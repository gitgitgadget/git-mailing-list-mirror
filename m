Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5147CEB64D7
	for <git@archiver.kernel.org>; Mon, 26 Jun 2023 16:53:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230303AbjFZQxZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Jun 2023 12:53:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230189AbjFZQxN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Jun 2023 12:53:13 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6F9118E
        for <git@vger.kernel.org>; Mon, 26 Jun 2023 09:53:11 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id af79cd13be357-763a2e39b88so384227285a.1
        for <git@vger.kernel.org>; Mon, 26 Jun 2023 09:53:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687798391; x=1690390391;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vUUy927i6/1qe0ieek7qw27uBJO7uEn8AXIbYrS1VtY=;
        b=hygG/dUqty2XfOkAflW22hfs/iIG3JQMGFlUS69hqomToitnguGVCEr4FV0o6clR5C
         qb83Eoor0NeyE6EBi1mIQHNAt0NqvC2J74YlQ8V5ko3a1GkfUgDcxR5b5Ex5zAigR9go
         TAC+rHky4DigcAps1ngVS58wO+lQVKgln97s+ncjc2aKIhfodxP+sCklGmagOhWgEV42
         v16qaST+vwCZOwOaUXvpJjS8t2WUmcF3VQTiIiX1yJ2dMqN39rWzaaCnbSqfZthQUz4l
         7FQfm72dgjfnwDd+rD+lRwHdIzPQ7+XUFnJMijaugUWkT09NNNiiZ/Uxfs2NpQoyA8gy
         VtGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687798391; x=1690390391;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vUUy927i6/1qe0ieek7qw27uBJO7uEn8AXIbYrS1VtY=;
        b=XjQemHkRBTPEBc/3jvGJrHO02ij1at7Nc6RwwP8KM2f7Az0eC2WVx1jLNm0c5wakJx
         ZDwrRMaru0bd9WBGpPL+3/vc9BBJBFp75JsmnQLXUvQR+tESX67hdcsbd5SCKcgTMC3y
         Dy5BNRmaG4Dfo6ufwrmsHbWfcVtYfWboSHNdv/mo4VuepZsFC+P+vHH7Y43BeBhnAuor
         MDHRCWPg/VamHJzgTL2CdTkDej32AwXawAPAfvP7jRMYeoThPETgEcPxLQCfQpocoJad
         PGG+8ZsXdWEHOGjofmgp7NxkcyfI837tTreofwAOWB+V7O4+bgq2jybWIVhLB243eb4j
         YagQ==
X-Gm-Message-State: AC+VfDxFAzN1NV0S1v7cUAUnrEwpFaDoe4DJqeQViqlPjW/xZIQ6tZ4W
        OCxFZc3d5fx8JiIe5nMVmUk=
X-Google-Smtp-Source: ACHHUZ7Da3kO0dIOFuF4AIUmUXpFh5CYWuAVcIHsyIQQHfnMM20XXUJkkEFUau1APjRb75bPTU6ung==
X-Received: by 2002:a05:620a:2947:b0:765:6584:b033 with SMTP id n7-20020a05620a294700b007656584b033mr8020388qkp.50.1687798390974;
        Mon, 26 Jun 2023 09:53:10 -0700 (PDT)
Received: from markl5i.lan ([2600:4040:266e:4d00::387])
        by smtp.gmail.com with ESMTPSA id p5-20020a05620a112500b00765acdc4f56sm922819qkk.60.2023.06.26.09.53.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jun 2023 09:53:10 -0700 (PDT)
From:   Mark Levedahl <mlevedahl@gmail.com>
To:     mdl123@verizon.net, git@vger.kernel.org
Cc:     adam@dinwoodie.org, me@yadavpratyush.com,
        johannes.schindelin@gmx.de, gitster@pobox.com,
        sunshine@sunshineco.com, Mark Levedahl <mlevedahl@gmail.com>
