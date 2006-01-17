From: Alex Riesen <raa.lkml@gmail.com>
Subject: [PATCH] "sleep 1" sleeps too little on cygwin
Date: Tue, 17 Jan 2006 12:25:37 +0100
Message-ID: <81b0412b0601170325y60094b4w693ac37490c67410@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_3612_15594453.1137497137687"
Cc: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue Jan 17 12:25:46 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Eyoy9-0005uj-JX
	for gcvg-git@gmane.org; Tue, 17 Jan 2006 12:25:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932361AbWAQLZn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Jan 2006 06:25:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932395AbWAQLZm
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Jan 2006 06:25:42 -0500
Received: from uproxy.gmail.com ([66.249.92.202]:55975 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932361AbWAQLZm (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 Jan 2006 06:25:42 -0500
Received: by uproxy.gmail.com with SMTP id s2so1023431uge
        for <git@vger.kernel.org>; Tue, 17 Jan 2006 03:25:40 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type;
        b=N6Ekji3A/tDozarY+DgwoOKmObiLpQw3GPCQrnhp+xf8lVDsmv0FLdS3PZ1oW3JU4JkLhp04981JYmG6IvuUWXcY/yfN9pe8FlFwbekSkaZmsQkYYTjI5ABOqX+fc6EBokPiHauTCOiDG2GVd0hK1rBmVa5ENhAfWFLNTeXMoVg=
Received: by 10.49.1.20 with SMTP id d20mr328649nfi;
        Tue, 17 Jan 2006 03:25:40 -0800 (PST)
Received: by 10.48.248.4 with HTTP; Tue, 17 Jan 2006 03:25:37 -0800 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14792>

------=_Part_3612_15594453.1137497137687
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Probably another one windows quirk, or just the moon phases,
but I have to make damn sure it sleeps long enough.

------=_Part_3612_15594453.1137497137687
Content-Type: text/x-patch; name=cygwin-sleeps-too-little.patch; 
	charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="cygwin-sleeps-too-little.patch"

diff --git a/t/t4011-diff-symlink.sh b/t/t4011-diff-symlink.sh
index e3ebf38..8c5b614 100755
--- a/t/t4011-diff-symlink.sh
+++ b/t/t4011-diff-symlink.sh
@@ -56,10 +56,11 @@ cat > expected << EOF
 diff --git a/frotz b/frotz
 EOF
 
+secs="$SECONDS"
+while [ "$SECONDS" = "$secs" ]; do sleep 1; done
 test_expect_success \
     'diff identical, but newly created symlink' \
-    'sleep 1 &&
-    ln -s xyzzy frotz &&
+    'ln -s xyzzy frotz &&
     git-diff-index -M -p $tree > current &&
     compare_diff_patch current expected'
 

------=_Part_3612_15594453.1137497137687--
