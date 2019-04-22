Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 445A61F5CB
	for <e@80x24.org>; Mon, 22 Apr 2019 05:07:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726645AbfDVFHu (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Apr 2019 01:07:50 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:46386 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726309AbfDVFHt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Apr 2019 01:07:49 -0400
Received: by mail-pf1-f194.google.com with SMTP id 9so5127774pfj.13
        for <git@vger.kernel.org>; Sun, 21 Apr 2019 22:07:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=iZNon4pwWMrbAHZdXAojQPwvxuBx2rScAuj7av8F4GI=;
        b=f0OW/+YeMUyPnMHIES1+QUB0E5q/nFvJEnxGoSjKMUgVfelSa1Ahyk5tSxe9rop89A
         sp/qPuYSGglbJeYKU2P/eFRo1V0Wd3fFee/mDSDskXafJr2eInhc7ed/RbcIEZv/Vr7W
         Flpny7x3n1zmulpB3TqSxv1nZScdFalmSlau0AIKadF4cFefaz1GWXBSg9eC/Yn6NIUK
         raM/ShsorGaEee9Vs3z/dz4CWcGRd4hfml6I6o8Sev8b6pywD3D0wRbRqNXIWBKFdrv3
         0ARmXwEtFkpidKC1wbsNEcCgC/mUHFCbAh6ZYADC8vNgiEmlS/0pefHVyyK57NtDPfWn
         cZTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=iZNon4pwWMrbAHZdXAojQPwvxuBx2rScAuj7av8F4GI=;
        b=XMBFJZBKPE3bLwx2yIPYC8mUmnMiZhVUycg22pdsiSrHTG8cga4/sFZ7LjImS/YvSW
         YnPGXBht2QbA8ZtIfOJEKoqVapWECh7SNnCutokV9+J0TJSCiV9v/muL0NooodeSJXUU
         fd+waIo4ZFY6szWwmr4jek65pHL5jJdr1F19KCD6TsHB/27hs1tdMuQXvvVIlb1J2iCd
         9wbDIU3JNBPpawyubsNdH20x5s0gp/X0IrGYDtBmJHPFm2o/BuV7za1O6WrvWWzkC40O
         ZXELR6RnrhzREcy86coO+fql/1UGRhGIkUy7Mqv+xeKx3YOGFb8k+e4UDuBptOYNB1fp
         TRgA==
X-Gm-Message-State: APjAAAULFFKLTAKDTbXCTSRlL33iFKgZsndo3+Qwx1KT7OgGt2pEebbn
        WRwR8i4/P0ZO0dcR9VYk62Fo8Dvu
X-Google-Smtp-Source: APXvYqzAJUOBs+T4aAt5yYg6r+eH0Yvbt+UzSTq3VSrBWFBlh7NAgm0narCCx763XOoLT3sooG1bvw==
X-Received: by 2002:a65:4802:: with SMTP id h2mr15919618pgs.98.1555909668112;
        Sun, 21 Apr 2019 22:07:48 -0700 (PDT)
Received: from archbookpro.localdomain (c-73-222-73-77.hsd1.ca.comcast.net. [73.222.73.77])
        by smtp.gmail.com with ESMTPSA id i68sm17985230pfj.96.2019.04.21.22.07.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 21 Apr 2019 22:07:47 -0700 (PDT)
Date:   Sun, 21 Apr 2019 22:07:45 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        David Aguilar <davvid@gmail.com>
Subject: [PATCH 3/5] mergetool: fallback to tool when guitool unavailable
Message-ID: <de1b897a11f96d2883907640c29313dd26886ea3.1555880168.git.liu.denton@gmail.com>
References: <cover.1555880168.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1555880168.git.liu.denton@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In git-difftool, if the tool is called with --gui but `diff.guitool` is
not set, it falls back to `diff.tool`. Make git-mergetool also fallback
from `merge.guitool` to `merge.tool` if the former is undefined.

If git-difftool were to use `get_configured_mergetool`, it would also
get the fallback behaviour in the following precedence:

1. diff.guitool
2. merge.guitool
3. diff.tool
4. merge.tool

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 Documentation/git-mergetool.txt |  4 +++-
 git-mergetool--lib.sh           | 27 ++++++++++++++++++---------
 t/t7610-mergetool.sh            | 19 +++++++++++++++++++
 3 files changed, 40 insertions(+), 10 deletions(-)

diff --git a/Documentation/git-mergetool.txt b/Documentation/git-mergetool.txt
index 0c7975a050..6b14702e78 100644
--- a/Documentation/git-mergetool.txt
+++ b/Documentation/git-mergetool.txt
@@ -83,7 +83,9 @@ success of the resolution after the custom tool has exited.
 --gui::
 	When 'git-mergetool' is invoked with the `-g` or `--gui` option
 	the default merge tool will be read from the configured
-	`merge.guitool` variable instead of `merge.tool`.
+	`merge.guitool` variable instead of `merge.tool`. If
+	`merge.guitool` is not set, we will fallback to the tool
+	configured under `merge.tool`.
 
 --no-gui::
 	This overrides a previous `-g` or `--gui` setting and reads the
diff --git a/git-mergetool--lib.sh b/git-mergetool--lib.sh
index d5e2c6c5c6..68a85f4a7b 100644
--- a/git-mergetool--lib.sh
+++ b/git-mergetool--lib.sh
@@ -350,20 +350,29 @@ guess_merge_tool () {
 }
 
 get_configured_merge_tool () {
-	# If first argument is true, find the guitool instead
-	if test "$1" = true
+	is_gui="$1"
+	sections="merge"
+	keys="tool"
+
+	if diff_mode
 	then
-		gui_prefix=gui
+		sections="diff $sections"
 	fi
 
-	# Diff mode first tries diff.(gui)tool and falls back to merge.(gui)tool.
-	# Merge mode only checks merge.(gui)tool
-	if diff_mode
+	if "$is_gui" = true
 	then
-		merge_tool=$(git config diff.${gui_prefix}tool || git config merge.${gui_prefix}tool)
-	else
-		merge_tool=$(git config merge.${gui_prefix}tool)
+		keys="guitool $keys"
 	fi
+
+	IFS=' '
+	for key in $keys
+	do
+		for section in $sections
+		do
+			merge_tool=$(git config $section.$key) && break 2
+		done
+	done
+
 	if test -n "$merge_tool" && ! valid_tool "$merge_tool"
 	then
 		echo >&2 "git config option $TOOL_MODE.${gui_prefix}tool set to unknown tool: $merge_tool"
diff --git a/t/t7610-mergetool.sh b/t/t7610-mergetool.sh
index 5f37d7a1ff..bc2c9eaa30 100755
--- a/t/t7610-mergetool.sh
+++ b/t/t7610-mergetool.sh
@@ -167,6 +167,25 @@ test_expect_success 'gui mergetool' '
 	git commit -m "branch1 resolved with mergetool"
 '
 
+test_expect_success 'gui mergetool without merge.guitool set fallsback to merge.tool' '
+	test_when_finished "git reset --hard" &&
+	git checkout -b test$test_count branch1 &&
+	git submodule update -N &&
+	test_must_fail git merge master >/dev/null 2>&1 &&
+	( yes "" | git mergetool --gui both >/dev/null 2>&1 ) &&
+	( yes "" | git mergetool -g file1 file1 ) &&
+	( yes "" | git mergetool --gui file2 "spaced name" >/dev/null 2>&1 ) &&
+	( yes "" | git mergetool --gui subdir/file3 >/dev/null 2>&1 ) &&
+	( yes "d" | git mergetool --gui file11 >/dev/null 2>&1 ) &&
+	( yes "d" | git mergetool --gui file12 >/dev/null 2>&1 ) &&
+	( yes "l" | git mergetool --gui submod >/dev/null 2>&1 ) &&
+	test "$(cat file1)" = "master updated" &&
+	test "$(cat file2)" = "master new" &&
+	test "$(cat subdir/file3)" = "master new sub" &&
+	test "$(cat submod/bar)" = "branch1 submodule" &&
+	git commit -m "branch1 resolved with mergetool"
+'
+
 test_expect_success 'mergetool crlf' '
 	test_when_finished "git reset --hard" &&
 	# This test_config line must go after the above reset line so that
-- 
2.21.0.967.gf85e14fd49

