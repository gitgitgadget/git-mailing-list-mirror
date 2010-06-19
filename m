From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 2/2] git-cvsserver: fix error for invalid password formats
Date: Sat, 19 Jun 2010 16:06:58 +0000
Message-ID: <1276963618-14662-3-git-send-email-avarab@gmail.com>
References: <1276963618-14662-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 19 18:08:08 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OQ0aW-00058O-9A
	for gcvg-git-2@lo.gmane.org; Sat, 19 Jun 2010 18:08:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754874Ab0FSQIC convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 19 Jun 2010 12:08:02 -0400
Received: from mail-ww0-f46.google.com ([74.125.82.46]:60260 "EHLO
	mail-ww0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754666Ab0FSQIB (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Jun 2010 12:08:01 -0400
Received: by mail-ww0-f46.google.com with SMTP id 22so836405wwb.19
        for <git@vger.kernel.org>; Sat, 19 Jun 2010 09:08:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=bf+OaInWAu069C+iYAUcgjOtIjlZiN1HXZH2unhipfM=;
        b=tDfolxvg+w4mErTTvi/dk85eKOrBaXCC+0ZShIRcepoeg3y6TvPBPe6OwR9Bx/q8kd
         Nc3/26E78UA9Hx0HESeDkru4DCpxwktNPHMcMvwTW79cRVvCOfv51lQU1ftQfGNinyol
         lcxw/huIqN5otSzPk5n0afDV1NoNnep1LL2f4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=eMrPpMq+ml7HZBW96x3/fMmIUHftOq0zRfR8ljlqi685hmg1tnaPWIN5wPSm9OpW3T
         r6d2aIZBK3hlvvTiOaS6zvfQMaTmpKi1gDNiR4b7L9aMMuGRDPDVMLLXSJ5vWbgmweC2
         hnNcSqs966LotxsfxFdBeDRjH0JGrMIoJVYqw=
Received: by 10.227.128.199 with SMTP id l7mr2420824wbs.210.1276963680303;
        Sat, 19 Jun 2010 09:08:00 -0700 (PDT)
Received: from localhost.localdomain ([188.105.94.3])
        by mx.google.com with ESMTPS id y31sm7107452wby.16.2010.06.19.09.07.58
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 19 Jun 2010 09:07:59 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.251.g92a7
In-Reply-To: <1276963618-14662-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149385>

Change the error message to report the erroneous password
character. $1 was never set in the previos version, it was a leftover
from older code that used a regex for the test.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 git-cvsserver.perl |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/git-cvsserver.perl b/git-cvsserver.perl
index 6de7921..0f45c39 100755
--- a/git-cvsserver.perl
+++ b/git-cvsserver.perl
@@ -2658,7 +2658,10 @@ sub descramble
=20
     # This should never happen, the same password format (A) has been
     # used by CVS since the beginning of time
-    die "invalid password format $1" unless substr($str, 0, 1) eq 'A';
+    {
+        my $fmt =3D substr($str, 0, 1);
+        die "invalid password format `$fmt'" unless $fmt eq 'A';
+    }
=20
     my @str =3D unpack "C*", substr($str, 1);
     my $ret =3D join '', map { chr $SHIFTS[$_] } @str;
--=20
1.7.1.251.g92a7
