From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v16 38/48] refs.c: remove lock_ref_sha1
Date: Thu, 12 Jun 2014 10:21:29 -0700
Message-ID: <1402593699-13983-39-git-send-email-sahlberg@google.com>
References: <1402593699-13983-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 12 19:22:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wv8i8-0007gA-Dm
	for gcvg-git-2@plane.gmane.org; Thu, 12 Jun 2014 19:22:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933463AbaFLRW1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Jun 2014 13:22:27 -0400
Received: from mail-qc0-f202.google.com ([209.85.216.202]:46876 "EHLO
	mail-qc0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756281AbaFLRVp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jun 2014 13:21:45 -0400
Received: by mail-qc0-f202.google.com with SMTP id x13so99183qcv.5
        for <git@vger.kernel.org>; Thu, 12 Jun 2014 10:21:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=bQME9NDIWduEW9lMzKAhh8+5RIcrVIPgFqWo5s2Enk0=;
        b=oIt0PM3GOXewJfh2yLW4zECj4YjKZmP4OOltWk45GH7WtaM2so1fnJKOowdefoG2BH
         IOGDsnH/yl+ChpBk1eRiLVgDYSa7l8FzFIzWTNNLjA09KQVzr06cKPaOxT91ihixr5CE
         wwa3tdyHtChqEUAoXa+UdE31sVEnagB55s3jVCvvOvKbyWqr6iWdjjzpJbpjI7Zi8JmE
         ZIzBpre+ulFYzAd4FBNJajqB14VU8cv76wx12t5KnKEBdZoaV6rJs4iShy4bdqAYRakl
         m2nZWc1yJ1lTuKGBSc8SwShEfxY4GsTOkAAcXoHbrJuAHA0fzVVz7zgIBSk1406BkgBx
         U3BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=bQME9NDIWduEW9lMzKAhh8+5RIcrVIPgFqWo5s2Enk0=;
        b=GBiK8ueUiETa2bHCYGUU92YvUqAHb7OA9oybdNirRC/mLfAam6g0DiHWd9wW106GRK
         T/cHY4WsRqtLiLf+ZbnK/TSrUttHeoCjSrNtkRXRRU92I2ctXfd16Q5dlRU/FWFcXhfd
         wMm3ickn7jUL0cKsZ1/VmTcts833/wxETEKfHaIJOcpiCPJ/BGCvZk5Q0Rqa5OZ24+tC
         jQ0yvzG7Yx5kAaSQSTGNs9922h5KvkLC+jnr3scKUIucgzXpYnpJ0fD8O0Qcb8OlD1Td
         KpNPvND7wRBRHVMIokmuGtFrMHCy9xivgZPi44gUstX4FXosmi8Gwxf8lDF2s3PTmmQU
         KtgA==
X-Gm-Message-State: ALoCoQnwlwomnFBuCuxQXgaeG0jdmitAz4iyqHVRHZiNHZCfT+4o13CilxytAppJl333OgkZzbYi
X-Received: by 10.58.220.4 with SMTP id ps4mr1041729vec.38.1402593704645;
        Thu, 12 Jun 2014 10:21:44 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id n68si112267yhj.5.2014.06.12.10.21.44
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 12 Jun 2014 10:21:44 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 7ED8B5A4813;
	Thu, 12 Jun 2014 10:21:44 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 5D22BE0CFF; Thu, 12 Jun 2014 10:21:44 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.599.g83ced0e
In-Reply-To: <1402593699-13983-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251432>

lock_ref_sha1 was only called from one place in refc.c and only provided
a check that the refname was sane before adding back the initial "refs/"
part of the ref path name, the initial "refs/" that this caller had already
stripped off before calling lock_ref_sha1.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/refs.c b/refs.c
index 11084a1..1cb6ef6 100644
--- a/refs.c
+++ b/refs.c
@@ -2143,15 +2143,6 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
 	return NULL;
 }
 
-static struct ref_lock *lock_ref_sha1(const char *refname, const unsigned char *old_sha1)
-{
-	char refpath[PATH_MAX];
-	if (check_refname_format(refname, 0))
-		return NULL;
-	strcpy(refpath, mkpath("refs/%s", refname));
-	return lock_ref_sha1_basic(refpath, old_sha1, 0, NULL);
-}
-
 struct ref_lock *lock_any_ref_for_update(const char *refname,
 					 const unsigned char *old_sha1,
 					 int flags, int *type_p)
@@ -2361,8 +2352,12 @@ static void try_remove_empty_parents(char *name)
 /* make sure nobody touched the ref, and unlink */
 static void prune_ref(struct ref_to_prune *r)
 {
-	struct ref_lock *lock = lock_ref_sha1(r->name + 5, r->sha1);
+	struct ref_lock *lock;
+
+	if (check_refname_format(r->name + 5, 0))
+		return;
 
+	lock = lock_ref_sha1_basic(r->name, r->sha1, 0, NULL);
 	if (lock) {
 		unlink_or_warn(git_path("%s", r->name));
 		unlock_ref(lock);
-- 
2.0.0.599.g83ced0e
