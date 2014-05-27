From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v11 12/41] refs.c: change ref_transaction_update() to do error checking and return status
Date: Tue, 27 May 2014 13:25:31 -0700
Message-ID: <1401222360-21175-13-git-send-email-sahlberg@google.com>
References: <1401222360-21175-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 27 22:27:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WpNyK-0004MU-VC
	for gcvg-git-2@plane.gmane.org; Tue, 27 May 2014 22:27:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753620AbaE0U1k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 May 2014 16:27:40 -0400
Received: from mail-yh0-f73.google.com ([209.85.213.73]:52828 "EHLO
	mail-yh0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752894AbaE0U0F (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 May 2014 16:26:05 -0400
Received: by mail-yh0-f73.google.com with SMTP id f73so1644957yha.2
        for <git@vger.kernel.org>; Tue, 27 May 2014 13:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=lFDaUtjFS74DuUjwk8EPRm0looT7f8abDLnVRphrsHE=;
        b=NsAkoVGUSnpaZe5+CxB428Jy9cirhB5ZCSzIndI4bmd2H264rU//LvZWXQ5lsp7BgB
         gptK5w9xVgk0tVzTDLMkg1A2YgZtNN6If1+f4gJltsVlf5a7SQvx3LQW7EK38+8AG1WX
         U1hJnWrgpP7l4xqC6NCbD3kyqsoWtC1OanUmW4Wbdv4X6iywxKlSlPLkxioAoes1nUkE
         ZplrCmgKq2+UnEJWWd2B5dL8L3RKC5711tR4aEMGXGnQO/cBtzT0PAZDlmaFM7DlFOug
         ZIbL9DcAXOq4VNhPaxQNeDFN1me8Fzm0pl1P9lwOvryBG+mIqITiNtR6yvw348Ys7HWv
         JwUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=lFDaUtjFS74DuUjwk8EPRm0looT7f8abDLnVRphrsHE=;
        b=NT4hsyYdL3cxlGLhu0XeM7pMTXvyLe4DFZJrvjoUGXQLR044EGlabOyagjoh/JOF0g
         nJN3BkSXICUdds8mKCmQn1lABBZOIgRs6TjuP/ArdN0V/XWrl9h2xYp6m24YJgndH+Vw
         RDyKReuI3e06pz9oo/DkWJ+022RIhLfYfsaQDSSMHwSF4LQ6qwcqqO8wJl+Q4t26OrrE
         fbwDgjhRF4IUKgF3/TLbyhL7fv+zSzmAeYLjN6CBaPOoFmTnxPFAt1xPPNd52WGYepb9
         5+yo5SUuFZ7foMEzneF6vMg624TlIMtvJBH0ZcT+FDn+tbppxmoQuU07x9CsabX21GS5
         oTpQ==
X-Gm-Message-State: ALoCoQnaze6bJpwC5WwgO/IJOGkx0uXX14e+0O496/sFNshFkSy5AerR/GPE8gqSXJrJG5f/yk5x
X-Received: by 10.236.124.100 with SMTP id w64mr5933036yhh.57.1401222364320;
        Tue, 27 May 2014 13:26:04 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id n59si1574266yhi.6.2014.05.27.13.26.04
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 27 May 2014 13:26:04 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 10D44370568;
	Tue, 27 May 2014 13:26:04 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id BE61CE1B35; Tue, 27 May 2014 13:26:03 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc3.474.g0203784
In-Reply-To: <1401222360-21175-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250223>

Update ref_transaction_update() do some basic error checking and return
non-zero on error. Update all callers to check ref_transaction_update() for
error. There are currently no conditions in _update that will return error but
there will be in the future. Add an err argument that will be updated on
failure. In future patches we will start doing both locking and checking
for name conflicts in _update instead of _commit at which time this function
will start returning errors for these conditions.

Also check for BUGs during update and die(BUG:...) if we are calling
_update with have_old but the old_sha1 pointer is NULL.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 builtin/update-ref.c | 12 +++++++-----
 refs.c               | 18 ++++++++++++------
 refs.h               | 14 +++++++++-----
 3 files changed, 28 insertions(+), 16 deletions(-)

diff --git a/builtin/update-ref.c b/builtin/update-ref.c
index 88ab785..3067b11 100644
--- a/builtin/update-ref.c
+++ b/builtin/update-ref.c
@@ -16,6 +16,7 @@ static struct ref_transaction *transaction;
 
 static char line_termination = '\n';
 static int update_flags;
+static struct strbuf err = STRBUF_INIT;
 
 /*
  * Parse one whitespace- or NUL-terminated, possibly C-quoted argument
@@ -197,8 +198,9 @@ static const char *parse_cmd_update(struct strbuf *input, const char *next)
 	if (*next != line_termination)
 		die("update %s: extra input: %s", refname, next);
 
-	ref_transaction_update(transaction, refname, new_sha1, old_sha1,
-			       update_flags, have_old);
+	if (ref_transaction_update(transaction, refname, new_sha1, old_sha1,
+				   update_flags, have_old, &err))
+		die("%s", err.buf);
 
 	update_flags = 0;
 	free(refname);
@@ -286,8 +288,9 @@ static const char *parse_cmd_verify(struct strbuf *input, const char *next)
 	if (*next != line_termination)
 		die("verify %s: extra input: %s", refname, next);
 
-	ref_transaction_update(transaction, refname, new_sha1, old_sha1,
-			       update_flags, have_old);
+	if (ref_transaction_update(transaction, refname, new_sha1, old_sha1,
+				   update_flags, have_old, &err))
+		die("%s", err.buf);
 
 	update_flags = 0;
 	free(refname);
@@ -342,7 +345,6 @@ int cmd_update_ref(int argc, const char **argv, const char *prefix)
 	const char *refname, *oldval, *msg = NULL;
 	unsigned char sha1[20], oldsha1[20];
 	int delete = 0, no_deref = 0, read_stdin = 0, end_null = 0, flags = 0;
-	struct strbuf err = STRBUF_INIT;
 	struct option options[] = {
 		OPT_STRING( 'm', NULL, &msg, N_("reason"), N_("reason of the update")),
 		OPT_BOOL('d', NULL, &delete, N_("delete the reference")),
diff --git a/refs.c b/refs.c
index 00b6e9a..79a4477 100644
--- a/refs.c
+++ b/refs.c
@@ -3376,19 +3376,25 @@ static struct ref_update *add_update(struct ref_transaction *transaction,
 	return update;
 }
 
-void ref_transaction_update(struct ref_transaction *transaction,
-			    const char *refname,
-			    const unsigned char *new_sha1,
-			    const unsigned char *old_sha1,
-			    int flags, int have_old)
+int ref_transaction_update(struct ref_transaction *transaction,
+			   const char *refname,
+			   const unsigned char *new_sha1,
+			   const unsigned char *old_sha1,
+			   int flags, int have_old,
+			   struct strbuf *err)
 {
-	struct ref_update *update = add_update(transaction, refname);
+	struct ref_update *update;
+
+	if (have_old && !old_sha1)
+		die("BUG: have_old is true but old_sha1 is NULL");
 
+	update = add_update(transaction, refname);
 	hashcpy(update->new_sha1, new_sha1);
 	update->flags = flags;
 	update->have_old = have_old;
 	if (have_old)
 		hashcpy(update->old_sha1, old_sha1);
+	return 0;
 }
 
 void ref_transaction_create(struct ref_transaction *transaction,
diff --git a/refs.h b/refs.h
index 6ee9c9e..32edf3f 100644
--- a/refs.h
+++ b/refs.h
@@ -234,12 +234,16 @@ struct ref_transaction *ref_transaction_begin(void);
  * be deleted.  If have_old is true, then old_sha1 holds the value
  * that the reference should have had before the update, or zeros if
  * it must not have existed beforehand.
+ * Function returns 0 on success and non-zero on failure. A failure to update
+ * means that the transaction as a whole has failed and will need to be
+ * rolled back. On failure the err buffer will be updated.
  */
-void ref_transaction_update(struct ref_transaction *transaction,
-			    const char *refname,
-			    const unsigned char *new_sha1,
-			    const unsigned char *old_sha1,
-			    int flags, int have_old);
+int ref_transaction_update(struct ref_transaction *transaction,
+			   const char *refname,
+			   const unsigned char *new_sha1,
+			   const unsigned char *old_sha1,
+			   int flags, int have_old,
+			   struct strbuf *err);
 
 /*
  * Add a reference creation to transaction.  new_sha1 is the value
-- 
2.0.0.rc3.474.g0203784
