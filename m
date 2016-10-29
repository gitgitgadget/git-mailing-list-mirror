Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D7BDC2022A
	for <e@80x24.org>; Sat, 29 Oct 2016 12:55:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756190AbcJ2Mzr (ORCPT <rfc822;e@80x24.org>);
        Sat, 29 Oct 2016 08:55:47 -0400
Received: from mout.web.de ([212.227.17.11]:57189 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751541AbcJ2Mzq (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 Oct 2016 08:55:46 -0400
Received: from [192.168.178.36] ([79.197.211.11]) by smtp.web.de (mrweb102)
 with ESMTPSA (Nemesis) id 0MhUbO-1cEGvw2RKU-00MfId; Sat, 29 Oct 2016 14:55:38
 +0200
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] commit: simplify building parents list
Message-ID: <30afdbeb-7a45-70b2-495e-35fd3b62419a@web.de>
Date:   Sat, 29 Oct 2016 14:55:36 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:Gfj8Tafe535cXxx86Xzh17y9e788wUerjURINuhFVSzmLm3Vqac
 PNonIb0higtVOb/v6F+QibMcB9Y67hfR+owGTJKI5fGxjQjkRQRV5EiDd1RYGfOiKL+lAYL
 4ddGwEIsbiz3++muUhSFxIznLFXnPNMYygUWGuusI/49/8+No2NcZ4xdkoHo+IK/plxTLXB
 v4eJPTNKaX/RLtlvwEjaA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:n8/EsZyOuYk=:s/rkEoKbroY77qKDwEr0s+
 zvuSlmcgMM5yoYcG4Swt0DbdrichTMjPYeKSdXuut90jtvMoqZQXso2LQtoTVV0rJzd9YpZ2s
 qbY2KcoRwwEgTvolV0MUw4MvEdGvWjfALWktRyvML2eZRwp6ncxwcCQr40mD6Chi60IVrgg1T
 xP3wOLn9htg7Rxsg2hLv3Zo56EdGLOIqNRh6V4zyescqr0SGHV1r5+BQNns+z+gU4Ikj7vN/c
 E7lXP3syAJSPNLiiIBS/GKW1NExRSHxQYMQMmZSjDkM7e5j4/KYeTxbsjH1rcrvq9uaA/KrM8
 10wG3QvWleYhI9cOZV3on1lQB8xm8Bfu+Z84pyTwUMqr6MzDvTtfCt2vUlHsIRnxEivP8HfDa
 TtaqlD5kBf//xFyKItUbyax2IhQGO22zZMcApyVfFaJWOyVMxOR9Lox6M6qaBiu96RevTZvRG
 bG+BPhBHGasYXwPq/Js7uy3p5NjQfKLUiVPGGbvkwYripRL+Ro0ZiQXWEX3Y6oKfgo0MnP71y
 dnIOPSptdtBBH2Sif6jrkTD8nSzB0/p7lSmbcG682uLMeDI5haTX6sBcgofkEMsvpHNksxvBj
 FtrMaICi7VkFyQBYRkZaH6jMu73yVH44Eh0JmcUNZct/jFFhxPzDX6seTk/htDuAs/FkayDvv
 fNAp7NLDYE/b/Uox3sdF9NDSlbwldNqydfUezDQ77lHVmK9kl5k88TCdC5f7Z5G0j0NDNLIho
 9Hfg6KDJU9704tSxxCKwGtL4xO/C6YW/mK8nrgHn09yP8l7dzU5JC1inb4yNNFYzKv9TQWLu1
 5RENCtf
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Push pptr down into the FROM_MERGE branch of the if/else statement,
where it's actually used, and call commit_list_append() for appending
elements instead of playing tricks with commit_list_insert().  Call
copy_commit_list() in the amend branch instead of open-coding it.  Don't
bother setting pptr in the final branch as it's not used thereafter.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 builtin/commit.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index a2baa6e..8976c3d 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1642,7 +1642,7 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 	const char *index_file, *reflog_msg;
 	char *nl;
 	unsigned char sha1[20];
-	struct commit_list *parents = NULL, **pptr = &parents;
+	struct commit_list *parents = NULL;
 	struct stat statbuf;
 	struct commit *current_head = NULL;
 	struct commit_extra_header *extra = NULL;
@@ -1688,20 +1688,18 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 		if (!reflog_msg)
 			reflog_msg = "commit (initial)";
 	} else if (amend) {
-		struct commit_list *c;
-
 		if (!reflog_msg)
 			reflog_msg = "commit (amend)";
-		for (c = current_head->parents; c; c = c->next)
-			pptr = &commit_list_insert(c->item, pptr)->next;
+		parents = copy_commit_list(current_head->parents);
 	} else if (whence == FROM_MERGE) {
 		struct strbuf m = STRBUF_INIT;
 		FILE *fp;
 		int allow_fast_forward = 1;
+		struct commit_list **pptr = &parents;
 
 		if (!reflog_msg)
 			reflog_msg = "commit (merge)";
-		pptr = &commit_list_insert(current_head, pptr)->next;
+		pptr = commit_list_append(current_head, pptr);
 		fp = fopen(git_path_merge_head(), "r");
 		if (fp == NULL)
 			die_errno(_("could not open '%s' for reading"),
@@ -1712,7 +1710,7 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 			parent = get_merge_parent(m.buf);
 			if (!parent)
 				die(_("Corrupt MERGE_HEAD file (%s)"), m.buf);
-			pptr = &commit_list_insert(parent, pptr)->next;
+			pptr = commit_list_append(parent, pptr);
 		}
 		fclose(fp);
 		strbuf_release(&m);
@@ -1729,7 +1727,7 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 			reflog_msg = (whence == FROM_CHERRY_PICK)
 					? "commit (cherry-pick)"
 					: "commit";
-		pptr = &commit_list_insert(current_head, pptr)->next;
+		commit_list_insert(current_head, &parents);
 	}
 
 	/* Finally, get the commit message */
-- 
2.10.2

