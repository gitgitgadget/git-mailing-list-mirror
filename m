From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [PATCH] Pass "git config" flags in the right order
Date: Fri, 29 May 2009 09:43:50 +0200
Message-ID: <20090529074300.20591.96310.stgit@october.hq.vtech>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Daniel Aarno <aarno@virtutech.com>, git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 29 09:44:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M9wky-0003yj-9B
	for gcvg-git-2@gmane.org; Fri, 29 May 2009 09:44:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754575AbZE2Hnu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 29 May 2009 03:43:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754558AbZE2Hnu
	(ORCPT <rfc822;git-outgoing>); Fri, 29 May 2009 03:43:50 -0400
Received: from vtab.com ([62.20.90.195]:51808 "EHLO oden.vtab.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754297AbZE2Hnt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 May 2009 03:43:49 -0400
Received: from oden.vtab.com (oden.vtab.com [127.0.0.1])
	by oden.vtab.com (Postfix) with ESMTP id 6BCE726EF6A;
	Fri, 29 May 2009 09:43:50 +0200 (CEST)
Received: from october.hq.vtech (october.hq.vtech [10.0.0.43])
	by oden.vtab.com (Postfix) with ESMTP id 5764A26EF5E;
	Fri, 29 May 2009 09:43:50 +0200 (CEST)
User-Agent: StGit/0.14.3.390.g9adb
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120255>

=46rom: Karl Hasselstr=C3=B6m <kha@treskal.com>

New enough gits accept the --null and --list flags in any order, but
older gits want --null before --list. So do it the way that's fine
with everyone.

I think (but haven't verified) that git started to accept the flags in
any order after commit d64ec16c2af4ddcf3985d11d5dc28a15db181de5 ("git
config: reorganize to use parseopt") by Felipe Contreras on
2009-02-21, first released in git v1.6.3.

Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>

---

Bug discovered by Daniel Aarno.

 stgit/config.py |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)


diff --git a/stgit/config.py b/stgit/config.py
index c40756c..dc9c9eb 100644
--- a/stgit/config.py
+++ b/stgit/config.py
@@ -48,7 +48,7 @@ class GitConfig:
         if self.__cache is not None:
             return
         self.__cache =3D {}
-        lines =3D Run('git', 'config', '--list', '--null').raw_output(=
)
+        lines =3D Run('git', 'config', '--null', '--list').raw_output(=
)
         for line in filter(None, lines.split('\0')):
             key, value =3D line.split('\n', 1)
             self.__cache.setdefault(key, []).append(value)
