Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3A65A1F42D
	for <e@80x24.org>; Fri, 13 Apr 2018 11:12:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754204AbeDMLL6 (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Apr 2018 07:11:58 -0400
Received: from mout.gmx.net ([212.227.15.15]:59855 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753981AbeDMLL4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Apr 2018 07:11:56 -0400
Received: from [192.168.0.129] ([37.201.203.18]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Mg3Vt-1emNSU10cf-00NPUJ; Fri, 13
 Apr 2018 13:11:51 +0200
Date:   Fri, 13 Apr 2018 13:11:37 +0200 (DST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH] Deprecate support for .git/info/grafts
Message-ID: <0f0942043678fe76f8d654306482ee26fac643f0.1523617836.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:5AeqMqFjk5T1iaS+ejFFgn8C2sT5pGgFW+ue+apSd74b+cMN3R9
 QNGChedQhYR7WSChN85pQDaUGcT9mnDpfW33x2la3hUWENngkPp4+Cu8V7wdXet8QGlmZpF
 8i5S0hrtA8gdSpe20YZRCJ/uqrgUprJaqIs829gzLagRqfBJlsmQPRS2VMEbuzND8VEL1VO
 rUj4/HJEvbwMvvc8k5PDQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:qfoP5UWrX/M=:qQfX6T63CXEbrlhNn/OkFA
 0zHGJdsLtJWQoF2wb+xxziVOYAMRW+Xan9AgnE4b/vXx1otUCnpT16tk4lnc2/Yn606OJRqrZ
 Re5fOyJr3UZoNvbt7ltyxn8ODij4/4ONu6RrDWR08MuVwAfRhoUZCn6uHMLjVPk6fg7weH/+I
 Oc7BAPtdJHDG2zldbQRSQQ3i/iVwppLfGrKNh+QICmpfyMC2o8fHSwFIO1KITbgGSDfX/zGIj
 bkHfxflnx0zhfHciqHohtcfRug0rMAwLPhxkVLatezF9nNvMTe2ebap0Oa3oy3H3upQ6SXhoG
 Iam5vgMCfNFDC4WKcDCNknhpy+LnqAizJKm76z6q4gdTkyr5Y3/yAZDFqwNRDi++BiL64e7XP
 lZSHn95u+xk7RVpYCNuWpNtjww7hEkzOE+L905uAPxXcKvqCA+N+EFrHUnq3l0K9VSm/7hJ8X
 J3ohyVCnXBPfHA/EYW1RJMxup7mUMEPaMxfv76BMsENF1L7q9apDNZHwUL6LnhjGBO7jXdhwY
 NkQPLiHqKEeqeJIRD844sxCpE1vTMMYyt3lqsBpjcNsYrF2KtoMmgTqgrNVobNTmsEMsklJ9P
 Qc3sJc+MrcafkYZpLyDmIYtbXoJdSc6tXqBSDstQHOBj/2AgaJGJ0kJQaHOgF78oEwSbrLCYh
 4QVUZv7OEPaO4fY9uoSFqzFYFNOdMfiaW/J0mIcaGR1lX+xxff9JGFeZl+l2fAHt1We/lE+Wi
 SaN67NqqSholqMTLonj9uNCoirB5GbHMiOLEyPZ+1HARzyK9oyr8lKBdOmYnboJ3BcjDje3IP
 5wzI8Q7uhkLLjN4K4gFgs7KvVM5IHfIQOXEFYvKCsVNQilDM0A=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The grafts feature was a convenient way to "stich together" ancient
history to the fresh start of linux.git.

Its implementation is, however, not up to Git's standards, as there are
too many ways where it can lead to surprising and unwelcome behavior.

For example, when pushing from a repository with active grafts, it is
possible to miss commits that have been "grafted out", resulting in a
broken state on the other side.

Also, the grafts feature is limited to "rewriting" commits' list of
parents, it cannot replace anything else.

The much younger feature implemented as `git replace` set out to remedy
those limitations and dangerous bugs.

Seeing as `git replace` is pretty mature by now, it is time to deprecate
support for the graft file, and to retire it eventually.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 advice.c                  | 2 ++
 advice.h                  | 1 +
 commit.c                  | 9 +++++++++
 t/t6001-rev-list-graft.sh | 9 +++++++++
 4 files changed, 21 insertions(+)

diff --git a/advice.c b/advice.c
index 406efc183ba..4411704fd45 100644
--- a/advice.c
+++ b/advice.c
@@ -19,6 +19,7 @@ int advice_rm_hints = 1;
 int advice_add_embedded_repo = 1;
 int advice_ignored_hook = 1;
 int advice_waiting_for_editor = 1;
+int advice_graft_file_deprecated = 1;
 
 static struct {
 	const char *name;
@@ -42,6 +43,7 @@ static struct {
 	{ "addembeddedrepo", &advice_add_embedded_repo },
 	{ "ignoredhook", &advice_ignored_hook },
 	{ "waitingforeditor", &advice_waiting_for_editor },
+	{ "graftfiledeprecated", &advice_graft_file_deprecated },
 
 	/* make this an alias for backward compatibility */
 	{ "pushnonfastforward", &advice_push_update_rejected }
diff --git a/advice.h b/advice.h
index 70568fa7922..9f5064e82a8 100644
--- a/advice.h
+++ b/advice.h
@@ -21,6 +21,7 @@ extern int advice_rm_hints;
 extern int advice_add_embedded_repo;
 extern int advice_ignored_hook;
 extern int advice_waiting_for_editor;
+extern int advice_graft_file_deprecated;
 
 int git_default_advice_config(const char *var, const char *value);
 __attribute__((format (printf, 1, 2)))
diff --git a/commit.c b/commit.c
index ca474a7c112..a96b0a27154 100644
--- a/commit.c
+++ b/commit.c
@@ -12,6 +12,7 @@
 #include "prio-queue.h"
 #include "sha1-lookup.h"
 #include "wt-status.h"
+#include "advice.h"
 
 static struct commit_extra_header *read_commit_extra_header_lines(const char *buf, size_t len, const char **);
 
@@ -176,6 +177,14 @@ static int read_graft_file(const char *graft_file)
 	struct strbuf buf = STRBUF_INIT;
 	if (!fp)
 		return -1;
+	if (advice_graft_file_deprecated)
+		advise(_("Support for <GIT_DIR>/info/grafts is deprecated\n"
+			 "and will be removed in a future Git version.\n"
+			 "\n"
+			 "Please use \"git replace --graft [...]\" instead.\n"
+			 "\n"
+			 "Turn this message off by running\n"
+			 "\"git config advice.graftFileDeprecated false\""));
 	while (!strbuf_getwholeline(&buf, fp, '\n')) {
 		/* The format is just "Commit Parent1 Parent2 ...\n" */
 		struct commit_graft *graft = read_graft_line(&buf);
diff --git a/t/t6001-rev-list-graft.sh b/t/t6001-rev-list-graft.sh
index 05ddc69cf2a..7504ba47511 100755
--- a/t/t6001-rev-list-graft.sh
+++ b/t/t6001-rev-list-graft.sh
@@ -110,4 +110,13 @@ do
 	"
 
 done
+
+test_expect_success 'show advice that grafts are deprecated' '
+	git show HEAD 2>err &&
+	test_i18ngrep "git replace" err &&
+	test_config advice.graftFileDeprecated false &&
+	git show HEAD 2>err &&
+	test_i18ngrep ! "git replace" err
+'
+
 test_done

base-commit: fe0a9eaf31dd0c349ae4308498c33a5c3794b293
-- 
2.17.0.windows.1.4.g7e4058d72e3

Published-As: https://github.com/dscho/git/releases/tag/deprecate-grafts-v1
Fetch-It-Via: git fetch https://github.com/dscho/git deprecate-grafts-v1
