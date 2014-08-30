From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 14/32] git-stash: avoid hardcoding $GIT_DIR/logs/....
Date: Sat, 30 Aug 2014 15:33:44 +0700
Message-ID: <1409387642-24492-15-git-send-email-pclouds@gmail.com>
References: <1409387642-24492-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 30 10:35:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XNe84-0002Fx-Pr
	for gcvg-git-2@plane.gmane.org; Sat, 30 Aug 2014 10:35:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751324AbaH3IfQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 30 Aug 2014 04:35:16 -0400
Received: from mail-pa0-f53.google.com ([209.85.220.53]:34904 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751287AbaH3IfM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Aug 2014 04:35:12 -0400
Received: by mail-pa0-f53.google.com with SMTP id fa1so8143961pad.40
        for <git@vger.kernel.org>; Sat, 30 Aug 2014 01:35:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=CYGlefEjsdL6YK3U4SBKm0rCwzc/DpG4AOa3/pUiIcU=;
        b=i0NR5dP6pQVZEWUgGTsEUjfB3HFqg+OyVFfn8+MOCiDkvQ2ibFHWbvFsa+9f5horpz
         Ed/ng0j6gVE2Lw4WMycEubCjJ+O6Llzl92sMHGPT5FHVw7+Gf7yxrUOMcX+8yihnfH1W
         NyCcEfiWNz9UTt+Fy2NJ4mNhSl3svpS+bRTqT/i9BZopK7IFGqQC5WHtK8pGYUMt1t9I
         EngdTp+Y1rVQ0IBB7u0ulfKtppu+w2fJI5QXuL/bJ8TeHGh/o/owovBBb8IIxeQ/75hH
         JqZqzHPpFRbwpo9zZSqZpNPKZ7uEuYIANfFIi69WsHT7Xl5XVf3aXKR8LF5tBeTKJNt7
         4D/w==
X-Received: by 10.70.101.35 with SMTP id fd3mr4427125pdb.2.1409387711556;
        Sat, 30 Aug 2014 01:35:11 -0700 (PDT)
Received: from lanh ([115.73.195.142])
        by mx.google.com with ESMTPSA id qy1sm2117985pbc.27.2014.08.30.01.35.08
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 30 Aug 2014 01:35:10 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sat, 30 Aug 2014 15:35:19 +0700
X-Mailer: git-send-email 2.1.0.rc0.78.gc0d8480
In-Reply-To: <1409387642-24492-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256224>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 git-stash.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/git-stash.sh b/git-stash.sh
index 393e1ec..41f8f6b 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -184,7 +184,7 @@ store_stash () {
 	fi
=20
 	# Make sure the reflog for stash is kept.
-	: >>"$GIT_DIR/logs/$ref_stash"
+	: >>"$(git rev-parse --git-path logs/$ref_stash)"
 	git update-ref -m "$stash_msg" $ref_stash $w_commit
 	ret=3D$?
 	test $ret !=3D 0 && test -z $quiet &&
@@ -259,7 +259,7 @@ save_stash () {
 		say "$(gettext "No local changes to save")"
 		exit 0
 	fi
-	test -f "$GIT_DIR/logs/$ref_stash" ||
+	test -f "$(git rev-parse --git-path logs/$ref_stash)" ||
 		clear_stash || die "$(gettext "Cannot initialize stash")"
=20
 	create_stash "$stash_msg" $untracked
--=20
2.1.0.rc0.78.gc0d8480
