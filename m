From: Caleb Thompson <caleb@calebthompson.io>
Subject: [PATCH v6 4/4] commit: Add commit.verbose configuration
Date: Tue, 17 Jun 2014 14:39:00 -0500
Message-ID: <2a0ed28d8ef50ce432c7680c1f01eb0f52891134.1403033723.git.caleb@calebthompson.io>
References: <cover.1403033723.git.caleb@calebthompson.io>
Cc: Jeff King <peff@peff.net>, Jeremiah Mahler <jmmahler@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 17 21:39:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WwzEL-0007aa-O3
	for gcvg-git-2@plane.gmane.org; Tue, 17 Jun 2014 21:39:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964816AbaFQTjb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Jun 2014 15:39:31 -0400
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:35029 "EHLO
	new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933509AbaFQTjW (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 Jun 2014 15:39:22 -0400
Received: from compute6.internal (compute6.nyi.mail.srv.osa [10.202.2.46])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 0FEA7685;
	Tue, 17 Jun 2014 15:39:22 -0400 (EDT)
Received: from frontend1 ([10.202.2.160])
  by compute6.internal (MEProxy); Tue, 17 Jun 2014 15:39:22 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=calebthompson.io;
	 h=from:to:cc:subject:date:message-id:in-reply-to:references
	:in-reply-to:references; s=mesmtp; bh=uOxiN+y/iBMIKkdQXdv12HpqmO
	c=; b=Mfe+BuxhfRYLomcqNEJIsD6MlKLrsyTJu3LuXIyzxzrgYjUXET+ZMZoTE2
	kqYfWDE5ceD7dch/eH38tJXhkjc83gYSe39cmkDcKVZHOK/3pE5GqvDDqXwkxmJO
	dJFwvU53F/zuWrgfZElX29U8HqnoDMm2xbzl6DIa9eSM5EJrE=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references:in-reply-to:references; s=smtpout; bh=uO
	xiN+y/iBMIKkdQXdv12HpqmOc=; b=bL69n6+ba6JvhML1f1sNR9KBKCgtqKf/bk
	aNjMmylbCzkL7/aLfKR3LodmfpPZXqmtzrKHZeiDx7zWsqbiXKGG8nnFY2IkrhxI
	cfGavLc4ZpML11zjww8CPRuRTNEWl7IDzMvakYE7szJdVJ66HipVJXESQK4W43Hm
	FnzYk5j9w=
X-Sasl-enc: lRcORgdVNMCIeBVxFUyyzbpyRwAH+D7tCNfZKK7WJVQe 1403033953
Received: from localhost.localdomain (unknown [67.78.97.126])
	by mail.messagingengine.com (Postfix) with ESMTPA id BF860C007C0;
	Tue, 17 Jun 2014 15:39:12 -0400 (EDT)
X-Mailer: git-send-email 2.0.0
In-Reply-To: <cover.1403033723.git.caleb@calebthompson.io>
In-Reply-To: <cover.1403033723.git.caleb@calebthompson.io>
References: <cover.1403033723.git.caleb@calebthompson.io>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251944>

Add a new configuration variable commit.verbose to implicitly pass
--verbose to git-commit. Ensure that --no-verbose to git-commit
negates that setting.

Signed-off-by: Caleb Thompson <caleb@calebthompson.io>
---
 Documentation/config.txt               |  5 +++++
 Documentation/git-commit.txt           |  8 +++++++-
 builtin/commit.c                       |  4 ++++
 contrib/completion/git-completion.bash |  1 +
 t/t7507-commit-verbose.sh              | 36 ++++++++++++++++++++++++++++++++++
 5 files changed, 53 insertions(+), 1 deletion(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 9f467d3..85ef016 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1017,6 +1017,11 @@ commit.template::
 	"`~/`" is expanded to the value of `$HOME` and "`~user/`" to the
 	specified user's home directory.
 
+commit.verbose::
+	A boolean to enable/disable inclusion of diff information in the
+	commit message template when using an editor to prepare the commit
+	message.  Defaults to false.
+
 credential.helper::
 	Specify an external helper to be called when a username or
 	password credential is needed; the helper may consult external
diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
index 0bbc8f5..8cb3439 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -282,7 +282,13 @@ configuration variable documented in linkgit:git-config[1].
 	Show unified diff between the HEAD commit and what
 	would be committed at the bottom of the commit message
 	template.  Note that this diff output doesn't have its
-	lines prefixed with '#'.
+	lines prefixed with '#'.  The `commit.verbose` configuration
+	variable can be set to true to implicitly send this option.
+
+--no-verbose::
+	Do not show the unified diff at the bottom of the commit message
+	template.  This is the default behavior, but can be used to override
+	the `commit.verbose` configuration variable.
 
 -q::
 --quiet::
diff --git a/builtin/commit.c b/builtin/commit.c
index 5e2221c..b746dc8 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1503,6 +1503,10 @@ static int git_commit_config(const char *k, const char *v, void *cb)
 		sign_commit = git_config_bool(k, v) ? "" : NULL;
 		return 0;
 	}
+	if (!strcmp(k, "commit.verbose")) {
+		verbose = git_config_bool(k, v);
+		return 0;
+	}
 
 	status = git_gpg_config(k, v, NULL);
 	if (status)
diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 019026e..b686985 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1980,6 +1980,7 @@ _git_config ()
 		color.ui
 		commit.status
 		commit.template
+		commit.verbose
 		core.abbrev
 		core.askpass
 		core.attributesfile
diff --git a/t/t7507-commit-verbose.sh b/t/t7507-commit-verbose.sh
index 35a4d06..471bd8f 100755
--- a/t/t7507-commit-verbose.sh
+++ b/t/t7507-commit-verbose.sh
@@ -7,6 +7,10 @@ write_script check-for-diff <<-'EOF'
 	exec grep '^diff --git' "$1"
 EOF
 
+write_script check-for-no-diff <<-'EOF'
+	! check-for-diff
+EOF
+
 cat >message <<'EOF'
 subject
 
@@ -48,6 +52,38 @@ test_expect_success 'verbose diff is stripped out (mnemonicprefix)' '
 	check_message message
 '
 
+test_expect_success 'commit shows verbose diff with commit.verbose true' '
+	echo morecontent >>file &&
+	git add file &&
+	test_config commit.verbose true &&
+	test_set_editor "$PWD/check-for-diff" &&
+	git commit --amend
+'
+
+test_expect_success 'commit --verbose overrides commit.verbose false' '
+	echo evenmorecontent >>file &&
+	git add file &&
+	test_config commit.verbose false  &&
+	test_set_editor "$PWD/check-for-diff" &&
+	git commit --amend --verbose
+'
+
+test_expect_success 'commit does not show verbose diff with commit.verbose false' '
+	echo evenmorecontent >>file &&
+	git add file &&
+	test_config commit.verbose false &&
+	test_set_editor "$PWD/check-for-no-diff" &&
+	git commit --amend
+'
+
+test_expect_success 'commit --no-verbose overrides commit.verbose true' '
+	echo evenmorecontent >>file &&
+	git add file &&
+	test_config commit.verbose true &&
+	test_set_editor "$PWD/check-for-no-diff" &&
+	git commit --amend --no-verbose
+'
+
 cat >diff <<'EOF'
 This is an example commit message that contains a diff.
 
-- 
2.0.0
