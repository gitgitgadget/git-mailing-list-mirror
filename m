Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9CA3B201A9
	for <e@80x24.org>; Fri, 17 Feb 2017 22:41:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964788AbdBQWlI (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Feb 2017 17:41:08 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33220 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935072AbdBQWlG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Feb 2017 17:41:06 -0500
Received: by mail-wm0-f68.google.com with SMTP id v77so4797497wmv.0
        for <git@vger.kernel.org>; Fri, 17 Feb 2017 14:41:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+YOQPn09YCAiLDiFGGYz64/1Sf/Ma6KiVBXWfP677Yw=;
        b=Z8lsW8Sk4jkGUlj3UMDVvPkMu7Q69iFb3tPO++HgTS53n0jpB+5UB3cEIIwBrVuMTr
         919sni55M0ch8qEhBjKaYLVKh8nM79zZjM3VB14sLh7IRnhLNXI3slZw2TRpm8HE5D53
         rnFMQizKcAy1J+b4xAcy5YxdA/dokO+Z1AU4dZ9BaUMtXjdr+WUJjAwfLVIwE1pixel1
         CRntctsIHUR/hqZ5Ylce4ZsZzXgf81+nyPrxwb8HUe+te6sIKeOd6Vn8GLauOby4vhnd
         ZenNtr0b6n41pG/m/rueZr/vMHYPGOC+mpqYOXQFzdLV0eGCj+0hwGVa939dtOpPJ645
         DSnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+YOQPn09YCAiLDiFGGYz64/1Sf/Ma6KiVBXWfP677Yw=;
        b=IcSyyPHzCOZ2FHUNp/kIrm4PL2ts8JtyGPKY7orksEj8PGZLLhyEQ3vCMpsLOyt9CQ
         RY3KxSXXsrWJptrdaImmWyjvu0IW+n6350YET/rjAVLHtyfnPT7Yb4sJC/7/CG1WUzR5
         HNgWx2AqCI3buuL/U3IVkxxsGl6LxaZwURaFY6Tpr3bRCXhFviNup5ZbFeyGzOfr1Gzm
         tFvtyhiBLkUp9gwJWnESgNPtzeOGMUl3Oa9WVU7Q0X+6UR2uqdRmE9CZ1xERcE6uZSo5
         Q1OHDDL2NW4kt8puD4kVunbxFT2RVVPz1QJlNmAtX+JsxQzbJJYveWKSCBiSGT5KAe6I
         oMsw==
X-Gm-Message-State: AMke39lgBAsDW7x+uhUeRiL4Javlg+NX+l2u9vVDPFgWTXLOoyhzRQpW6DTs8TFsZrEfFg==
X-Received: by 10.28.111.78 with SMTP id k75mr6196583wmc.71.1487371264517;
        Fri, 17 Feb 2017 14:41:04 -0800 (PST)
Received: from localhost ([2a02:c7f:c42b:f900:5e51:4fff:fee9:57af])
        by smtp.gmail.com with ESMTPSA id n13sm14521327wrn.40.2017.02.17.14.41.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 17 Feb 2017 14:41:03 -0800 (PST)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=98yvind=20A=20=2E=20Holm?= <sunny@sunbase.org>,
        =?UTF-8?q?Jakub=20Nar=C4=99bski?= <jnareb@gmail.com>,
        Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v5 0/6] stash: support pathspec argument
Date:   Fri, 17 Feb 2017 22:41:35 +0000
Message-Id: <20170217224141.19183-1-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.11.0.301.g27b9849079.dirty
In-Reply-To: <20170212215420.16701-1-t.gummerer@gmail.com>
References: <20170212215420.16701-1-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks Matthieu, Peff and Junio for the discussion on v3 and v4.

Changes since v4:
Dropped patch 1 from the series, as it's already in master

Instead of changing the external interface to git stash create, only
refactor the internal create_stash() function to take -m and -u
arguments.  This also simplifies the internal option parsing.

Make git stash -p an alias for git stash push -p, so git stash -p
<pathspec> is allowed.

Interdiff below:

