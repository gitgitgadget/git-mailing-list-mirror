Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C96582047F
	for <e@80x24.org>; Wed, 26 Jul 2017 20:32:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751458AbdGZUcf (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Jul 2017 16:32:35 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57584 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751009AbdGZUcf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Jul 2017 16:32:35 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 546F1951CF;
        Wed, 26 Jul 2017 16:32:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=y6BopDA2O1q8fVCgRNzEI9gjNQ0=; b=bQvffS
        qUutMpAeOJPeyYJ3UqEya5c3KFhEoaDyY8LhK8cgJZ/rWIQHl6ZyG3qsmgzokG07
        Hgl2pgvu48FgmjKxkMXtx072W7MLwZHvJLtbNU5bZd85A+9cBsGTqYy2ao1wMyiQ
        CvMzzxdf9Cg0FWMipffpPcGtZmmzt/EWPz64s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=G/68R0nKjOEHahu4DRCndhyixBB3y32b
        HB9O3rdXejDk5zOkHe4v4bxfmTANQcsYLTeMrMy0wknJWvf7tZuJBQQSfGQblZBI
        X7kssbg3z1uuSbbPv5Kcz0CwbMTU3JAitwb+/8vJcgoLFi0VyOEfUnbW027LmTk8
        IM90QZDu+Kw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4B6D3951CE;
        Wed, 26 Jul 2017 16:32:32 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9F66E951CD;
        Wed, 26 Jul 2017 16:32:31 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCHv2] t8008: rely on rev-parse'd HEAD instead of sha1 value
References: <xmqqk235o7rm.fsf@gitster.mtv.corp.google.com>
        <20170726190631.560-1-sbeller@google.com>
Date:   Wed, 26 Jul 2017 13:32:30 -0700
In-Reply-To: <20170726190631.560-1-sbeller@google.com> (Stefan Beller's
        message of "Wed, 26 Jul 2017 12:06:31 -0700")
Message-ID: <xmqqd18nq6qp.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8CACC17C-7241-11E7-8C16-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> Remove hard coded sha1 values, obtain the values using
> 'git rev-parse HEAD' which should be future proof regardless
> of the hash function used.
>
> Additionally future-proof the test by hard coding the
> abbreviation length of the hash.
>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>
>> Don't hardcoded lengths of the hashes defeat this future-proofing
>> effort, though?  It shouldn't be too hard to do the equivalent of
>> the auto computation of abbreviation in this script, which would be
>> true future-proofing, I guess.
>
> Added --abbrev=n to also hard code hash abbreviation. At first
> I had the impression of a off-by-one-error, but after reading the
> man page for both blame and rev-parse, I realize that blames
> abbrev notion is different than rev-parse precisely for the
> caret that may occur to indicate out-of-range.

OK, and 17 hexdigits ought to be sufficient for a sample repository
we create for the test---we shouldn't be picking a hash that would
cause hash prefix collisions with such a small number of objects and
reasonably long prefix anyway ;-)

Thanks, will queue.

>
>  t/t8008-blame-formats.sh | 30 ++++++++++++++++--------------
>  1 file changed, 16 insertions(+), 14 deletions(-)
>
> diff --git a/t/t8008-blame-formats.sh b/t/t8008-blame-formats.sh
> index 92c8e792d1..ae4b579d24 100755
> --- a/t/t8008-blame-formats.sh
> +++ b/t/t8008-blame-formats.sh
> @@ -12,22 +12,25 @@ test_expect_success 'setup' '
>  	echo c >>file &&
>  	echo d >>file &&
>  	test_tick &&
> -	git commit -a -m two
> +	git commit -a -m two &&
> +	ID1=$(git rev-parse HEAD^) &&
> +	shortID1="^$(git rev-parse HEAD^ |cut -c 1-17)" &&
> +	ID2=$(git rev-parse HEAD) &&
> +	shortID2="$(git rev-parse HEAD |cut -c 1-18)"
>  '
>  
> -cat >expect <<'EOF'
> -^baf5e0b (A U Thor 2005-04-07 15:13:13 -0700 1) a
> -8825379d (A U Thor 2005-04-07 15:14:13 -0700 2) b
> -8825379d (A U Thor 2005-04-07 15:14:13 -0700 3) c
> -8825379d (A U Thor 2005-04-07 15:14:13 -0700 4) d
> +cat >expect <<EOF
> +$shortID1 (A U Thor 2005-04-07 15:13:13 -0700 1) a
> +$shortID2 (A U Thor 2005-04-07 15:14:13 -0700 2) b
> +$shortID2 (A U Thor 2005-04-07 15:14:13 -0700 3) c
> +$shortID2 (A U Thor 2005-04-07 15:14:13 -0700 4) d
>  EOF
>  test_expect_success 'normal blame output' '
> -	git blame file >actual &&
> +	git blame --abbrev=17 file >actual &&
>  	test_cmp expect actual
>  '
>  
> -ID1=baf5e0b3869e0b2b2beb395a3720c7b51eac94fc
> -COMMIT1='author A U Thor
> +COMMIT1="author A U Thor
>  author-mail <author@example.com>
>  author-time 1112911993
>  author-tz -0700
> @@ -37,9 +40,8 @@ committer-time 1112911993
>  committer-tz -0700
>  summary one
>  boundary
> -filename file'
> -ID2=8825379dfb8a1267b58e8e5bcf69eec838f685ec
> -COMMIT2='author A U Thor
> +filename file"
> +COMMIT2="author A U Thor
>  author-mail <author@example.com>
>  author-time 1112912053
>  author-tz -0700
> @@ -48,8 +50,8 @@ committer-mail <committer@example.com>
>  committer-time 1112912053
>  committer-tz -0700
>  summary two
> -previous baf5e0b3869e0b2b2beb395a3720c7b51eac94fc file
> -filename file'
> +previous $ID1 file
> +filename file"
>  
>  cat >expect <<EOF
>  $ID1 1 1 1
