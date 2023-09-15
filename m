Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC398EEAA7D
	for <git@archiver.kernel.org>; Fri, 15 Sep 2023 00:28:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230488AbjIOA2Y (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Sep 2023 20:28:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230480AbjIOA2Y (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Sep 2023 20:28:24 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3D6426AB
        for <git@vger.kernel.org>; Thu, 14 Sep 2023 17:28:19 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-403012f276dso17150055e9.0
        for <git@vger.kernel.org>; Thu, 14 Sep 2023 17:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694737698; x=1695342498; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cg+0dSl1bvkslu92CKw670Dg5vzONZst99nCVlUtgAw=;
        b=FF5uZikztfB5zQ0FAJfDyEgZlx5ASPst0xMXBmukZGl32AZZRFCTN4QZK6yMipgjLI
         UvUGFV5S/BeCUr0gxdByxjRc3l6JPKEhll2ChCNjusbs/1C5h3GboU/xrL7DhJ0nPBGl
         6V+fduqj9SneEYNq8M2t0i8kvWhDMHKk1ltZ8Olc1BNAHywNISx5lWzSb9sTd87/vJqA
         uS6b99Bkne/zQlBH2eWlcL581J54jp86U/k2Ladu4mv32N6ucsODiwzyAP+mEFBaVHPa
         s+3ObFrlZdMGyLfZeqVpsiupszRjT/8P8G/VqmP7UoPNyrGe5DvguO4WXLacC//K0VaY
         9wTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694737698; x=1695342498;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Cg+0dSl1bvkslu92CKw670Dg5vzONZst99nCVlUtgAw=;
        b=S8i57H+ECHNoIDX8USX6nbVz6IUDDF3n4sBn/6suAh3M9zMDK4y7BsI77rj1s/rWLN
         Yhlnctnc2VbkPhIUfXA5tvZtxBwyJoA2/cYh3/NmbhCoERshh5GcL6pyFvXPX9io2eId
         uQmx9njJWZ6RxsQTNg5hGtKeeMX0/dYZEuXz+59WKpRSREGrULoUPvl8OSEPr1+Ot69+
         9xL9ODI7M8PAM0mLXF22EW0UVohfyYqp+SnN85xINxgGGiu7kaSnZs0Q1H6uMQ3h4qhG
         iOCi3mq4rh22d6lTQSIzIPEBBXkclwNmrkFLxosZ2ugWbgCDMZ+H3ht5bPfPiJaFD2Zm
         OvsA==
X-Gm-Message-State: AOJu0Ywh38aWs4c0VezoDXE/ytsNkHhi5uCIFbxs34RNIxSa2uda9J1G
        uEtL6epi6WRyta7tLVvDvo0=
X-Google-Smtp-Source: AGHT+IFklrzrqBJK3czHProMdhiX4B7hhpdz4fYOzrAYxCjX9gOc/UIUBvZ7UJ6yDnYc4nQtZJgUdQ==
X-Received: by 2002:a05:600c:152:b0:402:95a0:b2ae with SMTP id w18-20020a05600c015200b0040295a0b2aemr226993wmm.32.1694737698136;
        Thu, 14 Sep 2023 17:28:18 -0700 (PDT)
Received: from [192.168.2.52] (203.red-88-14-40.dynamicip.rima-tde.net. [88.14.40.203])
        by smtp.gmail.com with ESMTPSA id m13-20020a7bca4d000000b003fe4548188bsm6103346wml.48.2023.09.14.17.28.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Sep 2023 17:28:17 -0700 (PDT)
Subject: Re: [PATCH 2/2] test-lib: fix GIT_TEST_SANITIZE_LEAK_LOG
To:     Jeff King <peff@peff.net>
Cc:     Git List <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFy?= =?UTF-8?Q?mason?= 
        <avarab@gmail.com>
References: <68522960-edda-26d3-ddca-cee63f2d859e@gmail.com>
 <64825651-00d2-d2c5-2da2-91a9917bef21@gmail.com>
 <20230912082742.GB1630538@coredump.intra.peff.net>
From:   =?UTF-8?Q?Rub=c3=a9n_Justo?= <rjusto@gmail.com>
Message-ID: <2890b210-c42f-41cf-e676-0b1c56310f73@gmail.com>
Date:   Fri, 15 Sep 2023 02:28:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20230912082742.GB1630538@coredump.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12-sep-2023 04:27:42, Jeff King wrote:
> On Sun, Sep 10, 2023 at 01:09:52AM +0200, Rubén Justo wrote:
> 
> > GIT_TEST_SANITIZE_LEAK_LOG=true with a test that leaks, will make the
> > test return zero unintentionally:
> > 
> >   $ git checkout v2.40.1
> >   $ make SANITIZE=leak
> >   $ make -C t GIT_TEST_SANITIZE_LEAK_LOG=true t3200-branch.sh
> >   ...
> >   With GIT_TEST_SANITIZE_LEAK_LOG=true our logs revealed a memory leak, exit non-zero!
> >   # faked up failures as TODO & now exiting with 0 due to --invert-exit-code
> > 
> > Let's use invert_exit_code only if needed.
> 
> Hmm, OK. So we saw some actual test errors (maybe from leaks or maybe
> not), but then we _also_ saw entries in the leak-log. So the inversion
> cancels out, and we accidentally say everything is OK, which is wrong.
> 
> I'm not quite sure of your fix, though. In the if-else chain you're
> touching, we know going in that we found a leak in the log. And then we
> cover these 5 cases:
> 
>   1. if the test is marked as passing-leak
>     a. if we saw no test failures, invert (and mention the leaking log)
>     b. otherwise, do not invert (and mention the log)
>   2. else if we are in "check" mode
>     a. if we saw no test failures, do not invert (we do have a leak,
>        which is equivalent to a test failure). Mention the log.
>     b. otherwise, invert (to switch back to "success", since we are
>        looking for leaks), but still mention the log.
>   3. invert to trigger failure (and mention the log)
> 
> And the problem is in (3). You switch it to trigger only if we have no
> failures (fixing the inversion). But should we have the same a/b split
> for this case? I.e.:
> 
>   3a. if we saw no test failures, invert to cause a failure
>   3b. we saw other failures; do not invert, but _do_ mention that the
>       log found extra leaks
> 
> In 3b we are explaining to the user what happened. Though maybe it is
> not super important, because I think we'd have dumped the log contents
> anyway?

I think so too.  At that point we've already dumped the contents of the
$TEST_RESULTS_SAN_FILE file.

IMO, when $test_failure is zero (the "if" I'm touching), the message
makes sense not so much to say that a leak has been found, but rather
because we're forcing the non-zero exit.

But when $test_failure is not zero, after we've already dumped the
log, maybe this is somewhat redundant:

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 87cfea9e9a..b160ae3f7a 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -1267,6 +1267,8 @@ check_test_results_san_file_ () {
        then
                say "With GIT_TEST_SANITIZE_LEAK_LOG=true our logs revealed a memory leak, exit non-zero!" &&
                invert_exit_code=t
+       else
+               say "With GIT_TEST_SANITIZE_LEAK_LOG=true our logs revealed a memory leak"
        fi
 }

However, if you or anyone else thinks it adds value, I have no objection
to re-roll with it.

> Other than that, I think the patch is correct. I wondered when we ran
> this "check_test_results_san_file_" code, but it is only at the end of
> the script. So we are OK to make a definitive call on the zero/non-zero
> count of failed tests.
> 
> -Peff

Thank you for taking the time to review these series.
