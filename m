Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B62CBC433B4
	for <git@archiver.kernel.org>; Fri, 16 Apr 2021 08:48:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 95336613C5
	for <git@archiver.kernel.org>; Fri, 16 Apr 2021 08:48:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241503AbhDPIs7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Apr 2021 04:48:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241195AbhDPIsY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Apr 2021 04:48:24 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54733C06175F
        for <git@vger.kernel.org>; Fri, 16 Apr 2021 01:47:58 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id n10-20020a05600c4f8ab0290130f0d3cba3so2030138wmq.1
        for <git@vger.kernel.org>; Fri, 16 Apr 2021 01:47:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=6gXQlC6WfeDhidMTMl3NDyHiPUKU9vvCJH+mC6VPa/k=;
        b=Zv603lAgsIxINAj0c2eDwlsTBe180GAqyn5DTwkMp92aTVgJ8QmSW1aPb7U9gPjkgl
         F9qvpls0YxkX/b0YFblcXxbX3LPJmzNUXV7E2HB7G7MS7WbVHfZX94ujg3b66fxHOLT8
         4J3U1kAwYCjBkk8oQVUL42hEhExg2/Ueu525nui6TERvLiVomxHhqmgQRQnz7A1J48dc
         Vj4heNRMfyVPXtrKPnI5DP9RVOe9TnUd9Lr1QLEGEC+l6fqbxJeVLUj9T/eiarvgNTyS
         6tK0gYbjutrVKPQCkvwbSOQqtLFlZsdtaK7VQNN51BQFbYwY+QvwXalOR/tvNnIuU09N
         BkjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=6gXQlC6WfeDhidMTMl3NDyHiPUKU9vvCJH+mC6VPa/k=;
        b=ud8QTOz8cyLqF2FRZZRmHKU2PE0gmC5VpGWomBU8uIKVtyx/mtuAE8PqkBsiS30Db4
         oYXXCpxW4g7gkvkjaieLWWAY6DurrE6aPUWGCXu8SpI31PhIj2txgpGJA8uvRVaLPFcZ
         tcuVfE3PIOCAbo3tnCAm7qqEftZrS3PKni7F8DwQ1WCeWbn7Pt0kxhZCtkEWz8mMEL13
         QVmEVdwolOZlx6WZhEy/4IRuu4RTSTdFi5m5pb+pKBXLyr736ifdGcTcN+f7UP1on5tK
         8IJbJPXEAnJMmt36OBn41/CbPB/v5yUKlIllMYcCWuhZRDD5B29+xuZFf/PxFOidKRNX
         K/MA==
X-Gm-Message-State: AOAM530kc2fHEP9UK0kKOyuF9nYv2LsOZhi2IrYtbqwhg3OZd/4+xIwe
        FEmuHPyFdiKj67Fi39XB6uVjrqklGS4=
X-Google-Smtp-Source: ABdhPJwnzUIt/2JR4hKaVF8yQVFaCC99MY5Aqz0u1SZTCSNKL8akD15Q+RhtSt1drsmNoKIT4WENrQ==
X-Received: by 2002:a7b:cd98:: with SMTP id y24mr7014950wmj.52.1618562877143;
        Fri, 16 Apr 2021 01:47:57 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v185sm7953967wmb.25.2021.04.16.01.47.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Apr 2021 01:47:56 -0700 (PDT)
Message-Id: <8129ef6c476b4f35be59eae71367de5b83888068.1618562875.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.913.v10.git.1618562875.gitgitgadget@gmail.com>
References: <pull.913.v9.git.1618245568.gitgitgadget@gmail.com>
        <pull.913.v10.git.1618562875.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 16 Apr 2021 08:47:54 +0000
Subject: [PATCH v10 1/2] [GSOC] docs: correct descript of
 trailer.<token>.command
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Christian Couder <christian.couder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        ZheNing Hu <adlternative@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: ZheNing Hu <adlternative@gmail.com>

In the original documentation of `trailer.<token>.command`,
some descriptions are easily misunderstood. So let's modify
it to increase its readability.

In addition, clarify that `$ARG` in command can only be
replaced once.

Signed-off-by: ZheNing Hu <adlternative@gmail.com>
---
 Documentation/git-interpret-trailers.txt | 37 ++++++++++++++----------
 1 file changed, 21 insertions(+), 16 deletions(-)

diff --git a/Documentation/git-interpret-trailers.txt b/Documentation/git-interpret-trailers.txt
index 96ec6499f001..6f2a7a130464 100644
--- a/Documentation/git-interpret-trailers.txt
+++ b/Documentation/git-interpret-trailers.txt
@@ -232,25 +232,30 @@ trailer.<token>.ifmissing::
 	that option for trailers with the specified <token>.
 
 trailer.<token>.command::
-	This option can be used to specify a shell command that will
-	be called to automatically add or modify a trailer with the
-	specified <token>.
+	This option can be used to specify a shell command that will be called:
+	once to automatically add a trailer with the specified <token>, and then
+	each time a '--trailer <token>=<value>' argument to modify the <value> of
+	the trailer that this option would produce.
 +
-When this option is specified, the behavior is as if a special
-'<token>=<value>' argument were added at the beginning of the command
-line, where <value> is taken to be the standard output of the
-specified command with any leading and trailing whitespace trimmed
-off.
+When the specified command is first called to add a trailer
+with the specified <token>, the behavior is as if a special
+'--trailer <token>=<value>' argument was added at the beginning
+of the "git interpret-trailers" command, where <value>
+is taken to be the standard output of the command with any
+leading and trailing whitespace trimmed off.
 +
-If the command contains the `$ARG` string, this string will be
-replaced with the <value> part of an existing trailer with the same
-<token>, if any, before the command is launched.
+If some '--trailer <token>=<value>' arguments are also passed
+on the command line, the command is called again once for each
+of these arguments with the same <token>. And the <value> part
+of these arguments, if any, will be used to replace the first
+occurrence of substring `$ARG` in the command. This way the
+command can produce a <value> computed from the <value> passed
+in the '--trailer <token>=<value>' argument.
 +
-If some '<token>=<value>' arguments are also passed on the command
-line, when a 'trailer.<token>.command' is configured, the command will
-also be executed for each of these arguments. And the <value> part of
-these arguments, if any, will be used to replace the `$ARG` string in
-the command.
+For consistency, the first occurrence of substring `$ARG` is
+also replaced, this time with the empty string, in the command
+when the command is first called to add a trailer with the
+specified <token>.
 
 EXAMPLES
 --------
-- 
gitgitgadget

