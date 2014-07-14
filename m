From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v21 15/19] refs.c: make ref_update_reject_duplicates take a strbuf argument for errors
Date: Mon, 14 Jul 2014 13:58:57 -0700
Message-ID: <1405371541-32121-16-git-send-email-sahlberg@google.com>
References: <1405371541-32121-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 14 23:00:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X6nMO-0003TK-GJ
	for gcvg-git-2@plane.gmane.org; Mon, 14 Jul 2014 23:00:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757117AbaGNVAA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jul 2014 17:00:00 -0400
Received: from mail-ie0-f201.google.com ([209.85.223.201]:57866 "EHLO
	mail-ie0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756952AbaGNU7H (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jul 2014 16:59:07 -0400
Received: by mail-ie0-f201.google.com with SMTP id tr6so647059ieb.4
        for <git@vger.kernel.org>; Mon, 14 Jul 2014 13:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=NlRdOLrBNvxAuD7tHcuzFLxb3TABQ/atLjH8aEC6uUE=;
        b=ESlm4qJjawoZZrFiRHta83PpCdz61ETH/Sfgvb7LSON0qKYN4rpkZhGbA5YOPSX4z1
         8KuFy6rm5G3ph6JRrzQhL7K/oEjfuJTjwTOhFeM30O0lxmdgc8zmMIM41AWuA4/Hpq5Q
         9BLT+HkxmS0bnntwVwSKgqqMQfPZg7i65CP+ZrzEq8UKi5e2TRWhs3BUpWSNjNHetHi6
         owoTicUOd2dG6hR0vGHaEQQACbQq62ocP3G6SeedO2IuEthAe/1wF6R/jEf2gFs4WGBg
         ZwC+szN13GkwsuGlRcQBoeS6Nn3769Jp1j6yOGeysbiyL3Ic7IRAJ8Ggmy+y2DIFEPTv
         0etw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=NlRdOLrBNvxAuD7tHcuzFLxb3TABQ/atLjH8aEC6uUE=;
        b=PxVkOLTlD4HPsB7cnr54OEJ2UQTFZyMao4y8T3kGOdsb3TByNknizORL115MG/pv81
         foKCFpf/35eAZ+kbMvQnyAkH3l4dp9ztx3UVJYs73zUbWzULkJK+FSbvQRQhjRC+PSxj
         TaNtaXYxdjM8jcoAcB2Yzw/OwM/rkotRzTQQXR6TtNs1kZeaBbWuzwWbh3FGSby1wxe1
         uywsME6IncuzxZ1qQH05qUUPEqfj815rYnbmAzYaQ9KoKJ8FlX8D7n/FDNzRqhzW2Gnc
         3qoEnDYiAGSfRh56T4NSzLbung02CCicOZFJvVGqrt2CwVdLmXZmK1kBabXCADetksvg
         0xnQ==
X-Gm-Message-State: ALoCoQnbf0SLpEpDm0QHEcSER+tdLp3T3E7454pWIYzgB9LqMRmR6OsxPKs49MXU/AeUilFxz7NW
X-Received: by 10.42.37.71 with SMTP id x7mr10680005icd.4.1405371546068;
        Mon, 14 Jul 2014 13:59:06 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id j5si822634yhi.1.2014.07.14.13.59.06
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 14 Jul 2014 13:59:06 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id E268F31C4BC;
	Mon, 14 Jul 2014 13:59:05 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id B23C2E0856; Mon, 14 Jul 2014 13:59:05 -0700 (PDT)
X-Mailer: git-send-email 2.0.1.546.gf603308
In-Reply-To: <1405371541-32121-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253534>

Make ref_update_reject_duplicates return any error that occurs through a
new strbuf argument. This means that when a transaction commit fails in
this function we will now be able to pass a helpful error message back to the
caller.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
Reviewed-by: Michael Haggerty <mhagger@alum.mit.edu>
Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/refs.c b/refs.c
index 61570c9..115f143 100644
--- a/refs.c
+++ b/refs.c
@@ -3488,6 +3488,7 @@ static int ref_update_compare(const void *r1, const void *r2)
 }
 
 static int ref_update_reject_duplicates(struct ref_update **updates, int n,
+					struct strbuf *err,
 					enum action_on_err onerr)
 {
 	int i;
@@ -3495,6 +3496,9 @@ static int ref_update_reject_duplicates(struct ref_update **updates, int n,
 		if (!strcmp(updates[i - 1]->refname, updates[i]->refname)) {
 			const char *str =
 				"Multiple updates for ref '%s' not allowed.";
+			if (err)
+				strbuf_addf(err, str, updates[i]->refname);
+
 			switch (onerr) {
 			case UPDATE_REFS_MSG_ON_ERR:
 				error(str, updates[i]->refname); break;
@@ -3525,7 +3529,7 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 
 	/* Copy, sort, and reject duplicate refs */
 	qsort(updates, n, sizeof(*updates), ref_update_compare);
-	ret = ref_update_reject_duplicates(updates, n, onerr);
+	ret = ref_update_reject_duplicates(updates, n, err, onerr);
 	if (ret)
 		goto cleanup;
 
-- 
2.0.1.546.gf603308
