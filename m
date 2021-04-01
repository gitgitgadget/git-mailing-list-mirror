Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7DC0C4363F
	for <git@archiver.kernel.org>; Thu,  1 Apr 2021 00:33:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A45561073
	for <git@archiver.kernel.org>; Thu,  1 Apr 2021 00:33:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233139AbhDAAcf (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 31 Mar 2021 20:32:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233112AbhDAAcV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Mar 2021 20:32:21 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 858BEC061574
        for <git@vger.kernel.org>; Wed, 31 Mar 2021 17:32:21 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id y5so637657qkl.9
        for <git@vger.kernel.org>; Wed, 31 Mar 2021 17:32:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=zqGBJg2n23Z7bupYiDxwBh4ujRU14cNWj73+Y43noA0=;
        b=uJk/NBcBR1hNorvEV7Sq7NE0gF1tbK1o9V/PqaOVQWZOblbj3NsFFJSORbqsugG0qY
         6YWFrJ1mbevBcWqQIuEV17t0zPK3jG9UfWp8kqo/boOUDYObkppG9lMWcCN4Of/h5lSK
         4G9UzCMXT6LlFuTQhDYOaahlNLKjTDv5FNQMzlcgfie/tF66TivM5nOyhRIUuhifbej/
         iZyWuGhIBxCLZTnoe5jIvJA2sB9YXHXlTFsBFV2cBwFDNrEOcp32owjeV0nR/5AP4koA
         kmD/EZQXaBhW45iRqKfaRxE4fZh6vFsV4GEhv4AYxJUoKlmA5133gPoGqkeWpNRf2+Dv
         VFkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zqGBJg2n23Z7bupYiDxwBh4ujRU14cNWj73+Y43noA0=;
        b=D2iUNsAaEIsm2AOtbzshn7RDqbwSkEuF1wcCB7KDnKGpHyGJFuMenN7L4st3rbxnrg
         IqY2L4He4CDO19Uo0O9Ezxo7PcJwPa6LNDAkbMeQuSKjm/Tj3pPevp1j9PKW4Ikw/8yo
         NShLrCxyqLCtcG3J3MvbbJYJxY29xmWbqo9rHPESkCBqHHnDVYq/PP0cUvnLjNl16fZO
         Tq+ZIcFEY7vNn9QJ2VL0wEttRZ33cHuOYbGYB+XvgkGOLRNId1gPfm8Tv96QQz61Ynit
         bZ+weAOppQGaj33YRyeXlRovbGH1vON1EP7g+3zJksjgduD59YzH+FkCK76tCeNRAqQd
         khog==
X-Gm-Message-State: AOAM5313h2qk8XQJenspkP2oOlhY2HkUbtM+UIIJsnk7tbmQp4f+FYkG
        FS73SsYREAThyjf59bJoMBKaSV8eX1zS1Q==
X-Google-Smtp-Source: ABdhPJyK1Q2mX5MR8wZD9suSk7+Y32OXIZKmz10zN/51nv5beoxwmUZ9NzkERzIG1jb4rqd2uq5XwA==
X-Received: by 2002:a05:620a:2116:: with SMTP id l22mr5805370qkl.377.1617237140454;
        Wed, 31 Mar 2021 17:32:20 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:90ff:e0f0:a41:6c5a])
        by smtp.gmail.com with ESMTPSA id j6sm2772361qkl.84.2021.03.31.17.32.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Mar 2021 17:32:19 -0700 (PDT)
Date:   Wed, 31 Mar 2021 20:32:18 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, dstolee@microsoft.com,
        jonathantanmy@google.com
Subject: Re: [PATCH v4 08/16] midx: allow marking a pack as preferred
Message-ID: <YGUUkoaFOdfs7nRs@nand.local>
References: <cover.1612998106.git.me@ttaylorr.com>
 <cover.1617116623.git.me@ttaylorr.com>
 <d061828e7e52eb97c72dbc0853b02180feea0d8b.1617116623.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d061828e7e52eb97c72dbc0853b02180feea0d8b.1617116623.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio,

On Tue, Mar 30, 2021 at 11:04:11AM -0400, Taylor Blau wrote:

I accidentally left a stray debugging line in here, and managed to skip
over it when reading the range-diff. It's right...

> diff --git a/t/t5319-multi-pack-index.sh b/t/t5319-multi-pack-index.sh
> index b4afab1dfc..031a5570c0 100755
> --- a/t/t5319-multi-pack-index.sh
> +++ b/t/t5319-multi-pack-index.sh
> @@ -234,6 +234,49 @@ test_expect_success 'warn on improper hash version' '
>  	)
>  '
>
> +test_expect_success 'midx picks objects from preferred pack' '
> +	test_when_finished rm -rf preferred.git &&
> +	git init --bare preferred.git &&
> +	(
> +		cd preferred.git &&
> +
> +		a=$(echo "a" | git hash-object -w --stdin) &&
> +		b=$(echo "b" | git hash-object -w --stdin) &&
> +		c=$(echo "c" | git hash-object -w --stdin) &&
> +
> +		# Set up two packs, duplicating the object "B" at different
> +		# offsets.
> +		#
> +		# Note that the "BC" pack (the one we choose as preferred) sorts
> +		# lexically after the "AB" pack, meaning that omitting the
> +		# --preferred-pack argument would cause this test to fail (since
> +		# the MIDX code would select the copy of "b" in the "AB" pack).
> +		git pack-objects objects/pack/test-AB <<-EOF &&
> +		$a
> +		$b
> +		EOF
> +		bc=$(git pack-objects objects/pack/test-BC <<-EOF
> +		$b
> +		$c
> +		EOF
> +		) &&
> +
> +		git multi-pack-index --object-dir=objects \
> +			write --preferred-pack=test-BC-$bc.idx 2>err &&
> +		test_must_be_empty err &&
> +
> +		echo hi &&

...here. Would you mind fixing it up locally before applying this to
next?

Sorry for the trouble.

Thanks,
Taylor
