From: David Turner <dturner@twopensource.com>
Subject: [PATCH 02/43] refs: make repack_without_refs and is_branch public
Date: Wed,  2 Sep 2015 21:54:32 -0400
Message-ID: <1441245313-11907-3-git-send-email-dturner@twopensource.com>
References: <1441245313-11907-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>,
	Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Thu Sep 03 03:55:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZXJkT-0005xh-8G
	for gcvg-git-2@plane.gmane.org; Thu, 03 Sep 2015 03:55:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756280AbbICBza (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Sep 2015 21:55:30 -0400
Received: from mail-qk0-f178.google.com ([209.85.220.178]:35839 "EHLO
	mail-qk0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751543AbbICBz2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Sep 2015 21:55:28 -0400
Received: by qkcj187 with SMTP id j187so15696796qkc.2
        for <git@vger.kernel.org>; Wed, 02 Sep 2015 18:55:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jDmoqCaD+djWG9rYZ6YK+fsd0wv12G2MAhkM/tP5vXA=;
        b=l6qiwBqJFMbWJo56yyEiax9oaIq0K376qVg/nhcCSgVQmWEIvnU3xrzUD1PcqqBn0o
         REdYy66xm5t93EJH5d49gdQWZPQBV8DXy8N2b8Lngi0rovGQ33JDl1qXcL5MshgxGOMA
         KyF18GqTBCvFtq1HvDshRu2jMBe3a+81ZfTVdfQqVuKfP72KISdFoSz/MWUV3hhZHS6A
         VvczorJKbyx6XBNuubRj15M3Fe6NHlp6gCu32lN0tZfFsFf8eqd8FCj+4vEg3bn28Ecg
         dJ0u3w73Lu+hbXFnEFxXwAmUJJx62PNA4NZPg3lKS4tVBgFSqnxGniaNqqMzbv0cJ26r
         uOLw==
X-Gm-Message-State: ALoCoQmbm2vjs/dSYRVwf2UESX/SXpEsW0r+El3aZEdPV9viYWFW/WnpTwLY6lnnGt+VTEcTdh9S
X-Received: by 10.55.48.67 with SMTP id w64mr34312958qkw.32.1441245327605;
        Wed, 02 Sep 2015 18:55:27 -0700 (PDT)
Received: from ubuntu.jfk4.office.twttr.net ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id 95sm11108155qgt.12.2015.09.02.18.55.26
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 02 Sep 2015 18:55:26 -0700 (PDT)
X-Mailer: git-send-email 2.0.4.315.gad8727a-twtrsrc
In-Reply-To: <1441245313-11907-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277137>

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
Signed-off-by: David Turner <dturner@twopensource.com>
---
 refs.c |  7 -------
 refs.h | 13 +++++++++++++
 2 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/refs.c b/refs.c
index 76b05f1..9c29899 100644
--- a/refs.c
+++ b/refs.c
@@ -2824,13 +2824,6 @@ int pack_refs(unsigned int flags)
 	return 0;
 }
 
-/*
- * Rewrite the packed-refs file, omitting any refs listed in
- * 'refnames'. On error, leave packed-refs unchanged, write an error
- * message to 'err', and return a nonzero value.
- *
- * The refs in 'refnames' needn't be sorted. `err` must not be NULL.
- */
 int repack_without_refs(struct string_list *refnames, struct strbuf *err)
 {
 	struct ref_dir *packed;
diff --git a/refs.h b/refs.h
index 140aa8b..e0c6ea1 100644
--- a/refs.h
+++ b/refs.h
@@ -218,6 +218,19 @@ extern void warn_dangling_symrefs(FILE *fp, const char *msg_fmt, const struct st
 int pack_refs(unsigned int flags);
 
 /*
+ * Rewrite the packed-refs file, omitting any refs listed in
+ * 'refnames'. On error, packed-refs will be unchanged, the return
+ * value is nonzero, and a message about the error is written to the
+ * 'err' strbuf.
+ *
+ * The refs in 'refnames' needn't be sorted. `err` must not be NULL.
+ */
+extern int repack_without_refs(struct string_list *refnames,
+			       struct strbuf *err);
+
+extern int is_branch(const char *refname);
+
+/*
  * Return true iff a reference named refname could be created without
  * conflicting with the name of an existing reference.  If
  * skip is non-NULL, ignore potential conflicts with refs in skip
-- 
2.0.4.315.gad8727a-twtrsrc
