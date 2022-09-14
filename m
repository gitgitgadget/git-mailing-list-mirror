Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13B84ECAAD8
	for <git@archiver.kernel.org>; Wed, 14 Sep 2022 09:47:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230373AbiINJrj (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Sep 2022 05:47:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230367AbiINJrh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Sep 2022 05:47:37 -0400
Received: from mout.web.de (mout.web.de [212.227.15.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1419962AAC
        for <git@vger.kernel.org>; Wed, 14 Sep 2022 02:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1663148853; bh=zBdn5FtF+EmGHs2nHUyIEaUivuGGl2bF3qR1aY6XIzU=;
        h=X-UI-Sender-Class:Date:Subject:To:References:Cc:From:In-Reply-To;
        b=v4tt/djA0tB52DGFrbrN54a0TFePfY0aa4tcUT0Izl1RYkMRkLSaeZrEsavJGEh4/
         r7ujM9XNIqApvfjPs00MJPt3wISEtY9iEDZ7AE5CgJjvAvwcvaIli7J7iio4Pvvaj3
         /z8B8QJqM6A/9qfiQ5CR8q7uUU8c8BUw+7JwnVYaouZ1n5m0QK3ipnFUbZ9zkEcc9g
         lCiO0051usX87zwigmfNYaQIzJXBBQozsdC6Gf3htfyIWEkyplT8jfxiQPB4Y9E4Ba
         o0klzb/VUpbdmtEuakxmORSWp/yMCivMIKUMdFZRmeOYi7Ceee2+v2E6RIZUMYPMfJ
         O8qYC5ZBKG0Kg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([79.203.24.217]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MsaS7-1pRbwc2OEN-00tmvG; Wed, 14
 Sep 2022 11:47:33 +0200
Message-ID: <2463c4b9-313b-032f-9313-d1421f71f111@web.de>
Date:   Wed, 14 Sep 2022 11:47:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.2.2
Subject: [PATCH] add -p: fix worktree patch mode prompts
Content-Language: en-US
To:     David Plumpton <david.plumpton@gmail.com>, git@vger.kernel.org
References: <CAJXaddZwqGabdjmgc22eCYCdBw6nxcPbPfom26PwG3xvKEN93w@mail.gmail.com>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <CAJXaddZwqGabdjmgc22eCYCdBw6nxcPbPfom26PwG3xvKEN93w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:J6Qo6DjoZGFN6MBRl6VtDrNxTd8yOpfED74TSM/6os8b4iU+nZv
 +R14yf2NW5uCjdjVHq1HKREmfxba2m4wo4glZ3OQbYBjiJEui0I8eDZ3lIU9ZZLcXILUNJm
 plSmvvsYzSk/ZITaa6fbM8pNYP8n9/4w02p4pdcYRARgbBjpWujkPFKVEd1I9pSjcsHoT/B
 cjmXhcSwUd7tmD16UOCiQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:sdSzr0yxBXk=:1S1x72azoo3Xzgz9V9MCXU
 hVgPH1457iXgnmPBDgy2hshcQ2KqqELfNf5Gn3t09DBhHGinZNmWeBkTtn6019MHL2M7lDusC
 b/pWOsHc2Kn99P6I06UU1aC8oakygzsQQWAXqlsO6dcP/X727PTXHiZU2rJRROuO+K0Zy65Ph
 +XhM/x9aBz7jU+p7+z349qMNzeBAFAi4bZf5kTx6M+Yv0qXqT6hhEyLZjZyZ4My0b/TCGkSJB
 kcD0FpDUXmrfqGIroDJdF8kJBxG8nJLzbZvnZ5p7GXhMkC6X6WgPHC+OLdPc5UEruBDF9emmA
 D2mgVcLPVxnwI/4+F0GfjojDaKYd1FZLbDYuIMy76U2pdY+G81gJnzb8qVqTc9izzqWLdNZ9o
 4NBaUNYjemwBqooHiFBtGwMchvPd2ltbmHv1So1cQBhWbWHIQef+jVmJnyeDMKeVjJs6epZBq
 ZQvRHou3nZy2xmuwVOZcrq2uDd0mBa8SkDxkaBprHY3Q9uEIPyTVW5P4EX/q251v4I/3oqrQT
 8DEEZc+QIb0ej2UHGTU+BAbmQqbnia5xWR1Td3UZsI7gv7ip9h0Kiab+KQPj7NOoQi1/3iB+H
 DPLszgzLhQ7CxNY7D3dJpFwy1s69h7NuvQ5bGnC2ZMkJMiTUMdHpBgmc/XuqST4A51IH3Xi3N
 1zrE7Ai5pDFqN42Gtc0eq5isVOZFMUy1aEBHmJR0+9aY0R3EK4R4DPMq9rg8GSkjmEOD57uW0
 7KzzvxSuNwXnIUokH3tsYnaXUaLPG2IOr9uasnJx6oGYSbOdrDwj8oEZTCH13Gf3lnsbGl4RO
 nqtzKaA2UlPoyM47nH2/4neTUF0Q+gVeNFLb8XVZJtBE0INNMXMPonl729tkjXq3h9oX7RbfH
 CniOd4DP6zprIF+qeEOPi0Bzcivt+G9g5GGXCEjqz4Sl298YoRyX1p+8zseuWM27ER5JouAVn
 8FJaS/3TMQ51Isg9PB4SCgU8NeOhotQ7M7PGzD3UjuFwgB+Y3jWRnn459xTv+1Y/JFEZxMa8M
 JMF9bA2zlkylXKUWuUuU3fOKwACKPa/64zF1nTbxhb72pHfrscM0ixILH3J5COK2P59MmYOF5
 madCJNsLyeEh2QDHste3rgHxziW0pV5h6gMoIf26UWec8CqvNvO99lBXPUST/uLU+sqJCRBfM
 WjRuk=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

cee6cb7300 (built-in add -p: implement the "worktree" patch modes,
2019-12-21) added the worktree patch modes to the built-in add -p.
Its commit message claims to be a port of 2f0896ec3ad4 (restore:
support --patch, 2019-04-25), which did the same for the script
git-add--interactive.perl.

The script mentioned only the worktree in its prompt messages in
worktree mode, while the built-in mentions the worktree and also the
index, even though the command doesn't actually affect the index.

2c8bd8471a (checkout -p: handle new files correctly, 2020-05-27)
added new prompt messages for addition that also mention the index in
worktree mode in the built-in, but not in the script.

Correct these prompts to state that only the worktree will be affected.

Reported-by: David Plumpton <david.plumpton@gmail.com>
Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
Patch created using --function-context for easier review.  Note that
help_patch_text is already correct.

 add-patch.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/add-patch.c b/add-patch.c
index 29f9456df3..33ecd8398a 100644
=2D-- a/add-patch.c
+++ b/add-patch.c
@@ -188,22 +188,22 @@ static struct patch_mode patch_mode_checkout_nothead=
 =3D {
 static struct patch_mode patch_mode_worktree_head =3D {
 	.diff_cmd =3D { "diff-index", NULL },
 	.apply_args =3D { "-R", NULL },
 	.apply_check_args =3D { "-R", NULL },
 	.is_reverse =3D 1,
 	.prompt_mode =3D {
-		N_("Discard mode change from index and worktree [y,n,q,a,d%s,?]? "),
-		N_("Discard deletion from index and worktree [y,n,q,a,d%s,?]? "),
-		N_("Discard addition from index and worktree [y,n,q,a,d%s,?]? "),
-		N_("Discard this hunk from index and worktree [y,n,q,a,d%s,?]? "),
+		N_("Discard mode change from worktree [y,n,q,a,d%s,?]? "),
+		N_("Discard deletion from worktree [y,n,q,a,d%s,?]? "),
+		N_("Discard addition from worktree [y,n,q,a,d%s,?]? "),
+		N_("Discard this hunk from worktree [y,n,q,a,d%s,?]? "),
 	},
 	.edit_hunk_hint =3D N_("If the patch applies cleanly, the edited hunk "
 			     "will immediately be marked for discarding."),
 	.help_patch_text =3D
 		N_("y - discard this hunk from worktree\n"
 		   "n - do not discard this hunk from worktree\n"
 		   "q - quit; do not discard this hunk or any of the remaining "
 			"ones\n"
 		   "a - discard this hunk and all later hunks in the file\n"
 		   "d - do not discard this hunk or any of the later hunks in "
 			"the file\n"),
 };
@@ -211,21 +211,21 @@ static struct patch_mode patch_mode_worktree_head =
=3D {
 static struct patch_mode patch_mode_worktree_nothead =3D {
 	.diff_cmd =3D { "diff-index", "-R", NULL },
 	.apply_args =3D { NULL },
 	.apply_check_args =3D { NULL },
 	.prompt_mode =3D {
-		N_("Apply mode change to index and worktree [y,n,q,a,d%s,?]? "),
-		N_("Apply deletion to index and worktree [y,n,q,a,d%s,?]? "),
-		N_("Apply addition to index and worktree [y,n,q,a,d%s,?]? "),
-		N_("Apply this hunk to index and worktree [y,n,q,a,d%s,?]? "),
+		N_("Apply mode change to worktree [y,n,q,a,d%s,?]? "),
+		N_("Apply deletion to worktree [y,n,q,a,d%s,?]? "),
+		N_("Apply addition to worktree [y,n,q,a,d%s,?]? "),
+		N_("Apply this hunk to worktree [y,n,q,a,d%s,?]? "),
 	},
 	.edit_hunk_hint =3D N_("If the patch applies cleanly, the edited hunk "
 			     "will immediately be marked for applying."),
 	.help_patch_text =3D
 		N_("y - apply this hunk to worktree\n"
 		   "n - do not apply this hunk to worktree\n"
 		   "q - quit; do not apply this hunk or any of the remaining "
 			"ones\n"
 		   "a - apply this hunk and all later hunks in the file\n"
 		   "d - do not apply this hunk or any of the later hunks in "
 			"the file\n"),
 };
=2D-
2.37.2
