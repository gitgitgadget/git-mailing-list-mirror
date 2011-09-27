From: Oleg Andreev <oleganza@gmail.com>
Subject: [PATCH] add --progress to git-gc and git-repack
Date: Tue, 27 Sep 2011 22:32:45 +0200
Message-ID: <9F9C752E-6B3C-401B-9E01-8B1F5544A82F@gmail.com>
Mime-Version: 1.0 (Apple Message framework v1244.3)
Content-Type: multipart/mixed; boundary="Apple-Mail=_43C6AEF5-30D1-4396-B224-73EDE396F60D"
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Sep 27 22:34:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R8eMY-0001NE-VZ
	for gcvg-git-2@lo.gmane.org; Tue, 27 Sep 2011 22:34:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753182Ab1I0Ucx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Sep 2011 16:32:53 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:53965 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752561Ab1I0Ucv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Sep 2011 16:32:51 -0400
Received: by wwf22 with SMTP id 22so7821508wwf.1
        for <git@vger.kernel.org>; Tue, 27 Sep 2011 13:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:content-type:subject:date:message-id:to:mime-version:x-mailer;
        bh=p5a9Nmsam8cdoS0X0KnJsKMEpAcvK98RwucwEK9qlvA=;
        b=MlWudDbiPtkATUyHsm/1KvNJdXCVMv4MPcZ2sy7Ap4f4Aj/1HPRI2aTGZAN07mJTzD
         sV+QjROMcIq+SBMudWwhggAePx4Bzsl76b4bnoHfghYfaGbfhbl/g0SL5/WBBHEKaDZd
         uSLIJECC+yHHAVpqZVluu5yWEtK1XOiaSz/rQ=
Received: by 10.216.221.207 with SMTP id r57mr26366wep.100.1317155569085;
        Tue, 27 Sep 2011 13:32:49 -0700 (PDT)
Received: from [10.0.1.8] (dan75-9-78-235-57-9.fbx.proxad.net. [78.235.57.9])
        by mx.google.com with ESMTPS id n21sm37424331wbp.2.2011.09.27.13.32.46
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 27 Sep 2011 13:32:47 -0700 (PDT)
X-Mailer: Apple Mail (2.1244.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182261>


--Apple-Mail=_43C6AEF5-30D1-4396-B224-73EDE396F60D
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

Hello,

Here are two patches adding --progress option to git-gc and git-repack.

You can also pull them from here: git://github.com/oleganza/git.git

Just in case, if some spaces get corrupted, you can find the patches in =
the attachment.



=46rom 1f261e13e72770deabd77087e354f304be850efc Mon Sep 17 00:00:00 2001
From: Oleg Andreev <oleganza@gmail.com>
Date: Tue, 27 Sep 2011 08:24:25 +0200
Subject: [PATCH 1/2] git-repack: pass --progress down to =
git-pack-objects

---
 Documentation/git-repack.txt |    4 ++++
 git-repack.sh                |    6 ++++--
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-repack.txt b/Documentation/git-repack.txt
index 40af321..1c22076 100644
--- a/Documentation/git-repack.txt
+++ b/Documentation/git-repack.txt
@@ -74,6 +74,10 @@ other objects in that pack they already have locally.
 	Pass the `-q` option to 'git pack-objects'. See
 	linkgit:git-pack-objects[1].
=20
+--progress::
+	Pass the `--progress` option to 'git pack-objects'. See
+	linkgit:git-pack-objects[1].
+
 -n::
 	Do not update the server information with
 	'git update-server-info'.  This option skips
diff --git a/git-repack.sh b/git-repack.sh
index 624feec..b86d60e 100755
--- a/git-repack.sh
+++ b/git-repack.sh
@@ -14,6 +14,7 @@ f               pass --no-reuse-delta to =
git-pack-objects
 F               pass --no-reuse-object to git-pack-objects
 n               do not run git-update-server-info
 q,quiet         be quiet
+progress        pass --progress to git-pack-objects
 l               pass --local to git-pack-objects
  Packing constraints
 window=3D         size of the window used for delta compression
@@ -25,7 +26,7 @@ SUBDIRECTORY_OK=3D'Yes'
 . git-sh-setup
=20
 no_update_info=3D all_into_one=3D remove_redundant=3D =
unpack_unreachable=3D
-local=3D no_reuse=3D extra=3D
+local=3D no_reuse=3D extra=3D progress=3D
 while test $# !=3D 0
 do
 	case "$1" in
@@ -35,6 +36,7 @@ do
 		unpack_unreachable=3D--unpack-unreachable ;;
 	-d)	remove_redundant=3Dt ;;
 	-q)	GIT_QUIET=3Dt ;;
