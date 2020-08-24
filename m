Return-Path: <SRS0=3swP=CC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36047C433E1
	for <git@archiver.kernel.org>; Mon, 24 Aug 2020 15:50:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B7872071E
	for <git@archiver.kernel.org>; Mon, 24 Aug 2020 15:50:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gLhjomYc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728024AbgHXPum (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Aug 2020 11:50:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727877AbgHXPtM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Aug 2020 11:49:12 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2963C061573
        for <git@vger.kernel.org>; Mon, 24 Aug 2020 08:49:01 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id ba10so8508643edb.3
        for <git@vger.kernel.org>; Mon, 24 Aug 2020 08:49:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rpHqLOLfCufiNldSzGi0xWICLXcMU99TUpTLyJpCU1w=;
        b=gLhjomYcS21ED03dk3xG4v+JBMRDzfaFP9tYXor5aO+94f20gpld8SL6B4Dp1dm3nt
         7rpkkwI6PVYUq9IQfnNVV9EjEfz0C2bb/SFSZtmKn2RWYi3r2w2JbtDHsmm+xB7B9ht4
         LY4jXBiAwRc02FiEfoEe7YzLfKbjU9LaKjjao/kmL5O/iv5payCUxg6tcitIDUFFkaeh
         837woz07UeK85WxBA+halsYGdUGOZfWlTT06fNF48l1Pf53Afb1074B/5iCtZ/7MjDJ8
         S7x2PZXTogqfyZmfBaaOBMGKjhLCn2q4snlcxtRhzeJvPJ+uM5NWU55Nlvb1jaZrM4it
         V0wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rpHqLOLfCufiNldSzGi0xWICLXcMU99TUpTLyJpCU1w=;
        b=axWFHv9+vj2Ce6QzW3S5rOLYMit7ycAHJJJFd+TmqAck6WveU66ZW5q222ms+xTAp7
         Qkna3GG4Jh6xaKVVnn1ccTdu/Culue0+MgkNgAj47CFNrGDlz2LZuDFp93qXRxwUqYKG
         Ax4ejL3Ok7K1yKCICt141tMmBV7q2QTJBqumSylQKu8MRetOBfucZvuYCtvSnvBE7Q3e
         Av1XiHckFxMg8XwThDAdNNj29czrwxfKeQNH1jA+1SXXH3dBuyUfDbXH++T/DPYgSh4V
         Vti4uOxy3kMej0WU3pSrTK6O5+QvRYeBmirMf2jN65eGtWnisX2FmL8mwGP9F0N/ndNR
         8lWQ==
X-Gm-Message-State: AOAM5335t+alWXFDdzcKNIs6a+Ff8Bp5Qefd3s9O8E+HFBf5s/f3UXjC
        3GysV7vScOt3A7ZZkwUVvBUvUCwV/Qr8yg==
X-Google-Smtp-Source: ABdhPJxrTKBpsZkM0lsBd9cU8qQknMfqLCcawaPwGttuuMNPo9OztyWV/ZaM01GBBymdrD9ZBFihhg==
X-Received: by 2002:aa7:dc58:: with SMTP id g24mr5016679edu.344.1598284140285;
        Mon, 24 Aug 2020 08:49:00 -0700 (PDT)
Received: from partizan.lan ([46.98.122.217])
        by smtp.gmail.com with ESMTPSA id s21sm10546182ejc.16.2020.08.24.08.48.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2020 08:48:59 -0700 (PDT)
From:   Serg Tereshchenko <serg.partizan@gmail.com>
To:     git@vger.kernel.org
Cc:     Serg Tereshchenko <serg.partizan@gmail.com>
Subject: [PATCH] git-gui: Basic dark mode support
Date:   Mon, 24 Aug 2020 18:48:35 +0300
Message-Id: <20200824154835.160749-1-serg.partizan@gmail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi all.

I want to use dark themes with git citool, and here is my first attempt
to do so.

I am new to tcl, so i happily accept any tips on how to improve code.

First things first: to properly support colors, would be nice to have
them separated from app code, so i created new file lib/colored.tcl. Name
is selected to be consistent with "lib/themed.tcl".

Then, i extract hardcoded colors from git-gui.sh into namespace Color.
Then, if option use_ttk is true, i update default colors for
background/foreground from current theme.

How it was looking before:
 - Dark theme (awdark): https://i.imgur.com/0lrfHyq.png
 - Light theme (clam): https://i.imgur.com/1fsfayJ.png

Now looks like this:
 - Dark theme (awdark): https://i.imgur.com/BISllEH.png
 - Light theme (clam): https://i.imgur.com/WclSTa4.png

One problem that i can't yet fix: gray background for files in
changelists. Any advice on this?


I would be happy to move color definitions from git-gui.sh to
themed.tcl, so we can set it once, and not for each ttext call. Do you
think this is a good idea now or in the future?

I see some work is already done in that direction, like lib/themed.tcl:gold_frame.


Kind Regards.

Signed-off-by: Serg Tereshchenko <serg.partizan@gmail.com>
---
 git-gui.sh      | 33 +++++++++++++++++++--------------
 lib/colored.tcl | 23 +++++++++++++++++++++++
 2 files changed, 42 insertions(+), 14 deletions(-)
 create mode 100644 lib/colored.tcl

diff --git a/git-gui.sh b/git-gui.sh
index ca66a8e..cffd106 100755
--- a/git-gui.sh
+++ b/git-gui.sh
@@ -861,6 +861,7 @@ proc apply_config {} {
 			set NS ttk
 			bind [winfo class .] <<ThemeChanged>> [list InitTheme]
 			pave_toplevel .
+			Color::syncColorsWithTheme
 		}
 	}
 }
