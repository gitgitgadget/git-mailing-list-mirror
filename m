Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46FBAC64ED6
	for <git@archiver.kernel.org>; Tue, 28 Feb 2023 16:13:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbjB1QNp (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Feb 2023 11:13:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjB1QNo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Feb 2023 11:13:44 -0500
Received: from mout.web.de (mout.web.de [212.227.15.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E8541B2C7
        for <git@vger.kernel.org>; Tue, 28 Feb 2023 08:13:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1677600812; i=l.s.r@web.de;
        bh=cBFn/RtrjgLDPasWmYTtPhaX875Tj1/GoVJVAvHbHH8=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=fWIMFVsSUq4cV5kXB/eNyqiRmzMjLWfF4PpDPz7VlE2dfff0V1MDmbulwQx1seYIW
         ZrTzS3kQe3HsGtJPE1Ee+Rg72Yt/MkOoSsLGopR2F0VqbT/5LbUPDY82hE1hfovexz
         9PUxIUUQFH8kibbbx/prpPojIAcrxpyVBMRtThNB1WT3L5iWo7qrUSTy638c9tzGvF
         m7N8eGZjkJ+saO1Z6uff0LWPwowAP3A14FBLsv3Uqhq1V/K3YF63IYhb6YAy03W2OY
         y2wkMkXvJ5AVyUJSyu/YC9CWpxqPFUTEGzZS7ohTfmLDRjGXII8ERu6J2pDplArgY5
         96GN+gshBq1+A==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([79.203.21.51]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MW9vi-1ozXRm0luk-00Xq5Q; Tue, 28
 Feb 2023 17:13:32 +0100
Message-ID: <1156586e-9dbe-335e-7e33-74eea7913e86@web.de>
Date:   Tue, 28 Feb 2023 17:13:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
Subject: [PATCH] range-diff: avoid compiler warning when char is unsigned
To:     Teng Long <dyroneteng@gmail.com>, git@vger.kernel.org
Cc:     avarab@gmail.com, tenglong.tl@alibaba-inc.com,
        Junio C Hamano <gitster@pobox.com>
References: <20230220142444.18739-1-tenglong.tl@alibaba-inc.com>
 <20230220142444.18739-2-tenglong.tl@alibaba-inc.com>
Content-Language: en-US
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <20230220142444.18739-2-tenglong.tl@alibaba-inc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:mjDnBSTSeVM+LHBer+FOB5u+yPcbEW2LFfDdroMOym1vjlITGxG
 bQ9fAkBTIghS0V91BUEyIzGwyI+EXOtiydejdOQeHLHd83QpfQyGWvtTumvo/cJ9Gb4ROCd
 LDYENe3Tu67Q4ETlpYsIjSzWevkheE6nr/2p2yjiIBIkOQPOcER7JDyo65w2AHLaddWzaon
 OGTVpa6q12hM/QfcDwtkA==
UI-OutboundReport: notjunk:1;M01:P0:brf4EOGyKcs=;U9ciWah6lIrDL33TokvuOh3hhtz
 iHvLiIzQgg25lg/q0dgOXm0boqQpcIA7FGKAZJ+/V+gdm8m0W/xXGqh1eq9Bn2byK/nlQ11OJ
 iqiVxCwxRI9vHGxhI+DVnY0gofWwt/obPsbgd0P60N86kxUShAjswKnbcjiKPw4B0f245is12
 XeLO3tSgEL3PJAc61UW0rs6iVCzbI/iAHccj/R2DFN61YzaHj6tWbhJ8A70eFNMGV4lxqs41s
 ypG0R7TquWYyjKK3L1hKAtA5TuU26pH1Ln81onZdtfXBjgjauscn9YOW5lqgWFITuxR05ajtX
 vphL3Ws3LyrOiPy8tj2N1S9/MOvazo53b51Yo5VEekOEm8XpjHIBnJcPMQ2P46miPae003h4i
 +RyzfjJtdXYv/XcACrQm4FK1zrnA/2X+1Qwf7dtAeIOdILQNmIMbEeWvnAo2A05vBD3EIllo1
 nPBSY6mIShYggO2wlUoYid9V7GfPU/qOXgZJxZgu+/xOjVXVB9XVtu9s46NdmQ2mt59EaHJqC
 XCnRPpy7/UePO24zFFGjrAktmqrM5Je2A4XVmaK+Mr7sY9bFe+gu0nNqJfbgYwRdBSsPwLoQl
 6PEAIZAVEPZvuuhxnC2PJXLYphg1oo9UVwuquaUABkdqUrXQOXhfs9j3KdWYiKF8pR6RV/t99
 xPVqmOozvHLLuDraB4L8LoGlbWT8GEyy6nSbiMfeE1wYaD/+lQnIwBXFisfpMOtyFD1hZRSpU
 FI6aue/F9c4pHLxEa5PUD3DdfePZPu3CCs8UoeTWlb+zWm7M+thXiXApgwozZbuKl7NVkpKha
 JU9lyPIIDtfdRw0O4qzCxVRB0pA6nGtBxGkDQYd9xlD1z0RTr+ACqqhk25PclkLEjWsn7Mr+K
 2JXR8jxeB1h9U4FI4Cy5w9tJx6J6VlhEFOEG1G5KVdrYoV2Da6mgrHWhLByXsJl7z0TrUicDL
 a8g3UrQ64Ylmdfm7roGdH7mrae0=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since 2b15969f61 (range-diff: let '--abbrev' option takes effect,
2023-02-20), GCC 11.3 on Ubuntu 22.04 on aarch64 warns (and errors
out if the make variable DEVELOPER is set):

range-diff.c: In function =E2=80=98output_pair_header=E2=80=99:
range-diff.c:388:20: error: comparison is always false due to limited rang=
e of data type [-Werror=3Dtype-limits]
  388 |         if (abbrev < 0)
      |                    ^
cc1: all warnings being treated as errors

That's because char is unsigned on that platform.  Use int instead, just
like in struct diff_options, to copy the value faithfully.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 range-diff.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/range-diff.c b/range-diff.c
index 086365dffb..4bd65ab749 100644
=2D-- a/range-diff.c
+++ b/range-diff.c
@@ -383,7 +383,7 @@ static void output_pair_header(struct diff_options *di=
ffopt,
 	const char *color_new =3D diff_get_color_opt(diffopt, DIFF_FILE_NEW);
 	const char *color_commit =3D diff_get_color_opt(diffopt, DIFF_COMMIT);
 	const char *color;
-	char abbrev =3D diffopt->abbrev;
+	int abbrev =3D diffopt->abbrev;

 	if (abbrev < 0)
 		abbrev =3D DEFAULT_ABBREV;
=2D-
2.34.1
