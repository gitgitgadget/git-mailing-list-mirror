Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E22CC4338F
	for <git@archiver.kernel.org>; Mon,  9 Aug 2021 19:40:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 70B1461004
	for <git@archiver.kernel.org>; Mon,  9 Aug 2021 19:40:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235276AbhHITlQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Aug 2021 15:41:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235350AbhHITlN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Aug 2021 15:41:13 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39588C061798
        for <git@vger.kernel.org>; Mon,  9 Aug 2021 12:40:52 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id lw7-20020a17090b1807b029017881cc80b7so570392pjb.3
        for <git@vger.kernel.org>; Mon, 09 Aug 2021 12:40:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=IhNxz/RfLjTJ292Cu4+4H5xbRvCfX4HkCpFKRT6t7VI=;
        b=K2sOGpp0fjORRLRiMbppSxM+LrZRMsJbx/FkPKVqPc8H4yWl9hiBKX9+CmJfvsK0nz
         EWwDbH6RHdWU4nkmZ22j5+BJZTOxWgivJqwESv8uKRijdw9R5CExVR/4ILyhebfAfJ7h
         Wn3l0eBD9dxD83kG37k4AErf8HGrcsS0IQZ0Hk9GOI7OSJcvrz3uCDLTNTaC7rqSJT0Y
         wuTALip6RImD1+KdTHa8v5uc/HYm4eV7QRH5mCPevbN9tqLut1Fwvw67bhc398s2bbOP
         lQeIV92WS6m0QCJZiwoCBvrcNl/MDRNgA5VFSRLEyi4w1Sz873n+i29DUCbC62OEDRHU
         x4uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=IhNxz/RfLjTJ292Cu4+4H5xbRvCfX4HkCpFKRT6t7VI=;
        b=kAmpYYHf3mVSvu4XjpzIwQPQ9V8CVK1jIyb+1DdmI+y18IKwnL3sek/43Q7xHrkK7w
         Wk6ya9vCMRraaCOJeUYtmjqZ2htSZZevlvAKIoYpdIklhrdck1bbyVFhgKCE5l6kHrdE
         +J1v1ehCbLEN6YNHQfK2kHvDP6cDi8FcbjFF5BD35rYxEFd0vm4EpgdDJ4xCojpobAdw
         bfyqOM3XmWDmGi5gRkjS3kpzf/P0UeV0HnTQM73V10uvp3HCCVEcuaq1wMnOHbL2J9lU
         0YilaciyRCj44cBEv2UGgVpnFRGxqCMTJUwu+4my2brYS7x0SQsSLqmj1KERVxMT7hjj
         q73g==
X-Gm-Message-State: AOAM532K7L9kmo93MbVJ6lyi22DH8iqkJNaW7vQ10GzgMejAKl6Ffub8
        kY+1htP02qykETULSPwwQxw=
X-Google-Smtp-Source: ABdhPJyc1DtL9igYsS/nxXUJYoi1xIAWjEUSuTDzDXEkZHFOAngdr5J2O2Wv9WE1Amy0uu7OMH0Lpg==
X-Received: by 2002:a65:6812:: with SMTP id l18mr3680pgt.428.1628538051721;
        Mon, 09 Aug 2021 12:40:51 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:4d74:2fd5:acb7:59ca])
        by smtp.gmail.com with ESMTPSA id b26sm21194031pfo.47.2021.08.09.12.40.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Aug 2021 12:40:51 -0700 (PDT)
Date:   Mon, 9 Aug 2021 12:40:48 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Kim Altintop <kim@eagain.st>
Cc:     git@vger.kernel.org, gitster@pobox.com, jonathantanmy@google.com,
        bwilliams.eng@gmail.com
Subject: Re: [PATCH 1/3] t5730: introduce fetch command helper
Message-ID: <YRGEwFauT5QjMSNO@google.com>
References: <20210730135845.633234-1-kim@eagain.st>
 <20210731203415.618641-1-kim@eagain.st>
 <20210804203829.661565-1-kim@eagain.st>
 <20210804205951.668140-1-kim@eagain.st>
 <20210809175530.75326-1-kim@eagain.st>
 <20210809175530.75326-2-kim@eagain.st>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210809175530.75326-2-kim@eagain.st>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Kim Altintop wrote:

