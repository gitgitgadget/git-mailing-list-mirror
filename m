From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [RFC PATCH v4 12/19] unpack-trees(): add CE_WT_REMOVE to remove on worktree alone
Date: Thu, 20 Aug 2009 20:47:06 +0700
Message-ID: <1250776033-12395-13-git-send-email-pclouds@gmail.com>
References: <1250776033-12395-1-git-send-email-pclouds@gmail.com>
 <1250776033-12395-2-git-send-email-pclouds@gmail.com>
 <1250776033-12395-3-git-send-email-pclouds@gmail.com>
 <1250776033-12395-4-git-send-email-pclouds@gmail.com>
 <1250776033-12395-5-git-send-email-pclouds@gmail.com>
 <1250776033-12395-6-git-send-email-pclouds@gmail.com>
 <1250776033-12395-7-git-send-email-pclouds@gmail.com>
 <1250776033-12395-8-git-send-email-pclouds@gmail.com>
 <1250776033-12395-9-git-send-email-pclouds@gmail.com>
 <1250776033-12395-10-git-send-email-pclouds@gmail.com>
 <1250776033-12395-11-git-send-email-pclouds@gmail.com>
 <1250776033-12395-12-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 20 15:49:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Me81K-0007ZS-9a
	for gcvg-git-2@lo.gmane.org; Thu, 20 Aug 2009 15:49:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754678AbZHTNs1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 20 Aug 2009 09:48:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754676AbZHTNs0
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Aug 2009 09:48:26 -0400
Received: from rv-out-0506.google.com ([209.85.198.226]:44931 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754675AbZHTNsZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Aug 2009 09:48:25 -0400
Received: by rv-out-0506.google.com with SMTP id k40so26612rvb.5
        for <git@vger.kernel.org>; Thu, 20 Aug 2009 06:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=eK7xQL9wkEAfxxKuMshyXR1VpUMrSp32JkvJaGqWubs=;
        b=Cyw/ZOh3RW2eKQg0eUK6YixBYbWRiMqtpj27PQYDEahIk+kGD1zTrdU7cp+o+lPpWR
         GZdq4OWPQKfvZlYe6+FnfK/wZTbvNK5QID3FCzWWxinAmgiBKOTYHwNeVJGVku+HO52c
         JAkoV69A3b7W/1FW0rg3kt+Wh8W2IW/4ktvfc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=JJL1tj4O+GH3BUEAFS4smp+oNv0kUSZ/gWsJM/QkO95GDuabgRIAY3wpyFuzx5UGW7
         ws/NlEBlXOvYAnIgjeVpN8K4c+SDegSzMa53wKhbhq4XlA3/gfs5ZvsVOF8ar0e6mwj0
         O9TgFg4/ApO8CWTF27+QV0UTg4Kl3Vm6Ziy4o=
Received: by 10.140.178.8 with SMTP id a8mr3027451rvf.192.1250776107407;
        Thu, 20 Aug 2009 06:48:27 -0700 (PDT)
Received: from pclouds@gmail.com ([115.73.241.222])
        by mx.google.com with ESMTPS id k2sm4912395rvb.33.2009.08.20.06.48.25
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 20 Aug 2009 06:48:26 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Thu, 20 Aug 2009 20:48:21 +0700
X-Mailer: git-send-email 1.6.3.GIT
In-Reply-To: <1250776033-12395-12-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126634>

CE_REMOVE now removes both worktree and index versions. Sparse
checkout must be able to remove worktree version while keep the
index intact when checkout area is narrowed.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 cache.h        |    3 +++
 unpack-trees.c |    9 ++++++++-
 2 files changed, 11 insertions(+), 1 deletions(-)

diff --git a/cache.h b/cache.h
index 3b0e5fc..0e912a9 100644
--- a/cache.h
+++ b/cache.h
@@ -177,6 +177,9 @@ struct cache_entry {
 #define CE_HASHED    (0x100000)
 #define CE_UNHASHED  (0x200000)
=20
+/* Only remove in work directory, not index */
+#define CE_WT_REMOVE (0x400000)
+
 /*
  * Extended on-disk flags
  */
diff --git a/unpack-trees.c b/unpack-trees.c
index dc6d74a..6a51a69 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -78,7 +78,7 @@ static int check_updates(struct unpack_trees_options =
*o)
 	if (o->update && o->verbose_update) {
 		for (total =3D cnt =3D 0; cnt < index->cache_nr; cnt++) {
 			struct cache_entry *ce =3D index->cache[cnt];
-			if (ce->ce_flags & (CE_UPDATE | CE_REMOVE))
+			if (ce->ce_flags & (CE_UPDATE | CE_REMOVE | CE_WT_REMOVE))
 				total++;
 		}
=20
@@ -92,6 +92,13 @@ static int check_updates(struct unpack_trees_options=
 *o)
 	for (i =3D 0; i < index->cache_nr; i++) {
 		struct cache_entry *ce =3D index->cache[i];
=20
+		if (ce->ce_flags & CE_WT_REMOVE) {
+			display_progress(progress, ++cnt);
+			if (o->update)
+				unlink_entry(ce);
+			continue;
+		}
+
 		if (ce->ce_flags & CE_REMOVE) {
 			display_progress(progress, ++cnt);
 			if (o->update)
--=20
1.6.3.GIT
