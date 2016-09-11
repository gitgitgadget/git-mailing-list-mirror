Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 38C83207DF
	for <e@80x24.org>; Sun, 11 Sep 2016 10:55:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755893AbcIKKzC (ORCPT <rfc822;e@80x24.org>);
        Sun, 11 Sep 2016 06:55:02 -0400
Received: from mout.gmx.net ([212.227.15.19]:59542 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755457AbcIKKzB (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Sep 2016 06:55:01 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0LnOve-1b7D1r0XwE-00hhS0; Sun, 11 Sep 2016 12:54:57
 +0200
Date:   Sun, 11 Sep 2016 12:54:55 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH v2 16/25] sequencer: allow editing the commit message on a
 case-by-case basis
In-Reply-To: <cover.1473590966.git.johannes.schindelin@gmx.de>
Message-ID: <eb2df2a784ab76dbe5c139e42c2c21f3c0484017.1473590966.git.johannes.schindelin@gmx.de>
References: <cover.1472457609.git.johannes.schindelin@gmx.de> <cover.1473590966.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:SUra8IgzRdm7P3Q5jbEWJm2xUtOGpq7Pa4TShEO6Cov2HrRuJBH
 T/QenhHpvrIYLbTm/e9CH3ruHyPCzQTuHJ8tW8POvVRHPcR+QAaSl3CuEqCI8DtEF8piAGl
 wBN9/QkKfqPe4NWPuwyb1kUtp+eTuYe6YFch/1KKDXCiW79sxyDQQj0GXV4ksCznebNyx7a
 qY2jd7aYL9jgxIaWfS6ag==
X-UI-Out-Filterresults: notjunk:1;V01:K0:r25ZeuuP+kg=:CLKpN8vnmCF3g2KxHla3p2
 EgefAE1be/sAW5G9glcxRvyzEF00SeZzTABdTzA2H+vlNZFUON3MQRtHZawbhn/EZyBwF28tf
 XeweviAkcRQmJnEZqo2RuexixTygGtHZN78lKLFR8HoKhUogA+710E7YP/H3HVTmECLgJ8Jol
 CtjMdTpnGXWEQ+a9PO0DJPauyEfo6ko7kDJWi1iAzedxPgia8H3sgQ1OLhRzzD1CF7qMi2c+N
 8ifupFYnlVaWbJXP3NJVLB14TmUGhQ7PUhmzM8OTOZqGcP6C9aDu52+3aYLRM/8D8CRMkmLXF
 QdLAcRl6aDofEirq3yZMH02yFUodpxEGOWpqatZZHNJocvKboS6w5h4B10chtKgEVkmCKpYfj
 MyaFebOzM2dHg5vZ0EKpgS4SyVCI+iccbSOXMqhS/e3lbeZn1swVPXJLTuIUXBFY4raIAowhX
 u6ecNY4Pc888d+0lC2bHPxcXsdHo6htXI6wA74Eht2sPyCL1ZNvvRJ9F8nxYmNnwx9FrJWS60
 30JbVHTdE2/r3ZES05EFyRstDo74ljBJwCoCMb16+MDuoNoRxVW9RkbMwncmhDcjWJ/4v9yW/
 OmL6pe36Xe2gH7Z/Zz6N0GiQGwbIx6DaxK+ND6GcVDE63q3Z2shZ5fp+Bvbx8rQxluW3D4gcm
 wTroyFPuRWHZVW4ArHFW3e8SkDcCtgRPzKEHFvsO0ju/7He5sMjTmllgEOssBACAJjIjlWgeP
 zkLkaXT5zMfHppV//iRoXy+dALY0KhOOQTJUA63MdLKh/WGUAqJfcYORYcYzFmmfEdGTQFahB
 Is4t26u
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In the upcoming commits, we will implement more and more of rebase
-i's functionality. One particular feature of the commands to come is
that some of them allow editing the commit message while others don't,
i.e. we cannot define in the replay_opts whether the commit message
should be edited or not.

Let's add a new parameter to the sequencer_commit() function. Previously,
it was the duty of the caller to ensure that the opts->edit setting
indicates whether to let the user edit the commit message or not,
indicating that it is an "all or nothing" setting, i.e. that the sequencer
wants to let the user edit *all* commit message, or none at all. In the
upcoming rebase -i mode, it will depend on the particular command that is
currently executed, though.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 sequencer.c | 6 +++---
 sequencer.h | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index bf02565..6e9732c 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -485,7 +485,7 @@ static char **read_author_script(void)
  * author metadata.
  */
 int sequencer_commit(const char *defmsg, struct replay_opts *opts,
-			  int allow_empty)
+			  int allow_empty, int edit)
 {
 	char **env = NULL;
 	struct argv_array array;
@@ -520,7 +520,7 @@ int sequencer_commit(const char *defmsg, struct replay_opts *opts,
 		argv_array_push(&array, "-s");
 	if (defmsg)
 		argv_array_pushl(&array, "-F", defmsg, NULL);
-	if (opts->edit)
+	if (edit)
 		argv_array_push(&array, "-e");
 	else if (!opts->signoff && !opts->record_origin &&
 		 git_config_get_value("commit.cleanup", &value))
@@ -786,7 +786,7 @@ static int do_pick_commit(enum todo_command command, struct commit *commit,
 	}
 	if (!opts->no_commit)
 		res = sequencer_commit(opts->edit ? NULL : git_path_merge_msg(),
-			opts, allow);
+			opts, allow, opts->edit);
 
 leave:
 	free_message(commit, &msg);
diff --git a/sequencer.h b/sequencer.h
index 16deb6c..7f5222f 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -54,7 +54,7 @@ int sequencer_rollback(struct replay_opts *opts);
 int sequencer_remove_state(struct replay_opts *opts);
 
 int sequencer_commit(const char *defmsg, struct replay_opts *opts,
-			  int allow_empty);
+			  int allow_empty, int edit);
 
 extern const char sign_off_header[];
 
-- 
2.10.0.windows.1.10.g803177d


