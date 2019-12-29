Return-Path: <SRS0=BEVv=2T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04022C2D0CE
	for <git@archiver.kernel.org>; Sun, 29 Dec 2019 19:32:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBB5D20748
	for <git@archiver.kernel.org>; Sun, 29 Dec 2019 19:32:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gjVLptOz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727048AbfL2TcO (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 29 Dec 2019 14:32:14 -0500
Received: from mail-ed1-f48.google.com ([209.85.208.48]:33158 "EHLO
        mail-ed1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726958AbfL2TcN (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Dec 2019 14:32:13 -0500
Received: by mail-ed1-f48.google.com with SMTP id r21so30776615edq.0
        for <git@vger.kernel.org>; Sun, 29 Dec 2019 11:32:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=3yrtc2gsDNFELpCRddSjHVbQqTLbLvGB7GwAdd1Y5ss=;
        b=gjVLptOzVnujbyzHJUdfdDyTvInQqYfsOJm+4dN0TfoX67gx8hw6mJuaTuXxjMMehz
         XepCbNxbVnzC15NvWyOqHtoVmBRuyNw10f/BSPaGx9qNGY7tFvxGJowXslbd/JTKMNM0
         yv3EAk8kV/rJOaYBTko7TLwkt2O6dqbnALRjmHg/GadH7Nag0OFL4zYQEVr0ToyNfphp
         deA2Lhiq0RVOg8WLSNBT3jPT38HYrCN3hfVDpY+jzcGpTC0AYq5XW6G/mOhM3j7bVX8R
         SqieRWLqkZyP4ggmawMKmY4JiC/bf3K5DjRBj0sl2xLwbDsPcD3udjeYXFpq1lmlGFeI
         C83Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=3yrtc2gsDNFELpCRddSjHVbQqTLbLvGB7GwAdd1Y5ss=;
        b=m3VsAODOHZGnxR7Kz2KoWp5wGgqefsph6oV3aQqt0HDcvXiQ7cNZc2+ggNS0kr5sTg
         VTVywhNA6h3B/cS8wHEON69pGbhc0HT5Exsamjng7b4hM7ugF+7SAM1j8VmJ8Y9OLoD2
         uhIABHD/cJLIzKvv8phIYXUDKt+MKgHq6pOZhG3BJYoA1zv/1ZA4jRJS2c/1eeWu+V/m
         M9GcViMqHWIyNiWnz34NWj4LeAxtGIip27Hs07zckTsROfzd9HQd5H1B2+l+aSqeuUup
         gkEjywUDKa/jgB3cU2OclDD09tRKtL9ZvSKkAgQvrOsgAjdcr94sVJAmvunzItlDDhZR
         Yr/w==
X-Gm-Message-State: APjAAAWaHRgB7ilYk05apKUPb/BgpGTdV2a9oDwsakYgVZjSLR4ZpvT0
        4QyDmvKbSiszUslzsP8EpQyMb/Nj
X-Google-Smtp-Source: APXvYqwELRUXlq1AXQ/2px2WDjFonur/F+XwXee7GZwepyIKlSlixwU3VQczX91Fpjfz37L5TGs5DQ==
X-Received: by 2002:a50:e046:: with SMTP id g6mr67996921edl.172.1577647932315;
        Sun, 29 Dec 2019 11:32:12 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id be18sm5044390edb.19.2019.12.29.11.32.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 29 Dec 2019 11:32:11 -0800 (PST)
Message-Id: <a6fde256f818f934beb0228db95ac551ddb5d6b1.1577647930.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.499.v2.git.1577647930.gitgitgadget@gmail.com>
References: <pull.499.git.1577386915.gitgitgadget@gmail.com>
        <pull.499.v2.git.1577647930.gitgitgadget@gmail.com>
From:   "=?UTF-8?q?Zoli=20Szab=C3=B3?= via GitGitGadget" 
        <gitgitgadget@gmail.com>
Date:   Sun, 29 Dec 2019 19:32:10 +0000
Subject: [PATCH v2 1/1] git-gui: allow opening currently selected file
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

...in the default associated app (e.g. in a text editor / IDE).

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
