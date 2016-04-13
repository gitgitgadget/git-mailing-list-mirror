From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 17/26] clone: define shallow clone boundary based on time with --shallow-since
Date: Wed, 13 Apr 2016 19:55:01 +0700
Message-ID: <1460552110-5554-18-git-send-email-pclouds@gmail.com>
References: <1460552110-5554-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 13 14:56:54 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aqKLk-0004V8-HG
	for gcvg-git-2@plane.gmane.org; Wed, 13 Apr 2016 14:56:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030824AbcDMM4p convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 13 Apr 2016 08:56:45 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:35998 "EHLO
	mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030810AbcDMM4n (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Apr 2016 08:56:43 -0400
Received: by mail-pf0-f195.google.com with SMTP id q129so4050439pfb.3
        for <git@vger.kernel.org>; Wed, 13 Apr 2016 05:56:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TW3HYhEgXo9EWsIdHb3w8keh5GWZHHilBpMFXe6nEXA=;
        b=zNmKuybJDJQ1l8fiD5tdpFce1rFdw/bSpKnho7M4U2zhVJQ6vxRGVvcMELJV/MdnHA
         RHJ+9Z8aSx4nO9Nwx5Qsc31R0VK8E7TvpbohQq71weQHPJfyQnec1X+hlYuw1j7j/osi
         YsOCFoZUlj/xofkOnKPb6phVE4H+R+qo91t44gA1bydp3S6TVoVAP2GY5pH3aZKaCGaa
         tQUg+n1OrhjzmdnPVHBXxG6fjWQdjNWgDk6N0l41/dhfExWLvXlJ8BxUJYt5I4zHiWSG
         IhCwW1WqB9N8ywU1hQuudDQIkMOo372nmsUY2yFuKfS9eRfwD6YhuJgmnuo13SuA6WiP
         EDJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TW3HYhEgXo9EWsIdHb3w8keh5GWZHHilBpMFXe6nEXA=;
        b=XHTNw26xaKJLBImR6Br/77ilw4nPYAFk5rLpzAGjbxWEBauq/rzXZPzUfLpO8zEKV3
         JYUgW4wvLU781Y45R8glOhRmQrSFiAX5N8xaZKF0h3gp+r+VWD0kl7Rvl83vmFTTTm66
         111DcV+xWQINVK5tlV+SfzO6eO958wBE0NKqv8OcHDS0Ei1JUvq+fj98uY0MIykMGCQT
         AVa7ehBVSlt/RxZOhSTc3KKmJpZFFoWhvvrX1Ik2fp786R4z/FMgI7/63JezkXUbTPKC
         jJ2ANYjGJtb/GQpWyvu0Out57F1zv6Ncb7x9hZiOdrK7/t8flKE8OZSOV7YxDwoeZ8oX
         n+KA==
X-Gm-Message-State: AOPr4FXl3D6JBqgitAMf/DZs0VQYDiJ2v5Le3ERyGhnvLMYYIk4mx7jMaAugzVglvs5t9Q==
X-Received: by 10.98.10.147 with SMTP id 19mr12712444pfk.87.1460552202569;
        Wed, 13 Apr 2016 05:56:42 -0700 (PDT)
Received: from lanh ([115.76.233.41])
        by smtp.gmail.com with ESMTPSA id d19sm50997516pfj.92.2016.04.13.05.56.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Apr 2016 05:56:41 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Wed, 13 Apr 2016 19:56:48 +0700
X-Mailer: git-send-email 2.8.0.rc0.210.gd302cd2
In-Reply-To: <1460552110-5554-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291410>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
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
2.8.0.rc0.210.gd302cd2
