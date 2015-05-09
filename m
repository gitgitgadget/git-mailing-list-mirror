From: =?UTF-8?q?S=C3=A9bastien=20Guimmara?= 
	<sebastien.guimmara@gmail.com>
Subject: [PATCH v5 6/6] cmd-list.perl: ignore all lines until [commands]
Date: Sat,  9 May 2015 19:17:36 +0200
Message-ID: <1431191856-10949-7-git-send-email-sebastien.guimmara@gmail.com>
References: <1431191856-10949-1-git-send-email-sebastien.guimmara@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?S=C3=A9bastien=20Guimmara?= 
	<sebastien.guimmara@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 09 19:19:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yr8Ox-0000ij-Ow
	for gcvg-git-2@plane.gmane.org; Sat, 09 May 2015 19:19:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751424AbbEIRSz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 9 May 2015 13:18:55 -0400
Received: from mail-wi0-f173.google.com ([209.85.212.173]:37470 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751196AbbEIRSz (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 May 2015 13:18:55 -0400
Received: by widdi4 with SMTP id di4so57203618wid.0
        for <git@vger.kernel.org>; Sat, 09 May 2015 10:18:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=Qo/gYDDCxix3+avFrG6G/xhwXkxFJTZPIVjzwN/v1y4=;
        b=wHxSOwZAG4euZHEzVe3F0Fz9g6F7haeGqG2triUtln4ppbiqi2Dt+nz39nX6JoEexf
         TWkzIAZtjw/VY2aAhjgL18wsdrOccrN+S6zzDqBZk3HrA4B+hqZ2RVd6S/2FeAP+VDUz
         re3N4O8G3kCuP6eyMM94QIykntqjkbfwK5QI+TCbxtk1PBtiu2YuOMvGTj/bY3MLF/9W
         skA7HXgYnDaxMumFSU+CAPAvlzwF+5HPaWp+40s72oYCGXG+1MwQXXFnl788cUdoQarX
         LWr3a+hqhPmGFTkdxlOlTYuCL6aGKGdf/KtLEfB83Dj/t+WX16LXWMQr1J8DpQotSPki
         aPAw==
X-Received: by 10.180.103.3 with SMTP id fs3mr7356707wib.14.1431191933850;
        Sat, 09 May 2015 10:18:53 -0700 (PDT)
Received: from localhost.localdomain (bd231-1-88-176-208-17.fbx.proxad.net. [88.176.208.17])
        by mx.google.com with ESMTPSA id fo7sm4710675wic.1.2015.05.09.10.18.52
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 09 May 2015 10:18:53 -0700 (PDT)
X-Mailer: git-send-email 2.4.0
In-Reply-To: <1431191856-10949-1-git-send-email-sebastien.guimmara@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268707>

command-list.txt contains a [common] block that should be ignored
by the Documentation checker cmd-list.perl.

=46ilter out this block before the actual processing of the command lis=
t.

Signed-off-by: S=C3=A9bastien Guimmara <sebastien.guimmara@gmail.com>
---
 Documentation/cmd-list.perl | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/Documentation/cmd-list.perl b/Documentation/cmd-list.perl
index 04f9977..d581378 100755
--- a/Documentation/cmd-list.perl
+++ b/Documentation/cmd-list.perl
@@ -38,8 +38,14 @@ sub format_one {
 	}
 }
=20
+my @filtered =3D ();
+while (<>)
+{
+	push (@filtered, $_) unless 1../^\[commands\]/;
+}
+
 my %cmds =3D ();
-for (sort <>) {
+for (sort @filtered) {
 	next if /^#/;
=20
 	chomp;
--=20
2.4.0
