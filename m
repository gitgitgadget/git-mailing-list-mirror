Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E86A42070F
	for <e@80x24.org>; Thu, 15 Sep 2016 15:01:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752785AbcIOPBU (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Sep 2016 11:01:20 -0400
Received: from relay5.ptmail.sapo.pt ([212.55.154.25]:48164 "EHLO sapo.pt"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752577AbcIOPBT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Sep 2016 11:01:19 -0400
Received: (qmail 10163 invoked from network); 15 Sep 2016 15:01:16 -0000
Received: (qmail 26028 invoked from network); 15 Sep 2016 15:01:04 -0000
Received: from unknown (HELO catarina.localdomain) (vascomalmeida@sapo.pt@[85.246.157.91])
          (envelope-sender <vascomalmeida@sapo.pt>)
          by ptmail-mta-auth01 (qmail-ptmail-1.0.0) with ESMTPA
          for <git@vger.kernel.org>; 15 Sep 2016 15:01:02 -0000
X-PTMail-RemoteIP: 85.246.157.91
X-PTMail-AllowedSender-Action: 
X-PTMail-Service: default
From:   Vasco Almeida <vascomalmeida@sapo.pt>
To:     git@vger.kernel.org
Cc:     Vasco Almeida <vascomalmeida@sapo.pt>,
        Jiang Xin <worldhello.net@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>,
        =?UTF-8?q?Jean-No=C3=ABl=20AVILA?= <jn.avila@free.fr>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 13/14] i18n: show-branch: mark plural strings for translation
Date:   Thu, 15 Sep 2016 14:59:07 +0000
Message-Id: <1473951548-31733-13-git-send-email-vascomalmeida@sapo.pt>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1473951548-31733-1-git-send-email-vascomalmeida@sapo.pt>
References: <1473951548-31733-1-git-send-email-vascomalmeida@sapo.pt>
In-Reply-To: <1473259758-11836-1-git-send-email-vascomalmeida@sapo.pt>
References: <1473259758-11836-1-git-send-email-vascomalmeida@sapo.pt>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Mark plural string for translation using Q_().

Although we already know that the plural sentence is always used in the
English source, other languages have complex plural rules they must
comply according to the value of MAX_REVS.

Signed-off-by: Vasco Almeida <vascomalmeida@sapo.pt>
---
 builtin/show-branch.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/builtin/show-branch.c b/builtin/show-branch.c
index 5809371..623ca56 100644
--- a/builtin/show-branch.c
+++ b/builtin/show-branch.c
@@ -373,8 +373,9 @@ static int append_ref(const char *refname, const struct object_id *oid,
 				return 0;
 	}
 	if (MAX_REVS <= ref_name_cnt) {
-		warning("ignoring %s; cannot handle more than %d refs",
-			refname, MAX_REVS);
+		warning(Q_("ignoring %s; cannot handle more than %d ref",
+			   "ignoring %s; cannot handle more than %d refs",
+			   MAX_REVS), refname, MAX_REVS);
 		return 0;
 	}
 	ref_name[ref_name_cnt++] = xstrdup(refname);
@@ -731,8 +732,9 @@ int cmd_show_branch(int ac, const char **av, const char *prefix)
 			die(_("--reflog option needs one branch name"));
 
 		if (MAX_REVS < reflog)
-			die("Only %d entries can be shown at one time.",
-			    MAX_REVS);
+			die(Q_("only %d entry can be shown at one time.",
+			       "only %d entries can be shown at one time.",
+			       MAX_REVS), MAX_REVS);
 		if (!dwim_ref(*av, strlen(*av), oid.hash, &ref))
 			die(_("no such ref %s"), *av);
 
@@ -826,7 +828,9 @@ int cmd_show_branch(int ac, const char **av, const char *prefix)
 		unsigned int flag = 1u << (num_rev + REV_SHIFT);
 
 		if (MAX_REVS <= num_rev)
-			die("cannot handle more than %d revs.", MAX_REVS);
+			die(Q_("cannot handle more than %d rev.",
+			       "cannot handle more than %d revs.",
+			       MAX_REVS), MAX_REVS);
 		if (get_sha1(ref_name[num_rev], revkey.hash))
 			die(_("'%s' is not a valid ref."), ref_name[num_rev]);
 		commit = lookup_commit_reference(revkey.hash);
-- 
2.7.4

