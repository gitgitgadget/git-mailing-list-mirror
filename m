From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 3/3] {fetch,upload}-pack: allow --depth=0 for infinite depth
Date: Fri, 20 Aug 2010 11:51:07 +1000
Message-ID: <1282269067-5527-3-git-send-email-pclouds@gmail.com>
References: <1282269067-5527-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: Jakub Narebski <jnareb@gmail.com>, mikachu@gmail.com,
	computerdruid@gmail.com, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 20 03:51:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OmGlq-0007IK-5P
	for gcvg-git-2@lo.gmane.org; Fri, 20 Aug 2010 03:51:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751508Ab0HTBvs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 19 Aug 2010 21:51:48 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:46152 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750849Ab0HTBvq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Aug 2010 21:51:46 -0400
Received: by pvg2 with SMTP id 2so994898pvg.19
        for <git@vger.kernel.org>; Thu, 19 Aug 2010 18:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=/zY57SQDg86stAUJHpNLUMT1wnuj7nZjlG2ebQ6OA3w=;
        b=W391PqEcPaJEBEAZcQzrPgcWscLB6ktqgUOd4xMf27YdI7tdh/lB28liiTkUp+OVai
         AGne5XZSoZPepzuyZeHPMY4vY1xx+l62NUsFpimVPA3GqnqdsDq16mx61n2pLCOTbGqG
         dmd/O9VjKRWdc/ZJYlv9h/Ou8fbi1up0LYtT0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=WDhbh7inXWI5amFXNwBTIxG96RDx0c8dq2ovEc3OWFGX6LDIYPQAVk591hPZlbegTb
         pShpYGuARlWWZqIzDUtJ8vHu+ozedjCHcE4FX0KoXt0xPGif/6WkI242kV8KbT6OSQjW
         wEqaBoxM6JkHpQwRpSOY/1cw+4haAgO+RROVE=
Received: by 10.143.166.17 with SMTP id t17mr612721wfo.35.1282269106456;
        Thu, 19 Aug 2010 18:51:46 -0700 (PDT)
Received: from dektop (dektec3.lnk.telstra.net [165.228.202.174])
        by mx.google.com with ESMTPS id n2sm2503605wfl.13.2010.08.19.18.51.43
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 19 Aug 2010 18:51:45 -0700 (PDT)
Received: by dektop (sSMTP sendmail emulation); Fri, 20 Aug 2010 11:51:35 +1000
X-Mailer: git-send-email 1.7.1.rc1.69.g24c2f7
In-Reply-To: <1282269067-5527-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153970>

Users can do --depth=3D2147483648 for infinite depth now. It just looks
ugly. So make "0" special (i.e. infinite depth) at plumbing/protocol
level.

To make it even more user friendly, "git fetch" accepts --depth=3Dinf a=
s
an alternative to --depth=3D0. "git clone" also can. It just does not
make much sense for doing "git clone --depth=3Dinf"

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/fetch-options.txt     |    3 ++-
 Documentation/git-fetch-pack.txt    |    1 +
 Documentation/technical/shallow.txt |    2 ++
 builtin/fetch-pack.c                |    2 +-
 shallow.c                           |    2 +-
 t/t5500-fetch-pack.sh               |    8 ++++++++
 transport.c                         |    2 +-
 upload-pack.c                       |    8 ++++----
 8 files changed, 20 insertions(+), 8 deletions(-)

diff --git a/Documentation/fetch-options.txt b/Documentation/fetch-opti=
ons.txt
index 9333c42..a22d839 100644
--- a/Documentation/fetch-options.txt
+++ b/Documentation/fetch-options.txt
@@ -10,7 +10,8 @@
 --depth=3D<depth>::
 	Deepen the history of a 'shallow' repository created by
 	`git clone` with `--depth=3D<depth>` option (see linkgit:git-clone[1]=
)
-	by the specified number of commits.
+	by the specified number of commits. Specify "inf" for
+	infinite depth.
=20
 ifndef::git-pull[]
 --dry-run::
diff --git a/Documentation/git-fetch-pack.txt b/Documentation/git-fetch=
-pack.txt
index 4a8487c..75e4669 100644
--- a/Documentation/git-fetch-pack.txt
+++ b/Documentation/git-fetch-pack.txt
@@ -70,6 +70,7 @@ OPTIONS
=20
 --depth=3D<n>::
 	Limit fetching to ancestor-chains not longer than n.
