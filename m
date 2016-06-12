From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 18/27] clone: define shallow clone boundary based on time with --shallow-since
Date: Sun, 12 Jun 2016 17:54:00 +0700
Message-ID: <20160612105409.22156-19-pclouds@gmail.com>
References: <20160610122714.3341-1-pclouds@gmail.com>
 <20160612105409.22156-1-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 12 12:56:25 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bC342-0003tO-LP
	for gcvg-git-2@plane.gmane.org; Sun, 12 Jun 2016 12:56:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753372AbcFLK4S convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 12 Jun 2016 06:56:18 -0400
Received: from mail-pa0-f68.google.com ([209.85.220.68]:35559 "EHLO
	mail-pa0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753351AbcFLK4P (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Jun 2016 06:56:15 -0400
Received: by mail-pa0-f68.google.com with SMTP id hf6so606222pac.2
        for <git@vger.kernel.org>; Sun, 12 Jun 2016 03:56:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=l1haUHVSmLGCVGnse4zeFmjoNAO0pKcACD9KME5XTo4=;
        b=EtYQbwNiDcU5GQYDTLybamkdwLLfgvRlG6CfD7D7cBDfXzxsvQiUVNYKymtq6zTSvk
         EywU9pRYw0mbXodGR7fO3+PrVkidQov2c3PKEyrYRwn7Vk2S4NQ5+zAwobmyn/odMBWq
         IKrzsiVWHV1R87WSSq1z+URIA2FLJEPXlZ9JdgQudtgPqqvQ50twq1nLg9nKYt3J9zuW
         f2nXpHV5ynd8OAs2iuv1zlv8Hcere7B1nqK0BASfamYxhxGNLDCZR9YRerBJN5JK10qN
         eW+MVj5/leQB4Myvg5T4HQYEZr1womkxNvYIcJWp6Pd+seN2CG/0/GCVfokQqHHP6WjX
         JRtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=l1haUHVSmLGCVGnse4zeFmjoNAO0pKcACD9KME5XTo4=;
        b=Jx+SDKJdEOjAxP1a0gQ4d6rqh9jbb3ZGE2YLq/v9N/vvLEWxplXV3fhoV5GyDbouFF
         I77+xuLeDjWx4EfbiJon5YAp7jiMT3xs0tix3xoWymyql1GEpnumpczex7XNDEnRWBWr
         DY1BMJw+raU0ANMRqyrvsXaCEiRT3N+4ICdndPbiugHyyBaWY8Tm5jYo5gpDamCrf1v2
         WpwOHuYxdvoANlvMkumk9JUsJXZdQbfpymLT9yfh8Y+AP50W76DLkrxR0Jb0/wPq98J3
         kruD6G+kMxTFcJh+HAz6fTtzLDPHVQk9aUc/67Y5UuktFGIt0Gs4smhO4rXMinHoe9m4
         4Z/g==
X-Gm-Message-State: ALyK8tKecSI6q8ECWSF031rUzz5spWk20aeuqpW230dd8DEpvbbCw7Un1NxW5ywr3b9Jrg==
X-Received: by 10.66.234.65 with SMTP id uc1mr14519936pac.81.1465728974345;
        Sun, 12 Jun 2016 03:56:14 -0700 (PDT)
Received: from ash ([115.76.211.1])
        by smtp.gmail.com with ESMTPSA id 4sm19522711pav.33.2016.06.12.03.56.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 12 Jun 2016 03:56:13 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Sun, 12 Jun 2016 17:56:09 +0700
X-Mailer: git-send-email 2.8.2.524.g6ff3d78
In-Reply-To: <20160612105409.22156-1-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297125>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git-clone.txt |  3 +++
 builtin/clone.c             | 16 +++++++++++++---
 2 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
index b7c467a..a410409 100644
--- a/Documentation/git-clone.txt
+++ b/Documentation/git-clone.txt
@@ -193,6 +193,9 @@ objects from the source repository into a pack in t=
he cloned repository.
 	`--no-single-branch` is given to fetch the histories near the
 	tips of all branches.
=20
+--shallow-since=3D<date>::
+	Create a shallow clone with a history after the specified time.
+
 --[no-]single-branch::
 	Clone only the history leading to the tip of a single branch,
 	either specified by the `--branch` option or the primary
diff --git a/builtin/clone.c b/builtin/clone.c
index bcba080..dc2ef4f 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -40,7 +40,8 @@ static const char * const builtin_clone_usage[] =3D {
=20
 static int option_no_checkout, option_bare, option_mirror, option_sing=
le_branch =3D -1;
 static int option_local =3D -1, option_no_hardlinks, option_shared, op=
tion_recursive;
-static char *option_template, *option_depth;
+static int deepen;
+static char *option_template, *option_depth, *option_since;
 static char *option_origin =3D NULL;
 static char *option_branch =3D NULL;
 static const char *real_git_dir;
@@ -86,6 +87,8 @@ static struct option builtin_clone_options[] =3D {
 		   N_("path to git-upload-pack on the remote")),
 	OPT_STRING(0, "depth", &option_depth, N_("depth"),
 		    N_("create a shallow clone of that depth")),
+	OPT_STRING(0, "shallow-since", &option_since, N_("time"),
+		    N_("create a shallow clone since a specific time")),
 	OPT_BOOL(0, "single-branch", &option_single_branch,
 		    N_("clone only one branch, HEAD or --branch")),
 	OPT_STRING(0, "separate-git-dir", &real_git_dir, N_("gitdir"),
@@ -849,8 +852,10 @@ int cmd_clone(int argc, const char **argv, const c=
har *prefix)
 		usage_msg_opt(_("You must specify a repository to clone."),
 			builtin_clone_usage, builtin_clone_options);
=20
+	if (option_depth || option_since)
+		deepen =3D 1;
 	if (option_single_branch =3D=3D -1)
-		option_single_branch =3D option_depth ? 1 : 0;
+		option_single_branch =3D deepen ? 1 : 0;
=20
 	if (option_mirror)
 		option_bare =3D 1;
@@ -976,6 +981,8 @@ int cmd_clone(int argc, const char **argv, const ch=
ar *prefix)
 	if (is_local) {
 		if (option_depth)
 			warning(_("--depth is ignored in local clones; use file:// instead.=
"));
+		if (option_since)
+			warning(_("--shallow-since is ignored in local clones; use file:// =
instead."));
 		if (!access(mkpath("%s/shallow", path), F_OK)) {
 			if (option_local > 0)
 				warning(_("source repository is shallow, ignoring --local"));
@@ -994,6 +1001,9 @@ int cmd_clone(int argc, const char **argv, const c=
har *prefix)
 	if (option_depth)
 		transport_set_option(transport, TRANS_OPT_DEPTH,
 				     option_depth);
+	if (option_since)
+		transport_set_option(transport, TRANS_OPT_DEEPEN_SINCE,
+				     option_since);
 	if (option_single_branch)
 		transport_set_option(transport, TRANS_OPT_FOLLOWTAGS, "1");
=20
@@ -1001,7 +1011,7 @@ int cmd_clone(int argc, const char **argv, const =
char *prefix)
 		transport_set_option(transport, TRANS_OPT_UPLOADPACK,
 				     option_upload_pack);
=20
-	if (transport->smart_options && !option_depth)
+	if (transport->smart_options && !deepen)
 		transport->smart_options->check_self_contained_and_connected =3D 1;
=20
 	refs =3D transport_get_remote_refs(transport);
--=20
2.8.2.524.g6ff3d78
