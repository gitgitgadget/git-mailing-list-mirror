From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 44/48] i18n: git-bisect bisect_run + $@ messages
Date: Sun,  8 May 2011 12:21:16 +0000
Message-ID: <1304857280-14773-45-git-send-email-avarab@gmail.com>
References: <1304857280-14773-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 08 14:23:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QJ30v-0004Hv-4s
	for gcvg-git-2@lo.gmane.org; Sun, 08 May 2011 14:23:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754073Ab1EHMWk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 May 2011 08:22:40 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:48739 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752937Ab1EHMWQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 May 2011 08:22:16 -0400
Received: by mail-ey0-f174.google.com with SMTP id 24so1325631eyx.19
        for <git@vger.kernel.org>; Sun, 08 May 2011 05:22:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=yiKtLR0WjcH+Es3l7rhbOKgdMJ+fhoaXkjQ4Gw6eQ1U=;
        b=FgcmzV+8Nh3CHUj8NIsL9FDpryqAcjrT4BZ8EuIhQhuQSJ8JttBvmvRbod3cxAp+J5
         RgxSx6u+N7GEeil4YsNLdDZCWDOvbrLj1TRZQjkKHQ31Rw7oPxFw9HIO65Dv7X2bqEZQ
         n0L8iV6Hfe0Rt82FCHpWZ+2TJLsJaZzzzHsoQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=LQgQdZmtoaD6gDHKwSfYNUxvhZ5bTjlohp9hTJFShulOT52eY7Xz/v6RdFbzQuB052
         J+GRMOr7IyYOnPjl9fPZGfHJ1JEGT+ctxnxWsk65yxwzgUixXkhcRFd2kbXBm+B5rUwe
         J9nGAOjSjvzXlVmmtiS+lLP/LpCbuozXobLos=
Received: by 10.14.23.85 with SMTP id u61mr2641055eeu.132.1304857335662;
        Sun, 08 May 2011 05:22:15 -0700 (PDT)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id n55sm2690046een.2.2011.05.08.05.22.14
        (version=SSLv3 cipher=OTHER);
        Sun, 08 May 2011 05:22:15 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.4
In-Reply-To: <1304857280-14773-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173139>

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
1.7.4.4
