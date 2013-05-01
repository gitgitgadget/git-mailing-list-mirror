From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v3] Add new @ shortcut for HEAD
Date: Wed,  1 May 2013 04:51:28 -0500
Message-ID: <1367401888-21055-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jeff King <peff@peff.net>, Duy Nguyen <pclouds@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 01 11:52:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXTiX-0003ca-17
	for gcvg-git-2@plane.gmane.org; Wed, 01 May 2013 11:52:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757427Ab3EAJwt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 May 2013 05:52:49 -0400
Received: from mail-gg0-f172.google.com ([209.85.161.172]:56677 "EHLO
	mail-gg0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753142Ab3EAJwr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 May 2013 05:52:47 -0400
Received: by mail-gg0-f172.google.com with SMTP id f1so242695ggn.17
        for <git@vger.kernel.org>; Wed, 01 May 2013 02:52:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer;
        bh=ryrp3jsGCjuYEddZ9gRObz/5sNW9u2xmIh91l63hkpY=;
        b=yVFtPRYCm7YXLiKD3zOcUFvfunbLq4wM6O/VjX6yOoXIOn7h0eGTMP90qhCCwIXt/8
         1IsXQBonaiZYl6vmGlLOOe0Lfnwp3FjsCH3IEU/nOtg1DVQ9aTWb7/1N8d+Hx5QnkTy+
         UboszvDXvg0aySaFsIxyNYP3Gc4ndXNfeAbNKrhNrM0ZxuFVD+t3d4KGL/fAwq7Z8pKh
         t09l393zTwCT5P3tZvAL9PQu56aquaW5JB6F9lxx37oN4T/nUWZDiVW2qkNfKyJYxqZ7
         Uoe25bB2Ke1fopUBcfCCk7MSZ2/YjW+lsRcQJk6i4vLzx1q5a0hhXCLp5TjNtog9fHFo
         uKnQ==
X-Received: by 10.236.115.197 with SMTP id e45mr1364868yhh.172.1367401966714;
        Wed, 01 May 2013 02:52:46 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id v27sm4109606yhj.12.2013.05.01.02.52.44
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 01 May 2013 02:52:45 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc0.399.gc96a135
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223077>

So HEAD@{0}~0^0 is too much to type, but we can remove '^0', and we can
remove '~0', and we can remove 'HEAD', which leaves us with @{0}, but we
can't remove '{0}'?

This patch allows '@' to be the same as 'HEAD'.

So now we can use 'git show @~1', and all that goody goodness.

Until now '@' was a valid name, but it conflicts with this idea, so lets
make it invalid. Probably very few people, if any, used this name.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---

Drop the last two patches of the previous series, and replace with this one,
which is the real deal ;)

 Documentation/git-check-ref-format.txt |  2 ++
 Documentation/revisions.txt            |  3 +++
 refs.c                                 |  4 ++++
 sha1_name.c                            | 17 +++++++++++++++++
 t/t1508-at-combinations.sh             |  3 +++
 5 files changed, 29 insertions(+)

diff --git a/Documentation/git-check-ref-format.txt b/Documentation/git-check-ref-format.txt
index ec1739a..e8035ec 100644
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
index de2d8eb..4e70b3e 100644
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
index 76e3219..3b06e5e 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -965,6 +965,17 @@ int get_sha1_mb(const char *name, unsigned char *sha1)
 	return st;
 }
 
+/* parse @something syntax, when 'something' is not {.*} */
+static int interpret_empty_at(const char *name, int namelen, int len, struct strbuf *buf)
+{
+	if (len || name[1] == '{')
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
@@ -1025,9 +1036,15 @@ int interpret_branch_name(const char *name, struct strbuf *buf)
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
index d5d6244..65584c0 100755
--- a/t/t1508-at-combinations.sh
+++ b/t/t1508-at-combinations.sh
@@ -45,6 +45,9 @@ check "@{u}" upstream-two
 check "@{u}@{1}" upstream-one
 check "@{-1}@{u}" master-two
 check "@{-1}@{u}@{1}" master-one
+check "@" new-two
+check "HEAD@{u}" upstream-two
+check "@@{u}" upstream-two
 nonsense "@{u}@{-1}"
 nonsense "@{1}@{u}"
 
-- 
1.8.3.rc0.399.gc96a135
