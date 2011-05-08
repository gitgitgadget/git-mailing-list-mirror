From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 46/48] i18n: git-bisect bisect_replay + $1 messages
Date: Sun,  8 May 2011 12:21:18 +0000
Message-ID: <1304857280-14773-47-git-send-email-avarab@gmail.com>
References: <1304857280-14773-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 08 14:23:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QJ30w-0004Hv-PM
	for gcvg-git-2@lo.gmane.org; Sun, 08 May 2011 14:23:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753442Ab1EHMXE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 May 2011 08:23:04 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:35010 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753852Ab1EHMWS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 May 2011 08:22:18 -0400
Received: by mail-ew0-f46.google.com with SMTP id 4so1327054ewy.19
        for <git@vger.kernel.org>; Sun, 08 May 2011 05:22:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=TxI1wBEr024VigwnvZV+Muz1N28tyMVifoAa3mQjh7o=;
        b=fVreW0R6TjJsAY0Wqlsn2XCRutcUefGbJnJrDHUotDklXSeJaEJinxyX8su5kaLjwL
         ID4RhncLsYLUjNmedv55TbqDwRGZ31HlmryvsdBnBhC5bJjPRgg+1SlTHEnzshCncIFJ
         4UxEfRDf1lzZkEZhfygXQEFYSd0rvUKfGHNXY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=HK6pGlie/2/LqJUyFaiNuX5JSEBdyaSId3eU6W1qH4jYUdXmImaWN2FSNtjKwKH0rX
         pbbeqVhga+OPvgzKlAbLohGg8bKykAt3Iaf1CiDCYfwXi4yJTIQ4mcfpcZZkmonZgYtZ
         EQwTHDP0ht+HdH33I+nt0W7Ifcy3bY84myBS4=
Received: by 10.213.20.213 with SMTP id g21mr1887056ebb.56.1304857337423;
        Sun, 08 May 2011 05:22:17 -0700 (PDT)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id n55sm2690046een.2.2011.05.08.05.22.16
        (version=SSLv3 cipher=OTHER);
        Sun, 08 May 2011 05:22:16 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.4
In-Reply-To: <1304857280-14773-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173140>

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
1.7.4.4
