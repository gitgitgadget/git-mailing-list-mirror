From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v2 09/23] refs-common.c: move warn_if_dangling_symref* to refs-common
Date: Wed, 13 Aug 2014 13:14:53 -0700
Message-ID: <1407960907-18189-10-git-send-email-sahlberg@google.com>
References: <1407960907-18189-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 13 22:16:12 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XHexu-0000CW-C7
	for gcvg-git-2@plane.gmane.org; Wed, 13 Aug 2014 22:16:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753880AbaHMUQF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Aug 2014 16:16:05 -0400
Received: from mail-pd0-f202.google.com ([209.85.192.202]:64298 "EHLO
	mail-pd0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753531AbaHMUPL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Aug 2014 16:15:11 -0400
Received: by mail-pd0-f202.google.com with SMTP id w10so83662pde.5
        for <git@vger.kernel.org>; Wed, 13 Aug 2014 13:15:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=G5cVjPQ0SdW6BMjjmXTQ+RiAXnP+2NoqQQmq7hTxLz8=;
        b=hPYow2UkURNO/QRFViX/9uVl/0XleDgrt7LuZ0ZCC2BImm3y1wOldSfJFkqo9mLz+L
         z5MzlotQhjX5sxlO3LM03+e2uXFNVgYkqPUe6f+7lXTHzwtzO7uLZqsaZzGKLBZPkSXX
         NwVV8Yj2wy2Jn9X86HJG8/gwtzjC4jF//dC3hiKJUe+eyJaO93hFpSUnBmX4bnNxkx/k
         6DKyVAZvdt78LtJJo5bn7kUCqIq2lNjt7v/XBW6mJC+Qy/cRX/kNIzrHus5SsyRfR2kC
         Dj56aFV0V0bElww2v6aNIIBXT4OYi1WwVKxdBigOD4xOzwFxYbDvg/leC93ZH+zNJd0G
         fSVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=G5cVjPQ0SdW6BMjjmXTQ+RiAXnP+2NoqQQmq7hTxLz8=;
        b=WtMhdxqQxrgoIFsvFbv+CqHeW7+TNz94yfB0gEEu8J5QvbuBPSlu+fPVMci8WJoS24
         zlCZ/+VnEjTBGEgXoA+A4tVRJKqRzSN52K94vb/Myf1c9/qJeUkaQFWhmXBAbf8JZg5W
         XoqZgUUrr9/rfiHXuiV3vwOQLln/tW0wN7IDlnLkamRRiczIjwtkhIDaPv4gEzymqenE
         MxyOKHiyYIuGXEAy7pLNFoA5uJyAy2sHQNpO5FGpqfkU0vED3hpSBSqsbFGbQ1/zQdtA
         fGdX1xVBVL65Zjl+Zhz/S0RWKC+W+0fdrzWmtyvmHfxs0ue9cy2qCMF6qDz2UoA9PYpB
         LhRQ==
X-Gm-Message-State: ALoCoQlYzYAiC8Ok1NhHkPXBzrNwFEoch1RUU10hN/j62DfnGQaA80cuXUTRQRnYxBuJzwI3l8qB
X-Received: by 10.68.116.42 with SMTP id jt10mr3527779pbb.5.1407960910440;
        Wed, 13 Aug 2014 13:15:10 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id y50si209192yhk.4.2014.08.13.13.15.10
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 13 Aug 2014 13:15:10 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 22D1E31C52A;
	Wed, 13 Aug 2014 13:15:10 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id B2903E11C5; Wed, 13 Aug 2014 13:15:09 -0700 (PDT)
X-Mailer: git-send-email 2.0.1.556.gfa712f7
In-Reply-To: <1407960907-18189-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255245>

These functions do not use any backend specific code so we can move
them to the common code.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs-common.c | 52 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 refs.c        | 52 ----------------------------------------------------
 2 files changed, 52 insertions(+), 52 deletions(-)

diff --git a/refs-common.c b/refs-common.c
index ac081e1..ab3a118 100644
--- a/refs-common.c
+++ b/refs-common.c
@@ -495,3 +495,55 @@ char *shorten_unambiguous_ref(const char *refname, int strict)
 	free(short_name);
 	return xstrdup(refname);
 }