+	--progress) progress=3D--progress ;;
 	-f)	no_reuse=3D--no-reuse-delta ;;
 	-F)	no_reuse=3D--no-reuse-object ;;
 	-l)	local=3D--local ;;
@@ -85,7 +87,7 @@ esac
 mkdir -p "$PACKDIR" || exit
=20
 args=3D"$args $local ${GIT_QUIET:+-q} $no_reuse$extra"
-names=3D$(git pack-objects --keep-true-parents --honor-pack-keep =
--non-empty --all --reflog $args </dev/null "$PACKTMP") ||
+names=3D$(git pack-objects --keep-true-parents --honor-pack-keep =
--non-empty --all --reflog $progress $args </dev/null "$PACKTMP") ||
 	exit 1
 if [ -z "$names" ]; then
 	say Nothing new to pack.
--=20
1.7.6.1



=46rom 01437ba2785a23221f246c37f6ba317274bfa6f4 Mon Sep 17 00:00:00 2001
From: Oleg Andreev <oleganza@gmail.com>
Date: Tue, 27 Sep 2011 08:38:20 +0200
Subject: [PATCH 2/2] git-gc: pass --progress down to git-repack

---
 Documentation/git-gc.txt   |   11 +++++++++--
 builtin/gc.c               |    7 ++++++-
 contrib/examples/git-gc.sh |    6 +++++-
 3 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-gc.txt b/Documentation/git-gc.txt
index 815afcb..b65fa3e 100644
--- a/Documentation/git-gc.txt
+++ b/Documentation/git-gc.txt
@@ -9,7 +9,7 @@ git-gc - Cleanup unnecessary files and optimize the =
local repository
 SYNOPSIS
 --------
 [verse]
-'git gc' [--aggressive] [--auto] [--quiet] [--prune=3D<date> | =
--no-prune]
+'git gc' [--aggressive] [--auto] [--quiet] [--progress] [--prune=3D<date>=
 | --no-prune]
=20
 DESCRIPTION
 -----------
@@ -69,7 +69,14 @@ automatic consolidation of packs.
 	Do not prune any loose objects.
=20
 --quiet::
-	Suppress all progress reports.
+	Suppress all progress reports. Progress is not reported to
+	the standard error stream.
+
+--progress::
+	Progress status is reported on the standard error stream
+	by default when it is attached to a terminal, unless -q
+	is specified. This flag forces progress status even if the
+	standard error stream is not directed to a terminal.
=20
 Configuration
 -------------
diff --git a/builtin/gc.c b/builtin/gc.c
index 0498094..e146985 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -28,7 +28,7 @@ static int gc_auto_threshold =3D 6700;
 static int gc_auto_pack_limit =3D 50;
 static const char *prune_expire =3D "2.weeks.ago";
=20
-#define MAX_ADD 10
+#define MAX_ADD 11
 static const char *argv_pack_refs[] =3D {"pack-refs", "--all", =
"--prune", NULL};
 static const char *argv_reflog[] =3D {"reflog", "expire", "--all", =
NULL};
 static const char *argv_repack[MAX_ADD] =3D {"repack", "-d", "-l", =
NULL};
@@ -177,10 +177,12 @@ int cmd_gc(int argc, const char **argv, const char =
*prefix)
 	int aggressive =3D 0;
 	int auto_gc =3D 0;
 	int quiet =3D 0;
+	int progress =3D 0;
 	char buf[80];
