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
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD9D8C433E6
	for <git@archiver.kernel.org>; Mon,  1 Feb 2021 19:47:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 98CEA64EA9
	for <git@archiver.kernel.org>; Mon,  1 Feb 2021 19:47:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232490AbhBATq5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Feb 2021 14:46:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230298AbhBATqb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Feb 2021 14:46:31 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3E4CC06174A
        for <git@vger.kernel.org>; Mon,  1 Feb 2021 11:45:51 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id l12so17964230wry.2
        for <git@vger.kernel.org>; Mon, 01 Feb 2021 11:45:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=+DQeitWBjgmX6Tf3pJzZueR3+qK5XfM+JfwKZw1URY8=;
        b=cbMgjObXdCymoKeY/WKefb+GJhCLM7HjCgkh3rV4koW5YzRbQF3A9/wa0VqOXgWBF8
         6iqROxIgl1PMVPjEBvfBkJs5Hfh9ZXBR/GV2n5iW1szsxCNl7SdEQJgnBE/3haKd5EZO
         UwWai3myhumHMf+PwBSqC8VVgc/zIF+0I4yk0dQ80603Srtja6an2k2QzEY8y5YgPqxJ
         94pdyauLcEzNfhkK6D02R6wICLRHJisxwPAeGLKaI4nYpCRVbwnvQUPXzNPNygE3DdZw
         EbQ8yvibzVBuwqHH28YZx0RSSE3xD8ApOWi4fOqyTZM360MDep+QcJU6m6mPRAP7PEH2
         ivqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=+DQeitWBjgmX6Tf3pJzZueR3+qK5XfM+JfwKZw1URY8=;
        b=tvUmY3hduP6Yl0NYgXzXup0NaXulIQgTztz8GB0svqlqiREN8n6zq6W05Inqlj6meq
         MGrtYLsq5h+dccV2ottO3wtsMswng3NbM7lK3k/G26LoaQQIz5R1IJ5bp0vh/5FkjCH1
         mu9ABD5kH8HvJxDJe4WH0iRhFQJaWhBZUL5p1zZRdcT8zqopay+7YZTgeJnu8Nrip6tV
         8fm5im/TOFae65PJUY4kA+uZEAINfyWRbj3Wb0G4B80z6owedJ2cXoa+/jhUMMOBzaef
         4TWUjJW3r8a62gmv65vzxJwa/gF6QHlSYBTz7pakOfvlbvUWWpNMQWT8E5msVH+FHQ7f
         Vm1w==
X-Gm-Message-State: AOAM532CfWLgw6H7cOCd8OtTXIOwTBtciM/f93+HgALb5PGOKJjOXMGc
        0oaDLT0WMGOG5SE6HmwbtEQF+EguvMM=
X-Google-Smtp-Source: ABdhPJwYuVoWitz/ftNGQGWjxWBgoJYANsptLi9C04nzYivirKP6ADM4nDCIgrz+Er8wGZGZa6kUFQ==
X-Received: by 2002:a05:6000:1043:: with SMTP id c3mr20175062wrx.140.1612208750336;
        Mon, 01 Feb 2021 11:45:50 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f17sm29995991wrv.0.2021.02.01.11.45.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Feb 2021 11:45:49 -0800 (PST)
Message-Id: <4c6766d41834da9508142d1f420a741dc550806b.1612208747.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.766.v2.git.1612208747.gitgitgadget@gmail.com>
References: <pull.766.git.1610465492.gitgitgadget@gmail.com>
        <pull.766.v2.git.1612208747.gitgitgadget@gmail.com>
From:   "Junio C Hamano via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 01 Feb 2021 19:45:34 +0000
Subject: [PATCH v2 01/14] ci/install-depends: attempt to fix "brew cask" stuff
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Jeff Hostetler <git@jeffhostetler.com>,
        Jeff King <peff@peff.net>, Chris Torek <chris.torek@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Junio C Hamano <gitster@pobox.com>

We run "git pull" against "$cask_repo"; clarify that we are
expecting not to have any of our own modifications and running "git
pull" to merely update, by passing "--ff-only" on the command line.

Also, the "brew cask install" command line triggers an error message
that says:

    Error: Calling brew cask install is disabled! Use brew install
    [--cask] instead.

In addition, "brew install caskroom/cask/perforce" step triggers an
error that says:

    Error: caskroom/cask was moved. Tap homebrew/cask instead.

Attempt to see if blindly following the suggestion in these error
messages gets us into a better shape.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 ci/install-dependencies.sh | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/ci/install-dependencies.sh b/ci/install-dependencies.sh
index 0229a77f7d2..0b1184e04ad 100755
--- a/ci/install-dependencies.sh
+++ b/ci/install-dependencies.sh
@@ -44,13 +44,13 @@ osx-clang|osx-gcc)
 	test -z "$BREW_INSTALL_PACKAGES" ||
 	brew install $BREW_INSTALL_PACKAGES
 	brew link --force gettext
-	brew cask install --no-quarantine perforce || {
+	brew install --cask --no-quarantine perforce || {
 		# Update the definitions and try again
 		cask_repo="$(brew --repository)"/Library/Taps/homebrew/homebrew-cask &&
-		git -C "$cask_repo" pull --no-stat &&
-		brew cask install --no-quarantine perforce
+		git -C "$cask_repo" pull --no-stat --ff-only &&
+		brew install --cask --no-quarantine perforce
 	} ||
-	brew install caskroom/cask/perforce
+	brew install homebrew/cask/perforce
 	case "$jobname" in
 	osx-gcc)
 		brew install gcc@9
-- 
gitgitgadget

