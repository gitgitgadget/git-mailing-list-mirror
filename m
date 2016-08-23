Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4F5EE1FD99
	for <e@80x24.org>; Tue, 23 Aug 2016 22:34:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932939AbcHWWeW (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Aug 2016 18:34:22 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53796 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753562AbcHWWeV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Aug 2016 18:34:21 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id BE0243732D;
        Tue, 23 Aug 2016 18:34:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=rfyDubC+dzNXVSNdZrcOlDoI2ZI=; b=THYc84
        pNMnNgA53pEFLCfzdNyClfMXKm63K6SMuXHkb07Y2VVXgYh+pR/a+C0225tEvaD2
        owj6HfFzEYX7vLtBEwN2MQfBtpkfhcewXbxPTfd5pNlovbKzTYZrKDWHnoGUk2Q+
        Hiklr7vIbkPpi0CY7kFuU5HN3hySFm3tziEb8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=QJfcUKFPm/7fa9Dhded1Cw9l8Ag1FIGT
        SGwI4edmliVBkXXQhK2rpLBNuNpmK9xkmniEOQRrKyyF2Kk7qZhshf2vXpuNvig7
        79f6H5qwkN0YvbsIdw8VQPBOkNMmMmGcNde9g3ZF+rSNKmd0syb6HM57pHvKf/wf
        4GMNwIwf5RY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B500A3732C;
        Tue, 23 Aug 2016 18:34:19 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 403853732B;
        Tue, 23 Aug 2016 18:34:19 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jacob Keller <jacob.e.keller@intel.com>
Cc:     git@vger.kernel.org, Josh Triplett <josh@joshtriplett.org>,
        James Hogan <james.hogan@imgtec.com>,
        Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH v2] format-patch: show 0/1 and 1/1 for singleton patch with cover letter
References: <20160823214620.28624-1-jacob.e.keller@intel.com>
Date:   Tue, 23 Aug 2016 15:34:17 -0700
In-Reply-To: <20160823214620.28624-1-jacob.e.keller@intel.com> (Jacob Keller's
        message of "Tue, 23 Aug 2016 14:46:20 -0700")
Message-ID: <xmqqk2f7t8ra.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BB239946-6981-11E6-8B1D-FCB17B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jacob Keller <jacob.e.keller@intel.com> writes:

> diff --git a/builtin/log.c b/builtin/log.c
> index 92dc34dcb0cc..49aa534f4a01 100644
> --- a/builtin/log.c
> +++ b/builtin/log.c
> @@ -1676,16 +1676,16 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
>  		/* nothing to do */
>  		return 0;
>  	total = nr;
> -	if (!keep_subject && auto_number && total > 1)
> -		numbered = 1;
> -	if (numbered)
> -		rev.total = total + start_number - 1;
>  	if (cover_letter == -1) {
>  		if (config_cover_letter == COVER_AUTO)
>  			cover_letter = (total > 1);
>  		else
>  			cover_letter = (config_cover_letter == COVER_ON);
>  	}
> +	if (!keep_subject && auto_number && (total > 1 || cover_letter))
> +		numbered = 1;
> +	if (numbered)
> +		rev.total = total + start_number - 1;
>  
>  	if (!signature) {
>  		; /* --no-signature inhibits all signatures */

That sounds sensible.

> diff --git a/t/t4021-format-patch-numbered.sh b/t/t4021-format-patch-numbered.sh
> index 886494b58f67..ea0a388f0191 100755
> --- a/t/t4021-format-patch-numbered.sh
> +++ b/t/t4021-format-patch-numbered.sh
> @@ -36,6 +36,11 @@ test_no_numbered() {
>  	test_num_no_numbered $1 2
>  }
>  
> +test_single_cover_letter_numbered() {
> +	grep "^Subject: \[PATCH 0/1\]" $1 &&
> +	grep "^Subject: \[PATCH 1/1\]" $1
> +}
> +
>  test_single_numbered() {
>  	grep "^Subject: \[PATCH 1/1\]" $1
>  }
> @@ -50,6 +55,11 @@ test_expect_success 'single patch defaults to no numbers' '
>  	test_single_no_numbered patch0.single
>  '
>  
> +test_expect_success 'single patch with cover-letter defaults to numbers' '
> +	git format-patch --cover-letter --stdout HEAD~1 >patch0.single &&
> +	test_single_cover_letter_numbered patch0.single
> +'

The remaining and existing tests seems to expect that the result of
each test is stored in a distinct file so that the output can be
inspected after seeing a test failure without running the script
with the "-i" option.  Perhaps rename this to patch0.single-cover or
something?  The same for the overwriting of patch1 we can see below.

>  test_expect_success 'multiple patch defaults to numbered' '
>  
>  	git format-patch --stdout HEAD~2 >patch0.multiple &&
> @@ -64,6 +74,11 @@ test_expect_success 'Use --numbered' '
>  
>  '
>  
> +test_expect_success 'Use --no-numbered and --cover-letter single patch' '
> +	git format-patch --no-numbered --stdout --cover-letter HEAD~1 >patch1 &&
> +	test_no_numbered patch1
> +'
> +
>  test_expect_success 'format.numbered = true' '
>  
>  	git config format.numbered true &&
