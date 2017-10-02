Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 686BB20281
	for <e@80x24.org>; Mon,  2 Oct 2017 13:57:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751101AbdJBN5z (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Oct 2017 09:57:55 -0400
Received: from mout.gmx.net ([212.227.15.15]:54799 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751036AbdJBN5y (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Oct 2017 09:57:54 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MCLQ1-1e87uk0801-009BdZ; Mon, 02
 Oct 2017 15:57:47 +0200
Date:   Mon, 2 Oct 2017 15:57:46 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     J Wyman <jwyman@microsoft.com>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/3] for-each-ref: let upstream/push optionally report merge
 name.
In-Reply-To: <cover.1506952571.git.johannes.schindelin@gmx.de>
Message-ID: <f615fcc05fa358b4c7e3531cbdbd91661be321aa.1506952571.git.johannes.schindelin@gmx.de>
References: <cover.1506952571.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:rE46LVJfPku+1PYP7w43P0aarj7X4v7uNbqj8OdByvbus1gXj25
 moLDjSNyscgzrBy/rWrleorbz1oFXQiz9mTeGx39ytyH38jMLssfa/PZfc7TBNFjfW+gVqV
 z+Rp+UHnKX3iCMAYTtjD8NkqDq499pnt8Eu4cIbL34DNRtCpbVRdBgTUegfGGs8JA19vqSi
 qeyYgUdYpw/Krvy1dNQSg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:vUICU8QeKTc=:FkuneC8gqKWFDJxvKbDg+8
 s0IDtQrPqeZHtNV1zQObY8aGzv1H0X3BFO6kZpFjPJ2N4dG0EN9xUy3M/V30gqhLAljh0XG83
 EBUOhZ9hsXrhEZKAf/Qpm6064wi4+cM1NOLqnGV1mf+pzbUB3KPmhYx7AGKPPid3uzYIFMBFj
 N8s/Q0RmuqabQazWu/S20HxT9ik/B+6ZF+Q8DsHebYLaUKe5FdEkP2sJf6bbef7dZGUSJgBsS
 LCIPicSIx4ywR7IakKWWglnPKBvuF/Hw8sjrD242gm9HSpdfMWojsIgjZ6Fd9c78Nawry0ICc
 mmeaP4BeK0tKnRbDfsqeQNikh5F76uiNjty1wKegKdmKRCXZwoJFacv7i8ZmOWQGTBHEbSNDN
 tuAsgSZZopigmhbEsAUvOegvkO6p5ga+ucTflZO7/whIOdtWbKRu+5GjG6XWoMBEsl+2PIz6o
 fXJGrb/zKREMaBxNIt1yOzLDgPPPf5pVkAU5Bfj8BWAVK5KBfU+EO/Q6oPqiLgP0poCjGKd7b
 qqybIwE4Gy6zRKwU+wBDxoGpdhnWAMXUv4KuXLD/oBeOwgCbXMdRbkh6JqvW4NeD77qo5maDA
 SQzwfGWAD+6jzjUNq35K4Iid3pbJRXxFurf76EhLeCB0drIeovRVKsqRIpftzxu6pCi9EkBrH
 xkgA6aAYMLAOtUz9GxsanMuN2Yxq0muMaeFovCMvEV3KajHZHeGNEawAHZXoCDm7FT/+rliJI
 pkk0xWfsG7tzt/4oisq0yaKVZpkcj36MieRSSFsUagprjVRAZBK/Sl+Kwnw3EDCIW9BdK7eZP
 INP06EK9eDUQ56TzFyPasC30Ok6QCpd+xoD1sZ9JCiHvkagfm4=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: J Wyman <jwyman@microsoft.com>

There are times when scripts want to know not only the name of the
push branch on the remote, but also the name of the branch as known
by the remote repository.

A useful example of this is with the push command where
`branch.<name>.merge` is useful as the <to> value. Example:

	$ git push <remote> <from>:<to>

This patch offers the new suffix :merge for the push atom, allowing to
show exactly that. Example:

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
		--format='%(push) %(push:remote-ref)' \
		refs/heads
	refs/remotes/origin/master refs/heads/master
	refs/remotes/origin/develop/with/topics refs/heads/develop/with/topics
---
 Documentation/git-for-each-ref.txt | 11 ++++++-----
 ref-filter.c                       | 12 +++++++++++-
 remote.c                           | 30 ++++++++++++++++++++++++++++++
 remote.h                           |  2 ++
 4 files changed, 49 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
index 776368ee531..ba1147a1223 100644
--- a/Documentation/git-for-each-ref.txt
+++ b/Documentation/git-for-each-ref.txt
@@ -141,8 +141,9 @@ upstream::
 	also prints "[gone]" whenever unknown upstream ref is
 	encountered. Append `:track,nobracket` to show tracking
 	information without brackets (i.e "ahead N, behind M").  Also
-	respects `:remote-name` to state the name of the *remote* instead of
-	the ref.
+	respects `:remote-name` to state the name of the *remote* instead
+	of the ref, and `:remote-ref` to state the name of the *reference*
+	as locally known by the remote.
 +
 Has no effect if the ref does not have tracking information associated
 with it.  All the options apart from `nobracket` are mutually exclusive,
@@ -151,9 +152,9 @@ but if used together the last option is selected.
 push::
 	The name of a local ref which represents the `@{push}`
 	location for the displayed ref. Respects `:short`, `:lstrip`,
-	`:rstrip`, `:track`, `:trackshort` and `:remote-name` options as
-	`upstream` does. Produces an empty string if no `@{push}` ref is
-	configured.
+	`:rstrip`, `:track`, `:trackshort`, `:remote-name`, and `:remote-ref`
+	options as `upstream` does. Produces an empty string if no `@{push}`
+	ref is configured.
 
 HEAD::
 	'*' if HEAD matches current ref (the checked out branch), ' '
diff --git a/ref-filter.c b/ref-filter.c
index 58d53c09390..4401e573b8a 100644
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
 			unsigned int nobracket : 1;
@@ -160,6 +160,8 @@ static void remote_ref_atom_parser(const struct ref_format *format, struct used_
 			atom->u.remote_ref.nobracket = 1;
 		else if (!strcmp(s, "remote-name"))
 			atom->u.remote_ref.option = RR_REMOTE_NAME;
+		else if (!strcmp(s, "remote-ref"))
+			atom->u.remote_ref.option = RR_REMOTE_REF;
 		else {
 			atom->u.remote_ref.option = RR_REF;
 			refname_atom_parser_internal(&atom->u.remote_ref.refname,
@@ -1260,6 +1262,14 @@ static void fill_remote_ref_details(struct used_atom *atom, const char *refname,
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
2.14.2.windows.1


