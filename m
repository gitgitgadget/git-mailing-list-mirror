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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4920C432BE
	for <git@archiver.kernel.org>; Fri, 27 Aug 2021 18:35:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E7B4601FF
	for <git@archiver.kernel.org>; Fri, 27 Aug 2021 18:35:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbhH0Sgd (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 Aug 2021 14:36:33 -0400
Received: from mout.web.de ([212.227.15.3]:52409 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229638AbhH0Sgd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Aug 2021 14:36:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1630089336;
        bh=ZZhNqkaNybeybU72So1+f788cojWeTgGo/DprEwKaIE=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:References:Date:In-Reply-To;
        b=mGoROFnOxzkDwcP0aYqya/SB70shauKRGxvAYhKumZ5zXYVxEZqJ8vBHmr6mJSBRS
         AY21RfR0gordXzmVtiVsxxXKsVxRMUYWX6bef/5FG5OlU0zu8A+oRZC9RrzxJn/gMc
         BinI8131vxD7O9XQDonqxjXdJtnx9/TLr2PPU85w=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from Mini-von-Rene.fritz.box ([79.203.27.185]) by smtp.web.de
 (mrweb005 [213.165.67.108]) with ESMTPSA (Nemesis) id
 1MtPre-1nA9jF43KA-00umoG; Fri, 27 Aug 2021 20:35:36 +0200
Subject: [PATCH v3] branch: allow deleting dangling branches with --force
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Ulrich Windl <Ulrich.Windl@rz.uni-regensburg.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
References: <7894f736-4681-7656-e2d4-5945d2c71d31@web.de>
 <325d64e9-8a31-6ba0-73f2-5e9d67b8682f@web.de>
Message-ID: <c192f438-2eaf-c098-9fe4-c03a9d36cbd0@web.de>
Date:   Fri, 27 Aug 2021 20:35:35 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <325d64e9-8a31-6ba0-73f2-5e9d67b8682f@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:1qgmny09oO8x87h1xxEuuJT0YScNfTeKMdw+acqxP7YONGSYCJQ
 5cepcOllyDxWuL26+Ooy1rXzJywDk46bL1fTAzlIc5J4E7OqjE1wQpHHn43BEBSStf72oKq
 tfQGWK1kt5BLo2o7RhZqBsIAlNShehHl9Dg1zGFJblcpRCCpmljYKYVTwt67Dd5PbH0FtIm
 LfSdtH9T5tPOd+lHhNkFQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:g81dg864KyM=:JEtFt50r5Ib2vKFkzzN+3O
 haH0x5rZJhX5w++EcQhuXxb0VF/FP9X1A4xDxLK/5bib4PMPC4YIJ6s88ifOcPm9CB9wxvFnv
 hkaWRiC61AKQOUq8NYfLTm15DbkQJDg7xfDrpCJLW7l8o28WogRtR8J8J8JkUeCp+y791YTZn
 vaym3wRw/0lnw7MxAbuHcalMMsdenr9ktOTej2jK4mWMiJe3kS3b1CNnAIGKzhu1cCVqg8YeR
 5olRoHapevx2e/xGceodh0loDL3Tqkj+5XflIXxm9fQ3FiJoK/dDTJQHsOZMOhD8WMUasCFr/
 c5QFdP4RcRSoFBsHAb9PO5VUtjBCGxh/PqaxSaY80UhuIDVUqcnBKu9m4VJvtzPvG7C+YVBHI
 P8afqTg97nmacMFOu5iZ3z51YKncBjbi8SOHZ9Y/m4W1aScwSK0ekasfVgwSXvY+uscSo7sus
 Vpal6NDIoAMSxB525Kl0GTQAYp9wVetpZn2cnWnZ0ZCVwcOvhbZ+bMTfWi9Ariv1BIF0/b5HD
 Gn0Gva8alvlU3hVtxBSJJqKmDarIvqO56rMWIMBL4IHJt3CT8xU0asisEKfJURYpYLX2AOWm9
 X3E05fnvJ+NOj11ma8fo849eOW6RLKni8Svu5jOPSURUnQAAIFWo5UIx+LLYb+1PA8QCjbWM5
 TaT0YldlQVuv8Xl9lXoCPGAWmQkQKI6SzAUZAz+JJ/RzMIsDRbTk91uTVkQPx3XbQIbJjwdf7
 U3R7DdMq/s3WZOUlXDyUamtv/9uE2neQWLjbfvLngdZRrcoIATUvG7dfeaynpaV9NhL42Zt7t
 W04X//KlZtS6JfnCDb25wpWhgG6QLnc5KM8Jl9YRlMpYgc08vfwMuXeiSNSUSoXluQ8XJQi1s
 nx1P4yP4Ro8b/Lgn7FiCdDFrYOmHiljui7bZ66A9Pik1JK4VjdNZOP/+NRN9QTrBfjMbUEY39
 FBIuPXLpM+Tl/geGzH1kwWlPkvwLK1R4yCh/UIThT6cOGnhpSJZuEkVm3hOuGiano62nr3vy8
 O5f5Df4DQLI3JGWNRgPW2LhukCSWg5k6S1WEqNVnTrPpGqPHevMe5tpO4hfIfBYsn+syyDL72
 8Npqh+iQ6iAX7aiTbeqhBpjZjZihIHWaeu/
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
Changes since v2:
- move test_when_finished down to avoid need for test -f
- check return code of git for-each-ref  in test to distinguish
  between a deleted and a still existing, but dangling branch

 Documentation/git-branch.txt |  3 ++-
 builtin/branch.c             |  2 +-
 t/t3200-branch.sh            | 13 +++++++++++++
 3 files changed, 16 insertions(+), 2 deletions(-)

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
index cc4b10236e..e575ffb4ff 100755
=2D-- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -1272,6 +1272,19 @@ test_expect_success 'attempt to delete a branch mer=
ged to its base' '
 	test_must_fail git branch -d my10
 '

+test_expect_success 'branch --delete --force removes dangling branch' '
+	git checkout main &&
+	test_commit unstable &&
+	hash=3D$(git rev-parse HEAD) &&
+	objpath=3D$(echo $hash | sed -e "s|^..|.git/objects/&/|") &&
+	git branch --no-track dangling &&
+	mv $objpath $objpath.x &&
+	test_when_finished "mv $objpath.x $objpath" &&
+	git branch --delete --force dangling &&
+	git for-each-ref refs/heads/dangling >actual &&
+	test_must_be_empty actual
+'
+
 test_expect_success 'use --edit-description' '
 	write_script editor <<-\EOF &&
 		echo "New contents" >"$1"
=2D-
2.33.0