diff --git a/Documentation/git-stash.txt b/Documentation/git-stash.txt
index b0825f4aca..97194576ef 100644
--- a/Documentation/git-stash.txt
+++ b/Documentation/git-stash.txt
@@ -53,9 +53,8 @@ OPTIONS
 save [-p|--patch] [-k|--[no-]keep-index] [-u|--include-untracked] [-a|--all] [-q|--quiet] [<message>]::
 push [-p|--patch] [-k|--[no-]keep-index] [-u|--include-untracked] [-a|--all] [-q|--quiet] [-m|--message <message>] [--] [<pathspec>...]::
 
-	Save your local modifications to a new 'stash' and roll them
-	back to HEAD (in the working tree and in the index).
-	The <message> part is optional and gives
+	Save your local modifications to a new 'stash', and run `git reset
+	--hard` to revert them.  The <message> part is optional and gives
 	the description along with the stashed state.  For quickly making
 	a snapshot, you can omit _both_ "save" and <message>, but giving
 	only <message> does not trigger this action to prevent a misspelled
diff --git a/git-stash.sh b/git-stash.sh
index a184b1e274..1446fbe2e8 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -67,51 +67,20 @@ create_stash () {
 		case "$1" in
 		-m|--message)
 			shift
-			test -z ${1+x} && usage
-			stash_msg="$1"
-			new_style=t
+			stash_msg=${1-"BUG: create_stash () -m requires an argument"}
 			;;
 		-u|--include-untracked)
 			shift
-			test -z ${1+x} && usage
-			untracked="$1"
-			new_style=t
+			untracked=${1-"BUG: create_stash () -u requires an argument"}
 			;;
 		--)
 			shift
-			new_style=t
-			break
-			;;
-		*)
-			if test -n "$new_style"
-			then
-				echo "invalid argument"
-				option="$1"
-				# TRANSLATORS: $option is an invalid option, like
-				# `--blah-blah'. The 7 spaces at the beginning of the
-				# second line correspond to "error: ". So you should line
-				# up the second line with however many characters the
-				# translation of "error: " takes in your language. E.g. in
-				# English this is:
-				#
-				#    $ git stash save --blah-blah 2>&1 | head -n 2
-				#    error: unknown option for 'stash save': --blah-blah
-				#           To provide a message, use git stash save -- '--blah-blah'
-				eval_gettextln "error: unknown option for 'stash create': \$option"
-				usage
-			fi
 			break
 			;;
 		esac
 		shift
 	done
 
-	if test -z "$new_style"
-	then
-		stash_msg="$*"
-		set --
-	fi
-
 	git update-index -q --refresh
 	if no_changes "$@"
 	then
@@ -698,6 +667,8 @@ apply_to_branch () {
 	}
 }
 
+test "$1" = "-p" && set "push" "$@"
+
 PARSE_CACHE='--not-parsed'
 # The default command is "push" if nothing but options are given
 seen_non_option=
@@ -740,7 +711,7 @@ clear)
 	;;
 create)
 	shift
-	create_stash "$@" && echo "$w_commit"
+	create_stash -m "$*" && echo "$w_commit"
 	;;
 store)
 	shift
diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index 22ac75377b..c0ae41e724 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -800,15 +800,6 @@ test_expect_success 'create with multiple arguments for the message' '
 	test_cmp expect actual
 '
 
-test_expect_success 'new style stash create stores correct message' '
-	>foo &&
-	git add foo &&
-	STASH_ID=$(git stash create -m "create test message new style") &&
-	echo "On master: create test message new style" >expect &&
-	git show --pretty=%s -s ${STASH_ID} >actual &&
-	test_cmp expect actual
-'
-
 test_expect_success 'stash -- <filename> stashes and restores the file' '
 	>foo &&
 	>bar &&

Thomas Gummerer (6):
  stash: introduce push verb
  stash: add test for the create command line arguments
  stash: refactor stash_create
  stash: teach 'push' (and 'create_stash') to honor pathspec
  stash: use stash_push for no verb form
  stash: allow pathspecs in the no verb form

 Documentation/git-stash.txt        |  16 ++++-
 git-stash.sh                       | 128 ++++++++++++++++++++++++++++++-------
 t/t3903-stash.sh                   | 118 +++++++++++++++++++++++++++++++++-
 t/t3905-stash-include-untracked.sh |  26 ++++++++
 4 files changed, 261 insertions(+), 27 deletions(-)

-- 
2.11.0.301.g27b9849079.dirty

