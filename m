Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58222C4321E
	for <git@archiver.kernel.org>; Tue, 29 Nov 2022 12:22:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233003AbiK2MWo (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Nov 2022 07:22:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233193AbiK2MWk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Nov 2022 07:22:40 -0500
Received: from mout.web.de (mout.web.de [212.227.15.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E1952669
        for <git@vger.kernel.org>; Tue, 29 Nov 2022 04:22:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1669724547; bh=WnnfKfjhZ3SoEJZflXoQGOVFFRGqnPKvi8AVNNTGWdw=;
        h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:In-Reply-To;
        b=PtsJ6sKmupZ8UtDd7TQtwXqhBdULXNvpJxap+a5MurhePd3LllnUgkjd/kvigmUtZ
         B6T+/daPE65c9TK/sVMvLuigWXUTJWPOLrnRg4KtNVFapnpcdg0LxVmFf6Gzi7qWPW
         W8tEMb+De8F8BMSZCeyIjcx7TIdjgaT8tjQpgpABx3EPt98wL2nuh1EJwAX7CZiwwn
         wiz2woVok2fLavt7m1TspRBPxlxvcv3OiFfcV5FyBuRxRkeMJpP1BlYZM+iaEnul4s
         zoueR24aNLYARnzxFpxT6cyt1cdPlXzf+szZM+/mTGJZZlKGaUgFZ3MAVG8Iv96ZfB
         eQ7fCfIyGc1Eg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.154.159]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N8Epo-1ovKrL1L2e-014FhG; Tue, 29
 Nov 2022 13:22:27 +0100
Message-ID: <4d5a63e2-e4dc-1f51-cbfa-621c7bba0d9a@web.de>
Date:   Tue, 29 Nov 2022 13:22:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.0
Subject: [PATCH v3 2/5] t5317: demonstrate failure to handle multiple --filter
 options
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
X-Provags-ID: V03:K1:cFCs015rZfX29l9xQ3OUcryUHQNNDKTYrnMjSRvDnEBLFPUT+Ph
 1QEr/EZH4Ch/7fGtYzKWs5rk12SNUDsy3IrqinJacYGfXxgPmutJoiKfS/D+E/TuTh0Q2cb
 EOeTeWjeOjHMWTXfm8bnK6uV7yyH4SmReN6M/9sSqpESxuBk241dV6O4vcZGK0DYntAV3Sd
 O/DpqmhL4cL7jt9aGEdMA==
UI-OutboundReport: notjunk:1;M01:P0:WAfA435D+Z8=;17nZt31fa9CkxGV+7NvZYyAOG81
 IAOU+LXIcQuEzJWwofcld4HJypvhuIkgexjRD0magpxetEICUo3vQHzMqE65Idbgz8SZooAXw
 P0rqWv/Fb+g5URWLJDnxVacC7LZM1SrYHkN8YI/vArM+xrXMx0uAwrneKgNGo0ErgAGijyHRz
 AYZesh/8ZS70F0Mmlb/KcSMLTN4OPpQ40eMZ9J9aHMlQfULhBNhh5HMoTE5C4YlaQQoYOd0vN
 A5OK6QjgID4YCSQuy/NvoguKfGrTvSCLJIo6v/mQc77EOsKTMHYONZOTn11a/LZruE+jus2zX
 nJ/gyOGcLMoCanswU+3hDqS09DQ0DVasOVwWy+CKHizu24EN5gnlHpIwXzPp4cJcUMy/fmoMX
 SoZsQeJiVNtTCD8QLg+askaX2v20PloaUGVNJ8XBzO9Goe3utO+3rWyQmVQHEZ2tVDlMnW1yH
 zrY2JkNCH3ECnEfp66tBWv7F+wLApnu6fmHbclojBE8jGDmVgvzvNXZnm2aiUF+Ge+dPVIdw+
 Baq2xOVLAk2VVIwmhwVWsMvyELRwVpiAF6NeJmdz0m2JXWhLq61TbNbdK0vv80lDgA/Wf9uVU
 oJYZavGcnWlOUKx5WkwMe68nU9WN+OsfLXoy4344Kmj1W/fGbS5gvJFXlg7uOd+PRSHuaN4b3
 75h3HubfABOP19NXa9rBGQd3kjX1lfvz22B5rW/Tu0wtNUsoll0qRLNmojbRxMUHY+QTFlpzx
 cMVHrb9/zslkn9UO8xWBfldYqErlqbSXF9dkBRda9DzDRxMwiy6NOE/DpJPqZ4XjL/wAPrukE
 pI2kN0oQfK8s5nl0pd+Qp0cHFj6xk92J6C2/JBhsMpr/Jb5pKmGvYyJL8YIM7/Q9Mg/tHKhtg
 kq5w0ODah/kwmNgaZC8JLWg1jCcjhb2h4DUXuuZFZynCAq2uWcFoDQRNE5SDBkUeqoz8uWnFJ
 OsnY+RQ1NZLHHYqXYyqYaIqT0yQ=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

git pack-objects should accept multiple --filter options as documented
in Documentation/rev-list-options.txt, but currently the last one wins.
Show that using tests with multiple blob size limits

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 t/t5317-pack-objects-filter-objects.sh | 38 ++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/t/t5317-pack-objects-filter-objects.sh b/t/t5317-pack-objects=
-filter-objects.sh
index 82a22ecaa5..25faebaada 100755
=2D-- a/t/t5317-pack-objects-filter-objects.sh
+++ b/t/t5317-pack-objects-filter-objects.sh
@@ -265,6 +265,44 @@ test_expect_success 'verify normal and blob:limit pac=
kfiles have same commits/tr
 	test_cmp expected observed
 '

+test_expect_failure 'verify small limit and big limit results in small li=
mit' '
+	git -C r2 ls-files -s large.1000 >ls_files_result &&
+	test_parse_ls_files_stage_oids <ls_files_result |
+	sort >expected &&
+
+	git -C r2 pack-objects --revs --stdout --filter=3Dblob:limit=3D1001 \
+		--filter=3Dblob:limit=3D10001 >filter.pack <<-EOF &&
+	HEAD
+	EOF
+	git -C r2 index-pack ../filter.pack &&
+
+	git -C r2 verify-pack -v ../filter.pack >verify_result &&
+	grep blob verify_result |
+	parse_verify_pack_blob_oid |
+	sort >observed &&
+
+	test_cmp expected observed
+'
+
+test_expect_success 'verify big limit and small limit results in small li=
mit' '
+	git -C r2 ls-files -s large.1000 >ls_files_result &&
+	test_parse_ls_files_stage_oids <ls_files_result |
+	sort >expected &&
+
+	git -C r2 pack-objects --revs --stdout --filter=3Dblob:limit=3D10001 \
+		--filter=3Dblob:limit=3D1001 >filter.pack <<-EOF &&
+	HEAD
+	EOF
+	git -C r2 index-pack ../filter.pack &&
+
+	git -C r2 verify-pack -v ../filter.pack >verify_result &&
+	grep blob verify_result |
+	parse_verify_pack_blob_oid |
+	sort >observed &&
+
+	test_cmp expected observed
+'
+
 # Test sparse:path=3D<path> filter.
 # !!!!
 # NOTE: sparse:path filter support has been dropped for security reasons,
=2D-
2.38.1
