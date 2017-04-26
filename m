Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AE90A207E4
	for <e@80x24.org>; Wed, 26 Apr 2017 04:34:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1953708AbdDZEeq (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Apr 2017 00:34:46 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:35038 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1947415AbdDZEeo (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Apr 2017 00:34:44 -0400
Received: by mail-pf0-f194.google.com with SMTP id a188so13907568pfa.2
        for <git@vger.kernel.org>; Tue, 25 Apr 2017 21:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=W3nqDF1kLb+X+4Yfi1Yg/XSyocWeFgyiaphBTQfjLPw=;
        b=bP8IkCltGyo0SXIFl3fjsSjV+VsRW4KjDCuc2pviIQXn2G7Yz+vzSMyG0SC9EOE49A
         sKHXsoDTPmfZZj3Mpre+CYf6gzQAg6xkNnzB3DLiYtaPZmGdlSA1SZO7XAw0tijcgz1f
         Nk7G3kL9TrMMgW59pV21QkUU8+IoCx2HA2jfm+v0PjfW6A8m22bWCJTgT6QiOb5NqpnA
         GsSCEoRVLq2vkoqnEM/IEYLiwzd5Bo4JFboDyOnmaNbwT2wpItwf1BRCE6KdD4rzWAiW
         3g73AGSf9giVIvlucv+1JSiVydJZmlGuf9TZkcQDAfEkg882q8uNGZ2DjXevCj5/Odhs
         b88Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=W3nqDF1kLb+X+4Yfi1Yg/XSyocWeFgyiaphBTQfjLPw=;
        b=ROkhzKM7+k2bSVscCWhULI/I2eyQ4O4dcRJzh7AYCVD5dV0Ra/yEGt3noek6ZHPT5t
         PPqGvOdVuenhCj5V+GykNs8UNsztqVDGA99J/u4xznuyFtr04zJBsndVGYbRvnvFnAu+
         wtbQc0gkJ67TmPptRkjI6yoLJW+J0bwy42JAZ02MSz2ngQj0tTJgnp9GTvDUtc0x6r1f
         7jDxapIaemFbjSqNooN76Z6N/1m70uL14FjgKhR1DXxtjj8Ij1vOzL52exKbbgY2oiY2
         LtiEYlXG/V/1gvAq6D6LZe3axcu+NNs84BC6QInJmtyWn2UEBVURug3S75m/nz7ewYxm
         L28g==
X-Gm-Message-State: AN3rC/7FW0e6Nb/t3e+SFWgdbCN4ew1jZfZS98iVeOhesTthV6csETip
        t5rwVj8Kr3ZV6g==
X-Received: by 10.84.239.8 with SMTP id w8mr40791818plk.73.1493181284160;
        Tue, 25 Apr 2017 21:34:44 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:3179:d004:20b:b383])
        by smtp.gmail.com with ESMTPSA id j4sm39076116pfk.91.2017.04.25.21.34.41
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 25 Apr 2017 21:34:41 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@jeffhostetler.com
Cc:     git@vger.kernel.org, peff@peff.net, j6t@kdbg.org,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v8] read-cache: call verify_hdr() in a background thread
References: <20170425184109.46168-1-git@jeffhostetler.com>
        <xmqqd1bzst95.fsf@gitster.mtv.corp.google.com>
Date:   Tue, 25 Apr 2017 21:34:41 -0700
In-Reply-To: <xmqqd1bzst95.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Tue, 25 Apr 2017 21:11:18 -0700")
Message-ID: <xmqq8tmnss66.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> git@jeffhostetler.com writes:
>
>> From: Jeff Hostetler <jeffhost@microsoft.com>
>>
>> Version 8 of this patch converts the unit test to use
>> perl to corrupt the index checksum (rather than altering
>> a filename) and also verifies the fsck error message as
>> suggested in response to v7 on the mailing list.
>>
>> If there are no other suggestions, I think this version
>> should be considered final.
>
> Oops.  The earlier one has already been in 'master' for a few days.
> Let's make this an incremental update.  
>
> Is the description in the following something you are OK with (so
> that I can add your sign-off)?
>
> Thanks.

By the way, I said I am fine with the two-liner version in Dscho's
message, but I am also OK with this version that does not use a
separate dd and instead does everything in a single invocation of
Perl.  As long as you've tested this version, there is no point
replacing it with yet another one.

Thanks.

> -- >8 --
> From: Jeff Hostetler <jeffhost@microsoft.com>
> Date: Tue, 25 Apr 2017 18:41:09 +0000
> Subject: t1450: avoid use of "sed" on the index, which is a binary file
>
> The previous step added a path zzzzzzzz to the index, and then used
> "sed" to replace this string to yyyyyyyy to create a test case where
> the checksum at the end of the file does not match the contents.
>
> Unfortunately, use of "sed" on a non-text file is not portable.
> Instead, use a Perl script that seeks to the end and modifies the
> last byte of the file (where we _know_ stores the trailing
> checksum).
>
>
> ---
>  t/t1450-fsck.sh | 33 ++++++++++++++++++++++++++-------
>  1 file changed, 26 insertions(+), 7 deletions(-)
>
> diff --git a/t/t1450-fsck.sh b/t/t1450-fsck.sh
> index 677e15a7a4..eff1cd68e9 100755
> --- a/t/t1450-fsck.sh
> +++ b/t/t1450-fsck.sh
> @@ -689,16 +689,35 @@ test_expect_success 'bogus head does not fallback to all heads' '
>  	! grep $blob out
>  '
>  
> +# Corrupt the checksum on the index.
> +# Add 1 to the last byte in the SHA.
> +corrupt_index_checksum () {
> +    perl -w -e '
> +	use Fcntl ":seek";
> +	open my $fh, "+<", ".git/index" or die "open: $!";
> +	binmode $fh;
> +	seek $fh, -1, SEEK_END or die "seek: $!";
> +	read $fh, my $in_byte, 1 or die "read: $!";
> +
> +	$in_value = unpack("C", $in_byte);
> +	$out_value = ($in_value + 1) & 255;
> +
> +	$out_byte = pack("C", $out_value);
> +
> +	seek $fh, -1, SEEK_END or die "seek: $!";
> +	print $fh $out_byte;
> +	close $fh or die "close: $!";
> +    '
> +}
> +
> +# Corrupt the checksum on the index and then
> +# verify that only fsck notices.
>  test_expect_success 'detect corrupt index file in fsck' '
>  	cp .git/index .git/index.backup &&
>  	test_when_finished "mv .git/index.backup .git/index" &&
> -	echo zzzzzzzz >zzzzzzzz &&
> -	git add zzzzzzzz &&
> -	sed -e "s/zzzzzzzz/yyyyyyyy/" .git/index >.git/index.yyy &&
> -	mv .git/index.yyy .git/index &&
> -	# Confirm that fsck detects invalid checksum
> -	test_must_fail git fsck --cache &&
> -	# Confirm that status no longer complains about invalid checksum
> +	corrupt_index_checksum &&
> +	test_must_fail git fsck --cache 2>expect &&
> +	grep "bad index file" expect &&
>  	git status
>  '
>  
