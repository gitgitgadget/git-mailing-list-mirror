Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16DA2FA373D
	for <git@archiver.kernel.org>; Sun, 30 Oct 2022 11:47:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229802AbiJ3LrL (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 30 Oct 2022 07:47:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbiJ3LrK (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 30 Oct 2022 07:47:10 -0400
Received: from mout.web.de (mout.web.de [212.227.15.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45C56C2D
        for <git@vger.kernel.org>; Sun, 30 Oct 2022 04:47:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1667130423; bh=1R6QDc7nNQhEPKz47mDhFf0HX/0OCep8fX/4pqMkC3c=;
        h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:In-Reply-To;
        b=IgDN2opEB2rR3MdcnvakJ60dNQkIn+HSXfSRO2vwR6U/4lAI467+naBbgpvkZmIaf
         TEk0UIsTVftda65rTS6rNZv2Ul/lUOv+o9B9dd15QW2S7yrerDHYCNf39G0Ec5NIWu
         0mMF6A0oKwCyISHtFGqb8q3UGyY9CAt/qwVXymYmpSjTi2Km1usIX0DDshk7bRFUIu
         Vvnwf4WXzufoGo/xKdkenisl/eo2ElDLFkqtaVYob75s2f51c6gGGMLy4umdod4zC2
         bRdNJuepe4P7RdU/qSu7Jz+tcKNBlVGcVT5m1W+RJEvG7QZ474Gu7wX2Mq0tNKU3s4
         NxztPC6Z5vS6A==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([79.203.23.191]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MpU1w-1pPWyx0RYK-00ps4D; Sun, 30
 Oct 2022 12:47:03 +0100
Message-ID: <78a5fb6d-4728-e6dc-a3e2-2d38c95ad381@web.de>
Date:   Sun, 30 Oct 2022 12:47:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.1
Subject: [PATCH v2 04/12] bisect: simplify building "checkout" argument list
Content-Language: en-US
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
References: <7407e074-4bd8-b351-7fa4-baf59b41880c@web.de>
 <ea061164-b36b-485c-963f-8c13e813a47e@web.de>
In-Reply-To: <ea061164-b36b-485c-963f-8c13e813a47e@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:QemJmEfPvvMV0AeX1w5e5kBLvudmvlgmhnQUyjLlnF8G6rlqkpx
 mhkHV0CKLYvzitn2Ilc8Ff0S2U4ZZrm4qymvl314Ot1M0YrvPdDLND78fjTPyUiK7N0bNnu
 8+uPmZ3Phtm/JEUMEkfbQAzLMD2SXI/KNd4sC9nIqhoA0YOqsLeIhzki8VDmiQ1uGB1YC9D
 NTOZYbvgpFTbzYjJdB/zA==
UI-OutboundReport: notjunk:1;M01:P0:jDhFse6RQg0=;Oj0OEJ4rvNZgT62RyHU+k1/uHpS
 XJNEcMB2UJUUKmeinHHAwWta4pd6jzG58KLEiPpH/F+G9z0PayGXwkLAfBzRvEuPW9u4P6+Y/
 XY3i/vinbnK+iNRPG0dip5tWPwWSuJUnjblAWSNurk9AG5tiyLBu+bpn92nemVEQLaTOCToNx
 EIBIh7AC06pWcrpXEOhCbrRNX5tc8Wvb1eNwCZ83cA6AANJ/2bVqC/T9fHg+Xjn+eCg93lZFl
 +CxW59rni28+hbnTzoqijuCYgfhvMqEhJM0W1zy8aVclMID50Y5WP5iF2gwHBKH+vXElkH1cy
 CL5KiP8VAQWBHz2uPYpfPOuSYqIqj3rCBGFGLAB2ccmY7Fk0dXqTZiAnmwaI6Fa6sh6u6uGWk
 vzgnAc94jda4HtShCneNpahqBqeUV9uA9CLZPFiEiLnShHXlrdqQNTICuaybe1G8kxWLjhnhF
 UgA4Hoe6rc2iQSe4lpgmYPnFZFUQ6MzbcO2pZhiB+MmuXUrUyxDNYgNyRlR2alLcOU1JkStze
 uaUGdYt2lSecuoymZNsAH+qB7M0mUG3SnMfArFGtZjs+vitmvksTDimdWw/dJyosyCU1Yfblt
 kanhymiVqDBR+wuRg1Uf3dzoxXF8pXVV4dWQw+pbcRM9uwgQSXCqpNCXScdhd4f+rOw5LKXkq
 tZWdNY6X+R7qtlacyQLd0UIUDYlf9g346p9jRJxa09LYRbZX45lxVWuMWXZM3mK1rw8xnkE6C
 hl8drcUTbA3tVgwvIxlSOIh3G6g1FRdut2dJnwhMEAF5l4BBGRkN0LMnd4rg5jTJt/rfcNRUb
 UBnWFVRDuPnYqZ+V0y5C+67PqiXYQzCO/ordHjkLWmG7jTJ1FEsRxVpkJUNmq8Up8TYisKiAu
 IXKc8KMNTrCyqhECBi+X/UUW5viDBOk+tlhbIN5U3aIfs4GNkdz/Gdan8kHrYSgg9O8EpTuIn
 gPyglsSzIhITtyL+BZ7g1fnDR+E=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Reduce the scope of argv_checkout, which allows to fully build it during
initialization.  Use oid_to_hex() instead of oid_to_hex_r(), because
that's simpler and using the static buffer of the former is just as safe
as the old static argv_checkout.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 bisect.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/bisect.c b/bisect.c
index fd581b85a7..090aa5c4b4 100644
=2D-- a/bisect.c
+++ b/bisect.c
@@ -22,8 +22,6 @@ static struct oid_array skipped_revs;

 static struct object_id *current_bad_oid;

-static const char *argv_checkout[] =3D {"checkout", "-q", NULL, "--", NUL=
L};
-
 static const char *term_bad;
 static const char *term_good;

@@ -729,19 +727,20 @@ static int is_expected_rev(const struct object_id *o=
id)
 enum bisect_error bisect_checkout(const struct object_id *bisect_rev,
 				  int no_checkout)
 {
-	char bisect_rev_hex[GIT_MAX_HEXSZ + 1];
 	struct commit *commit;
 	struct pretty_print_context pp =3D {0};
 	struct strbuf commit_msg =3D STRBUF_INIT;

-	oid_to_hex_r(bisect_rev_hex, bisect_rev);
 	update_ref(NULL, "BISECT_EXPECTED_REV", bisect_rev, NULL, 0, UPDATE_REFS=
_DIE_ON_ERR);

-	argv_checkout[2] =3D bisect_rev_hex;
 	if (no_checkout) {
 		update_ref(NULL, "BISECT_HEAD", bisect_rev, NULL, 0,
 			   UPDATE_REFS_DIE_ON_ERR);
 	} else {
+		const char *argv_checkout[] =3D {
+			"checkout", "-q", oid_to_hex(bisect_rev), "--", NULL
+		};
+
 		if (run_command_v_opt(argv_checkout, RUN_GIT_CMD))
 			/*
 			 * Errors in `run_command()` itself, signaled by res < 0,
=2D-
2.38.1
