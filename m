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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44C70C433ED
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 16:52:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 14A9461206
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 16:52:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343833AbhDLQwt (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Apr 2021 12:52:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345394AbhDLQrP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Apr 2021 12:47:15 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F3D2C061375
        for <git@vger.kernel.org>; Mon, 12 Apr 2021 09:39:31 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id p6so6910945wrn.9
        for <git@vger.kernel.org>; Mon, 12 Apr 2021 09:39:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=6gXQlC6WfeDhidMTMl3NDyHiPUKU9vvCJH+mC6VPa/k=;
        b=B8lugyQsXmO36Jti3QHhbtusIbNRTs5Kwi8kXmnSIY46vpzSQNvurVaB+StrlfRE8J
         ysM+AeRxId3l8ZKy099pnB8QkauRXUbvwi00VO+QRh8TcEi2KZfqt9lc2YwHmUAMyMOk
         1iYJKMI/nBWgZH9OC+AoiNPNpvVL+xkJqzLKXWfpcQZ7Hpn0nXcpKJRow7OwjsubjRzb
         fUPMe8Pk8EKaKVfKzBa1Q9kZqZFL94/N8N7KyHmRRz89mJ8io19M9Rrfh5SryqSvOmhc
         VUXUtOKA1UU9wmSb2xjuVgLz4QkRmn3sOhGuiFEgM5Z+FrzebOzgt4Vy4yFPlKGLY382
         9HpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=6gXQlC6WfeDhidMTMl3NDyHiPUKU9vvCJH+mC6VPa/k=;
        b=J3K9mblISqc0+eNSX6A4W2FfBxOUgZM2gk5FPsSeS8YbIi0DdZNgTV8H1wjc+lLrSH
         5ps0eQJItg6u3qHLVu7UfVvaJn+zFTEyoZN+9+o9+TMwKjBrUnwfpgQ9Or9+ohw6FQPD
         x4eMUFmlKKjQecCdLnUYDqi0sTNnM1Cxy0sR+YNu3Zmd/2oU/O6F6zTdNjEZhVKjfySP
         xxcmwb9+CZ3Cnyq/qEErb7WrQ8FlV3U76eLuy+yABPj7rv/xgMf6mVuGlbFo5uqVbfvo
         pamy+NftZKcsrz9B7EpqeQx31eDemdlnTvHWWLrsovAxIt2QiSII9XSmKNjeP4M7O2v8
         r8FQ==
X-Gm-Message-State: AOAM532iVpbxBc8iE75Se82BmWW7gfYt9tVRJUfhCuRwLbg/YQQKY/TE
        2eulyip+OWiRytZaFWQRShItQIiC6Aw=
X-Google-Smtp-Source: ABdhPJwuOg7k7lbblJ4mOv5yuiU76Bdli6UmF0NpxStUn4Yc7xnkNoMvSPYhYKdPhi+upd9/yAtzKg==
X-Received: by 2002:adf:d851:: with SMTP id k17mr32747044wrl.254.1618245570069;
        Mon, 12 Apr 2021 09:39:30 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x23sm9501222wmj.43.2021.04.12.09.39.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Apr 2021 09:39:29 -0700 (PDT)
Message-Id: <8129ef6c476b4f35be59eae71367de5b83888068.1618245568.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.913.v9.git.1618245568.gitgitgadget@gmail.com>
References: <pull.913.v8.git.1617975462.gitgitgadget@gmail.com>
        <pull.913.v9.git.1618245568.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 12 Apr 2021 16:39:26 +0000
Subject: [PATCH v9 1/2] [GSOC] docs: correct descript of
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

