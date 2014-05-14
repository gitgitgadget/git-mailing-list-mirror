From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH 04/31] refs.c: add a new update_type field to ref_update
Date: Wed, 14 May 2014 15:13:03 -0700
Message-ID: <1400105610-21194-5-git-send-email-sahlberg@google.com>
References: <1400105610-21194-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 15 00:15:41 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WkhSd-0001LH-BF
	for gcvg-git-2@plane.gmane.org; Thu, 15 May 2014 00:15:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753869AbaENWP2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 May 2014 18:15:28 -0400
Received: from mail-pb0-f73.google.com ([209.85.160.73]:43942 "EHLO
	mail-pb0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753151AbaENWNe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 May 2014 18:13:34 -0400
Received: by mail-pb0-f73.google.com with SMTP id ma3so51492pbc.2
        for <git@vger.kernel.org>; Wed, 14 May 2014 15:13:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1mmY1BPgS/QX+wPNRZH0SodcxTGNZjD+s3lMQzxJP88=;
        b=ORwk4SpPbCJ17J1IELZf4fKMCntZakNKu0+sQVcfbYj1QplLyCMIDsdSIONoWTJkJz
         fspY4cNYuUteFTzxZlZUfuJru1dtbuxxjlqWoGV2I746o7E/aim/ylMMEs3Rd0+huiWJ
         LYRGlY0Tuk7EMxSb+eSIWVmZhjCIntx9XMLSdGOPIvc1TGj02XueXETy7bHlD+nVZqXk
         VK3AJfOSsF42FUP8WLxuhiu2yvAh6fXjPHU6E6tDmHvU7F7QRjLq8555cHcGJLmeBBW7
         9qCgj6dkjKxn/qrSdahQFFcrjTHLyOic1rSZOrkgnHbvIQJPQktocdj9wAqg0QkhO0NV
         kr/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1mmY1BPgS/QX+wPNRZH0SodcxTGNZjD+s3lMQzxJP88=;
        b=SfyiWIuiP59zCbWB65rIqU6dO/KZvqr6dw2eKKvqqvXXT0OGTdWP6nZTaRfPv20Rf4
         4ij3BTSbzVqKmS6xLcgOKlDXLEaS1jV/Idn0+qpWcR9noo/vl+eg/PHWMQiGNSLMADN/
         iPMepovBOGdM5VigY2+qRo0ASoiY638GlkTd865Ca+HhO88hsi2DnLn5uK4WHfFCHmTx
         1zQ1NAsQpvri4ovXQOOgO74y+VswkvB2SJ0jWEChw+4oHzmm+3OjvVFNQV+BpTEFTHtj
         3LfmBmrqFEPfaQ9RfGi6G/XSddVg7QMC0ee84aXbYBcBaO2XFedRAtX41uBWwtsw1ODU
         m0kw==
X-Gm-Message-State: ALoCoQk9AsgdJRmchIItjIKgzg+aVY6aQlgzR3GoV5W2Rgqm8xJUK2nYXkyNpfbZzDthItbMkJjZ
X-Received: by 10.66.65.109 with SMTP id w13mr548511pas.21.1400105613704;
        Wed, 14 May 2014 15:13:33 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id r79si152487yhj.2.2014.05.14.15.13.33
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 14 May 2014 15:13:33 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 8551731C1F8;
	Wed, 14 May 2014 15:13:33 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 49F76E0973; Wed, 14 May 2014 15:13:33 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc3.506.g3739a35
In-Reply-To: <1400105610-21194-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249038>

Add a field that describes what type of update this refers to. For now
the only type is UPDATE_SHA1 but we will soon add more types.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/refs.c b/refs.c
index 6785fa6..018062d 100644
--- a/refs.c
+++ b/refs.c
@@ -3235,6 +3235,10 @@ int for_each_reflog(each_ref_fn fn, void *cb_data)
 	return retval;
 }
 
+enum transaction_update_type {
+       UPDATE_SHA1 = 0,
+};
+
 /**
  * Information needed for a single ref update.  Set new_sha1 to the
  * new value or to zero to delete the ref.  To check the old value
@@ -3242,6 +3246,7 @@ int for_each_reflog(each_ref_fn fn, void *cb_data)
  * value or to zero to ensure the ref does not exist before update.
  */
 struct ref_update {
+	enum transaction_update_type update_type;
 	unsigned char new_sha1[20];
 	unsigned char old_sha1[20];
 	int flags; /* REF_NODEREF? */
@@ -3301,12 +3306,14 @@ void transaction_rollback(struct ref_transaction *transaction)
 }
 
 static struct ref_update *add_update(struct ref_transaction *transaction,
-				     const char *refname)
+				     const char *refname,
+				     enum transaction_update_type update_type)
 {
 	size_t len = strlen(refname);
 	struct ref_update *update = xcalloc(1, sizeof(*update) + len + 1);
 
 	strcpy((char *)update->refname, refname);
+	update->update_type = update_type;
 	ALLOC_GROW(transaction->updates, transaction->nr + 1, transaction->alloc);
 	transaction->updates[transaction->nr++] = update;
 	return update;
@@ -3329,7 +3336,7 @@ int transaction_update_sha1(struct ref_transaction *transaction,
 	if (flags & REF_ISPACKONLY && !is_null_sha1(new_sha1))
 		die("BUG: REF_ISPACKONLY can not be used with updates");
 
-	update = add_update(transaction, refname);
+	update = add_update(transaction, refname, UPDATE_SHA1);
 	hashcpy(update->new_sha1, new_sha1);
 	update->flags = flags;
 	update->have_old = have_old;
-- 
2.0.0.rc3.506.g3739a35
