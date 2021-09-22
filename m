Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79140C433F5
	for <git@archiver.kernel.org>; Wed, 22 Sep 2021 02:32:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E243610E8
	for <git@archiver.kernel.org>; Wed, 22 Sep 2021 02:32:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229649AbhIVCeQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Sep 2021 22:34:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229466AbhIVCeQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Sep 2021 22:34:16 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6623C061574
        for <git@vger.kernel.org>; Tue, 21 Sep 2021 19:32:46 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id w8so1089349pgf.5
        for <git@vger.kernel.org>; Tue, 21 Sep 2021 19:32:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=d3+nzDjHoLb/MJaj5rlUHk8gIpvoCXzvZHXriXDZvDI=;
        b=TTpWikL3ec5MaWbjeyxJ+WnrR00FzRFxeXgttnS7OFsDnbONbttiA/kxMZtfoTnRsd
         PGNI78Z/qU1EKP/tEHFXBewJTzO7OvpOwFfD/RlKT/9o016Wfn37fgD8DYt659i5+bXo
         nwl4fVVmO5A/rAr32Sy/Gg3dm6JJxl54ibpCJ0s0kG3czQfcbDg+nvJX8Q+TQ9/e2qmf
         SF759DD3arVbYB1sJpYGrYr4ShZQzSNSsGZv1lTZbgD75VNWgaIQhLhR7to8n2SCkFZ1
         9/4wcADJON4vurFSBfdq5AfB2w8VrRR8/plKuLwm2Cn0ZvEGtWt/TOf4Am3QbO7joHTV
         4IfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=d3+nzDjHoLb/MJaj5rlUHk8gIpvoCXzvZHXriXDZvDI=;
        b=jX1UTNk0+4NyJJvi5O88YIIQtZRr+zmY6PyXZSXvTz+a5xkUChvhg5jbVbs86Fn8KO
         F5W09GxRP2pnxhVUFO7tGBg7CebmjrItopdIrXYhHG5rsU9dyeNIfOJdnf49SR1C+zKK
         gTBJtbijBzov3SjGKEj9dZmKsBcH/w3nMxlUiAM71PqnGKBeUTZ1fJaubbmQTGYSM9vA
         NS4Zs8pffspPu8OF0J0HcOm0rAt7KK0hMq9opDF8jqqRVuYQLlR4ymocDX9i73SYTfDp
         XFtV/mNRgIf6PyMkcs7L7nDM1kYZ8ALG2RqB/ivyn+bVetXEBdLdWJ76oTs46VqSSPgb
         roeA==
X-Gm-Message-State: AOAM531FSC771u7+cah6qG7PR2tC2dbEHZBlsObvrXdkNQJPpHcffyfh
        5xay4KaSjsYM9YkdyEVRdts=
X-Google-Smtp-Source: ABdhPJzlgtFnk0x6ri1y7oDegsdia+bp1Cqd3PHp5grxfE9HUk4RUxFIFrdJKntBte4mFNJhShgT7A==
X-Received: by 2002:a63:f963:: with SMTP id q35mr30789864pgk.132.1632277966202;
        Tue, 21 Sep 2021 19:32:46 -0700 (PDT)
Received: from [192.168.43.80] (subs28-116-206-12-34.three.co.id. [116.206.12.34])
        by smtp.gmail.com with ESMTPSA id n66sm418514pfd.21.2021.09.21.19.32.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Sep 2021 19:32:45 -0700 (PDT)
Subject: Re: [PATCH] http: match headers case-insensitively when redacting
To:     Jeff King <peff@peff.net>, git@vger.kernel.org
Cc:     Daniel Stenberg <daniel@haxx.se>
References: <YUonS1uoZlZEt+Yd@coredump.intra.peff.net>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Message-ID: <afd7bd6b-52bf-7fd8-d13e-6dcd660c4100@gmail.com>
Date:   Wed, 22 Sep 2021 09:32:41 +0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YUonS1uoZlZEt+Yd@coredump.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 22/09/21 01.41, Jeff King wrote:
> But when HTTP/2 is in use, instead we get a lower-case "authorization:"
> header, and we fail to match it. The fix is simple: we should match with
> skip_iprefix().
> 
> Testing is more complicated, though. We do have a test for the redacting
> feature, but we don't hit the problem case because our test Apache setup
> does not understand HTTP/2. You can reproduce the issue by applying this
> on top of the test change in this patch:
> 
> 	diff --git a/t/lib-httpd/apache.conf b/t/lib-httpd/apache.conf
> 	index afa91e38b0..19267c7107 100644
> 	--- a/t/lib-httpd/apache.conf
> 	+++ b/t/lib-httpd/apache.conf
> 	@@ -29,6 +29,9 @@ ErrorLog error.log
> 	 	LoadModule setenvif_module modules/mod_setenvif.so
> 	 </IfModule>
> 
> 	+LoadModule http2_module modules/mod_http2.so
> 	+Protocols h2c
> 	+
> 	 <IfVersion < 2.4>
> 	 LockFile accept.lock
> 	 </IfVersion>
> 	@@ -64,8 +67,8 @@ LockFile accept.lock
> 	 <IfModule !mod_access_compat.c>
> 	 	LoadModule access_compat_module modules/mod_access_compat.so
> 	 </IfModule>
> 	-<IfModule !mod_mpm_prefork.c>
> 	-	LoadModule mpm_prefork_module modules/mod_mpm_prefork.so
> 	+<IfModule !mod_mpm_event.c>
> 	+	LoadModule mpm_event_module modules/mod_mpm_event.so
> 	 </IfModule>
> 	 <IfModule !mod_unixd.c>
> 	 	LoadModule unixd_module modules/mod_unixd.so
> 	diff --git a/t/t5551-http-fetch-smart.sh b/t/t5551-http-fetch-smart.sh
> 	index 1c2a444ae7..ff74f0ae8a 100755
> 	--- a/t/t5551-http-fetch-smart.sh
> 	+++ b/t/t5551-http-fetch-smart.sh
> 	@@ -24,6 +24,10 @@ test_expect_success 'create http-accessible bare repository' '
> 	 	git push public main:main
> 	 '
> 
> 	+test_expect_success 'prefer http/2' '
> 	+	git config --global http.version HTTP/2
> 	+'
> 	+
> 	 setup_askpass_helper
> 
> 	 test_expect_success 'clone http repository' '
> 
> but this has a few issues:
> 
>    - it's not necessarily portable. The http2 apache module might not be
>      available on all systems. Further, the http2 module isn't compatible
>      with the prefork mpm, so we have to switch to something else. But we
>      don't necessarily know what's available. It would be nice if we
>      could have conditional config, but IfModule only tells us if a
>      module is already loaded, not whether it is available at all.
> 
>      This might be a non-issue. The http tests are already optional, and
>      modern-enough systems may just have both of these. But...
> 
>    - if we do this, then we'd no longer be testing HTTP/1.1 at all. I'm
>      not sure how much that matters since it's all handled by curl under
>      the hood, but I'd worry that some detail leaks through. We'd
>      probably want two scripts running similar tests, one with HTTP/2 and
>      one with HTTP/1.1.

Maybe for httpd config we can say that if mpm_prefork isn't loaded, load 
mpm_event and mod_http2.

And for testing both HTTP/2 and HTTP/1.1 did you mean sharing the same 
test code (with adjustments for each protocol)?

-- 
An old man doll... just what I always wanted! - Clara
