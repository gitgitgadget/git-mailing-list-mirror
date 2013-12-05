From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v4 15/28] fetch: add --update-shallow to accept refs that update .git/shallow
Date: Thu,  5 Dec 2013 20:02:42 +0700
Message-ID: <1386248575-10206-16-git-send-email-pclouds@gmail.com>
References: <1385351754-9954-1-git-send-email-pclouds@gmail.com>
 <1386248575-10206-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 05 13:59:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VoYX4-0002El-CJ
	for gcvg-git-2@plane.gmane.org; Thu, 05 Dec 2013 13:59:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756650Ab3LEM7u convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 5 Dec 2013 07:59:50 -0500
Received: from mail-pd0-f179.google.com ([209.85.192.179]:60510 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751299Ab3LEM7t (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Dec 2013 07:59:49 -0500
Received: by mail-pd0-f179.google.com with SMTP id r10so24472637pdi.24
        for <git@vger.kernel.org>; Thu, 05 Dec 2013 04:59:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=6vDyMQyEpIOq0PdYlGvZgMI37LqBe8XTlhNvABnM+Jw=;
        b=s4ybX4Wyt5jN/ugX32+bUkHTzFLobC7hVPAfiM2ADh3q5xb7PmWrXowRuzaRjM3qt9
         3I7uQwoGyINBLdQQYbRPhNZgO0liYNdvqv+KxFSRLWWfXiJIUY0KD9EiHLLhZ8408+hP
         j5ppro9hnjrw0zNnS5QSBdb7mgu+/TXXdH4r/Qvr4FIqynsTIJxbqfC9JgnIBmvsZRvB
         N8S0f5kFYZrn4TJP4B4CrDc1hhLZdf8d7ez7Mfvrbb3DJGLMuwmS7rmsuhmD3+9uB/rZ
         Xye1VsKI6wEBO51Y3pKdOObnEBugJjFpa/o9upD375Us7qbGxY3adReOcBX0CMScZ51F
         UsQw==
X-Received: by 10.68.225.9 with SMTP id rg9mr52823296pbc.122.1386248389405;
        Thu, 05 Dec 2013 04:59:49 -0800 (PST)
Received: from lanh ([115.73.194.163])
        by mx.google.com with ESMTPSA id pl1sm144610847pbb.20.2013.12.05.04.59.46
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 05 Dec 2013 04:59:48 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Thu, 05 Dec 2013 20:04:32 +0700
X-Mailer: git-send-email 1.8.5.1.25.g8667982
In-Reply-To: <1386248575-10206-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238871>

The same steps are done as in when --update-shallow is not given. The
only difference is we now add all shallow commits in "ours" and
"theirs" to .git/shallow (aka "step 8").

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/fetch-options.txt |  6 ++++++
 builtin/fetch.c                 |  6 +++++-
 fetch-pack.c                    | 27 +++++++++++++++++++++++++++
 fetch-pack.h                    |  1 +
 t/t5536-fetch-shallow.sh        | 32 ++++++++++++++++++++++++++++++++
 transport.c                     |  4 ++++
 transport.h                     |  4 ++++
 7 files changed, 79 insertions(+), 1 deletion(-)

diff --git a/Documentation/fetch-options.txt b/Documentation/fetch-opti=
ons.txt
index a83d2b4..54043e3 100644
--- a/Documentation/fetch-options.txt
+++ b/Documentation/fetch-options.txt
@@ -21,6 +21,12 @@
 If the source repository is shallow, fetch as much as possible so that
 the current repository has the same history as the source repository.
=20
+--update-shallow::
+	By default when fetching from a shallow repository,
+	`git fetch` refuses refs that require updating
+	.git/shallow. This option updates .git/shallow and accept such
+	refs.
+
 ifndef::git-pull[]
 --dry-run::
 	Show what would be done, without making any changes.
diff --git a/builtin/fetch.c b/builtin/fetch.c
index 7b41a7e..d2e4fc0 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -36,7 +36,7 @@ static int prune =3D -1; /* unspecified */
=20
 static int all, append, dry_run, force, keep, multiple, update_head_ok=
, verbosity;
 static int progress =3D -1, recurse_submodules =3D RECURSE_SUBMODULES_=
DEFAULT;
-static int tags =3D TAGS_DEFAULT, unshallow;
+static int tags =3D TAGS_DEFAULT, unshallow, update_shallow;
 static const char *depth;
 static const char *upload_pack;
 static struct strbuf default_rla =3D STRBUF_INIT;
@@ -104,6 +104,8 @@ static struct option builtin_fetch_options[] =3D {
 	{ OPTION_STRING, 0, "recurse-submodules-default",
 		   &recurse_submodules_default, NULL,
 		   N_("default mode for recursion"), PARSE_OPT_HIDDEN },
+	OPT_BOOL(0, "update-shallow", &update_shallow,
+		 N_("accept refs that update .git/shallow")),
 	OPT_END()
 };
=20
@@ -768,6 +770,8 @@ static struct transport *prepare_transport(struct r=
emote *remote)
 		set_option(transport, TRANS_OPT_KEEP, "yes");
 	if (depth)
 		set_option(transport, TRANS_OPT_DEPTH, depth);
+	if (update_shallow)
+		set_option(transport, TRANS_OPT_UPDATE_SHALLOW, "yes");
 	return transport;
 }
=20
diff --git a/fetch-pack.c b/fetch-pack.c
index 7c11aff..cd219b8 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -993,6 +993,33 @@ static void update_shallow(struct fetch_pack_args =
*args,
 		sha1_array_append(&ref, sought[i]->old_sha1);
 	si->ref =3D &ref;
=20
+	if (args->update_shallow) {
+		/*
+		 * remote is also shallow, .git/shallow may be updated
+		 * so all refs can be accepted. Make sure we only add
+		 * shallow roots that are actually reachable from new
+		 * refs.
+		 */
+		struct sha1_array extra =3D SHA1_ARRAY_INIT;
+		unsigned char (*sha1)[20] =3D si->shallow->sha1;
+		assign_shallow_commits_to_refs(si, NULL, NULL);
+		if (!si->nr_ours && !si->nr_theirs) {
+			sha1_array_clear(&ref);
+			return;
+		}
+		for (i =3D 0; i < si->nr_ours; i++)
+			sha1_array_append(&extra, sha1[si->ours[i]]);
+		for (i =3D 0; i < si->nr_theirs; i++)
+			sha1_array_append(&extra, sha1[si->theirs[i]]);
+		setup_alternate_shallow(&shallow_lock,
+					&alternate_shallow_file,
+					&extra);
+		commit_lock_file(&shallow_lock);
+		sha1_array_clear(&extra);
+		sha1_array_clear(&ref);
+		return;
+	}
+
 	/*
 	 * remote is also shallow, check what ref is safe to update
 	 * without updating .git/shallow
diff --git a/fetch-pack.h b/fetch-pack.h
index ce59537..ada02f5 100644
--- a/fetch-pack.h
+++ b/fetch-pack.h
@@ -23,6 +23,7 @@ struct fetch_pack_args {
 	unsigned check_self_contained_and_connected:1;
 	unsigned self_contained_and_connected:1;
 	unsigned cloning:1;
+	unsigned update_shallow:1;
 };
=20
 /*
diff --git a/t/t5536-fetch-shallow.sh b/t/t5536-fetch-shallow.sh
index 022cb2c..3ae9092 100755
--- a/t/t5536-fetch-shallow.sh
+++ b/t/t5536-fetch-shallow.sh
@@ -141,4 +141,36 @@ EOF
 	)
 '
=20
+test_expect_success 'fetch --update-shallow' '
+	(
+	cd shallow &&
+	git checkout master &&
+	commit 7 &&
+	git tag -m foo heavy-tag HEAD^ &&
+	git tag light-tag HEAD^:tracked
+	) &&
+	(
+	cd notshallow &&
+	git fetch --update-shallow ../shallow/.git refs/heads/*:refs/remotes/=
shallow/* &&
+	git fsck &&
+	git for-each-ref --sort=3Drefname --format=3D"%(refname)" >actual.ref=
s &&
+	cat <<EOF >expect.refs &&
+refs/remotes/shallow/master
+refs/remotes/shallow/no-shallow
+refs/tags/heavy-tag
+refs/tags/light-tag
+EOF
+	test_cmp expect.refs actual.refs &&
+	git log --format=3D%s shallow/master >actual &&
+	cat <<EOF >expect &&
+7
+6
+5
+4
+3
+EOF
+	test_cmp expect actual
+	)
+'
+
 test_done
diff --git a/transport.c b/transport.c
index 491360b..a09fdb6 100644
--- a/transport.c
+++ b/transport.c
@@ -477,6 +477,9 @@ static int set_git_option(struct git_transport_opti=
ons *opts,
 	} else if (!strcmp(name, TRANS_OPT_KEEP)) {
 		opts->keep =3D !!value;
 		return 0;
+	} else if (!strcmp(name, TRANS_OPT_UPDATE_SHALLOW)) {
+		opts->update_shallow =3D !!value;
+		return 0;
 	} else if (!strcmp(name, TRANS_OPT_DEPTH)) {
 		if (!value)
 			opts->depth =3D 0;
@@ -543,6 +546,7 @@ static int fetch_refs_via_pack(struct transport *tr=
ansport,
 	args.check_self_contained_and_connected =3D
 		data->options.check_self_contained_and_connected;
 	args.cloning =3D transport->cloning;
+	args.update_shallow =3D data->options.update_shallow;
=20
 	if (!data->got_remote_heads) {
 		connect_setup(transport, 0, 0);
diff --git a/transport.h b/transport.h
index 59842d4..02ea248 100644
--- a/transport.h
+++ b/transport.h
@@ -11,6 +11,7 @@ struct git_transport_options {
 	unsigned followtags : 1;
 	unsigned check_self_contained_and_connected : 1;
 	unsigned self_contained_and_connected : 1;
+	unsigned update_shallow : 1;
 	int depth;
 	const char *uploadpack;
 	const char *receivepack;
@@ -152,6 +153,9 @@ struct transport *transport_get(struct remote *, co=
nst char *);
 /* Aggressively fetch annotated tags if possible */
 #define TRANS_OPT_FOLLOWTAGS "followtags"
=20
+/* Accept refs that may update .git/shallow without --depth */
+#define TRANS_OPT_UPDATE_SHALLOW "updateshallow"
+
 /**
  * Returns 0 if the option was used, non-zero otherwise. Prints a
  * message to stderr if the option is not used.
--=20
1.8.5.1.25.g8667982
