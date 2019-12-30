Return-Path: <SRS0=o5qA=2U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAB92C2D0C2
	for <git@archiver.kernel.org>; Mon, 30 Dec 2019 15:57:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FAD4206DB
	for <git@archiver.kernel.org>; Mon, 30 Dec 2019 15:57:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JUI3vtq8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727634AbfL3P5E (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Dec 2019 10:57:04 -0500
Received: from mail-ed1-f41.google.com ([209.85.208.41]:45675 "EHLO
        mail-ed1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727588AbfL3P5D (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Dec 2019 10:57:03 -0500
Received: by mail-ed1-f41.google.com with SMTP id v28so32898951edw.12
        for <git@vger.kernel.org>; Mon, 30 Dec 2019 07:57:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=DRZyGIbXz6mOooctr4LjgXPJwOHFNdvHD3a5jZ3z0rM=;
        b=JUI3vtq8DNWE/iytFnAGn/jzLBhJxUWALAeu6iNEmLD8aIJ0HnOq2Ys6oyDyb/Somx
         PFuTuD/+egQyuUmNKPYGbDLGELA1mIBhwca+eVK/EY0R1JAlom+02q2rn+WKmpjnzRtA
         7KTv4Qnbt89plsWzvVJYwc/rrKCNAlA+VnIznPpKek/DahDxkHndA18uPf8pelDrQhwo
         sv3yb4rA6P1T1H4YtjdA7CGIx55Q9SdQcRPY7x0YAjm/qDsvWPJ4H5UlttuACXCKKy3i
         zRMScBHpdkwg87PBHt52QVSUvSDZHcYySeApAuHA4g6Wq7DHxO3FRlkqj7nI2u4t01gI
         6zjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=DRZyGIbXz6mOooctr4LjgXPJwOHFNdvHD3a5jZ3z0rM=;
        b=bl8J+Ncv8N5O61uYLVli2w/VNDz+tWThiCPFRVJ5PO1lSWBHY9O9Pknp0sPmwkdC2P
         lq9Fcxo1riDBGORi+rLGa3vHVzn3HrilHCi5H1knvGe3MRR4U76UeNU8mTk2RMnStaJW
         +QHt89cw4NzLCw4pBuYGJbGFWWsVZlsZmNtzFEv5qr546UImi93zlqPZAZVy40A+3f+8
         5+MG+w/vDjuBJGAJNjjkrC/cmhUcFfNTOTHWw42FdGnGJ5vtx+aBa4WkRKnmDeAUSuph
         Sid8WKswCaO6oR4MNx/7YgHLgbtA2m6yuu2/VC9gZIumHMHEEMJGRRACNkT4AaqGMzKV
         XCLw==
X-Gm-Message-State: APjAAAUN76JRHMg5VQzO81NivdWXBFYEU40mLv+xTzdi83QEJ5OFWdXV
        6NWStJA1If/GTuwNBGdS3gSmcb0o
X-Google-Smtp-Source: APXvYqyApQTyDPO8b6GrgI9EOsR6pPxlWCtWsrLpT+VpptIHTpKgcVrsmNwylRLwNA7pJqm8xQAjhw==
X-Received: by 2002:a50:d506:: with SMTP id u6mr64672341edi.225.1577721421811;
        Mon, 30 Dec 2019 07:57:01 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i21sm5331091edj.33.2019.12.30.07.57.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Dec 2019 07:57:01 -0800 (PST)
Message-Id: <1b2363be726c6d70746aec9fae62edaf857cd665.1577721419.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.499.v3.git.1577721419.gitgitgadget@gmail.com>
References: <pull.499.v2.git.1577647930.gitgitgadget@gmail.com>
        <pull.499.v3.git.1577721419.gitgitgadget@gmail.com>
From:   "=?UTF-8?q?Zoli=20Szab=C3=B3?= via GitGitGadget" 
        <gitgitgadget@gmail.com>
Date:   Mon, 30 Dec 2019 15:56:59 +0000
Subject: [PATCH v3 1/1] git-gui: allow opening currently selected file in
 default app
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Pratyush Yadav <me@yadavpratyush.com>,
        =?UTF-8?q?Zoli=20Szab=C3=B3?= <zoli.szabo@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: =?UTF-8?q?Zoli=20Szab=C3=B3?= <zoli.szabo@gmail.com>

Many times there's the need to quickly open a source file (the one you're
looking at in Git GUI) in the predefined text editor / IDE. Of course,
the file can be searched for in your preferred file manager or directly
in the text editor, but having the option to directly open the current
file from Git GUI would be just faster. This change enables just that by:
 - clicking the diff header path (which is now highlighted as a hyperlink)
 - or diff header path context menu -> Open;

Note: executable files will be run and not opened for editing.

Signed-off-by: Zoli Szabó <zoli.szabo@gmail.com>
---
 git-gui.sh | 29 ++++++++++++++++++++++++-----
 1 file changed, 24 insertions(+), 5 deletions(-)

diff --git a/git-gui.sh b/git-gui.sh
index c1be733e3e..8920e4ddb0 100755
--- a/git-gui.sh
+++ b/git-gui.sh
@@ -2248,9 +2248,8 @@ proc do_git_gui {} {
 	}
 }
 
-proc do_explore {} {
-	global _gitworktree
-	set explorer {}
+# Get the system-specific explorer app/command.
+proc get_explorer {} {
 	if {[is_Cygwin] || [is_Windows]} {
 		set explorer "explorer.exe"
 	} elseif {[is_MacOSX]} {
@@ -2259,9 +2258,23 @@ proc do_explore {} {
 		# freedesktop.org-conforming system is our best shot
 		set explorer "xdg-open"
 	}
+	return $explorer
+}
+
+proc do_explore {} {
+	global _gitworktree
+	set explorer [get_explorer]
 	eval exec $explorer [list [file nativename $_gitworktree]] &
 }
 
+# Open file relative to the working tree by the default associated app.
+proc do_file_open {file} {
+	global _gitworktree
+	set explorer [get_explorer]
+	set full_file_path [file join $_gitworktree $file]
+	eval exec $explorer [list [file nativename $full_file_path]] &
+}
+
 set is_quitting 0
 set ret_code    1
 
@@ -3513,9 +3526,11 @@ tlabel .vpane.lower.diff.header.file \
 	-justify left
 tlabel .vpane.lower.diff.header.path \
 	-background gold \
-	-foreground black \
+	-foreground blue \
 	-anchor w \
-	-justify left
+	-justify left \
+	-font [eval font create [font configure font_ui] -underline 1] \
+	-cursor hand2
 pack .vpane.lower.diff.header.status -side left
 pack .vpane.lower.diff.header.file -side left
 pack .vpane.lower.diff.header.path -fill x
@@ -3530,8 +3545,12 @@ $ctxm add command \
 			-type STRING \
 			-- $current_diff_path
 	}
+$ctxm add command \
+	-label [mc Open] \
+	-command {do_file_open $current_diff_path}
 lappend diff_actions [list $ctxm entryconf [$ctxm index last] -state]
 bind_button3 .vpane.lower.diff.header.path "tk_popup $ctxm %X %Y"
+bind .vpane.lower.diff.header.path <Button-1> {do_file_open $current_diff_path}
 
 # -- Diff Body
 #
-- 
gitgitgadget