Subject: [PATCH v1 4/4] git-gui - use mkshortcut on Cygwin
Date:   Mon, 26 Jun 2023 12:53:05 -0400
Message-ID: <20230626165305.37488-5-mlevedahl@gmail.com>
X-Mailer: git-send-email 2.41.0.99.19
In-Reply-To: <20230626165305.37488-1-mlevedahl@gmail.com>
References: <20230624212347.179656-1-mlevedahl@gmail.com>
 <20230626165305.37488-1-mlevedahl@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

git-gui enables the "Repository->Create Desktop Icon" item on Cygwin,
offering to create a shortcut that starts git-gui on the current
repository. The code in do_cygwin_shortcut invokes function
win32_create_lnk to create the shortcut. This latter function is shared
between Cygwin and Git For Windows and expects Windows rather than unix
pathnames, though do_cygwin_shortcut provides unix pathnames. Also, this
function tries to invoke the Windows Script Host to run a javascript
snippet, but this fails under Cygwin's Tcl. So, win32_create_lnk just
does not support Cygwin.

However, Cygwin's default installation provides /bin/mkshortcut for
creating desktop shortcuts. This is compatible with exec under Cygwin's
Tcl, understands Cygwin's unix pathnames, and avoids the need for shell
escapes to encode troublesome paths. So, teach git-gui to use mkshortcut
on Cygwin, leaving win32_create_lnk unchanged and for exclusive use by
Git For Windows.

Notes: "CHERE_INVOKING=1" is recognized by Cygwin's /etc/profile and
prevents a "chdir $HOME", leaving the shell in the working directory
specified by the shortcut. That directory is written directly by
mkshortcut eliminating any problems with shell escapes and quoting.

The code being replaced includes the full pathname of the git-gui
creating the shortcut, but that git-gui might not be compatible with the
git found after /etc/profile sets the path, and might have a pathname
that defies encoding using shell escapes that can survive the multiple
incompatible interpreters involved in the chain of creating and using
this shortcut.  The new code uses bare "git gui" as the command to
execute, thus using the system git to launch the system git-gui, and
avoiding both issues.

Signed-off-by: Mark Levedahl <mlevedahl@gmail.com>
---
changes since v0
 -- assumes no changes to shortcut creation code in prior patches,
    so changes in this patch are easier to review.
 -- changed to use long option names for mkshortcut, better conforming
    to practice in git-gui overall.

 lib/shortcut.tcl | 31 ++++++++++++++-----------------
 1 file changed, 14 insertions(+), 17 deletions(-)

diff --git a/lib/shortcut.tcl b/lib/shortcut.tcl
index 97d1d7a..674a41f 100644
--- a/lib/shortcut.tcl
+++ b/lib/shortcut.tcl
@@ -27,13 +27,10 @@ proc do_windows_shortcut {} {
 }
 
 proc do_cygwin_shortcut {} {
-	global argv0 _gitworktree
+	global argv0 _gitworktree oguilib
 
 	if {[catch {
 		set desktop [exec cygpath \
-			--windows \
-			--absolute \
-			--long-name \
 			--desktop]
 		}]} {
 			set desktop .
@@ -48,19 +45,19 @@ proc do_cygwin_shortcut {} {
 			set fn ${fn}.lnk
 		}
 		if {[catch {
-				set sh [exec cygpath \
-					--windows \
-					--absolute \
-					/bin/sh.exe]
-				set me [exec cygpath \
-					--unix \
-					--absolute \
-					$argv0]
-				win32_create_lnk $fn [list \
-					$sh -c \
-					"CHERE_INVOKING=1 source /etc/profile;[sq $me] &" \
-					] \
-					[file normalize $_gitworktree]
+				set repodir [file normalize $_gitworktree]
+				set shargs {-c \
+					"CHERE_INVOKING=1 \
+					source /etc/profile; \
+					git gui"}
+				exec /bin/mkshortcut.exe \
+					--arguments $shargs \
+					--desc "git-gui on $repodir" \
+					--icon $oguilib/git-gui.ico \
+					--name $fn \
+					--show min \
+					--workingdir $repodir \
+					/bin/sh.exe
 			} err]} {
 			error_popup [strcat [mc "Cannot write shortcut:"] "\n\n$err"]
 		}
-- 
2.41.0.99.19

