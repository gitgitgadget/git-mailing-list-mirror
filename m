From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v7 04/42] refs.c: make ref_update_reject_duplicates take a strbuf argument for errors
Date: Wed, 14 May 2014 14:16:38 -0700
Message-ID: <1400102236-30082-5-git-send-email-sahlberg@google.com>
References: <1400102236-30082-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 14 23:21:41 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WkgcO-00024e-Bv
	for gcvg-git-2@plane.gmane.org; Wed, 14 May 2014 23:21:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753798AbaENVV2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 May 2014 17:21:28 -0400
Received: from mail-pb0-f73.google.com ([209.85.160.73]:65251 "EHLO
	mail-pb0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752796AbaENVRV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 May 2014 17:17:21 -0400
Received: by mail-pb0-f73.google.com with SMTP id ma3so37018pbc.2
        for <git@vger.kernel.org>; Wed, 14 May 2014 14:17:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jYxtRv1FbqhgpBhNM72P/3eL7srcZVpD9JzLmujfC4o=;
        b=mSGehRpDA4KkLlMq34mlCGaDyETqFccRIJm1Oh8IDuqnlohIq6TIbp1gteCvA6fpzX
         zmXdiusAAy1DvtFmbGlwiizhEntNycmxr12vnkipJlfjUJt756QWWGpSYYZc4r54hIL9
         ZKD6Z3czlZOAzAwAoFYNhLlcKPsh7UUlVloAZQum6+AXord8ePAhPTthZ+pcEVauZPfA
         7bQVAONDBtQu1WBEx5ayKErmeMX7JDhTfnjNOdALuaoat7KnylWJDBG3UgrK4JOgyspT
         aunRa4GRIDmMiZUPhFXDyeBos0qCJ0pTQVZxKGAmUUVsV5+KhuilcVRSNcBgQSr4xKO/
         wnaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jYxtRv1FbqhgpBhNM72P/3eL7srcZVpD9JzLmujfC4o=;
        b=GCk/lKJTo2HwJVueDihfmmPENeiKj4tJt0wFBRgnNZTxvDsxj89Z/FMw2Ar+trWE20
         DS1A4yW4x5KRkuHHSIx5VWbH3DRQoLs+DKoMwahzfft0573z4BRQ2Q74WCehkbXZEZa/
         VmXsMmxHY0Wi1PgI+knWC+RXY6Tt7CqfDZLBmJfno8UAS0TAzDD7aeNVKvQgK81ZYKAA
         z7r7Gclua723/XMCZVVuLdyy8pwkOrz3UTnH83PJ2vZo3Ai/Pwy73UoeijkaCZG3vHZ+
         fNBFBH19c5SuNiAFJOuy6YtWhNV6Qg/zQjh4fg0cLxsfDAmOMmsA0HOay+3J41z2Z7wW
         LlNA==
X-Gm-Message-State: ALoCoQnhBbLmxc1sjcFGaLvOnk2xNm3G/zFQZDQJCdWqMDYiHMi8t8jzXSzyBNrgxUJaeB2mSoUX
X-Received: by 10.66.231.68 with SMTP id te4mr357788pac.29.1400102240834;
        Wed, 14 May 2014 14:17:20 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id n68si71383yhj.5.2014.05.14.14.17.20
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 14 May 2014 14:17:20 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id A42165A4292;
	Wed, 14 May 2014 14:17:20 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 6848BE0973; Wed, 14 May 2014 14:17:20 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc3.471.g2055d11.dirty
In-Reply-To: <1400102236-30082-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248995>

Make ref_update_reject_duplicates return any error that occurs through a
new strbuf argument. This means that when a transaction commit fails in
this function we will now be able to pass a helpful error message back to the
caller.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/refs.c b/refs.c
index 1a7f9d9..364daf0 100644
--- a/refs.c
+++ b/refs.c
@@ -3402,6 +3402,7 @@ static int ref_update_compare(const void *r1, const void *r2)
 }
 
 static int ref_update_reject_duplicates(struct ref_update **updates, int n,
+					struct strbuf *err,
 					enum action_on_err onerr)
 {
 	int i;
@@ -3409,6 +3410,9 @@ static int ref_update_reject_duplicates(struct ref_update **updates, int n,
 		if (!strcmp(updates[i - 1]->refname, updates[i]->refname)) {
 			const char *str =
 				"Multiple updates for ref '%s' not allowed.";
+			if (err)
+				strbuf_addf(err, str, updates[i]->refname);
+
 			switch (onerr) {
 			case UPDATE_REFS_MSG_ON_ERR:
 				error(str, updates[i]->refname); break;
@@ -3439,7 +3443,7 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 
 	/* Copy, sort, and reject duplicate refs */
 	qsort(updates, n, sizeof(*updates), ref_update_compare);
-	ret = ref_update_reject_duplicates(updates, n, onerr);
+	ret = ref_update_reject_duplicates(updates, n, err, onerr);
 	if (ret)
 		goto cleanup;
 
-- 
2.0.0.rc3.471.g2055d11.dirty
