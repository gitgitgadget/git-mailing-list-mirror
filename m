Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,LONGWORDS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66F9FC433E0
	for <git@archiver.kernel.org>; Fri, 22 Jan 2021 15:19:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3DBA123A84
	for <git@archiver.kernel.org>; Fri, 22 Jan 2021 15:19:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727103AbhAVPTA (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Jan 2021 10:19:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729150AbhAVPRa (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Jan 2021 10:17:30 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED696C06174A
        for <git@vger.kernel.org>; Fri, 22 Jan 2021 07:16:37 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id y187so4644497wmd.3
        for <git@vger.kernel.org>; Fri, 22 Jan 2021 07:16:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=vvoVUi1xcPNXXcaT05hevbb9H8Me9yG1v2NJvkIIjkA=;
        b=Ao7SJYyyCtjetjSSKFTzdDzxQh5ntjPJszk5PcDCdMPU3udzRbB0DY12NJ3PY9m4b5
         dJxENf0pPMPLe+aOH62oJePCxiAvcpcmUF6OaalFowgZSLrEQmQsiDhhBiHygO8CBmm1
         R4i3p8LN/tH+JexvQg0CiTaCLL92ptsxllfvfgutA+w/ug5HXdTjtKZlz9ztfO9caUNF
         ub7nTT7or8BhpRtMd0CdVIENtL2CseEBKXgo/H8Re5aC3dbJS0z4Y4BQ0tvC0g1I4b+M
         FsHTnUSZMXrNlGTfKqpElmssFVXliOjEPyRwpzMWUdidFSRDSxRIjJkbYtQ6+wFNdfcq
         B6OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=vvoVUi1xcPNXXcaT05hevbb9H8Me9yG1v2NJvkIIjkA=;
        b=R+MmfcjDGn9Fs62rjn69bD708FityCrtnfa+QZqh5BCDDE9mdONr/CDTv8f//0Ps1D
         QaUk4i2Wq5i1Eb0l59C/RuX+cZ3m09x/lhFOk7Awm7grE8zeOiPlboOCgKfAgwHQumP0
         4cFOxty/KsbF5rK8gY6ViYBmb4W3gMYic+zrWF56EO3TkJHLsheFA1gVmQheExtpGFUv
         brxw+YkAkshwvipYg6LErLDrv5ec/an/cAbHRFKuUDlvOVo+vawmRNQ0sZFvJbVd3QrP
         Vyms8Lh58ddeBm3L1B+ebAuMQSqhUrGVkJZ4dpDorPKb9W6yk9Fno2bcqrlG2cg5Q/UY
         tRwA==
X-Gm-Message-State: AOAM530VhBLSQYirTq8WgUutefjNo57kgZSQY96keM0CWoeisg+S/j7L
        8adiYflR/QllgOgLHIYXiwa/6kTKXlo=
X-Google-Smtp-Source: ABdhPJw+PiXsy0MKqJ3w7Vs34mrvwGgRYxyVieSSZ00oByvZkkq9YxtNBSCx0O8zGOK5TSoKcQDREA==
X-Received: by 2002:a7b:c842:: with SMTP id c2mr4437915wml.100.1611328596518;
        Fri, 22 Jan 2021 07:16:36 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g14sm13825345wru.45.2021.01.22.07.16.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jan 2021 07:16:35 -0800 (PST)
Message-Id: <pull.872.git.git.1611328595003.gitgitgadget@gmail.com>
From:   "Vladimir Chigarev via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 22 Jan 2021 15:16:34 +0000
Subject: [PATCH] gitk: add option to perform 'git fetch' command
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Vladimir Chigarev <chiga17@mail.ru>,
        Vladimir Chigarev <chiga17@mail.ru>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Vladimir Chigarev <chiga17@mail.ru>

There wasn't ability to perform 'git fetch' from gitk tool.
Add 'Fetch' option to 'File' menu.
Bind it to 'F7' key.

Signed-off-by: Vladimir Chigarev <chiga17@mail.ru>
---
    gitk: add option to perform 'git fetch' command
    
    There wasn't ability to perform 'git fetch' from gitk tool. Add 'Fetch'
    option to 'File' menu. Bind it to 'F7' key.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-872%2Fchiga17%2Fgitk-fetch-option-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-872/chiga17/gitk-fetch-option-v1
Pull-Request: https://github.com/git/git/pull/872

 gitk-git/gitk | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/gitk-git/gitk b/gitk-git/gitk
index 23d9dd1fe0d..1756385886f 100755
--- a/gitk-git/gitk
+++ b/gitk-git/gitk
@@ -499,6 +499,34 @@ proc getcommits {selid} {
     }
 }
 
+proc fetch {} {
+    global bgcolor NS fetch_output
+
+    set fetch_output {}
+    if {[catch {exec sh -c "git fetch -v 2>&1"} fetch_output]} {
+    }
+
+    set w .about
+    if {[winfo exists $w]} {
+	raise $w
+	return
+    }
+    ttk_toplevel $w
+    wm title $w [mc "Fetch"]
+    make_transient $w .
+    message $w.m -text [mc " $fetch_output "] \
+	    -justify left -aspect 600 -border 2 -bg $bgcolor -relief groove
+    pack $w.m -side top -fill x -padx 2 -pady 2
+    ${NS}::button $w.ok -text [mc "Close"] -command "destroy $w" -default active
+    pack $w.ok -side bottom
+    bind $w <Visibility> "focus $w.ok"
+    bind $w <Key-Escape> "destroy $w"
+    bind $w <Key-Return> "destroy $w"
+    tk::PlaceWindow $w widget .
+
+    reloadcommits
+}
+
 proc updatecommits {} {
     global curview vcanopt vorigargs vfilelimit viewinstances
     global viewactive viewcomplete tclencoding
@@ -2089,6 +2117,7 @@ proc makewindow {} {
         mc "&File" cascade {
             {mc "&Update" command updatecommits -accelerator F5}
             {mc "&Reload" command reloadcommits -accelerator Shift-F5}
+            {mc "&Fetch" command fetch -accelerator F7}
             {mc "Reread re&ferences" command rereadrefs}
             {mc "&List references" command showrefs -accelerator F2}
             {xx "" separator}
@@ -2609,6 +2638,7 @@ proc makewindow {} {
     bindkey f nextfile
     bind . <F5> updatecommits
     bindmodfunctionkey Shift 5 reloadcommits
+    bind . <F7> fetch
     bind . <F2> showrefs
     bindmodfunctionkey Shift 4 {newview 0}
     bind . <F4> edit_or_newview
@@ -3125,6 +3155,7 @@ proc keys {} {
 [mc "<%s-KP->	Decrease font size" $M1T]
 [mc "<%s-minus>	Decrease font size" $M1T]
 [mc "<F5>		Update"]
+[mc "<F7>		Fetch"]
 " \
             -justify left -bg $bgcolor -border 2 -relief groove
     pack $w.m -side top -fill both -padx 2 -pady 2

base-commit: 72c4083ddf91b489b7b7b812df67ee8842177d98
-- 
gitgitgadget
