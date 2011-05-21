From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH v2 44/48] i18n: git-bisect bisect_run + $@ messages
Date: Sat, 21 May 2011 18:44:25 +0000
Message-ID: <1306003469-22939-45-git-send-email-avarab@gmail.com>
References: <1306003469-22939-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 21 20:46:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QNrC7-0000od-Fl
	for gcvg-git-2@lo.gmane.org; Sat, 21 May 2011 20:46:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757196Ab1EUSqa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 21 May 2011 14:46:30 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:55119 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756997Ab1EUSpo (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 May 2011 14:45:44 -0400
Received: by mail-ey0-f174.google.com with SMTP id 24so1444635eyx.19
        for <git@vger.kernel.org>; Sat, 21 May 2011 11:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=iuVhzn8FQHGLU+Z+BFUshGcJ7znpjtwvNRXJJXwEJ60=;
        b=rUQEKfTFUWc+fG68oRRIhvlfdMeoiunU/8D7TKIqrbhWSvx6MRRnGvHeivtAsNP1Ef
         b+E1TWAdG2dyoktcUR7I338SSUXlKQnF5E9bq3/bLasklynEYWEjvJ0xWfS81vVFCz6m
         EaFd4tadbQb+O8fTtcuS6BBX373LYO3k4t4H8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=AA6f495EzXysWefyv46rvL2KlOJqA2hVPLgxtnlB8seUDwFBoDjgQJvvIHGl1VXj8O
         hs7XMQMawrRUl42KnJ6/kV8I6yehjOvJxihN9unu5wRoMNG93D/uEnM6TTnAmL0OnB1g
         rdjsxnytcPkfEe0o24+YviX4nlk5VyCbHbuS4=
Received: by 10.14.50.3 with SMTP id y3mr255500eeb.225.1306003543357;
        Sat, 21 May 2011 11:45:43 -0700 (PDT)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id y14sm1130434eeh.3.2011.05.21.11.45.42
        (version=SSLv3 cipher=OTHER);
        Sat, 21 May 2011 11:45:42 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.1
In-Reply-To: <1306003469-22939-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174144>

Gettextize bisect_run messages that use the $@ variable. Since it's
subroutine local we have to provide an alias for it for eval_gettext.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 git-bisect.sh |   10 +++++++---
 1 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/git-bisect.sh b/git-bisect.sh
index d86d503..d69c587 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -380,14 +380,18 @@ bisect_run () {
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
+	  (
+	    eval_gettext "bisect run failed:
+exit code \$res from '\$command' is < 0 or >=3D 128" &&
+	    echo
+	  ) >&2
 	  exit $res
       fi
=20
--=20
1.7.5.1
