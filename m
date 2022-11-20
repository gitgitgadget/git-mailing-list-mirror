Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95165C4332F
	for <git@archiver.kernel.org>; Sun, 20 Nov 2022 10:08:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbiKTKGV (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 20 Nov 2022 05:06:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiKTKGU (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Nov 2022 05:06:20 -0500
Received: from mout.web.de (mout.web.de [212.227.15.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D898A5E9F9
        for <git@vger.kernel.org>; Sun, 20 Nov 2022 02:06:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1668938766; bh=64RcOQPsVobNySgLG/XWXDVwZQeJNovvPvrxXvUqpHE=;
        h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:In-Reply-To;
        b=j07104eew2WrMtWnneFW/phjzm8ilBS0O4Y0lWmh0tJHEMX1CKqOWFwEbW3jZ5MPG
         Xu4KzZ0r7lSGATv8/Id7KhAVUd1HDxqVVQ/DDqYrtmjn5HYFkBMrb4+lAYmTyPeBx/
         XpDkfAcOfszfo07O3VbwDlL4pDmRCRCg3MfJZ0KCFWBwfUla59Do8jfDEf+jZ155bH
         3p+p4ZfLe6siOLPUSl4mvFc5aLDdTt1WlLvm/riRfEZsjl1x+RBXLMhjsdQ0GhuQTw
         T5wdIaLiEOVc4C64n9h3RqUC3UA/B5dxDqLk9CbapMrKpjhrubR69K+Sxb6zz96Ljn
         9DraqL7PTjwYw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.154.159]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MUUAG-1oWC9G0SC8-00QX5D; Sun, 20
 Nov 2022 11:06:06 +0100
Message-ID: <ad8df33f-cf47-4b1e-e356-d61817ccf810@web.de>
Date:   Sun, 20 Nov 2022 11:06:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.0
Subject: [PATCH v2 1/3] t5317: stop losing return codes of git ls-files
Content-Language: en-US
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
To:     Git List <git@vger.kernel.org>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Jeff King <peff@peff.net>
References: <c64e4fa5-62c2-2a93-a4ef-bd84407ea570@web.de>
 <d19c6cb4-611f-afea-8a14-5e58d7509113@web.de>
In-Reply-To: <d19c6cb4-611f-afea-8a14-5e58d7509113@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:3RITmMEObXF+9Px9NzX6oclkjuCP68eqcLB3WDW6Sd+CJ7/vLFV
 h0mKcBwoZX2U03vA5U6TWbUmWeo3fJuH8FEaUpBd7jTzpEd4IAGjq6gnn339hY9Wbb8YYZl
 DDqBXjFi8ugEaERjfidLzQk7J0VXM6ElWBSiaFeVqahIzcQlPjlRBV+35XGAo19U9/ntdkR
 FQDeomuCWwu+tV0kwzjXQ==
UI-OutboundReport: notjunk:1;M01:P0:Z0RgREgxhls=;wBnjdc0R08xG9qHuUe/Bi5EzMoi
 cnZIkL+jhN9rUBzShQxqwrNJtnjzGugmK1A6ONfepRCynfRCuMh26f0Ucm466hKiH2IunPjeB
 WAAWIGhBo5uLf1ET6pkjJ4AuXE4RZP07IppXdKFBze3u3/ZxVZ2HeoQYRdXtQk4VgX7WV/D0z
 HsT4BcJFxHI9nwxuUClIUYbMVfpnmpNn3QHcO/cOXYZgpekypx34+J6/3K3ZCQjRzcPp8Gdvp
 Ig1HDrWw778XBDMfE3IX6fStt9t6pW7iqC4SA+J9MZ1d14D77u76IT8cm3YOdb9o0NDBoTwON
 kThd5I2jghow3EPriGW6rm0zprZTOk1wlv3KX1CGsfX4w5O+Bb5iq+9vGWxFX0j5jUBhN5/o6
 F4DhGucahV4j8vnU2JWTYs9ylVeaiQRWad/T9f52TkJyowso79GpSVOmiwxjv1zqccnxgaNoM
 /no6BbnNB2OJv7zZ6pZ9AII6hHf4aTWEeakfHE02HVK098XNxHnTCBr1bOi5bGMMDg3QFTlDQ
 iZi9BBdOeLrqLnFzDdPjuWiuWxB479oE6vEFi5DvgQBdVyvc1fDEnGXRYH2xNnoS7CQo8LmHz
 6FKYvr2kFLTIjCohepeU9Evaj8sb0Js0SzK+bEdTZWJiCmgMLQM/twYDqoHjmMgzOxG8ynq1p
 Gfp9sYZiYX5f4kFvt5EQK+/ZhKllXGayElfQFVueUCNaWTY19I6caT88GGo25mwRrP8bkATas
 K0nNPy+yvGqtUCoQr8EV+GSv2b4ZT6Xe6BBu8dcftUjLTLUJVf2gykFaZiaQPOPkZwvm0Evnd
 IqmNY2G30whgs1I1fpDHR4+dCDFfmSUld97vM+KKHun0K6OGcSzaM5jBY1AxlAcyFFDlrUOsH
 HAOOrjOigSj4LWPoWWsWyGEjZ8r7YXkIXeFiGc0u1e/dM0SjMnZRbGJaYpIq/7Hjc1nM3lC00
 oo3+jg==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

fb2d0db502 (test-lib-functions: add parsing helpers for ls-files and
ls-tree, 2022-04-04) not only started to use helper functions, it also
started to pipe the output of git ls-files into them directly, without
using a temporary file.  No explanation was given.  This causes the
return code of that git command to be ignored.

Revert that part of the change, use temporary files and check the return
code of git ls-files again.

Suggested-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 t/t5317-pack-objects-filter-objects.sh | 52 ++++++++++++++------------
 1 file changed, 28 insertions(+), 24 deletions(-)

diff --git a/t/t5317-pack-objects-filter-objects.sh b/t/t5317-pack-objects=
-filter-objects.sh
index bb633c9b09..82a22ecaa5 100755
=2D-- a/t/t5317-pack-objects-filter-objects.sh
+++ b/t/t5317-pack-objects-filter-objects.sh
@@ -24,8 +24,9 @@ parse_verify_pack_blob_oid () {
 }

 test_expect_success 'verify blob count in normal packfile' '
-	git -C r1 ls-files -s file.1 file.2 file.3 file.4 file.5 |
-	test_parse_ls_files_stage_oids |
+	git -C r1 ls-files -s file.1 file.2 file.3 file.4 file.5 \
+		>ls_files_result &&
+	test_parse_ls_files_stage_oids <ls_files_result |
 	sort >expected &&

 	git -C r1 pack-objects --revs --stdout >all.pack <<-EOF &&
@@ -123,8 +124,8 @@ test_expect_success 'setup r2' '
 '

 test_expect_success 'verify blob count in normal packfile' '
-	git -C r2 ls-files -s large.1000 large.10000 |
-	test_parse_ls_files_stage_oids |
+	git -C r2 ls-files -s large.1000 large.10000 >ls_files_result &&
+	test_parse_ls_files_stage_oids <ls_files_result |
 	sort >expected &&

 	git -C r2 pack-objects --revs --stdout >all.pack <<-EOF &&
@@ -161,8 +162,8 @@ test_expect_success 'verify blob:limit=3D1000' '
 '

 test_expect_success 'verify blob:limit=3D1001' '
-	git -C r2 ls-files -s large.1000 |
-	test_parse_ls_files_stage_oids |
+	git -C r2 ls-files -s large.1000 >ls_files_result &&
+	test_parse_ls_files_stage_oids <ls_files_result |
 	sort >expected &&

 	git -C r2 pack-objects --revs --stdout --filter=3Dblob:limit=3D1001 >fil=
ter.pack <<-EOF &&
@@ -179,8 +180,8 @@ test_expect_success 'verify blob:limit=3D1001' '
 '

 test_expect_success 'verify blob:limit=3D10001' '
-	git -C r2 ls-files -s large.1000 large.10000 |
-	test_parse_ls_files_stage_oids |
+	git -C r2 ls-files -s large.1000 large.10000 >ls_files_result &&
+	test_parse_ls_files_stage_oids <ls_files_result |
 	sort >expected &&

 	git -C r2 pack-objects --revs --stdout --filter=3Dblob:limit=3D10001 >fi=
lter.pack <<-EOF &&
@@ -197,8 +198,8 @@ test_expect_success 'verify blob:limit=3D10001' '
 '

 test_expect_success 'verify blob:limit=3D1k' '
-	git -C r2 ls-files -s large.1000 |
-	test_parse_ls_files_stage_oids |
+	git -C r2 ls-files -s large.1000 >ls_files_result &&
+	test_parse_ls_files_stage_oids <ls_files_result |
 	sort >expected &&

 	git -C r2 pack-objects --revs --stdout --filter=3Dblob:limit=3D1k >filte=
r.pack <<-EOF &&
@@ -215,8 +216,8 @@ test_expect_success 'verify blob:limit=3D1k' '
 '

 test_expect_success 'verify explicitly specifying oversized blob in input=
' '
-	git -C r2 ls-files -s large.1000 large.10000 |
-	test_parse_ls_files_stage_oids |
+	git -C r2 ls-files -s large.1000 large.10000 >ls_files_result &&
+	test_parse_ls_files_stage_oids <ls_files_result |
 	sort >expected &&

 	echo HEAD >objects &&
@@ -233,8 +234,8 @@ test_expect_success 'verify explicitly specifying over=
sized blob in input' '
 '

 test_expect_success 'verify blob:limit=3D1m' '
-	git -C r2 ls-files -s large.1000 large.10000 |
-	test_parse_ls_files_stage_oids |
+	git -C r2 ls-files -s large.1000 large.10000 >ls_files_result &&
+	test_parse_ls_files_stage_oids <ls_files_result |
 	sort >expected &&

 	git -C r2 pack-objects --revs --stdout --filter=3Dblob:limit=3D1m >filte=
r.pack <<-EOF &&
@@ -289,8 +290,9 @@ test_expect_success 'setup r3' '
 '

 test_expect_success 'verify blob count in normal packfile' '
-	git -C r3 ls-files -s sparse1 sparse2 dir1/sparse1 dir1/sparse2 |
-	test_parse_ls_files_stage_oids |
+	git -C r3 ls-files -s sparse1 sparse2 dir1/sparse1 dir1/sparse2 \
+		>ls_files_result &&
+	test_parse_ls_files_stage_oids <ls_files_result |
 	sort >expected &&

 	git -C r3 pack-objects --revs --stdout >all.pack <<-EOF &&
@@ -341,8 +343,9 @@ test_expect_success 'setup r4' '
 '

 test_expect_success 'verify blob count in normal packfile' '
-	git -C r4 ls-files -s pattern sparse1 sparse2 dir1/sparse1 dir1/sparse2 =
|
-	test_parse_ls_files_stage_oids |
+	git -C r4 ls-files -s pattern sparse1 sparse2 dir1/sparse1 dir1/sparse2 =
\
+		>ls_files_result &&
+	test_parse_ls_files_stage_oids <ls_files_result |
 	sort >expected &&

 	git -C r4 pack-objects --revs --stdout >all.pack <<-EOF &&
@@ -359,8 +362,8 @@ test_expect_success 'verify blob count in normal packf=
ile' '
 '

 test_expect_success 'verify sparse:oid=3DOID' '
-	git -C r4 ls-files -s dir1/sparse1 dir1/sparse2 |
-	test_parse_ls_files_stage_oids |
+	git -C r4 ls-files -s dir1/sparse1 dir1/sparse2 >ls_files_result &&
+	test_parse_ls_files_stage_oids <ls_files_result |
 	sort >expected &&

 	git -C r4 ls-files -s pattern >staged &&
@@ -379,8 +382,8 @@ test_expect_success 'verify sparse:oid=3DOID' '
 '

 test_expect_success 'verify sparse:oid=3Doid-ish' '
-	git -C r4 ls-files -s dir1/sparse1 dir1/sparse2 |
-	test_parse_ls_files_stage_oids |
+	git -C r4 ls-files -s dir1/sparse1 dir1/sparse2 >ls_files_result &&
+	test_parse_ls_files_stage_oids <ls_files_result |
 	sort >expected &&

 	git -C r4 pack-objects --revs --stdout --filter=3Dsparse:oid=3Dmain:patt=
ern >filter.pack <<-EOF &&
@@ -400,8 +403,9 @@ test_expect_success 'verify sparse:oid=3Doid-ish' '
 # This models previously omitted objects that we did not receive.

 test_expect_success 'setup r1 - delete loose blobs' '
-	git -C r1 ls-files -s file.1 file.2 file.3 file.4 file.5 |
-	test_parse_ls_files_stage_oids |
+	git -C r1 ls-files -s file.1 file.2 file.3 file.4 file.5 \
+		>ls_files_result &&
+	test_parse_ls_files_stage_oids <ls_files_result |
 	sort >expected &&

 	for id in `cat expected | sed "s|..|&/|"`
=2D-
2.38.1
