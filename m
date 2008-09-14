From: =?utf-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 02/16] Introduce CE_NO_CHECKOUT bit
Date: Sun, 14 Sep 2008 20:07:51 +0700
Message-ID: <1221397685-27715-3-git-send-email-pclouds@gmail.com>
References: <1221397685-27715-1-git-send-email-pclouds@gmail.com>
 <1221397685-27715-2-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 14 15:09:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KerM9-0005mQ-Tk
	for gcvg-git-2@gmane.org; Sun, 14 Sep 2008 15:09:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753865AbYINNIa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 14 Sep 2008 09:08:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753828AbYINNIa
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Sep 2008 09:08:30 -0400
Received: from wf-out-1314.google.com ([209.85.200.170]:21050 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753399AbYINNI3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Sep 2008 09:08:29 -0400
Received: by wf-out-1314.google.com with SMTP id 27so1590748wfd.4
        for <git@vger.kernel.org>; Sun, 14 Sep 2008 06:08:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=ObhoDCcClkpN4YwtXW1q9rOIWqoE6P8b5fixmbO/m3Q=;
        b=ZdB/9NMZmF6On870RcJN+HZUZQMRIVwzNXJol35Qp15u5Kp0ey0PfnrtrvsqjUnnXo
         cOMYdQJh+D7bZd8skGYMGn+6WaKnSG6QHxQH8loF+OEAqH6rKZ5OKLLby1A2hME2Zhkq
         63Nlo/dcbbP8Na2IE7SxOvZUBl+VWeevLhSPo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=ctvi6ASdMSbGLGKGxfDQenw8qOVSn0ZH0OV93hqauJ1orRzvqphjVPJdom8l4Ss39i
         j22JBHSiEzRHCXBy/9PwtqVvY10prODAccm/38tzSfz7PyxfLpDkZx0tvL9OrrxvOv0W
         MjItUqGO1si+YNLbGPfQJDQ4dwwAI5WP7JgRE=
Received: by 10.142.177.7 with SMTP id z7mr2254375wfe.249.1221397709233;
        Sun, 14 Sep 2008 06:08:29 -0700 (PDT)
Received: from pclouds@gmail.com ( [117.5.40.147])
        by mx.google.com with ESMTPS id 22sm20079734wfg.13.2008.09.14.06.08.25
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 14 Sep 2008 06:08:27 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Sun, 14 Sep 2008 20:08:20 +0700
X-Mailer: git-send-email 1.6.0.96.g2fad1.dirty
In-Reply-To: <1221397685-27715-2-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95829>

This bit is the basis of narrow checkout. If this bit is on, the entry
is outside narrow checkout and therefore should be ignored (similar
to CE_VALID)

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 cache.h      |   10 +++++++++-
 read-cache.c |    6 +++---
 2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/cache.h b/cache.h
index 1e572e4..2b2c90f 100644
--- a/cache.h
+++ b/cache.h
@@ -170,10 +170,11 @@ struct cache_entry {
 /*
  * Extended on-disk flags
  */
+#define CE_NO_CHECKOUT 0x40000000
 /* CE_EXTENDED2 is for future extension */
 #define CE_EXTENDED2 0x80000000
=20
-#define CE_EXTENDED_FLAGS (0)
+#define CE_EXTENDED_FLAGS (CE_NO_CHECKOUT)
=20
 /*
  * Safeguard to avoid saving wrong flags:
@@ -185,6 +186,9 @@ struct cache_entry {
 #error "CE_EXTENDED_FLAGS out of range"
 #endif
=20
+/* "Assume unchanged" mask */
+#define CE_VALID_MASK (CE_VALID | CE_NO_CHECKOUT)
+
 /*
  * Copy the sha1 and stat state of a cache entry from one to
  * another. But we never change the name, or the hash state!
@@ -222,6 +226,10 @@ static inline size_t ce_namelen(const struct cache=
_entry *ce)
 			    ondisk_cache_entry_size(ce_namelen(ce)))
 #define ce_stage(ce) ((CE_STAGEMASK & (ce)->ce_flags) >> CE_STAGESHIFT=
)
 #define ce_uptodate(ce) ((ce)->ce_flags & CE_UPTODATE)
+#define ce_no_checkout(ce) ((ce)->ce_flags & CE_NO_CHECKOUT)
+#define ce_checkout(ce) (!ce_no_checkout(ce))
+#define ce_mark_no_checkout(ce) ((ce)->ce_flags |=3D CE_NO_CHECKOUT)
+#define ce_mark_checkout(ce) ((ce)->ce_flags &=3D ~CE_NO_CHECKOUT)
 #define ce_mark_uptodate(ce) ((ce)->ce_flags |=3D CE_UPTODATE)
=20
 #define ce_permissions(mode) (((mode) & 0100) ? 0755 : 0644)
diff --git a/read-cache.c b/read-cache.c
index 667c36b..e965a4c 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -254,7 +254,7 @@ int ie_match_stat(const struct index_state *istate,
 	 * If it's marked as always valid in the index, it's
 	 * valid whatever the checked-out copy says.
 	 */
-	if (!ignore_valid && (ce->ce_flags & CE_VALID))
+	if (!ignore_valid && (ce->ce_flags & CE_VALID_MASK))
 		return 0;
=20
 	changed =3D ce_match_stat_basic(ce, st);
@@ -962,10 +962,10 @@ static struct cache_entry *refresh_cache_ent(stru=
ct index_state *istate,
 		return ce;
=20
 	/*
-	 * CE_VALID means the user promised us that the change to
+	 * CE_VALID_MASK means the user promised us that the change to
 	 * the work tree does not matter and told us not to worry.
 	 */
-	if (!ignore_valid && (ce->ce_flags & CE_VALID)) {
+	if (!ignore_valid && (ce->ce_flags & CE_VALID_MASK)) {
 		ce_mark_uptodate(ce);
 		return ce;
 	}
--=20
1.6.0.96.g2fad1.dirty
