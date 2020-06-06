Return-Path: <SRS0=8AI5=7T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 900BCC433DF
	for <git@archiver.kernel.org>; Sat,  6 Jun 2020 12:15:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 58A922073E
	for <git@archiver.kernel.org>; Sat,  6 Jun 2020 12:15:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U+h8XmWY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728748AbgFFMO7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 6 Jun 2020 08:14:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725831AbgFFMO6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 Jun 2020 08:14:58 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24C6EC03E96A
        for <git@vger.kernel.org>; Sat,  6 Jun 2020 05:14:58 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id x6so12323124wrm.13
        for <git@vger.kernel.org>; Sat, 06 Jun 2020 05:14:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=i39upMTZBoFG7TvxCvWFUa8k8ZJefC669hggnTMIVq0=;
        b=U+h8XmWYt6SXNJW+7RH+AH5krgLoZvmV3dSxP1J9YSNVuJgIRgYVjIr5iIkH2Ahj97
         ANUWbd1ePmgSw4j56jJowzJdyBDhUiouvecDjOomialz1L18z+3XYbN/kIdJ5LlLrSXr
         4Ml4J3eqLdgVuBtTcjK9kz1k/84qdIbPBW5utdmCf9X3sjk1mAQ30WyftbLkS2yFPb9J
         kSy9wO0tM6cZGnrn6+MKuPZyfQcwpcNJfmEt7oNJYKCLVOZ0Fhr0LmQpkii4Y7+H5YUL
         g0KAgF4NaWFicvwphMPR3FYt/ZqUAhIs0jHYWH8by6ZXzNTuNIegZl31n4VQF5ui48I0
         Mz4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=i39upMTZBoFG7TvxCvWFUa8k8ZJefC669hggnTMIVq0=;
        b=oszJoDgOypFcT/WgOF8nlqGu5l8t+uH+jFEAIB03EpP+k/pW180J0u89egmzBFQdze
         YUAsKiakVGJQNY3P3cnn5qHXUlFRLAPgDD+vE2s1TBDeKBCNnluYegUh7DfZJxzDNS7U
         VURaNlhckdxrFb2ziQXehVa7y7MRciN+zom0U1HKl8ba1vaf8UDfLzxRo2moXDoel9ub
         TQ5sAjcYuLmAz0P7MA1xfabeExTSQD1ztS0EK0D96ItJVfbdI96B0pSz0fJsgyLwSpgT
         1+f88aszJRFYghhfRwxNq8abN0Ma6M3m6W6Y/BOOg8QqlQ+UFwvDbo+tB40Vt+I7tIsu
         lMBA==
X-Gm-Message-State: AOAM5309eQfAh6JalzBArnZIlX31Z2Xbn1UWSbFfgedKQoFEwC1Bsl9a
        Bu2x2z9TPox4IQHiHkvtCAvYvRUA
X-Google-Smtp-Source: ABdhPJwsWULF2yxwRcUeEalnw2dfs26qO++7HlGuwFhojB0x/oW75K3qqUZmbPsMhz0oK4efHAA2tA==
X-Received: by 2002:a05:6000:100e:: with SMTP id a14mr13996533wrx.349.1591445696567;
        Sat, 06 Jun 2020 05:14:56 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w3sm16128302wmg.44.2020.06.06.05.14.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jun 2020 05:14:56 -0700 (PDT)
Message-Id: <pull.649.git.1591445695220.gitgitgadget@gmail.com>
From:   "Angel via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 06 Jun 2020 12:14:55 +0000
Subject: [PATCH] doc: fix a typo inside `--bare` section
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Angel <the.f8er@gmail.com>, Mark Williams <the.f8er@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Mark Williams <the.f8er@gmail.com>

Add a word `variable` and a `$` sign before variable's
name in `--bare` argument section. Without this word someone
might be confused.

Signed-off-by: Mark Williams <the.f8er@gmail.com>
---
    doc: fix a typo inside --bare section
    
    doc: fix a typo inside --bare section
    
    Add a word variable and a $ sign before variable's name in --bare 
    argument section. Without this word someone might be confused.
    
    Signed-off-by: Mark Williams the.f8er@gmail.com [the.f8er@gmail.com]

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-649%2Fvv7v7%2Fpatch-3-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-649/vv7v7/patch-3-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/649

 Documentation/git-init.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-init.txt b/Documentation/git-init.txt
index adc6adfd380..7f8b0bd6c4d 100644
--- a/Documentation/git-init.txt
+++ b/Documentation/git-init.txt
@@ -45,8 +45,8 @@ Only print error and warning messages; all other output will be suppressed.
 
 --bare::
 
-Create a bare repository. If `GIT_DIR` environment is not set, it is set to the
-current working directory.
+Create a bare repository. If the `$GIT_DIR` environment variable is not set, it
+is set to the current working directory.
 
 --object-format=<format>::
 

base-commit: 20514004ddf1a3528de8933bc32f284e175e1012
-- 
gitgitgadget
