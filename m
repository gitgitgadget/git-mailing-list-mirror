Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A625DC43334
	for <git@archiver.kernel.org>; Sun, 12 Jun 2022 06:19:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234523AbiFLGTY (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 12 Jun 2022 02:19:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229664AbiFLGTY (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Jun 2022 02:19:24 -0400
Received: from mout.web.de (mout.web.de [212.227.15.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0334239BA8
        for <git@vger.kernel.org>; Sat, 11 Jun 2022 23:19:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1655014745;
        bh=VKU4TSmiHTGdb75DWjKGpgdbGJuoyYmFY+hvStDAVao=;
        h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:In-Reply-To;
        b=npnlhlWTkyX7/xfiBB8QEH8QvhrORkz/gOwvYGdHzeBTwu7HvAxb/SE0PevgtO06N
         zGVpV2kECuZ6Stgd3WWrgsGtHqgjZ+LiklvyJTbx49QDhD/NJfonjZyYSS+6G+nvzO
         la0iWRbwGgRr+2PnpoNQALYE0R48kAMVqvzTVL/Y=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.29] ([79.203.31.99]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MnX5F-1nGnBU2e8b-00jSa7; Sun, 12
 Jun 2022 08:19:05 +0200
Message-ID: <d9e75b24-c351-e226-011d-5a5cc2e1c858@web.de>
Date:   Sun, 12 Jun 2022 08:19:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.10.0
Subject: [PATCH v3 5/5] archive-tar: use internal gzip by default
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
 <217a2f4d-4fc2-aaed-f5c2-1b7e134b046d@web.de>
In-Reply-To: <217a2f4d-4fc2-aaed-f5c2-1b7e134b046d@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:t/cny2zg2ihPzkPprkLWHcT1FM2KE89qX52UUgd5411Kyjj4bzZ
 MRNNPCfrC+GKTjn6ZClypEb+gYtsRndOVjZQ9vjzgMWJ+T81AM5cTrqsAdo7rTNjN2prwt7
 345fxkV5lSWcMpEWL8T2tR/KraOOoeOWliSL4CD1CQeapXo0Rt6FwKGkWefa1hzntGRJ2Og
 UuXkdAkmT/Hyj/6xE8D5g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:bZFEO5ja+rY=:A1RPxVq02/fNvoKsN5b436
 d1rRu4a0XYnuaSTz1c15z4amyiAh7Mv7D5e/Yj23v13ivSc7VZBl5mpoWpkS4E9BeJ+QZ+SY0
 M7/eFGfHYYNhmD0s2aotfeWhnJssbzXh55WxjQ9jq1VTsb8ZO0A6podsQ88DaSRSTQC/MdS9P
 v2ecayfGNgqZcNZhANNarbO6yPtHCP/YcsAvLK5vXVD/RXplH8akFpUeAF+mNhs2bJXlIFcyr
 ApSZ7zO+Wtnzwx8ZAR6SXZFrHfu4l9QAmCBUGrQQCIJ9F4e4IJXkrPrvdivIlb/xTOpEa7efz
 gn9E7C3xfuJTTm3n1L42mSr8ZHJuRsNYWzQQwBmG9FYf28a0kUcWaAe3FZY0Q4uQ2OJqHMTwK
 GpZFylaVTZjFadcqWcnx+6M1lvJltZ6erpQdH/iq/+w1OTA2k4lMIyvclFYbSstR/485SLr6e
 slDDYeqINJf3n316my8SUNhETLmR92Am8d9L4vh4vSrHyanNi/U1z+MbZSGc/+Ses6SbHgKxk
 rXPy0D8PvMW4tRAXVz3UDKtt/mx9RxNr/cvJjkYQi+Z5S9vEiiugVoSdYVJn/7zDg1j8Vdfed
 us+Xmj/7EIYObeTldwhPtNhL5Rh7RM4JJeFSgBicBIHC5DuDXzuwK0DZ4bMTAiaGqOxxK8Rrh
 tAs+dkRRAxrbC/rtmJzuLObpRwCtFcSTnPrfTQr1vDPnRV6Xa2OlpQD5YOuQkQBXKZG6alpXM
 mrKsK838JJMEoBYxvwGGtiaNNw6PovlRYPofdPsZNcIwup3q8R87b7sjthrumGFpbll/k6evi
 qR5it9l51/sCS/8FpS18BJ8b/7Gv0sbmdSBURLJqigdWym353UsJ8pxfBBc4slqC1yLlxHVw6
 I2TxkoAR8vnaxavJk+m+cYdps+iU1G+SjxpEW09GTRnTXoQVknAgf7tCnOII1FStqvBL3yWNA
 y1rNSN+mKAUPsilhEpndiOYBNfVrAOlDaRv0wzG1iArbYuxYEOIdZMoQzvYN/DCPxR+SAo9zO
 oABZTOxe6UNWdHRz79C7QTGvx3rajVTxStDLet/40R/shi4ICrd5lcRfjJGU27wjHKED3xJof
 liiHl+yQynnR6z7PqJxdK+mh1ajfBpnzmIE
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
index 5b017c2bdc..9de12896fc 100644
=2D-- a/Documentation/git-archive.txt
+++ b/Documentation/git-archive.txt
@@ -148,8 +148,8 @@ tar.<format>.command::
 	format is given.
 +
 The "tar.gz" and "tgz" formats are defined automatically and default to
-`gzip -cn`. You may override them with custom commands. An internal gzip
-implementation can be used by specifying the value `git archive gzip`.
+the magic value `git archive gzip`, which invokes an internal
+implementation of gzip. You may override them with custom commands.

 tar.<format>.remote::
 	If true, enable `<format>` for use by remote clients via
diff --git a/archive-tar.c b/archive-tar.c
index bf7e321e0e..60669eb7b9 100644
=2D-- a/archive-tar.c
+++ b/archive-tar.c
@@ -528,9 +528,9 @@ void init_tar_archiver(void)
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
