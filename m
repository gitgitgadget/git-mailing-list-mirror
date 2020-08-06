Return-Path: <SRS0=sa20=BQ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 197A6C433E0
	for <git@archiver.kernel.org>; Thu,  6 Aug 2020 01:05:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E37852173E
	for <git@archiver.kernel.org>; Thu,  6 Aug 2020 01:05:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="urJWwz+9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726762AbgHFBFe (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Aug 2020 21:05:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726360AbgHFBFM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Aug 2020 21:05:12 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EE76C061757
        for <git@vger.kernel.org>; Wed,  5 Aug 2020 18:05:11 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id k20so8041650wmi.5
        for <git@vger.kernel.org>; Wed, 05 Aug 2020 18:05:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=/dGZi5rmQREJD46v4NSDJLG7Jjjiiuicdzy5xoEf68Y=;
        b=urJWwz+9oCiZ619KMvEdakKHAD0dQr35YzJMONQxs4BLv8Y4UaXyRisboFCkfvVwYP
         Aa+VwYAv0cjOOkxHw6RQG/WbkyekfN0kfKUy/AkJCFtcgVwR1nw3qW2bUn58PQf7ucTn
         mcrg5l9NyVUPSQU48Dzzb84JM0qzn3RVmFS9OvZpaf7+6ZT0d0NDR/Q4bVo1OrX/UHXh
         2tV/2Kymy4PwLEy3tmK6GqE408PDolGN9x5WqBk/RkrMjEc0PRgkJJeFeMQ0rqt/6+g1
         p+EvI9Z//ZTgHwOWTcmWGKKfsXp9CpKHGCwnIBILJtroFuF/B/lPa1zTLwFcaZJmPejM
         cOfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=/dGZi5rmQREJD46v4NSDJLG7Jjjiiuicdzy5xoEf68Y=;
        b=V/aWW7xkTQZ3ULEOGpICe4m6QLOXjv5Z1y2GENrzak4O55AdZOasXCN8jeVpJaRPLT
         l8iQYlwiGb6Kox7w7FRqr/3Ry9u8+VBIOJJmwnWbLpvgxFyh2VxEzytCkXoLCSQjXVVZ
         66QRv+8pOZhqojeY0qKuN575h4srvHU+9gHgY68zpQfzBoTbR7fW0Sd2sxuGNP429LU2
         qCTzGfvE13NWX6y0qfKtIc7vRy9H2olnKxLR9MelPtCSsPJiDP1UuW2iJ+uPsfxs5RES
         GFY4KsWvhOdfSI+8I/Gn9KZ515lbCi1oi6OPrpAvH8gFLKcZXBEBPEhTjXaz0h7k7LWF
         cYwQ==
X-Gm-Message-State: AOAM531UueprjHnOwt1rC6niElnf5DRepnFrMX01ihKwZVQCXbD3t5/s
        aGcOl8Kq6OaCo4FklaWA02TtaS0c
X-Google-Smtp-Source: ABdhPJzwP6NI3tQHO/2qIA+7wToC6CjBFK37Mt8qxuhuFwoRLT/40HOcWZiiTfQGSysmq5NSV0xXtw==
X-Received: by 2002:a05:600c:284:: with SMTP id 4mr5628658wmk.48.1596675908577;
        Wed, 05 Aug 2020 18:05:08 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v29sm4596371wrv.51.2020.08.05.18.05.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2020 18:05:08 -0700 (PDT)
Message-Id: <d15ed626de65c51ef2ba31020eeb2111fb8e091f.1596675905.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.694.git.1596675905.gitgitgadget@gmail.com>
References: <pull.694.git.1596675905.gitgitgadget@gmail.com>
From:   "lufia via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 06 Aug 2020 01:05:03 +0000
Subject: [PATCH 3/4] Fit to Plan 9's ANSI/POSIX compatibility layer
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     "KADOTA, Kyohei" <lufia@lufia.org>, lufia <lufia@lufia.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: lufia <lufia@lufia.org>

That haven't any commands: cut, expr and printf.

And its sed(1)'s label is limited to maximum seven characters.
Therefore I replaced some labels to drop a character.

* close -> cl
* continue -> cont (cnt is used for count)
* line -> ln
* hered -> hdoc
* shell -> sh
* string -> str

Signed-off-by: lufia <lufia@lufia.org>
---
 GIT-VERSION-GEN     |  2 +-
 generate-cmdlist.sh | 19 ++++++++-----
 t/chainlint.sed     | 66 ++++++++++++++++++++++-----------------------
 3 files changed, 47 insertions(+), 40 deletions(-)

