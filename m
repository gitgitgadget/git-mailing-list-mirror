Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C848AC433F5
	for <git@archiver.kernel.org>; Mon, 13 Sep 2021 11:07:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB54060F46
	for <git@archiver.kernel.org>; Mon, 13 Sep 2021 11:07:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239427AbhIMLIW (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Sep 2021 07:08:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239418AbhIMLIS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Sep 2021 07:08:18 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF84BC061574
        for <git@vger.kernel.org>; Mon, 13 Sep 2021 04:07:02 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id g16so14055777wrb.3
        for <git@vger.kernel.org>; Mon, 13 Sep 2021 04:07:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=L7VyVf3JhmrwJvI0gpAMMVzoG6QAp5b/7xEvfp+eqSY=;
        b=VTtnglyURosrP4aLlh/gQvK+QzhVaAiTLOPnEKsNC5MhWhW2eEwHX9D50RajYbCesm
         cFpRWLjdZxJqJHwUF/+JTf3YgnwrWUFWwBDkqVxLsvrSSQrc1my3uTF88rZ1UUvfyogc
         aj7T183EtubC7QOivAsjnfqGEIlZY5saPXpOw4CkwwsTfZnzPEKdlCVCnhht8wAo3HHm
         mkqGx4WRZ2FrZkYbacygJZjQV3OEDCN46wFrlMZYYayjTvLj3MnuQA3ItH00VCxuGi+j
         pXfuWJem9NvE8ANn8jxUDA20l38hMk0tCFPojHTFCsbfjbBm6Jsbky+zCgFcm6x5++wm
         MeHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=L7VyVf3JhmrwJvI0gpAMMVzoG6QAp5b/7xEvfp+eqSY=;
        b=IXdGpTH+RMaMKCEYMLLlQVQbmdOaNXbVt6I+aJr4P/ovJ2qYi2k0EsLjAaJ1nJ0/bQ
         FxcdF1XJdOIWcpo+ssTKdtTTEPFsOak2IK7W1yIBYRIvQD4Emr4EZ7BEv7b9ql34jpQR
         teHlv+WxNEGzJxr/xufusJmU9r1tEtWZa1AkGoWJ/4Y+dmDTIwsy7iFhZXCjdAxxt3Fn
         /luNuvXg0QUqb6xw6BUN42QtGj6mB05kbwIV9vAmAyWDYaqzlO+su7+I4UfN/CYpZXkt
         8D82myE4u/fF9Ibpb9vyVn+hj7Ce99nUS9jplZNyW1Wh9Gd5nwLp9o9CBR3l8lboTXMs
         PBlA==
X-Gm-Message-State: AOAM532etDHas/0eoOAMN10gjLebofU/iNf0T68XXstLx8mYEE7Qrb+B
        /WGcJ16pJI+zSDK747WYVp+YG1+EmKw=
X-Google-Smtp-Source: ABdhPJy36a7gxvra7/twCsqUgokibNagtPj/F2lGaAFL8JCDnR+k6RkVbVZbStJtTxHK7ZZlGBVfWQ==
X-Received: by 2002:adf:fb09:: with SMTP id c9mr11603130wrr.93.1631531221435;
        Mon, 13 Sep 2021 04:07:01 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m4sm8378472wrx.81.2021.09.13.04.07.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Sep 2021 04:07:01 -0700 (PDT)
Message-Id: <d3635cbfd6ef0d47ebf28c516476dcd0b718afd4.1631531219.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1038.git.1631531218.gitgitgadget@gmail.com>
References: <pull.1038.git.1631531218.gitgitgadget@gmail.com>
From:   "=?UTF-8?q?Matthias=20A=C3=9Fhauer?= via GitGitGadget" 
        <gitgitgadget@gmail.com>
Date:   Mon, 13 Sep 2021 11:06:58 +0000
Subject: [PATCH 2/2] documentation: add documentation for 'git version'
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Matthias =?UTF-8?Q?A=C3=9Fhauer?= <mha1993@live.de>,
        =?UTF-8?q?Matthias=20A=C3=9Fhauer?= <mha1993@live.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: =?UTF-8?q?Matthias=20A=C3=9Fhauer?= <mha1993@live.de>

While 'git version' is probably the least complex git command,
it is a non-experimental user-facing builtin command. As such
it should have a help page.

Signed-off-by: Matthias Aßhauer <mha1993@live.de>
---
 Documentation/git-version.txt | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)
 create mode 100644 Documentation/git-version.txt

diff --git a/Documentation/git-version.txt b/Documentation/git-version.txt
new file mode 100644
index 00000000000..c7d6b496c8d
--- /dev/null
+++ b/Documentation/git-version.txt
@@ -0,0 +1,35 @@
+git-version(1)
+==============
+
+NAME
+----
+git-version - Display version information about Git
+
+
+SYNOPSIS
+--------
+[verse]
+'git version' [--build-options]
+
+
+DESCRIPTION
+-----------
+
+With no options given, the version of 'git' is printed
+on the standard output.
+
+If the option `--build-options` is given, information about how git was built is
+printed on the standard output in addition to the version number.
+
+Note that `git --version` is identical to `git version` because the
+former is internally converted into the latter.
+
+OPTIONS
+-------
+--build-options::
+	Prints out additional information about how git was built for diagnostic
+	purposes.
+
+GIT
+---
+Part of the linkgit:git[1] suite
-- 
gitgitgadget
