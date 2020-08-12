Return-Path: <SRS0=KdtI=BW=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38F9DC433DF
	for <git@archiver.kernel.org>; Wed, 12 Aug 2020 15:06:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 105452080C
	for <git@archiver.kernel.org>; Wed, 12 Aug 2020 15:06:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p4/QdDNR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726568AbgHLPGV (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Aug 2020 11:06:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726447AbgHLPGV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Aug 2020 11:06:21 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2C8AC061383
        for <git@vger.kernel.org>; Wed, 12 Aug 2020 08:06:20 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id d190so2067463wmd.4
        for <git@vger.kernel.org>; Wed, 12 Aug 2020 08:06:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=Jrygab2ToHuSEEjgUdoBqy4RB1ePuTtvYLOF5kmEa58=;
        b=p4/QdDNRvDS4U6heaSKyHaZEDPg2djgHYHg9M9FHInFRfC8JtnFHSYfH0eGq7czX8N
         pW53pvOYJkRwiSyA01+7bqq93jI+DbUBIJqoYK2I0x9upWUoE85b3kxF2Srqsk64xm6K
         h+3MOp1ZwJfb81AbZZn03RFlj01PndCqML517wcBMezo4a9mhubFc5lljQ4mzH98MlZu
         94wJio/zAWxMApxBPqjOGtqbdf2BpeGx1All+LrQqcHkvsFZCxfq3lkB9qCd6ZfMxvqc
         ROgPBxYLevH6aZCkXu0wyeEIrVKxEXJYjl1mIUQkoU9ScxKI1rPQJbF7uwEa9r6RFiPc
         SqEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Jrygab2ToHuSEEjgUdoBqy4RB1ePuTtvYLOF5kmEa58=;
        b=CLvCXiEHQOrY3fz1apQ2vTqtIoduOdKEpl2Kf0iCpgVMonCQIHEHMsVcaSFuCEzMKg
         eEPUEMbfxfvZKMoQCgYRveZAMwhcYij5yGnmnaMSKrn3tFE3DX9oYJlsW2V04EfcnZ+z
         dO1A6XR27ReAhqBX/Ir0o5lYCsmrwePB7i3e45+qRAHJJt9B2W1DtMM+i1gMJSIc4Mo+
         KfqVNixCc9AHu8tF1L90dj4HKUUkzOAmsDvpzNY9A0zeHbd8c2VoIm4b5NqhmqUwKTvq
         AvNHFd7sk4BGU5mzLcslUQW32Tnr7ryvIDQhvEdvXiBDuPqZQOyz82YwiOQgjy9ehttX
         R7Og==
X-Gm-Message-State: AOAM530KgmzF+nBhKl2In7R2XVaHUkzqcZ64BYsea5Crp0imASeRqsQS
        YeTPY3ofLihaOww5vbMrxgRa6piH
X-Google-Smtp-Source: ABdhPJxXUp5sEQEl9p5btCXvXPmiK7TZJWmb5XRRGxqn2xT8JVbCwhqGbX6SQ8uqM5/QyvEdXlZOyw==
X-Received: by 2002:a05:600c:2146:: with SMTP id v6mr159072wml.87.1597244779380;
        Wed, 12 Aug 2020 08:06:19 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t189sm4366692wmf.47.2020.08.12.08.06.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2020 08:06:18 -0700 (PDT)
Message-Id: <pull.699.git.1597244777943.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 12 Aug 2020 15:06:17 +0000
Subject: [PATCH] git-gui: accommodate for intent-to-add files
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Pratyush Yadav <me@yadavpratyush.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

As of Git v2.28.0, the diff for files staged via `git add -N` marks them
as new files. Git GUI was ill-prepared for that, and this patch teaches
Git GUI about them.

Please note that this will not even fix things with v2.28.0, as the
`rp/apply-cached-with-i-t-a` patches are required on Git's side, too.

This fixes https://github.com/git-for-windows/git/issues/2779

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
    git-gui: accommodate for intent-to-add files
    
    This fixes the intent-to-add bug reported in 
    https://github.com/git-for-windows/git/issues/2779: after a file was
    staged with git add -N, staging hunks/lines would fail silently.
    
    On its own, this patch is not enough, as it requires the patches
    provided in rp/apply-cached-with-i-t-a to be applied on Git's side.
    
    Please note that this patch might need a bit more help, as I do not
    really know whether showing "new file mode 100644" in the diff view is
    desirable, or whether we should somehow try to retain the
    "intent-to-add" state so that unstaging all hunks would return the file
    to "intent-to-add" state.
    
    Thoughts?

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-699%2Fdscho%2Fgit-gui-stage-ita-hunks-and-lines-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-699/dscho/git-gui-stage-ita-hunks-and-lines-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/699

 git-gui.sh   |  2 ++
 lib/diff.tcl | 12 ++++++++----
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/git-gui.sh b/git-gui.sh
index 49bd86e635..e08cb17395 100755
--- a/git-gui.sh
+++ b/git-gui.sh
@@ -2080,6 +2080,7 @@ set all_icons(U$ui_index)   file_merge
 set all_icons(T$ui_index)   file_statechange
 
 set all_icons(_$ui_workdir) file_plain
+set all_icons(A$ui_workdir) file_plain
 set all_icons(M$ui_workdir) file_mod
 set all_icons(D$ui_workdir) file_question
 set all_icons(U$ui_workdir) file_merge
@@ -2106,6 +2107,7 @@ foreach i {
 		{A_ {mc "Staged for commit"}}
 		{AM {mc "Portions staged for commit"}}
 		{AD {mc "Staged for commit, missing"}}
+		{AA {mc "Intended to be added"}}
 
 		{_D {mc "Missing"}}
 		{D_ {mc "Staged for removal"}}
diff --git a/lib/diff.tcl b/lib/diff.tcl
index 871ad488c2..36d3715f7b 100644
--- a/lib/diff.tcl
+++ b/lib/diff.tcl
@@ -582,7 +582,8 @@ proc apply_or_revert_hunk {x y revert} {
 	if {$current_diff_side eq $ui_index} {
 		set failed_msg [mc "Failed to unstage selected hunk."]
 		lappend apply_cmd --reverse --cached
-		if {[string index $mi 0] ne {M}} {
+		set file_state [string index $mi 0]
+		if {$file_state ne {M} && $file_state ne {A}} {
 			unlock_index
 			return
 		}
@@ -595,7 +596,8 @@ proc apply_or_revert_hunk {x y revert} {
 			lappend apply_cmd --cached
 		}
 
-		if {[string index $mi 1] ne {M}} {
+		set file_state [string index $mi 1]
+		if {$file_state ne {M} && $file_state ne {A}} {
 			unlock_index
 			return
 		}
@@ -687,7 +689,8 @@ proc apply_or_revert_range_or_line {x y revert} {
 		set failed_msg [mc "Failed to unstage selected line."]
 		set to_context {+}
 		lappend apply_cmd --reverse --cached
-		if {[string index $mi 0] ne {M}} {
+		set file_state [string index $mi 0]
+		if {$file_state ne {M} && $file_state ne {A}} {
 			unlock_index
 			return
 		}
@@ -702,7 +705,8 @@ proc apply_or_revert_range_or_line {x y revert} {
 			lappend apply_cmd --cached
 		}
 
-		if {[string index $mi 1] ne {M}} {
+		set file_state [string index $mi 1]
+		if {$file_state ne {M} && $file_state ne {A}} {
 			unlock_index
 			return
 		}

base-commit: 469725c1a3d44f7e1475f1d37cd13e0824d4ea41
-- 
gitgitgadget
