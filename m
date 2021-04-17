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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2FE5C433B4
	for <git@archiver.kernel.org>; Sat, 17 Apr 2021 15:13:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A94B1611AF
	for <git@archiver.kernel.org>; Sat, 17 Apr 2021 15:13:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236611AbhDQPOI (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 17 Apr 2021 11:14:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236581AbhDQPOI (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Apr 2021 11:14:08 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77EBEC061574
        for <git@vger.kernel.org>; Sat, 17 Apr 2021 08:13:41 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id y5-20020a05600c3645b0290132b13aaa3bso3934890wmq.1
        for <git@vger.kernel.org>; Sat, 17 Apr 2021 08:13:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=6gXQlC6WfeDhidMTMl3NDyHiPUKU9vvCJH+mC6VPa/k=;
        b=g+nIupatmlp7+YfRkzBrtUyYqQNi0ptqvjl3HDIJo9pdU8+Urwr/7fHmf4uXZS49wC
         9Mse6a0pABDnhRIQ4xQ7wnb5CVk5CY17PMIfWhd0s7VBEr0iqfzWC783UttNX82E5deh
         zMpj1lqOaxqVYMpVlPJpIJQJ6UCAuTZNMtDp0OGaWjweg71hn4ef95XiY9iXw37rUC5A
         0jXTJRxbsDQVUXWNib/qQsc6MBxt0x/HiqwfKYVNA3PmgYG8DPGrQDYDHNyHplQzGapl
         vjRQymwpu4WG1n+E+CZXqkFJO4bo0HLPKsgdy5deAYybLp9mBc480xJtMw+QIPaGJhgW
         miSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=6gXQlC6WfeDhidMTMl3NDyHiPUKU9vvCJH+mC6VPa/k=;
        b=baRwBj+gTE0kmX8m7Y0993u3FhhMLy3XJD89X9CXgQGHREKoBrsfJhuW5TxS3D6cS5
         oodRuWDuF3PgPr28attkN8Pk+qUzkFsZn4ZHGJ102V4tFfNFKslHOVGVqv1qFfj2uroJ
         t6jaMRSKuP6TusgHmAmNzMLe+8H5llQ21sEDWqC487nabaKDIKIgXehTUuvap4Sr7I29
         Bftm3yDvQ3zD6Pslt7jVYWqkvo3S/ZP5UoiwFRfptIFh2QNo3LuUaKKeZhuizloAzMNo
         E2qy997vT0wX/bzlyJEy8/6dT63t1Ekt7ZpNoAmw2tdxmYbukor4PtYxVwx3gpn/kHJ2
         2QPg==
X-Gm-Message-State: AOAM5310OqpBlULWTcW7lag3Aw2hdWrhzPsBilaaS0X9eV9YxOfMiqAB
        osTfJWNRDY7/ATgaRcbAviKoMk+Tr6E=
X-Google-Smtp-Source: ABdhPJxXv1kCMG5yenW2NTWT7dH6CbCV3yHyQvOUbxXo2fbh+kfqoWuiu8ViTv7viK9XX2PIHGH5OA==
X-Received: by 2002:a1c:9a16:: with SMTP id c22mr13197772wme.7.1618672419557;
        Sat, 17 Apr 2021 08:13:39 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z15sm14311340wrv.39.2021.04.17.08.13.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Apr 2021 08:13:39 -0700 (PDT)
Message-Id: <34210e5bd3da3fe540800966860a9deca9c3253a.1618672417.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.913.v11.git.1618672417.gitgitgadget@gmail.com>
References: <pull.913.v10.git.1618562875.gitgitgadget@gmail.com>
        <pull.913.v11.git.1618672417.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 17 Apr 2021 15:13:36 +0000
Subject: [PATCH v11 1/2] [GSOC] docs: correct description of .command
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

