From: Stephan Springl <springl-git@bfw-online.de>
Subject: [PATCH] make git-cvsimport work on ref-packed repositories
Date: Wed, 23 May 2007 09:13:28 +0200 (MSZ)
Message-ID: <Pine.LNX.4.64.0705230909310.25524@lar.bfw.de>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-555875106-1883279211-1179904218=:25524"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 23 10:09:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HqluU-0006QS-F7
	for gcvg-git@gmane.org; Wed, 23 May 2007 10:09:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755885AbXEWIJ2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 23 May 2007 04:09:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756000AbXEWIJ2
	(ORCPT <rfc822;git-outgoing>); Wed, 23 May 2007 04:09:28 -0400
Received: from mail.bfw-online.de ([62.245.186.164]:59111 "EHLO
	mail.bfw-online.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755885AbXEWIJ1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 May 2007 04:09:27 -0400
X-Greylist: delayed 3356 seconds by postgrey-1.27 at vger.kernel.org; Wed, 23 May 2007 04:09:26 EDT
Received: from lar.bfw.de ([222.222.222.4] ident=springl)
	by mail.bfw-online.de with esmtp (Exim 4.51)
	id 1Hql2G-0007iA-Ih
	for git@vger.kernel.org; Wed, 23 May 2007 09:13:29 +0200
Content-ID: <Pine.LNX.4.64.0705230910260.26460@lar.bfw.de>
X-SA-Exim-Connect-IP: 222.222.222.4
X-SA-Exim-Mail-From: springl-git@bfw-online.de
X-SA-Exim-Scanned: No (on mail.bfw-online.de); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48148>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---555875106-1883279211-1179904218=:25524
Content-Type: TEXT/PLAIN; CHARSET=ISO-8859-1; FORMAT=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <Pine.LNX.4.64.0705230910261.26460@lar.bfw.de>

Hi!

      This helps us to use git-cvsimport on our ref-packed repositories.
Maybe you want to use this or a similar solution to be integrated in
stock git.

Thank you.

Stephan.



commit 83f8922f1ad385ef3493684838e11a34edbf68a7
Author: Stephan Springl <springl-git@bfw-online.de>
Date:   Wed May 23 09:06:37 2007 +0200

     Use git-for-each-ref to check whether the origin (or opt_o) branch exi=
sts.
     This works in repositories that have their refs packed by
     "git-pack-refs --all --prune" whereas testing the file
     $git_dir/refs/heads/$opt_o does not.

diff --git a/git-cvsimport.perl b/git-cvsimport.perl
index ac74bc5..f68afe7 100755
--- a/git-cvsimport.perl
+++ b/git-cvsimport.perl
@@ -559,11 +559,6 @@ unless (-d $git_dir) {
  =09$last_branch =3D $opt_o;
  =09$orig_branch =3D "";
  } else {
-=09-f "$git_dir/refs/heads/$opt_o"
-=09=09or die "Branch '$opt_o' does not exist.\n".
-=09=09       "Either use the correct '-o branch' option,\n".
-=09=09       "or import to a new repository.\n";
-
  =09open(F, "git-symbolic-ref HEAD |") or
  =09=09die "Cannot run git-symbolic-ref: $!\n";
  =09chomp ($last_branch =3D <F>);
@@ -588,6 +583,11 @@ unless (-d $git_dir) {
  =09=09$branch_date{$head} =3D $1;
  =09}
  =09close(H);
+        if (!exists $branch_date{$opt_o}) {
+=09=09die "Branch '$opt_o' does not exist.\n".
+=09=09       "Either use the correct '-o branch' option,\n".
+=09=09       "or import to a new repository.\n";
+        }
  }

  -d $git_dir


--
Stephan Springl                           BFW Werner V=F6lk GmbH
springl-git@bfw-online.de                 Energiemesstechnik & Service
+49 89 82917-452                          Drosselgasse 5
                                           82166 Gr=E4felfing/M=FCnchen
---555875106-1883279211-1179904218=:25524--
