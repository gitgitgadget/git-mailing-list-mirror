From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 6/7] remote-bzr: add utf-8 support for fetching
Date: Fri,  5 Apr 2013 21:49:22 -0600
Message-ID: <1365220163-13581-7-git-send-email-felipe.contreras@gmail.com>
References: <1365220163-13581-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Timotheus Pokorra <timotheus.pokorra@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 06 20:04:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UOWSG-0001b9-3X
	for gcvg-git-2@plane.gmane.org; Sat, 06 Apr 2013 18:59:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1163213Ab3DFDxP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 5 Apr 2013 23:53:15 -0400
Received: from mail-oa0-f48.google.com ([209.85.219.48]:53931 "EHLO
	mail-oa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756759Ab3DFDxO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Apr 2013 23:53:14 -0400
Received: by mail-oa0-f48.google.com with SMTP id j1so4546985oag.7
        for <git@vger.kernel.org>; Fri, 05 Apr 2013 20:53:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=Txbikg0m2JKyvd/UxpqUgB31gjNIVRj666qLHxbwnaQ=;
        b=YG3fyeXOhfwN7YQqoOJQD8+TI7U/0XDk6qmOmdFDn5u49KODdEyoJZYtXYtJ9c08h+
         zwwgo5xpRptOqIyO661uAHnjeLTKiV7JFUm6IKqVn3NOWFifAFC4kZyghijzcWup2LzC
         60ctBFzg347zvsXKOPyVW6X156WqNayTlWyMfD8npWRWAQPdFqqIg24LmO8dk7fUGqWZ
         EqmPGoHkd1UB8aGNytdOFDN2y0zcnXE4PtI6lp8o4pggobkB+eEsjByRJaikwbqkmrqd
         QJUkGTwAhmcvofDs9m4YZFQVCpyU0FQnruHEkfSzFgT5JaRF93g0uA38HK49m9F9WoX6
         xSHg==
X-Received: by 10.182.136.72 with SMTP id py8mr10000046obb.0.1365220393976;
        Fri, 05 Apr 2013 20:53:13 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPS id l4sm15197949oek.3.2013.04.05.20.52.57
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 05 Apr 2013 20:53:13 -0700 (PDT)
X-Mailer: git-send-email 1.8.2
In-Reply-To: <1365220163-13581-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220253>

=46rom: Timotheus Pokorra <timotheus.pokorra@gmail.com>

[fc: added tests]

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/git-remote-bzr |  4 ++--
 contrib/remote-helpers/test-bzr.sh    | 25 +++++++++++++++++++++++++
 2 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/contrib/remote-helpers/git-remote-bzr b/contrib/remote-hel=
pers/git-remote-bzr
index 0bcf8c5..0bd0759 100755
--- a/contrib/remote-helpers/git-remote-bzr
+++ b/contrib/remote-helpers/git-remote-bzr
@@ -223,7 +223,7 @@ def export_files(tree, files):
             # is the blog already exported?
             if h in filenodes:
                 mark =3D filenodes[h]
-                final.append((mode, mark, path))
+                final.append((mode, mark, path.encode('utf-8')))
                 continue
=20
             d =3D tree.get_file_text(fid)
@@ -240,7 +240,7 @@ def export_files(tree, files):
         print "data %d" % len(d)
         print d
=20
-        final.append((mode, mark, path))
+        final.append((mode, mark, path.encode('utf-8')))
=20
     return final
=20
diff --git a/contrib/remote-helpers/test-bzr.sh b/contrib/remote-helper=
s/test-bzr.sh
index 68105fc..e468079 100755
--- a/contrib/remote-helpers/test-bzr.sh
+++ b/contrib/remote-helpers/test-bzr.sh
@@ -165,4 +165,29 @@ test_expect_success 'different authors' '
   test_cmp expected actual
 '
=20
+test_expect_success 'fetch utf-8 filenames' '
+  mkdir -p tmp && cd tmp &&
+  test_when_finished "cd .. && rm -rf tmp && LC_ALL=3DC" &&
+
+  export LC_ALL=3Den_US.UTF-8
+
+  (
+  bzr init bzrrepo &&
+  cd bzrrepo &&
+
+  echo test >> "=C3=A1=C3=A9=C3=AD=C3=B3=C3=BA" &&
+  bzr add "=C3=A1=C3=A9=C3=AD=C3=B3=C3=BA" &&
+  bzr commit -m utf-8
+  ) &&
+
+  (
+  git clone "bzr::$PWD/bzrrepo" gitrepo &&
+  cd gitrepo &&
+  git ls-files > ../actual
+  ) &&
+
+  echo "\"\\303\\241\\303\\251\\303\\255\\303\\263\\303\\272\"" > expe=
cted &&
+  test_cmp expected actual
+'
+
 test_done
--=20
1.8.2
