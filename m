From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v3 06/19] refs.c: make update_ref_write to return error string on failure
Date: Fri, 25 Apr 2014 09:14:41 -0700
Message-ID: <1398442494-23438-7-git-send-email-sahlberg@google.com>
References: <1398442494-23438-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 25 18:17:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WdioG-00015Z-N8
	for gcvg-git-2@plane.gmane.org; Fri, 25 Apr 2014 18:17:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752623AbaDYQQl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Apr 2014 12:16:41 -0400
Received: from mail-qa0-f73.google.com ([209.85.216.73]:45775 "EHLO
	mail-qa0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753723AbaDYQPC (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Apr 2014 12:15:02 -0400
Received: by mail-qa0-f73.google.com with SMTP id hw13so633180qab.0
        for <git@vger.kernel.org>; Fri, 25 Apr 2014 09:15:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=UwnzpTODaAh87WihNCBvZFj9DzLeXlP8OSk0pO5Ddao=;
        b=gnAxpd07PcbiYP6/qEnkOYbdHVLza83jD8ggZ1bQv+JMksO+RsWRHX/EFoC99thPyG
         3WcZ6XAiAD4IwNvW9L5dRvw5YYK28p1uOoDDor5Pl86Xj57f2hrCIH6sBSkQmn9sFI3o
         hmgGVyUB/AWc44Wz2tnvP3flKzMEYBAepLIoacnBEgpejAlXY62C9dLKcmVXa+jHHQi9
         ovAVgjIEbk+edIca8sYcsgecMVHRcjKFkYg8Ral3EcKmM0VGLa9olDHhKCMtwVydOekn
         BZFlry8JlPZZxqGoWD5FZaqG+i2a6PUXY0uA+7POiKJu3i6z+n+omTuXX6M8A7w24KtE
         d95A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=UwnzpTODaAh87WihNCBvZFj9DzLeXlP8OSk0pO5Ddao=;
        b=Li91ncT7u37eBLtJWgufu01HmGcPaMlX+REMqQ2GWF+/7jZC5yj8rjN5LiwvMkHXF7
         weUnxJ2H5vx0PHkSznzK7LxO4M2DPLCtSNAVZ1XLbTDNcMgoWSv/hoy69UlW/YhoKyw/
         hr4dGNcj6xWFj8/rfOPFF7FRXlzEcvR9xBCtbkFPBIuxoXEpDsXQ5DdXVNjFppTUZB5U
         FCKodQnGJWlB++xKmjMKIqNkuhuxcMiOxBXeyGR3l9EoLzID2iv2CRMiDAdm/CyK0HVU
         ZYc/Igvhc4frmo01xbBlxJDzQ584Femq1bypN01EBObISCaQruSXux48Bs0i/qaQt6ji
         n6RQ==
X-Gm-Message-State: ALoCoQnVVWaysqVzlYr7au+AKC4YG8sNHXiXAUQOpuGGBcZoR2qRLgwl02Hned4J7qCO91hFIcpTMMkkKZ6z4Q1nbSuFTzndYLb5xAVzoD+98gC3DL6SVJeycXPkI5EplJDRUcaViT9duZHa+FVyto+aPlmT4aHUFhPPYu37HdOX/BQ8CItHaC1YdchwcXADT7yesCxP0hkl
X-Received: by 10.52.165.179 with SMTP id yz19mr4176508vdb.1.1398442502080;
        Fri, 25 Apr 2014 09:15:02 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id a44si1049857yhb.6.2014.04.25.09.15.02
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 25 Apr 2014 09:15:02 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id B9DC431C1B6;
	Fri, 25 Apr 2014 09:15:01 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 6DE14E0855; Fri, 25 Apr 2014 09:15:01 -0700 (PDT)
X-Mailer: git-send-email 1.9.1.521.g5dc89fa
In-Reply-To: <1398442494-23438-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247067>

Change update_ref_write to also return an error string on failure.
This makes the error avaialbel to ref_transaction_commit callers if the
transaction failed dur to update_ref_sha1/write_ref_sha1 failures.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/refs.c b/refs.c
index 9d9eab8..7562151 100644
--- a/refs.c
+++ b/refs.c
@@ -3253,10 +3253,14 @@ static struct ref_lock *update_ref_lock(const char *refname,
 
 static int update_ref_write(const char *action, const char *refname,
 			    const unsigned char *sha1, struct ref_lock *lock,
-			    enum action_on_err onerr)
+			    char **err, enum action_on_err onerr)
 {
 	if (write_ref_sha1(lock, sha1, action) < 0) {
 		const char *str = "Cannot update the ref '%s'.";
+		if (err) {
+			*err = xmalloc(PATH_MAX + 26);
+			snprintf(*err, PATH_MAX + 26, str, refname);
+		}
 		switch (onerr) {
 		case UPDATE_REFS_MSG_ON_ERR: error(str, refname); break;
 		case UPDATE_REFS_DIE_ON_ERR: die(str, refname); break;
@@ -3382,7 +3386,7 @@ int update_ref(const char *action, const char *refname,
 	lock = update_ref_lock(refname, oldval, flags, NULL, onerr);
 	if (!lock)
 		return 1;
-	return update_ref_write(action, refname, sha1, lock, onerr);
+	return update_ref_write(action, refname, sha1, lock, NULL, onerr);
 }
 
 static int ref_update_compare(const void *r1, const void *r2)
@@ -3472,7 +3476,7 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 			ret = update_ref_write(msg,
 					       update->refname,
 					       update->new_sha1,
-					       update->lock, onerr);
+					       update->lock, err, onerr);
 			update->lock = NULL; /* freed by update_ref_write */
 			if (ret)
 				goto cleanup;
-- 
1.9.1.521.g5dc89fa
