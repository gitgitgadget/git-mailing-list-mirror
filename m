From: larsxschneider@gmail.com
Subject: [PATCH v3] git-p4: use replacement character for non UTF-8 characters in paths
Date: Mon, 21 Sep 2015 10:49:18 +0200
Message-ID: <1442825358-90294-2-git-send-email-larsxschneider@gmail.com>
References: <1442825358-90294-1-git-send-email-larsxschneider@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: luke@diamand.org, Lars Schneider <larsxschneider@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 21 10:49:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zdwms-0003hm-S0
	for gcvg-git-2@plane.gmane.org; Mon, 21 Sep 2015 10:49:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756216AbbIUItX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 21 Sep 2015 04:49:23 -0400
Received: from mail-wi0-f182.google.com ([209.85.212.182]:33565 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756191AbbIUItW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Sep 2015 04:49:22 -0400
Received: by wiclk2 with SMTP id lk2so135607383wic.0
        for <git@vger.kernel.org>; Mon, 21 Sep 2015 01:49:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=HHzk7KF0YsZn85+xTHfMU63smWo3S+oIrxnrEcrgF38=;
        b=FfkWoGo4AqtxNt9eXg0wNy5Do9zFgnjahgiDmPkxHs/xyLI1xIcF9+w4xQDnZBZAbT
         B4zFPbCz7ZPBK/AbGuSoGAy0UdYphCW+HXtvdQ6Pc7U+6q/gAvGxWhX7E4jPzGqdfuxB
         rdtcuVp9tFHIdxyuqsBfCbYJjOIIXsyK/dQPAq8qpiKUhgdaVoBQaCPsiBiebnxdxJPV
         m/T51GjT5xKYk+AEqk7ok0ZQH5jFHPqozblehJgTAJ6HjRjwFnPb6QqDoU5eU8/JFFXn
         QRojGOgn4GpcQTXGMSphRRJK4q5KYNwI/+bmtjCdvJ8htwZYf5ZjqxCBOtXhipwk+Vcs
         2gWg==
X-Received: by 10.194.79.196 with SMTP id l4mr23871870wjx.93.1442825361071;
        Mon, 21 Sep 2015 01:49:21 -0700 (PDT)
Received: from slxBook3.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id gt4sm12280148wib.21.2015.09.21.01.49.20
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 21 Sep 2015 01:49:20 -0700 (PDT)
X-Mailer: git-send-email 2.5.1
In-Reply-To: <1442825358-90294-1-git-send-email-larsxschneider@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278289>

=46rom: Lars Schneider <larsxschneider@gmail.com>

If non UTF-8 characters are detected in paths then replace them with =EF=
=BF=BD
instead of throwing a UnicodeDecodeError exception. This restores the
original (implicit) implementation that was broken in 00a9403.

Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
---
 git-p4.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git-p4.py b/git-p4.py
index e7510a9..215f556 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -2226,7 +2226,7 @@ class P4Sync(Command, P4UserMap):
             encoding =3D 'utf8'
             if gitConfig('git-p4.pathEncoding'):
                 encoding =3D gitConfig('git-p4.pathEncoding')
-            relPath =3D relPath.decode(encoding).encode('utf8', 'repla=
ce')
+            relPath =3D relPath.decode(encoding, 'replace').encode('ut=
f8', 'replace')
             if self.verbose:
                 print 'Path with non-ASCII characters detected. Used %=
s to encode: %s ' % (encoding, relPath)
=20
--=20
2.5.1
