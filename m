From: =?utf-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 2/9] Introduce CE_NO_CHECKOUT bit
Date: Wed,  1 Oct 2008 11:04:02 +0700
Message-ID: <1222833849-22129-3-git-send-email-pclouds@gmail.com>
References: <1222833849-22129-1-git-send-email-pclouds@gmail.com>
 <1222833849-22129-2-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Oct 01 06:06:54 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KkszE-0001ME-78
	for gcvg-git-2@gmane.org; Wed, 01 Oct 2008 06:06:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750901AbYJAEFV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 1 Oct 2008 00:05:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750939AbYJAEFU
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Oct 2008 00:05:20 -0400
Received: from rv-out-0506.google.com ([209.85.198.229]:63785 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750901AbYJAEFT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Oct 2008 00:05:19 -0400
Received: by rv-out-0506.google.com with SMTP id k40so384855rvb.1
        for <git@vger.kernel.org>; Tue, 30 Sep 2008 21:05:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=nuZQA/e9FsRux0au1lxooz3tsUPKsz1Mqg9oKcrPkW4=;
        b=EmyjzCepC/wr2d6o5jGEh6n6t8mFw7nQ0xGvjLNgDnKgHvSonOdHc0Kl3x0kh72H86
         rcQeBaaVbqqYiDYPtndk22tuooOF/cMWnaVlnTgLOOdeRq0fVifW3bCFJn6jUC0RD4kv
         Vexitqf7d5yasNw6G0GYKJMbGXyV1ZVZ41h1I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=MUbfDtMEwtlBgjSbIMneccCt/2edSdG2kcu+y9hcYgnk2Ny4mUqJac09ULEErCLZE9
         d7mXU3YEOkTqgyfqJo2MmXF42M8aakixubbpAL58z4uO5REX+2jA2CQ9ZGB/HWYXSJEt
         F/o3e7x1XZTD8KWpFPGRzMqziItJviAXmha/U=
Received: by 10.141.75.6 with SMTP id c6mr4012927rvl.286.1222833918435;
        Tue, 30 Sep 2008 21:05:18 -0700 (PDT)
Received: from pclouds@gmail.com ([117.5.46.240])
        by mx.google.com with ESMTPS id b8sm3948565rvf.4.2008.09.30.21.05.14
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 30 Sep 2008 21:05:16 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Wed,  1 Oct 2008 11:05:10 +0700
X-Mailer: git-send-email 1.6.0.2.488.gf604a
In-Reply-To: <1222833849-22129-2-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97193>

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
index 5180879..f13ddbc 100644
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
1.6.0.2.488.gf604a
