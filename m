Return-Path: <SRS0=NZH0=7G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 103CDC433E0
	for <git@archiver.kernel.org>; Sun, 24 May 2020 07:24:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DFE1F2078B
	for <git@archiver.kernel.org>; Sun, 24 May 2020 07:24:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="UPeMtOFM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728106AbgEXHXK (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 24 May 2020 03:23:10 -0400
Received: from mout.web.de ([212.227.15.3]:35125 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726331AbgEXHXK (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 May 2020 03:23:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1590304974;
        bh=w/Ziz0cg/jTGyeRVDIHykumPoOFdfwPzROLZZpwFcs8=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=UPeMtOFMTThIB2UTgHCp9P2AVgDg/Yk66LW3t4hR/Ewrf/yghRgSCLsfH74FeWdVy
         Pl1ApSbNmg9W6p6vyIgNgkHEYd1Ht5gFI1i2B0PhcHIu9+bqOiiOevOrVSgSEsAcD1
         Eg81tMTMQ37GU5six9rxm0evqUs7B1llp/V1Jx8U=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([91.47.155.84]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MKM5z-1jJrpx2r6N-00Ll20; Sun, 24
 May 2020 09:22:54 +0200
Subject: [PATCH 1/2] checkout: add tests for -b and --track
To:     Jeff King <peff@peff.net>
Cc:     Dana Dahlstrom <dahlstrom@google.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>
References: <CACqwCQiLpZ1HFzgJw0p0KR3jXNsxkhjXmF_huzhv+qkMZmybBQ@mail.gmail.com>
 <20200521191626.GC1308489@coredump.intra.peff.net>
 <9f26099a-e77b-ede4-bee3-27382a5a0875@web.de>
 <20200523162914.GA2178752@coredump.intra.peff.net>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <ebe696b2-bf68-ccd1-b930-dce274ec9279@web.de>
Date:   Sun, 24 May 2020 09:22:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200523162914.GA2178752@coredump.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:nH9D2NJuKB04Pd65DZOP6sKOvcVdLjAstu2cESX1hQAU54nG+Pt
 8cIjd+QmDkwZBCs/dMI3wm7A140vlMMuGu+86IsvM9NTWNT2VGv4A17xM0krzp7JD+Nw3n5
 01JGwgtGs5nPoXA5T9KCevxim7VF9p5yFfmW6g/Anc0zPYc8/7e204PTZRRWiU3qTuUdr3+
 e6fWAHa9UYONNlZu0ePBw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:F29xvHAmdvE=:MmG6h3E9xm1GMB10lJl+KN
 Z8v0WQO6j52m7sdWcHCp8RVl446Lr778DqKaotjmSIuPsXE1CcTZQZ8mi+UVeDppg6r9HX31I
 0IyhWRnY1ncRSj6iSFLKjZ2tQKSYaxQ+6ufItue5WNSDBoTaqWu/1VD8Ic/CgLXmGAR/0fOwJ
 7J6NHwlLNCzKHlXyk1ZrVULghVDip6PeTfc1WAP5ZpZfoEmhhEiEpXuGdrjU7jOpamRTCj19z
 14DVbdDtx6jAfjN/VkOvpDE3T1oBWN9osAsrMZYZ1h1CkKkj76x8pHt6PEfAJDhN6NihRUuct
 b538o4ZsCrFHr6h512akCe0DCi7S8oKcXeMFgPMCFN+Q+X/a4IFVuoUdiYai/2oWjwb5lQHcq
 /KOMh5fQlgU3EekrNtZF0CZP9nRyKq8OkyyhpYNWTroftFZH8nkC2IdVY19ttF51zz336oVpn
 q7lSIkdJf1S0HQcJJj33AXYAPOWq48aXu61W1AWQKtuhPyL6dSVy4Hm5ODqpYZoMF098UX6wG
 qCZzIRO7fpjy25S2VE/hS1UvGj7SkfA23DS+Bb5AN1yVLz2aNTvlxutxl4NHiKh5Y7v4H8NWz
 +LtFcsL84nnmBUzTxVpkky2xCylm2VuWb+cNA2IW4eabP1bgP0oaAjxG37bp7CJNAFMWrAcFQ
 JdrrDyPFcUCoeLcPbtYv0aTGFxfaKgEhvJjS7/WGXF+n9Mbo740ash/lfGbmmq7GEzZR2D6aU
 QUYl6FZqsZf8s5q7tavhP9kM+U2cOuNYSkucgznt55HL2PVpeh6jIiI8v5vMnKHttYar0bldU
 jfXefSMT86fAiFL/xihQ1SOn6/ARIxDdbCVHJPKNHSEOVvTI00v1itT9mMYZXY9debGEcZ1eX
 QZRuMxi4DxTr9ZqWODMmwv0nTRxxXr0Len4NZH2b+/jvhaC0ITyUenae/GuZRC9EubG2LyFCm
 jzvHAkEFxYhzCMxMojzNZeEYQHRF6uJ8QAJcyd1oG5bTB2IMjHz3lqrx0CM+fHjcz37WxtXYK
 CZivpLN979lkACGKW3x6OKr+o/2oPDBErkAj9kGfEk/n2F1/hxxAx2zLeDwPEcKzn8N5VD5e+
 ry5IDUNhwPg39xu9ZIx/dM8E5w88S9gJV1WxWnalIMLOXGqZ7h+uUwDlvaLbp2xtg8vlX2tFO
 Drhnzt93F6eg1WJm+Jp4DwShDQ3093yoIz84856Logmb8uAzw/W+xCulwNONVl44qhwLhNkeA
 kQgg9UMIYWEGC+rZE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Test git checkout -b with and without --track and demonstrate unexpected
error messages when it's given an extra (i.e. unsupported) path
argument.  In both cases it reports:

   $ git checkout -b foo origin/master bar
   fatal: 'bar' is not a commit and a branch 'foo' cannot be created from =
it

The problem is that the start point we gave for the new branch is
"origin/master" and "bar" is just some extra argument -- it could even
be a valid commit, which would make the message even more confusing.  We
have more fitting error messages in git commit, but get confused; use
the text of the rights ones in the tests.

Reported-by: Dana Dahlstrom <dahlstrom@google.com>
Original-test-by: Jeff King <peff@peff.net>
Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 t/t2018-checkout-branch.sh | 10 ++++++++++
 t/t2027-checkout-track.sh  | 24 ++++++++++++++++++++++++
 2 files changed, 34 insertions(+)
 create mode 100755 t/t2027-checkout-track.sh

diff --git a/t/t2018-checkout-branch.sh b/t/t2018-checkout-branch.sh
index 21583154d8..d99b699396 100755
=2D-- a/t/t2018-checkout-branch.sh
+++ b/t/t2018-checkout-branch.sh
@@ -260,4 +260,14 @@ test_expect_success 'checkout -b to a new branch pres=
erves mergeable changes des
 	test_cmp expect actual
 '

+test_expect_success 'checkout -b rejects an invalid start point' '
+	test_must_fail git checkout -b branch4 file1 2>err &&
+	test_i18ngrep "is not a commit" err
+'
+
+test_expect_failure 'checkout -b rejects an extra path argument' '
+	test_must_fail git checkout -b branch5 branch1 file1 2>err &&
+	test_i18ngrep "Cannot update paths and switch to branch" err
+'
+
 test_done
diff --git a/t/t2027-checkout-track.sh b/t/t2027-checkout-track.sh
new file mode 100755
index 0000000000..d0b41d7cd0
=2D-- /dev/null
+++ b/t/t2027-checkout-track.sh
@@ -0,0 +1,24 @@
+#!/bin/sh
+
+test_description=3D'tests for git branch --track'
+
+. ./test-lib.sh
+
+test_expect_success 'setup' '
+	test_commit one &&
+	test_commit two
+'
+
+test_expect_success 'checkout --track -b creates a new tracking branch' '
+	git checkout --track -b branch1 master &&
+	test $(git rev-parse --abbrev-ref HEAD) =3D branch1 &&
+	test $(git config --get branch.branch1.remote) =3D . &&
+	test $(git config --get branch.branch1.merge) =3D refs/heads/master
+'
+
+test_expect_failure 'checkout --track -b rejects an extra path argument' =
'
+	test_must_fail git checkout --track -b branch2 master one.t 2>err &&
+	test_i18ngrep "cannot be used with updating paths" err
+'
+
+test_done
=2D-
2.26.2
