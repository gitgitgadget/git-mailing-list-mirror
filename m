From: =?UTF-8?q?Ren=C3=A9=20Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH 1/7] cache: mark cache_entry pointers const
Date: Thu, 30 May 2013 13:34:18 +0200
Message-ID: <1369913664-49734-2-git-send-email-rene.scharfe@lsrfire.ath.cx>
References: <1369913664-49734-1-git-send-email-rene.scharfe@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Stephen Boyd <sboyd@codeaurora.org>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 30 13:34:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ui180-0006iS-C6
	for gcvg-git-2@plane.gmane.org; Thu, 30 May 2013 13:34:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752308Ab3E3Lef convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 30 May 2013 07:34:35 -0400
Received: from india601.server4you.de ([85.25.151.105]:57594 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751843Ab3E3Leb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 May 2013 07:34:31 -0400
Received: from debian.Speedport_W_504V_Typ_A (p579BEB6E.dip0.t-ipconnect.de [87.155.235.110])
	by india601.server4you.de (Postfix) with ESMTPSA id 3E125344;
	Thu, 30 May 2013 13:34:29 +0200 (CEST)
X-Mailer: git-send-email 1.8.3
In-Reply-To: <1369913664-49734-1-git-send-email-rene.scharfe@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225959>

Add const for pointers that are only dereferenced for reading by the
inline functions copy_cache_entry and ce_mode_from_stat.  This allows
callers to pass in const pointers.

Signed-off-by: Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx>
---
 cache.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/cache.h b/cache.h
index 94ca1ac..43a27e7 100644
--- a/cache.h
+++ b/cache.h
@@ -190,7 +190,8 @@ struct cache_entry {
  * another. But we never change the name, or the hash state!
  */
 #define CE_STATE_MASK (CE_HASHED | CE_UNHASHED)
-static inline void copy_cache_entry(struct cache_entry *dst, struct ca=
che_entry *src)
+static inline void copy_cache_entry(struct cache_entry *dst,
+				    const struct cache_entry *src)
 {
 	unsigned int state =3D dst->ce_flags & CE_STATE_MASK;
=20
@@ -222,7 +223,8 @@ static inline unsigned int create_ce_mode(unsigned =
int mode)
 		return S_IFGITLINK;
 	return S_IFREG | ce_permissions(mode);
 }
-static inline unsigned int ce_mode_from_stat(struct cache_entry *ce, u=
nsigned int mode)
+static inline unsigned int ce_mode_from_stat(const struct cache_entry =
*ce,
+					     unsigned int mode)
 {
 	extern int trust_executable_bit, has_symlinks;
 	if (!has_symlinks && S_ISREG(mode) &&
--=20
1.8.3
