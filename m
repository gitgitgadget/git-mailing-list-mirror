Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7DC92207DF
	for <e@80x24.org>; Sun, 11 Sep 2016 10:55:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755897AbcIKKzR (ORCPT <rfc822;e@80x24.org>);
        Sun, 11 Sep 2016 06:55:17 -0400
Received: from mout.gmx.net ([212.227.15.18]:54219 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755457AbcIKKzQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Sep 2016 06:55:16 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0LjZhg-1bCAZF0laK-00bfET; Sun, 11 Sep 2016 12:55:05
 +0200
Date:   Sun, 11 Sep 2016 12:55:02 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH v2 17/25] sequencer: support amending commits
In-Reply-To: <cover.1473590966.git.johannes.schindelin@gmx.de>
Message-ID: <68f995eaaad2448f5793f0030f96aa501b985ed5.1473590966.git.johannes.schindelin@gmx.de>
References: <cover.1472457609.git.johannes.schindelin@gmx.de> <cover.1473590966.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:je6vP4dUwbKxWCvUk+uKIO5cli0nKIBpZCbeQsq4Gt7wRyi+h/P
 K4esqKWNTHV64xMM4lReDRiUPwkC02yrGKSEAqLrnUxVjo6WG+XUyD4DmLHd0Faz7PIxLF9
 dU+xW6f2YDigRHWY4VBvCt0N/JkcyTylcD45Byxl6GDIfoEPdVA+AVlkrn9oEy/Jhg8NBTe
 yYL306tK1ih4lMc10syow==
X-UI-Out-Filterresults: notjunk:1;V01:K0:vo4BotZ/BGQ=:g1RjoOD5vygxfTg1Xw9xm3
 V25BaM9Tw9XfLQNClIp8dnglU3hfjFIlL9zoJcTmLr5j3caZuPrOCdZrgeHS1CYmUFlQUrmAK
 2etODh/BpfFU3Ma6LELl5IPolHYXCpPK8eeSFekUudk7uNVnoYqHy04gXM5lnyfuDTRRU0uWD
 0QVU4moqSB2xHJLhddu4QTYRa+983JBCQgBMLYPYFTi5Fg7NHxOhbjTKmYb8wXCSOaR45kno8
 1CoyVhlEgHnoOCGXzhV8RLJJwqPotjJRO858KZ5R4pjx1KSzpDhB7HvV0c7W9ZqZ3hpRNv6Yo
 4an8dBqbralPzRebxsZtVrSCQPj40+/syqqqHgsCNRyk9wsrGkGfOYFtaIdOIKCgcnNkW1rYj
 k8JOLvEBfRTgzpMt1TV6M7dgPPoBxYsExzpPt5uxhrz4fiWuDF5epU2rawXNyYNU6R3Kejf4a
 f3lqVCHYS+qxPqWH5u8PYB5pgKG8peqn0jgScPM35LC2fPPlmDIonBwaMPLq6ft5PG0SnWCoU
 PJstNi51GLIvf3wQLMkT5Ut3siTfU58cempn/lXnm3K7kpPHLW9sNjRWW703VPi+w+puRrtwc
 gEcZ6TIobpMX0tHQpbTbqzCPVTgL+94BaZO8vRnMaOfJ1pHyNIfRcGnUhiWs7fPW5WBeAvoXJ
 jm1t2vuvkDhDuAmC0jWzDCCddIk5NcwtyFctdgA/zefPnqEv0cKvdX17faRIREMkpxeC3elBF
 7tE/1HkX0uojU6Uwlpl3cy2lg77Z4XXC01etZVvDAN1D3Y3UoPCZo9GvrRCD0pe4u+BEhLplz
 zgT6xmC
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This teaches the sequencer_commit() function to take an argument that
will allow us to implement "todo" commands that need to amend the commit
messages ("fixup", "squash" and "reword").

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 sequencer.c | 6 ++++--
 sequencer.h | 2 +-
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 6e9732c..60b522e 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -485,7 +485,7 @@ static char **read_author_script(void)
  * author metadata.
  */
 int sequencer_commit(const char *defmsg, struct replay_opts *opts,
-			  int allow_empty, int edit)
+			  int allow_empty, int edit, int amend)
 {
 	char **env = NULL;
 	struct argv_array array;
@@ -514,6 +514,8 @@ int sequencer_commit(const char *defmsg, struct replay_opts *opts,
 	argv_array_push(&array, "commit");
 	argv_array_push(&array, "-n");
 
+	if (amend)
+		argv_array_push(&array, "--amend");
 	if (opts->gpg_sign)
 		argv_array_pushf(&array, "-S%s", opts->gpg_sign);
 	if (opts->signoff)
@@ -786,7 +788,7 @@ static int do_pick_commit(enum todo_command command, struct commit *commit,
 	}
 	if (!opts->no_commit)
 		res = sequencer_commit(opts->edit ? NULL : git_path_merge_msg(),
-			opts, allow, opts->edit);
+			opts, allow, opts->edit, 0);
 
 leave:
 	free_message(commit, &msg);
diff --git a/sequencer.h b/sequencer.h
index 7f5222f..c45f5c4 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -54,7 +54,7 @@ int sequencer_rollback(struct replay_opts *opts);
 int sequencer_remove_state(struct replay_opts *opts);
 
 int sequencer_commit(const char *defmsg, struct replay_opts *opts,
-			  int allow_empty, int edit);
+			  int allow_empty, int edit, int amend);
 
 extern const char sign_off_header[];
 
-- 
2.10.0.windows.1.10.g803177d


