From: Chris Packham <judge.packham@gmail.com>
Subject: [StGit BUG/PATCH] config.py: fix unset
Date: Thu, 6 Aug 2009 15:29:28 +1200
Message-ID: <a038bef50908052029t3e993fcaw75e9a58e120c0c74@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 06 05:36:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MYtlw-0005gw-TE
	for gcvg-git-2@gmane.org; Thu, 06 Aug 2009 05:36:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754039AbZHFDgA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 5 Aug 2009 23:36:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753958AbZHFDgA
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Aug 2009 23:36:00 -0400
Received: from mail-vw0-f183.google.com ([209.85.212.183]:56253 "EHLO
	mail-vw0-f183.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753305AbZHFDf7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 5 Aug 2009 23:35:59 -0400
X-Greylist: delayed 391 seconds by postgrey-1.27 at vger.kernel.org; Wed, 05 Aug 2009 23:35:59 EDT
Received: by vws13 with SMTP id 13so553436vws.22
        for <git@vger.kernel.org>; Wed, 05 Aug 2009 20:36:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=2/kajtBxiGGs+CmtUlBvTsTY3hlITixmlVp5dK1gYks=;
        b=LHCb15bBVjbs4AbguXJFWa+eEzo3wWaOq+Mtw3zDVCoyiOYKKy7CWBnRvf0Y63iTXO
         Yr+/yrXvO8RKthP4HGj57Tc3Pmslur3fK3sbJvsftofna6ofd3pUAN+M2jvD+RRbFfBA
         X64+uAj7P+NhBV/LwyT9HRr+jnBwGvcyMH5is=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=S0Y80lGo+SxsK/zKgANGIFyQtaNkP8Qt75A5suSA7zui1OFsAgWBeGrfO5NA+7bjxB
         j2YJ9t/MULVQKhdYWlpePS+DkDTw1YZQVkrvGFuITaJ7T5CrkHGtDsJxD/xttyPOM9oy
         uZ474K9dTY4l2netw1uBe0Bwp3ypLcw7Axw0o=
Received: by 10.220.97.67 with SMTP id k3mr9640076vcn.7.1249529368743; Wed, 05 
	Aug 2009 20:29:28 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125026>

=46rom: Chris Packham <judge.packham@gmail.com>

Missing invocation of .run() so config.unset('blah') didn't do anything=
=2E
Consequently the fact that the next line set the value to 'None' instea=
d of a
list with 1 element i.e. '[None]' was not noticed.

Signed-off-by: Chris Packham <judge.packham@gmail.com>
---
=C2=A0stgit/config.py | =C2=A0 =C2=A04 ++--
=C2=A01 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/stgit/config.py b/stgit/config.py
index 4a6cb3b..6f84b10 100644
--- a/stgit/config.py
+++ b/stgit/config.py
@@ -94,8 +94,8 @@ class GitConfig:
=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.__cache[name] =3D value

=C2=A0 =C2=A0 def unset(self, name):
- =C2=A0 =C2=A0 =C2=A0 =C2=A0Run('git', 'config', '--unset', name)
- =C2=A0 =C2=A0 =C2=A0 =C2=A0self.__cache[name] =3D None
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0Run('git', 'config', '--unset', name).run(=
)
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0self.__cache[name] =3D [None]

=C2=A0 =C2=A0 def sections_matching(self, regexp):
=C2=A0 =C2=A0 =C2=A0 =C2=A0 """Takes a regexp with a single group, matc=
hes it against all
