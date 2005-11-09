From: =?ISO-8859-1?Q?Lukas_Sandstr=F6m?= <lukass@etek.chalmers.se>
Subject: [PATCH] Rename git-pack-intersect to git-pack-redundant
Date: Thu, 10 Nov 2005 00:16:13 +0100
Organization: Chalmers
Message-ID: <4372833D.3010706@etek.chalmers.se>
References: <43714EFB.5070705@etek.chalmers.se> <20051109111917.GB30496@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Petr Baudis <pasky@suse.cz>, junkio@cox.net
X-From: git-owner@vger.kernel.org Thu Nov 10 00:17:59 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EZzAb-0003Yx-2A
	for gcvg-git@gmane.org; Thu, 10 Nov 2005 00:15:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751573AbVKIXPy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 9 Nov 2005 18:15:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751575AbVKIXPy
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Nov 2005 18:15:54 -0500
Received: from pne-smtpout1-sn1.fre.skanova.net ([81.228.11.98]:14835 "EHLO
	pne-smtpout1-sn1.fre.skanova.net") by vger.kernel.org with ESMTP
	id S1751573AbVKIXPx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Nov 2005 18:15:53 -0500
Received: from [192.168.0.82] (213.66.95.18) by pne-smtpout1-sn1.fre.skanova.net (7.2.060.1)
        id 4368D4B900203CB6; Thu, 10 Nov 2005 00:15:50 +0100
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051015)
X-Accept-Language: en-us, en
To: git@vger.kernel.org
In-Reply-To: <20051109111917.GB30496@pasky.or.cz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11436>

Petr Baudis wrote:
> Dear diary, on Wed, Nov 09, 2005 at 02:20:59AM CET, I got a letter
> where Lukas Sandstr=F6m <lukass@etek.chalmers.se> said that...
>=20
>>This patch series adds git-pack-intersect. It finds redundant packs
>>by calculating the union of all objects present in .git/objects/pack
>>and then computing the smallest set of packs which contain all the
>>objects in this union.
>=20
>=20
> Sounds nice, except the name - it does something else than what the n=
ame
> says, so perhaps something like 'git-pack-redundant' would be more
> appropriate.
>=20

Yes, it would. git-pack-intersect is a working name from before
I knew what the program would actually do. In the beginning
it just computed the intersection of two pack-files...

/Lukas Sandstr=F6m

-- >8 -- cut here -- >8 --
Subject: [PATCH] Rename git-pack-intersect to git-pack-redundant

This patch renames git-pack-intersect to git-pack-redundant
as suggested by Petr Baudis. The new name reflects what the
program does, rather than how it does it.

Also fix a small argument parsing bug.

Signed-off-by: Lukas Sandstr=F6m <lukass@etek.chalmers.se>

---

 .gitignore                           |    2 +-
 Documentation/git-pack-redundant.txt |    6 +++---
 Makefile                             |    2 +-
 git-repack.sh                        |    4 ++--
 pack-redundant.c                     |   10 ++++++----
 5 files changed, 13 insertions(+), 11 deletions(-)
 rename Documentation/{git-pack-intersect.txt =3D> git-pack-redundant.t=
xt} (86%)
 rename pack-intersect.c =3D> pack-redundant.c (98%)

applies-to: 85a2ca124a0579c98df5e6d9158a7ee358aeefef
4db829aa0d1811ccf3505aca232045d7970aec5d
diff --git a/.gitignore b/.gitignore
index 6ff2530..1d1aa57 100644
--- a/.gitignore
+++ b/.gitignore
@@ -60,7 +60,7 @@ git-mktag
 git-name-rev
 git-mv
 git-octopus
-git-pack-intersect
+git-pack-redundant
 git-pack-objects
 git-parse-remote
 git-patch-id
diff --git a/Documentation/git-pack-intersect.txt b/Documentation/git-p=
ack-redundant.txt
similarity index 86%
rename from Documentation/git-pack-intersect.txt
rename to Documentation/git-pack-redundant.txt
index a73d9e3..3829616 100644
--- a/Documentation/git-pack-intersect.txt
+++ b/Documentation/git-pack-redundant.txt
@@ -1,14 +1,14 @@
-git-pack-intersect(1)
+git-pack-redundant(1)
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
 NAME
 ----
-git-pack-intersect - Program used to find redundant pack files.
+git-pack-redundant - Program used to find redundant pack files.
=20
=20
 SYNOPSIS
 --------
-'git-pack-intersect [ -v ] < -a | .pack filename ... >'
+'git-pack-redundant [ -v ] < -a | .pack filename ... >'
=20
 DESCRIPTION
 -----------
diff --git a/Makefile b/Makefile
index 4c646c9..b4dca5f 100644
--- a/Makefile
+++ b/Makefile
@@ -122,7 +122,7 @@ PROGRAMS =3D \
 	git-unpack-objects$X git-update-index$X git-update-server-info$X \
 	git-upload-pack$X git-verify-pack$X git-write-tree$X \
 	git-update-ref$X git-symbolic-ref$X git-check-ref-format$X \
-	git-name-rev$X git-pack-intersect$X $(SIMPLE_PROGRAMS)
+	git-name-rev$X git-pack-redundant$X $(SIMPLE_PROGRAMS)
=20
 # Backward compatibility -- to be removed after 1.0
 PROGRAMS +=3D git-ssh-pull$X git-ssh-push$X
diff --git a/git-repack.sh b/git-repack.sh
index 3f28300..4ce0022 100755
--- a/git-repack.sh
+++ b/git-repack.sh
@@ -45,7 +45,7 @@ if [ -z "$name" ]; then
 	if test "$remove_redandant" =3D t ; then
 		echo "Removing redundant packs."
 		sync
-		redundant=3D$(git-pack-intersect -a)
+		redundant=3D$(git-pack-redundant -a)
 		if test "$redundant" !=3D "" ; then
 			echo $redundant | xargs rm
 		fi
@@ -63,7 +63,7 @@ exit
 if test "$remove_redandant" =3D t
 then
 	sync
-	redundant=3D$(git-pack-intersect -a)
+	redundant=3D$(git-pack-redundant -a)
 	if test "$redundant" !=3D "" ; then
 		echo $redundant | xargs rm
 	fi
diff --git a/pack-intersect.c b/pack-redundant.c
similarity index 98%
rename from pack-intersect.c
rename to pack-redundant.c
index 2267478..db3dcde 100644
--- a/pack-intersect.c
+++ b/pack-redundant.c
@@ -8,8 +8,8 @@
=20
 #include "cache.h"
=20
-static const char pack_intersect_usage[] =3D
-"git-pack-intersect [ -v ]  < -a | <.pack filename> ...>";
+static const char pack_redundant_usage[] =3D
+"git-pack-redundant [ -v ]  < -a | <.pack filename> ...>";
=20
 int all =3D 0, verbose =3D 0;
=20
@@ -522,8 +522,10 @@ int main(int argc, char **argv)
=20
 	for (i =3D 1; i < argc; i++) {
 		const char *arg =3D argv[i];
-		if(!strcmp(arg, "--"))
+		if(!strcmp(arg, "--")) {
+			i++;
 			break;
+		}
 		if(!strcmp(arg, "-a")) {
 			all =3D 1;
 			continue;
@@ -533,7 +535,7 @@ int main(int argc, char **argv)
 			continue;
 		}
 		if(*arg =3D=3D '-')
-			usage(pack_intersect_usage);
+			usage(pack_redundant_usage);
 		else
 			break;
 	}
---
0.99.9.GIT
