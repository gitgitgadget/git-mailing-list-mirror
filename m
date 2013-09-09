From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v6 2/2] Add new @ shortcut for HEAD
Date: Sun,  8 Sep 2013 21:06:34 -0500
Message-ID: <1378692394-27096-3-git-send-email-felipe.contreras@gmail.com>
References: <1378692394-27096-1-git-send-email-felipe.contreras@gmail.com>
Cc: Stefano Lattarini <stefano.lattarini@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 09 04:11:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VIqxD-00063g-GX
	for gcvg-git-2@plane.gmane.org; Mon, 09 Sep 2013 04:11:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751688Ab3IICLp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Sep 2013 22:11:45 -0400
Received: from mail-oa0-f53.google.com ([209.85.219.53]:49742 "EHLO
	mail-oa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751671Ab3IICLo (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Sep 2013 22:11:44 -0400
Received: by mail-oa0-f53.google.com with SMTP id k18so5903109oag.26
        for <git@vger.kernel.org>; Sun, 08 Sep 2013 19:11:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=sDQB4dnIgSkeBA9/bw3TYyHu8cA6C+UcwKQIqIWB6vE=;
        b=qKVfbPs2qbL16jTqp5jBEzE46Cly7wdbLhPdeaAlHdk0KsSOIsSGs1vT8KHXWG4h1N
         4GmZTmt1XRaCt8o8Mnn4Izxo9IwQcLgSeFTr6adKRFHcFHsQ/LA6eCkzayeX0cn5eblY
         S1OAxTkw2zo2H0abbCf1qYtSgDR5zHq/MYo9ycP7p4mKU9yPfPH3dL46X/hOlAgo7Zrl
         v3JoqABB8yhMgKhwAYEK5Qsh2LCS3fqHmdVMfK+m2rVHablyfwOW2rJLFyFPCcqaiQBG
         qqg5BBUlT7RXRmUlYN2SJN0Mk01xjqYj/BFujrlb9JwnuSqUQve3h83F3XTKnPux8VKj
         78KQ==
X-Received: by 10.60.43.131 with SMTP id w3mr9836962oel.10.1378692703881;
        Sun, 08 Sep 2013 19:11:43 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id s9sm10634318obu.4.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 08 Sep 2013 19:11:42 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-338-gefd7fa6
In-Reply-To: <1378692394-27096-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234306>

Typing 'HEAD' is tedious, especially when we can use '@' instead.

The reason for choosing '@' is that it follows naturally from the
ref@op syntax (e.g. HEAD@{u}), except we have no ref, and no
operation, and when we don't have those, it makes sens to assume
'HEAD'.

So now we can use 'git show @~1', and all that goody goodness.

Until now '@' was a valid name, but it conflicts with this idea, so
let's make it invalid. Probably very few people, if any, used this name.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git-check-ref-format.txt |  2 ++
 Documentation/revisions.txt            |  3 +++
 refs.c                                 |  4 ++++
 sha1_name.c                            | 26 ++++++++++++++++++++++++++
 t/t1508-at-combinations.sh             |  4 ++++
 5 files changed, 39 insertions(+)

diff --git a/Documentation/git-check-ref-format.txt b/Documentation/git-check-ref-format.txt
index a49be1b..fc02959 100644
--- a/Documentation/git-check-ref-format.txt
+++ b/Documentation/git-check-ref-format.txt
@@ -54,6 +54,8 @@ Git imposes the following rules on how references are named:
 
 . They cannot contain a sequence `@{`.
 
+. They cannot be the single character `@`.
+
 . They cannot contain a `\`.
 
 These rules make it easy for shell script based tools to parse
diff --git a/Documentation/revisions.txt b/Documentation/revisions.txt
index d477b3f..09896a3 100644
--- a/Documentation/revisions.txt
+++ b/Documentation/revisions.txt
@@ -58,6 +58,9 @@ the '$GIT_DIR/refs' directory or from the '$GIT_DIR/packed-refs' file.
 While the ref name encoding is unspecified, UTF-8 is preferred as
 some output processing may assume ref names in UTF-8.
 
+'@'::
+  '@' alone is a shortcut for 'HEAD'.
+
 '<refname>@\{<date>\}', e.g. 'master@\{yesterday\}', 'HEAD@\{5 minutes ago\}'::
   A ref followed by the suffix '@' with a date specification
   enclosed in a brace
diff --git a/refs.c b/refs.c
index 8fd5faf..bfe10e2 100644
--- a/refs.c
+++ b/refs.c
@@ -72,6 +72,10 @@ int check_refname_format(const char *refname, int flags)
 {
 	int component_len, component_count = 0;
 
+	if (!strcmp(refname, "@"))
+		/* Refname is a single character '@'. */
+		return -1;
+
 	while (1) {
 		/* We are at the start of a path component. */
 		component_len = check_refname_component(refname, flags);
diff --git a/sha1_name.c b/sha1_name.c
index 93197b9..b8ece6e 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -1004,6 +1004,26 @@ int get_sha1_mb(const char *name, unsigned char *sha1)
 	return st;
 }
 
+/* parse @something syntax, when 'something' is not {.*} */
+static int interpret_empty_at(const char *name, int namelen, int len, struct strbuf *buf)
+{
+	const char *next;
+
+	if (len || name[1] == '{')
+		return -1;
+
+	/* make sure it's a single @, or @@{.*}, not @foo */
+	next = strchr(name + len + 1, '@');
+	if (!next)
+		next = name + namelen;
+	if (next != name + 1)
+		return -1;
+
+	strbuf_reset(buf);
+	strbuf_add(buf, "HEAD", 4);
+	return 1;
+}
+
 static int reinterpret(const char *name, int namelen, int len, struct strbuf *buf)
 {
 	/* we have extra data, which might need further processing */
@@ -1068,9 +1088,15 @@ int interpret_branch_name(const char *name, int namelen, struct strbuf *buf)
 	cp = strchr(name, '@');
 	if (!cp)
 		return -1;
+
+	len = interpret_empty_at(name, namelen, cp - name, buf);
+	if (len > 0)
+		return reinterpret(name, namelen, len, buf);
+
 	tmp_len = upstream_mark(cp, namelen - (cp - name));
 	if (!tmp_len)
 		return -1;
+
 	len = cp + tmp_len - name;
 	cp = xstrndup(name, cp - name);
 	upstream = branch_get(*cp ? cp : NULL);
diff --git a/t/t1508-at-combinations.sh b/t/t1508-at-combinations.sh
index e5aea3b..3a52375 100755
--- a/t/t1508-at-combinations.sh
+++ b/t/t1508-at-combinations.sh
@@ -32,6 +32,7 @@ test_expect_success 'setup' '
 	git checkout -b upstream-branch &&
 	test_commit upstream-one &&
 	test_commit upstream-two &&
+	git checkout -b @at-test &&
 	git checkout -b old-branch &&
 	test_commit old-one &&
 	test_commit old-two &&
@@ -55,6 +56,9 @@ check "HEAD@{u}" ref refs/heads/upstream-branch
 check "@{u}@{1}" commit upstream-one
 check "@{-1}@{u}" ref refs/heads/master
 check "@{-1}@{u}@{1}" commit master-one
+check "@" commit new-two
+check "@@{u}" ref refs/heads/upstream-branch
+check "@at-test" ref refs/heads/@at-test
 nonsense "@{u}@{-1}"
 nonsense "@{0}@{0}"
 nonsense "@{1}@{u}"
-- 
1.8.4-338-gefd7fa6
