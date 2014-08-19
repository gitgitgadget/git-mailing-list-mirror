From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH 2/5] refs.c: make add_packed_ref return an error instead of calling die
Date: Tue, 19 Aug 2014 09:17:01 -0700
Message-ID: <1408465024-23162-3-git-send-email-sahlberg@google.com>
References: <1408465024-23162-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 19 18:17:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XJm6R-0003Fk-3e
	for gcvg-git-2@plane.gmane.org; Tue, 19 Aug 2014 18:17:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751976AbaHSQRS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Aug 2014 12:17:18 -0400
Received: from mail-pa0-f74.google.com ([209.85.220.74]:63075 "EHLO
	mail-pa0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752756AbaHSQRJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Aug 2014 12:17:09 -0400
Received: by mail-pa0-f74.google.com with SMTP id lj1so1806440pab.1
        for <git@vger.kernel.org>; Tue, 19 Aug 2014 09:17:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5P45S3Z6ypBQTfpaayD1Imp26woqHhOb9/i31MHWEeY=;
        b=PDbQkjPKaoCL+gakg2qNsF1Val7ejmKw/bg10e9lTZYIHy/zW7Xmxwpb/rv5CTdfVn
         aRxyIDcoYZIoVckiyONovEB7f7i9KoKYmzTsx3wcV+3XnVqopzXW24CQExRPwW3/gnM3
         RhFxm06xMNg3pyYaILikQ5UlOib2SZt7oWVjCXV6dzEX+MWCKxOzFfDMUELDYJsfMSv6
         WWBNsAoeRMpAqKsi3Hjwe7rJ9k4Swad28+X/sLv7pV7lfBD52V7ctTL7v4OOpsrDHszg
         JhJNGYdvO3BVGPMCKi/7ZPjBYRyXACbcdm5V9lVBGmeCG6XjJ79qVFrugK6ek0QWRdoT
         2DuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=5P45S3Z6ypBQTfpaayD1Imp26woqHhOb9/i31MHWEeY=;
        b=TQhyDTm3fkNb7YruYvZ43ynp9x1nT6beKoiXskcLRfr4MIKlPfStKmW/oDCy3A7Hfv
         WKnr/bwcUUygjFiQt7fOol3tWsOQLvyGQ4zStrRviGFXEIXqMhKyHSW91Y1A/rip8qvq
         tI7NWv5+vHrsLqrngCN3rAOwfm4KmIsEhsAsVeYqeOATAxOmaKYocsEpTuK6D5B/kU5N
         F3QNjkaUHIvOv0aDDB7Q15sbd/LieCWzRULG4jo4IHyiQHBSVPxngt/WX+eqz+rzIcJx
         ssS5dintkzVyeQbfXyfxuqqROWLwCvH9EYzqnX3H9spR2jlon9iqMOktHbjPqE6PzPBk
         dCQA==
X-Gm-Message-State: ALoCoQnyoEjSi2wMMb9tg2qiWfpwttoQWPVazlm8GpEQBb8kRRX5DOkvSamoAFTo2yb0KwW8cYsX
X-Received: by 10.70.90.47 with SMTP id bt15mr22355289pdb.4.1408465027137;
        Tue, 19 Aug 2014 09:17:07 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id y50si326168yhk.4.2014.08.19.09.17.07
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 19 Aug 2014 09:17:07 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id EC92D5A441E;
	Tue, 19 Aug 2014 09:17:06 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 96B79E0547; Tue, 19 Aug 2014 09:17:06 -0700 (PDT)
X-Mailer: git-send-email 2.0.1.556.ge8f7cba.dirty
In-Reply-To: <1408465024-23162-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255469>

Change add_packed_ref to return an error instead of calling die().
Update all callers to check the return value of add_packed_ref.

We can also skip checking the refname format since this function is now
static and only called from the transaction code.
If we are updating a ref and the refname is bad then we fail the transaction
already in transaction_update_sha1().
For the ref deletion case the only caveat is that we would not want
to move the badly named ref into the packed refs file during transaction
commit. This again is not a problem since if the name is bad, then
resolve_ref_unsafe() will fail which protects us from calling add_packed_ref()
with the bad name.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/refs.c b/refs.c
index 65eee72..0aad8c8 100644
--- a/refs.c
+++ b/refs.c
@@ -1135,17 +1135,16 @@ static struct ref_dir *get_packed_refs(struct ref_cache *refs)
 	return get_packed_ref_dir(get_packed_ref_cache(refs));
 }
 
-static void add_packed_ref(const char *refname, const unsigned char *sha1)
+static int add_packed_ref(const char *refname, const unsigned char *sha1)
 {
 	struct packed_ref_cache *packed_ref_cache =
 		get_packed_ref_cache(&ref_cache);
 
 	if (!packed_ref_cache->lock)
-		die("internal error: packed refs not locked");
-	if (check_refname_format(refname, REFNAME_ALLOW_ONELEVEL|REFNAME_DOT_COMPONENT))
-		die("Reference has invalid format: '%s'", refname);
+		return -1;
 	add_ref(get_packed_ref_dir(packed_ref_cache),
 		create_ref_entry(refname, sha1, REF_ISPACKED));
+	return 0;
 }
 
 /*
@@ -3666,7 +3665,13 @@ int transaction_commit(struct ref_transaction *transaction,
 					RESOLVE_REF_READING, NULL))
 			continue;
 
-		add_packed_ref(update->refname, sha1);
+		if (add_packed_ref(update->refname, sha1)) {
+			if (err)
+				strbuf_addf(err, "Failed to add %s to packed "
+					    "refs", update->refname);
+			ret = -1;
+			goto cleanup;
+		}
 		need_repack = 1;
 	}
 	if (need_repack) {
@@ -3778,7 +3783,13 @@ int transaction_commit(struct ref_transaction *transaction,
 
 		packed = get_packed_refs(&ref_cache);
 		remove_entry(packed, update->refname);
-		add_packed_ref(update->refname, update->new_sha1);
+		if (add_packed_ref(update->refname, update->new_sha1)) {
+			if (err)
+				strbuf_addf(err, "Failed to add %s to packed "
+					    "refs", update->refname);
+			ret = -1;
+			goto cleanup;
+		}
 		need_repack = 1;
 
 		try_remove_empty_parents((char *)update->refname);
-- 
2.0.1.556.ge8f7cba.dirty
