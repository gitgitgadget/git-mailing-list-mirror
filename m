From: =?utf-8?q?Santi=20B=C3=A9jar?= <sbejar@gmail.com>
Subject: [PATCHv4 4/4] user.warnautomatic: add config to control if the committer ident is shown
Date: Sun,  4 May 2008 18:04:52 +0200
Message-ID: <1209917092-12146-5-git-send-email-sbejar@gmail.com>
References: <1209917092-12146-1-git-send-email-sbejar@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?q?Santi=20B=C3=A9jar?= <sbejar@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 04 18:06:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JsgjH-0007JP-95
	for gcvg-git-2@gmane.org; Sun, 04 May 2008 18:06:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752097AbYEDQFb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 4 May 2008 12:05:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752076AbYEDQFb
	(ORCPT <rfc822;git-outgoing>); Sun, 4 May 2008 12:05:31 -0400
Received: from fg-out-1718.google.com ([72.14.220.159]:56874 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751876AbYEDQFa (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 May 2008 12:05:30 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1618419fgg.17
        for <git@vger.kernel.org>; Sun, 04 May 2008 09:05:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references:mime-version:content-type:content-transfer-encoding;
        bh=80YMidVlDugh6oMbLFkNrRHE3n925dBDoGyoVlyIFUU=;
        b=v8cd7hyipAqvH7v1U9WgXRuQseVX8uMxg5dH1GNbi4a3ZyDvxbuoh5tZ4F5qdnsfPWD8bzuIUTf/Mhs9kizzIc7W0XDlrPX/ChphXdCHG2NTSmTZyKFJWH5hzwjnfbr1f3+nxOneWpC5eoR73M1F6/j8PQGd7hrHZ1W78XI6P6Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references:mime-version:content-type:content-transfer-encoding;
        b=SjrRGUR2dApmkJOuzUvkw0X6SFOmvUo6nsheZFl1KIIJoB/x9HQVjCsSVgoa7SzDZX682kPdkLMGNKqCYXL4jBPNGUjTXbHndZ5YyolHXfR12xElmQQ+iG1iutbpVS+kz2XCH6YyT8GXthRuJEZ+wvtF5YFk4nRP5pfnYxXBBTU=
Received: by 10.86.90.2 with SMTP id n2mr4461902fgb.51.1209917129949;
        Sun, 04 May 2008 09:05:29 -0700 (PDT)
Received: from localhost ( [91.13.106.248])
        by mx.google.com with ESMTPS id 3sm4593997fge.3.2008.05.04.09.05.27
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 04 May 2008 09:05:28 -0700 (PDT)
X-Mailer: git-send-email 1.5.5.1.224.gadb29
In-Reply-To: <1209917092-12146-1-git-send-email-sbejar@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81180>


Signed-off-by: Santi B=C3=A9jar <sbejar@gmail.com>
---
 Documentation/config.txt |    4 ++++
 builtin-commit.c         |    2 +-
 cache.h                  |    1 +
 config.c                 |    5 +++++
 environment.c            |    1 +
 t/t7502-commit.sh        |   15 +++++++++++++--
 6 files changed, 25 insertions(+), 3 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 824e416..9c770a6 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -994,6 +994,10 @@ user.signingkey::
 	unchanged to gpg's --local-user parameter, so you may specify a key
 	using any method that gpg supports.
=20
+user.warnautomatic::
+	A boolean to show the committer ident while committing in the editor
+	if it is set automatically. Defaults to true.
+
 whatchanged.difftree::
 	The default linkgit:git-diff-tree[1] arguments to be used
 	for linkgit:git-whatchanged[1].
diff --git a/builtin-commit.c b/builtin-commit.c
index 353f9c7..381e3c8 100644
--- a/builtin-commit.c
+++ b/builtin-commit.c
@@ -566,7 +566,7 @@ static int prepare_to_commit(const char *index_file=
, const char *prefix)
 				showed_ident++ ? "" : "#\n",
 				author_ident);
=20
-		if (!user_explicit)
+		if (!user_explicit && user_warnautomatic)
 			fprintf(fp,
 				"%s"
 				"# Committer: %s\n",
diff --git a/cache.h b/cache.h
index e8b26cf..5d0dd23 100644
--- a/cache.h
+++ b/cache.h
@@ -719,6 +719,7 @@ extern int config_error_nonbool(const char *);
 extern char git_default_email[MAX_GITNAME];
 extern char git_default_name[MAX_GITNAME];
 extern int user_explicit;
+extern int user_warnautomatic;
=20
 extern const char *git_commit_encoding;
 extern const char *git_log_output_encoding;
diff --git a/config.c b/config.c
index e49804a..1588053 100644
--- a/config.c
+++ b/config.c
@@ -457,6 +457,11 @@ int git_default_config(const char *var, const char=
 *value)
 		return 0;
 	}
=20
+	if (!strcmp(var, "user.warnautomatic")) {
+		user_warnautomatic =3D git_config_bool(var, value);
+		return 0;
+	}
+
 	if (!strcmp(var, "i18n.commitencoding"))
 		return git_config_string(&git_commit_encoding, var, value);
=20
diff --git a/environment.c b/environment.c
index b941971..6b6ede6 100644
--- a/environment.c
+++ b/environment.c
@@ -12,6 +12,7 @@
 char git_default_email[MAX_GITNAME];
 char git_default_name[MAX_GITNAME];
 int user_explicit =3D 0;
+int user_warnautomatic =3D 1;
 int trust_executable_bit =3D 1;
 int quote_path_fully =3D 1;
 int has_symlinks =3D 1;
diff --git a/t/t7502-commit.sh b/t/t7502-commit.sh
index 018060c..a63f9c4 100755
--- a/t/t7502-commit.sh
+++ b/t/t7502-commit.sh
@@ -166,14 +166,25 @@ test_expect_success 'author different from commit=
ter' '
 	test_cmp expect actual
 '
=20
+unset GIT_COMMITTER_EMAIL
+unset GIT_COMMITTER_NAME
+
+test_expect_success 'committer is automatic but user.warnautomatic=3Dn=
o' '
+
+	git config user.warnautomatic no
+	echo >>negative &&
+	git commit -e -m "sample"
+	head -n 7 .git/COMMIT_EDITMSG >actual &&
+	test_cmp expect actual
+'
+
 sed -i '$d' expect
 echo "# Committer:
 #" >> expect
-unset GIT_COMMITTER_EMAIL
-unset GIT_COMMITTER_NAME
=20
 test_expect_success 'committer is automatic' '
=20
+	git config --unset user.warnautomatic
 	echo >>negative &&
 	git commit -e -m "sample"
 	head -n 8 .git/COMMIT_EDITMSG |	\
--=20
1.5.5.1.224.gadb29