+	Specify 0 for infinite depth.
=20
 --no-progress::
 	Do not show the progress.
diff --git a/Documentation/technical/shallow.txt b/Documentation/techni=
cal/shallow.txt
index 559263a..405170f 100644
--- a/Documentation/technical/shallow.txt
+++ b/Documentation/technical/shallow.txt
@@ -47,3 +47,5 @@ It also writes an appropriate $GIT_DIR/shallow.
 You can deepen a shallow repository with "git-fetch --depth 20
 repo branch", which will fetch branch from repo, but stop at depth
 20, updating $GIT_DIR/shallow.
+
+"--depth 0" (or "--depth inf" for git-fetch) means infinite depth.
diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
index 45d1824..7d7af2e 100644
--- a/builtin/fetch-pack.c
+++ b/builtin/fetch-pack.c
@@ -845,7 +845,7 @@ int cmd_fetch_pack(int argc, const char **argv, con=
st char *prefix)
 			}
 			if (!prefixcmp(arg, "--depth=3D")) {
 				args.depth =3D strtol(arg + 8, NULL, 0);
-				if (args.depth <=3D 0)
+				if (args.depth < 0)
 					die("Invalid depth %d", args.depth);
 				args.shallow =3D 1;
 				continue;
diff --git a/shallow.c b/shallow.c
index 4d90eda..eab97c6 100644
--- a/shallow.c
+++ b/shallow.c
@@ -85,7 +85,7 @@ struct commit_list *get_shallow_commits(struct object=
_array *heads, int depth,
 					continue;
 				*pointer =3D cur_depth;
 			}
-			if (cur_depth < depth) {
+			if (!depth || cur_depth < depth) {
 				if (p->next)
 					add_object_array(&p->item->object,
 							NULL, &stack);
diff --git a/t/t5500-fetch-pack.sh b/t/t5500-fetch-pack.sh
index 18376d6..47fd87c 100755
--- a/t/t5500-fetch-pack.sh
+++ b/t/t5500-fetch-pack.sh
@@ -248,4 +248,12 @@ test_expect_success 'clone shallow object count' '
 	grep "^count: 52" count.shallow
 '
=20
+test_expect_success 'infinite deepening (full repo)' '
+	(
+		cd shallow &&
+		git fetch --depth=3Dinf &&
+		! test -f .git/shallow
+	)
+'
+
 test_done
diff --git a/transport.c b/transport.c
index cf7030b..9303aef 100644
--- a/transport.c
+++ b/transport.c
@@ -475,7 +475,7 @@ static int set_git_option(struct git_transport_opti=
ons *opts,
 			opts->shallow =3D 0;
 		}
 		else {
-			opts->depth =3D atoi(value);
+			opts->depth =3D !strcmp(value, "inf") ? 0 : atoi(value);
 			opts->shallow =3D 1;
 		}
 		return 0;
diff --git a/upload-pack.c b/upload-pack.c
index fc79dde..7b004b9 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -484,7 +484,7 @@ static void receive_needs(void)
 {
 	struct object_array shallows =3D {0, 0, NULL};
 	static char line[1000];
-	int len, depth =3D 0;
+	int len, depth =3D -1;
=20
 	shallow_nr =3D 0;
 	if (debug_fd)
@@ -514,7 +514,7 @@ static void receive_needs(void)
 		if (!prefixcmp(line, "deepen ")) {
 			char *end;
 			depth =3D strtol(line + 7, &end, 0);
-			if (end =3D=3D line + 7 || depth <=3D 0)
+			if (end =3D=3D line + 7 || depth < 0)
 				die("Invalid deepen: %s", line);
 			continue;
 		}
@@ -562,9 +562,9 @@ static void receive_needs(void)
 	if (!use_sideband && daemon_mode)
 		no_progress =3D 1;
=20
-	if (depth =3D=3D 0 && shallows.nr =3D=3D 0)
+	if (depth =3D=3D -1 && shallows.nr =3D=3D 0)
 		return;
-	if (depth > 0) {
+	if (depth >=3D 0) {
 		struct commit_list *result, *backup;
 		int i;
 		backup =3D result =3D get_shallow_commits(&want_obj, depth,
--=20
1.7.1.rc1.69.g24c2f7
