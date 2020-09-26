Return-Path: <SRS0=tECa=DD=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD48EC2D0A8
	for <git@archiver.kernel.org>; Sat, 26 Sep 2020 14:55:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B7DF20882
	for <git@archiver.kernel.org>; Sat, 26 Sep 2020 14:55:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="syQS4nG3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729294AbgIZOzN (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 26 Sep 2020 10:55:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729217AbgIZOzN (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 26 Sep 2020 10:55:13 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4D04C0613CE
        for <git@vger.kernel.org>; Sat, 26 Sep 2020 07:55:12 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id b12so5440709edz.11
        for <git@vger.kernel.org>; Sat, 26 Sep 2020 07:55:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yNowKYVlp0sLsFqV32YCHqVEF87/gqfWBtksr74zavE=;
        b=syQS4nG3ZOPqw86oxw8f9WggLE2PRsBnbejUHyILrebKr+0+fw6MKVXRQY3bDa6gn+
         PpSlRPbv1K5H+/itMK1EY+U6LzF7j683V0RstfEpH3jEaU2UC9vamjWbTnbUYayjYd8t
         EwXrBKpcQ4+AEp9NkTdTnWrIbe4CUD+hy/uiZWq4kqhxSYDgJzpDYUZIO5Z8PX24e8dB
         uWR6hGej6hx/EyB0Tcoad69O6pkgUECB0FdwRvfASsnIaflzHoa7r/v3d8mHYy+kr2lW
         VwshGKcAKZlgvIz7dVZYohTe8GjBLVpjWGjbZiDonY9LIDNVnfudsQyEGckLi+8J5NJg
         qAWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yNowKYVlp0sLsFqV32YCHqVEF87/gqfWBtksr74zavE=;
        b=FBiYqcVWc4gQX+172dldd3uOqA+F/6oLewTASQQ2fdGZO1B+162xus/VXd3zv0h8A3
         1MK8bMpe+w7GwvNsHSTGYxOhV0pHJHUT84Kfd0BzVonCMxp/4nJzG+WbRo4+Tg6t4ldJ
         mvaNHIUQh6qeiBD+yn1WVg27WwyzltDIjEvOmFKdOHo0tLQPHre2KlkBPxSbJfbECfuW
         +P20KmetqToEYb12qDngyBb9XzV5Ctgd/5AAeEAGoc0nlHpyC9MYUZoRkIEMIEd/eF6z
         VmDkLTpeP0b7JTwWDZWaKsfa6UqkVq0G55ia3bM8VmVv+MxvSf5GyCXoW/5D/84mDwkN
         l62A==
X-Gm-Message-State: AOAM533lDDQuNaRKX0PAy7QT2wdg0JYK11MAd5lGlnVPCfyYRZU+aJSm
        rJzzYj5t7ymnMRoeVnQP5MGDo2WZ/iDGBw==
X-Google-Smtp-Source: ABdhPJw9dijzeEPtdY5eX99STTXLId+cvpnONC85DyDi44Kyb8NAApagB6/Hov3ahMekfmC5HwSlJA==
X-Received: by 2002:a50:c051:: with SMTP id u17mr7160690edd.39.1601132110965;
        Sat, 26 Sep 2020 07:55:10 -0700 (PDT)
Received: from partizan.lan ([46.98.122.48])
        by smtp.gmail.com with ESMTPSA id g11sm4565702edj.85.2020.09.26.07.55.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2020 07:55:10 -0700 (PDT)
From:   Serg Tereshchenko <serg.partizan@gmail.com>
To:     me@yadavpratyush.com
Cc:     git@vger.kernel.org, serg.partizan@gmail.com
Subject: [PATCH v2] git-gui: Basic dark mode support
Date:   Sat, 26 Sep 2020 17:54:43 +0300
Message-Id: <20200926145443.15423-1-serg.partizan@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200922110419.ymqj4ol76kg6qshf@yadavpratyush.com>
References: <20200922110419.ymqj4ol76kg6qshf@yadavpratyush.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Pratyush.

> Wouldn't having the contents of colored.tcl in themed.tcl be a good 
> idea? The way I see it, colors are part of the theming of the 
> application.

You are right, fixed this.

> You can set that in the function `rmsel_tag` in git-gui.sh on the line

Thanks, it worked!

>> I would be happy to move color definitions from git-gui.sh to
>> themed.tcl, so we can set it once, and not for each ttext call. Do you
>> think this is a good idea now or in the future?
>
>Do you mean to put the `-foreground` and `-background` options in the 
>function ttext in themed.tcl? If so how can a widget specify if it wants 
>a dark text or light for example?

Turns out ttext was always using black/white colors, so i just removed
it from ttext calls and used `option add` to set default colors.

And if some widget needs to different, it can be implemented like
existing gold_frame.

Or like theoretical `ttext_inverse`, which just calls ttext with
-background -foreground swapped. Or maybe we can come up with something
better. Main idea is to keep all theme-related code in themed.tcl.

> Why have `textOnLight`, `textOnDark` and `textColor` separately? My 
> guess is that it is for when you want to force light colors regardless 
> of the theme? Am I right?

Something like that, i was using it for tlabel like this:
> tlabel ... -background $Color::lightGreen -foreground $Color::textOnLight

But, it was actually not related to current task, so i just reverted
that changes and focused only on getting basic dark theme support.

> Nitpick: please use snake_case for variable names like the rest of the 
> code does. Same for the function name below and the namespace name 
> above.

