From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH 3/3] builtin/checkout: learn -B
Date: Tue, 22 Jun 2010 01:19:42 +0800
Message-ID: <1277140782-4064-4-git-send-email-rctay89@gmail.com>
References: <7vpqzlrmo4.fsf@alter.siamese.dyndns.org>
 <1277140782-4064-1-git-send-email-rctay89@gmail.com>
 <1277140782-4064-2-git-send-email-rctay89@gmail.com>
 <1277140782-4064-3-git-send-email-rctay89@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Clemens Buchacher <drizzd@aon.at>,
	Michel Lespinasse <walken@google.com>,
	Erick Mattos <erick.mattos@gmail.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jun 21 19:20:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OQkfi-0007d1-M8
	for gcvg-git-2@lo.gmane.org; Mon, 21 Jun 2010 19:20:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932457Ab0FURU3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jun 2010 13:20:29 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:47325 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932176Ab0FURU2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jun 2010 13:20:28 -0400
Received: by pwj8 with SMTP id 8so402008pwj.19
        for <git@vger.kernel.org>; Mon, 21 Jun 2010 10:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=M+rkuRuF4xaxfiLanoqsMgiD1OeEEQpgVQTO1OepV0g=;
        b=oLtqSWRAQdgzl8agVtu2rSrM/5vTSoHsZY3lhxVYAF0tG7Cn6X9V1cuExxh5XlLbzf
         +JUg3GKakV7x3flM4NweKSQLhrMni0rLrEaMD+sRY7nS3x8pCLeRLphUEMKsytOUSXIf
         8v2wlHxufpr1DtA+x/Wn7zorpS79T8BJ9Kjv8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=P056pcpuDr4mL8vMagC4FPQvLE6pdORSEzJty0gYvBz7h1ue/uXFXBTatAMnzOfAyU
         TUAJIT6fr9VWaQJG5RuNQvZuhm3FSjGLSLpJ6FqUEES2xRBNB/JqDmXFBN3w7HNf80Bg
         JSvu+g3/S4rl8ltKoAKroeVM5G6EwHCrlV9Wk=
Received: by 10.115.100.15 with SMTP id c15mr4229280wam.11.1277140827053;
        Mon, 21 Jun 2010 10:20:27 -0700 (PDT)
Received: from localhost.localdomain (cm134.zeta152.maxonline.com.sg [116.87.152.134])
        by mx.google.com with ESMTPS id b6sm32760016wam.21.2010.06.21.10.20.22
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 21 Jun 2010 10:20:26 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.513.g06a69
In-Reply-To: <1277140782-4064-3-git-send-email-rctay89@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149423>

Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
---
 Documentation/git-checkout.txt |   15 +++++++++++-
 builtin/checkout.c             |    7 ++++-
 t/t2018-checkout-branch.sh     |   45 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 63 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkout.txt
index 261dd90..5849e13 100644
--- a/Documentation/git-checkout.txt
+++ b/Documentation/git-checkout.txt
@@ -9,7 +9,7 @@ SYNOPSIS
 --------
 [verse]
 'git checkout' [-q] [-f] [-m] [<branch>]
-'git checkout' [-q] [-f] [-m] [[-b|--orphan] <new_branch>] [<start_point>]
+'git checkout' [-q] [-f] [-m] [[-b|-B|--orphan] <new_branch>] [<start_point>]
 'git checkout' [-f|--ours|--theirs|-m|--conflict=<style>] [<tree-ish>] [--] <paths>...
 'git checkout' --patch [<tree-ish>] [--] [<paths>...]
 
@@ -21,7 +21,7 @@ also update `HEAD` to set the specified branch as the current
 branch.
 
 'git checkout' [<branch>]::
-'git checkout' -b <new branch> [<start point>]::
+'git checkout' -b|-B <branch> [<start point>]::
 
 	This form switches branches by updating the index, working
 	tree, and HEAD to reflect the specified branch.
@@ -31,6 +31,13 @@ were called and then checked out; in this case you can
 use the `--track` or `--no-track` options, which will be passed to
 'git branch'.  As a convenience, `--track` without `-b` implies branch
 creation; see the description of `--track` below.
