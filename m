From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 01/13] refs.c: make ref_transaction_create a wrapper for ref_transaction_update
Date: Thu,  4 Dec 2014 00:29:11 -0800
Message-ID: <1417681763-32334-2-git-send-email-sbeller@google.com>
References: <1417681763-32334-1-git-send-email-sbeller@google.com>
Cc: git@vger.kernel.org, Ronnie Sahlberg <sahlberg@google.com>,
	Stefan Beller <sbeller@google.com>
To: ronniesahlberg@gmail.com, mhagger@alum.mit.edu, jrnieder@gmail.com,
	gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Dec 04 09:29:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XwRn8-0005bi-9y
	for gcvg-git-2@plane.gmane.org; Thu, 04 Dec 2014 09:29:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752714AbaLDI3f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Dec 2014 03:29:35 -0500
Received: from mail-ie0-f171.google.com ([209.85.223.171]:61078 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752117AbaLDI3e (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Dec 2014 03:29:34 -0500
Received: by mail-ie0-f171.google.com with SMTP id rl12so15231176iec.2
        for <git@vger.kernel.org>; Thu, 04 Dec 2014 00:29:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=YPhVSG0xO/TsL0aI75VQBQwm5G+PicP7gK+aoWjagZg=;
        b=cQABiHJvO39aXKOOg6Hw0D7IAP8KUKrMGKWa2jyB5OIpRmFvt8d/Z+2i4DDyvV98Ch
         KwEqXgsZxdG4Ugbc86XlPtc/TCwnlDEvPoV45x3ppbyFEsgaNdpELrd7A6y3+J82Zoxl
         ES09tsR7Oqy0hNsOBBlUnM1yR0Rdr5afLwSfNWpBn+rQ5rrATKjOZu/nARefXceyoe7C
         B990xkdwKXq+Dz0Uwq2XZksAQLcZ8azraD9RUoAmMbnKhGH1spB0w0lRYjXA9c14xY4E
         FfJ6sJ8rtzEZjB08PU7cGDUVu0CQE2gmZqiu5SMGA4cdbgKUi0fsHfQBymdIEBUNMuqf
         lmjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=YPhVSG0xO/TsL0aI75VQBQwm5G+PicP7gK+aoWjagZg=;
        b=F37RWp8fs5o+Xw1IBdoS1RRrNFAR1IQYfwmfQojsHgmcfWajyKhkpZkrAQ0Xwuar+A
         fYxjj4ORrTzozlW2cZmUjoCIRhnHyviwzNfein7mZFDpRv8yOfXbbuRrmNpwAlrIbmU0
         MhyHEiN+5PYRzowPW0KqnmLJgOhUl1ZCCdXjJyuy3HvkYY22NbBZOrjeuetlZxdTnEi2
         N/YJpCkWAMND+WDuQG3YomWjWJ1noIKyXLbYFjTpZEswmLtDKABcY7xVkUqvnxvGWhIZ
         V+UrzhcrWPvrLqK53kg4fck3cHiWAhBiizPtAu1h2NET3O0OsR2mINwvA/dgv5dWGYPr
         COMQ==
X-Gm-Message-State: ALoCoQmKS4WjWu2wUs4CPHbTBQEeHOfoC4UfphIIqQLZNDyL5tv+WIP3arOUBZpNJ/9mXqx0wwy3
X-Received: by 10.107.10.168 with SMTP id 40mr8752003iok.66.1417681773206;
        Thu, 04 Dec 2014 00:29:33 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:5d2c:9a2d:3064:bc4])
        by mx.google.com with ESMTPSA id c139sm6170271ioc.28.2014.12.04.00.29.32
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 04 Dec 2014 00:29:32 -0800 (PST)
X-Mailer: git-send-email 2.2.0
In-Reply-To: <1417681763-32334-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260732>

From: Ronnie Sahlberg <sahlberg@google.com>

The ref_transaction_update function can already be used to create refs by
passing null_sha1 as the old_sha1 parameter. Simplify by replacing
transaction_create with a thin wrapper.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
Reviewed-by: Michael Haggerty <mhagger@alum.mit.edu>
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
---

Notes:
    origin/sb/ref-transaction-unify-to-update
    as well as
    origin/sb/ref-transaction-reflog
    
    no changes since sending them last time

 refs.c | 27 ++-------------------------
 1 file changed, 2 insertions(+), 25 deletions(-)

diff --git a/refs.c b/refs.c
index 5ff457e..005eb18 100644
--- a/refs.c
+++ b/refs.c
@@ -3623,31 +3623,8 @@ int ref_transaction_create(struct ref_transaction *transaction,
 			   int flags, const char *msg,
 			   struct strbuf *err)
 {
-	struct ref_update *update;
-
-	assert(err);
-
-	if (transaction->state != REF_TRANSACTION_OPEN)
-		die("BUG: create called for transaction that is not open");
-
-	if (!new_sha1 || is_null_sha1(new_sha1))
-		die("BUG: create ref with null new_sha1");
-
-	if (check_refname_format(refname, REFNAME_ALLOW_ONELEVEL)) {
-		strbuf_addf(err, "refusing to create ref with bad name %s",
-			    refname);
-		return -1;
-	}
-
-	update = add_update(transaction, refname);
-
-	hashcpy(update->new_sha1, new_sha1);
-	hashclr(update->old_sha1);
-	update->flags = flags;
-	update->have_old = 1;
-	if (msg)
-		update->msg = xstrdup(msg);
-	return 0;
+	return ref_transaction_update(transaction, refname, new_sha1,
+				      null_sha1, flags, 1, msg, err);
 }
 
 int ref_transaction_delete(struct ref_transaction *transaction,
-- 
2.2.0
