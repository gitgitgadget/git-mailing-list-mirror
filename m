From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 24/34] checkout: reject if the branch is already checked
 out elsewhere
Date: Mon, 1 Dec 2014 17:38:18 +0700
Message-ID: <20141201103818.GA20429@lanh>
References: <1417335899-27307-1-git-send-email-pclouds@gmail.com>
 <1417335899-27307-25-git-send-email-pclouds@gmail.com>
 <547B5170.6050206@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Mark Levedahl <mlevedahl@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 01 11:38:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XvON7-0004px-Tc
	for gcvg-git-2@plane.gmane.org; Mon, 01 Dec 2014 11:38:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753089AbaLAKiV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 1 Dec 2014 05:38:21 -0500
Received: from mail-pd0-f175.google.com ([209.85.192.175]:41528 "EHLO
	mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753060AbaLAKiS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Dec 2014 05:38:18 -0500
Received: by mail-pd0-f175.google.com with SMTP id y10so10659755pdj.34
        for <git@vger.kernel.org>; Mon, 01 Dec 2014 02:38:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=sfROdlKd3+FI7amJlMBRLw68gIqr/u9dmVX9nUe0ps4=;
        b=MqGmBhmYjGNP0+c0M3nccjIZiuOsBTNjIBqYBB/yE8h0feGbM7NM5VqrMLLdkAc7mw
         v9dip9IQUTnzJMVmp9xNHgo2FQIB5POKJGyyTyrspwr+oo5uABXe+l8hqU0toSi5wLBD
         zknkCGXYEyoDml1LTuKP7A/ZXAcoFfeonLZGOIZxnZBa8iGlcu0llpOuYvbJ9tc45/GS
         U0hXOnRAQ8fHlFSNW98+MQXL5vzbqo6gfcSalQn/YVtPaFnoYO/nu81GsKjp6Fiunceo
         v8bfmMSVupb4FZ0hq+yuv4ZvKbuge4qEt7YOH/B57Dk+ZnHxcC3XkI6LE3m3cdItoZqq
         /9BA==
X-Received: by 10.68.95.3 with SMTP id dg3mr17518016pbb.12.1417430298132;
        Mon, 01 Dec 2014 02:38:18 -0800 (PST)
Received: from lanh ([115.73.247.22])
        by mx.google.com with ESMTPSA id ko4sm17254214pdb.31.2014.12.01.02.38.15
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Dec 2014 02:38:17 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Mon, 01 Dec 2014 17:38:18 +0700
Content-Disposition: inline
In-Reply-To: <547B5170.6050206@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260478>

On Sun, Nov 30, 2014 at 12:18:40PM -0500, Mark Levedahl wrote:
> On 11/30/2014 03:24 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wro=
te:
> > One branch obviously can't be checked out at two places (but detach=
ed
> > heads are ok). Give the user a choice in this case: --detach, -b
> > new-branch, switch branch in the other checkout first or simply 'cd=
'
> > and continue to work there.
> >
>=20
> This seems too restrictive and is not "obvious" to me: I currently us=
e=20
> git-new-workdir to have multiple checkouts of the same branch, with n=
o=20
> ill effect. While those who do not understand what is going on=20
> underneath might be confused by one checkout suddenly showing=20
> uncommitted diffs, I don't accept that as a reason to outright preven=
t=20
> such use. I suggest, at the very least, that this behavior be overrid=
den=20
> by a --force flag?

