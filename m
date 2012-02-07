From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 3/4] commit: turn commit.ignoreIntentToAdd to true by default
Date: Tue,  7 Feb 2012 19:46:43 +0700
Message-ID: <1328618804-31796-4-git-send-email-pclouds@gmail.com>
References: <1328618804-31796-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 07 13:42:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RukN8-0006zr-NU
	for gcvg-git-2@plane.gmane.org; Tue, 07 Feb 2012 13:42:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756151Ab2BGMmC convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 7 Feb 2012 07:42:02 -0500
Received: from mail-pz0-f46.google.com ([209.85.210.46]:34915 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756092Ab2BGMmA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Feb 2012 07:42:00 -0500
Received: by mail-pz0-f46.google.com with SMTP id d14so358770dae.19
        for <git@vger.kernel.org>; Tue, 07 Feb 2012 04:42:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=8Vnhws5ADdLb37ZAkSVjKV6i4nQTp1CTZ6GDW4inyPE=;
        b=SHXmO4j++ETXx9ysRnd7slB3dEFKxCEtVr7qpn6U4sRmyRG3NInPyyq0DXDnhVBsC0
         +9C8OQ8/uzru+EOKdkBuX5j70tCO1mUlhtzxdp4p2BFO8vCwANTuo47aZ65FABiR1YxZ
         qVzy+OJ0Yz46LXsruleSVb25+pnDwoxy7wz/Y=
Received: by 10.68.73.105 with SMTP id k9mr55402558pbv.121.1328618520476;
        Tue, 07 Feb 2012 04:42:00 -0800 (PST)
Received: from tre ([115.74.57.120])
        by mx.google.com with ESMTPS id d1sm29351560pbg.13.2012.02.07.04.41.56
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 07 Feb 2012 04:41:59 -0800 (PST)
Received: by tre (sSMTP sendmail emulation); Tue, 07 Feb 2012 19:47:11 +0700
X-Mailer: git-send-email 1.7.8.36.g69ee2
In-Reply-To: <1328618804-31796-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190169>

This is step 2 from commit.ignoreIntentToAdd deprecation plan. To
recap:

2. A few releases after step 1 is out in the field, turn
commit.ignoreIntentToAdd default value to true (affecting mostly new
users).

Those who decided to stick to "false" from step 1 are warned the "false=
"
support will soon be gone and encouraged to move to "true" (or simply
remove the config variable).

Those who set the config to "true" is advised to remove it to keep
config file clean.

Those who encountered the safety check and did not bother to set this
config var is left out in the cold.

3. A few more releases after step 2, commit.ignoreIntentToAdd is
removed. There's no way to bring back the safety check.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/config.txt |   11 ++++-------
 builtin/commit.c         |   19 ++++++++++++++++---
 t/t2203-add-intent.sh    |    4 ++--
 3 files changed, 22 insertions(+), 12 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 6839e44..fa56753 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -839,13 +839,10 @@ commit.ignoreIntentToAdd::
 	these entries.  Setting this to `true` makes `git commit`
 	pretend as if these entries do not exist in the index.
 +
-The default for this variable is `false`, but it will change to `true`
-in future releases of git. To ease the transition, you may want to set
-it to `true` now and get used to the new behaviour early, or you may
-want to set it to `false` to keep the old behaviour a bit longer. We
-however expect to support setting this to `false` (to keep the current
-behaviour) only for a limited time after the default is changed to
-`true`.
+The default for this variable is `true`. You are discouraged to set it
+to `false` to keep the old behaviour a bit longer because support
+setting this to `false` will be removed in future releases without
+warning.
=20
 credential.helper::
 	Specify an external helper to be called when a username or
diff --git a/builtin/commit.c b/builtin/commit.c
index da67653..cd28081 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -423,15 +423,16 @@ static char *prepare_index(int argc, const char *=
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
 			if (i < active_nr) {
 				error(_("you intended to add \"%s\" but did not add it; not commit=
ting\n"
-					"hint: to commit all changes to tracked files, use \"commit -a\"\=
n"
-					"hint: to commit anyway without adding, set commit.ignoreIntentTo=
Add to true"),
+					"this behavior is deprecated, please set commit.ignoreIntentToAdd=
\n"
+					"to true or remove the configuration variable. See the configurat=
ion\n"
+					"variable documentation for more information."),
 				      active_cache[i]->name);
 				exit(128); /* die() */
 			}
@@ -1424,6 +1425,9 @@ int cmd_commit(int argc, const char **argv, const=
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
@@ -1583,5 +1587,14 @@ int cmd_commit(int argc, const char **argv, cons=
t char *prefix)
 	if (!quiet)
 		print_summary(prefix, sha1, !current_head);
=20
+	if (set_commit_ignoreintenttoadd) {
+		if (cache_tree_flags & WRITE_TREE_IGNORE_INTENT_TO_ADD)
+			warning(_("commit.ignoreIntentToAdd =3D true is not needed anymore.=
\n"
+				  "Please remove it."));
+		else
+			warning(_("commit.ignoreIntentToAdd =3D false is deprecated.\n"
+				  "Please see the commit.ignoreIntentToAdd documentation for\n"
+				  "more information and remove the configuration variable."));
+	}
 	return 0;
 }
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