=20
 	struct option builtin_gc_options[] =3D {
 		OPT__QUIET(&quiet, "suppress progress reporting"),
+		OPT_BOOLEAN(0, "progress", &progress, "force progress =
reporting"),
 		{ OPTION_STRING, 0, "prune", &prune_expire, "date",
 			"prune unreferenced objects",
 			PARSE_OPT_OPTARG, NULL, (intptr_t)prune_expire =
},
@@ -213,6 +215,9 @@ int cmd_gc(int argc, const char **argv, const char =
*prefix)
 	if (quiet)
 		append_option(argv_repack, "-q", MAX_ADD);
=20
+	if (progress)
+		append_option(argv_repack, "--progress", MAX_ADD);
+
 	if (auto_gc) {
 		/*
 		 * Auto-gc should be least intrusive as possible.
diff --git a/contrib/examples/git-gc.sh b/contrib/examples/git-gc.sh
index 1597e9f..52ea808 100755
--- a/contrib/examples/git-gc.sh
+++ b/contrib/examples/git-gc.sh
@@ -9,12 +9,16 @@ SUBDIRECTORY_OK=3DYes
 . git-sh-setup
=20
 no_prune=3D:
+progress=3D
 while test $# !=3D 0
 do
 	case "$1" in
 	--prune)
 		no_prune=3D
 		;;
+	--progress)
+		progress=3D--progress
+		;;
 	--)
 		usage
 		;;
@@ -32,6 +36,6 @@ esac
 test "true" !=3D "$pack_refs" ||
 git pack-refs --prune &&
 git reflog expire --all &&
-git-repack -a -d -l &&
+git-repack -a -d -l $progress &&
 $no_prune git prune &&
 git rerere gc || exit
--=20
1.7.6.1




--Apple-Mail=_43C6AEF5-30D1-4396-B224-73EDE396F60D
Content-Disposition: attachment;
	filename=0001-git-repack-pass-progress-down-to-git-pack-objects.patch
Content-Type: application/octet-stream;
	name="0001-git-repack-pass-progress-down-to-git-pack-objects.patch"
Content-Transfer-Encoding: quoted-printable

=46rom=201f261e13e72770deabd77087e354f304be850efc=20Mon=20Sep=2017=20=
00:00:00=202001=0AFrom:=20Oleg=20Andreev=20<oleganza@gmail.com>=0ADate:=20=
Tue,=2027=20Sep=202011=2008:24:25=20+0200=0ASubject:=20[PATCH=201/2]=20=
git-repack:=20pass=20--progress=20down=20to=20git-pack-objects=0A=0A---=0A=
=20Documentation/git-repack.txt=20|=20=20=20=204=20++++=0A=20=
git-repack.sh=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20|=20=20=20=20=
6=20++++--=0A=202=20files=20changed,=208=20insertions(+),=202=20=
deletions(-)=0A=0Adiff=20--git=20a/Documentation/git-repack.txt=20=
b/Documentation/git-repack.txt=0Aindex=2040af321..1c22076=20100644=0A---=20=
a/Documentation/git-repack.txt=0A+++=20b/Documentation/git-repack.txt=0A=
@@=20-74,6=20+74,10=20@@=20other=20objects=20in=20that=20pack=20they=20=
already=20have=20locally.=0A=20=09Pass=20the=20`-q`=20option=20to=20'git=20=
pack-objects'.=20See=0A=20=09linkgit:git-pack-objects[1].=0A=20=0A=
+--progress::=0A+=09Pass=20the=20`--progress`=20option=20to=20'git=20=
pack-objects'.=20See=0A+=09linkgit:git-pack-objects[1].=0A+=0A=20-n::=0A=20=
=09Do=20not=20update=20the=20server=20information=20with=0A=20=09'git=20=
update-server-info'.=20=20This=20option=20skips=0Adiff=20--git=20=
a/git-repack.sh=20b/git-repack.sh=0Aindex=20624feec..b86d60e=20100755=0A=
---=20a/git-repack.sh=0A+++=20b/git-repack.sh=0A@@=20-14,6=20+14,7=20@@=20=
f=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20pass=20--no-reuse-delta=20=
to=20git-pack-objects=0A=20F=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
pass=20--no-reuse-object=20to=20git-pack-objects=0A=20n=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20do=20not=20run=20git-update-server-info=0A=20=
q,quiet=20=20=20=20=20=20=20=20=20be=20quiet=0A+progress=20=20=20=20=20=20=
=20=20pass=20--progress=20to=20git-pack-objects=0A=20l=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20pass=20--local=20to=20git-pack-objects=0A=20=20=
Packing=20constraints=0A=20window=3D=20=20=20=20=20=20=20=20=20size=20of=20=
the=20window=20used=20for=20delta=20compression=0A@@=20-25,7=20+26,7=20=
@@=20SUBDIRECTORY_OK=3D'Yes'=0A=20.=20git-sh-setup=0A=20=0A=20=
no_update_info=3D=20all_into_one=3D=20remove_redundant=3D=20=
unpack_unreachable=3D=0A-local=3D=20no_reuse=3D=20extra=3D=0A+local=3D=20=
no_reuse=3D=20extra=3D=20progress=3D=0A=20while=20test=20$#=20!=3D=200=0A=
=20do=0A=20=09case=20"$1"=20in=0A@@=20-35,6=20+36,7=20@@=20do=0A=20=09=09=
unpack_unreachable=3D--unpack-unreachable=20;;=0A=20=09-d)=09=
remove_redundant=3Dt=20;;=0A=20=09-q)=09GIT_QUIET=3Dt=20;;=0A+=09=
--progress)=20progress=3D--progress=20;;=0A=20=09-f)=09=
no_reuse=3D--no-reuse-delta=20;;=0A=20=09-F)=09=
no_reuse=3D--no-reuse-object=20;;=0A=20=09-l)=09local=3D--local=20;;=0A=
@@=20-85,7=20+87,7=20@@=20esac=0A=20mkdir=20-p=20"$PACKDIR"=20||=20exit=0A=
=20=0A=20args=3D"$args=20$local=20${GIT_QUIET:+-q}=20$no_reuse$extra"=0A=
-names=3D$(git=20pack-objects=20--keep-true-parents=20--honor-pack-keep=20=
--non-empty=20--all=20--reflog=20$args=20</dev/null=20"$PACKTMP")=20||=0A=
+names=3D$(git=20pack-objects=20--keep-true-parents=20--honor-pack-keep=20=
--non-empty=20--all=20--reflog=20$progress=20$args=20</dev/null=20=
"$PACKTMP")=20||=0A=20=09exit=201=0A=20if=20[=20-z=20"$names"=20];=20=
then=0A=20=09say=20Nothing=20new=20to=20pack.=0A--=20=0A1.7.6.1=0A=0A=

--Apple-Mail=_43C6AEF5-30D1-4396-B224-73EDE396F60D
Content-Disposition: attachment;
	filename=0002-git-gc-pass-progress-down-to-git-repack.patch
Content-Type: application/octet-stream;
	name="0002-git-gc-pass-progress-down-to-git-repack.patch"
Content-Transfer-Encoding: quoted-printable

=46rom=2001437ba2785a23221f246c37f6ba317274bfa6f4=20Mon=20Sep=2017=20=
00:00:00=202001=0AFrom:=20Oleg=20Andreev=20<oleganza@gmail.com>=0ADate:=20=
Tue,=2027=20Sep=202011=2008:38:20=20+0200=0ASubject:=20[PATCH=202/2]=20=
git-gc:=20pass=20--progress=20down=20to=20git-repack=0A=0A---=0A=20=
Documentation/git-gc.txt=20=20=20|=20=20=2011=20+++++++++--=0A=20=
builtin/gc.c=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20|=20=20=20=207=20=
++++++-=0A=20contrib/examples/git-gc.sh=20|=20=20=20=206=20+++++-=0A=203=20=
files=20changed,=2020=20insertions(+),=204=20deletions(-)=0A=0Adiff=20=
--git=20a/Documentation/git-gc.txt=20b/Documentation/git-gc.txt=0Aindex=20=
815afcb..b65fa3e=20100644=0A---=20a/Documentation/git-gc.txt=0A+++=20=
b/Documentation/git-gc.txt=0A@@=20-9,7=20+9,7=20@@=20git-gc=20-=20=
Cleanup=20unnecessary=20files=20and=20optimize=20the=20local=20=
repository=0A=20SYNOPSIS=0A=20--------=0A=20[verse]=0A-'git=20gc'=20=
[--aggressive]=20[--auto]=20[--quiet]=20[--prune=3D<date>=20|=20=
--no-prune]=0A+'git=20gc'=20[--aggressive]=20[--auto]=20[--quiet]=20=
[--progress]=20[--prune=3D<date>=20|=20--no-prune]=0A=20=0A=20=
DESCRIPTION=0A=20-----------=0A@@=20-69,7=20+69,14=20@@=20automatic=20=
consolidation=20of=20packs.=0A=20=09Do=20not=20prune=20any=20loose=20=
objects.=0A=20=0A=20--quiet::=0A-=09Suppress=20all=20progress=20reports.=0A=
+=09Suppress=20all=20progress=20reports.=20Progress=20is=20not=20=
reported=20to=0A+=09the=20standard=20error=20stream.=0A+=0A+--progress::=0A=
+=09Progress=20status=20is=20reported=20on=20the=20standard=20error=20=
stream=0A+=09by=20default=20when=20it=20is=20attached=20to=20a=20=
terminal,=20unless=20-q=0A+=09is=20specified.=20This=20flag=20forces=20=
progress=20status=20even=20if=20the=0A+=09standard=20error=20stream=20is=20=
not=20directed=20to=20a=20terminal.=0A=20=0A=20Configuration=0A=20=
-------------=0Adiff=20--git=20a/builtin/gc.c=20b/builtin/gc.c=0Aindex=20=
0498094..e146985=20100644=0A---=20a/builtin/gc.c=0A+++=20b/builtin/gc.c=0A=
@@=20-28,7=20+28,7=20@@=20static=20int=20gc_auto_threshold=20=3D=206700;=0A=
=20static=20int=20gc_auto_pack_limit=20=3D=2050;=0A=20static=20const=20=
char=20*prune_expire=20=3D=20"2.weeks.ago";=0A=20=0A-#define=20MAX_ADD=20=
10=0A+#define=20MAX_ADD=2011=0A=20static=20const=20char=20=
*argv_pack_refs[]=20=3D=20{"pack-refs",=20"--all",=20"--prune",=20NULL};=0A=
=20static=20const=20char=20*argv_reflog[]=20=3D=20{"reflog",=20"expire",=20=
"--all",=20NULL};=0A=20static=20const=20char=20*argv_repack[MAX_ADD]=20=3D=
=20{"repack",=20"-d",=20"-l",=20NULL};=0A@@=20-177,10=20+177,12=20@@=20=
int=20cmd_gc(int=20argc,=20const=20char=20**argv,=20const=20char=20=
*prefix)=0A=20=09int=20aggressive=20=3D=200;=0A=20=09int=20auto_gc=20=3D=20=
0;=0A=20=09int=20quiet=20=3D=200;=0A+=09int=20progress=20=3D=200;=0A=20=09=
char=20buf[80];=0A=20=0A=20=09struct=20option=20builtin_gc_options[]=20=3D=
=20{=0A=20=09=09OPT__QUIET(&quiet,=20"suppress=20progress=20reporting"),=0A=
+=09=09OPT_BOOLEAN(0,=20"progress",=20&progress,=20"force=20progress=20=
reporting"),=0A=20=09=09{=20OPTION_STRING,=200,=20"prune",=20=
&prune_expire,=20"date",=0A=20=09=09=09"prune=20unreferenced=20objects",=0A=
=20=09=09=09PARSE_OPT_OPTARG,=20NULL,=20(intptr_t)prune_expire=20},=0A@@=20=
-213,6=20+215,9=20@@=20int=20cmd_gc(int=20argc,=20const=20char=20**argv,=20=
const=20char=20*prefix)=0A=20=09if=20(quiet)=0A=20=09=09=
append_option(argv_repack,=20"-q",=20MAX_ADD);=0A=20=0A+=09if=20=
(progress)=0A+=09=09append_option(argv_repack,=20"--progress",=20=
MAX_ADD);=0A+=0A=20=09if=20(auto_gc)=20{=0A=20=09=09/*=0A=20=09=09=20*=20=
Auto-gc=20should=20be=20least=20intrusive=20as=20possible.=0Adiff=20=
--git=20a/contrib/examples/git-gc.sh=20b/contrib/examples/git-gc.sh=0A=
index=201597e9f..52ea808=20100755=0A---=20a/contrib/examples/git-gc.sh=0A=
+++=20b/contrib/examples/git-gc.sh=0A@@=20-9,12=20+9,16=20@@=20=
SUBDIRECTORY_OK=3DYes=0A=20.=20git-sh-setup=0A=20=0A=20no_prune=3D:=0A=
+progress=3D=0A=20while=20test=20$#=20!=3D=200=0A=20do=0A=20=09case=20=
"$1"=20in=0A=20=09--prune)=0A=20=09=09no_prune=3D=0A=20=09=09;;=0A+=09=
--progress)=0A+=09=09progress=3D--progress=0A+=09=09;;=0A=20=09--)=0A=20=09=
=09usage=0A=20=09=09;;=0A@@=20-32,6=20+36,6=20@@=20esac=0A=20test=20=
"true"=20!=3D=20"$pack_refs"=20||=0A=20git=20pack-refs=20--prune=20&&=0A=20=
git=20reflog=20expire=20--all=20&&=0A-git-repack=20-a=20-d=20-l=20&&=0A=
+git-repack=20-a=20-d=20-l=20$progress=20&&=0A=20$no_prune=20git=20prune=20=
&&=0A=20git=20rerere=20gc=20||=20exit=0A--=20=0A1.7.6.1=0A=0A=

--Apple-Mail=_43C6AEF5-30D1-4396-B224-73EDE396F60D
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=us-ascii




--Apple-Mail=_43C6AEF5-30D1-4396-B224-73EDE396F60D--
