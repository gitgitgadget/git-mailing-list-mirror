Return-Path: <SRS0=sGv9=AK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A181C433DF
	for <git@archiver.kernel.org>; Mon, 29 Jun 2020 21:11:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 19C2D20720
	for <git@archiver.kernel.org>; Mon, 29 Jun 2020 21:11:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lX/Yymiz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730187AbgF2S7v (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Jun 2020 14:59:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730090AbgF2S7t (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Jun 2020 14:59:49 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8888C031C40
        for <git@vger.kernel.org>; Mon, 29 Jun 2020 11:59:49 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id d21so9747448lfb.6
        for <git@vger.kernel.org>; Mon, 29 Jun 2020 11:59:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Qf8iMJVete2q2LlDpIePK4B6GRLSwzC+8/rJ+Y2Mjns=;
        b=lX/YymizSoDYUMNf6Hj6Q71j5hET7hCUIRDww4ymrtEJ1YQ/WzAgWLndV8m617e+aw
         BKpYyX0vanIxrHaL5E8/OdMxijjijNIM3xPc7QwdbN34RSJ+sRu+KY+rQTtaMzvNoFN7
         PbH2eCbIKwJHg5wAgwW4RECUB81AVn4jA4qWA8Zjq13xvQ/TnDKjBytgDFUBXmvPnrWz
         FbAWkYLwC9lLwD5dQYqvLe7w6+ibzmEw5S4sAryoQwb2HhYL5aCggYDrQgkL6TWp0K6T
         LRtF1DLBNXBEEJ6rzcZGXQO14+4LzVEVBRFuO9x40AdEyoDtB+Y1ZraDqICuVo2hakEf
         /f4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=Qf8iMJVete2q2LlDpIePK4B6GRLSwzC+8/rJ+Y2Mjns=;
        b=OeRd/7lxVR3A05FzoVsyY7JzPIcFRvLzghAF+uFjNq67A3LKRa9R9MUPTXR3/xNi1I
         a/jAgWcvRaOfAijSU7lXPkyeQLzguD3f/69YkGtsN8AEqFKqqvhsWMxSNEBaPCcJmNsL
         lfe9ctVRxrJ2Amc4MpO7rT8EOwDRLTB9QpOvW27oC8Hwz14MByrDiWGdFctaHbPcQuSr
         GZ4FJPJBUGUM/52AS+cTs08HDLwOi5AOXHkaSqEdqxN7y7I2ua5UinGhf7Tk4ArCUvQI
         +FnjqeG9gO4Uf+MChmHft+5rU1EA0b4WO5XeNLyS1xxVpHqhxn+IlbDbLwAYlvxz/qIc
         w9Xw==
X-Gm-Message-State: AOAM532wWOBqHCf/CiTlkPbYZa7Lc+E19E0Ozh13p99PedjOOIJ45VIW
        gdqz+er9WDTELzsO/5TlWB+gV3QDmPY=
X-Google-Smtp-Source: ABdhPJx9a5aH7i1hYasQ8YqLZUkakiWgpUh3m3wVKiizrMpM3vykWVU18pWGBZs5Dd5S/EZ7V9V8Gw==
X-Received: by 2002:a19:8253:: with SMTP id e80mr10302683lfd.199.1593457187861;
        Mon, 29 Jun 2020 11:59:47 -0700 (PDT)
Received: from uncleman.localhost.localhost (dygydtsfl9kwztw5f6jwy-4.rev.dnainternet.fi. [2001:14bb:140:383c:89ea:2548:4b24:d1e4])
        by smtp.gmail.com with ESMTPSA id g7sm142319ljl.7.2020.06.29.11.59.46
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2020 11:59:47 -0700 (PDT)
From:   =?UTF-8?q?Ville=20Skytt=C3=A4?= <ville.skytta@iki.fi>
To:     git@vger.kernel.org
Subject: [PATCH] completion: nounset mode fixes
Date:   Mon, 29 Jun 2020 21:59:45 +0300
Message-Id: <20200629185945.29814-1-ville.skytta@iki.fi>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Accessing unset variables results an errors when the shell is in
nounset/-u mode. This fixes the cases I've come across while using git
completion in a shell running in that mode for a while. It's hard to
tell if this is the complete set, but at least it improves things.

Signed-off-by: Ville Skyttä <ville.skytta@iki.fi>
---
 contrib/completion/git-completion.bash | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index de5d0fbbd1..ee468ea3b0 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -50,7 +50,7 @@ esac
 # variable.
 __git_find_repo_path ()
 {
-	if [ -n "$__git_repo_path" ]; then
+	if [ -n "${__git_repo_path-}" ]; then
 		# we already know where it is
 		return
 	fi
@@ -404,12 +404,12 @@ __gitcomp_builtin ()
 	# spaces must be replaced with underscore for multi-word
 	# commands, e.g. "git remote add" becomes remote_add.
 	local cmd="$1"
-	local incl="$2"
-	local excl="$3"
+	local incl="${2-}"
+	local excl="${3-}"
 
 	local var=__gitcomp_builtin_"${cmd/-/_}"
 	local options
-	eval "options=\$$var"
+	eval "options=\${$var-}"
 
 	if [ -z "$options" ]; then
 		# leading and trailing spaces are significant to make
@@ -801,7 +801,7 @@ __git_refs ()
 #                --remote is only compatible with --mode=refs.
 __git_complete_refs ()
 {
-	local remote dwim pfx cur_="$cur" sfx=" " mode="refs"
+	local remote= dwim= pfx= cur_="$cur" sfx=" " mode="refs"
 
 	while test $# != 0; do
 		case "$1" in
@@ -1152,7 +1152,7 @@ __git_find_on_cmdline ()
 	while [ $c -lt $cword ]; do
 		for word in $wordlist; do
 			if [ "$word" = "${words[c]}" ]; then
-				if [ -n "$show_idx" ]; then
+				if [ -n "${show_idx-}" ]; then
 					echo "$c $word"
 				else
 					echo "$word"
@@ -1468,7 +1468,7 @@ __git_checkout_default_dwim_mode ()
 {
 	local last_option dwim_opt="--dwim"
 
-	if [ "$GIT_COMPLETION_CHECKOUT_NO_GUESS" = "1" ]; then
+	if [ "${GIT_COMPLETION_CHECKOUT_NO_GUESS-}" = "1" ]; then
 		dwim_opt=""
 	fi
 
@@ -3350,7 +3350,7 @@ __git_main ()
 		((c++))
 	done
 
-	if [ -z "$command" ]; then
+	if [ -z "${command-}" ]; then
 		case "$prev" in
 		--git-dir|-C|--work-tree)
 			# these need a path argument, let's fall back to
@@ -3385,7 +3385,7 @@ __git_main ()
 			"
 			;;
 		*)
-			if test -n "$GIT_TESTING_PORCELAIN_COMMAND_LIST"
+			if test -n "${GIT_TESTING_PORCELAIN_COMMAND_LIST-}"
 			then
 				__gitcomp "$GIT_TESTING_PORCELAIN_COMMAND_LIST"
 			else
-- 
2.17.1