Fixed. I was confused by InitTheme and InitEntryFrame.

--
Regargs,
Serg Tereshchenko

--- 8< ---
Removed forced colors in ttext widget calls,
instead using Text.Background/Foreground options.
This way colors can be configured dependent on current theme, and even
overriden by user via .Xresources.

Extracted colors for in_sel/in_diff tags into colors:: namespace,
where they can be configured from current theme colors.

Signed-off-by: Serg Tereshchenko <serg.partizan@gmail.com>
---
 git-gui.sh     | 17 +++++++++++------
 lib/themed.tcl | 38 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 49 insertions(+), 6 deletions(-)

diff --git a/git-gui.sh b/git-gui.sh
index d18b902..867b8ce 100755
--- a/git-gui.sh
+++ b/git-gui.sh
@@ -720,7 +720,9 @@ proc rmsel_tag {text} {
 		-background [$text cget -background] \
 		-foreground [$text cget -foreground] \
 		-borderwidth 0
-	$text tag conf in_sel -background lightgray
+	$text tag conf in_sel\
+		-background $color::select_bg \
+		-foreground $color::select_fg
 	bind $text <Motion> break
 	return $text
 }
@@ -863,6 +865,7 @@ proc apply_config {} {
 			set NS ttk
 			bind [winfo class .] <<ThemeChanged>> [list InitTheme]
 			pave_toplevel .
+			color::sync_with_theme
 		}
 	}
 }
@@ -3272,7 +3275,7 @@ pack .vpane -anchor n -side top -fill both -expand 1
 textframe .vpane.files.workdir -height 100 -width 200
 tlabel .vpane.files.workdir.title -text [mc "Unstaged Changes"] \
 	-background lightsalmon -foreground black
-ttext $ui_workdir -background white -foreground black \
+ttext $ui_workdir \
 	-borderwidth 0 \
 	-width 20 -height 10 \
 	-wrap none \
@@ -3294,7 +3297,7 @@ textframe .vpane.files.index -height 100 -width 200
 tlabel .vpane.files.index.title \
 	-text [mc "Staged Changes (Will Commit)"] \
 	-background lightgreen -foreground black
-ttext $ui_index -background white -foreground black \
+ttext $ui_index \
 	-borderwidth 0 \
 	-width 20 -height 10 \
 	-wrap none \
@@ -3321,7 +3324,9 @@ if {!$use_ttk} {
 
 foreach i [list $ui_index $ui_workdir] {
 	rmsel_tag $i
-	$i tag conf in_diff -background [$i tag cget in_sel -background]
+	$i tag conf in_diff \
+		-background $color::select_bg \
+		-foreground $color::select_fg
 }
 unset i
 
@@ -3429,7 +3434,7 @@ if {![is_enabled nocommit]} {
 }
 
 textframe .vpane.lower.commarea.buffer.frame
-ttext $ui_comm -background white -foreground black \
+ttext $ui_comm \
 	-borderwidth 1 \
 	-undo true \
 	-maxundo 20 \
@@ -3558,7 +3563,7 @@ bind .vpane.lower.diff.header.path <Button-1> {do_file_open $current_diff_path}
 #
 textframe .vpane.lower.diff.body
 set ui_diff .vpane.lower.diff.body.t
-ttext $ui_diff -background white -foreground black \
+ttext $ui_diff \
 	-borderwidth 0 \
 	-width 80 -height 5 -wrap none \
 	-font font_diff \
diff --git a/lib/themed.tcl b/lib/themed.tcl
index 88b3119..83e3ac7 100644
--- a/lib/themed.tcl
+++ b/lib/themed.tcl
@@ -1,6 +1,44 @@
 # Functions for supporting the use of themed Tk widgets in git-gui.
 # Copyright (C) 2009 Pat Thoyts <patthoyts@users.sourceforge.net>
 
+
+namespace eval color {
+	# Variable colors
+	# Preffered way to set widget colors is using add_option.
+	# In some cases, like with tags in_diff/in_sel, we use these colors.
+	variable select_bg		lightgray
+	variable select_fg		black
+
+	proc sync_with_theme {} {
+		set base_bg		[ttk::style lookup . -background]
+		set base_fg		[ttk::style lookup . -foreground]
+		set text_bg		[ttk::style lookup Treeview -background]
+		set text_fg		[ttk::style lookup Treeview -foreground]
+		set select_bg	[ttk::style lookup Default -selectbackground]
+		set select_fg	[ttk::style lookup Default -selectforeground]
+
+		set color::select_bg $select_bg
+		set color::select_fg $select_fg
+
+		proc add_option {key val} {
+			option add $key $val widgetDefault
+		}
+		# Add options for plain Tk widgets
+		# Using `option add` instead of tk_setPalette to avoid unintended
+		# consequences.
+		if {![is_MacOSX]} {
+			add_option *Menu.Background $base_bg
+			add_option *Menu.Foreground $base_fg
+			add_option *Menu.activeBackground $select_bg
+			add_option *Menu.activeForeground $select_fg
+		}
+		add_option *Text.Background $text_bg
+		add_option *Text.Foreground $text_fg
+		add_option *Text.HighlightBackground $base_bg
+		add_option *Text.HighlightColor $select_bg
+	}
+}
+
 proc ttk_get_current_theme {} {
 	# Handle either current Tk or older versions of 8.5
 	if {[catch {set theme [ttk::style theme use]}]} {
-- 
2.28.0

