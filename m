From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: [PATCH V2] core.filemode may need manual action
Date: Fri, 17 Oct 2014 23:39:44 +0200
Message-ID: <54418CA0.6050503@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: tboegi@web.de
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 17 23:40:05 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XfFFh-0004Wm-2z
	for gcvg-git-2@plane.gmane.org; Fri, 17 Oct 2014 23:40:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751398AbaJQVj5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 17 Oct 2014 17:39:57 -0400
Received: from mout.web.de ([212.227.15.14]:53596 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751262AbaJQVj4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Oct 2014 17:39:56 -0400
Received: from macce.local ([78.72.74.102]) by smtp.web.de (mrweb002) with
 ESMTPSA (Nemesis) id 0MhlP1-1XSPUz1951-00Mumh; Fri, 17 Oct 2014 23:39:53
 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
X-Provags-ID: V03:K0:qkIVZO+s7PpBQD6m3JlE0HN2eYeMhdM0Jym3uu12//Q5KxDPqVW
 vTZ1BbVHdHcB801UhHHZQdaoDn2CwXoE/Dr7U3/spg57tbsfbb6sOTi1oCEVZv1QMWCTOMO
 jvYuiM2eNuYk0a/uffEoGLiG9veAKZJ7yiyVDmOZToKZnqgVPDDmxXUwQODNecYkbHBwSWT
 kiP+WkFVmIinKzAgNk1Cw==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

core.filemode is set automatically when a repo is created.
But when a repo is exported via CIFS or cygwin is mixed with Git for Wi=
ndows
or Eclipse core.filemode may better be set manually to false.
Update and improve the documentation

Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
---

Thanks for careful reading.
Changes since V1:
- The '+' at an otherwise empty line generates an empty line
  in html, so s/^$/+/
- Changed msygit into Git for Windows
- Mention Eclipse
- Minor changes in the wording, remove one comma
- Remove the "The default is true, except "
  This line is maybe confusing.
  "The default is true" is not wrong as such, we have
  int trust_executable_bit =3D 1;
  But: these days most repos have core.filemode defined,
  so describing this default gives not much new information to the
  user. (please correct me if that is wrong)
  Especially the "except" is not really helpful, because
  the default is always true, and git.git will always probe.
  Any thoughts ?
  Now we mention the probing 2 times, I am not 100% happy with this,
  please see V2B

  Another thing is that both Git for Windows and Eclipse can not handle
  the filemode, and should silently ignore the flag, which is a differe=
nt
  patch.


 Documentation/config.txt | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 04a1e2f..959dc11 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -204,12 +204,27 @@ advice.*::
 --
=20
 core.fileMode::
-	If false, the executable bit differences between the index and
-	the working tree are ignored; useful on broken filesystems like FAT.
+	Tells Git if the executable bit of files in the working tree
+	is to be honored.
++
+	Some filesystems lose the executable bit when a file that is
+	marked as executable is checked out, or checks out an
+	non-executable file with executable bit on.  "git init" and
+	"git clone" probe the filesystem to see if it records
+	executable bit correctly when they create a new repository
+	and this variable is automatically set as necessary.
++
+	A repository, however, may be on a filesystem that handles
+	the filemode correctly, and this variable is set to 'true'
+	when created, but later may be made accessible from another
+	environment that loses the filemode (e.g. exporting ext4 via
+	CIFS mount, visiting a Cygwin created repository with
+	Git for Windows or Eclipse).
+	In such a case it may be necessary to set this variable to 'false'.
 	See linkgit:git-update-index[1].
 +
-The default is true, except linkgit:git-clone[1] or linkgit:git-init[1=
]
-will probe and set core.fileMode false if appropriate when the
+linkgit:git-clone[1] or linkgit:git-init[1]
+will probe and set core.fileMode to true or false when the
 repository is created.
=20
 core.ignorecase::
--=20
2.1.0.rc2.210.g636bceb
