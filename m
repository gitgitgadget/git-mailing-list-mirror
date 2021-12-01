Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3C58C433FE
	for <git@archiver.kernel.org>; Wed,  1 Dec 2021 22:16:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353364AbhLAWTn (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Dec 2021 17:19:43 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:33939 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S243260AbhLAWTm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Dec 2021 17:19:42 -0500
Received: from localhost (198-27-191-186.fiber.dynamic.sonic.net [198.27.191.186])
        (authenticated bits=0)
        (User authenticated as andersk@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 1B1MG9KO012592
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 1 Dec 2021 17:16:11 -0500
From:   Anders Kaseorg <andersk@mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        Andreas Heiduk <andreas.heiduk@mathema.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason=20?= 
        <avarab@gmail.com>, Jiang Xin <worldhello.net@gmail.com>,
        Anders Kaseorg <andersk@mit.edu>
Subject: [PATCH v7 3/8] branch: lowercase error messages
Date:   Wed,  1 Dec 2021 14:15:42 -0800
Message-Id: <20211201221547.1796213-4-andersk@mit.edu>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211201221547.1796213-1-andersk@mit.edu>
References: <20211201221547.1796213-1-andersk@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Documentation/CodingGuidelines says “do not end error messages with a
full stop” and “do not capitalize the first word”.  Clean up existing
messages, some of which we will be touching in later steps in the
series, that deviate from these rules in this file, as a preparation for
the main part of the topic.

Signed-off-by: Anders Kaseorg <andersk@mit.edu>
---
 branch.c                   | 20 ++++++++++----------
 t/t2018-checkout-branch.sh |  2 +-
 t/t3200-branch.sh          |  4 ++--
 3 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/branch.c b/branch.c
index 07a46430b3..85777b939b 100644
--- a/branch.c
+++ b/branch.c
@@ -64,7 +64,7 @@ int install_branch_config(int flag, const char *local, const char *origin, const
 	if (skip_prefix(remote, "refs/heads/", &shortname)
 	    && !strcmp(local, shortname)
 	    && !origin) {
-		warning(_("Not setting branch %s as its own upstream."),
+		warning(_("not setting branch %s as its own upstream"),
 			local);
 		return 0;
 	}
@@ -116,7 +116,7 @@ int install_branch_config(int flag, const char *local, const char *origin, const
 
 out_err:
 	strbuf_release(&key);
-	error(_("Unable to write upstream branch configuration"));
+	error(_("unable to write upstream branch configuration"));
 
 	advise(_(tracking_advice),
 	       origin ? origin : "",
@@ -153,7 +153,7 @@ static void setup_tracking(const char *new_ref, const char *orig_ref,
 		}
 
 	if (tracking.matches > 1)
-		die(_("Not tracking: ambiguous information for ref %s"),
+		die(_("not tracking: ambiguous information for ref %s"),
 		    orig_ref);
 
 	if (install_branch_config(config_flags, new_ref, tracking.remote,
@@ -186,7 +186,7 @@ int read_branch_desc(struct strbuf *buf, const char *branch_name)
 int validate_branchname(const char *name, struct strbuf *ref)
 {
 	if (strbuf_check_branch_ref(ref, name))
-		die(_("'%s' is not a valid branch name."), name);
+		die(_("'%s' is not a valid branch name"), name);
 
 	return ref_exists(ref->buf);
 }
@@ -205,12 +205,12 @@ int validate_new_branchname(const char *name, struct strbuf *ref, int force)
 		return 0;
 
 	if (!force)
-		die(_("A branch named '%s' already exists."),
+		die(_("a branch named '%s' already exists"),
 		    ref->buf + strlen("refs/heads/"));
 
 	head = resolve_ref_unsafe("HEAD", 0, NULL, NULL);
 	if (!is_bare_repository() && head && !strcmp(head, ref->buf))
-		die(_("Cannot force update the current branch."));
+		die(_("cannot force update the current branch"));
 
 	return 1;
 }
@@ -230,7 +230,7 @@ static int validate_remote_tracking_branch(char *ref)
 }
 
 static const char upstream_not_branch[] =
-N_("Cannot setup tracking information; starting point '%s' is not a branch.");
+N_("cannot set up tracking information; starting point '%s' is not a branch");
 static const char upstream_missing[] =
 N_("the requested upstream branch '%s' does not exist");
 static const char upstream_advice[] =
@@ -278,7 +278,7 @@ void create_branch(struct repository *r,
 			}
 			die(_(upstream_missing), start_name);
 		}
-		die(_("Not a valid object name: '%s'."), start_name);
+		die(_("not a valid object name: '%s'"), start_name);
 	}
 
 	switch (dwim_ref(start_name, strlen(start_name), &oid, &real_ref, 0)) {
@@ -298,12 +298,12 @@ void create_branch(struct repository *r,
 		}
 		break;
 	default:
-		die(_("Ambiguous object name: '%s'."), start_name);
+		die(_("ambiguous object name: '%s'"), start_name);
 		break;
 	}
 
 	if ((commit = lookup_commit_reference(r, &oid)) == NULL)
-		die(_("Not a valid branch point: '%s'."), start_name);
+		die(_("not a valid branch point: '%s'"), start_name);
 	oidcpy(&oid, &commit->object.oid);
 
 	if (reflog)
diff --git a/t/t2018-checkout-branch.sh b/t/t2018-checkout-branch.sh
index 93be1c0eae..3e93506c04 100755
--- a/t/t2018-checkout-branch.sh
+++ b/t/t2018-checkout-branch.sh
@@ -148,7 +148,7 @@ test_expect_success 'checkout -b to an existing branch fails' '
 test_expect_success 'checkout -b to @{-1} fails with the right branch name' '
 	git checkout branch1 &&
 	git checkout branch2 &&
-	echo  >expect "fatal: A branch named '\''branch1'\'' already exists." &&
+	echo  >expect "fatal: a branch named '\''branch1'\'' already exists" &&
 	test_must_fail git checkout -b @{-1} 2>actual &&
 	test_cmp expect actual
 '
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index e575ffb4ff..498cea31bd 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -866,7 +866,7 @@ test_expect_success '--set-upstream-to fails on a missing src branch' '
 '
 
 test_expect_success '--set-upstream-to fails on a non-ref' '
-	echo "fatal: Cannot setup tracking information; starting point '"'"'HEAD^{}'"'"' is not a branch." >expect &&
+	echo "fatal: cannot set up tracking information; starting point '"'"'HEAD^{}'"'"' is not a branch" >expect &&
 	test_must_fail git branch --set-upstream-to HEAD^{} 2>err &&
 	test_cmp expect err
 '
@@ -953,7 +953,7 @@ test_expect_success 'disabled option --set-upstream fails' '
 test_expect_success '--set-upstream-to notices an error to set branch as own upstream' '
 	git branch --set-upstream-to refs/heads/my13 my13 2>actual &&
 	cat >expect <<-\EOF &&
-	warning: Not setting branch my13 as its own upstream.
+	warning: not setting branch my13 as its own upstream
 	EOF
 	test_expect_code 1 git config branch.my13.remote &&
 	test_expect_code 1 git config branch.my13.merge &&
-- 
2.34.1

