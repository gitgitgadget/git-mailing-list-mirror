From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 5/9] push: add --set-publish option
Date: Thu, 10 Apr 2014 14:04:42 -0500
Message-ID: <1397156686-31349-6-git-send-email-felipe.contreras@gmail.com>
References: <1397156686-31349-1-git-send-email-felipe.contreras@gmail.com>
Cc: Matthieu Moy <matthieu.moy@imag.fr>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jeff King <peff@peff.net>,
	John Szakmeister <john@szakmeister.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 10 21:15:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WYKRe-0006Ua-85
	for gcvg-git-2@plane.gmane.org; Thu, 10 Apr 2014 21:15:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161189AbaDJTPT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Apr 2014 15:15:19 -0400
Received: from mail-oa0-f52.google.com ([209.85.219.52]:61353 "EHLO
	mail-oa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161185AbaDJTPP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Apr 2014 15:15:15 -0400
Received: by mail-oa0-f52.google.com with SMTP id l6so4914634oag.25
        for <git@vger.kernel.org>; Thu, 10 Apr 2014 12:15:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tDWbsqRzXkWG6XjiB/JudexXTwzr20vU5Eny/jrN6i8=;
        b=Wu+q/cYKNYiqNZPe/R7NkwTK4e+8cvewOTdS6s8y0/H9PGDCOyoZBG/v9s+396zT7u
         z0wQOrUMMp1c8tDPdZe+dbg3+5mt4Qn8RjJyp35A/KJy1d4E4URtqE8YNs36Q1nwhhz9
         g2KF7CcC0BbC1LNCIfzXtCZnQV/tdIzrlLtLjznLZfnUbvHVFGYALAHfmK/PzUaYB9u+
         zEK46mzVFf/2S3eM4ajTbpYEWrR4KpTiQ33cD8paXdnhH9ZbIuTYdYx2Zj4vlPRA6QPv
         0kvnSE6m+yTCWTEHxlRGP9nkfedXfitT+J0Ab/BkjSODFG8lHe1rrihnXSOXsTOoaKWE
         tuZA==
X-Received: by 10.60.141.70 with SMTP id rm6mr15532061oeb.27.1397157314637;
        Thu, 10 Apr 2014 12:15:14 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id l5sm8363405obh.15.2014.04.10.12.15.09
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Apr 2014 12:15:11 -0700 (PDT)
X-Mailer: git-send-email 1.9.1+fc1
In-Reply-To: <1397156686-31349-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246043>

To setup publish tracking branch, like 'git branch --set-publish'.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/git-push.txt |  9 +++++-
 builtin/push.c             |  2 ++
 t/t5529-push-publish.sh    | 70 ++++++++++++++++++++++++++++++++++++++++++++++
 transport.c                | 28 +++++++++++++------
 transport.h                |  1 +
 5 files changed, 100 insertions(+), 10 deletions(-)
 create mode 100755 t/t5529-push-publish.sh

diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
index 2b7f4f9..bf6ff9c 100644
--- a/Documentation/git-push.txt
+++ b/Documentation/git-push.txt
@@ -10,7 +10,8 @@ SYNOPSIS
 --------
 [verse]
 'git push' [--all | --mirror | --tags] [--follow-tags] [-n | --dry-run] [--receive-pack=<git-receive-pack>]
-	   [--repo=<repository>] [-f | --force] [--prune] [-v | --verbose] [-u | --set-upstream]
+	   [--repo=<repository>] [-f | --force] [--prune] [-v | --verbose]
+	   [-u | --set-upstream] [-p | --set-publish]
 	   [--force-with-lease[=<refname>[:<expect>]]]
 	   [--no-verify] [<repository> [<refspec>...]]
 
@@ -231,6 +232,12 @@ useful if you write an alias or script around 'git push'.
 	linkgit:git-pull[1] and other commands. For more information,
 	see 'branch.<name>.merge' in linkgit:git-config[1].
 
+-p::
+--set-publish::
+	For every branch that is up to date or successfully pushed, add
+	publish branch tracking reference, used by argument-less
+	linkgit:git-pull[1] and other commands.
+
 --[no-]thin::
 	These options are passed to linkgit:git-send-pack[1]. A thin transfer
 	significantly reduces the amount of sent data when the sender and
diff --git a/builtin/push.c b/builtin/push.c
index a1fdc49..9e61b8f 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -532,6 +532,8 @@ int cmd_push(int argc, const char **argv, const char *prefix)
 		OPT_STRING( 0 , "exec", &receivepack, "receive-pack", N_("receive pack program")),
 		OPT_BIT('u', "set-upstream", &flags, N_("set upstream for git pull/status"),
 			TRANSPORT_PUSH_SET_UPSTREAM),
+		OPT_BIT('p', "set-publish", &flags, N_("set publish for git pull/status"),
+			TRANSPORT_PUSH_SET_PUBLISH),
 		OPT_BOOL(0, "progress", &progress, N_("force progress reporting")),
 		OPT_BIT(0, "prune", &flags, N_("prune locally removed refs"),
 			TRANSPORT_PUSH_PRUNE),
diff --git a/t/t5529-push-publish.sh b/t/t5529-push-publish.sh
new file mode 100755
index 0000000..2037026
--- /dev/null
+++ b/t/t5529-push-publish.sh
@@ -0,0 +1,70 @@
+#!/bin/sh
+
+test_description='push with --set-publish'
+
+. ./test-lib.sh
+
+test_expect_success 'setup bare parent' '
+	git init --bare parent &&
+	git remote add publish parent
+'
+
+test_expect_success 'setup local commit' '
+	echo content >file &&
+	git add file &&
+	git commit -m one
+'
+
+check_config() {
+	(echo $2; echo $3) >expect.$1
+	(git config branch.$1.pushremote
+	 git config branch.$1.push) >actual.$1
+	test_cmp expect.$1 actual.$1
+}
+
+test_expect_success 'push -p master:master' '
+	git push -p publish master:master &&
+	check_config master publish refs/heads/master
+'
+
+test_expect_success 'push -u master:other' '
+	git push -p publish master:other &&
+	check_config master publish refs/heads/other
+'
+
+test_expect_success 'push -p --dry-run master:otherX' '
+	git push -p --dry-run publish master:otherX &&
+	check_config master publish refs/heads/other
+'
+
+test_expect_success 'push -p master2:master2' '
+	git branch master2 &&
+	git push -p publish master2:master2 &&
+	check_config master2 publish refs/heads/master2
+'
+
+test_expect_success 'push -p master2:other2' '
+	git push -p publish master2:other2 &&
+	check_config master2 publish refs/heads/other2
+'
+
+test_expect_success 'push -p :master2' '
+	git push -p publish :master2 &&
+	check_config master2 publish refs/heads/other2
+'
+
+test_expect_success 'push -u --all' '
+	git branch all1 &&
+	git branch all2 &&
+	git push -p --all &&
+	check_config all1 publish refs/heads/all1 &&
+	check_config all2 publish refs/heads/all2
+'
+
+test_expect_success 'push -p HEAD' '
+	git checkout -b headbranch &&
+	git push -p publish HEAD &&
+	check_config headbranch publish refs/heads/headbranch
+'
+
+test_done
diff --git a/transport.c b/transport.c
index ca7bb44..dfcddfe 100644
--- a/transport.c
+++ b/transport.c
@@ -143,8 +143,8 @@ static void insert_packed_refs(const char *packed_refs, struct ref **list)
 	}
 }
 