+
+struct warn_if_dangling_data {
+	FILE *fp;
+	const char *refname;
+	const struct string_list *refnames;
+	const char *msg_fmt;
+};
+
+static int warn_if_dangling_symref(const char *refname, const unsigned char *sha1,
+				   int flags, void *cb_data)
+{
+	struct warn_if_dangling_data *d = cb_data;
+	const char *resolves_to;
+	unsigned char junk[20];
+
+	if (!(flags & REF_ISSYMREF))
+		return 0;
+
+	resolves_to = resolve_ref_unsafe(refname, junk, 0, NULL);
+	if (!resolves_to
+	    || (d->refname
+		? strcmp(resolves_to, d->refname)
+		: !string_list_has_string(d->refnames, resolves_to))) {
+		return 0;
+	}
+
+	fprintf(d->fp, d->msg_fmt, refname);
+	fputc('\n', d->fp);
+	return 0;
+}
+
+void warn_dangling_symref(FILE *fp, const char *msg_fmt, const char *refname)
+{
+	struct warn_if_dangling_data data;
+
+	data.fp = fp;
+	data.refname = refname;
+	data.refnames = NULL;
+	data.msg_fmt = msg_fmt;
+	for_each_rawref(warn_if_dangling_symref, &data);
+}
+
+void warn_dangling_symrefs(FILE *fp, const char *msg_fmt, const struct string_list *refnames)
+{
+	struct warn_if_dangling_data data;
+
+	data.fp = fp;
+	data.refname = NULL;
+	data.refnames = refnames;
+	data.msg_fmt = msg_fmt;
+	for_each_rawref(warn_if_dangling_symref, &data);
+}
diff --git a/refs.c b/refs.c
index 56e146f..40c329b 100644
--- a/refs.c
+++ b/refs.c
@@ -1667,58 +1667,6 @@ int peel_ref(const char *refname, unsigned char *sha1)
 	return peel_object(base, sha1);
 }
 
-struct warn_if_dangling_data {
-	FILE *fp;
-	const char *refname;
-	const struct string_list *refnames;
-	const char *msg_fmt;
-};
-
-static int warn_if_dangling_symref(const char *refname, const unsigned char *sha1,
-				   int flags, void *cb_data)
-{
-	struct warn_if_dangling_data *d = cb_data;
-	const char *resolves_to;
-	unsigned char junk[20];
-
-	if (!(flags & REF_ISSYMREF))
-		return 0;
-
-	resolves_to = resolve_ref_unsafe(refname, junk, 0, NULL);
-	if (!resolves_to
-	    || (d->refname
-		? strcmp(resolves_to, d->refname)
-		: !string_list_has_string(d->refnames, resolves_to))) {
-		return 0;
-	}
-
-	fprintf(d->fp, d->msg_fmt, refname);
-	fputc('\n', d->fp);
-	return 0;
-}
-
-void warn_dangling_symref(FILE *fp, const char *msg_fmt, const char *refname)
-{
-	struct warn_if_dangling_data data;
-
-	data.fp = fp;
-	data.refname = refname;
-	data.refnames = NULL;
-	data.msg_fmt = msg_fmt;
-	for_each_rawref(warn_if_dangling_symref, &data);
-}
-
-void warn_dangling_symrefs(FILE *fp, const char *msg_fmt, const struct string_list *refnames)
-{
-	struct warn_if_dangling_data data;
-
-	data.fp = fp;
-	data.refname = NULL;
-	data.refnames = refnames;
-	data.msg_fmt = msg_fmt;
-	for_each_rawref(warn_if_dangling_symref, &data);
-}
-
 /*
  * Call fn for each reference in the specified ref_cache, omitting
  * references not in the containing_dir of base.  fn is called for all
-- 
2.0.1.556.g3edca4c
