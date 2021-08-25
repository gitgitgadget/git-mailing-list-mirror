Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D43CCC432BE
	for <git@archiver.kernel.org>; Wed, 25 Aug 2021 20:43:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B596161058
	for <git@archiver.kernel.org>; Wed, 25 Aug 2021 20:43:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242658AbhHYUoa (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Aug 2021 16:44:30 -0400
Received: from mout.web.de ([212.227.17.11]:42481 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231873AbhHYUo3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Aug 2021 16:44:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1629924218;
        bh=Gdv77WtyOmYIPR8+uPqFkLyOPAVuBzH2gtZctYd0RNc=;
        h=X-UI-Sender-Class:To:Cc:From:Subject:Date;
        b=q8HGbCI5KqTdz27CKGIkWwww21JkpuiIQi82uhRq66vGVfmeVa3zBoOdBEUAjmdQf
         A0UiZWhrY2viCVjoTbbIp3hijsVE4reWVf7PjMNF+gGGes4QB+UvLrXk7t/xF7Qe1H
         +3+qDrQkAApwhbqPYLIPzPdjr8sw3Gye5rAVw9VY=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from Mini-von-Rene.fritz.box ([79.203.27.185]) by smtp.web.de
 (mrweb105 [213.165.67.124]) with ESMTPSA (Nemesis) id
 1MIc7b-1mDkwJ2zcT-00EhlP; Wed, 25 Aug 2021 22:43:38 +0200
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Ulrich Windl <Ulrich.Windl@rz.uni-regensburg.de>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH RESEND] branch: allow deleting dangling branches with --force
Message-ID: <7894f736-4681-7656-e2d4-5945d2c71d31@web.de>
Date:   Wed, 25 Aug 2021 22:43:38 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.13.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ukUp3+vfKiwfoLQ8fXW/OVQ9ryQODZM/mqH8Xg9mt8ck0rB/UnK
 T/NWuDWILswClLWI4IOmpOXhGdaOKj5AgzLjGi8bf23UsJQjaddpih+zHO2KIaSTXuWyq66
 FnjKkW0z3NMAogKjdUUaVLNOa5df+1nB/LxN/R7J7jC69/LR40nP/MIBQ1up05iDrLn7pLG
 34vLV2EVPrq4zWVGEVFmQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:UlZcA5vZiMo=:ssOkxUwdhep83Qp8BiU3Q1
 5HHbJP3t2v5a0RvM9MtX3GTHIieRS9J2mLOzOSsV3pItaJ5n3hTEn/au03bSu8eQv9w1US10f
 woArs6n53+NELNeL/ZIngdhRoWfpmKC7bUslxFaWdcweOkmf+dSmP9aPYrZ2UBabiV3hcgxbF
 uxjyIpWPOjchCP2xmmksW+tFUgKiswrgF13dA3tFiXiMGvrKdGARQrQ3Il1rWF/xh+8jvL712
 dRhSf5mWU9CH6EJAM01B4dboa+98+7uUJwya3v+i85wRwG5l/OMqQ9Re4B9ylEKXHGxaUCKrJ
 xkKRAKa6RY5tcuWAsevpe7AttdtofkRixjicSP3nAKQh/QNVOql6MCgU5odq7uwlmiU/2IfyS
 clMzqRyTlKUQ1DPdbUtZuHT8vAG06Kn/8ufFiUYjtgOkFFHQInOmNUxsGPtgQtID3Z36b2N3V
 YeKnOG5zghthqINaT5MUQJJBMrQph730GsG+qZ6T9OCQkZ0S9+nfF5lZmEwagyN+he6LZYjlc
 1Mw0ad2opbygsRG8uJY+TZvt8wzbP1nU7sComi73jw8/AmYyfAW1iFgHuEkJ+2mVJWXTKHCu7
 e6ofL3EjVR6farl7XCxe4sScBTj4uCyIHgs4lusqs6Utwxeh0R0BkbYymDUyLZ8SnySxLtRLy
 ffMg1cqcKx1XGPwzxds9QM6oXaAuTGA/61NUj0H90mwBm09r+KTTAdNeOdj37bydMiojphw/H
 zGqokCUhUCV6qp/LWfG/EbU2HCOC96RqXlhq6aL7p/qsgetpyIT9jdBRZk/O9T5nCYejQUX6e
 NZoUrEDzKJ605GMB134GRZJ7ppIODsiPIGmizkYmDbT7kEekN7hU1G/aM4E2ximcfKVz6lsVx
 0oWsglGVxxoWmovc0Ld/m9iPwg2nDs/6Q9xI1NM7aOeq13aKBI4lXv3eDCCmVjnmRvTtopnxh
 SrVX7YTljpmCRRYP0v6CshLNxgMXz7JxbZN2/a5LDTHhwz/Su1ofD5AjfpxzjjfdjO3RIhOJ3
 +WRZOcn4KhYid4+ovR3mcW1fE+jEd8baUyxYqUHjpA1dZRalBzvb6D2B9kzdXH/J4e+hNZszK
 j5v+lm7sDfJtvowbPkGhOsnpFZwLsSiBlLl
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

git branch only allows deleting branches that point to valid commits.
Skip that check if --force is given, as the caller is indicating with
it that they know what they are doing and accept the consequences.
This allows deleting dangling branches, which previously had to be
reset to a valid start-point using --force first.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
Original submission:
http://public-inbox.org/git/52847a99-db7c-9634-b3b1-fd9b1342bc32@web.de/

 Documentation/git-branch.txt | 3 ++-
 builtin/branch.c             | 2 +-
 t/t3200-branch.sh            | 7 +++++++
 3 files changed, 10 insertions(+), 2 deletions(-)

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
index cc4b10236e..ec61a10c29 100755
=2D-- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -1272,6 +1272,13 @@ test_expect_success 'attempt to delete a branch mer=
ged to its base' '
 	test_must_fail git branch -d my10
 '

+test_expect_success 'branch --delete --force removes dangling branch' '
+	test_when_finished "rm -f .git/refs/heads/dangling" &&
+	echo $ZERO_OID >.git/refs/heads/dangling &&
+	git branch --delete --force dangling &&
+	test_path_is_missing .git/refs/heads/dangling
+'
+
 test_expect_success 'use --edit-description' '
 	write_script editor <<-\EOF &&
 		echo "New contents" >"$1"
=2D-
2.32.0
