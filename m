From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v6 16/32] git-stash: avoid hardcoding $GIT_DIR/logs/....
Date: Wed,  9 Jul 2014 14:33:01 +0700
Message-ID: <1404891197-18067-17-git-send-email-pclouds@gmail.com>
References: <1404891197-18067-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 09 09:35:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X4mP4-0003mC-Mg
	for gcvg-git-2@plane.gmane.org; Wed, 09 Jul 2014 09:34:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754851AbaGIHez convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 9 Jul 2014 03:34:55 -0400
Received: from mail-pa0-f52.google.com ([209.85.220.52]:53666 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754842AbaGIHey (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jul 2014 03:34:54 -0400
Received: by mail-pa0-f52.google.com with SMTP id eu11so8793667pac.11
        for <git@vger.kernel.org>; Wed, 09 Jul 2014 00:34:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=mPaj1NC9shKhbHCPOstYHnMtPsPB1E4fGMLGhTDGIxE=;
        b=l/3XPQgG8nHJukxXfUz51vZYCz8dyiJ3FxocJr2bgT1577KiUIer3pPKUc4AlOvJvE
         vyYvoSMRRmtrZ1mxGezZAhwSY9JeTA2ZMxEz3NOmrJ6nuqZMEFPefV0d+86tXEv2F/xR
         av4mkoXhIp6lnXOG0ZZylqGbPRNEMPTmecGYoOjoe/q22HtCHmPiDqeT4tuASCaATk1l
         A7gvCvvvzkwAqL2GedmOdrf+5D67Dk9T1nWXZmWN3S8Pfk87/FK9qFOAdp7R1zHj+Xk4
         6eMmZq7X7cyk1vIH5xjjAjEy41pJIPhFMVUYIqztOypBc8QxS1kVYMxiaKvdgD+uW3E7
         s8OA==
X-Received: by 10.70.44.8 with SMTP id a8mr9675571pdm.81.1404891293976;
        Wed, 09 Jul 2014 00:34:53 -0700 (PDT)
Received: from lanh ([115.73.209.165])
        by mx.google.com with ESMTPSA id fs3sm80303331pac.44.2014.07.09.00.34.51
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Jul 2014 00:34:53 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Wed, 09 Jul 2014 14:34:51 +0700
X-Mailer: git-send-email 1.9.1.346.ga2b5940
In-Reply-To: <1404891197-18067-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253091>

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
