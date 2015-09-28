From: David Turner <dturner@twopensource.com>
Subject: [PATCH v2 02/43] refs: make repack_without_refs and is_branch public
Date: Mon, 28 Sep 2015 18:01:37 -0400
Message-ID: <1443477738-32023-3-git-send-email-dturner@twopensource.com>
References: <1443477738-32023-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>,
	Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Tue Sep 29 00:03:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZggVp-0000Zd-2h
	for gcvg-git-2@plane.gmane.org; Tue, 29 Sep 2015 00:03:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753780AbbI1WDA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Sep 2015 18:03:00 -0400
Received: from mail-qk0-f169.google.com ([209.85.220.169]:36259 "EHLO
	mail-qk0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753373AbbI1WC7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Sep 2015 18:02:59 -0400
Received: by qkcf65 with SMTP id f65so74204930qkc.3
        for <git@vger.kernel.org>; Mon, 28 Sep 2015 15:02:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zKXD8m1JXB9+lZrgdKuBWQ2zvXjrtrLH31ZU7TrYRss=;
        b=iCLt24A8qv656nwmMFgUSAgBiA6yYgtGCtHrEbH4LjyUFc6BEp8CgGRtmOrFI6z1bp
         VltINw9dAJWNo2mtZaqA2CaqP8Gj98KYROH6Nxx5gqcKFcRG9WD4vvdITCQdRkld6Yjn
         mOtz4QJ24zK4vKLTorTI6omaqHB8StVRbv84biHpsx+P5dGXcdoDXzY5LYRlpdNXjH+i
         k84SjmkrSEQJJhrKzIoUKgNXwDdIy1anTo1Q5PYmLgTnLIVAQmWshDDjqcL8q0jmqLFc
         /Y0zC0FTdoXyrj5P0Ja6o2sYJiOsD24S2/CFhsFl+t5wpalfVRptiO9RBaR6XA4M3OEC
         ovHA==
X-Gm-Message-State: ALoCoQnldcqhkuedOCwmDrmPILWGS6lYX8bV8jMZSGpTgZcWDJ7+i/+RkUS7CX3i5/AMjDLy1oeH
X-Received: by 10.55.192.219 with SMTP id v88mr948423qkv.7.1443477778181;
        Mon, 28 Sep 2015 15:02:58 -0700 (PDT)
Received: from ubuntu.jfk4.office.twttr.net ([192.133.79.147])
        by smtp.gmail.com with ESMTPSA id 128sm7949979qhe.9.2015.09.28.15.02.57
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 28 Sep 2015 15:02:57 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.644.g97b850b-twtrsrc
In-Reply-To: <1443477738-32023-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278756>

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
Signed-off-by: David Turner <dturner@twopensource.com>
---
 refs.c |  9 +--------
 refs.h | 13 +++++++++++++
 2 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/refs.c b/refs.c
index ce551e9..2741cc5 100644
--- a/refs.c
+++ b/refs.c
@@ -2826,14 +2826,7 @@ int pack_refs(unsigned int flags)
 	return 0;
 }
 
-/*
- * Rewrite the packed-refs file, omitting any refs listed in
- * 'refnames'. On error, leave packed-refs unchanged, write an error
- * message to 'err', and return a nonzero value.
- *
- * The refs in 'refnames' needn't be sorted. `err` must not be NULL.
- */
-static int repack_without_refs(struct string_list *refnames, struct strbuf *err)
+int repack_without_refs(struct string_list *refnames, struct strbuf *err)
 {
 	struct ref_dir *packed;
 	struct string_list_item *refname;
diff --git a/refs.h b/refs.h
index 79ea220..729bc3c 100644
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
2.4.2.644.g97b850b-twtrsrc
