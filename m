Return-Path: <SRS0=GnTn=7I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27AB5C433E0
	for <git@archiver.kernel.org>; Tue, 26 May 2020 15:33:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F15DE20663
	for <git@archiver.kernel.org>; Tue, 26 May 2020 15:33:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kWSn437o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729311AbgEZPdY (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 May 2020 11:33:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727898AbgEZPdY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 May 2020 11:33:24 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AEC2C03E96D
        for <git@vger.kernel.org>; Tue, 26 May 2020 08:33:24 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id y17so12425548wrn.11
        for <git@vger.kernel.org>; Tue, 26 May 2020 08:33:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=QbSRwWHmTIvxLCfAjUQpB13egZVObZEavEjKN7ezg9s=;
        b=kWSn437oGGSNU2GwTZMloegpsfSDedeuaVVJhrBpWUoI4B34W4j7Cm+SRd7acnau32
         fqdUoJ8mDhCERfM0Q1pcxgrDN4x6i6hJyV+S4VEFARxl5u8lkXACLY4hQ0i+SrMHrGPH
         36rTzei8okgQkFLPfGaG99JvDhPur/y4/UMcdX3svzcvhqa9yXDLTVn/t0S4PPUnSEWD
         iPtWX+16pI/cW6pIFVXoKOzGKt1gRvCrTp3zqaYaT6xNGcnlKYfsUkOw1XMYdWtEw8OF
         svfx27Bd2fg7TMizNAynBO1kkBKNHKpJHMARHDzGHbiSNiWQQLjsUnwpTdNW0x5/Cpuq
         Ub1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=QbSRwWHmTIvxLCfAjUQpB13egZVObZEavEjKN7ezg9s=;
        b=tjw+Fa97NYmv2CNiHpEAemOOkvM6D/5UeWrf+eC+iI+3zg4l02YsitrTig49C6yh9+
         ITv0h4WRhuCGyBp6uzNWp4Mz5A2To8xu2sK6kUOH1Qw2Z/i5W+xHVUSTh6nbqyhK8IYI
         VyvjacHsSDT2e9vW5YcdIf2QGIhNWSR16l6nFAm3yhauVa81l9OBjCAjortPlbTeA33e
         gzFy6SIG2BXDjR89BGUy25uUaDi2ZCOaH7y6oiihwvyBR1VpmFXhY8mtpSP486hITtkn
         jKZd7ya2ClhvpcK/NsQrfRRtI8h6I3biPmrz1+cXEv4bIatce/yNlhn0OKyBrAa+CIJC
         ah2g==
X-Gm-Message-State: AOAM531wg4vOjn7DqxxmxgJ9NNHkEgnASRZrf2Ird1XszBvlYpbiw3Qm
        G7pTXiu/AwG04ryyYk7ZUj7zquE4
X-Google-Smtp-Source: ABdhPJxwyPVQYAUKq4Aujb6vaaZy3sAB1/uvxQWG7xvj7e8ktbT7dixlVhM0EEC+vd4GMe1GYudO+Q==
X-Received: by 2002:adf:a1c1:: with SMTP id v1mr20981260wrv.205.1590507202866;
        Tue, 26 May 2020 08:33:22 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y4sm177722wro.91.2020.05.26.08.33.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2020 08:33:22 -0700 (PDT)
Message-Id: <pull.644.git.1590507201474.gitgitgadget@gmail.com>
From:   "Mikhail Terekhov via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 26 May 2020 15:33:21 +0000
Subject: [PATCH] git-gui: allow opening work trees from the startup dialog
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Mikhail Terekhov <termim@gmail.com>,
        Pratyush Yadav <me@yadavpratyush.com>,
        Mikhail Terekhov <termim@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Mikhail Terekhov <termim@gmail.com>

In proc _is_git check that supplied path is a valid work tree path.
This allows the choose_repository::pick dialog to accept path to a
work tree directory.

Signed-off-by: Mikhail Terekhov <termim@gmail.com>
---
    git-gui: allow opening work trees from the startup dialog
    
    Trying to open a working tree from the "Open Existing Repository" link
    of the git-gui startup dialog results in an error: Not a Git repository:
    .... This patch fixes that error.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-644%2Ftermim%2Fgit-gui-open-worktree-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-644/termim/git-gui-open-worktree-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/644

 lib/choose_repository.tcl | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/lib/choose_repository.tcl b/lib/choose_repository.tcl
index e54f3e66d8f..8f911e89fbb 100644
--- a/lib/choose_repository.tcl
+++ b/lib/choose_repository.tcl
@@ -362,8 +362,19 @@ proc _is_git {path {outdir_var ""}} {
 		gets $fp line
 		close $fp
 		if {[regexp "^gitdir: (.+)$" $line line link_target]} {
+			set check_path [file normalize $path]
 			set path [file join [file dirname $path] $link_target]
 			set path [file normalize $path]
+
+			if {[file exists [file join $path gitdir]]} {
+				set fp [open [file join $path gitdir] r]
+				gets $fp worktree_path
+				close $fp
+				if {[string equal $check_path $worktree_path]} {
+					set outdir $path
+					return 1
+				}
+			}
 		}
 	}
 

base-commit: c195247812f8cd38ba7e1c603112e6c1d8d8e71e
-- 
gitgitgadget
