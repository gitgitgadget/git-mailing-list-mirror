From: David Turner <dturner@twopensource.com>
Subject: [PATCH v5 10/26] refs.c: move warn_if_dangling_symref* to the common code
Date: Tue, 27 Oct 2015 22:14:11 -0400
Message-ID: <1445998467-11511-11-git-send-email-dturner@twopensource.com>
References: <1445998467-11511-1-git-send-email-dturner@twopensource.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>,
	David Turner <dturner@twopensource.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Wed Oct 28 03:15:24 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZrGGi-0001Ee-Sv
	for gcvg-git-2@plane.gmane.org; Wed, 28 Oct 2015 03:15:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755243AbbJ1CPE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Oct 2015 22:15:04 -0400
Received: from mail-ig0-f173.google.com ([209.85.213.173]:33294 "EHLO
	mail-ig0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755227AbbJ1CO6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Oct 2015 22:14:58 -0400
Received: by igbkq10 with SMTP id kq10so108253359igb.0
        for <git@vger.kernel.org>; Tue, 27 Oct 2015 19:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource_com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=EVTbF98R0ml8jFHkoW9w+sQRwyM2b/NMDddfiU+BWRQ=;
        b=jOWaWGBWW2hzq7QsIGvPdn5HS5Wl883HcrjmrqT240Gr4IA6QzZYJnCRLDCYGH+yTf
         1VB+eH453+f3JGtY9KDkirxpMaJQYFpQ7RKanauY9fUsOiMaAnICV4vi5RFRyplB5qbg
         D4eTrtH/p9ETmpuOpNeDQpW+u7MpH44exwClOcEVXMdR5ZO0+s1MRq3Oyf3ojCe5kKvC
         FrDRPMqKlgf/BRM4VZyvoehJr2ZkhdTPZ2F3XJl3e7PcMDMKV0YBiVfn4C84akwvvszy
         0DdSN3jHiISEeRd9VD4ccyAcU/GFRDUyYxXVO6DPgOSmLSiEEv+Bs922z6e60tfOuvsm
         V/qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=EVTbF98R0ml8jFHkoW9w+sQRwyM2b/NMDddfiU+BWRQ=;
        b=MgzcVtJgoy/c7sIBgeuD5cfQx8oY5+gmjbEybAJJYh7a1HiWGkKfNbOVAZ/0HNu0YI
         cgZzf7eiSDT+lHFOvJqL5GASf822kmuXiqRRjVQYgzAklBqD3gBMeDHXFCgRvsnlvNQ6
         4FcTy6UlBVfPfURS8Viln8UYGkyUYlvbJqCgl6IKWqQHzLrYnbJltiaoTGjMrvqaeyE2
         tya82l+EcujvUQFXlmlzUbGkI2H4/zhgIs3MNRbNzs+sVU/4rKXqFNgQIUa7o7CWsaNu
         McOL7G1n2K0nr+JRQheWXL0hKWvVCEeyD2HTt+sn3jrzT4ZvTy/5o3fmP8OnsGhg0Cgc
         gSJA==
X-Gm-Message-State: ALoCoQmT2i2uCMkB795rc1eCB6NtjCEPCObVJnFnT+GL9xhlxHtYopXcP6hVD13CiPrc68flQNrh
X-Received: by 10.50.3.71 with SMTP id a7mr363423iga.9.1445998497721;
        Tue, 27 Oct 2015 19:14:57 -0700 (PDT)
Received: from ubuntu.twitter.corp? ([8.25.196.25])
        by smtp.gmail.com with ESMTPSA id lo2sm9240077igb.17.2015.10.27.19.14.55
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 27 Oct 2015 19:14:57 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.658.g6d8523e-twtrsrc
In-Reply-To: <1445998467-11511-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280337>

From: Ronnie Sahlberg <sahlberg@google.com>

These functions do not use any backend specific code so we move
them to the common code.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
Signed-off-by: David Turner <dturner@twopensource.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 refs-be-files.c | 52 ----------------------------------------------------
 refs.c          | 52 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 52 insertions(+), 52 deletions(-)

diff --git a/refs-be-files.c b/refs-be-files.c
index b74b6cc..ab72adf 100644
--- a/refs-be-files.c
+++ b/refs-be-files.c
@@ -1944,58 +1944,6 @@ int peel_ref(const char *refname, unsigned char *sha1)
 	return peel_object(base, sha1);
 }
 
-struct warn_if_dangling_data {
-	FILE *fp;
-	const char *refname;
-	const struct string_list *refnames;
-	const char *msg_fmt;
-};
-
-static int warn_if_dangling_symref(const char *refname, const struct object_id *oid,
-				   int flags, void *cb_data)
-{
-	struct warn_if_dangling_data *d = cb_data;
-	const char *resolves_to;
-	struct object_id junk;
-
-	if (!(flags & REF_ISSYMREF))
-		return 0;
-
-	resolves_to = resolve_ref_unsafe(refname, 0, junk.hash, NULL);
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
index e0bc031..1f77978 100644
--- a/refs.c
+++ b/refs.c
@@ -545,3 +545,55 @@ char *shorten_unambiguous_ref(const char *refname, int strict)
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
+static int warn_if_dangling_symref(const char *refname, const struct object_id *oid,
+				   int flags, void *cb_data)
+{
+	struct warn_if_dangling_data *d = cb_data;
+	const char *resolves_to;
+	struct object_id junk;
+
+	if (!(flags & REF_ISSYMREF))
+		return 0;
+
+	resolves_to = resolve_ref_unsafe(refname, 0, junk.hash, NULL);
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
2.4.2.658.g6d8523e-twtrsrc
