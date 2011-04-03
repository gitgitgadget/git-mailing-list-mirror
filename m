From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 47/51] i18n: git-bisect bisect_run + $@ messages
Date: Sun,  3 Apr 2011 16:46:11 +0000
Message-ID: <1301849175-1697-48-git-send-email-avarab@gmail.com>
References: <1301849175-1697-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 03 18:48:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q6QTQ-0005RJ-Cw
	for gcvg-git-2@lo.gmane.org; Sun, 03 Apr 2011 18:48:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753227Ab1DCQrm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 3 Apr 2011 12:47:42 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:33259 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753153Ab1DCQrT (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Apr 2011 12:47:19 -0400
Received: by mail-ew0-f46.google.com with SMTP id 4so1505908ewy.19
        for <git@vger.kernel.org>; Sun, 03 Apr 2011 09:47:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=OF9QJCusJ+INj9nbO7KYPyflkhINnV1V8/fc/FA0zFM=;
        b=MkR0Uv31H3fSjg0WbwlBpFWx2ERpwfIeiYGdG96qhiCLiQ/nmqWTOznBirTez9wAWo
         KbjpBc+99LPU5PRv6DZMaNg5UIqu936MdYPIWChMVS28kdAfHQialyPVVktjQO7ID4df
         1qmGLgetTMXbOAiIspig1cn011RcMZc8XCOY4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=j+ClrRS+FatPE11Hj0GUZOMlPezXIco/Etvoch3FgTMEDp+M3XzFm8In+5G+FEOs1Z
         4FBCEM/ixb+Y8O3XDuWhclrhBjyXHg/Da7a8GbTOZxmDBNwUvbFHZSPVbR7jKEmx2Th9
         pb5tuQQowDHHhsOrSb8PKKR+Fa3rmHY8dE644=
Received: by 10.213.34.208 with SMTP id m16mr3192640ebd.37.1301849239074;
        Sun, 03 Apr 2011 09:47:19 -0700 (PDT)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id w59sm2750567eeh.24.2011.04.03.09.47.17
        (version=SSLv3 cipher=OTHER);
        Sun, 03 Apr 2011 09:47:18 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <1301849175-1697-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170737>

Gettextize bisect_run messages that use the $@ variable. Since it's
subroutine local we have to provide an alias for it for eval_gettext.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 git-bisect.sh |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/git-bisect.sh b/git-bisect.sh
index 2e755cd..d06fa56 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -374,14 +374,15 @@ bisect_run () {
=20
     while true
     do
-      echo "running $@"
+      command=3D"$@"
+      eval_gettext "running \$command"; echo
       "$@"
       res=3D$?
=20
       # Check for really bad run error.
       if [ $res -lt 0 -o $res -ge 128 ]; then
-	  echo >&2 "bisect run failed:"
-	  echo >&2 "exit code $res from '$@' is < 0 or >=3D 128"
+	  echo >&2 "$(eval_gettext "bisect run failed:
+exit code \$res from '\$command' is < 0 or >=3D 128")"
 	  exit $res
       fi
=20
--=20
1.7.4.1
