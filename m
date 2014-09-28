From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 14/32] git-stash: avoid hardcoding $GIT_DIR/logs/....
Date: Sun, 28 Sep 2014 08:22:28 +0700
Message-ID: <1411867366-3821-15-git-send-email-pclouds@gmail.com>
References: <xmqqk34r9z3r.fsf@gitster.dls.corp.google.com>
 <1411867366-3821-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 28 03:24:12 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XY3Dg-0002Pu-9K
	for gcvg-git-2@plane.gmane.org; Sun, 28 Sep 2014 03:24:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753358AbaI1BYH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 27 Sep 2014 21:24:07 -0400
Received: from mail-pd0-f171.google.com ([209.85.192.171]:55737 "EHLO
	mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753183AbaI1BYG (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Sep 2014 21:24:06 -0400
Received: by mail-pd0-f171.google.com with SMTP id y13so15125499pdi.30
        for <git@vger.kernel.org>; Sat, 27 Sep 2014 18:24:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=6QMzF0GbtHKUjn71lvoyh8A42guC2OdoxaVozpi2FLU=;
        b=oZl2j7njTJR5bBlqm3jgJzarAYv5sQtlZBSGI8O96WRMnLjFx8TV59qQ1XnVwGgZTY
         /g5usvTqRhwJKMkcCef/FIs7LMo/4917F3JfS4GOQL+dZzcNQ4lbZ8lASNYOpxq8lG4B
         9c3HTQOqE3cEW8PWCqm9HiVT9RVWpAcUIYE9m7d4EYptFdmqVIxKySnJZlzk3wks3hfR
         4dYHv8nEN8SvsPOFj2kWIBbx5YFZxUrykR81bxeQpNTrjOG121nwxvE1cIXBCZ3cWVAV
         96jP1PLs+93lynrzX5Jrt6awk4OwGZ51w1ZhEGfcn2XlxI9jI4MP5zsjhQvuF1uLO5iD
         ZkkA==
X-Received: by 10.68.220.228 with SMTP id pz4mr47472137pbc.16.1411867446032;
        Sat, 27 Sep 2014 18:24:06 -0700 (PDT)
Received: from lanh ([115.73.212.224])
        by mx.google.com with ESMTPSA id tc5sm8521017pbc.51.2014.09.27.18.24.03
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 27 Sep 2014 18:24:05 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 28 Sep 2014 08:24:09 +0700
X-Mailer: git-send-email 2.1.0.rc0.78.gc0d8480
In-Reply-To: <1411867366-3821-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257573>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 git-stash.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/git-stash.sh b/git-stash.sh
index 4294aa0..2784f8b 100755
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
