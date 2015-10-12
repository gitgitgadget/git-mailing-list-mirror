From: David Turner <dturner@twopensource.com>
Subject: [PATCH v3 02/44] refs: make repack_without_refs and is_branch public
Date: Mon, 12 Oct 2015 17:51:22 -0400
Message-ID: <1444686725-27660-3-git-send-email-dturner@twopensource.com>
References: <1444686725-27660-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>,
	Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Mon Oct 12 23:52:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zll13-0004Ch-EH
	for gcvg-git-2@plane.gmane.org; Mon, 12 Oct 2015 23:52:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752077AbbJLVwR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Oct 2015 17:52:17 -0400
Received: from mail-qg0-f45.google.com ([209.85.192.45]:33789 "EHLO
	mail-qg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751647AbbJLVwQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Oct 2015 17:52:16 -0400
Received: by qgeb31 with SMTP id b31so28254355qge.0
        for <git@vger.kernel.org>; Mon, 12 Oct 2015 14:52:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=aM+YYtcJ74Yr2p4251dDXVZXxvNruk0YFHmnO1RMid0=;
        b=WgDOvneOinOAHoydcl8ZEXdwkKrNuBXl3svH9vPtQJEatiqiyx8+aJ+LN2vWdI4EDX
         V9Xk1kzO6IVwmkJcNVPkLb2/9RmPrcjHxKhvhv55MsjwdXXqBav+sCP6sHe7RugqbGm8
         3qtRrTXM87GDse8+TWzRX3KUOcbAFkFGxw46mydHRMN2OicOwR+PLzs+kxg81mxKUajG
         83RCe5F4xOuUFIiwSUHy0zHx1RfMIV5QafCGYmDEqd1DVcT9w7NPMYScrxYZixVL1kV0
         9PUybmNNRQHbZ2GM5LMt1+aE+ep4wIq5oUDIhgXxdOq/EKWtgO5YNIhwJ0DAIn9Qs1Cq
         iLkg==
X-Gm-Message-State: ALoCoQl0BKgOhu7WEkyo3cRMM/xQAS7y0cpIT9YtJYbMCrjprnVG0QKclDMNMpkBv877XjdUiCdL
X-Received: by 10.140.95.73 with SMTP id h67mr35617409qge.14.1444686735978;
        Mon, 12 Oct 2015 14:52:15 -0700 (PDT)
Received: from ubuntu.jfk4.office.twttr.net ([192.133.79.147])
        by smtp.gmail.com with ESMTPSA id q140sm7865647qha.5.2015.10.12.14.52.14
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 12 Oct 2015 14:52:15 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.644.g97b850b-twtrsrc
In-Reply-To: <1444686725-27660-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279421>

is_branch was already non-static, but this patch declares it in the
header.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
Signed-off-by: David Turner <dturner@twopensource.com>
---
 refs.c |  9 +--------
 refs.h | 13 +++++++++++++
 2 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/refs.c b/refs.c
index fe71ea0..d0dfdfc 100644
--- a/refs.c
+++ b/refs.c
@@ -2814,14 +2814,7 @@ int pack_refs(unsigned int flags)
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
