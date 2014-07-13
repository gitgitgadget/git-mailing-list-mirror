From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v7 14/31] git-stash: avoid hardcoding $GIT_DIR/logs/....
Date: Sun, 13 Jul 2014 11:50:51 +0700
Message-ID: <1405227068-25506-15-git-send-email-pclouds@gmail.com>
References: <1404891197-18067-1-git-send-email-pclouds@gmail.com>
 <1405227068-25506-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Max Kirillov <max@max630.net>,
	Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 13 06:54:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X6Bnw-0000Gl-1c
	for gcvg-git-2@plane.gmane.org; Sun, 13 Jul 2014 06:54:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752810AbaGMEyY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 13 Jul 2014 00:54:24 -0400
Received: from mail-pd0-f176.google.com ([209.85.192.176]:46869 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752633AbaGMEyX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Jul 2014 00:54:23 -0400
Received: by mail-pd0-f176.google.com with SMTP id ft15so3484648pdb.21
        for <git@vger.kernel.org>; Sat, 12 Jul 2014 21:54:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=mPaj1NC9shKhbHCPOstYHnMtPsPB1E4fGMLGhTDGIxE=;
        b=oMGRRrFbrqfUtuZFItO67XNqji4jdQoPDUMnD4EcPKNgsCv/Wi/vvetg6bSuhQdOPP
         jbcWiJaAzVWxZjZU6MctvingRn61PUrYQVfDTJcRaUQSiPjtCPqaLY6SbHBSfHcFV3rv
         ThBcRDKocAY/YFAS6CNlKkVQQBSQDDTqWWR+bT3EBYfRjwcVjhkLDkDN1FIQL9u1KXjN
         Nx6KavOvqov78eQJUwnSixYSyOoIA3fJ26zmVanGqnCISitxpNGgqfwYJnCLnmdzZxan
         +4fb7OufVb/NyVA5J1sgLXVJ3sx7x07sAk+ZKIJ3GFa0q0NdVVPcOSdg7v22NGWwSwJT
         NaFg==
X-Received: by 10.68.99.194 with SMTP id es2mr8955492pbb.100.1405227262659;
        Sat, 12 Jul 2014 21:54:22 -0700 (PDT)
Received: from lanh ([115.73.227.1])
        by mx.google.com with ESMTPSA id n3sm1173161pde.47.2014.07.12.21.54.19
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 12 Jul 2014 21:54:22 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 13 Jul 2014 11:54:22 +0700
X-Mailer: git-send-email 1.9.1.346.ga2b5940
In-Reply-To: <1405227068-25506-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253417>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
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
1.9.1.346.ga2b5940
