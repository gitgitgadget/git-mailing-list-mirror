Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1A5FC64997
	for <git@archiver.kernel.org>; Mon, 19 Jul 2021 23:11:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2435961205
	for <git@archiver.kernel.org>; Mon, 19 Jul 2021 23:11:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354531AbhGSWUV (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Jul 2021 18:20:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387296AbhGSUDT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Jul 2021 16:03:19 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 501D1C061574
        for <git@vger.kernel.org>; Mon, 19 Jul 2021 13:41:32 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id x6so9075462qvx.4
        for <git@vger.kernel.org>; Mon, 19 Jul 2021 13:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=5S+AD4TUU/5/nMeShu1VC6YtYaPmQNzSdVes2XefLCs=;
        b=PjiGEEddNzAN6njoQ/BkDmJmgxvnKwX90lWDu4dUJ0wGnHOKdxv1fP+9hj3PwCKg+W
         L3QhlfkUb3VCxkB0MVSEZ9kX5hSPLVSa8xEvCCrWf8wIfLDg45IFFc2i7vttvgD7fkcE
         kqLzCT/M+2jzX7tMmn+gXZpA2RSbPdM7lTSSpg/CFRTN3VDW+loaH4Yv9spVJuvp3XIg
         HSQMH5qmw8aIeteMtOXy0gSEjBUjg5bXnKhRnMlfYkwK0HajNQ1N7IogKD6M5w4H9h32
         6NWzqSYRSeJ6HiUE1UubuYy+2YfFZkQA1SddF+sry3XO+UkWXj1QAMqxavSpaNwpocOh
         8hoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=5S+AD4TUU/5/nMeShu1VC6YtYaPmQNzSdVes2XefLCs=;
        b=JOcZlwmfIOEj0LL1RdQh6NPqkdxKNFU0YeYe4GBRTp4bEkGhaQ04m50WBQwErWPCyr
         YLskCrJA/GU/vZOFOApcAXiKRyC4F9tE+3O75OfR/i0DA45OjKpmBoibfUWoNXq+UYc1
         P/0qwUl59j7eeiP/EzM/jIeRyIRO+7Sv4FXgKeO7qYi9/kSQOcnP7SKI5yuhqk7WY9FZ
         6HI977eCQBEseCLm4Ng7v3++FhR+odb63AO6/s1dp2YjgxVvi7AaNzK60lm3bQj215IM
         WF/JuW8U6Hre/3jKEsfj6FgOCNG4RBHNZxq0oKVOTXAeqgjl8pZvwLoDr/NExR53O9dz
         yfYQ==
X-Gm-Message-State: AOAM530Phur1ODlbVC7xnaMxZw4kSmBdXM6hiXiUMVxlx5O1zpGWjHI4
        iIYNPFciWioBSJ59z3N6nHhHzO6XZaZ+/w==
X-Google-Smtp-Source: ABdhPJyiqhB731XVe/L3+twjr5c/Hlf4GD471CVWyBMxkbkvNdjMwPCbsuSiwMhlA2Ffax7TpeeuHw==
X-Received: by 2002:a0c:ff48:: with SMTP id y8mr26782641qvt.29.1626727435919;
        Mon, 19 Jul 2021 13:43:55 -0700 (PDT)
Received: from [192.168.1.127] ([192.222.216.4])
        by smtp.gmail.com with ESMTPSA id g13sm7047594qtj.2.2021.07.19.13.43.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Jul 2021 13:43:55 -0700 (PDT)
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     Git mailing list <git@vger.kernel.org>
From:   Philippe Blain <levraiphilippeblain@gmail.com>
Subject: 'git range-diff' does not detect submodule changes if
 'diff.submodule=log'
Message-ID: <e469038c-d78c-cd4b-0214-7094746b9281@gmail.com>
Date:   Mon, 19 Jul 2021 16:43:54 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:78.0)
 Gecko/20100101 Thunderbird/78.12.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Johannes,

I noticed that 'git range-diff' silently "drops" submodule changes if
'diff.submodule=log' is set in the config. This is because the 'diff --git'
header is not shown in that case, and the code in range-diff.c::read_patches
expects that header to be found to detect changes.

If 'diff.submodule' is instead set to 'diff', the range-diff outright errors with
(at least in my case):

error: git apply: bad git-diff - inconsistent old filename on line 1
error: could not parse git header 'diff --git path/to/submodule/and/some/file/within
'
error: could not parse log for '@{u}..@{1}'


I think it would make sense to force '--submodule=short' for range-diff, something like:

diff --git a/range-diff.c b/range-diff.c
index 1a4471fe4c..d74b9c7a55 100644
--- a/range-diff.c
+++ b/range-diff.c
@@ -54,7 +54,7 @@ static int read_patches(const char *range, struct string_list *list,

         strvec_pushl(&cp.args, "log", "--no-color", "-p", "--no-merges",
                      "--reverse", "--date-order", "--decorate=no",
-                    "--no-prefix",
+                    "--no-prefix", "--submodule=short",
                      /*
                       * Choose indicators that are not used anywhere
                       * else in diffs, but still look reasonable


What do you think ?

Thanks,
Philippe.

P.S. As an aside,
I'm  not sure why you chose to skip the 'diff --git' header with '--submodule=log'
(I did not search the list), but I think that in general 'git diff' and friends,
it would be nice to be able to still see this header even with --submodule=log...
