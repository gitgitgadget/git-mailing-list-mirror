Return-Path: <SRS0=iV/m=CA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75E07C433DF
	for <git@archiver.kernel.org>; Sat, 22 Aug 2020 08:58:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2BDE2208DB
	for <git@archiver.kernel.org>; Sat, 22 Aug 2020 08:58:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="kFKwCHnx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726483AbgHVI6Q (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 22 Aug 2020 04:58:16 -0400
Received: from mout.web.de ([212.227.15.3]:60803 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725877AbgHVI6P (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Aug 2020 04:58:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1598086683;
        bh=clIz1o304efYWZjmMIDgBSTtm4IvbDLzrO2PJzt3R1c=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=kFKwCHnxRfARQ286A6oyAAkUN8RIpO32XhdO9huGk4T6NGPchpIls2sZOTLERqlQw
         WDsZCQGuGs29O1mQnKvpnBtkq/zWcalADp9fF31lTrOdZzjAVxpq9yigSRzQOhDSIr
         Vs1SdRA6+1YvqrTD8DHikNqcLWbpK56dUApmCw5g=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([79.203.26.151]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MiMEM-1koUiz0YT8-00fST4; Sat, 22
 Aug 2020 10:58:03 +0200
Subject: [PATCH] checkout, restore: make pathspec recursive
To:     Jeff King <peff@peff.net>
Cc:     Sergii Shkarnikov <sergii.shkarnikov@globallogic.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
References: <CAFvH=vsWyX79j-9pyC5gpxGu8rRxYyrXwywHjh-_T2opHjT8Xg@mail.gmail.com>
 <CAPig+cSCd_8YB90sypTe1bHMQhPgo+Tr2PHNucdqfCpEe+Dosg@mail.gmail.com>
 <CAFvH=vuFg+kM2GkBaE7jRqHWWcTcZMrs36KLS+-VTy8tgNZXJw@mail.gmail.com>
 <20200820134013.GA2526241@coredump.intra.peff.net>
 <c3f0d51a-d0e3-ed0a-c9ed-da092704da5c@web.de>
 <20200820182720.GA2537643@coredump.intra.peff.net>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <7c5144d8-24cd-0d50-a7c6-ff77160d503d@web.de>
Date:   Sat, 22 Aug 2020 10:57:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200820182720.GA2537643@coredump.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:/nqfnVZajwL2CU75bMBUolg5Fey/fIFkHIALd0bNS58UUYr91n4
 wyidWq4TLAKwsWYcQYW1K4gSVaksotqDaNYWODP6GZgiDv2/EYsuzsgdeesEcRQ0PDQpw9D
 jppTX9Irx3zXuKbMTsGfqjNhOn/Lore2ngLUe9jI0njJa33YV9lxYm8sOdrnwbww2Fi942x
 55JxNjxvsf9F/XcIclSHw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:g0q5Z1eGfAI=:k8u7haEAKedAeAji9V4+7i
 6DlVjTucW/7GFRyu2ajWwJDWIMu0NEfGa90Y2dOQkODA2KtcdMhZSoe10JlaN6eN10FmuWChZ
 L2l+AFOAB1BB9KEvJk6qq93KaMOQF58qo3i3h5iqL2kdhDq+nPMxy+TOy0Fur838pDFft6LQb
 gkciXNNs2OT1dUdJ5azcKdb5bolweGs5lNg+PVNVVwkOWSP1ab9c3sN3GWKZJu1DNJhqd4YG1
 E8fJJ/Zg7kbGvGMjcmVSme58xUs6VeaEHuVZj0Y7OZsa8xFcu8PNvXuZ/Myq9jt2K2c1sa6ze
 nBcnNQuzYrQgjEAM9ILp07OThQtmrWL/YzL/qaeEXFjIwgomc8U66KsIRmiukT4odRyromQhs
 7eRC7I9oosZdX/Ra7/KAaeBDC+3P2uuRrtZa7273cORP5mjn0wxyhR3H/isjfIl4hxHwcl2mF
 cHcBgLk2w6G0C1ceGP82MFwscRCU3x7RG6vT2EBf449YIEzXV9N/S+oOCi5h5mlqjUKDJQu0f
 xdjfZqkVQCpZA90NOaDAP/rzXb5MlBaUz4WLgAbdrvrBnqyp0y6gkslyuihwYT6w0OM2SOn3p
 hdBOxGWljFX+YwZCubm4J3IR42pgv2b+BpqEeTnrdPFQOOjaw4CzcVOctBvryMtK0H7dvB911
 bPfY5rS/XxNDCx+mbdjCFYGTn5f6NKjbRfe3520pKGdVWIeNIM6ZqqeOZRc9LD3tdv7QFejKY
 vDvJedBYJ5ReN9w5vs8bzmHiQwKuyAohF+fdFh7IIH4yoFfMCYbkDSZntr2yAXEPa47biAVkx
 2KY6WLPCQulbCozZ+QACQKAnZWAqnrsNYU09FFvyVXORV/4GFAE9hpPv330MLIPVi2f4B4i/c
 rC/qguR9wK7wdmtvDCHRswzyqKP55pnpJMFFuGy5v56u9MPbv0vmlWt19VyEeE5g5wRmFF7Go
 PEt76U056o4Ur8lMG6qo3otZBZfEQVSEviCsyScJkkAZ54y+RfEHbzjGArfqkClxjJS19jpca
 dSLAHSmsBi+YKaRIlou75KZ7WrDvpSfVDsCxklGst7k1IH3lZvNiaWwOKhh2CoYDzjbq0qFtf
 0y9EmT4h2JE1wtds3d9dVLm8Csf3NkqhYDADW99uT1pEd1+4uvxf/bNT3MsttLwzp9E8UyMcV
 lyEdVjBGEGpv7KvbVwBmQuUKnt8wB2U/eNM0Oa+M6MQJypYVMMGZVwXn8E29TVI10hae7IGFU
 Xhe5MuTUhicR5ZMkG
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The pathspec given to git checkout and git restore is used with both
tree_entry_interesting (via read_tree_recursive) and match_pathspec
(via ce_path_match).  The latter effectively only supports recursive
matching regardless of the value of the pathspec flag "recursive",
which is unset here.

That causes different match results for pathspecs with wildcards, and
can lead checkout and restore in no-overlay mode to remove entries
instead of modifying them.  Enable recursive matching for both checkout
and restore to make matching consistent.

Setting the flag in checkout_main() technically also affects git switch,
but since that command doesn't accept pathspecs at all this has no
actual consequence.

Reported-by: Sergii Shkarnikov <sergii.shkarnikov@globallogic.com>
Initial-test-by: Sergii Shkarnikov <sergii.shkarnikov@globallogic.com>
Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 builtin/checkout.c               |  2 ++
 t/t2025-checkout-no-overlay.sh   | 12 ++++++++++++
 t/t2072-restore-pathspec-file.sh | 19 ++++++++++++++++---
 3 files changed, 30 insertions(+), 3 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 28371954912..a65b4bf0b71 100644
=2D-- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -1707,6 +1707,8 @@ static int checkout_main(int argc, const char **argv=
, const char *prefix,
 		die(_("--pathspec-file-nul requires --pathspec-from-file"));
 	}

+	opts->pathspec.recursive =3D 1;
+
 	if (opts->pathspec.nr) {
 		if (1 < !!opts->writeout_stage + !!opts->force + !!opts->merge)
 			die(_("git checkout: --ours/--theirs, --force and --merge are incompat=
ible when\n"
diff --git a/t/t2025-checkout-no-overlay.sh b/t/t2025-checkout-no-overlay.=
sh
index 76330cb5ab7..fa9e0987063 100755
=2D-- a/t/t2025-checkout-no-overlay.sh
+++ b/t/t2025-checkout-no-overlay.sh
@@ -44,4 +44,16 @@ test_expect_success '--no-overlay --theirs with D/F con=
flict deletes file' '
 	test_path_is_missing file1
 '

+test_expect_success 'wildcard pathspec matches file in subdirectory' '
+	git reset --hard &&
+	mkdir subdir &&
+	test_commit file3-1 subdir/file3 &&
+	test_commit file3-2 subdir/file3 &&
+
+	git checkout --no-overlay file3-1 "*file3" &&
+	echo file3-1 >expect &&
+	test_path_is_file subdir/file3 &&
+	test_cmp expect subdir/file3
+'
+
 test_done
diff --git a/t/t2072-restore-pathspec-file.sh b/t/t2072-restore-pathspec-f=
ile.sh
index 0d47946e8a9..b48345bf95f 100755
=2D-- a/t/t2072-restore-pathspec-file.sh
+++ b/t/t2072-restore-pathspec-file.sh
@@ -9,18 +9,21 @@ test_tick
 test_expect_success setup '
 	test_commit file0 &&

+	mkdir dir1 &&
+	echo 1 >dir1/file &&
 	echo 1 >fileA.t &&
 	echo 1 >fileB.t &&
 	echo 1 >fileC.t &&
 	echo 1 >fileD.t &&
-	git add fileA.t fileB.t fileC.t fileD.t &&
+	git add dir1 fileA.t fileB.t fileC.t fileD.t &&
 	git commit -m "files 1" &&

+	echo 2 >dir1/file &&
 	echo 2 >fileA.t &&
 	echo 2 >fileB.t &&
 	echo 2 >fileC.t &&
 	echo 2 >fileD.t &&
-	git add fileA.t fileB.t fileC.t fileD.t &&
+	git add dir1 fileA.t fileB.t fileC.t fileD.t &&
 	git commit -m "files 2" &&

 	git tag checkpoint
@@ -31,7 +34,7 @@ restore_checkpoint () {
 }

 verify_expect () {
-	git status --porcelain --untracked-files=3Dno -- fileA.t fileB.t fileC.t=
 fileD.t >actual &&
+	git status --porcelain --untracked-files=3Dno -- dir1 fileA.t fileB.t fi=
leC.t fileD.t >actual &&
 	test_cmp expect actual
 }

@@ -161,4 +164,14 @@ test_expect_success 'error conditions' '
 	test_i18ngrep -e "you must specify path(s) to restore" err
 '

+test_expect_success 'wildcard pathspec matches file in subdirectory' '
+	restore_checkpoint &&
+
+	echo "*file" | git restore --pathspec-from-file=3D- --source=3DHEAD^1 &&
+	cat >expect <<-\EOF &&
+	 M dir1/file
+	EOF
+	verify_expect
+'
+
 test_done
=2D-
2.28.0