Prevention is a strong word. It's more about safety for the mere
mortals. It's certainly possible to do something like this patch
(--force can't be reused, it already carries some other meaning).
Should I add this one in the next (hic) reroll?

-- 8< --
Subject: [PATCH] checkout: add --ignore-other-wortrees

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/git-checkout.txt |  6 ++++++
 builtin/checkout.c             | 19 +++++++++++--------
 t/t2025-checkout-to.sh         |  7 +++++++
 3 files changed, 24 insertions(+), 8 deletions(-)

diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkou=
t.txt
index 0c13825..71d9e4e 100644
--- a/Documentation/git-checkout.txt
+++ b/Documentation/git-checkout.txt
@@ -232,6 +232,12 @@ section of linkgit:git-add[1] to learn how to oper=
ate the `--patch` mode.
 	specific files such as HEAD, index... See "MULTIPLE WORKING
 	TREES" section for more information.
=20
+--ignore-other-worktrees::
+	`git checkout` refuses when the wanted ref is already checked out
+	by another worktree. This option makes it check the
+	ref out anyway. In other words, the ref is held by more than one
+	worktree.
+
 <branch>::
 	Branch to checkout; if it refers to a branch (i.e., a name that,
 	when prepended with "refs/heads/", is a valid ref), then that
diff --git a/builtin/checkout.c b/builtin/checkout.c
index 953b763..8b2bf20 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -37,6 +37,7 @@ struct checkout_opts {
 	int writeout_stage;
 	int overwrite_ignore;
 	int ignore_skipworktree;
+	int ignore_other_worktrees;
=20
 	const char *new_branch;
 	const char *new_branch_force;
@@ -1079,11 +1080,12 @@ static void check_linked_checkouts(struct branc=
h_info *new)
 static int parse_branchname_arg(int argc, const char **argv,
 				int dwim_new_local_branch_ok,
 				struct branch_info *new,
-				struct tree **source_tree,
-				unsigned char rev[20],
-				const char **new_branch,
-				int force_detach)
+				struct checkout_opts *opts,
+				unsigned char rev[20])
 {
+	struct tree **source_tree =3D &opts->source_tree;
+	const char **new_branch =3D &opts->new_branch;
+	int force_detach =3D opts->force_detach;
 	int argcount =3D 0;
 	unsigned char branch_rev[20];
 	const char *arg;
@@ -1209,7 +1211,8 @@ static int parse_branchname_arg(int argc, const c=
har **argv,
 		int flag;
 		char *head_ref =3D resolve_refdup("HEAD", 0, sha1, &flag);
 		if (head_ref &&
-		    (!(flag & REF_ISSYMREF) || strcmp(head_ref, new->path)))
+		    (!(flag & REF_ISSYMREF) || strcmp(head_ref, new->path)) &&
+		    !opts->ignore_other_worktrees)
 			check_linked_checkouts(new);
 		free(head_ref);
 	}
@@ -1340,6 +1343,8 @@ int cmd_checkout(int argc, const char **argv, con=
st char *prefix)
 				N_("second guess 'git checkout no-such-branch'")),
 		OPT_FILENAME(0, "to", &opts.new_worktree,
 			   N_("check a branch out in a separate working directory")),
+		OPT_BOOL(0, "ignore-other-worktrees", &opts.ignore_other_worktrees,
+			 N_("do not check if another worktree is holding the given ref")),
 		OPT_END(),
 	};
=20
@@ -1420,9 +1425,7 @@ int cmd_checkout(int argc, const char **argv, con=
st char *prefix)
 			opts.track =3D=3D BRANCH_TRACK_UNSPECIFIED &&
 			!opts.new_branch;
 		int n =3D parse_branchname_arg(argc, argv, dwim_ok,
-					     &new, &opts.source_tree,
-					     rev, &opts.new_branch,
-					     opts.force_detach);
+					     &new, &opts, rev);
 		argv +=3D n;
 		argc -=3D n;
 	}
diff --git a/t/t2025-checkout-to.sh b/t/t2025-checkout-to.sh
index 915b506..f8e4df4 100755
--- a/t/t2025-checkout-to.sh
+++ b/t/t2025-checkout-to.sh
@@ -79,6 +79,13 @@ test_expect_success 'die the same branch is already =
checked out' '
 	)
 '
=20
+test_expect_success 'not die the same branch is already checked out' '
+	(
+		cd here &&
+		git checkout --ignore-other-worktrees --to anothernewmaster newmaste=
r
+	)
+'
+
 test_expect_success 'not die on re-checking out current branch' '
 	(
 		cd there &&
--=20
2.2.0.60.gb7b3c64

-- 8< --
