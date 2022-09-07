Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF798C6FA83
	for <git@archiver.kernel.org>; Wed,  7 Sep 2022 11:37:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230217AbiIGLhP (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Sep 2022 07:37:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230119AbiIGLhE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Sep 2022 07:37:04 -0400
Received: from mout.web.de (mout.web.de [212.227.17.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7A73120
        for <git@vger.kernel.org>; Wed,  7 Sep 2022 04:37:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1662550614;
        bh=TIVuNgPRPdInet7JGnCBXZeBj1VPDQ2qSJSnRFuClm4=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=a+1yTjARDZR1eEDl2dWQR9bZak+OWGaDSHg5J8tBL6XrDMq4h/9Lrh7dHoWPkTip3
         aV7clrw8fg/TER2hqok6rWw81xxmtqcrspw5zIzK2At6ZLV0NHe922TVLCnu8B2P6z
         Rh6cGutL0yem5B5OpxSbb+w4H3INWmn1FyoWqes8=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.29] ([91.47.158.123]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MCol0-1oej493NSK-008wwe; Wed, 07
 Sep 2022 13:36:53 +0200
Message-ID: <1aee1020-2b8a-906b-8e25-051dd6b48fb9@web.de>
Date:   Wed, 7 Sep 2022 13:36:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.2.1
Subject: [PATCH v2 1/2] diff-no-index: release strbuf on queue error
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
X-Provags-ID: V03:K1:8AWSOcwm6zdVeXK8UJUfHQbi9lc/Qpmm934e+pVbONbubkKK4qS
 zE6N3/VsYlYlzwmk6/3iUmL7sGpasNy02EGtdrRXySUMtk+0ZSLLZLo9/fl2aTFkxzOvE2d
 BrQzk3w/csw2ZnD37xdWWjOERH/o580ctMmUFbTheYtuhi0HdA16eXQMrRn0LDUIGNPe9Ee
 ooTe/mMzHidjdNGAH0ntA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Ul4gqnmBvjM=:dfO7l6qKYJPopqZXmgmVSr
 z2ccK1ICUbEX8Wxno/IYoJwAofqs/PHPo72VuJx5fz++JpLjhO99uD/6KjcHaqxgfsopT3TpE
 gOdyH8K6SRhHcjMO2efeYG1FYoNmFqCvtHdEzVqGFQWygxaEG5mPm/0P6r5abi3GOghB2TLKH
 26SHrutuaaSobPkC8Q8crVlPX8IN5d24Sse4Xpsu5iIiL1igRLMlde41e3JeMcAEB91sXFoqj
 lUDIUM6mu7GGMRofRXIgAeGLzFk+IgUmYT1VfUZN40OPjAFHslCrGI9THnn5A3CQwB1PwBr8/
 ivC3RR93FSIeoHHyqGreeeVEqfayjhBnWb3BeJJuLC3c5ROOpOScfc7COvVJ2BhXnDI4huNB7
 f+Zvcz9M+YbLsaa4vDC2oiFp2NgGl/Y8Ij+ltPyC9L5S4NzxGfnwhbXRi1GAFCCN46rGKr+fg
 IkrRKIRWl6UFFQzpLumJa8/AS+LS6Pc7VtMP26NGjMa2o88nJs5wVhUZx970yIg7JcPEWPOzM
 Ot1Yo4xzUs9wlLsWWX4kIGxH6xyjnwsRS22cleQyVKkhytH0V5KVlRz5KeASdSwa+JHwg3nKS
 tNRbHgdKtptz7TaOn5wuh57oQ/yl+Oyh+JIITOYzlvdp5wlw8Zpa69iyDbsQuaOWqW4x607wi
 /YeU4nrDXKI92+30aOOHvheFh4pKTn6PzgH2oKgqgkdjmE+IkJqEy8o1qyG17F5zo2sU66EC+
 GLPcMevEgUlcsV8IG7+u7j7Q39UmsTmCNfONFTO/4zyMY6hp/M6gkPcY2ANvhf/V8oMT5uQ9P
 AYFhm+lQp3+6fKI9NpZhQHi6PseWHT17EMy71O2HH4In2SsBk6aBH54XirXilZlZ+634kPh5l
 04V4k5DJt147iIiQXngXck/J4YHkRkz0t4BtB7SIQfhmJfPCJ7X8k+GjFnKanTVveQPjmjQFs
 V9mvgybcMYyLV6rSBxg0a+v/Wh5++Gy8QBCQmn+qaHe2sbecSTzo6c7yOAFahCXQ6+8eEgYC6
 q3NUdLaMOCIXg1H+C+L9I05GEQBON3V8As0q88wvXZDMJLy84kFQje2mrfZ5RUAYSfwLmyHAP
 k6R0S3iNv73ba5RwFIKNb7Kq2aS3laeeNNRTKHVLLsXmumYCTZs14EvLe3+5ZDUoS320TNS+C
 GUIuQ=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The strbuf is small and we are about to exit, so we could leave its
cleanup to the OS.  If we release it explicitly at all, however, then we
should do it on early exit as well.  Move the strbuf_release call to a
new cleanup section at the end and make sure all execution paths go
through it.

Suggested-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
Changes:
* Add Suggested-by.
* Clarify message (s/Move it/Move the strbuf_release call/).

 diff-no-index.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/diff-no-index.c b/diff-no-index.c
index 9a8b09346b..a3683d8a04 100644
=2D-- a/diff-no-index.c
+++ b/diff-no-index.c
@@ -243,6 +243,7 @@ int diff_no_index(struct rev_info *revs,
 		  int argc, const char **argv)
 {
 	int i, no_index;
+	int ret =3D 1;
 	const char *paths[2];
 	struct strbuf replacement =3D STRBUF_INIT;
 	const char *prefix =3D revs->prefix;
@@ -295,16 +296,18 @@ int diff_no_index(struct rev_info *revs,
 	revs->diffopt.flags.exit_with_status =3D 1;

 	if (queue_diff(&revs->diffopt, paths[0], paths[1]))
-		return 1;
+		goto out;
 	diff_set_mnemonic_prefix(&revs->diffopt, "1/", "2/");
 	diffcore_std(&revs->diffopt);
 	diff_flush(&revs->diffopt);

-	strbuf_release(&replacement);
-
 	/*
 	 * The return code for --no-index imitates diff(1):
 	 * 0 =3D no changes, 1 =3D changes, else error
 	 */
-	return diff_result_code(&revs->diffopt, 0);
+	ret =3D diff_result_code(&revs->diffopt, 0);
+
+out:
+	strbuf_release(&replacement);
+	return ret;
 }
=2D-
2.37.2