> Assembling a "raw" fetch command to be fed directly to "test-tool serve-v2"
> is extracted into a test helper.
>
> Suggested-by: Junio C Hamano <gitster@pobox.com>
> Signed-off-by: Kim Altintop <kim@eagain.st>
> ---
>  t/t5703-upload-pack-ref-in-want.sh | 107 ++++++++++++++++++++---------
>  1 file changed, 74 insertions(+), 33 deletions(-)

Thanks!  Interesting.

> diff --git a/t/t5703-upload-pack-ref-in-want.sh b/t/t5703-upload-pack-ref-in-want.sh
> index e9e471621d..cd4744b016 100755
> --- a/t/t5703-upload-pack-ref-in-want.sh
> +++ b/t/t5703-upload-pack-ref-in-want.sh
> @@ -40,6 +40,54 @@ write_command () {
>  	fi
>  }
> 
> +# Write a complete fetch command to stdout, suitable for use with `test-tool
> +# pkt-line`. "want-ref", "want", and "have" values can be given in this order,
> +# with sections separated by "--".
> +#
> +# Examples:
> +#
> +# write_fetch_command refs/heads/main
> +#
> +# write_fetch_command \
> +#	refs/heads/main \
> +#	-- \
> +#	-- \
> +#	$(git rev-parse x)
> +#
> +# write_fetch_command \
> +#	--
> +#	$(git rev-parse a) \
> +#	--
> +#	$(git rev-parse b)
> +write_fetch_command () {

Hm, for comparison let me see what this looks like without the helper:
after some prior step

	object_format=$(test_oid algo) &&	# probably just once in a setup step
	x=$(git rev-parse x) &&

we can write

	cat <<-EOF &&
		command=fetch
		object-format=$object_format
		0001
		no-progress
		want-ref refs/heads/main
		have $x
		done
		0000
	EOF

I find that a little _easier_ to read than a write_fetch_command call,
because I don't have to chase the definition and x is labeled as a
'have'.

Is there some additional motivation for this helper?

> +	write_command fetch &&
> +	echo "0001" &&
> +	echo "no-progress" || return
> +    while :

Whitespace seems off.  Junio covers this in his review so I'll ignore
other instances.

[...]
> @@ -97,15 +145,13 @@ test_expect_success 'basic want-ref' '
>  	EOF
>  	git rev-parse f >expected_commits &&
> 
> -	oid=$(git rev-parse a) &&
>  	test-tool pkt-line pack >in <<-EOF &&
> -	$(write_command fetch)
> -	0001
> -	no-progress
> -	want-ref refs/heads/main
> -	have $oid
> -	done
> -	0000
> +	$(write_fetch_command \
> +		refs/heads/main \
> +		-- \
> +		-- \
> +		$(git rev-parse a) \
> +	)
>  	EOF
> 
>  	test-tool serve-v2 --stateless-rpc >out <in &&
> @@ -121,16 +167,14 @@ test_expect_success 'multiple want-ref lines' '
>  	EOF
>  	git rev-parse c d >expected_commits &&
> 
> -	oid=$(git rev-parse b) &&
>  	test-tool pkt-line pack >in <<-EOF &&
> -	$(write_command fetch)
> -	0001
> -	no-progress
> -	want-ref refs/heads/o/foo
> -	want-ref refs/heads/o/bar
> -	have $oid
> -	done
> -	0000
> +	$(write_fetch_command \
> +		refs/heads/o/foo \
> +		refs/heads/o/bar \
> +		-- \
> +		-- \
> +		$(git rev-parse b) \
> +	)
>  	EOF

Here the entirety of the input to "test-tool pkt-line pack" is the
entirety of the output from write_fetch_command, which would suggest
either

 a. making write_fetch_command pipe its output to "test-tool pkt-line
    pack", or

 b. using a pipe instead of a command substitution, like
    "write_fetch_command ... | test-tool pkt-line pack >in"

(although as mentioned above, I think it's simpler to inline the
write_fetch_command and even the write_command as well).

Thanks and hope that helps,
Jonathan
