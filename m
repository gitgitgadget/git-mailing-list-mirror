Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6CB6E207DF
	for <e@80x24.org>; Sun, 11 Sep 2016 10:55:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755932AbcIKKzj (ORCPT <rfc822;e@80x24.org>);
        Sun, 11 Sep 2016 06:55:39 -0400
Received: from mout.gmx.net ([212.227.17.20]:58711 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755457AbcIKKzi (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Sep 2016 06:55:38 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0MTSmp-1bZSJW3iWF-00SMz2; Sun, 11 Sep 2016 12:55:34
 +0200
Date:   Sun, 11 Sep 2016 12:55:33 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH v2 18/25] sequencer: support cleaning up commit messages
In-Reply-To: <cover.1473590966.git.johannes.schindelin@gmx.de>
Message-ID: <773ba280e64c2dfabff0d6e6a0a0808482461677.1473590966.git.johannes.schindelin@gmx.de>
References: <cover.1472457609.git.johannes.schindelin@gmx.de> <cover.1473590966.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:BriN3/v9heQTknGbrOKtOSOGJKCzdiExSlDo4fuG24Ql55EPFwx
 sorbj/Iuhnb5vPKStWr4ded+iwUPek01guKMcXXEtVDn2rzYdY8UEo2BZpZFtUebwUC/m/s
 driuj7+RoWnNMf/7+atNDNYQA+1uafgekE2Lq+2uP4LfYMPC+m9AlAacK2kCsiApNlJ49ws
 Ft7Ta4CzzuoEqcLSPLDxA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Uz3OAnZ3Rvc=:5xhaiWgY/wOl38z5T+f6/E
 K1TNiFzMYHgm6V13UbnlQ8EE8kwoI+gG5A1SyCeTTOqNLziwXO6ZF/VPQUrCgKZvbdglfeGKO
 OLGKXsywgmz6BgFyc+a4sw6Mp1UXPVVVicAsDymBBucw2fJIl7Wdewk+X0vB0+CHZrc5UZek/
 NTGM0r8YOrWe7xOYbbqDgmU1QJdbLFiMQCrULUQKpFQftHrCwA4A6w4f1nZEQgSqqgBkenj1Z
 FJcrYZ4sjOCg1v0zAX2SGsjjZsOYvrcPGUoEPrkhfWvYnN5qZi95DNpq4LV1q0HsOjgeFhBfK
 k7C0gHMm7/FBhoyIc5scLWQZ2m93GdvRkVTstqDlUbflvnfbUwUjKjj2W3WVJ48CJzFxx7gOs
 9vJCfDXvX5cHLfOwXQFeRff00NkkEIYmiMxQfGdRevf7EkJjUlu8LmVVd7Y3iLkUvmP2Kurda
 avycVZY/YFQRKbjgPct/sTtICjjeNFlm97IDKZJMvgGuW2/IdNK02ZnNQdqYMAPbf+1PNNlM6
 PSYXvi+wYG44q9M6m35C8KnKD84xXue2hHdULO3jszQrDcuxwCRgqlgpHSTm/NpWUo2K9uCI/
 69Yp1ukXMDcAOpnsH1yP2fIAdfYd8Vtkw7KPskBOOBNHIrdHbCvU6o1rVaJp3Qx30moZMlD5e
 5aj7Bw7ijsbT78aFBOhW/RvRejxD+Pkx/FqL5XFA1QPo1JpONrycqzf1YYS04afRfHpVCUnou
 Q7QPGiKxXVmXM0+wtkdUrQxVdWmBcBdDiZB4x5O5ZYvdNicekdP6NW+MtQxZScs52hq36kP75
 4AmtGKU
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The sequencer_commit() function already knows how to amend commits, and
with this new option, it can also clean up commit messages (i.e. strip
out commented lines). This is needed to implement rebase -i's 'fixup'
and 'squash' commands as sequencer commands.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 sequencer.c | 10 +++++++---
 sequencer.h |  3 ++-
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 60b522e..75772b8 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -485,7 +485,8 @@ static char **read_author_script(void)
  * author metadata.
  */
 int sequencer_commit(const char *defmsg, struct replay_opts *opts,
-			  int allow_empty, int edit, int amend)
+			  int allow_empty, int edit, int amend,
+			  int cleanup_commit_message)
 {
 	char **env = NULL;
 	struct argv_array array;
@@ -522,9 +523,12 @@ int sequencer_commit(const char *defmsg, struct replay_opts *opts,
 		argv_array_push(&array, "-s");
 	if (defmsg)
 		argv_array_pushl(&array, "-F", defmsg, NULL);
+	if (cleanup_commit_message)
+		argv_array_push(&array, "--cleanup=strip");
 	if (edit)
 		argv_array_push(&array, "-e");
-	else if (!opts->signoff && !opts->record_origin &&
+	else if (!cleanup_commit_message &&
+		 !opts->signoff && !opts->record_origin &&
 		 git_config_get_value("commit.cleanup", &value))
 		argv_array_push(&array, "--cleanup=verbatim");
 
@@ -788,7 +792,7 @@ static int do_pick_commit(enum todo_command command, struct commit *commit,
 	}
 	if (!opts->no_commit)
 		res = sequencer_commit(opts->edit ? NULL : git_path_merge_msg(),
-			opts, allow, opts->edit, 0);
+			opts, allow, opts->edit, 0, 0);
 
 leave:
 	free_message(commit, &msg);
diff --git a/sequencer.h b/sequencer.h
index c45f5c4..688fff1 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -54,7 +54,8 @@ int sequencer_rollback(struct replay_opts *opts);
 int sequencer_remove_state(struct replay_opts *opts);
 
 int sequencer_commit(const char *defmsg, struct replay_opts *opts,
-			  int allow_empty, int edit, int amend);
+			  int allow_empty, int edit, int amend,
+			  int cleanup_commit_message);
 
 extern const char sign_off_header[];
 
-- 
2.10.0.windows.1.10.g803177d


