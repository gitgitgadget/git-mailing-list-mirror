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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 061C5C433B4
	for <git@archiver.kernel.org>; Mon,  3 May 2021 15:41:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C5C56611AB
	for <git@archiver.kernel.org>; Mon,  3 May 2021 15:41:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230439AbhECPmJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 May 2021 11:42:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230443AbhECPmD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 May 2021 11:42:03 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92E6EC061763
        for <git@vger.kernel.org>; Mon,  3 May 2021 08:41:08 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id l13so4449697wru.11
        for <git@vger.kernel.org>; Mon, 03 May 2021 08:41:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=6gXQlC6WfeDhidMTMl3NDyHiPUKU9vvCJH+mC6VPa/k=;
        b=Fa4qzc3LGvQliMoNR8C7/d5cyXAgy5VFShEHt2GTKrIqGMLxE8OO7y3KxqSYqr0j+w
         akOXZvx2wy066gsd5tj02EO9mMllzkefOOVxQbadGnW/BNBir5cFJAaev22b53IosZop
         CwWssQC7yivhiNeh/tKIa+6VONsGYhD6yiBtd7qMd4jr9bv1i17b8RSbLtd0ngG8ZFSP
         w6cIpjH7kD9xZJG7oZgkNE0/iI8qEFePbgnRHK5pRDhtHxu11rAHHwve4pZql7WgZgxQ
         2DcUIrT9EHAXeVBkd0bqfDwmbwvnfkPWQJm9siiJ5OjVS64Xa02qcqLNrhWHkfHI4C+l
         I0nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=6gXQlC6WfeDhidMTMl3NDyHiPUKU9vvCJH+mC6VPa/k=;
        b=cS9LWKdfHXYRpPBenCJSLmL64uYgCKzLasR3+jq5DD3r4jBab38aKhkpGG0lVi4Jub
         18v9MMh/JhShf8imvVmdOGvF4NX22n8vMnUltrQXxpmISABHke2c91r7y/QIzNIoKebe
         pPHWQMlYOIPLFw1C8gq4c5eMz6+PQhogYb9mnA8vqkU53pdp3XYMfhjRSoxVrAnhRMkW
         3o6wULLH+9yzVXvJiq+YanXL16PGgs2VL1YX3PcJlmi9xsYKytLOblIqTxBeO95uoHLb
         0CL/jPI9oL3ZsYYv09Iv7ZnrGD48CJhhSQxLBMBBv+Dla47cGEvhg2e0l/cs1nrnMOq8
         aRvQ==
X-Gm-Message-State: AOAM533L+UGzL+TOCcS97crLl6zs3DD0+DDtKyROatcV8sOstO9HxpGD
        R80TeOtKe1w8sITlRDW0YWfYRIAtjR0=
X-Google-Smtp-Source: ABdhPJzro6Cfx+Jd/lq2p1MUxlSTGvHMxjf0q9PesdPmx1NZ8mZwArWBEwvIVlTcpUcBS4r2xYK+gQ==
X-Received: by 2002:a05:6000:10:: with SMTP id h16mr25631639wrx.381.1620056467739;
        Mon, 03 May 2021 08:41:07 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l18sm12799220wrx.96.2021.05.03.08.41.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 May 2021 08:41:07 -0700 (PDT)
Message-Id: <8129ef6c476b4f35be59eae71367de5b83888068.1620056466.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.913.v12.git.1620056466.gitgitgadget@gmail.com>
References: <pull.913.v11.git.1618672417.gitgitgadget@gmail.com>
        <pull.913.v12.git.1620056466.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 03 May 2021 15:41:04 +0000
Subject: [PATCH v12 1/2] [GSOC] docs: correct descript of
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

