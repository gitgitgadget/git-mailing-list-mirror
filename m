From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 3/4] commit: turn commit.ignoreIntentToAdd to true by default
Date: Mon,  6 Feb 2012 17:57:34 +0700
Message-ID: <1328525855-2547-4-git-send-email-pclouds@gmail.com>
References: <1328525855-2547-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 06 11:53:11 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RuMC5-0005AZ-BW
	for gcvg-git-2@plane.gmane.org; Mon, 06 Feb 2012 11:53:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754684Ab2BFKxE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 Feb 2012 05:53:04 -0500
Received: from mail-pw0-f46.google.com ([209.85.160.46]:40579 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754527Ab2BFKxC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Feb 2012 05:53:02 -0500
Received: by mail-pw0-f46.google.com with SMTP id u11so4870137pbd.19
        for <git@vger.kernel.org>; Mon, 06 Feb 2012 02:53:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=mQ6mPDbfm+l2rP1HLgeHt2S12Jf7Hjysql0zfpXZ1pY=;
        b=rzXYSEymyFlgmDrOW7a+o5LbYt5TwL9BNg3XaabesEkiZRZK4du49NUANliVOtIFRP
         AGIR8kD3uKcKZtgwUlFJ6bWSN4zhbLJj9XfsjL1AgZEXBv5NI+cQmyvha1pJ/g51ZMR4
         byewzxHgSkZ8Asc5tuLqlPwBALUGtQFEVmRZg=
Received: by 10.68.227.132 with SMTP id sa4mr47335855pbc.64.1328525582174;
        Mon, 06 Feb 2012 02:53:02 -0800 (PST)
Received: from tre ([115.74.57.120])
        by mx.google.com with ESMTPS id x4sm38333635pbx.16.2012.02.06.02.52.58
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 06 Feb 2012 02:53:01 -0800 (PST)
Received: by tre (sSMTP sendmail emulation); Mon, 06 Feb 2012 17:57:57 +0700
X-Mailer: git-send-email 1.7.8.36.g69ee2
In-Reply-To: <1328525855-2547-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190065>

=46rom now on, those who has not set commit.ignoreIntentToAdd can commi=
t
as-is even if there are intent-to-add entries. Users are advised/annoye=
d
to switch to new behavior.

Support for "commit.ignoreIntentToAdd =3D true" will be dropped in futu=
re.
The placeholder "FIXME" needs to be replaced when it's decided what
release will drop config support.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/config.txt |    5 ++---
 builtin/commit.c         |   13 ++++++++-----
 t/t2203-add-intent.sh    |    4 ++--
 3 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 6ec81a8..f9a05ac 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -837,9 +837,8 @@ commit.ignoreIntentToAdd::
 	in index. Set to `false` to disallow commit in this acase, or `true`
 	to allow it.
 +
-By default, `git commit` refuses to commit as-is when you have intent-=
to-add
-entries. This will change in 1.8.0, where `git commit` allows it. If y=
ou
-prefer current behavior, please set it to `false`.
+By default, `git commit` allows to commit as-is when you have intent-t=
o-add
+entries. Support for this configuration variable will be dropped in FI=
XME.
=20
 credential.helper::
 	Specify an external helper to be called when a username or
diff --git a/builtin/commit.c b/builtin/commit.c
index af3250c..eb0ca49 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -423,17 +423,17 @@ static char *prepare_index(int argc, const char *=
*argv, const char *prefix,
 	if (!pathspec || !*pathspec) {
 		fd =3D hold_locked_index(&index_lock, 1);
 		refresh_cache_or_die(refresh_flags);
-		if (!set_commit_ignoreintenttoadd) {
+		if (!(cache_tree_flags & WRITE_TREE_IGNORE_INTENT_TO_ADD)) {
 			int i;
 			for (i =3D 0; i < active_nr; i++)
 				if (active_cache[i]->ce_flags & CE_INTENT_TO_ADD)
 					break;
 			if (i < active_nr)
 				warning(_("You are committing as-is with intent-to-add entries as =
the result of\n"
-					  "\"git add -N\". Git currently forbids this case. This will cha=
nge in\n"
-					  "1.8.0 where intent-to-add entries are simply ignored when comm=
itting\n"
-					  "as-is. Please look up document and set commit.ignoreIntentToAd=
d\n"
-					  "properly to stop this warning."));
+					  "\"git add -N\". Git currently forbids this case. But this is d=
eprecated\n"
+					  "support for this behavior will be dropped in FIXME.\n"
+					  "Please look up document and set commit.ignoreIntentToAdd to tr=
ue\n"
+					  "or remove it."));
 		}
 		if (active_cache_changed) {
 			update_main_cache_tree(cache_tree_flags | WRITE_TREE_SILENT);
@@ -1423,6 +1423,9 @@ int cmd_commit(int argc, const char **argv, const=
 char *prefix)
 	git_config(git_commit_config, &s);
 	determine_whence(&s);
=20
+	if (!set_commit_ignoreintenttoadd)
+		cache_tree_flags |=3D WRITE_TREE_IGNORE_INTENT_TO_ADD;
+
 	if (get_sha1("HEAD", sha1))
 		current_head =3D NULL;
 	else {
diff --git a/t/t2203-add-intent.sh b/t/t2203-add-intent.sh
index 88a508e..09b8bbf 100755
--- a/t/t2203-add-intent.sh
+++ b/t/t2203-add-intent.sh
@@ -41,11 +41,11 @@ test_expect_success 'cannot commit with i-t-a entry=
' '
 	echo frotz >nitfol &&
 	git add rezrov &&
 	git add -N nitfol &&
-	test_must_fail git commit -minitial
+	git commit -minitial
 '
=20
 test_expect_success 'can commit tree with i-t-a entry' '
-	git reset --hard &&
+	git reset --hard HEAD^ &&
 	echo xyzzy >rezrov &&
 	echo frotz >nitfol &&
 	git add rezrov &&
--=20
1.7.8.36.g69ee2