diff --git a/GIT-VERSION-GEN b/GIT-VERSION-GEN
index 9db2f4feab..a7cc01caf9 100755
--- a/GIT-VERSION-GEN
+++ b/GIT-VERSION-GEN
@@ -26,7 +26,7 @@ else
 	VN="$DEF_VER"
 fi
 
-VN=$(expr "$VN" : v*'\(.*\)')
+VN=${VN#v}
 
 if test -r $GVF
 then
diff --git a/generate-cmdlist.sh b/generate-cmdlist.sh
index 45fecf8bdf..8344ca6264 100755
--- a/generate-cmdlist.sh
+++ b/generate-cmdlist.sh
@@ -6,11 +6,11 @@ die () {
 }
 
 command_list () {
-	eval "grep -ve '^#' $exclude_programs" <"$1"
+	eval "grep -v -e '^#' $exclude_programs" <"$1"
 }
 
 get_categories () {
-	tr ' ' '\n'|
+	tr ' ' '\012'|
 	grep -v '^$' |
 	sort |
 	uniq
@@ -18,13 +18,13 @@ get_categories () {
 
 category_list () {
 	command_list "$1" |
-	cut -c 40- |
+	awk '{ print substr($0, 40) }' |
 	get_categories
 }
 
 get_synopsis () {
 	sed -n '
-		/^NAME/,/'"$1"'/H
+		/^NAME/,/'"$1"'/h
 		${
 			x
 			s/.*'"$1"' - \(.*\)/N_("\1")/
@@ -60,16 +60,23 @@ define_category_names () {
 	echo "};"
 }
 
+if test -z "$(echo -n)"
+then
+	alias print='echo -n'
+else
+	alias print='printf %s'
+fi
+
 print_command_list () {
 	echo "static struct cmdname_help command_list[] = {"
 
 	command_list "$1" |
 	while read cmd rest
 	do
-		printf "	{ \"$cmd\", $(get_synopsis $cmd), 0"
+		print "	{ \"$cmd\", $(get_synopsis $cmd), 0"
 		for cat in $(echo "$rest" | get_categories)
 		do
-			printf " | CAT_$cat"
+			print " | CAT_$cat"
 		done
 		echo " },"
 	done
diff --git a/t/chainlint.sed b/t/chainlint.sed
index 70df40e34b..8a25c5b855 100644
--- a/t/chainlint.sed
+++ b/t/chainlint.sed
@@ -117,7 +117,7 @@
 /^[ 	]*!*[ 	]*(..*)[ 	]*[0-9]*[<>|&]/boneline
 
 # multi-line "(...\n...)"
-/^[ 	]*(/bsubshell
+/^[ 	]*(/bsubsh
 
 # innocuous line -- print it and advance to next line
 b
@@ -130,11 +130,11 @@ b
 }
 b
 
-:subshell
+:subsh
 # bare "(" line? -- stash for later printing
 /^[ 	]*([	]*$/ {
 	h
-	bnextline
+	bnextln
 }
 # "(..." line -- split off and stash "(", then process "..." as its own line
 x
@@ -143,7 +143,7 @@ x
 s/(//
 bslurp
 
-:nextline
+:nextln
 N
 s/.*\n//
 
@@ -151,10 +151,10 @@ s/.*\n//
 # incomplete line "...\"
 /\\$/bicmplte
 # multi-line quoted string "...\n..."?
-/"/bdqstring
+/"/bdqstr
 # multi-line quoted string '...\n...'? (but not contraction in string "it's")
 /'/{
-	/"[^'"]*'[^'"]*"/!bsqstring
+	/"[^'"]*'[^'"]*"/!bsqstr
 }
 :folded
 # here-doc -- swallow it
@@ -163,8 +163,8 @@ s/.*\n//
 # before closing ")", "done", "elsif", "else", or "fi" will need to be
 # re-visited to drop "suspect" marking since final line of those constructs
 # legitimately lacks "&&", so "suspect" mark must be removed
-/^[ 	]*#/bnextline
-/^[ 	]*$/bnextline
+/^[ 	]*#/bnextln
+/^[ 	]*$/bnextln
 # in-line comment -- strip it (but not "#" in a string, Bash ${#...} array
 # length, or Perforce "//depot/path#42" revision in filespec)
 /[ 	]#/{
@@ -175,22 +175,22 @@ s/.*\n//
 # multi-line "case ... esac"
 /^[ 	]*case[ 	]..*[ 	]in/bcase
 # multi-line "for ... done" or "while ... done"
-/^[ 	]*for[ 	]..*[ 	]in/bcontinue
-/^[ 	]*while[ 	]/bcontinue
-/^[ 	]*do[ 	]/bcontinue
-/^[ 	]*do[ 	]*$/bcontinue
-/;[ 	]*do/bcontinue
+/^[ 	]*for[ 	]..*[ 	]in/bcont
+/^[ 	]*while[ 	]/bcont
+/^[ 	]*do[ 	]/bcont
+/^[ 	]*do[ 	]*$/bcont
+/;[ 	]*do/bcont
 /^[ 	]*done[ 	]*&&[ 	]*$/bdone
 /^[ 	]*done[ 	]*$/bdone
 /^[ 	]*done[ 	]*[<>|]/bdone
 /^[ 	]*done[ 	]*)/bdone
-/||[ 	]*exit[ 	]/bcontinue
-/||[ 	]*exit[ 	]*$/bcontinue
+/||[ 	]*exit[ 	]/bcont
+/||[ 	]*exit[ 	]*$/bcont
 # multi-line "if...elsif...else...fi"
-/^[ 	]*if[ 	]/bcontinue
-/^[ 	]*then[ 	]/bcontinue
-/^[ 	]*then[ 	]*$/bcontinue
-/;[ 	]*then/bcontinue
+/^[ 	]*if[ 	]/bcont
+/^[ 	]*then[ 	]/bcont
+/^[ 	]*then[ 	]*$/bcont
+/;[ 	]*then/bcont
 /^[ 	]*elif[ 	]/belse
 /^[ 	]*elif[ 	]*$/belse
 /^[ 	]*else[ 	]/belse
@@ -234,10 +234,10 @@ s/.*\n//
 	}
 }
 # line ends with pipe "...|" -- valid; not missing "&&"
-/|[ 	]*$/bcontinue
+/|[ 	]*$/bcont
 # missing end-of-line "&&" -- mark suspect
 /&&[ 	]*$/!s/^/?!AMP?!/
-:continue
+:cont
 # retrieve and print previous line
 x
 n
@@ -250,7 +250,7 @@ s/\\\n//
 bslurp
 
 # check for multi-line double-quoted string "...\n..." -- fold to one line
-:dqstring
+:dqstr
 # remove all quote pairs
 s/"\([^"]*\)"/@!\1@!/g
 # done if no dangling quote
@@ -258,13 +258,13 @@ s/"\([^"]*\)"/@!\1@!/g
 # otherwise, slurp next line and try again
 N
 s/\n//
