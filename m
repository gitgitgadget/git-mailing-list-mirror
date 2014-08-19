From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v3 10/23] refs.c: move warn_if_dangling_symref* to the common code
Date: Tue, 19 Aug 2014 09:30:34 -0700
Message-ID: <1408465847-30384-11-git-send-email-sahlberg@google.com>
References: <1408465847-30384-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 19 18:32:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XJmKd-0002zZ-T0
	for gcvg-git-2@plane.gmane.org; Tue, 19 Aug 2014 18:32:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753261AbaHSQbu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Aug 2014 12:31:50 -0400
Received: from mail-ig0-f202.google.com ([209.85.213.202]:54843 "EHLO
	mail-ig0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751950AbaHSQay (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Aug 2014 12:30:54 -0400
Received: by mail-ig0-f202.google.com with SMTP id r2so1088290igi.1
        for <git@vger.kernel.org>; Tue, 19 Aug 2014 09:30:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=A2r2epT3doNw/K5OLdnu3T6m/y20TQgKINm/+FpkBxo=;
        b=cPxAXuPPCqUQA+e/oO94gQWi/RLx3RgjEkfBB/OoCIH64jGhvlS3PI2l/90iSwqqFm
         7OVrIFCx16ree4QeN2UE8r6e8+NnAZWKDqs2oz+xcqv3yPCerOe8D3hS7G5WFjEr/86O
         Mo5TpEyv8eq8yxNm8eJxN/NRwYQwpJRAMBqcu4mXIrwyux36BAWAEn3eV/s1Kgi5yhoX
         0LMGWIJkPjYUjIDct1fa0oMz9wQEfDDzOnlyfwkGAt8xZD42gkTtN5OAYbUrLLjWrRgm
         euhnQpRridkGOv/nPGSOlShPevqPNXwRW+xUX5kSl40mIhCGnTMuGCht+CcxxGVSv7CQ
         O7uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=A2r2epT3doNw/K5OLdnu3T6m/y20TQgKINm/+FpkBxo=;
        b=hXeuZIQJv8t13EiJfIvbDjeFBhYWJBQEpvIqNBqNivNe+WnktrdwNwAx/L9zMKar59
         12JULZAt//xMb9Brw2TnJf2M3vWgIhP/6pChc6zNzUPtmJij+r3QzwtRlZfijuZ9TrzF
         6k4shZzppCyIYdC9y5vBK1LX1tifKIt9gbazRKCrKhYo6E6Gq5Q/fkoB0sFTKkFFwjtM
         OBfeobEVcFdFS2RdK+cwuELOP9tOQd3A/verSR86Q8zwVN9xALLcjz6oxYJwQ3/DIPo5
         GFLtgEUcczgU0zSW056oby8C8SWgK69oG06RJu2gK3aDR1xg59Wq63exQ9fyXx5QQQNp
         PRlw==
X-Gm-Message-State: ALoCoQlECSItsmVCuqst/ZNrDSpVhaWNFjR4r3iHz/ouRjmN48+9uQrU64wUhvZaZTS+kl4asBYZ
X-Received: by 10.50.66.236 with SMTP id i12mr3631977igt.5.1408465853673;
        Tue, 19 Aug 2014 09:30:53 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id x19si332775yhg.0.2014.08.19.09.30.53
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 19 Aug 2014 09:30:53 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 415FC31C537;
	Tue, 19 Aug 2014 09:30:53 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id B9AEFE11E7; Tue, 19 Aug 2014 09:30:52 -0700 (PDT)
X-Mailer: git-send-email 2.0.1.552.g1af257a
In-Reply-To: <1408465847-30384-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255490>

These functions do not use any backend specific code so we can move
them to the common code.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs-be-files.c | 52 ----------------------------------------------------
 refs.c          | 52 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 52 insertions(+), 52 deletions(-)

diff --git a/refs-be-files.c b/refs-be-files.c
index 56e146f..40c329b 100644
--- a/refs-be-files.c
+++ b/refs-be-files.c
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
diff --git a/refs.c b/refs.c
index adf0c29..3011452 100644
--- a/refs.c
+++ b/refs.c
@@ -497,3 +497,55 @@ char *shorten_unambiguous_ref(const char *refname, int strict)
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
-- 
2.0.1.552.g1af257a
