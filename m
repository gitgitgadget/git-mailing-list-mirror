From: tboegi@web.de
Subject: [PATCH/RFC] t0060: basename("//") is implementation defined
Date: Wed, 13 Jan 2016 21:56:01 +0100
Message-ID: <1452718561-32226-1-git-send-email-tboegi@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: tboegi@web.de, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 13 21:56:14 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJSSj-00054a-UD
	for gcvg-git-2@plane.gmane.org; Wed, 13 Jan 2016 21:56:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758491AbcAMU4J convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 13 Jan 2016 15:56:09 -0500
Received: from mout.web.de ([212.227.15.3]:55348 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753030AbcAMU4I (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jan 2016 15:56:08 -0500
Received: from snoopy.lan ([213.66.56.100]) by smtp.web.de (mrweb002) with
 ESMTPSA (Nemesis) id 0Mbydi-1aZTwR3sV4-00JK2d; Wed, 13 Jan 2016 21:56:06
 +0100
X-Mailer: git-send-email 2.2.1.212.gc5b9256
X-Provags-ID: V03:K0:asEQrQHxc4rorWaKN6jARUThEIdVeBVVuaGx0pYDhS7dQSGKZej
 RJs2D3vm776UPjSu7XmrJMKXSd7aVSyXgazNx+NpdsdQ2vYB0KfXquY0y8d/xRS+98o5lWO
 q59+8KjxyYaGUSBLGeeU6/GrulUn204LH7lpx3BB0RsTlUNYKZKMQe8eGJTIByKKgJ4pujz
 6PXrUpSDx7tYWP6xTOiHA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:O5tKdDT9WFI=:rFrgbeIoMa9Ojrgg1W/aKo
 Geh0z6RbC9BDEo67OB/sy0rbNFXGpr31RhpfnNG1jRpDhWsuDrOEXibhWnSV3/3GXTnsubHUG
 6eZ8yvyhsCV/g/RWsR9XsitAlZWfo7BNqOTq//7qgkdIjh/x8Ee5OQ7p4sYgQ87iap+tWziUc
 grhB5JT7Gv8+0yBAviRtEXw+7LOZlM+/PWRbe0nuSzvUzkljso2D2Kcm/aoA9outQEXfAvsMx
 HW7fm0DlFvAjRq8EaN8W/IIy9waBV8HDgoLCIyxlkSroTXhgx7fhfT0+xQMhhH9SrwTR34XlD
 zJ4UO6EEPsBI6AVFkFsZoQzZ5SvqeM7xzl3c0FPOVRkol1USVSG5nSvUls7gjzoOucew7D82D
 HAyvUUPYZY1244RTiCLC1/Cg8A41daNp72mgvv5ruoskdlhIvN73U/6tYGApZ0aR4jOGShH7k
 Sz+TKYhspDt7Rxh2MM1fjenCQR+UAX/S6nhSZlOU9XeBr4xv3uNBMq3BsxCD7v+tjGAgFFneF
 tkfzGWOvbdPUkKxeUF4tUQ97WHA9o6lfHUYIpc2mlN7XrY/Fr3OJE5MFvbUAt8ThqsePxXbU9
 28IMZqBBHMuu6CsXPv5yRQ1jnpPXgE/Nmif4XqNJ7CaHXNXeX/VwKk4hvmvs7offdz7/rDdK2
 UP06dBt7tlULbirEoUggR5Lwlow59Z/bI0xf6S1S7+8O33J4loGCBUV6ZUoXvqmvmFLYg4B6z
 4xjir8wE3dJeeJcjmRhxv8fX3cW65Vo0p3tMcDf0ACFoWdXYoOoUwWqZ5vsqD0sEPf2ckRLP 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283986>

=46rom: Torsten B=C3=B6gershausen <tboegi@web.de>

=46rom
http://pubs.opengroup.org/onlinepubs/9699919799/functions/basename.html
basename("//") may return either "//" or "/".

Linux returns "/", some systems like Mac OS X return "//".
Skip the test unless NO_LIBGEN_H is set and gitbasename() from
compat/basename is used.

Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
---
My version of a hot fix
 test-path-utils.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/test-path-utils.c b/test-path-utils.c
index 4ab68ac..db0bb39 100644
--- a/test-path-utils.c
+++ b/test-path-utils.c
@@ -142,7 +142,9 @@ static struct test_data dirname_data[] =3D {
 	{ ".",               "."      },
 	{ "..",              "."      },
 	{ "/",               "/"      },
+#if defined(NO_LIBGEN_H)
 	{ "//",              "//"     },
+#endif
 #if defined(__CYGWIN__) && !defined(NO_LIBGEN_H)
 	{ "///",             "//"     },
 	{ "////",            "//"     },
--=20
2.7.0.278.g9379adb.dirty
