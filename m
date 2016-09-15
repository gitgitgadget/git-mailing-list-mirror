Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8A3D32070F
	for <e@80x24.org>; Thu, 15 Sep 2016 15:00:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752478AbcIOPAy (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Sep 2016 11:00:54 -0400
Received: from relay4.ptmail.sapo.pt ([212.55.154.24]:60362 "EHLO sapo.pt"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752144AbcIOPAw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Sep 2016 11:00:52 -0400
Received: (qmail 27525 invoked from network); 15 Sep 2016 15:00:50 -0000
Received: (qmail 21797 invoked from network); 15 Sep 2016 15:00:50 -0000
Received: from unknown (HELO catarina.localdomain) (vascomalmeida@sapo.pt@[85.246.157.91])
          (envelope-sender <vascomalmeida@sapo.pt>)
          by ptmail-mta-auth01 (qmail-ptmail-1.0.0) with ESMTPA
          for <git@vger.kernel.org>; 15 Sep 2016 15:00:45 -0000
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
Subject: [PATCH v3 09/14] i18n: notes: mark error messages for translation
Date:   Thu, 15 Sep 2016 14:59:03 +0000
Message-Id: <1473951548-31733-9-git-send-email-vascomalmeida@sapo.pt>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1473951548-31733-1-git-send-email-vascomalmeida@sapo.pt>
References: <1473951548-31733-1-git-send-email-vascomalmeida@sapo.pt>
In-Reply-To: <1473259758-11836-1-git-send-email-vascomalmeida@sapo.pt>
References: <1473259758-11836-1-git-send-email-vascomalmeida@sapo.pt>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Vasco Almeida <vascomalmeida@sapo.pt>
---
 builtin/notes.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/builtin/notes.c b/builtin/notes.c
index f848b89..229ad6d 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -340,7 +340,9 @@ static struct notes_tree *init_notes_check(const char *subcommand,
 
 	ref = (flags & NOTES_INIT_WRITABLE) ? t->update_ref : t->ref;
 	if (!starts_with(ref, "refs/notes/"))
-		die("Refusing to %s notes in %s (outside of refs/notes/)",
+		/* TRANSLATORS: the first %s will be replaced by a
+		   git notes command: 'add', 'merge', 'remove', etc.*/
+		die(_("Refusing to %s notes in %s (outside of refs/notes/)"),
 		    subcommand, ref);
 	return t;
 }
@@ -680,11 +682,11 @@ static int merge_abort(struct notes_merge_options *o)
 	 */
 
 	if (delete_ref("NOTES_MERGE_PARTIAL", NULL, 0))
-		ret += error("Failed to delete ref NOTES_MERGE_PARTIAL");
+		ret += error(_("Failed to delete ref NOTES_MERGE_PARTIAL"));
 	if (delete_ref("NOTES_MERGE_REF", NULL, REF_NODEREF))
-		ret += error("Failed to delete ref NOTES_MERGE_REF");
+		ret += error(_("Failed to delete ref NOTES_MERGE_REF"));
 	if (notes_merge_abort(o))
-		ret += error("Failed to remove 'git notes merge' worktree");
+		ret += error(_("Failed to remove 'git notes merge' worktree"));
 	return ret;
 }
 
@@ -704,11 +706,11 @@ static int merge_commit(struct notes_merge_options *o)
 	 */
 
 	if (get_sha1("NOTES_MERGE_PARTIAL", sha1))
-		die("Failed to read ref NOTES_MERGE_PARTIAL");
+		die(_("Failed to read ref NOTES_MERGE_PARTIAL"));
 	else if (!(partial = lookup_commit_reference(sha1)))
-		die("Could not find commit from NOTES_MERGE_PARTIAL.");
+		die(_("Could not find commit from NOTES_MERGE_PARTIAL."));
 	else if (parse_commit(partial))
-		die("Could not parse commit from NOTES_MERGE_PARTIAL.");
+		die(_("Could not parse commit from NOTES_MERGE_PARTIAL."));
 
 	if (partial->parents)
 		hashcpy(parent_sha1, partial->parents->item->object.oid.hash);
@@ -721,10 +723,10 @@ static int merge_commit(struct notes_merge_options *o)
 	o->local_ref = local_ref_to_free =
 		resolve_refdup("NOTES_MERGE_REF", 0, sha1, NULL);
 	if (!o->local_ref)
-		die("Failed to resolve NOTES_MERGE_REF");
+		die(_("Failed to resolve NOTES_MERGE_REF"));
 
 	if (notes_merge_commit(o, t, partial, sha1))
-		die("Failed to finalize notes merge");
+		die(_("Failed to finalize notes merge"));
 
 	/* Reuse existing commit message in reflog message */
 	memset(&pretty_ctx, 0, sizeof(pretty_ctx));
-- 
2.7.4

