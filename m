From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH 09/22] refs-common.c: move warn_if_dangling_symref* to refs-common
Date: Fri,  8 Aug 2014 09:44:56 -0700
Message-ID: <1407516309-27989-10-git-send-email-sahlberg@google.com>
References: <1407516309-27989-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 08 18:46:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XFnIt-00085S-8B
	for gcvg-git-2@plane.gmane.org; Fri, 08 Aug 2014 18:46:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756953AbaHHQpn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Aug 2014 12:45:43 -0400
Received: from mail-pd0-f201.google.com ([209.85.192.201]:39440 "EHLO
	mail-pd0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756315AbaHHQpQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Aug 2014 12:45:16 -0400
Received: by mail-pd0-f201.google.com with SMTP id g10so1475622pdj.0
        for <git@vger.kernel.org>; Fri, 08 Aug 2014 09:45:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=52njImH89LjwBSPqAmDnM5Xdkm1mQHxvjqZsjS1eBPg=;
        b=MTMhTFuBB4UX+WC/NENV+Y4PQb2ZUPO+NH00qnMFc2NLdx6eheOsTalp/7Co5nO7Xr
         l4ZeKaXXYJYnaj7c4N+yRxHCuOVv3iCZs+cVgvR7jHEBjvynPar1829+RoW9gW9jHTh6
         6RL/94L8+p1hmg8YUvsJq2uoFZ49pii8mwe6lHlIyvCL35lqm6MzgVVqiVxHZaysP/AJ
         wCA276zIQeJ9fCR0Lk4JSlKwXh+plwil1vVkuSvi8ci0VCWlnhiJaMKNKYL3vsIQKPuF
         Y8IsBqvxALENv5U4odEBj8j/IQjPjHC63/EBSIOiUTp27D3pbZETqkOymWmV4Uy73GRt
         lFOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=52njImH89LjwBSPqAmDnM5Xdkm1mQHxvjqZsjS1eBPg=;
        b=boJbdjU11a+G1/KST+Cz/BQpuGDYf2Z4nXhgdmlhJ7vhLWFascu0k+4pCDQtqkjf++
         LTROA7/khjFG2Fb/CejNlLb/K/oKZJYzq46TtmpHw0ZUId23GLFrR6TQrNoOJUt4EaXe
         raRJqmOtIo+auHMGcntt3jC1ouRAvrVyzbVVed84xFol5gK2I3gtmIkm50OkNY06r5Vb
         L916HOV+fsxmvpAZ8ZbOraJVosCard8Dsy0Adbma0oLrao5IVshLL8K6lKbR7cwr/jad
         trVB36ZaV6aETaqYT0pGAcxgevoAuHjjWZEP1mXQoYPnSXu7cAioxLlT+8aTBYmiw8oj
         wHlA==
X-Gm-Message-State: ALoCoQkYi4eZKAvmIoICbadzJLVzPIiisZbXWFAyAFiMLDRSmsccR05S5MwzXhRvnV7Z5dupSrv6
X-Received: by 10.68.232.198 with SMTP id tq6mr8932748pbc.1.1407516315883;
        Fri, 08 Aug 2014 09:45:15 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id z50si504806yhb.3.2014.08.08.09.45.15
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 08 Aug 2014 09:45:15 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 8DCDF31C5BB;
	Fri,  8 Aug 2014 09:45:15 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 204BCE1154; Fri,  8 Aug 2014 09:45:15 -0700 (PDT)
X-Mailer: git-send-email 2.0.1.553.geee1b3e
In-Reply-To: <1407516309-27989-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255038>

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
2.0.1.553.geee1b3e
