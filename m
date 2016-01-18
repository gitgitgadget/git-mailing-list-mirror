From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v3 0/5] ls-remote: introduce symref argument
Date: Tue, 19 Jan 2016 00:20:45 +0100
Message-ID: <1453159250-21298-1-git-send-email-t.gummerer@gmail.com>
References: <1453136238-19448-1-git-send-email-t.gummerer@gmail.com>
Cc: peff@peff.net, bturner@atlassian.com, gitster@pobox.com,
	pedrorijo91@gmail.com, Thomas Gummerer <t.gummerer@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 19 00:21:22 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aLJ6v-0006iQ-MJ
	for gcvg-git-2@plane.gmane.org; Tue, 19 Jan 2016 00:21:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754095AbcARXUn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Jan 2016 18:20:43 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33682 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752745AbcARXUl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jan 2016 18:20:41 -0500
Received: by mail-wm0-f66.google.com with SMTP id u188so19463984wmu.0
        for <git@vger.kernel.org>; Mon, 18 Jan 2016 15:20:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=O/DMnDEBevYALbaaKeUPs5QunGj4UV1m5wxi/xoyMSI=;
        b=KDnM9Q9Dvn0ERNkov5aQpMu5q9dk6jO9yUVNNNSOnOtkmBsI4Lyg08VPVRhx0lTKAO
         ovTPhmR16BAvC1fQxn6Kt/cbUfBSgEi6bR70z917JneOntCDs/+llVb30gF+S+DTUXfw
         2xM8pt0Nq6Nt/ZBnj+CgVFuCwgv0ZhSXMpKgLUHCX2oy5UduPk2rWBbRPZG4s7gNUZaI
         lV0p5ypVK60SJfKZNkKSVqI4zkq5an+9YVFKfV72XD6Q998sqw5WtHshXVRQccmJm5E9
         qno0rowwZX18t5fb8YkEePCHj26DYMfm0tgAbqwGr+CqGVFKdYMLBkYynBO/NXi3cJur
         j9hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=O/DMnDEBevYALbaaKeUPs5QunGj4UV1m5wxi/xoyMSI=;
        b=cC5Y+HhnoKIPKC5CckajYtcMgJbCsM5m8M+VXrnNc1AI9UkVGLMvFEqHv3xF5fi8V6
         ovF3N1iEn4n1D89I0/uIo44XXhkvsTSZqyp6sBZYqOwmymycMnZXNFV74Qj39aH4Q2H+
         +50bRiFxzyPyRgekbbxnGOud7pdp9uGSbW+hiq8oQeTUQHiZDDg0dIr3sj1OprMO5w9H
         nrve32yFQxaXpXHNRQm6kTFY6zYQ8VcEM7J+e55155gHf5TTQX1k9wUEZEyZ8pAhovIj
         ebn27/Iv7cVmsdFyDe2ZU+oHZ1t7ZVt/rt7kAKaxNHlolWyUJmXN+YbRF6MCH/nszw9D
         OymA==
X-Gm-Message-State: ALoCoQnY8wC1Ys8UqBuPIDnY21vOBD+x1m8spnf+s/OZuo0Cd627fYqii5Go3waEdGc13F1qsQaxiWbcvLuz/OEKBPjvCSUI1A==
X-Received: by 10.194.110.230 with SMTP id id6mr25532491wjb.67.1453159240179;
        Mon, 18 Jan 2016 15:20:40 -0800 (PST)
Received: from localhost (host113-108-dynamic.249-95-r.retail.telecomitalia.it. [95.249.108.113])
        by smtp.gmail.com with ESMTPSA id l2sm25843816wjf.15.2016.01.18.15.20.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Jan 2016 15:20:38 -0800 (PST)
X-Mailer: git-send-email 2.7.0.30.g56a8654.dirty
In-Reply-To: <1453136238-19448-1-git-send-email-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284336>

The previous rounds are at $gmane/284248.  Thanks to Peff and Junio
for reviewing and suggestions on the previous round.

Changes from the previous round:
 - Slightly reworded the documentation for the --refs option
 - Small fix in the commit message of patch 4.
 - use <<-\EOF instead of <<-EOF in the tests
 - added a note about upload-pack only showing the HEAD symref
 - squashed in tests by peff
 - changed --symrefs option to --symref
 - reworded description and documentation of the option according to
   comments from junio.

Interdiff below:

diff --git a/Documentation/git-ls-remote.txt b/Documentation/git-ls-remote.txt
index 9356df2..5f2628c 100644
--- a/Documentation/git-ls-remote.txt
+++ b/Documentation/git-ls-remote.txt
@@ -11,7 +11,7 @@ SYNOPSIS
 [verse]
 'git ls-remote' [--heads] [--tags] [--refs] [--upload-pack=<exec>]
 	      [-q | --quiet] [--exit-code] [--get-url]
-	      [--symrefs] [<repository> [<refs>...]]
+	      [--symref] [<repository> [<refs>...]]
 
 DESCRIPTION
 -----------
@@ -31,8 +31,7 @@ OPTIONS
 	displayed.
 
 --refs::
-	Do not show peeled tags or pseudo-refs like HEAD or MERGE_HEAD
-	in the output.
+	Do not show peeled tags or pseudorefs like HEAD	in the output.
 
 -q::
 --quiet::
@@ -55,8 +54,11 @@ OPTIONS
 	"url.<base>.insteadOf" config setting (See linkgit:git-config[1]) and
 	exit without talking to the remote.
 
