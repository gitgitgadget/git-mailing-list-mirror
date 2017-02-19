Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CF7F6201A9
	for <e@80x24.org>; Sun, 19 Feb 2017 11:10:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751664AbdBSLKN (ORCPT <rfc822;e@80x24.org>);
        Sun, 19 Feb 2017 06:10:13 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34439 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751454AbdBSLKN (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 Feb 2017 06:10:13 -0500
Received: by mail-wm0-f66.google.com with SMTP id c85so9620836wmi.1
        for <git@vger.kernel.org>; Sun, 19 Feb 2017 03:10:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ih8970x6EfeqlHraXxl215Nf1xILxzMMilffzFJjFN8=;
        b=StFOBMaEfVHo/DUQNWFIjMVl4vCnNJkcOROoV47gZ3DhEc+SEv5x6hCLPxWu7vPjES
         tv8NW+A1H19xWyo2Wl1fE8PZ/I1OrowUAswsa908gSBdoMPTGdkrEEqKkhcRcymteI+Z
         oRO455uNkghdVDEToLIpigQVKLP9Jvj+tTksOS5bCgdx7Aff9B3IyVgXDDNfrAfGaubw
         B3Q/MJWSeQfTPDOYlgCzL4vgm8Tb6qqH9RKgGJe0/al/ElGNxb6UzvoB4HTFHzJlHtCV
         Yn9zCDrsjfTvOr9q9G+83UTIkb86M015q3V9XEYTPMHIE5OTyJ+Q0QbFUm37I/TL9ro4
         nsPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ih8970x6EfeqlHraXxl215Nf1xILxzMMilffzFJjFN8=;
        b=saDfmy/iFRsJFANTDuIg40huPIhdPmKntPJfoDm/P2TgVbTy4jvx9pSTiNDsSX1IFj
         JPtphLG9ls3MTMzDzPgWRrINPcm2dBcmmrxXL2AKxf3qzWGDbWjFO0+CYMkQomYhF8lV
         j+TAVHcsmsXwQ78tvtfjtV3M107p1uw4sv2l8lWcCRhKW31eHJioRhiHgJ5mC7U3orRq
         MM3aAM4U0A9YYaQBRHb/W8rKPqiBWiPQmOO/+8Z2Gs7e52s3z8bx7Oi5DBsqtXVWBnyK
         Ez3QTxh3wqGPyuz7bh5BbWxM06DtUyFO0Rwjn4qVnVEOmFvV1p+P0gQBuijzQDtrnMZE
         OO7A==
X-Gm-Message-State: AMke39n3znf3BwALlURjS2tz9UiNgTamrt3lYYtUcmVna54UguOY8+azP0UYhN30M2Oc/w==
X-Received: by 10.28.207.70 with SMTP id f67mr7164930wmg.72.1487502186834;
        Sun, 19 Feb 2017 03:03:06 -0800 (PST)
Received: from localhost ([2a02:c7f:c42b:f900:5e51:4fff:fee9:57af])
        by smtp.gmail.com with ESMTPSA id w51sm5166377wrc.12.2017.02.19.03.03.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 19 Feb 2017 03:03:05 -0800 (PST)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=98yvind=20A=2E=20Holm?= <sunny@sunbase.org>,
        =?UTF-8?q?Jakub=20Nar=C4=99bski?= <jnareb@gmail.com>,
        Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v6 0/6] stash: support pathspec argument
Date:   Sun, 19 Feb 2017 11:03:07 +0000
Message-Id: <20170219110313.24070-1-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.12.0.rc2.399.g0ca89a282
In-Reply-To: <20170217224141.19183-1-t.gummerer@gmail.com>
References: <20170217224141.19183-1-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks Junio and Peff for comments on the last round.

Changes since then:

- removed mention of the "new form" of git stash create from the
  Documentation.
- Changed documentation for git stash without a verb, mentioning
  stash -p now being an alias for git stash push -p and that -- can be
  used as disambiguation for for pathspecs
- Fixed ${1-...} which should have been ${1?...}
- Removed unused new_style variable from create_stash, which was a
  leftover from perious rounds.

Interdiff below:

diff --git a/Documentation/git-stash.txt b/Documentation/git-stash.txt
index 97194576ef..369bfae33d 100644
--- a/Documentation/git-stash.txt
+++ b/Documentation/git-stash.txt
@@ -20,8 +20,6 @@ SYNOPSIS
 	     [--] [<pathspec>...]]
 'git stash' clear
 'git stash' create [<message>]
-'git stash' create [-m <message>] [-u|--include-untracked <untracked|all>]
-	     [-- <pathspec>...]
 'git stash' store [-m|--message <message>] [-q|--quiet] <commit>
 
 DESCRIPTION
@@ -55,10 +53,13 @@ push [-p|--patch] [-k|--[no-]keep-index] [-u|--include-untracked] [-a|--all] [-q
 
 	Save your local modifications to a new 'stash', and run `git reset
 	--hard` to revert them.  The <message> part is optional and gives
-	the description along with the stashed state.  For quickly making
-	a snapshot, you can omit _both_ "save" and <message>, but giving
-	only <message> does not trigger this action to prevent a misspelled
-	subcommand from making an unwanted stash.
+	the description along with the stashed state.
++
+For quickly making a snapshot, you can omit "push".  In this mode,
+non-option arguments are not allowed to prevent a misspelled
+subcommand from making an unwanted stash.  The two exceptions to this
+are `stash -p` which acts as alias for `stash push -p` and pathspecs,
+which are allowed after a double hyphen `--` for disambiguation.
 +
 When pathspec is given to 'git stash push', the new stash records the
 modified states only for the files that match the pathspec.  The index
diff --git a/git-stash.sh b/git-stash.sh
index 1446fbe2e8..18aba1346f 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -61,17 +61,16 @@ clear_stash () {
 create_stash () {
 	stash_msg=
 	untracked=
-	new_style=
 	while test $# != 0
 	do
 		case "$1" in
 		-m|--message)
 			shift
-			stash_msg=${1-"BUG: create_stash () -m requires an argument"}
+			stash_msg=${1?"BUG: create_stash () -m requires an argument"}
 			;;
 		-u|--include-untracked)
 			shift
-			untracked=${1-"BUG: create_stash () -u requires an argument"}
+			untracked=${1?"BUG: create_stash () -u requires an argument"}
 			;;
 		--)
 			shift

Thomas Gummerer (6):
  stash: introduce push verb
  stash: add test for the create command line arguments
  stash: refactor stash_create
  stash: teach 'push' (and 'create_stash') to honor pathspec
  stash: use stash_push for no verb form
  stash: allow pathspecs in the no verb form

 Documentation/git-stash.txt        |  27 ++++++--
 git-stash.sh                       | 127 ++++++++++++++++++++++++++++++-------
 t/t3903-stash.sh                   | 118 +++++++++++++++++++++++++++++++++-
 t/t3905-stash-include-untracked.sh |  26 ++++++++
 4 files changed, 267 insertions(+), 31 deletions(-)

-- 
2.12.0.rc2.399.g0ca89a282

