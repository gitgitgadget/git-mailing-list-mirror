From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v14 30/40] refs.c: remove lock_ref_sha1
Date: Fri,  6 Jun 2014 15:29:08 -0700
Message-ID: <1402093758-3162-31-git-send-email-sahlberg@google.com>
References: <1402093758-3162-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 07 00:31:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wt2fa-0003Kh-Vn
	for gcvg-git-2@plane.gmane.org; Sat, 07 Jun 2014 00:31:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752641AbaFFWaj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jun 2014 18:30:39 -0400
Received: from mail-oa0-f74.google.com ([209.85.219.74]:41588 "EHLO
	mail-oa0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752548AbaFFW3X (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jun 2014 18:29:23 -0400
Received: by mail-oa0-f74.google.com with SMTP id m1so741436oag.5
        for <git@vger.kernel.org>; Fri, 06 Jun 2014 15:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0FS+ASektXNJXMHLPkUuyotaETJOt1j97DPl3FKBn40=;
        b=l/WpvjUipoAR07TjnPAutyEnyrLx0fvK3ewO4HahuRcMymzJ0cCckzTnw1L8TG3vRA
         h6KzeBERreOF0pRXENquOCXI1CcEOo1qK4Bb1IasnPR+HotnB39i3I/FtNwOd0Sa6QwL
         mw9MS7N27svBK68mqdT4lvOhH032YpC4DGRD7Bc6YXXQ6TmpZnq5HTsxZTMEDNBVsDww
         T7Y7/t3nGGLKWMdD/NQhAh4+XW+upsVenOgDiJD3dXJ2vqcdnw7CR/Anv7wzzcqtxNDL
         1ol4km5i/qQx17ROJ7s4Gd0o+7rhe5sGX0zsWoNFF8LE9USI76OZQ2cs55oTJvc6vX0T
         rTRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0FS+ASektXNJXMHLPkUuyotaETJOt1j97DPl3FKBn40=;
        b=UT59hPTRfg0tMrHy54u/HMka7oCy9BJu4OXxiL1QVKn9nCjFwUWbr7TADIm4LFlieb
         QDoGBvvVV+X1Y2/H5R1YozA7lN1o9SnOBuz505ixWvycRiKmI+55sCVJFKG6czDl2dqw
         O9ZYBy8jnwM2xVvJLmDUmQUOhZPbBV66gdgVZ82wDTT9WHENp4HpkTAu0XSZ72yxFVbl
         rdRarRFMK6JsqBrUKRCFN0NwCQAkhJEq0MQFwdTqK+ja84CuRifxmEEvblhxm+/5I2x8
         w0CNyBHTO/N83Zx+Gef1ayDcmtIpnt5tOHBPURdrpXo30sIoxzrmvpwLg+yrLuJIBcHI
         frmg==
X-Gm-Message-State: ALoCoQl+yqCptxjqNGwLnHazCcHSc4gozz4UeK1VI6FDX3RsIn9Y/qtY2vgaWPUmilGaWZC5NP/G
X-Received: by 10.42.19.73 with SMTP id a9mr4428424icb.31.1402093763115;
        Fri, 06 Jun 2014 15:29:23 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id ds6si750437vdb.0.2014.06.06.15.29.23
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 06 Jun 2014 15:29:23 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id D66EE31C61F;
	Fri,  6 Jun 2014 15:29:22 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id AFC3CE09AC; Fri,  6 Jun 2014 15:29:22 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.582.ge25c160
In-Reply-To: <1402093758-3162-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251002>

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
index 245c540..bc750f4 100644
--- a/refs.c
+++ b/refs.c
@@ -2139,15 +2139,6 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
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
@@ -2356,8 +2347,12 @@ static void try_remove_empty_parents(char *name)
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
2.0.0.582.ge25c160