---symrefs::
-	Show the symrefs in addition to the other refs.
+--symref::
+	In addition to the object pointed by it, show the underlying
+	ref pointed by it when showing a symbolic ref.  Currently,
+	upload-pack only shows the symref HEAD, so it will be the only
+	one shown by ls-remote.
 
 <repository>::
 	The "remote" repository to query.  This parameter can be
diff --git a/builtin/ls-remote.c b/builtin/ls-remote.c
index ea73d53..66cdd45 100644
--- a/builtin/ls-remote.c
+++ b/builtin/ls-remote.c
@@ -6,7 +6,7 @@
 static const char * const ls_remote_usage[] = {
 	N_("git ls-remote [--heads] [--tags] [--refs] [--upload-pack=<exec>]\n"
 	   "                     [-q | --quiet] [--exit-code] [--get-url]\n"
-	   "                     [--symrefs] [<repository> [<refs>...]]"),
+	   "                     [--symref] [<repository> [<refs>...]]"),
 	NULL
 };
 
@@ -38,7 +38,7 @@ int cmd_ls_remote(int argc, const char **argv, const char *prefix)
 	int get_url = 0;
 	int quiet = 0;
 	int status = 0;
-	int symrefs = 0;
+	int show_symref_target = 0;
 	const char *uploadpack = NULL;
 	const char **pattern = NULL;
 
@@ -60,7 +60,8 @@ int cmd_ls_remote(int argc, const char **argv, const char *prefix)
 			 N_("take url.<base>.insteadOf into account")),
 		OPT_SET_INT(0, "exit-code", &status,
 			    N_("exit with exit code 2 if no matching refs are found"), 2),
-		OPT_BOOL(0, "symrefs", &symrefs, N_("show symrefs")),
+		OPT_BOOL(0, "symref", &show_symref_target,
+			 N_("show underlying ref in addition to the object pointed by it")),
 		OPT_END()
 	};
 
@@ -104,7 +105,7 @@ int cmd_ls_remote(int argc, const char **argv, const char *prefix)
 			continue;
 		if (!tail_match(pattern, ref->name))
 			continue;
-		if (symrefs && ref->symref)
+		if (show_symref_target && ref->symref)
 			printf("ref: %s\t%s\n", ref->symref, ref->name);
 		printf("%s\t%s\n", oid_to_hex(&ref->old_oid), ref->name);
 		status = 0; /* we found something */
diff --git a/t/t5512-ls-remote.sh b/t/t5512-ls-remote.sh
index 3edbc9e..819b9dd 100755
--- a/t/t5512-ls-remote.sh
+++ b/t/t5512-ls-remote.sh
@@ -163,8 +163,8 @@ test_expect_success 'overrides work between mixed transfer/upload-pack hideRefs'
 	grep refs/tags/magic actual
 '
 
-test_expect_success 'ls-remote --symrefs' '
-	cat >expect <<-EOF &&
+test_expect_success 'ls-remote --symref' '
+	cat >expect <<-\EOF &&
 	ref: refs/heads/master	HEAD
 	1bd44cb9d13204b0fe1958db0082f5028a16eb3a	HEAD
 	1bd44cb9d13204b0fe1958db0082f5028a16eb3a	refs/heads/master
@@ -172,17 +172,40 @@ test_expect_success 'ls-remote --symrefs' '
 	1bd44cb9d13204b0fe1958db0082f5028a16eb3a	refs/remotes/origin/master
 	1bd44cb9d13204b0fe1958db0082f5028a16eb3a	refs/tags/mark
 	EOF
-	git ls-remote --symrefs >actual &&
+	git ls-remote --symref >actual &&
 	test_cmp expect actual
 '
 
-test_expect_success 'ls-remote with filtered symrefs' '
-	cat >expect <<-EOF &&
+test_expect_success 'ls-remote with filtered symref (refname)' '
+	cat >expect <<-\EOF &&
 	ref: refs/heads/master	HEAD
 	1bd44cb9d13204b0fe1958db0082f5028a16eb3a	HEAD
 	EOF
-	git ls-remote --symrefs . HEAD >actual &&
+	git ls-remote --symref . HEAD >actual &&
 	test_cmp expect actual
 '
 
+test_expect_failure 'ls-remote with filtered symref (--heads)' '
+	git symbolic-ref refs/heads/foo refs/tags/mark &&
+	cat >expect <<-\EOF &&
+	ref: refs/tags/mark	refs/heads/foo
+	1bd44cb9d13204b0fe1958db0082f5028a16eb3a	refs/heads/foo
+	1bd44cb9d13204b0fe1958db0082f5028a16eb3a	refs/heads/master
+	EOF
+	git ls-remote --symref --heads . >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'ls-remote --symref omits filtered-out matches' '
+	cat >expect <<-\EOF &&
+	1bd44cb9d13204b0fe1958db0082f5028a16eb3a	refs/heads/foo
+	1bd44cb9d13204b0fe1958db0082f5028a16eb3a	refs/heads/master
+	EOF
+	git ls-remote --symref --heads . >actual &&
+	test_cmp expect actual &&
+	git ls-remote --symref . "refs/heads/*" >actual &&
+	test_cmp expect actual
+'
+
+
 test_done

Thomas Gummerer (5):
  ls-remote: document --quiet option
  ls-remote: document --refs option
  ls-remote: fix synopsis
  ls-remote: use parse-options api
  ls-remote: add support for showing symrefs

 Documentation/git-ls-remote.txt | 16 +++++++-
 builtin/ls-remote.c             | 90 +++++++++++++++++------------------------
 t/t5512-ls-remote.sh            | 45 +++++++++++++++++++++
 3 files changed, 95 insertions(+), 56 deletions(-)

-- 
2.7.0.30.g56a8654.dirty
