Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CD1CF20281
	for <e@80x24.org>; Thu,  5 Oct 2017 12:19:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751702AbdJEMTb (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Oct 2017 08:19:31 -0400
Received: from mout.gmx.net ([212.227.17.22]:64730 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751667AbdJEMT2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Oct 2017 08:19:28 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MXqV1-1dlYmp24Yx-00WkWz; Thu, 05
 Oct 2017 14:19:16 +0200
Date:   Thu, 5 Oct 2017 14:19:15 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     J Wyman <jwyman@microsoft.com>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 2/3] for-each-ref: let upstream/push optionally remote
 ref name
In-Reply-To: <cover.1507205895.git.johannes.schindelin@gmx.de>
Message-ID: <7da6c7e2563d14cb7cd7ff2637c79c51896a9788.1507205895.git.johannes.schindelin@gmx.de>
References: <cover.1506952571.git.johannes.schindelin@gmx.de> <cover.1507205895.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:pgKyKSWJtDn+uKZH+R+bP4EL//VINYM0SqGZbBbamK21QAVS416
 kUciUxTnVhivk7gfdlXZFNIFW1bo5nMmnRJ91RVD9BkLqHo5HwBTBemUEKuZCoAHEeGRPO/
 Vpb8DTAwtfwVQPo6efjMq07FqR/dELx1H5pEP3mRkmyIN54Q8Ph5LUoyE1ycIWNCdlAHhPu
 fAcdWvvR7geFtuZmp87KQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:S380FNFOFkc=:zlLogQznLifGOL0Oo1BmPj
 T2GCK/Q5DTj77DnqVRUpmjn3l9dc8EFDN3cjlMldinGMwxpOHYt+r/TZfZ3QBXQ4hCkt1Bmyc
 o9tkAzoHYeHrnoRtY9h2OUfVpFRIEithmc7Na6C0Hi0jO+NEnAamRH2mAXgCtzdNA7mgzXP+g
 9cab0iA/GHgTyVr4DZ4bY4dpzJJM6W9eA+MHuEvNyGpTdls/fGuKFPTLiMoj87WSoBhwzECtE
 iNbKPYDCV7PhWTzE1uUiF5KZasAaGngy7xEr46BowNPtIUxUXxrEzXehJmHzjSItJESNBYzef
 0OtdOTsp0c/M+OUzA8miTHRYHImtOkMWhgd0nJa7PLiRNqRaLJEjj1qyDuDytmC8i+e+HrMq1
 rzW3az7WIubgmBqrVDTMMPrLQdRA7WAvqmQa0WGTg4Zh4ECa0iehSjj7E4VYf2mhSaWRyDFuJ
 NuoavPWNkOY4N5cIURiTyNDfhR8HjdbZpdC8zn5PmykIfVuHtxM/e4yzmKJPHPa9tZEd+mwa3
 mrHjoS8LCu07DO4ZD7kEhGq8AfJ4eH2LvfjXa1D42qO+Z4K1dRHh/GtyShCNzSKr3PfRy1HAk
 6Bio3t7A/GeNiS4fNCHsyxG919AEBRVIIEM00Ov9OLqUobsY3VaMcdOdP6Nt9eUu7fZbYIPKt
 9iUV+NPprVeoMExnOjdYUtmBl8ylLnROdXAM0z+HFKBiuI/fDAzpz/tvoQCtfSdgeAU985hLZ
 iGxuVQ+MRHyrXa4K9YW3BSHlabcSX5O96jDOs/YgxUYQUF/VSro3DBqjXWX9bgYsTSSLidFyz
 wk6pdzQOR0gIv3gVOSdeVr0/lPn8dzM1ZLx/o5Mf+DwWDvOXFg=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: J Wyman <jwyman@microsoft.com>

There are times when scripts want to know not only the name of the
push branch on the remote, but also the name of the branch as known
by the remote repository.

An example of this is when a tool wants to push to the very same branch
from which it would pull automatically, i.e. the `<remote>` and the `<to>`
in `git push <remote> <from>:<to>` would be provided by
`%(upstream:remotename)` and `%(upstream:remoteref)`, respectively.

This patch offers the new suffix :remoteref for the `upstream` and `push`
atoms, allowing to show exactly that. Example:

	$ cat .git/config
	...
	[remote "origin"]
		url = https://where.do.we.come/from
		fetch = refs/heads/*:refs/remote/origin/*
	[branch "master"]
		remote = origin
		merge = refs/heads/master
	[branch "develop/with/topics"]
		remote = origin
		merge = refs/heads/develop/with/topics
	...

	$ git for-each-ref \
		--format='%(push) %(push:remoteref)' \
		refs/heads
	refs/remotes/origin/master refs/heads/master
	refs/remotes/origin/develop/with/topics refs/heads/develop/with/topics

Signed-off-by: J Wyman <jwyman@microsoft.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Documentation/git-for-each-ref.txt | 11 ++++++-----
 ref-filter.c                       | 13 ++++++++++++-
 remote.c                           | 30 ++++++++++++++++++++++++++++++
 remote.h                           |  2 ++
 4 files changed, 50 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
index 39f50bd53eb..22767025850 100644
--- a/Documentation/git-for-each-ref.txt
+++ b/Documentation/git-for-each-ref.txt
@@ -142,8 +142,9 @@ upstream::
 	encountered. Append `:track,nobracket` to show tracking
 	information without brackets (i.e "ahead N, behind M").
 +
-Also respects `:remotename` to state the name of the *remote* instead of
-the ref.
+Also respects `:remotename` to state the name of the *remote* instead
+of the ref, and `:remoteref` to state the name of the *reference* as
+locally known by the remote.
 +
 Has no effect if the ref does not have tracking information associated
 with it.  All the options apart from `nobracket` are mutually exclusive,
@@ -152,9 +153,9 @@ but if used together the last option is selected.
 push::
 	The name of a local ref which represents the `@{push}`
 	location for the displayed ref. Respects `:short`, `:lstrip`,
-	`:rstrip`, `:track`, `:trackshort` and `:remotename` options as
-	`upstream` does. Produces an empty string if no `@{push}` ref is
-	configured.
+	`:rstrip`, `:track`, `:trackshort`, `:remotename`, and `:remoteref`
+	options as `upstream` does. Produces an empty string if no `@{push}`
+	ref is configured.
 
 HEAD::
 	'*' if HEAD matches current ref (the checked out branch), ' '
diff --git a/ref-filter.c b/ref-filter.c
index 4819707d032..b4b2c9b2190 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -77,7 +77,7 @@ static struct used_atom {
 		struct align align;
 		struct {
 			enum {
-				RR_REF, RR_TRACK, RR_TRACKSHORT, RR_REMOTE_NAME
+				RR_REF, RR_TRACK, RR_TRACKSHORT, RR_REMOTE_NAME, RR_REMOTE_REF
 			} option;
 			struct refname_atom refname;
 			unsigned int nobracket : 1, push : 1, push_remote : 1;
@@ -164,6 +164,9 @@ static void remote_ref_atom_parser(const struct ref_format *format, struct used_
 		else if (!strcmp(s, "remotename")) {
 			atom->u.remote_ref.option = RR_REMOTE_NAME;
 			atom->u.remote_ref.push_remote = 1;
+		} else if (!strcmp(s, "remoteref")) {
+			atom->u.remote_ref.option = RR_REMOTE_REF;
+			atom->u.remote_ref.push_remote = 1;
 		} else {
 			atom->u.remote_ref.option = RR_REF;
 			refname_atom_parser_internal(&atom->u.remote_ref.refname,
@@ -1262,6 +1265,14 @@ static void fill_remote_ref_details(struct used_atom *atom, const char *refname,
 			*s = xstrdup(remote);
 		else
 			*s = "";
+	} else if (atom->u.remote_ref.option == RR_REMOTE_REF) {
+		int explicit, for_push = starts_with(atom->name, "push");
+		const char *merge = remote_ref_for_branch(branch, for_push,
+							  &explicit);
+		if (explicit)
+			*s = xstrdup(merge);
+		else
+			*s = "";
 	} else
 		die("BUG: unhandled RR_* enum");
 }
diff --git a/remote.c b/remote.c
index b220f0dfc61..2bdcfc280cd 100644
--- a/remote.c
+++ b/remote.c
@@ -675,6 +675,36 @@ const char *pushremote_for_branch(struct branch *branch, int *explicit)
 	return remote_for_branch(branch, explicit);
 }
 
+const char *remote_ref_for_branch(struct branch *branch, int for_push,
+				  int *explicit)
+{
+	if (branch) {
+		if (!for_push) {
+			if (branch->merge_nr) {
+				if (explicit)
+					*explicit = 1;
+				return branch->merge_name[0];
+			}
+		} else {
+			const char *dst, *remote_name =
+				pushremote_for_branch(branch, NULL);
+			struct remote *remote = remote_get(remote_name);
+
+			if (remote && remote->push_refspec_nr &&
+			    (dst = apply_refspecs(remote->push,
+						  remote->push_refspec_nr,
+						  branch->refname))) {
+				if (explicit)
+					*explicit = 1;
+				return dst;
+			}
+		}
+	}
+	if (explicit)
+		*explicit = 0;
+	return "";
+}
+
 static struct remote *remote_get_1(const char *name,
 				   const char *(*get_default)(struct branch *, int *))
 {
diff --git a/remote.h b/remote.h
index 2ecf4c8c74c..1f6611be214 100644
--- a/remote.h
+++ b/remote.h
@@ -223,6 +223,8 @@ struct branch {
 struct branch *branch_get(const char *name);
 const char *remote_for_branch(struct branch *branch, int *explicit);
 const char *pushremote_for_branch(struct branch *branch, int *explicit);
+const char *remote_ref_for_branch(struct branch *branch, int for_push,
+				  int *explicit);
 
 int branch_has_merge_config(struct branch *branch);
 int branch_merge_matches(struct branch *, int n, const char *);
-- 
2.14.2.windows.1.2.gdc85205db4d


