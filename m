From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 49/51] i18n: git-bisect bisect_replay + $1 messages
Date: Sun,  3 Apr 2011 16:46:13 +0000
Message-ID: <1301849175-1697-50-git-send-email-avarab@gmail.com>
References: <1301849175-1697-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 03 18:48:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q6QTO-0005RJ-Hu
	for gcvg-git-2@lo.gmane.org; Sun, 03 Apr 2011 18:48:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753192Ab1DCQrZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 3 Apr 2011 12:47:25 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:47128 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753135Ab1DCQrW (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Apr 2011 12:47:22 -0400
Received: by mail-ey0-f174.google.com with SMTP id 24so1502908eyx.19
        for <git@vger.kernel.org>; Sun, 03 Apr 2011 09:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=fe/TDXi0eeVGeLRbXjW5h9qKp3tE08bAOIYELa5xW4Q=;
        b=KEXinxxQm64AXz6wmgIfNrEpzU5y/d7x7/NqTnjSyclc7V1idodwJtqQB1ADec7OA9
         LmId3Xldgzb4rtJaZUK3VvIcCFFBn4e3yjfgsddFWi91XtfGqWt0a8e27XCMl++sq7Tl
         kq9pc06zd8Hhlnd0IdWWE/lbVWOXYPLrs2Axk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=nmzatJ+10WGk774F2IRmUjHFSjZK2JF/TS85U2e1re2idieaZkpSHqRWiWm1WNe5bz
         10AoX74XfO3knspUKboOZ+VOvQTIJXSdZ8uMQABmc1pXbxbJwiDhzUB/VK9HiXfbwJXb
         3BABZVOd1zkPAbQh+wxgcJ30ynhROH6ozLVkQ=
Received: by 10.14.11.14 with SMTP id 14mr2900575eew.164.1301849241906;
        Sun, 03 Apr 2011 09:47:21 -0700 (PDT)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id w59sm2750567eeh.24.2011.04.03.09.47.21
        (version=SSLv3 cipher=OTHER);
        Sun, 03 Apr 2011 09:47:21 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <1301849175-1697-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170730>

Gettextize bisect_replay messages that use the $1 variable. Since it's
subroutine local we have to provide an alias for it for eval_gettext.

Since I was doing that anyway I've changed all other uses of $1
variable to use the alias variable for clarity.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 git-bisect.sh |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/git-bisect.sh b/git-bisect.sh
index 7bd78ab..e05b53b 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -348,8 +348,9 @@ bisect_clean_state() {
 }
=20
 bisect_replay () {
-	test "$#" -eq 1 || die "No logfile given"
-	test -r "$1" || die "cannot read $1 for replaying"
+	file=3D"$1"
+	test "$#" -eq 1 || die "$(gettext "No logfile given")"
+	test -r "$file" || die "$(eval_gettext "cannot read \$file for replay=
ing")"
 	bisect_reset
 	while read git bisect command rev
 	do
@@ -367,7 +368,7 @@ bisect_replay () {
 		*)
 			die "$(gettext "?? what are you talking about?")" ;;
 		esac
-	done <"$1"
+	done <"$file"
 	bisect_auto_next
 }
=20
--=20
1.7.4.1
