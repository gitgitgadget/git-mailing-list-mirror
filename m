Return-Path: <SRS0=cd4n=56=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B7CEC2BB1D
	for <git@archiver.kernel.org>; Tue, 14 Apr 2020 21:46:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 15B7020767
	for <git@archiver.kernel.org>; Tue, 14 Apr 2020 21:46:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m8PTqgIr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2634134AbgDNVp6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Apr 2020 17:45:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2634122AbgDNVpk (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 14 Apr 2020 17:45:40 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FBFEC061A0C
        for <git@vger.kernel.org>; Tue, 14 Apr 2020 14:45:37 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id e26so14837620wmk.5
        for <git@vger.kernel.org>; Tue, 14 Apr 2020 14:45:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=P+ddMxgkPNOS8cTuwOraqhg91ajQv9npoxVn4y9yfHM=;
        b=m8PTqgIrgIg/FufkWh+w5lp+vDZzQImzqrW3IeMzt8G1e6xqMu0CdzWZ4NZEzhfuw2
         kNHqZWUNE38XlQeh866KuzhdW6ZdKwEN2Q9r1+fuXFNBKqNWBly11TeZdh6e2rvW3T6s
         GDglFSgSmLTmux1cIZJ/Fh7rOA+ND/FX7GZWYkAzoHdXCWmmVKbDaDWiv1/hU7CtbqAQ
         fCQJ4qDg8g66VNJIoaR1Q6GiUagodilEZd3U5PfUD7R8H3RVdVUIBgrQy1lddxwPlC8P
         OlcugFnJG+ciNPsCVff11FPA7DTtxJYFgFWVFZd1/tj4CerZpaCRudiQxKPTaQsRwWFf
         gbrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=P+ddMxgkPNOS8cTuwOraqhg91ajQv9npoxVn4y9yfHM=;
        b=U53SLgvRRkyciXs76oQxVJpuIMtEETWl0uhjBM07kiXHX5cjljULauZihxGdw/2UUX
         XMPW/IitMa+Qr2qYYXP+IupdREyO81wkW1x6GjQ4PishdNpawWoplsbF/akhXC2xV2H8
         RdUVNoIrYlkwJRdmnrGHJC7IK2SgUEIzb9hiHEQTfOm9rumshpidR2clpoXpmgdlFy2F
         C5u1KW83IS0Vh/T/Lx0+SWUZof/pyJVuEJBejBZ2abfEYsyiCY3FUO56iRakoNEfPMtu
         9LEKzdCUQ21Ck5Emj1hpwE4FewtfRXMlsreJrkeQoDNbtJ+8gE0LNu+u7auvUeRGbk8C
         CXQw==
X-Gm-Message-State: AGi0PuaD7dTUvpbn3TQknIVuhbDDZX+E9NmeGd2M/zp/NcyhZ/OoYXZK
        EzS/V97zBL0atRz9snnyw5UqYz0H
X-Google-Smtp-Source: APiQypKM9avueu5iC/XX7YhAFG0K1DrAJfBuFg0XRw6Tx+a+B/SqGKLY5OQmBjjuKDgo1u0oOMlN9A==
X-Received: by 2002:a7b:c5d8:: with SMTP id n24mr1805683wmk.158.1586900735728;
        Tue, 14 Apr 2020 14:45:35 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n11sm21843627wrg.72.2020.04.14.14.45.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2020 14:45:35 -0700 (PDT)
Message-Id: <pull.612.git.1586900734341.gitgitgadget@gmail.com>
From:   "Konstantin Podsvirov via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 14 Apr 2020 21:45:34 +0000
Subject: [PATCH] git-gui: msys2 compatibility patches
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Konstantin Podsvirov <konstantin@podsvirov.pro>,
        Pratyush Yadav <me@yadavpratyush.com>,
        Konstantin Podsvirov <konstantin@podsvirov.pro>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Konstantin Podsvirov <konstantin@podsvirov.pro>

Allow using `git gui` command via MSYS2's MINGW32/64 subsystems (apropriate shells).

Just install apropriate `tk` package:

```bash
user@host MINGW32 ~
pacman -S mingw-w64-i686-tk
```

or

```bash
user@host MINGW64 ~
pacman -S mingw-w64-x86_64-tk
```

For more info see: https://github.com/msys2/MSYS2-packages/pull/1912

Signed-off-by: Konstantin Podsvirov <konstantin@podsvirov.pro>
---
    git-gui: msys2 compatibility patches
    
    Allow using git gui command via MSYS2's MINGW32/64 subsystems
    (apropriate shells).
    
    Just install apropriate tk package:
    
    user@host MINGW32 ~
    pacman -S mingw-w64-i686-tk
    
    or
    
    user@host MINGW64 ~
    pacman -S mingw-w64-x86_64-tk
    
    For more info see: https://github.com/msys2/MSYS2-packages/pull/1912

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-612%2Fpodsvirov%2Fgit-gui%2Fmsys2-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-612/podsvirov/git-gui/msys2-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/612

 git-gui.sh | 52 ++++++++++++++++++++++++++++++----------------------
 1 file changed, 30 insertions(+), 22 deletions(-)

diff --git a/git-gui.sh b/git-gui.sh
index 4610e4ca72a..512f4f121aa 100755
--- a/git-gui.sh
+++ b/git-gui.sh
@@ -44,6 +44,28 @@ if {[catch {package require Tcl 8.5} err]
 
 catch {rename send {}} ; # What an evil concept...
 
+######################################################################
+##
+## platform detection
+
+set _iscygwin {}
+
+proc is_Cygwin {} {
+	global _iscygwin
+	if {$_iscygwin eq {}} {
+		if {$::tcl_platform(platform) eq {windows}} {
+			if {[catch {set p [exec cygpath --windir]} err]} {
+				set _iscygwin 0
+			} else {
+				set _iscygwin 1
+			}
+		} else {
+			set _iscygwin 0
+		}
+	}
+	return $_iscygwin
+}
+
 ######################################################################
 ##
 ## locate our library
@@ -51,7 +73,14 @@ catch {rename send {}} ; # What an evil concept...
 if { [info exists ::env(GIT_GUI_LIB_DIR) ] } {
 	set oguilib $::env(GIT_GUI_LIB_DIR)
 } else {
-	set oguilib {@@GITGUI_LIBDIR@@}
+	if {[is_Cygwin]} {
+		set oguilib [exec cygpath \
+			--windows \
+			--absolute \
+			@@GITGUI_LIBDIR@@]
+	} else {
+		set oguilib {@@GITGUI_LIBDIR@@}
+	}
 }
 set oguirel {@@GITGUI_RELATIVE@@}
 if {$oguirel eq {1}} {
@@ -163,7 +192,6 @@ set _isbare {}
 set _gitexec {}
 set _githtmldir {}
 set _reponame {}
-set _iscygwin {}
 set _search_path {}
 set _shellpath {@@SHELL_PATH@@}
 
@@ -266,26 +294,6 @@ proc is_Windows {} {
 	return 0
 }
 
-proc is_Cygwin {} {
-	global _iscygwin
-	if {$_iscygwin eq {}} {
-		if {$::tcl_platform(platform) eq {windows}} {
-			if {[catch {set p [exec cygpath --windir]} err]} {
-				set _iscygwin 0
-			} else {
-				set _iscygwin 1
-				# Handle MSys2 which is only cygwin when MSYSTEM is MSYS.
-				if {[info exists ::env(MSYSTEM)] && $::env(MSYSTEM) ne "MSYS"} {
-					set _iscygwin 0
-				}
-			}
-		} else {
-			set _iscygwin 0
-		}
-	}
-	return $_iscygwin
-}
-
 proc is_enabled {option} {
 	global enabled_options
 	if {[catch {set on $enabled_options($option)}]} {return 0}

base-commit: a5728022e07c53e5ac91db0960870518e243b7c1
-- 
gitgitgadget