-static void set_upstreams(struct transport *transport, struct ref *refs,
-	int pretend)
+static void set_tracking(struct transport *transport, struct ref *refs,
+	int pretend, int publish)
 {
 	struct ref *ref;
 	for (ref = refs; ref; ref = ref->next) {
@@ -179,12 +179,18 @@ static void set_upstreams(struct transport *transport, struct ref *refs,
 		if (!remotename || !starts_with(remotename, "refs/heads/"))
 			continue;
 
-		if (!pretend)
-			install_branch_config(BRANCH_CONFIG_VERBOSE,
-				localname + 11, transport->remote->name,
-				remotename);
-		else
-			printf("Would set upstream of '%s' to '%s' of '%s'\n",
+		if (!pretend) {
+			if (publish)
+				install_branch_publish(localname + 11,
+						transport->remote->name,
+						remotename);
+			else
+				install_branch_config(BRANCH_CONFIG_VERBOSE,
+						localname + 11, transport->remote->name,
+						remotename);
+		} else
+			printf("Would set %s of '%s' to '%s' of '%s'\n",
+				publish ? "publish" : "upstream",
 				localname + 11, remotename + 11,
 				transport->remote->name);
 	}
@@ -1129,6 +1135,8 @@ int transport_push(struct transport *transport,
 		/* Maybe FIXME. But no important transport uses this case. */
 		if (flags & TRANSPORT_PUSH_SET_UPSTREAM)
 			die("This transport does not support using --set-upstream");
+		if (flags & TRANSPORT_PUSH_SET_PUBLISH)
+			die("This transport does not support using --set-publish");
 
 		return transport->push(transport, refspec_nr, refspec, flags);
 	} else if (transport->push_refs) {
@@ -1203,7 +1211,9 @@ int transport_push(struct transport *transport,
 					reject_reasons);
 
 		if (flags & TRANSPORT_PUSH_SET_UPSTREAM)
-			set_upstreams(transport, remote_refs, pretend);
+			set_tracking(transport, remote_refs, pretend, 0);
+		if (flags & TRANSPORT_PUSH_SET_PUBLISH)
+			set_tracking(transport, remote_refs, pretend, 1);
 
 		if (!(flags & TRANSPORT_PUSH_DRY_RUN)) {
 			struct ref *ref;
diff --git a/transport.h b/transport.h
index 02ea248..324997c 100644
--- a/transport.h
+++ b/transport.h
@@ -123,6 +123,7 @@ struct transport {
 #define TRANSPORT_RECURSE_SUBMODULES_ON_DEMAND 256
 #define TRANSPORT_PUSH_NO_HOOK 512
 #define TRANSPORT_PUSH_FOLLOW_TAGS 1024
+#define TRANSPORT_PUSH_SET_PUBLISH 2048
 
 #define TRANSPORT_SUMMARY_WIDTH (2 * DEFAULT_ABBREV + 3)
 #define TRANSPORT_SUMMARY(x) (int)(TRANSPORT_SUMMARY_WIDTH + strlen(x) - gettext_width(x)), (x)
-- 
1.9.1+fc1
