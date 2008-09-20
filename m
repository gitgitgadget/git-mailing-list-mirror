From: =?utf-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 02/14] Introduce CE_NO_CHECKOUT bit
Date: Sat, 20 Sep 2008 17:01:41 +0700
Message-ID: <1221904913-25887-3-git-send-email-pclouds@gmail.com>
References: <1221904913-25887-1-git-send-email-pclouds@gmail.com>
 <1221904913-25887-2-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 20 12:03:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KgzJL-00016z-2n
	for gcvg-git-2@gmane.org; Sat, 20 Sep 2008 12:03:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751320AbYITKCX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 20 Sep 2008 06:02:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751266AbYITKCX
	(ORCPT <rfc822;git-outgoing>); Sat, 20 Sep 2008 06:02:23 -0400
Received: from rv-out-0506.google.com ([209.85.198.227]:18345 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751289AbYITKCW (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Sep 2008 06:02:22 -0400
Received: by rv-out-0506.google.com with SMTP id k40so808244rvb.1
        for <git@vger.kernel.org>; Sat, 20 Sep 2008 03:02:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=OHbpmlo+RtBkV66KNFBHfYl1ijUlClERWYCue01lshA=;
        b=T45fE7UUBNkiN4jsC2zWf8TQkhwKeqLISX06wUTujqUnXN9CFXsxUuAwE20ElKVrBL
         QxbL/lhgO8q1xjrHCYx1u7/YNGGSSx52hhMHn9NLa2A7S/j8e95aRCHHbUj5d9QV8uf5
         YiyJTAKEtHw9Ebwd/ZQkoZcU+icG/lyjnB0DY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=NiLR42/26P2eQwcj/N/XmNFpBExkS92xdMlrGk/8lMV6i9INiks9qzgJOdxnQOWk1Y
         9P0wBH4SJgk2sDSStQUPEFhEtseUQFuRjmDVTrUo/aYs3b7slWfgYGGaW8Fa5J8hCkOw
         aNat506JmjwewF0rhGH7II7fRUUPvlw7x7Gw4=
Received: by 10.141.113.6 with SMTP id q6mr639553rvm.36.1221904941762;
        Sat, 20 Sep 2008 03:02:21 -0700 (PDT)
Received: from pclouds@gmail.com ( [117.5.36.54])
        by mx.google.com with ESMTPS id c20sm2542093rvf.3.2008.09.20.03.02.18
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 20 Sep 2008 03:02:20 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Sat, 20 Sep 2008 17:02:10 +0700
X-Mailer: git-send-email 1.6.0.96.g2fad1.dirty
In-Reply-To: <1221904913-25887-2-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96340>

This bit is the basis of sparse checkout. If this bit is on, the entry
is outside sparse checkout and therefore should be ignored (similar
to CE_VALID)

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/git-checkout.txt |   33 ++++++++++++++++++++++++++++++++=
+
 cache.h                        |   10 +++++++++-
 read-cache.c                   |    6 +++---
 3 files changed, 45 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkou=
t.txt
index 82e154d..4bd9eba 100644
--- a/Documentation/git-checkout.txt
+++ b/Documentation/git-checkout.txt
@@ -171,6 +171,39 @@ the reflog for HEAD where you were, e.g.
 $ git log -g -2 HEAD
 ------------
=20
+Sparse checkout
+---------------
+
+Normally when you checkout a branch, your working directory
+will be fully populated. In some situations, you just need to
+work on certain files, no full checkout is needed. Sparse
+checkout is a mode that limits the checkout area according to your
+needs. With sparse checkout, you can work on a single file, a
+collection of files, a subdirectory or a collection of separated
+subdirectories.
+
+Because sparse checkout uses a new index format, it will be
+incompatible with git prior to 1.6.0 regarding worktree operations.
+Operations that only need access to the repository itself, such as
+clone, push, or pull/fetch from another (normal) repository... should
+not be affected by sparse checkout.
+
+In sparse checkout mode, checkout status of every files in your
+working directory will be recorded in index. If a file is marked
+"no-checkout", it means that file is not needed to be present in
+working directory by user or any git command. When a new file is added
+to index, it will be marked "checkout" unless sparse patterns are
+applied.  Unmerged files are always "checkout". When you checkout new
+files using "git checkout <file>" they will be automatically marked
+"checkout". Other commands such as "git apply" can also checkout new
+files if they are needed.
+
+"No-checkout" status is very similar to "assume-unchanged bit"
+(see linkgit:git-update-index[1]). The main difference between them
+is "assume unchanged" bit just ignores corresponding files in working
+directory while sparse checkout goes a bit farther, remove those files
+when it is safe to do so.
+
=20
 EXAMPLES
 --------
diff --git a/cache.h b/cache.h
index 77b6eb3..6e875d5 100644
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
