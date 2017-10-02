Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 610AC20281
	for <e@80x24.org>; Mon,  2 Oct 2017 13:56:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751188AbdJBN4o (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Oct 2017 09:56:44 -0400
Received: from mout.gmx.net ([212.227.17.20]:61423 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751101AbdJBN4n (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Oct 2017 09:56:43 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MKLeM-1dzZAm24vu-001kE4; Mon, 02
 Oct 2017 15:56:38 +0200
Date:   Mon, 2 Oct 2017 15:56:37 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/3] for-each-ref: let upstream/push optionally report the
 remote name
In-Reply-To: <cover.1506952571.git.johannes.schindelin@gmx.de>
Message-ID: <0e03bf1e50e24a52f57be0f51d19f4657c68d2fa.1506952571.git.johannes.schindelin@gmx.de>
References: <cover.1506952571.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:VvvhS+gq3bBaB7/x39qfuZNefGK1wBStZp+2+jPIWooMqzPDgFr
 tPALvJhHexSu+REpd7bgywdWl9YcRYS+0DW6IL6wTRCR9OSMvUdICrCyMNBhvNLs98jciB0
 HcJ0dI2b6SRJw7sYS/WQAciM6V2ew+g/SluFLB39PWalzDRC1zEfL4Ds59nCvHBKo/vAUKN
 NIxa22YvqwYw8FPv8DbXw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:HrQ6xLlKESE=:YdHJgqwEKCUsFnrJ9iVZtX
 Sw4JrA4RKl0pvbBVF1Atxg4L22Sgv2ii6HoQJGCNP8S4omyET12c0jTTublZoUIlcxvjelHJi
 CLr6eNgIClGDKnaE+bRoJ2kgXvmknTfcCLOlW6RpA4cU/sS7RE1lJ08LguL1ia4/RaSUt/5Cf
 3BanYhNwgVipsDaZO9HAiyyBbnPmwGaEjEjb9JFrUM12sDAVPZa7aq3JZT3O2OyKfCLyr2DVG
 SANhSmKNK18YBSwGAjs8MGLnw7ql+GD0etFto+ehDCqwYqZu7wE0b0yCYFo9+E/xl+otKN6eR
 aX8oiDY4c87IlWG+RBMrUziDXYlD7Orte0VlWRcvRIbLANWCGeMyv6CvYgED1VtW3+4sxc9YK
 H1QXXgHQPgTQCtMCWlo1W4I04j59ayQ58BhE0ZvjdV+CcxHMg9MTiv6irYuyeFeRL6hI6aTpR
 yCLMpToG/E7c8aFimM1h+WLKfz71/GjPeFVs4tJSAO0olsJ50zUuZ/qoaN8D3twhL6IAnE28K
 EobA4ezPwJ91ThZJAVINfG5ikw0CEije2eVsIMRABYkvDP0lsyCjHSUA6/R11p2MetcwnUsaH
 CFXpakMvdYaTUzv8gG/cH9UGqDm++t6+KkrQ251CVU8VZxqFMVgw430lvTJM1yA53rgsry1Yx
 eDA5UpCPTJn/OuL7VvWLPcmVRolim19pMsrZKjX/Vfnj03AaWOaecVlvtyfKZ5/616qUsPmmZ
 l/a8zGVoHaUKDdcP1vS4X9U9nKxKHJfOs04iBAO0+999DJOWCjh2t1twnz0KiE55jeJuENEhw
 mIQ5y3xJEXb5HDtorvpEdGldcSAqSAwBWY0bRTFryJLref3Kfw=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There are times when e.g. scripts want to know not only the name of the
upstream branch on the remote repository, but also the name of the
remote.

This patch offers the new suffix :remote for the upstream and for the
push atoms, allowing to show exactly that. Example:

	$ cat .git/config
	...
	[remote "origin"]
		url = https://where.do.we.come/from
		fetch = refs/heads/*:refs/remote/origin/*
	[remote "hello-world"]
		url = https://hello.world/git
		fetch = refs/heads/*:refs/remote/origin/*
		pushURL = hello.world:git
		push = refs/heads/*:refs/heads/*
	[branch "master"]
		remote = origin
		pushRemote = hello-world
	...

	$ git for-each-ref \
		--format='%(upstream) %(upstream:remote) %(push:remote)' \
		refs/heads/master
	refs/remotes/origin/master origin hello-world

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Documentation/git-for-each-ref.txt | 16 +++++++++-------
 ref-filter.c                       | 25 +++++++++++++++++++++----
 2 files changed, 30 insertions(+), 11 deletions(-)

diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
index 66b4e0a4050..776368ee531 100644
--- a/Documentation/git-for-each-ref.txt
+++ b/Documentation/git-for-each-ref.txt
@@ -140,17 +140,19 @@ upstream::
 	(behind), "<>" (ahead and behind), or "=" (in sync). `:track`
 	also prints "[gone]" whenever unknown upstream ref is
 	encountered. Append `:track,nobracket` to show tracking
-	information without brackets (i.e "ahead N, behind M").  Has
-	no effect if the ref does not have tracking information
-	associated with it.  All the options apart from `nobracket`
-	are mutually exclusive, but if used together the last option
-	is selected.
+	information without brackets (i.e "ahead N, behind M").  Also
+	respects `:remote-name` to state the name of the *remote* instead of
+	the ref.
++
+Has no effect if the ref does not have tracking information associated
+with it.  All the options apart from `nobracket` are mutually exclusive,
+but if used together the last option is selected.
 
 push::
 	The name of a local ref which represents the `@{push}`
 	location for the displayed ref. Respects `:short`, `:lstrip`,
-	`:rstrip`, `:track`, and `:trackshort` options as `upstream`
-	does. Produces an empty string if no `@{push}` ref is
+	`:rstrip`, `:track`, `:trackshort` and `:remote-name` options as
+	`upstream` does. Produces an empty string if no `@{push}` ref is
 	configured.
 
 HEAD::
diff --git a/ref-filter.c b/ref-filter.c
index bc591f4f3de..58d53c09390 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -76,7 +76,9 @@ static struct used_atom {
 		char color[COLOR_MAXLEN];
 		struct align align;
 		struct {
-			enum { RR_REF, RR_TRACK, RR_TRACKSHORT } option;
+			enum {
+				RR_REF, RR_TRACK, RR_TRACKSHORT, RR_REMOTE_NAME
+			} option;
 			struct refname_atom refname;
 			unsigned int nobracket : 1;
 		} remote_ref;
@@ -156,6 +158,8 @@ static void remote_ref_atom_parser(const struct ref_format *format, struct used_
 			atom->u.remote_ref.option = RR_TRACKSHORT;
 		else if (!strcmp(s, "nobracket"))
 			atom->u.remote_ref.nobracket = 1;
+		else if (!strcmp(s, "remote-name"))
+			atom->u.remote_ref.option = RR_REMOTE_NAME;
 		else {
 			atom->u.remote_ref.option = RR_REF;
 			refname_atom_parser_internal(&atom->u.remote_ref.refname,
@@ -1247,6 +1251,15 @@ static void fill_remote_ref_details(struct used_atom *atom, const char *refname,
 			*s = ">";
 		else
 			*s = "<>";
+	} else if (atom->u.remote_ref.option == RR_REMOTE_NAME) {
+		int explicit;
+		const char *remote = starts_with(atom->name, "push") ?
+			pushremote_for_branch(branch, &explicit) :
+			remote_for_branch(branch, &explicit);
+		if (explicit)
+			*s = xstrdup(remote);
+		else
+			*s = "";
 	} else
 		die("BUG: unhandled RR_* enum");
 }
@@ -1364,9 +1377,13 @@ static void populate_value(struct ref_array_item *ref)
 				continue;
 			branch = branch_get(branch_name);
 
-			refname = branch_get_push(branch, NULL);
-			if (!refname)
-				continue;
+			if (starts_with(name, "push:remote-"))
+				refname = NULL;
+			else {
+				refname = branch_get_push(branch, NULL);
+				if (!refname)
+					continue;
+			}
 			fill_remote_ref_details(atom, refname, branch, &v->s);
 			continue;
 		} else if (starts_with(name, "color:")) {
-- 
2.14.2.windows.1


