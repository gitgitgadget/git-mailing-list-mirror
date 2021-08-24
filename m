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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D007C4338F
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 12:18:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0271061248
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 12:18:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236907AbhHXMTf (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Aug 2021 08:19:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230132AbhHXMTd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Aug 2021 08:19:33 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D032C061757
        for <git@vger.kernel.org>; Tue, 24 Aug 2021 05:18:49 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id v10so19792770wrd.4
        for <git@vger.kernel.org>; Tue, 24 Aug 2021 05:18:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=8gkqgOzmjrTGebifd/CyRcg4sriSUNDLDIaIzywHSfw=;
        b=MyD8CPmS9jit/AQS4lbd4Ie7PPwLZCkmC83BjN1ed7o05CTU7eyitzS14dOq1ei60A
         FsG3A2ohA4g9/zeAemaKnjjAHUCRZqZqHcOKhDP2E7Cs7o/KfWnWxWKNJ43dcDyKT6ts
         MFjepbGm3daKOe/9Ecfz+JQ4nixZQWKVKPrdAlKSaNWmx4MX2j3z/oDeHvEJKzEyXmi6
         D5+GpUur48GsEhqKlcyclZ7axFdj0x6JfWB5uANzxcRvNoZbccmctt3XMPq3nBDmcN8p
         duvpG14mOGj+vTyK2f7IX0XTOyb2ibwg1XD7AWSpE1HVL6zKnI02e+hSS1NF2hTSdfZG
         hd/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=8gkqgOzmjrTGebifd/CyRcg4sriSUNDLDIaIzywHSfw=;
        b=aAiJSZmDIQEo+EhozzAuLjdebeWn4UsTuww+szZ5zPCbB1C7Sw7iduKwfDg9tXZt1r
         XawqsR4vX2mt7XeL2aCb8MxxAf5wQtqRDBokWpYS7he2xP7Bqqxg82wB8qkzA3nnsj+8
         2vEEBIcBicH161saFicplTSngngmQYSVu4b02n5QG8lU5/QF4YTjCHzdoAY+kAjQj2q3
         B49363P5zOD1wdd47/e+Z1tpt9NqSdopiII8gJiPcK6evAv8f/lbZhHcvDouUwdr7oJ8
         Yeh8KK8TaUt1fnQmU/BMkX3zOkVl5TsbYtfi5uumULIWYa2O5O7eBc3adwWANAWQTOgM
         gjAQ==
X-Gm-Message-State: AOAM5332keho66U76hBWt6frIgGGl0I/5wWaXVx3H80lO9w/pFTHcxr8
        ++fcvKZ2PRpWL50Tbqi3ztnsYHn292o=
X-Google-Smtp-Source: ABdhPJwNuWE9DyIJGUFrbyYZ+FP+Ul11BXAK0ponP1IfRZeXmKyPpoD8+SqHteaiyFpb6KovpvxaTA==
X-Received: by 2002:adf:f290:: with SMTP id k16mr18945728wro.88.1629807527867;
        Tue, 24 Aug 2021 05:18:47 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j1sm14636950wrd.50.2021.08.24.05.18.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Aug 2021 05:18:47 -0700 (PDT)
Message-Id: <pull.1023.git.1629807526939.gitgitgadget@gmail.com>
From:   "Tal Kelrich via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 24 Aug 2021 12:18:46 +0000
Subject: [PATCH] gitk: new option to hide prefetch refs
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Paul Mackerras <paulus@ozlabs.org>,
        Tal Kelrich <hasturkun@gmail.com>,
        Tal Kelrich <hasturkun@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Tal Kelrich <hasturkun@gmail.com>

The maintenance 'prefetch' task creates refs that mirror remote refs,
and in repositories with many branches this can clutter the commit list.

Add a new option to ignore any prefetch refs, enabled by default.

Signed-off-by: Tal Kelrich <hasturkun@gmail.com>
---
    gitk: new option to hide prefetch refs
    
    Adding a new option for gitk to ignore prefetch refs, as these clutter
    the commit list on repositories with many branches.
    
    This defaults to being enabled, as I would expect users usually wouldn't
    want to see these.
    
    It might have been better to allow gitk to read log.excludeDecoration
    (or a gitk specific configured pattern) and use that to ignore refs, but
    this was simpler for me to implement without knowing Tcl.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1023%2Fhasturkun%2Fgitk-ignore-prefetch-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1023/hasturkun/gitk-ignore-prefetch-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1023

 gitk-git/gitk | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/gitk-git/gitk b/gitk-git/gitk
index 23d9dd1fe0d..4e44da517f2 100755
--- a/gitk-git/gitk
+++ b/gitk-git/gitk
@@ -1780,6 +1780,7 @@ proc readrefs {} {
     global selecthead selectheadid
     global hideremotes
     global tclencoding
+    global hideprefetch
 
     foreach v {tagids idtags headids idheads otherrefids idotherrefs} {
         unset -nocomplain $v
@@ -1814,6 +1815,7 @@ proc readrefs {} {
             }
             set tagids($name) $id
             lappend idtags($id) $name
+        } elseif {[string match "prefetch/*" $name] && $hideprefetch} {
         } else {
             set otherrefids($name) $id
             lappend idotherrefs($id) $name
@@ -11548,7 +11550,7 @@ proc create_prefs_page {w} {
 proc prefspage_general {notebook} {
     global NS maxwidth maxgraphpct showneartags showlocalchanges
     global tabstop limitdiffs autoselect autosellen extdifftool perfile_attrs
-    global hideremotes want_ttk have_ttk maxrefs web_browser
+    global hideremotes want_ttk have_ttk maxrefs web_browser hideprefetch
 
     set page [create_prefs_page $notebook.general]
 
@@ -11572,6 +11574,9 @@ proc prefspage_general {notebook} {
     ${NS}::checkbutton $page.hideremotes -text [mc "Hide remote refs"] \
         -variable hideremotes
     grid x $page.hideremotes -sticky w
+    ${NS}::checkbutton $page.hideprefetch -text [mc "Hide prefetch refs"] \
+        -variable hideprefetch
+    grid x $page.hideprefetch -sticky w
 
     ${NS}::label $page.ddisp -text [mc "Diff display options"]
     grid $page.ddisp - -sticky w -pady 10
@@ -11696,7 +11701,7 @@ proc doprefs {} {
     global oldprefs prefstop showneartags showlocalchanges
     global uicolor bgcolor fgcolor ctext diffcolors selectbgcolor markbgcolor
     global tabstop limitdiffs autoselect autosellen extdifftool perfile_attrs
-    global hideremotes want_ttk have_ttk
+    global hideremotes want_ttk have_ttk hideprefetch
 
     set top .gitkprefs
     set prefstop $top
@@ -11705,7 +11710,8 @@ proc doprefs {} {
         return
     }
     foreach v {maxwidth maxgraphpct showneartags showlocalchanges \
-                   limitdiffs tabstop perfile_attrs hideremotes want_ttk} {
+                   limitdiffs tabstop perfile_attrs hideremotes want_ttk \
+                   hideprefetch} {
         set oldprefs($v) [set $v]
     }
     ttk_toplevel $top
@@ -11831,7 +11837,8 @@ proc prefscan {} {
     global oldprefs prefstop
 
     foreach v {maxwidth maxgraphpct showneartags showlocalchanges \
-                   limitdiffs tabstop perfile_attrs hideremotes want_ttk} {
+                   limitdiffs tabstop perfile_attrs hideremotes want_ttk \
+                   hideprefetch} {
         global $v
         set $v $oldprefs($v)
     }
@@ -11845,7 +11852,7 @@ proc prefsok {} {
     global oldprefs prefstop showneartags showlocalchanges
     global fontpref mainfont textfont uifont
     global limitdiffs treediffs perfile_attrs
-    global hideremotes
+    global hideremotes hideprefetch
 
     catch {destroy $prefstop}
     unset prefstop
@@ -11891,7 +11898,8 @@ proc prefsok {} {
           $limitdiffs != $oldprefs(limitdiffs)} {
         reselectline
     }
-    if {$hideremotes != $oldprefs(hideremotes)} {
+    if {$hideremotes != $oldprefs(hideremotes) ||
+          $hideprefetch != $oldprefs(hideprefetch)} {
         rereadrefs
     }
 }
@@ -12365,6 +12373,7 @@ set cmitmode "patch"
 set wrapcomment "none"
 set showneartags 1
 set hideremotes 0
+set hideprefetch 1
 set maxrefs 20
 set visiblerefs {"master"}
 set maxlinelen 200
@@ -12477,7 +12486,7 @@ set config_variables {
     filesepbgcolor filesepfgcolor linehoverbgcolor linehoverfgcolor
     linehoveroutlinecolor mainheadcirclecolor workingfilescirclecolor
     indexcirclecolor circlecolors linkfgcolor circleoutlinecolor diffbgcolors
-    web_browser
+    web_browser hideprefetch
 }
 foreach var $config_variables {
     config_init_trace $var

base-commit: 225bc32a989d7a22fa6addafd4ce7dcd04675dbf
-- 
gitgitgadget
