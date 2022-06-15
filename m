Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA738C43334
	for <git@archiver.kernel.org>; Wed, 15 Jun 2022 17:05:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244057AbiFORFW (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Jun 2022 13:05:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240589AbiFORFV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Jun 2022 13:05:21 -0400
Received: from mout.web.de (mout.web.de [212.227.15.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 915EE4F443
        for <git@vger.kernel.org>; Wed, 15 Jun 2022 10:05:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1655312704;
        bh=Ixt2ZeG3Cp3Z24g+Sya1sLQRzm37+0Ax3Iori4Ynbzs=;
        h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:In-Reply-To;
        b=LzuQzqsSJflcFs53gxhGcmzQN//7eCGzo9Rj8S67jM8Dgv7uKow78+Edh/yxlXkB4
         KKMTb2q4YL2SfHSvGEHOZyOd7fWPt4VDsORbGAnmTVjS9CBsTcTESqJEEfTkuSM+fy
         n5t3GDctcip33ebeNii6ZRN1byblqxzQ0PN5oXKU=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.29] ([79.203.31.99]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MOm0x-1oMDAl07Lj-00QIwA; Wed, 15
 Jun 2022 19:05:04 +0200
Message-ID: <d0c2281e-1860-0808-8e80-9881d7d5cd63@web.de>
Date:   Wed, 15 Jun 2022 19:05:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.10.0
Subject: [PATCH v4 6/6] archive-tar: use internal gzip by default
Content-Language: en-US
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Rohit Ashiwal <rohit.ashiwal265@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jeff King <peff@peff.net>,
        "brian m . carlson" <sandals@crustytoothpaste.net>
References: <pull.145.git.gitgitgadget@gmail.com>
 <9df761c3-355a-ede9-7971-b32687fe9abb@web.de>
In-Reply-To: <9df761c3-355a-ede9-7971-b32687fe9abb@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:bik/D80M1Nkm2hameqZ/xCOWl59mrBR2flDi8W2x1GXPoBshkVD
 EIFB7PBsi5rfJe0rVZkQ32Nc4Vlxz3V5w6ottT9j9uIx+r/G72sjIfcGSHqm37FVT7o150u
 EItV3/+gr2UBkjpJyJaG45JgcAA2GGQdb+V3IYwaA67mjMqC/GzipdMQ5G7835uTQpTkHkn
 YhBYU+pMTYAP8tYNYiVKw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:TLsFjttL2F0=:boDO4TZpEj8spBS9OBqZNt
 zyj3Ih0fzPRuAcsCS9HXCZ5QN0r49Li1RXwKBa+nbGiTYwjvj63GXyKXvFGnJmSM5JpZ0N6w1
 NEU8JoAcGmAp+s6ldszf/i9W4oXlMMfFS6U6/1SCv3ov5xOEKHv1Flw9n4rEVlOsv/BpF6isv
 /2fgquE/tkVOAskoEBqtYBhNC5cLRGpnCL/nkaqduBFPSpKnW0xjwlZqbhikHgn47GgpPC2KP
 XxOVjw3vTw7ufojmFrYyqK/x6Ti/ksesYiRktBiG3pOY7tYCBTjw39iBuVA/eu2rZSlkxUOXl
 +5Y1gmKZkl83DnSvPuxjzy4JfbrAFhvDQE9e5DvykWZ+dreDMg5Q1w+xbpNMMldweruZNClUl
 FVwuD/dXj0+VrC/eGn/07ycy6nNh9wJsnB8YpyuNZN9WaDZUeEqM9oq9s+oQrf98yodioIe5+
 +yx3foCznBkbRTlyNW9UZIYqBFUMYBD/JZCCJKiG/5HXaDIWRaOoCg+ilO0B5N4FyvLmCHOar
 p6SCqWdOhxwIih8tNZyWZSTAiaMT50vPeM+4reyBE+poNuzBLFbbsLo7QWcr+RNOEv8S+333v
 tZMpUJTZfvNZ1KKevVWKJSa6FRxIlPtZttCFfShTsKtkcBVF2C3eO2CREsxIDYU4wegncv+4d
 qIK6l7dJFzR0u+l36tB2m+SfwCrHU+dXHnCw2XbxWWVB+Q3mp0JX0c4Jevx522WM/ol1lEoOV
 1iMTotS08kG+IxdbPshJ02+m1qi0efScq0+dqjzMPHuOJzE1OmlcWqKkyU53MPl8VgOQGNcg0
 0SFavn2zKdVsNhLyrOii5Oa6xj19u+IMg9N+785hd/6C43exT1ub6JVoWPVxwHci/HCeA5c/0
 2So+KoHdNPepA/YG/EeTiMd7SChKMLMie4ypuZkNjBOkeTQQF/eitlvKzgjlducnMdN4Qb2ME
 fCPD7PoGvrmpak3gh8/by6ig0mHaLYl2V8+npiFXm4QNCFcI1MRiN3iLqCmRdR24NCDAh0g/G
 oe0OX3KzZO/QtVD/rUpUJAeWQ8Ac20dNjsAiJB10nLXl4FOLZ/uHLoONytJSzGXYABDbLQDeT
 TNkLhd/HY4mVCMoprk2tSpBbM/EeQXJiyqa
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Drop the dependency on gzip(1) and use our internal implementation to
create tar.gz and tgz files.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 Documentation/git-archive.txt |  4 ++--
 archive-tar.c                 |  4 ++--
 t/t5000-tar-tree.sh           | 32 ++++++++++++++++----------------
 3 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/Documentation/git-archive.txt b/Documentation/git-archive.txt
index b2d1b63d31..60c040988b 100644
=2D-- a/Documentation/git-archive.txt
+++ b/Documentation/git-archive.txt
@@ -148,8 +148,8 @@ tar.<format>.command::
 	to the command (e.g., `-9`).
 +
 The `tar.gz` and `tgz` formats are defined automatically and use the
-command `gzip -cn` by default. An internal gzip implementation can be
-used by specifying the value `git archive gzip`.
+magic command `git archive gzip` by default, which invokes an internal
+implementation of gzip.

 tar.<format>.remote::
 	If true, enable the format for use by remote clients via
diff --git a/archive-tar.c b/archive-tar.c
index efba78118b..3d77e0f750 100644
=2D-- a/archive-tar.c
+++ b/archive-tar.c
@@ -526,9 +526,9 @@ void init_tar_archiver(void)
 	int i;
 	register_archiver(&tar_archiver);

-	tar_filter_config("tar.tgz.command", "gzip -cn", NULL);
+	tar_filter_config("tar.tgz.command", internal_gzip_command, NULL);
 	tar_filter_config("tar.tgz.remote", "true", NULL);
-	tar_filter_config("tar.tar.gz.command", "gzip -cn", NULL);
+	tar_filter_config("tar.tar.gz.command", internal_gzip_command, NULL);
 	tar_filter_config("tar.tar.gz.remote", "true", NULL);
 	git_config(git_tar_config, NULL);
 	for (i =3D 0; i < nr_tar_filters; i++) {
diff --git a/t/t5000-tar-tree.sh b/t/t5000-tar-tree.sh
index 9ac0ec67fe..1a68e89a55 100755
=2D-- a/t/t5000-tar-tree.sh
+++ b/t/t5000-tar-tree.sh
@@ -339,21 +339,21 @@ test_expect_success 'only enabled filters are availa=
ble remotely' '
 	test_cmp_bin remote.bar config.bar
 '

-test_expect_success GZIP 'git archive --format=3Dtgz' '
+test_expect_success 'git archive --format=3Dtgz' '
 	git archive --format=3Dtgz HEAD >j.tgz
 '

-test_expect_success GZIP 'git archive --format=3Dtar.gz' '
+test_expect_success 'git archive --format=3Dtar.gz' '
 	git archive --format=3Dtar.gz HEAD >j1.tar.gz &&
 	test_cmp_bin j.tgz j1.tar.gz
 '

-test_expect_success GZIP 'infer tgz from .tgz filename' '
+test_expect_success 'infer tgz from .tgz filename' '
 	git archive --output=3Dj2.tgz HEAD &&
 	test_cmp_bin j.tgz j2.tgz
 '

-test_expect_success GZIP 'infer tgz from .tar.gz filename' '
+test_expect_success 'infer tgz from .tar.gz filename' '
 	git archive --output=3Dj3.tar.gz HEAD &&
 	test_cmp_bin j.tgz j3.tar.gz
 '
@@ -363,31 +363,31 @@ test_expect_success GZIP 'extract tgz file' '
 	test_cmp_bin b.tar j.tar
 '

-test_expect_success GZIP 'remote tar.gz is allowed by default' '
+test_expect_success 'remote tar.gz is allowed by default' '
 	git archive --remote=3D. --format=3Dtar.gz HEAD >remote.tar.gz &&
 	test_cmp_bin j.tgz remote.tar.gz
 '

-test_expect_success GZIP 'remote tar.gz can be disabled' '
+test_expect_success 'remote tar.gz can be disabled' '
 	git config tar.tar.gz.remote false &&
 	test_must_fail git archive --remote=3D. --format=3Dtar.gz HEAD \
 		>remote.tar.gz
 '

-test_expect_success 'git archive --format=3Dtgz (internal gzip)' '
-	test_config tar.tgz.command "git archive gzip" &&
-	git archive --format=3Dtgz HEAD >internal_gzip.tgz
+test_expect_success GZIP 'git archive --format=3Dtgz (external gzip)' '
+	test_config tar.tgz.command "gzip -cn" &&
+	git archive --format=3Dtgz HEAD >external_gzip.tgz
 '

-test_expect_success 'git archive --format=3Dtar.gz (internal gzip)' '
-	test_config tar.tar.gz.command "git archive gzip" &&
-	git archive --format=3Dtar.gz HEAD >internal_gzip.tar.gz &&
-	test_cmp_bin internal_gzip.tgz internal_gzip.tar.gz
+test_expect_success GZIP 'git archive --format=3Dtar.gz (external gzip)' =
'
+	test_config tar.tar.gz.command "gzip -cn" &&
+	git archive --format=3Dtar.gz HEAD >external_gzip.tar.gz &&
+	test_cmp_bin external_gzip.tgz external_gzip.tar.gz
 '

-test_expect_success GZIP 'extract tgz file (internal gzip)' '
-	gzip -d -c <internal_gzip.tgz >internal_gzip.tar &&
-	test_cmp_bin b.tar internal_gzip.tar
+test_expect_success GZIP 'extract tgz file (external gzip)' '
+	gzip -d -c <external_gzip.tgz >external_gzip.tar &&
+	test_cmp_bin b.tar external_gzip.tar
 '

 test_expect_success 'archive and :(glob)' '
=2D-
2.36.1
