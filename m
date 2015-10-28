From: David Turner <dturner@twopensource.com>
Subject: [PATCH v5 11/26] refs.c: move read_ref, read_ref_full and ref_exists to the common code
Date: Tue, 27 Oct 2015 22:14:12 -0400
Message-ID: <1445998467-11511-12-git-send-email-dturner@twopensource.com>
References: <1445998467-11511-1-git-send-email-dturner@twopensource.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>,
	David Turner <dturner@twopensource.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Wed Oct 28 03:15:14 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZrGGd-00017v-12
	for gcvg-git-2@plane.gmane.org; Wed, 28 Oct 2015 03:15:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755240AbbJ1CPD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Oct 2015 22:15:03 -0400
Received: from mail-ig0-f176.google.com ([209.85.213.176]:34655 "EHLO
	mail-ig0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755237AbbJ1CO7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Oct 2015 22:14:59 -0400
Received: by igpw7 with SMTP id w7so19299160igp.1
        for <git@vger.kernel.org>; Tue, 27 Oct 2015 19:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource_com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mULhjHtz7dmiuKK8ufBbymSOP/hkDrSCD7hlLTjgs8I=;
        b=P69KS/cA+s2BIMMampvzud3OCk+WLA19di5pNF8gvvF/6XYW+IM4vgzyb/W2A6GOSe
         1PDyKL3vjBpeahPjEgzm5FnuMVu1+qLZHetN5Yezbk2tHmQlL0GAMjtFy5PFxMt4/n+X
         MRn1yaC3qCGKK37XAMP0lRhvRawitT0/gIMVkiDWHfDYPFuXvxRXrommJZMeZof3290Y
         TPAKIXtYrJnZtgI1aNf821hPLKcoVzpFqPn/deTfIPnDJaBCOYPf5Qtf8yXks+z5MDG1
         Nn8LkmGdwfGMXSv29dP58q0yRKQNp3DC7khhR52bMM9ntQnmlWUAyD7S3HlhgTQ8QrLl
         2pfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=mULhjHtz7dmiuKK8ufBbymSOP/hkDrSCD7hlLTjgs8I=;
        b=R2SEEHcmE79ssDEtlrdAXBSsbnaIbZ/QujcwoXcdMYZhoCWwDNVbuaKKCDEpAK4gGl
         2m1mkdEjuSxmTdvoM0CnnDudqpTMXSOsJBAvOg8UqNWBMB++iwUSPtqVpSdL5iBIaKLX
         I6AAo94wn/iRW/4/07xNByNOFLXLVwpx0+uhSyFFPOb+MZr0G/BkcSUoidUknDa+rPAD
         oy80uZnvg5ulzRZ38xNgyeBn2moCPegX1C4NrUnK6FXI1nyJ+nHYoX/+EdB+iO6B7YX4
         Ma4OJ9jU1vd2VxuwlRi7B0C4y/yKXi43EAVDRqbmg8G7JKOLJ2zHq+wxEFifm/eOdWnO
         YLUA==
X-Gm-Message-State: ALoCoQkCMLUgEVmQXZkNACgxzdnAnbybIRqzyk/geRNv0NSrFu73CahPsrw+521TACGqaBCybog1
X-Received: by 10.50.20.74 with SMTP id l10mr376106ige.2.1445998499240;
        Tue, 27 Oct 2015 19:14:59 -0700 (PDT)
Received: from ubuntu.twitter.corp? ([8.25.196.25])
        by smtp.gmail.com with ESMTPSA id lo2sm9240077igb.17.2015.10.27.19.14.57
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 27 Oct 2015 19:14:58 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.658.g6d8523e-twtrsrc
In-Reply-To: <1445998467-11511-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280335>

From: Ronnie Sahlberg <sahlberg@google.com>

These functions do not depend on the backend implementation so we
move them to the common code.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
Signed-off-by: David Turner <dturner@twopensource.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 refs-be-files.c | 18 ------------------
 refs.c          | 18 ++++++++++++++++++
 2 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/refs-be-files.c b/refs-be-files.c
index ab72adf..7f341bd 100644
--- a/refs-be-files.c
+++ b/refs-be-files.c
@@ -1791,24 +1791,6 @@ struct ref_filter {
 	void *cb_data;
 };
 
-int read_ref_full(const char *refname, int resolve_flags, unsigned char *sha1, int *flags)
-{
-	if (resolve_ref_unsafe(refname, resolve_flags, sha1, flags))
-		return 0;
-	return -1;
-}
-
-int read_ref(const char *refname, unsigned char *sha1)
-{
-	return read_ref_full(refname, RESOLVE_REF_READING, sha1, NULL);
-}
-
-int ref_exists(const char *refname)
-{
-	unsigned char sha1[20];
-	return !!resolve_ref_unsafe(refname, RESOLVE_REF_READING, sha1, NULL);
-}
-
 static int filter_refs(const char *refname, const struct object_id *oid,
 			   int flags, void *data)
 {
diff --git a/refs.c b/refs.c
index 1f77978..f3241e4 100644
--- a/refs.c
+++ b/refs.c
@@ -597,3 +597,21 @@ void warn_dangling_symrefs(FILE *fp, const char *msg_fmt, const struct string_li
 	data.msg_fmt = msg_fmt;
 	for_each_rawref(warn_if_dangling_symref, &data);
 }
+
+int read_ref_full(const char *refname, int resolve_flags, unsigned char *sha1, int *flags)
+{
+	if (resolve_ref_unsafe(refname, resolve_flags, sha1, flags))
+		return 0;
+	return -1;
+}
+
+int read_ref(const char *refname, unsigned char *sha1)
+{
+	return read_ref_full(refname, RESOLVE_REF_READING, sha1, NULL);
+}
+
+int ref_exists(const char *refname)
+{
+	unsigned char sha1[20];
+	return !!resolve_ref_unsafe(refname, RESOLVE_REF_READING, sha1, NULL);
+}
-- 
2.4.2.658.g6d8523e-twtrsrc