++
+If `-B` is given, <branch> is created if it doesn't exist; otherwise, it
+is reset. This is equivalent to
++
+------------
+$ git branch -f <branch> [<start point>] && git checkout <branch>
+------------
 
 'git checkout' [--patch] [<tree-ish>] [--] <pathspec>...::
 
@@ -75,6 +82,10 @@ entries; instead, unmerged entries are ignored.
 	Create a new branch named <new_branch> and start it at
 	<start_point>; see linkgit:git-branch[1] for details.
 
+-B::
+	Checks out to the branch named <branch>, creating it if it does
+	not exist; otherwise, the branch is reset.
+
 -t::
 --track::
 	When creating a new branch, set up "upstream" configuration. See
diff --git a/builtin/checkout.c b/builtin/checkout.c
index e794e1e..f7c2cdd 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -512,7 +512,8 @@ static void update_refs_for_switch(struct checkout_opts *opts,
 			}
 		}
 		else
-			create_branch(old->name, opts->new_branch_name, new->name, 0,
+			create_branch(old->name, opts->new_branch_name, new->name,
+				      opts->new_branch > 1,
 				      opts->new_branch_log, opts->track);
 		new->name = opts->new_branch_name;
 		setup_branch_path(new);
@@ -660,6 +661,8 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 		OPT__QUIET(&opts.quiet),
 		OPT_SET_INT('b', NULL, &opts.new_branch,
 			    "create and checkout a new branch", 1),
+		OPT_SET_INT('B', NULL, &opts.new_branch,
+			    "create and checkout a branch, resetting it if it exists", 2),
 		OPT_BOOLEAN('l', NULL, &opts.new_branch_log, "log for new branch"),
 		OPT_SET_INT('t', "track",  &opts.track, "track",
 			BRANCH_TRACK_EXPLICIT),
@@ -869,7 +872,7 @@ no_reference:
 		if (strbuf_check_branch_ref(&buf, opts.new_branch_name))
 			die("git checkout: we do not like '%s' as a branch name.",
 			    opts.new_branch_name);
-		if (!get_sha1(buf.buf, rev))
+		if (!get_sha1(buf.buf, rev) && !(opts.new_branch > 1))
 			die("git checkout: branch %s already exists", opts.new_branch_name);
 		strbuf_release(&buf);
 	}
diff --git a/t/t2018-checkout-branch.sh b/t/t2018-checkout-branch.sh
index 3c13065..1caffea 100755
--- a/t/t2018-checkout-branch.sh
+++ b/t/t2018-checkout-branch.sh
@@ -118,4 +118,49 @@ test_expect_success 'checkout -b to an existing branch fails' '
 	test_must_fail do_checkout branch2 $HEAD2
 '
 
+test_expect_success 'checkout -B to an existing branch resets branch to HEAD' '
+	git checkout branch1 &&
+
+	do_checkout branch2 "" -B
+'
+
+test_expect_success 'checkout -B to an existing branch with an explicit ref resets branch to that ref' '
+	git checkout branch1 &&
+
+	do_checkout branch2 $HEAD1 -B
+'
+
+test_expect_success 'checkout -B to an existing branch with unmergeable changes fails' '
+	git checkout branch1 &&
+
+	setup_dirty_unmergeable &&
+	test_must_fail do_checkout branch2 $HEAD1 -B &&
+	test_dirty_unmergeable
+'
+
+test_expect_success 'checkout -f -B to an existing branch with unmergeable changes discards changes' '
+	# still dirty and on branch1
+	do_checkout branch2 $HEAD1 "-f -B" &&
+	test_must_fail test_dirty_unmergeable
+'
+
+test_expect_success 'checkout -B to an existing branch preserves mergeable changes' '
+	git checkout branch1 &&
+
+	setup_dirty_mergeable &&
+	do_checkout branch2 $HEAD1 -B &&
+	test_dirty_mergeable
+'
+
+test_expect_success 'checkout -f -B to an existing branch with mergeable changes discards changes' '
+	# clean up from previous test
+	git reset --hard &&
+
+	git checkout branch1 &&
+
+	setup_dirty_mergeable &&
+	do_checkout branch2 $HEAD1 "-f -B" &&
+	test_must_fail test_dirty_mergeable
+'
+
 test_done
-- 
1.7.1.513.g4f18
