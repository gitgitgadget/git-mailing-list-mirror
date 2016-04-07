From: David Turner <dturner@twopensource.com>
Subject: [PATCH 17/24] read_raw_ref(): change flags parameter to unsigned int
Date: Thu,  7 Apr 2016 15:03:04 -0400
Message-ID: <1460055791-23313-18-git-send-email-dturner@twopensource.com>
References: <1460055791-23313-1-git-send-email-dturner@twopensource.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Thu Apr 07 21:04:31 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aoFEE-0007fu-0B
	for gcvg-git-2@plane.gmane.org; Thu, 07 Apr 2016 21:04:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757300AbcDGTEY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Apr 2016 15:04:24 -0400
Received: from mail-qg0-f53.google.com ([209.85.192.53]:34311 "EHLO
	mail-qg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932342AbcDGTDo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Apr 2016 15:03:44 -0400
Received: by mail-qg0-f53.google.com with SMTP id c6so71716983qga.1
        for <git@vger.kernel.org>; Thu, 07 Apr 2016 12:03:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=o5PXYYY9Px4OZgAbdI+pUsFzhvjhdotsVm142qQxZ50=;
        b=bE7onrRkLR7Do0t3rfsFALXpr0j08jtSR5rTTIN/IKsyjoPpJvySY20hYQKhG797lq
         M0U0KIIkEBj3jzcSXzvp5pWKuFWkPfR31qeLwP3LZQ5aCmsXF62TE3f9mryYjKaQgUaM
         IuUc9OjLh1rK7iBkkdE2JyAaLfgkABYy/TEBH5MVHHUJ6SUWfjM5AURzKjGxfDgHQFX1
         XMtFvIj1GfDYMqVkprTj86Q9nAQJLXh7x3Gwvhc09JfFElxey6OvNIcHnsIg2G0zVJ/g
         lqPJ+INqzDxvZGtk4BMX+FI/SH5QCEjfiAyHePb9kT/DnHivJ/FvaEOtIotsvP8bzo9Z
         8fcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=o5PXYYY9Px4OZgAbdI+pUsFzhvjhdotsVm142qQxZ50=;
        b=d0Kur71/8dzeklnBTr9Wl07gGbWxSN5chz2VcY65/eyyxmGVkGYk1tbNmfzvPzqOrj
         Dipmo3JxzmPNUU+yMVnYOHRl5ZMsKP2wlWxpZkqhxMmdgS7yi76ig64F/lyc6dD2ma6o
         duUZLg98fXwHK4pqyEq7iN88Ek4VjldFAyTKixt7/pDO/lYScCo8qnTCSGzl+CBPAq9a
         J7WnrdYYGhP96bMTvZvJG5f708bm2GTMLQ3Jx4ZHCQQHJGyvq7JyOb9p0f7MAMifEVG2
         bwe+Rgg/HcPD3v6LG4MYDbWLIA8U+fgzPxeAlpvIYWXV2AAVg/dAsHFnOQrpgP00gdFt
         qkhg==
X-Gm-Message-State: AD7BkJIzJtdtgpoP0kRdraqd4O3Qrb0KBwawBxK4Tu6Yj6kFaLzUx8LPlxFLBoUuvJibyg==
X-Received: by 10.140.23.139 with SMTP id 11mr5993849qgp.62.1460055818825;
        Thu, 07 Apr 2016 12:03:38 -0700 (PDT)
Received: from ubuntu.twitter.biz ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id e11sm3959273qkb.39.2016.04.07.12.03.37
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 07 Apr 2016 12:03:37 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.767.g62658d5-twtrsrc
In-Reply-To: <1460055791-23313-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290969>

From: Michael Haggerty <mhagger@alum.mit.edu>

read_raw_ref() is going to be part of the vtable for reference backends,
so clean up its interface to use "unsigned int flags" rather than "int
flags". Its caller still uses signed int for its flags arguments. But
changing that would touch a lot of code, so leave it for now.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/files-backend.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 120b2dd..a15986c 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1372,7 +1372,7 @@ static struct ref_entry *get_packed_ref(const char *refname)
  */
 static int resolve_missing_loose_ref(const char *refname,
 				     unsigned char *sha1,
-				     int *flags)
+				     unsigned int *flags)
 {
 	struct ref_entry *entry;
 
@@ -1421,7 +1421,7 @@ static int resolve_missing_loose_ref(const char *refname,
  *   refname will still be valid and unchanged.
  */
 static int read_raw_ref(const char *refname, unsigned char *sha1,
-			struct strbuf *symref, int *flags)
+			struct strbuf *symref, unsigned int *flags)
 {
 	struct strbuf sb_contents = STRBUF_INIT;
 	struct strbuf sb_path = STRBUF_INIT;
@@ -1570,7 +1570,7 @@ const char *resolve_ref_unsafe(const char *refname, int resolve_flags,
 	}
 
 	for (symref_count = 0; symref_count < MAXDEPTH; symref_count++) {
-		int read_flags = 0;
+		unsigned int read_flags = 0;
 
 		if (read_raw_ref(refname, sha1, &sb_refname, &read_flags)) {
 			*flags |= read_flags;
-- 
2.4.2.767.g62658d5-twtrsrc
