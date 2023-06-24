Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F76FC0015E
	for <git@archiver.kernel.org>; Sat, 24 Jun 2023 21:24:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229730AbjFXVX7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 24 Jun 2023 17:23:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbjFXVXx (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Jun 2023 17:23:53 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E9CB1728
        for <git@vger.kernel.org>; Sat, 24 Jun 2023 14:23:52 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id d75a77b69052e-3ff274778feso17310161cf.1
        for <git@vger.kernel.org>; Sat, 24 Jun 2023 14:23:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687641831; x=1690233831;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vLoTKRHvRu/cqozWc4zHiX93G9XPhpyZWEI7EE21eUs=;
        b=YXdS7ioFLiqZ/jijp4JyzQoCXhOC2y9vZRvN7fza4wVOE7hI6Ua4HWPPHtaPX5i2Hf
         fmrsUsBabBNym85BrHAMdYTAzjU2d0jSY2ohro0EPPAebVHXxoeLYfhzaV8VgPE6amal
         mx/49TEJ5rEssUw0E3tYiSt6A4Lk1xO1N7BoPAQbTbG/8ub/2M7j9b2hAkjyIZaO33Sh
         JMyNAQb9rK0AT2EhTFHJEIU71/nL27wteDm4/HuPdd1HvNsmAzWgx0lR8e+f2fd861G2
         Anj6EQde0CekLqHrbYPpzzSv3PXEo9KqJPpbQjjmlEU/PHqQGPSWTgg069jS9oYAI/uG
         YqOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687641831; x=1690233831;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vLoTKRHvRu/cqozWc4zHiX93G9XPhpyZWEI7EE21eUs=;
        b=i5g9QjOKFv74RoPgVFVe09c98uZl5LiDr2WRiMxwr+fVgsYvuIZw7ZuLualdB6c/fj
         KQ9BnZMv3sHjUWva0kRoe202nnCSQlS9qfvfhbZhjWOoDcjG7Wb+cvDlBEf8DTN6OyUD
         ZWMydMcQTQ2mQGzs7zPRm2c4HWQQKJWDPHN182TLnIL2miHkRy+CUg71WiDUbLD7hn4w
         8geKIcFt2a85QEQV/J858qBCF8jSv2G5PlOqdtmyvgbsXCnWSTYtHvcqT7fPxU6ZFIl+
         KOVPlP83YklQed8XHuON1Xx7FkcAP90cSXlcHkFRWmRLnK68QO4S15TBFRlFlmKVyVvn
         fTEg==
X-Gm-Message-State: AC+VfDwJbyX08q0D9rZLmb5LyzHQS2s7XVpnXBeP+tg3mWPdyckoe87G
        r6HL/+iiA8uOwckhSFT0LqVfBEiI2SMYmA==
X-Google-Smtp-Source: ACHHUZ4URpJIDpp/5Hyt8f81cHXphvwdlkvfA5QqFGIdsWFqfgNSnOktPB7ZNIajYVMUGwB/jaug9Q==
X-Received: by 2002:ac8:4e96:0:b0:400:8580:101a with SMTP id 22-20020ac84e96000000b004008580101amr6825693qtp.15.1687641831477;
        Sat, 24 Jun 2023 14:23:51 -0700 (PDT)
Received: from markl5i.lan ([2600:4040:266e:4d00::387])
        by smtp.gmail.com with ESMTPSA id x15-20020ac87ecf000000b003fdd34c6babsm1118182qtj.76.2023.06.24.14.23.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Jun 2023 14:23:51 -0700 (PDT)
From:   Mark Levedahl <mlevedahl@gmail.com>
To:     git@vger.kernel.org
Cc:     adam@dinwoodie.org, me@yadavpratyush.com,
        johannes.schindelin@gmx.de, Mark Levedahl <mlevedahl@gmail.com>
Subject: [PATCH v0 4/4] git-gui - use mkshortcut on Cygwin
Date:   Sat, 24 Jun 2023 17:23:47 -0400
Message-ID: <20230624212347.179656-5-mlevedahl@gmail.com>
X-Mailer: git-send-email 2.41.0.99.19
In-Reply-To: <20230624212347.179656-1-mlevedahl@gmail.com>
References: <20230624212347.179656-1-mlevedahl@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Prior to 2012, git-gui enabled the "Repository->Create Desktop Icon"
item on Cygwin, offering to create a shortcut that starts git-gui on a
particular repository. The original code for this in lib/win32.tcl,
shared with Git for Windows support, requires Windows pathnames, while
git-gui must use unix pathnames with the unix/X11 Tcl/Tk since 2012. The
ability to use this from Cygwin was removed in a previous patch.

Cygwin's default installation provides /bin/mkshortcut for creating
desktop shortuts, this is compatible with exec under tcl, and understands
Cygwin's unix pathnames. So, teach git-gui to use mkshortcut on Cygwin,
leaving lib/win32.tcl as Git for Windows specific support.

Notes: "CHERE_INVOKING=1" is recognized by Cygwin's /etc/profile and
prevents a "chdir $HOME", leaving the shell in the working directory
specified by the shortcut. That directory is written directly by
mkshortcut eliminating any problems with shell escapes and quoting.

The pre-2012 code includes the full pathname of the git-gui creating the
shortcut (rather than using the system git-gui), but that git-gui might
not be compatible with the git found after /etc/profile sets the path,
and might have a pathname that defies encoding using shell escapes that
can survive the multiple incompatible interpreters involved in this
chain. Instead, use "git gui", thus defaulting to the system git and
avoiding both issues.

Signed-off-by: Mark Levedahl <mlevedahl@gmail.com>
---
 git-gui.sh       |  4 ++++
 lib/shortcut.tcl | 38 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 42 insertions(+)

diff --git a/git-gui.sh b/git-gui.sh
index 523770a..5c13521 100755
--- a/git-gui.sh
+++ b/git-gui.sh
@@ -2836,6 +2836,10 @@ if {[is_enabled multicommit]} {
 		.mbar.repository add command \
 			-label [mc "Create Desktop Icon"] \
 			-command do_windows_shortcut
+	} elseif {[is_Cygwin]} {
+		.mbar.repository add command \
+			-label [mc "Create Desktop Icon"] \
+			-command do_cygwin_shortcut
 	} elseif {[is_MacOSX]} {
 		.mbar.repository add command \
 			-label [mc "Create Desktop Icon"] \
diff --git a/lib/shortcut.tcl b/lib/shortcut.tcl
index 1d8374b..6c2a99e 100644
--- a/lib/shortcut.tcl
+++ b/lib/shortcut.tcl
@@ -26,6 +26,44 @@ proc do_windows_shortcut {} {
 	}
 }
 
+proc do_cygwin_shortcut {} {
+	global argv0 _gitworktree oguilib
+
+	if {[catch {
+		set desktop [exec cygpath \
+			--desktop]
+		}]} {
+			set desktop .
+	}
+	set fn [tk_getSaveFile \
+		-parent . \
+		-title [mc "%s (%s): Create Desktop Icon" [appname] [reponame]] \
+		-initialdir $desktop \
+		-initialfile "Git [reponame].lnk"]
+	if {$fn != {}} {
+		if {[file extension $fn] ne {.lnk}} {
+			set fn ${fn}.lnk
+		}
+		if {[catch {
+				set repodir [file normalize $_gitworktree]
+				set shargs {-c \
+					"CHERE_INVOKING=1 \
+					source /etc/profile; \
+					git gui"}
+				exec /bin/mkshortcut.exe \
+					-a $shargs \
+					-d "git-gui on $repodir" \
+					-i $oguilib/git-gui.ico \
+					-n $fn \
+					-s min \
+					-w $repodir \
+					/bin/sh.exe
+			} err]} {
+			error_popup [strcat [mc "Cannot write shortcut:"] "\n\n$err"]
+		}
+	}
+}
+
 proc do_macosx_app {} {
 	global argv0 env
 
-- 
2.41.0.99.19

