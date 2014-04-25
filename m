From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v3 04/19] refs.c: return error string from ref_update_reject_duplicates on failure
Date: Fri, 25 Apr 2014 09:14:39 -0700
Message-ID: <1398442494-23438-5-git-send-email-sahlberg@google.com>
References: <1398442494-23438-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 25 18:17:03 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wdio7-0000rj-HW
	for gcvg-git-2@plane.gmane.org; Fri, 25 Apr 2014 18:16:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753561AbaDYQQo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Apr 2014 12:16:44 -0400
Received: from mail-qa0-f74.google.com ([209.85.216.74]:50552 "EHLO
	mail-qa0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753749AbaDYQPB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Apr 2014 12:15:01 -0400
Received: by mail-qa0-f74.google.com with SMTP id w8so634217qac.5
        for <git@vger.kernel.org>; Fri, 25 Apr 2014 09:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hCKC9EuYvTLIniROOnVOJWm81ECMbIdKRuj6IiUYKns=;
        b=WAvQ5df8mvM7A6MLXjHY/qaY4+w3Uhoy/9R5VV4gzPyxfq/1zWtRgXM0rdbLB8qdcV
         Tekd0qyz3D6jOH0EsZ+1+1h5F/c54qtTJPolqYZv1KRbY+XeNZiOE9EK4ASiZoRyW5EX
         oX+yl5fGfXylYLEofl4OAHAwB/dKg+PpIpQTSbyhQIgW8iu35MdhNvvBzBN+3+NyR+vP
         gJmK6j6z1M3PFOlH8SkRLk6HTznNbSGie45moK09ssA7oW8S1c/C875i1hRyvxfDiirW
         xywnSNeWBDRYAciahPD+fAQ+ad22VGj2fW6N8fEr/Ql0wFmkg8qI7fJiKvAN3OU8Fr65
         tyHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=hCKC9EuYvTLIniROOnVOJWm81ECMbIdKRuj6IiUYKns=;
        b=emec7OGPEfTbMpQwvo6QGxPCtPWQ2d7sxPpQNMKGyN+5QUxcGHy91X/8wTOmU93NtL
         ho2n2U1VwmrwXcszY8dqwH1WK1+my2TFHQjLl61EyV/xQEJquGxjnlSS7FbGnYj2n38J
         fo19tKqcFtrC8Rpx2NlG0sfJqKLCofawg6BEP3Zky1DTkFdepeRwQbcStVJzC+862P8x
         qC2ugrGcRipcCRp3+G+QbVX+cSb8CXe/1saPwu2xsctYUw8jAtTBgJU0qCfRlFiSA531
         G0cntbzUmAT0gcoVqAgcNdDORLDC/oXnfSr6XzIWRHKERAXtqo0JFuS2W+eRhzI6wCi9
         iSkA==
X-Gm-Message-State: ALoCoQn11DVl44c/d9JJTybNcvced1PaKU6AhJetday8qdfH4Jzb7P/Z4KCAs123Cv1Xvdui8DsB/n8unbv3D5GPBjWfZPfAD9SDOdAnaNG2+3bx7nLVRgluGym+N1x3G0p3tUz5+6bj3VtlVR8cj1upbatG4+1k+AmWpwx3RWLaihBbA6ERh1l7dEHRGLdXvDE6DDIFmma/
X-Received: by 10.236.141.11 with SMTP id f11mr4776459yhj.54.1398442500404;
        Fri, 25 Apr 2014 09:15:00 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id e40si1052326yhf.0.2014.04.25.09.15.00
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 25 Apr 2014 09:15:00 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 3D79E31C028;
	Fri, 25 Apr 2014 09:15:00 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id F1AA0E0855; Fri, 25 Apr 2014 09:14:59 -0700 (PDT)
X-Mailer: git-send-email 1.9.1.521.g5dc89fa
In-Reply-To: <1398442494-23438-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247063>

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/refs.c b/refs.c
index 0712912..9d9eab8 100644
--- a/refs.c
+++ b/refs.c
@@ -3393,6 +3393,7 @@ static int ref_update_compare(const void *r1, const void *r2)
 }
 
 static int ref_update_reject_duplicates(struct ref_update **updates, int n,
+					char **err,
 					enum action_on_err onerr)
 {
 	int i;
@@ -3400,6 +3401,11 @@ static int ref_update_reject_duplicates(struct ref_update **updates, int n,
 		if (!strcmp(updates[i - 1]->refname, updates[i]->refname)) {
 			const char *str =
 				"Multiple updates for ref '%s' not allowed.";
+			if (err) {
+				*err = xmalloc(PATH_MAX + 41);
+				snprintf(*err, PATH_MAX + 41, str,
+					 updates[i]->refname);
+			}
 			switch (onerr) {
 			case UPDATE_REFS_MSG_ON_ERR:
 				error(str, updates[i]->refname); break;
@@ -3433,7 +3439,7 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 
 	/* Copy, sort, and reject duplicate refs */
 	qsort(updates, n, sizeof(*updates), ref_update_compare);
-	ret = ref_update_reject_duplicates(updates, n, onerr);
+	ret = ref_update_reject_duplicates(updates, n, err, onerr);
 	if (ret)
 		goto cleanup;
 
-- 
1.9.1.521.g5dc89fa
