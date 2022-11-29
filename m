Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2612DC4321E
	for <git@archiver.kernel.org>; Tue, 29 Nov 2022 12:21:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234100AbiK2MVi (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Nov 2022 07:21:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234046AbiK2MVa (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Nov 2022 07:21:30 -0500
Received: from mout.web.de (mout.web.de [212.227.15.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85CF95DB83
        for <git@vger.kernel.org>; Tue, 29 Nov 2022 04:21:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1669724478; bh=64RcOQPsVobNySgLG/XWXDVwZQeJNovvPvrxXvUqpHE=;
        h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:In-Reply-To;
        b=lPa+IgmEXryW72LY36fo2PvG+ai9YGYfjfME2qPP9iOXMH7GcDpCkmKTNNSbmfI12
         ovfg4jcOwM1z/N4twHINj9O+0vF+gPBxfyB8jaJ32tdrTD2KXWQINnrL83COw5w4Ud
         ZVMa7h8bVHWPkW8ssTbL0I9Me60g6M1OLaocfki5dbwsN+Utn8P6lHIrq9MsBhBhjK
         O/wM5Erz5wZ32RdcCmo4P1zo+5syKchzBtZxRp/CFB8MeAQpnZ84dM7Boc9LPc06yQ
         oIdLXwKe7hxab++li/8xjhjzhl3i3l3IfzdPbFbqIvcLbuzhIkBGdBHbxXPcFTwFvv
         Rcwj4xWU6MAjQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.154.159]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MP384-1pN08P3ieK-00PMMY; Tue, 29
 Nov 2022 13:21:17 +0100
Message-ID: <05f162e2-0687-af8e-d4f8-4ab2ea003518@web.de>
Date:   Tue, 29 Nov 2022 13:21:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.0
Subject: [PATCH v3 1/5] t5317: stop losing return codes of git ls-files
Content-Language: en-US
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
To:     Git List <git@vger.kernel.org>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Jeff King <peff@peff.net>
References: <c64e4fa5-62c2-2a93-a4ef-bd84407ea570@web.de>
 <c2d3e7a3-599f-dae5-8dde-dc969df39f02@web.de>
In-Reply-To: <c2d3e7a3-599f-dae5-8dde-dc969df39f02@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:fIXgJz96tp8zGau/DgVED+F5jJV0zqDRSgTvgVlMiti6/WZcyi9
 JpjB7HI9sEkrIPFjSk3KQw7SzeQlQBBXtN8EpiO1w9UcrcQ7vq1kShdXPtLpXorqFbO7i9S
 bS4sRlO7KrE4SoIA2tdoLtepl8oM45MBFvzFVSBACLn1svhaXOKVulMH4+D4LrXaOsB/+ul
 cm4C7Te6N9wbS6qmwd0qA==
UI-OutboundReport: notjunk:1;M01:P0:cAzyDsWkt+o=;RQ/hnZqKdARfq6HiA8VHL0ZP9lL
 b/D7hlqxtybkEvvoTxYm9HfSvkjgMxJV8KZbRBctp/0//O1+DjciXlDRZQksC0CBKmPyWW704
 gAscwSg6abwf7+NWZwfgL8OvMLvp7pGbMD+zTP3Q7Nj7bh4aNIwuY6Ia57lt6KtP1Ya7Yw4sU
 n4GRDx6hKj0joLPznGmA/nHwKMhVUd9WcTigi+6zzQD2NfjMsYI1GtHaXr3veB0QqDK6wwBaG
 lJJJN8YDRY/If8UHDYxAHqruS3j2d8UXFfHuQbSdVo8lCUwK9R2C16liTkjJVx5s5HukPW1qv
 PlVgBb1qUtbHIbVIfTMB/dLLNXHh3HHi+X/CHA1UQrK3r4/CTwExoB3+YiRlT3G9yAvoj1aoc
 9vEslz4ezierDRxuKMkf4hVFTO/YVP8hFxohPh67P+w4iOEmfjI7j8QJKt7uZLbV/Mfn5X9mF
 if4sQsc/iseIwk01k5y2f4lSUTBQkjlp2CIOLR2fG8FOtyk7bLLkGlH0OmRUfDbKFBta1g69n
 N3kUBz1ssvFpNW6PXi/8WDeGGEekXx7ZIaMX71q9APQ3VEcJcUexLQzCFQj2TqD2Ha0kmnN99
 x3QQ7feMhlqI9TdsmlVdNlAWwoSgzrH33oTE4IPO/RMnAfAiAVsbzLPSTDivtABidr9rD+urb
 wAiAsStJlQGrvZlyXZwX1vrGNr62X+DZXZR7PTigcUz1wWxVnCQhK9ks8XwKcbZU+2OoO8dcK
 uZplX955IbkFuD8y/MtTrLFpW/zS5TkDRgxkdhpiQhe8DJledTBIALMwDE+TUF0KxRfHd3GaT
 N/xANvQ1Gs48pxlmLLlfsFy3lVUFFwD7hWasXojOzmgT/QEYCbLgxAFfXm8Ur2x4VcfHdl3nJ
 gSNl5FdCtpHP/T752Ktqpt6FOoNIq3Zt6XcXXaCC7UGAiGKZpsYggBXtXmJM8InTGmfwpnrgv
 a7msUG95zbixD5VT9vWmdjSeyb4=
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
