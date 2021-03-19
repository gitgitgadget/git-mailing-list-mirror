Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D799C433E0
	for <git@archiver.kernel.org>; Fri, 19 Mar 2021 13:05:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 09AC964EA4
	for <git@archiver.kernel.org>; Fri, 19 Mar 2021 13:05:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbhCSNFZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Mar 2021 09:05:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229785AbhCSNFJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Mar 2021 09:05:09 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2BB2C06174A
        for <git@vger.kernel.org>; Fri, 19 Mar 2021 06:05:08 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id v70so2712373qkb.8
        for <git@vger.kernel.org>; Fri, 19 Mar 2021 06:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=p+0soyJmUEqeev8SpOut4gaHtWhFaxm1Cm8QCErWres=;
        b=QLxB9Wd/m/aQY6knT0KbiV91p0/Paciht+4h6Xm4pyVis7QnR27G1vHHG8atcJww8N
         /AbdTrlMMiJuBUC5pJN/Y74nciSavJvUYTFLRmQolh3YLc9lsXp4zMeblWWh+cgzXQsd
         k4CbSsCwwB8aQQOV8c2DTvhLzdBDG7oEjO0rRu0d5ejbVg1lv+YmiB6LAXzL/IYdxj1m
         EzVpldFI1AfOyIAtx6bk0YzE3na/4qF0AbvvpXg4mW0hrEkq4FOxE8iK3+3uHONJ9WWY
         6+I7QxrErYa37ye7aoUgYgU98V9Tjcq1DUtI9p4jiyfgmLjljuWmkV84Y7n6e9yu72rg
         C9hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=p+0soyJmUEqeev8SpOut4gaHtWhFaxm1Cm8QCErWres=;
        b=Upy9IRcIFSSTWleq2SrBDBPiUSBaZ7uezrT1Iz8nM0P/o7T6SdYL2jyq9V7NY2fp1P
         Jj9q3qD+lrsutkPWrCCFnl7h4ZPu6OWcroGOCrjXAcAuC6RURTglw0HjlBP5b4Hnc3Di
         nvY9D4pXxHdT7wv3a3S/ww+b3OTYsTqAG/AyWjj+PwfEnH639C04nGcb3k3iyL0UDoV8
         G/VbzGbvsB9rvxJebV8bN/9tHvmoQL2tswaE1L/gKW+g0rFE4r5GquaXNWfr5Y7UmHI9
         d9gVOvp/Bh4yxkGWZ+BvF16clOx0fDGZR2EReZMwO6xIHgFxGM3onEnGzl+CtjwWEfzT
         6hWw==
X-Gm-Message-State: AOAM532187TLorkMMRDttTKWBYAhvzcAiR9qEtTJ4aalJ9Pgit9MvzQ7
        wwDGm44m6Yx4KelCoKRyvwU=
X-Google-Smtp-Source: ABdhPJzMwDh0QZC29GkG+SoaYg81OnMaChHofpdbZ1lob5jrfId3YmXxrRFoCsuCZrOKoPpIpeWC8g==
X-Received: by 2002:a37:9f89:: with SMTP id i131mr9450142qke.160.1616159107943;
        Fri, 19 Mar 2021 06:05:07 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:7c62:2958:a423:b37b? ([2600:1700:e72:80a0:7c62:2958:a423:b37b])
        by smtp.gmail.com with ESMTPSA id a14sm3588610qtw.80.2021.03.19.06.05.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Mar 2021 06:05:07 -0700 (PDT)
Subject: Re: [PATCH v2 13/13] Add testing with merge-ort merge strategy
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>
References: <pull.905.git.1615867503.gitgitgadget@gmail.com>
 <pull.905.v2.git.1616016485.gitgitgadget@gmail.com>
 <d8536f56ab296171c09e667e5c9299e95078388e.1616016485.git.gitgitgadget@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <6b619bd0-c924-274e-d8bb-3bb9c67a2625@gmail.com>
Date:   Fri, 19 Mar 2021 09:05:06 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <d8536f56ab296171c09e667e5c9299e95078388e.1616016485.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/17/2021 5:28 PM, Elijah Newren via GitGitGadget wrote:
> From: Elijah Newren <newren@gmail.com>
> 
> In preparation for switching from merge-recursive to merge-ort as the
> default strategy, ensure that we are testing it.

OK, so here we are testing it by default in CI, not just in that
second round of optional environment variables. If that is what
you intended, then this is the diff I was expecting:

diff --git a/ci/run-build-and-tests.sh b/ci/run-build-and-tests.sh
index a66b5e8c75a..c013e9e646a 100755
--- a/ci/run-build-and-tests.sh
+++ b/ci/run-build-and-tests.sh
@@ -25,6 +25,7 @@ linux-gcc)
 	export GIT_TEST_ADD_I_USE_BUILTIN=1
 	export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
 	export GIT_TEST_WRITE_REV_INDEX=1
+	export GIT_TEST_MERGE_STRATEGY=org
 	make test
 	;;
 linux-clang)

However, if we want to be aggressive in adopting the ort strategy
very soon, then your approach of testing more frequently is
valuable.

Would it be worth setting GIT_TEST_MERGE_ALGORITHM=ort by default
in test-lib.sh, too? That could help developers working on top of
your topic avoid creating test failures that only show up in CI.

Thanks,
-Stolee
