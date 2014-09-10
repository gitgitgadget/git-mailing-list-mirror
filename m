From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 14/32] git-stash: avoid hardcoding $GIT_DIR/logs/....
Date: Thu, 11 Sep 2014 05:41:50 +0700
Message-ID: <1410388928-32265-15-git-send-email-pclouds@gmail.com>
References: <1409387642-24492-1-git-send-email-pclouds@gmail.com>
 <1410388928-32265-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 11 00:43:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XRqbj-0001k5-0K
	for gcvg-git-2@plane.gmane.org; Thu, 11 Sep 2014 00:43:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753269AbaIJWnT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 10 Sep 2014 18:43:19 -0400
Received: from mail-pd0-f175.google.com ([209.85.192.175]:33305 "EHLO
	mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753063AbaIJWnS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Sep 2014 18:43:18 -0400
Received: by mail-pd0-f175.google.com with SMTP id z10so12064887pdj.20
        for <git@vger.kernel.org>; Wed, 10 Sep 2014 15:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=CYGlefEjsdL6YK3U4SBKm0rCwzc/DpG4AOa3/pUiIcU=;
        b=X6cHz0pk/IY4J79H0Ec30/yhvyQVq0tvdxa5Gfddsq/OqzBN5MVBAyA+AvzbWZ2C6Z
         DHl8NNwZsnqlESx/IQwSNrGx5nWqrEEsy62nSMVwukrNdXGt6etWUGJJmoHXpLUlRtyL
         pOptVDoqmQ0J10xrsDIAObvvc2bxST/7MsTZq+StXhkB2L7QXWJewN5pYZkb1bjfndBG
         ZAVP8i7zjpdBzbObbJS3MTeRoiQg2nCJSd2B+FCpbJ0cZWaQWWYLclberg4WTvnfS2eC
         Ye+o26CybiQBKuKAAI7xU8ZIH36Arh59WE2VgOh/PRIjmMcQ1JecdWMVsbi3l1+Cegu2
         myCg==
X-Received: by 10.70.25.132 with SMTP id c4mr19779841pdg.107.1410388997684;
        Wed, 10 Sep 2014 15:43:17 -0700 (PDT)
Received: from lanh ([115.73.197.210])
        by mx.google.com with ESMTPSA id j13sm15435547pbq.42.2014.09.10.15.43.14
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Sep 2014 15:43:17 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Thu, 11 Sep 2014 05:43:37 +0700
X-Mailer: git-send-email 2.1.0.rc0.78.gc0d8480
In-Reply-To: <1410388928-32265-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256791>

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
