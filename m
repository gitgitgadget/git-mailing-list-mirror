From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH v2 35/48] i18n: git-stash die + eval_gettext $1 messages
Date: Sat, 21 May 2011 18:44:16 +0000
Message-ID: <1306003469-22939-36-git-send-email-avarab@gmail.com>
References: <1306003469-22939-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 21 20:46:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QNrBW-0000TI-TA
	for gcvg-git-2@lo.gmane.org; Sat, 21 May 2011 20:45:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757071Ab1EUSpw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 21 May 2011 14:45:52 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:55119 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751905Ab1EUSpf (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 May 2011 14:45:35 -0400
Received: by mail-ey0-f174.google.com with SMTP id 24so1444635eyx.19
        for <git@vger.kernel.org>; Sat, 21 May 2011 11:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=z9q8t1BTYBLNJMdHWNlbYLCuSNo0MIHRF5tgrO86oXQ=;
        b=Taca1FOiJWGVBVHwUzd0Sc/ps1/808NVrV3OcWQH0y5DQjUV1hyYLm1cUhV8cF9IrK
         PkMScZlllIWbdwGJtRJACOR3916a3z0pSnTBjlcNlCif+/VGv6O7aWAWI5fEUmCCj2au
         nfUH6HI5qwz0CyGOTyhLTm6pxp6cBKXXVP04E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=Y2/Ruj5mJO6XV6E7eC6h6m2BCNNJuedDpB3WVz6eLys16VNXrsMMiBi+i3ysY9hqSh
         wXsDbhHjcnhT3w/uK1H2nwnHiRMcmc03+nyshWTMNFq/CTz9lJUnT1itBuuq1DFmsYnf
         oxrt6mtA3WgNaD5yp/ZQgtDzqVp88eY+Pp4Jk=
Received: by 10.213.29.68 with SMTP id p4mr279381ebc.94.1306003534934;
        Sat, 21 May 2011 11:45:34 -0700 (PDT)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id y14sm1130434eeh.3.2011.05.21.11.45.34
        (version=SSLv3 cipher=OTHER);
        Sat, 21 May 2011 11:45:34 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.1
In-Reply-To: <1306003469-22939-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174137>

Gettextize a messages that used the $1 variable. Since it's subroutine
local we have to provide an alias for it for eval_gettext.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 git-stash.sh |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/git-stash.sh b/git-stash.sh
index 509e14f..ede35a5 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -299,7 +299,10 @@ parse_flags_and_rev()
 		;;
 	esac
=20
-	REV=3D$(git rev-parse --quiet --symbolic --verify $1 2>/dev/null) || =
die "$1 is not valid reference"
+	REV=3D$(git rev-parse --quiet --symbolic --verify $1 2>/dev/null) || =
{
+		reference=3D"$1"
+		die "$(eval_gettext "\$reference is not valid reference")"
+	}
=20
 	i_commit=3D$(git rev-parse --quiet --verify $REV^2 2>/dev/null) &&
 	set -- $(git rev-parse $REV $REV^1 $REV: $REV^1: $REV^2: 2>/dev/null)=
 &&
--=20
1.7.5.1
