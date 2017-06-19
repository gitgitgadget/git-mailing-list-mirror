Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9860B20D0C
	for <e@80x24.org>; Mon, 19 Jun 2017 17:57:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751109AbdFSR5A (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Jun 2017 13:57:00 -0400
Received: from smtp-out-5.talktalk.net ([62.24.135.69]:53322 "EHLO
        smtp-out-5.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751062AbdFSR5A (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Jun 2017 13:57:00 -0400
Received: from lindisfarne.localdomain ([92.22.42.39])
        by smtp.talktalk.net with SMTP
        id N0uGdKeNKHGLwN0v4dVsE6; Mon, 19 Jun 2017 18:56:59 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net; s=1605;
        t=1497895019; bh=orPzP5tUuB4RbUA7dFPA0tq89JhKhYYXEX/fF0zdn5E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
        b=swnsTcTbwBA9b9gXk8St8qMBl6DVeJUNBpNR0s9cjf92Fy099Fbn97eVUenk5gggn
         rw6KhUu4tbZfDCn5Uvfl705g3h7HkCaxONdMcEaYYJo83EAP4RL8nyueIWTCXEJgzR
         bNfF/USlLYMmfDSageGwkglkX073O5RXiSGQUcGI=
X-Originating-IP: [92.22.42.39]
X-Spam: 0
X-OAuthority: v=2.2 cv=dsCZMBo4 c=1 sm=1 tr=0 a=0UCMmuyk8Ln1ykD6Z38Clg==:117
 a=0UCMmuyk8Ln1ykD6Z38Clg==:17 a=evINK-nbAAAA:8 a=X871Zwczc8JGJm1kKx0A:9
 a=RfR_gqz1fSpA9VikTjo0:22
From:   Phillip Wood <phillip.wood@talktalk.net>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v3 1/4] sequencer: print autostash messages to stderr
Date:   Mon, 19 Jun 2017 18:56:02 +0100
Message-Id: <20170619175605.27864-2-phillip.wood@talktalk.net>
X-Mailer: git-send-email 2.13.0
In-Reply-To: <20170619175605.27864-1-phillip.wood@talktalk.net>
References: <20170531104213.16944-1-phillip.wood@talktalk.net>
 <20170619175605.27864-1-phillip.wood@talktalk.net>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
X-CMAE-Envelope: MS4wfJF/ktyuxwcLC+1FKkIoKYpnIFXSM7hGe167c91ByNjB90INDTsgAIyluk7vHU8/7MpcBKu66BgoKLvGlPqmVq8B+bbsnCfgkikRIRKVSVjkmJ+GsmET
 6GR0CbTnP3paTNFFa3FT2Gm9rKvmYDGuMJElVXWTR3w+9CDQf5VBiH2gKK3lwmDf2z3hbbOuoNiEao9P/NKYzZPxgQtLg0sI5APudAfGYvjw5BR/TDo14XsC
 EIgN58ZOczoeTkHaytlVaB6zKyZshp12YgT9jCM1QEXuBbyPYPk/Ds1xjVt4SSoHuHqRJ7VGQvq+licGjPAImf1X5gmz1S02rupfmvRDC1881L7BmCYk6WYm
 xXl1otWA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

The rebase messages are printed to stderr traditionally. However due
to a bug introduced in 587947750bd (rebase: implement --[no-]autostash
and rebase.autostash, 2013-05-12) which was faithfully copied when
reimplementing parts of the interactive rebase in the sequencer the
autostash messages are printed to stdout instead.

It is time to fix that: let's print the autostash messages to stderr
instead of stdout.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 git-rebase.sh |  4 ++--
 sequencer.c   | 11 ++++++-----
 2 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/git-rebase.sh b/git-rebase.sh
index db1deed8464f0643763ed6e3c5e54221cad8c985..2cf73b88e8e83ca34b9eb319dbc2b0a220139b0f 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -166,14 +166,14 @@ apply_autostash () {
 		stash_sha1=$(cat "$state_dir/autostash")
 		if git stash apply $stash_sha1 2>&1 >/dev/null
 		then
-			echo "$(gettext 'Applied autostash.')"
+			echo "$(gettext 'Applied autostash.')" >&2
 		else
 			git stash store -m "autostash" -q $stash_sha1 ||
 			die "$(eval_gettext "Cannot store \$stash_sha1")"
 			gettext 'Applying autostash resulted in conflicts.
 Your changes are safe in the stash.
 You can run "git stash pop" or "git stash drop" at any time.
-'
+' >&2
 		fi
 	fi
 }
diff --git a/sequencer.c b/sequencer.c
index a23b948ac148304dbebfe38955ec8b40cab3e1e5..606750b1e0c900a9fb43cea224d27ab36ca29ab9 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1921,7 +1921,7 @@ static int apply_autostash(struct replay_opts *opts)
 	argv_array_push(&child.args, "apply");
 	argv_array_push(&child.args, stash_sha1.buf);
 	if (!run_command(&child))
-		printf(_("Applied autostash.\n"));
+		fprintf(stderr, _("Applied autostash.\n"));
 	else {
 		struct child_process store = CHILD_PROCESS_INIT;
 
@@ -1935,10 +1935,11 @@ static int apply_autostash(struct replay_opts *opts)
 		if (run_command(&store))
 			ret = error(_("cannot store %s"), stash_sha1.buf);
 		else
-			printf(_("Applying autostash resulted in conflicts.\n"
-				"Your changes are safe in the stash.\n"
-				"You can run \"git stash pop\" or"
-				" \"git stash drop\" at any time.\n"));
+			fprintf(stderr,
+				_("Applying autostash resulted in conflicts.\n"
+				  "Your changes are safe in the stash.\n"
+				  "You can run \"git stash pop\" or"
+				  " \"git stash drop\" at any time.\n"));
 	}
 
 	strbuf_release(&stash_sha1);
-- 
2.13.0

