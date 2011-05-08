From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 45/48] i18n: git-bisect bisect_reset + $1 messages
Date: Sun,  8 May 2011 12:21:17 +0000
Message-ID: <1304857280-14773-46-git-send-email-avarab@gmail.com>
References: <1304857280-14773-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 08 14:23:09 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QJ30u-0004Hv-Iu
	for gcvg-git-2@lo.gmane.org; Sun, 08 May 2011 14:23:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753969Ab1EHMWh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 May 2011 08:22:37 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:37472 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753983Ab1EHMWR (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 May 2011 08:22:17 -0400
Received: by mail-ey0-f174.google.com with SMTP id 24so1325598eyx.19
        for <git@vger.kernel.org>; Sun, 08 May 2011 05:22:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=+06oBxxrc+dF38OHVtX6iaMxsSWq9hct0w6Nebxh1Vo=;
        b=C4ru4661L7bskhm91/CRNEyuWMLCt/w3uR/BDFTt3W6ZfEde83CiWUTeDw87JspCyD
         wEj2VsPWrmCjPCdVxj2ppZL3QRNWdaLwNn0kDGgsC7pY2sU0+yh/pkrs9uGyF1RP+R5M
         4RKef8CYTmlBINVQSR7lyXe8essiizxuQAOgE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=N6yLWcPcsn/rY0PAc97M6wh/qbn6+rY4+kPFnjzHPWSJBk47g9w9Knfbknof0Mtasq
         idosHASjrXEoKk6+wq3MkrDh1IIpnGeVOEBEEkXca0+MukLZVyktlorT+cIMG+p7PPzF
         j7AVvxZAEfXbWWpd65gSkKLjJQTOdR787145E=
Received: by 10.213.4.198 with SMTP id 6mr1787144ebs.124.1304857336551;
        Sun, 08 May 2011 05:22:16 -0700 (PDT)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id n55sm2690046een.2.2011.05.08.05.22.15
        (version=SSLv3 cipher=OTHER);
        Sun, 08 May 2011 05:22:16 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.4
In-Reply-To: <1304857280-14773-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173132>

ettextize bisect_reset messages that use the $1 variable. Since it's
subroutine local we have to provide an alias for it for eval_gettext.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 git-bisect.sh |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/git-bisect.sh b/git-bisect.sh
index d06fa56..7bd78ab 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -313,8 +313,10 @@ bisect_reset() {
 	}
 	case "$#" in
 	0) branch=3D$(cat "$GIT_DIR/BISECT_START") ;;
-	1) git rev-parse --quiet --verify "$1^{commit}" > /dev/null ||
-	       die "'$1' is not a valid commit"
+	1) git rev-parse --quiet --verify "$1^{commit}" > /dev/null || {
+	       invalid=3D"$1"
+	       die "$(eval_gettext "'\$invalid' is not a valid commit")"
+	   }
 	   branch=3D"$1" ;;
 	*)
 	    usage ;;
--=20
1.7.4.4
