From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 48/51] i18n: git-bisect bisect_reset + $1 messages
Date: Sun,  3 Apr 2011 16:46:12 +0000
Message-ID: <1301849175-1697-49-git-send-email-avarab@gmail.com>
References: <1301849175-1697-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 03 18:48:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q6QTN-0005RJ-Vu
	for gcvg-git-2@lo.gmane.org; Sun, 03 Apr 2011 18:48:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753189Ab1DCQrY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 3 Apr 2011 12:47:24 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:57591 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753152Ab1DCQrV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Apr 2011 12:47:21 -0400
Received: by mail-ey0-f174.google.com with SMTP id 24so1502912eyx.19
        for <git@vger.kernel.org>; Sun, 03 Apr 2011 09:47:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=94ApF0t1KdcDjx9FuChFlk1Lji8jPGT6cQL3KGV6niE=;
        b=x9jkSwHul4v6v0L9Nj6azveEEOXnFTXFhKmhf04gJXD1XBz4FUcFxAeDWFFYsc18xf
         r16zQX3ZHb/oVg8FzS82fsNNbgQmn/4tTTD1+i1RDdmf79IRkdA7KQmY/g26KGdTseGf
         QXFIOSztvaUGhK7qYVevrJpMnh/UolKO+XKTE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=jy9EytCkozVzXw/yNqiaJa6+k2S2wKLY4ogwpsBk0Rww8FfXVdtWVrvfWTT+Oh4sIs
         oIJ4FBgopLDyTLrnbsTkIvlGtJ+sXpnF1sYbbRf8aXOVzkParZdZwwrT+06jbTtM6HWy
         N091xzz9hEWpI1Y+rT8GVO0BVQYvRXpp1VEU4=
Received: by 10.213.4.74 with SMTP id 10mr1182956ebq.33.1301849241024;
        Sun, 03 Apr 2011 09:47:21 -0700 (PDT)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id w59sm2750567eeh.24.2011.04.03.09.47.19
        (version=SSLv3 cipher=OTHER);
        Sun, 03 Apr 2011 09:47:19 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <1301849175-1697-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170728>

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
1.7.4.1
