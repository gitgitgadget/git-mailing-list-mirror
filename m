Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 903CEC432BE
	for <git@archiver.kernel.org>; Thu, 26 Aug 2021 18:19:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7AE9360FC1
	for <git@archiver.kernel.org>; Thu, 26 Aug 2021 18:19:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243332AbhHZSUK (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Aug 2021 14:20:10 -0400
Received: from mout.web.de ([212.227.15.4]:41307 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243329AbhHZSUJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Aug 2021 14:20:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1630001955;
        bh=V6gbBHbRB1vDP5PGMsa5+BfP8B72V9GzUHv0Joa126o=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:References:Date:In-Reply-To;
        b=NogSqCH4CnAO8TGuX94QYENfGUE8W3594+r2ApQNbPqs3vHRu6LxLlrjPOqYsd753
         Alx3uJL2um3IwiToAkh/R4+PBAcYlG3Lx6WpPIJIe4SeP7BDKPioVpbkDp0Ry+7XM4
         Ci+8Co1pajLLtUnniByvd5+hMeWlHr6jSokBqezQ=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from Mini-von-Rene.fritz.box ([79.203.27.185]) by smtp.web.de
 (mrweb006 [213.165.67.108]) with ESMTPSA (Nemesis) id
 1MKdLM-1mbwml3G4i-00LCC9; Thu, 26 Aug 2021 20:19:15 +0200
Subject: [PATCH v2] branch: allow deleting dangling branches with --force
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Ulrich Windl <Ulrich.Windl@rz.uni-regensburg.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
References: <7894f736-4681-7656-e2d4-5945d2c71d31@web.de>
Message-ID: <325d64e9-8a31-6ba0-73f2-5e9d67b8682f@web.de>
Date:   Thu, 26 Aug 2021 20:19:15 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <7894f736-4681-7656-e2d4-5945d2c71d31@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:koGSlEpd9XrKuzD5sk11tyjWfXVP6D0FWidVnu7j8IInC/OkzK9
 EM0HTXd1T8IQI6JwbL5tH3DnGlYo3YOL83gZFBpZP9gfBIE5xmFWbhs2cjV6xMfG+2tTee8
 OPj7rLTKgECPFa7yvttyQj1RtpXtLR9OhxSU23BWfrcjWgLupeNHl6D/K1Z+VqKqidUE9ji
 /alv9gzco3xfzv7GuzvtQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:d2lrs6RbkJo=:MRnGmv1Jazwxi/JEgkgMQ1
 8sAZj0pv3iIuOIfJ3mOovGMMsuz3+wlyeAEc/KDoc82pFYHwCqdbHfSCtwJ7ENpVwHjB3mzlH
 VFSh/ux5ISFkbJyRiTEPUg6tOTP2iOzHVvLNYf//1pwnd3BpSHH0y0UF9tpNq1H3liHTKaLsI
 4PT7vOFyqIlQrSZ++zrYklXnhFley1vSD183bJQ26CcE2YkLHH6RtCfkSBRX9YCSsjKRvtsm3
 1pUC6bFR9uzmLENQL9YqVW0EOH9ivJwQvRenVHHhArXvteKhCOztVlwVLnRUSwH4Zbk2NBSn9
 jiR0GU2lCDTloJdnwk3jnJYQgHFtOE4vKm8UTD3U8FuwZ+QTx+xzygsKRjPCDFiFZyM921Kyf
 Gh9BJyR0jWSwzSWb0Wy5dL4fAZN4i1rMbHp8V3MpmyR8ZScjQtBvoya3gAWxNHOjKfHhzR9iN
 p5My78CFHP1mtJpRKzlgnS8fzM1UhYvynVU5ijE0Dy77bltta4CavuzF0NPHio3AJFr+hP50Y
 F/MV0VpxAQleRddFzfmn/lBBOy0qtYE3Z+ZltqIDx/E6iGnHs0VCPxHlCOsxc3L9KoYVG4sVL
 NQLg0aa4K+adNShiEt5s1W5D6/eab4IRB3hLxKjWTugvZpIuB5lHnzM+90N3aKIxVun3XOqvx
 as0dFcFNxRibvmhpyPUseOANZMt4mY5OH50bx1J8dlF2IO84deoqdNgv28CvUIsGAwZBwIYSB
 IuU+Gqnpq3mJ0KcgJ8xgxPonvRNiKUVKI83rgUE/plY41DZ/uqJa0Ty5WNWf5siwkwAfcKvVb
 xhS0EVk+8oBwyji0uOmFD/ORpjxpAFF4lFtO2f5H6J0madJ+uQ97b3RrImCgby1CvFmWfjHYW
 Dr8YRwkU8BXIL4scqEZXmdqxmLaeRbn9JE+qr/Xakwod/+SUsPIncYgwTukYr+rGuYuowwn8F
 z2LwecIsIZYaL6S/klohlMYPEgRagbxA8kh2DSXQCtYxEy97fJ//NV2nf/q6EhXGCkiBcoJX0
 eGE+tZPxy7WtsetUFxDJ+TwXm1gvei63dR4idFkGTrdlkyYoS1mMLoJpl7u4MXCA0vGAqoRVl
 4AoNcVg2OEAeRsq7Q+dCzlg928PkBUSF9l0
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

git branch only allows deleting branches that point to valid commits.
Skip that check if --force is given, as the caller is indicating with
it that they know what they are doing and accept the consequences.
This allows deleting dangling branches, which previously had to be
reset to a valid start-point using --force first.

Reported-by: Ulrich Windl <Ulrich.Windl@rz.uni-regensburg.de>
Helped-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
Changes since v1:
- Added Reported-by and Helped-by.
- Made test independent of ref store.

 Documentation/git-branch.txt |  3 ++-
 builtin/branch.c             |  2 +-
 t/t3200-branch.sh            | 12 ++++++++++++
 3 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.txt
index 94dc9a54f2..5449767121 100644
=2D-- a/Documentation/git-branch.txt
+++ b/Documentation/git-branch.txt
@@ -118,7 +118,8 @@ OPTIONS
 	Reset <branchname> to <startpoint>, even if <branchname> exists
 	already. Without `-f`, 'git branch' refuses to change an existing branch=
.
 	In combination with `-d` (or `--delete`), allow deleting the
-	branch irrespective of its merged status. In combination with
+	branch irrespective of its merged status, or whether it even
+	points to a valid commit. In combination with
 	`-m` (or `--move`), allow renaming the branch even if the new
 	branch name already exists, the same applies for `-c` (or `--copy`).

diff --git a/builtin/branch.c b/builtin/branch.c
index b23b1d1752..03c7b7253a 100644
=2D-- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -168,7 +168,7 @@ static int check_branch_commit(const char *branchname,=
 const char *refname,
 			       int kinds, int force)
 {
 	struct commit *rev =3D lookup_commit_reference(the_repository, oid);
-	if (!rev) {
+	if (!force && !rev) {
 		error(_("Couldn't look up commit object for '%s'"), refname);
 		return -1;
 	}
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index cc4b10236e..d0d28c8ea7 100755
=2D-- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -1272,6 +1272,18 @@ test_expect_success 'attempt to delete a branch mer=
ged to its base' '
 	test_must_fail git branch -d my10
 '

+test_expect_success 'branch --delete --force removes dangling branch' '
+	git checkout main &&
+	test_commit unstable &&
+	hash=3D$(git rev-parse HEAD) &&
+	objpath=3D$(echo $hash | sed -e "s|^..|.git/objects/&/|") &&
+	git branch --no-track dangling &&
+	test_when_finished "test -f $objpath.x && mv $objpath.x $objpath" &&
+	mv $objpath $objpath.x &&
+	git branch --delete --force dangling &&
+	test -z "$(git for-each-ref refs/heads/dangling)"
+'
+
 test_expect_success 'use --edit-description' '
 	write_script editor <<-\EOF &&
 		echo "New contents" >"$1"
=2D-
2.33.0
