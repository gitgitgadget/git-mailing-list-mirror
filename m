Return-Path: <SRS0=QBG1=2L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01398C2D0C3
	for <git@archiver.kernel.org>; Sat, 21 Dec 2019 22:54:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6DE4206C3
	for <git@archiver.kernel.org>; Sat, 21 Dec 2019 22:54:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VWUbA113"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726087AbfLUWx7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 Dec 2019 17:53:59 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46210 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726024AbfLUWx7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Dec 2019 17:53:59 -0500
Received: by mail-wr1-f66.google.com with SMTP id z7so12803166wrl.13
        for <git@vger.kernel.org>; Sat, 21 Dec 2019 14:53:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rrIJdlJICSgb1+46YAJX72m56QBsEuLCz3oR8pT9Ezk=;
        b=VWUbA113wykhmDHz9TnkZjS+4BqzECElcdJ++hjiLU4b3BZm+G3fD5gmjMPNnv+hZQ
         NGHjS7iMrEYsYZBPtqZvGGnCng2GGWrHPZQPGktDSxh2DzKwpwko6mph4Zs3WpYfFicu
         lZxKR7rIpsLoQmapY28dy6Sea04gTph0ojzj60benWf5/ge8+oFvu/JnKwFq6CN2nTTn
         ARpfPLSA6w+GOIm7Mw8iYFpx4WvGvEpexJ307FrAzRzxnGQPee3vYvWt3Ze+KJMQGwON
         KrhDhfUzevSxZXlYrPVt9hfWVNp9eBkvgZPEOdKRCGDA1TgrbQQrOIjRpPphs6CCsFqc
         /qMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rrIJdlJICSgb1+46YAJX72m56QBsEuLCz3oR8pT9Ezk=;
        b=bsXeCiC+8CKJ594BSRCN3sde049cS1QxtLGovsIg8oO5TrG7dIY6uTWmqJuual8ie2
         xy3ooEVg0Z03vqD/bI/d7sN4jaMKyEVs2B4UmTCdq4JK+qiWAjLluFYu7XgMXkMQpdI/
         1kIoLBqkKARBtsiblLjf43sCe+bHPUxsCCfi9JD7o5FtWezuAo0tEKyqoswiPm2To3/C
         k43yERvxSWiBAcKYHHAzzIUjEpNm9K9FtdiPXXVj9ta7NxweVJhQ2bpjs0S9pWvdo1fF
         HqEdzRB9oc2m9UawlP2le508J9wXpnGYD8obNm05NWykCUIBn65IxJJrZjQGt39KSn8W
         Hiew==
X-Gm-Message-State: APjAAAUafWGeqQ8KZHbLjs2wabkDqBQ4evpTt38nzkWKvaWKoDc3iaso
        FjPSGAP1+eKJjNyar4oQsJU=
X-Google-Smtp-Source: APXvYqxGeP1t+y7ZYjR23i1tb4y9yLvO31JdkY+D54NaSReRvN2qieqIIFDT2YWnB6GDD7B35tWfrg==
X-Received: by 2002:adf:f1c6:: with SMTP id z6mr23481638wro.279.1576968836962;
        Sat, 21 Dec 2019 14:53:56 -0800 (PST)
Received: from szeder.dev (x4dbe5d13.dyn.telefonica.de. [77.190.93.19])
        by smtp.gmail.com with ESMTPSA id c15sm14765280wrt.1.2019.12.21.14.53.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 21 Dec 2019 14:53:56 -0800 (PST)
Date:   Sat, 21 Dec 2019 23:53:54 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 9/9] ci: include the built-in `git add -i` in the
 `linux-gcc` job
Message-ID: <20191221225354.GB32750@szeder.dev>
References: <pull.175.git.1576968120.gitgitgadget@gmail.com>
 <9719604a1fb6ec4cf1b1297875cae86c076c9cdd.1576968120.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9719604a1fb6ec4cf1b1297875cae86c076c9cdd.1576968120.git.gitgitgadget@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Dec 21, 2019 at 10:42:00PM +0000, Johannes Schindelin via GitGitGadget wrote:
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> 
> This job runs the test suite twice, once in regular mode, and once with
> a whole slew of `GIT_TEST_*` variables set.
> 
> Now that the built-in version of `git add --interactive` is
> feature-complete, let's also throw `GIT_TEST_MULTI_PACK_INDEX` into that

GIT_TEST_MULTI_PACK_INDEX? ;)

> fray.
> 
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  ci/run-build-and-tests.sh | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/ci/run-build-and-tests.sh b/ci/run-build-and-tests.sh
> index ff0ef7f08e..4df54c4efe 100755
> --- a/ci/run-build-and-tests.sh
> +++ b/ci/run-build-and-tests.sh
> @@ -20,6 +20,7 @@ linux-gcc)
>  	export GIT_TEST_OE_DELTA_SIZE=5
>  	export GIT_TEST_COMMIT_GRAPH=1
>  	export GIT_TEST_MULTI_PACK_INDEX=1
> +	export GIT_TEST_ADD_I_USE_BUILTIN=1
>  	make test
>  	;;
>  linux-gcc-4.8)
> -- 
> gitgitgadget