-bdqstring
+bdqstr
 :dqdone
 s/@!/"/g
 bfolded
 
 # check for multi-line single-quoted string '...\n...' -- fold to one line
-:sqstring
+:sqstr
 # remove all quote pairs
 s/'\([^']*\)'/@!\1@!/g
 # done if no dangling quote
@@ -272,7 +272,7 @@ s/'\([^']*\)'/@!\1@!/g
 # otherwise, slurp next line and try again
 N
 s/\n//
-bsqstring
+bsqstr
 :sqdone
 s/@!/'/g
 bfolded
@@ -282,11 +282,11 @@ bfolded
 :heredoc
 s/^\(.*\)<<[ 	]*[-\\'"]*\([A-Za-z0-9_][A-Za-z0-9_]*\)['"]*/<\2>\1<</
 s/[ 	]*<<//
-:heredsub
+:hdocsub
 N
 /^<\([^>]*\)>.*\n[ 	]*\1[ 	]*$/!{
 	s/\n.*$//
-	bheredsub
+	bhdocsub
 }
 s/^<[^>]*>//
 s/\n.*$//
@@ -305,7 +305,7 @@ bcase
 x
 s/?!AMP?!//
 x
-bcontinue
+bcont
 
 # found "done" closing for-loop or while-loop, or "fi" closing if-then -- drop
 # "suspect" from final contained line since that line legitimately lacks "&&"
@@ -321,10 +321,10 @@ bchkchn
 # found nested multi-line "(...\n...)" -- pass through untouched
 :nest
 x
-:nstslurp
+:nstslrp
 n
 # closing ")" on own line -- stop nested slurp
-/^[ 	]*)/bnstclose
+/^[ 	]*)/bnstcl
 # comment -- not closing ")" if in comment
 /^[ 	]*#/bnstcnt
 # "$((...))" -- arithmetic expansion; not closing ")"
@@ -332,11 +332,11 @@ n
 # "$(...)" -- command substitution; not closing ")"
 /\$([^)][^)]*)[^)]*$/bnstcnt
 # closing "...)" -- stop nested slurp
-/)/bnstclose
+/)/bnstcl
 :nstcnt
 x
-bnstslurp
-:nstclose
+bnstslrp
+:nstcl
 s/^/>>/
 # is it "))" which closes nested and parent subshells?
 /)[ 	]*)/bslurp
-- 
gitgitgadget

