From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH v2 46/48] i18n: git-bisect bisect_replay + $1 messages
Date: Sat, 21 May 2011 18:44:27 +0000
Message-ID: <1306003469-22939-47-git-send-email-avarab@gmail.com>
References: <1306003469-22939-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 21 20:46:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QNrC6-0000od-5i
	for gcvg-git-2@lo.gmane.org; Sat, 21 May 2011 20:46:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757154Ab1EUSqX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 21 May 2011 14:46:23 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:50211 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757010Ab1EUSpp (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 May 2011 14:45:45 -0400
Received: by mail-ew0-f46.google.com with SMTP id 4so1451108ewy.19
        for <git@vger.kernel.org>; Sat, 21 May 2011 11:45:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=8lChX9Vj21ae+u0TDYjlnSlH+iyawkNKoHE9VoqyvWI=;
        b=KwOQ+Lr6TKVzqC1Ec6Igpa2azn7Tk2l46VWoX6GSNmDus3wHYyarY3QrmyGpdC1GTL
         GxAPGhhyz8p0pfUIsXlw6djijLUOOWbPbG90S7r9ZQFlsD74axSF/RNtwwZtdqfRFe6S
         iu4sfv9PUuTfKd/p5Ps77pz2WZMZaxCvrd1Ww=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=wHCJtgWTnLqsdHSlT/B0XQu/whZetj330tb7l0ppUqq/v/AhRo7Jv0OvuDflkpqmDS
         1QxtNVdbT/XBvhedhHp4OJWGS2y9o8vm3He6OAjaKtZqb/7HDnR2wDjqWBxkBdwvXpka
         B043nVZNBxTojiErDcIgahz5FGXy1tmsmNEbA=
Received: by 10.213.4.7 with SMTP id 7mr572637ebp.75.1306003545047;
        Sat, 21 May 2011 11:45:45 -0700 (PDT)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id y14sm1130434eeh.3.2011.05.21.11.45.44
        (version=SSLv3 cipher=OTHER);
        Sat, 21 May 2011 11:45:44 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.1
In-Reply-To: <1306003469-22939-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174140>

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
index 24e1c15..081677b 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -354,8 +354,9 @@ bisect_clean_state() {
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
@@ -373,7 +374,7 @@ bisect_replay () {
 		*)
 			die "$(gettext "?? what are you talking about?")" ;;
 		esac
-	done <"$1"
+	done <"$file"
 	bisect_auto_next
 }
=20
--=20
1.7.5.1
