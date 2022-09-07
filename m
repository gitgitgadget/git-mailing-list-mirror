Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F31BC38145
	for <git@archiver.kernel.org>; Wed,  7 Sep 2022 11:37:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230252AbiIGLhS (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Sep 2022 07:37:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230021AbiIGLhK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Sep 2022 07:37:10 -0400
Received: from mout.web.de (mout.web.de [212.227.17.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AC5F1837F
        for <git@vger.kernel.org>; Wed,  7 Sep 2022 04:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1662550623;
        bh=sjT/dYIfRuIn2tyJ8mHk3O2LIHbpka4UMHJv1orwl40=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=Xxl21tvL58svSa2yrSkieAHHlYNCexwJq75VyG9dKrRyBSzfFNl7Dump6GrTAdKXU
         ZcHEstrYX2EuR5Wcvlfko2RsyaBwxLiHwSZpl5sc6NiZD/MIRPRxiYiv5/kf99GBOo
         JPVt2U1oFgFFUNWZC3ghqBwOa9TV1rOwVoa6hsM4=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.29] ([91.47.158.123]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N14tM-1pToJh25Wc-012Pnk; Wed, 07
 Sep 2022 13:37:03 +0200
Message-ID: <49a40ff2-757a-5d7b-4146-7e8b35884ae8@web.de>
Date:   Wed, 7 Sep 2022 13:37:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.2.1
Subject: [PATCH v2 2/2] diff-no-index: release prefixed filenames
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
References: <xmqqilm579hc.fsf@gitster.g> <xmqqilm51gn6.fsf@gitster.g>
 <181c029b-8b36-4b04-30f9-97a3f252bfbc@web.de> <xmqq8rmx1saz.fsf@gitster.g>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <xmqq8rmx1saz.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:/0gvJeWrWYIO3zRUQTiI4qMHP1vzfEgsJYED+JdobcjJOS850MZ
 JF1PkrDKK9ZGw5Ccciu7r2e0LV9R6q4eBY8FsyKQFRd7iwQSS3r2Za/S9AXGQcNBMAXMdA6
 5p/q8jP1zOUxi8gIICY1UBRD6ChkfsEDgRdMH31bQ1JP3bBfepDXzS3h55JtGQEus+TDSve
 /pFGVRvxrZB5JFJ/VEHCg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:vj0qSp2+4GA=:borlASGQ5+xf4fDU2u50+4
 SW9h2mHQNMECm2iUH5mcbz28crxuUQYS0+/7nf7f/NHG+lFMJc9bqG9iKWEldHi8NkEdkmacD
 xZvO7yjfEfp+yT3S/n37IxU3cUe/5o381rs6JP83RpRDULNXqZFiBLASGv2Hb2Ezy5jHX716r
 KbprxcWTvnTPv2tw473Lce3diXCLv6thP78H1iml0AaOLd4CRxWARIFQiFZASBnELBNMC+oc1
 OxnSrx9nmdAkr72/wQ/cPyUEDUhQIR5wKg+D+5QiplDrAlgj7QAHdfvOeYqooQYUAvyY6uRTN
 3nmkxOVnsBw3nmxXts7mSULuVi+Zp7MiyiL2wRnI6IeGLB0nfuaLR+3zU+tWzEL0CMfAs2Tnh
 Fmw9QNPOBSEb6ByJzV7N9n3329ukdO/8G+LWFmX1mngMaj1W4CpvwvPVZIcjIUvyxR3W1RLlm
 NofWlXkWz06ei/wtmKQGvcb3eZaK8RHnsEEmSVux10Hvw3E5lU8swI2/sEg5fXN+z9mZc5niZ
 Cyyt3OY17kKHqa4RV6ZPOFdnLMcF+w6RdI5ktBSZUbgzVnVf45LBifSTCVavlC1dnTZWF+q1P
 6vOsxlKZF2xBKFpGpqNaMSFU48A2TNZG69XVcvhA2s/QWU7Ztvhz5pOiLmwd1gRlfW+KSPfb3
 1gnalfrMnyrYTau5yAwWvL2QdOO5PbBeKrL/rJcKx9Z/Jib6xaeqRseCW18N5HQQKFVPk5vHh
 nWLdZ2lVDKGetLkGjj7PNq14qUFkVeEf33rI3bWPaow03S4buEBd22v55x8NpUDpBbBwAxqh0
 xzsBEDAFzu9ypMYoukubMiNL++PUdnmECEjO1UWUvOeFd6VO3E8b0S/YSuoX7K5eiSA8J8BJx
 iltTXsfK6m2AwS0ULB2CfDAkQ4+ZC7Vlr5d4I1GREuMuEra4SSrc8Etqqk5oofAPAOz6uGQSu
 3ZZw5DIu81t7pydD+eCom6gUYh2a6HYs1iQqk1Dh5oMar/VegnGDVxoq71ylR6RS3GAGLBapU
 NK/130L7rl5dkhSvz37KbVV8U+VnqDTXc8J/Q2Pod6EraPRCklAVUIN7ln5R/yuMzp/lFH6OC
 EAMSZ6w4Jnk/j285rIpZMV9AjmcisdeeogH2akZ7oRjEf+pvoKoz+blRpdrxxrpSNcCm/Dc7g
 jBJLY=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Callers of prefix_filename() are responsible for freeing its result.
Remember the returned strings and release them to appease leak checkers.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
Changes:
* Use ARRAY_SIZE twice instead of hard-code 2.
* Clarify message (s/Remember them/Remember the returned strings/).

 diff-no-index.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/diff-no-index.c b/diff-no-index.c
index a3683d8a04..a18f6c3c63 100644
=2D-- a/diff-no-index.c
+++ b/diff-no-index.c
@@ -245,6 +245,7 @@ int diff_no_index(struct rev_info *revs,
 	int i, no_index;
 	int ret =3D 1;
 	const char *paths[2];
+	char *to_free[ARRAY_SIZE(paths)] =3D { 0 };
 	struct strbuf replacement =3D STRBUF_INIT;
 	const char *prefix =3D revs->prefix;
 	struct option no_index_options[] =3D {
@@ -274,7 +275,7 @@ int diff_no_index(struct rev_info *revs,
 			 */
 			p =3D file_from_standard_input;
 		else if (prefix)
-			p =3D prefix_filename(prefix, p);
+			p =3D to_free[i] =3D prefix_filename(prefix, p);
 		paths[i] =3D p;
 	}

@@ -308,6 +309,8 @@ int diff_no_index(struct rev_info *revs,
 	ret =3D diff_result_code(&revs->diffopt, 0);

 out:
+	for (i =3D 0; i < ARRAY_SIZE(to_free); i++)
+		free(to_free[i]);
 	strbuf_release(&replacement);
 	return ret;
 }
=2D-
2.37.2
