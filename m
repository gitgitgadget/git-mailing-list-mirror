Return-Path: <SRS0=gV3S=CS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 998A8C43461
	for <git@archiver.kernel.org>; Wed,  9 Sep 2020 19:47:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5843B20897
	for <git@archiver.kernel.org>; Wed,  9 Sep 2020 19:47:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q+VjKM/n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726883AbgIITrw (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Sep 2020 15:47:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726489AbgIITrp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Sep 2020 15:47:45 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50ABEC061755
        for <git@vger.kernel.org>; Wed,  9 Sep 2020 12:47:44 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id a65so3424537wme.5
        for <git@vger.kernel.org>; Wed, 09 Sep 2020 12:47:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=hOR018goEhRQ7RSYRS2SCFDo5LDjsrzMyd4K+utOgsU=;
        b=Q+VjKM/nJPDGRKUYbSo1IFpn2G6VU4fhaU8XamPMbGtBBhDgedRW4kFH2FNswT3E4F
         hToYyl3c/LhtrQDsM1UjBFwOlKHhj9ZqNN5gh/YN5l0V2wJgZLtrQXxtjC5Rq0i4G/29
         Q6onvPOEY7TTj8pJDEeBLDPDnqMx0FHw4Me8nJfvVMstIP7dN7QTBH3IQgHmk4XkNydZ
         qR5NIefl0CAbf3CUPd62CSdPmg1WS9QQ+pVT0VX+E3T/YvMNcxTF0ghf72ykrPJDYYMK
         8FXRuys1/s5GhehoRuaB3D632FCU67UDYN0cmFQUQMgXU7CiSk+NOtRd3yOGeLChghM2
         HNNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=hOR018goEhRQ7RSYRS2SCFDo5LDjsrzMyd4K+utOgsU=;
        b=RTCi4KtAjkwkGLpl8yg/abAdoGD2WzY0Vd8lTIRGYV2mOO6U+/fwkzbiO+2edOV7lU
         5sus8PBF2w8AprXs4J+O4oRkH38OG9AxqdEcviLhBGl09yCuhnSHDWQK68nTvgtfqHH6
         jBc5thtWa9Yk3Yw2njGwxJcbonT125/0uwOu3MxU1koRPnQU1P3gzIvzF+Q6OV73yBVi
         sRFlXIPjMj/iAbYB3fmVEIXGBy7krtnCD0zMsvccdBZ3HAKKJKuQ463Vi2IkWHP3/0Ev
         Pxd9OWbKG6kNfalG8GErvNTWWlbMZ8ForVhEgaYLtf84fmgRL7/Pye7nyaSfyZPnDyI8
         dGvg==
X-Gm-Message-State: AOAM530dzC6ADro/WnQ43h/Vpj7dD91rwybg4OSgyImSVYVjMxD0M1o8
        CCQpi/NN1tVnzn9ecQuQaKsX7TYourY=
X-Google-Smtp-Source: ABdhPJyhneVY63OEhdBDLdC/7PD/1I02ZYqWGKMq/8KnHT7kRL7nfxZdApXU+n9YWpuPGWewp7UlyQ==
X-Received: by 2002:a1c:dec2:: with SMTP id v185mr4973889wmg.1.1599680863302;
        Wed, 09 Sep 2020 12:47:43 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k12sm5507131wrn.39.2020.09.09.12.47.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2020 12:47:42 -0700 (PDT)
Message-Id: <c850888c25d4d1e1c6b0ca40ab4638462c1649fa.1599680861.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.694.v2.git.1599680861.gitgitgadget@gmail.com>
References: <pull.694.git.1596675905.gitgitgadget@gmail.com>
        <pull.694.v2.git.1599680861.gitgitgadget@gmail.com>
From:   "Kyohei Kadota via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 09 Sep 2020 19:47:40 +0000
Subject: [PATCH v2 1/2] Fit to Plan 9's ANSI/POSIX compatibility layer
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     "KADOTA, Kyohei" <lufia@lufia.org>, Kyohei Kadota <lufia@lufia.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Kyohei Kadota <lufia@lufia.org>

tr(1) of ANSI/POSIX environment, aka APE, don't support \n literal.
It's handles only octal(\ooo) or hexadecimal(\xhhhh) numbers.

And its sed(1)'s label is limited to maximum seven characters.
Therefore I replaced some labels to drop a character.

* close -> cl
* continue -> cont (cnt is used for count)
* line -> ln
* hered -> hdoc
* shell -> sh
* string -> str

Signed-off-by: Kyohei Kadota <lufia@lufia.org>
---
 generate-cmdlist.sh |  4 +--
 t/chainlint.sed     | 66 ++++++++++++++++++++++-----------------------
 2 files changed, 35 insertions(+), 35 deletions(-)

diff --git a/generate-cmdlist.sh b/generate-cmdlist.sh
index 45fecf8bdf..4031623b0e 100755
--- a/generate-cmdlist.sh
+++ b/generate-cmdlist.sh
@@ -10,7 +10,7 @@ command_list () {
 }
 
 get_categories () {
-	tr ' ' '\n'|
+	tr ' ' '\012'|
 	grep -v '^$' |
 	sort |
 	uniq
@@ -24,7 +24,7 @@ category_list () {
 
 get_synopsis () {
 	sed -n '
-		/^NAME/,/'"$1"'/H
+		/^NAME/,/'"$1"'/h
 		${
 			x
 			s/.*'"$1"' - \(.*\)/N_("\1")/
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