@@ -3273,9 +3274,13 @@ pack .vpane -anchor n -side top -fill both -expand 1
 # -- Working Directory File List
 
 textframe .vpane.files.workdir -height 100 -width 200
-tlabel .vpane.files.workdir.title -text [mc "Unstaged Changes"] \
-	-background lightsalmon -foreground black
-ttext $ui_workdir -background white -foreground black \
+tlabel .vpane.files.workdir.title \
+	-text [mc "Unstaged Changes"] \
+	-background $Color::lightRed \
+	-foreground $Color::textOnLight
+ttext $ui_workdir \
+	-background $Color::textBg \
+	-foreground $Color::textColor \
 	-borderwidth 0 \
 	-width 20 -height 10 \
 	-wrap none \
@@ -3296,8 +3301,8 @@ pack $ui_workdir -side left -fill both -expand 1
 textframe .vpane.files.index -height 100 -width 200
 tlabel .vpane.files.index.title \
 	-text [mc "Staged Changes (Will Commit)"] \
-	-background lightgreen -foreground black
-ttext $ui_index -background white -foreground black \
+	-background $Color::lightGreen -foreground $Color::textOnLight
+ttext $ui_index -background $Color::textBg -foreground $Color::textColor \
 	-borderwidth 0 \
 	-width 20 -height 10 \
 	-wrap none \
@@ -3432,7 +3437,7 @@ if {![is_enabled nocommit]} {
 }
 
 textframe .vpane.lower.commarea.buffer.frame
-ttext $ui_comm -background white -foreground black \
+ttext $ui_comm -background $Color::textBg -foreground $Color::textColor \
 	-borderwidth 1 \
 	-undo true \
 	-maxundo 20 \
@@ -3519,19 +3524,19 @@ trace add variable current_diff_path write trace_current_diff_path
 
 gold_frame .vpane.lower.diff.header
 tlabel .vpane.lower.diff.header.status \
-	-background gold \
-	-foreground black \
+	-background $Color::lightGold \
+	-foreground $Color::textOnLight \
 	-width $max_status_desc \
 	-anchor w \
 	-justify left
 tlabel .vpane.lower.diff.header.file \
-	-background gold \
-	-foreground black \
+	-background $Color::lightGold \
+	-foreground $Color::textOnLight \
 	-anchor w \
 	-justify left
 tlabel .vpane.lower.diff.header.path \
-	-background gold \
-	-foreground blue \
+	-background $Color::lightGold \
+	-foreground $Color::lightBlue \
 	-anchor w \
 	-justify left \
 	-font [eval font create [font configure font_ui] -underline 1] \
@@ -3561,7 +3566,7 @@ bind .vpane.lower.diff.header.path <Button-1> {do_file_open $current_diff_path}
 #
 textframe .vpane.lower.diff.body
 set ui_diff .vpane.lower.diff.body.t
-ttext $ui_diff -background white -foreground black \
+ttext $ui_diff -background $Color::textBg -foreground $Color::textColor \
 	-borderwidth 0 \
 	-width 80 -height 5 -wrap none \
 	-font font_diff \
@@ -3589,7 +3594,7 @@ foreach {n c} {0 black 1 red4 2 green4 3 yellow4 4 blue4 5 magenta4 6 cyan4 7 gr
 $ui_diff tag configure clr1 -font font_diffbold
 $ui_diff tag configure clr4 -underline 1
 
-$ui_diff tag conf d_info -foreground blue -font font_diffbold
+$ui_diff tag conf d_info -foreground $Color::lightBlue -font font_diffbold
 
 $ui_diff tag conf d_cr -elide true
 $ui_diff tag conf d_@ -font font_diffbold
diff --git a/lib/colored.tcl b/lib/colored.tcl
new file mode 100644
index 0000000..fdb3f9c
--- /dev/null
+++ b/lib/colored.tcl
@@ -0,0 +1,23 @@
+# Color configuration support for git-gui.
+
+namespace eval Color {
+	# static colors
+	variable lightRed		lightsalmon
+	variable lightGreen		green
+	variable lightGold		gold
+	variable lightBlue		blue
+	variable textOnLight	black
+	variable textOnDark		white
+	# theme colors
+	variable interfaceBg	lightgray
+	variable textBg			white
+	variable textColor		black
+
+	proc syncColorsWithTheme {} {
+		set Color::interfaceBg	[ttk::style lookup Entry -background]
+		set Color::textBg		[ttk::style lookup Treeview -background]
+		set Color::textColor	[ttk::style lookup Treeview -foreground]
+
+		tk_setPalette $Color::interfaceBg
+	}
+}
-- 
2.28.0

