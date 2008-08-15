From: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: [PATCH 1/9] Introduce CE_NO_CHECKOUT bit
Date: Fri, 15 Aug 2008 21:24:58 +0700
Message-ID: <20080815142457.GA10653@laptop>
References: <cover.1218807249.git.pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 15 16:26:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KU0Fz-0004yH-HZ
	for gcvg-git-2@gmane.org; Fri, 15 Aug 2008 16:26:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754831AbYHOOZO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 15 Aug 2008 10:25:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755557AbYHOOZO
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Aug 2008 10:25:14 -0400
Received: from py-out-1112.google.com ([64.233.166.181]:26857 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753031AbYHOOZM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Aug 2008 10:25:12 -0400
Received: by py-out-1112.google.com with SMTP id p76so868457pyb.10
        for <git@vger.kernel.org>; Fri, 15 Aug 2008 07:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:date:from:to:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=y06WA48NP+X2rfWqef0MKO9FwNw66iiBGzx31b7X8qo=;
        b=baOa591cu7gvzl+v+qwc2q0NJnCYnQJFqTVWUEuou2TLzyutqZEWacZQ9Uce1msYY5
         mhLsMOtpV66+JIxLS+Gv4dPzdCE0jRXq0YXVmhN0oFNABj1Tu+z9nNaagp7fTtMM5/CS
         Ex1NCr9hrjTH+/uE97t378IJaJJ9vTmOxYKpY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=NWgU57sO1+eRb5xPEHtn8l3OUyoDq5GejcJvLYANqnbBMX04tqAJZ8mnew2A/vm4fX
         NLf9Dgp1s2zz4kOnCokzxYoAbeCbbsr39UN5zX+H3jKJQHnciUA4kbLoFOrk+4Z60jzD
         QXMjnbJYxMKLoEpCSPEB8ZffQnZ98vKnDHT+E=
Received: by 10.114.241.15 with SMTP id o15mr2549277wah.164.1218810311656;
        Fri, 15 Aug 2008 07:25:11 -0700 (PDT)
Received: from pclouds@gmail.com ( [125.234.152.212])
        by mx.google.com with ESMTPS id y25sm6912617pod.8.2008.08.15.07.25.09
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 15 Aug 2008 07:25:10 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Fri, 15 Aug 2008 21:24:58 +0700
Content-Disposition: inline
In-Reply-To: <cover.1218807249.git.pclouds@gmail.com>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92474>

This bit is the basis of narrow checkout. If this bit is on, the entry
is outside narrow checkout and therefore should be ignored (similar
to CE_VALID)

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 cache.h      |    8 ++++++++
 read-cache.c |    6 +++---
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/cache.h b/cache.h
index 30f1d62..86288b6 100644
--- a/cache.h
+++ b/cache.h
@@ -126,6 +126,7 @@ struct cache_entry {
=20
 #define CE_NAMEMASK  (0x0fff)
 #define CE_STAGEMASK (0x3000)
+#define CE_NO_CHECKOUT (0x4000)
 #define CE_VALID     (0x8000)
 #define CE_STAGESHIFT 12
=20
@@ -138,6 +139,9 @@ struct cache_entry {
 #define CE_HASHED    (0x100000)
 #define CE_UNHASHED  (0x200000)
=20
+/* "Assume unchanged" mask */
+#define CE_VALID_MASK (CE_VALID | CE_NO_CHECKOUT)
+
 /*
  * Copy the sha1 and stat state of a cache entry from one to
  * another. But we never change the name, or the hash state!
@@ -173,6 +177,10 @@ static inline size_t ce_namelen(const struct cache=
_entry *ce)
 #define ondisk_ce_size(ce) ondisk_cache_entry_size(ce_namelen(ce))
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
index a940f8d..d7f6b97 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -253,7 +253,7 @@ int ie_match_stat(const struct index_state *istate,
 	 * If it's marked as always valid in the index, it's
 	 * valid whatever the checked-out copy says.
 	 */
-	if (!ignore_valid && (ce->ce_flags & CE_VALID))
+	if (!ignore_valid && (ce->ce_flags & CE_VALID_MASK))
 		return 0;
=20
 	changed =3D ce_match_stat_basic(ce, st);
@@ -943,10 +943,10 @@ static struct cache_entry *refresh_cache_ent(stru=
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
1.6.0.rc3.250.g8dd0
