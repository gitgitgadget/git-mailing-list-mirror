Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2054AC4321E
	for <git@archiver.kernel.org>; Fri,  2 Dec 2022 16:51:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233612AbiLBQvY (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Dec 2022 11:51:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233546AbiLBQvW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Dec 2022 11:51:22 -0500
Received: from mout.web.de (mout.web.de [212.227.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDF66ACA4A
        for <git@vger.kernel.org>; Fri,  2 Dec 2022 08:51:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1669999874; bh=U0O7dWje4GtmRtvHsPX21rENkUorUyVxer6HFjJ4veU=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=ttLT/mtU/YTERc1fMBPcW2yZ6h4h8DEQBhtGH5CdazkDQXhywtvqMEsVRStMFElWB
         4mqLIqzsizte8wMWTuDcKc7VUBb542AGm0PNFlYINeCT8bUe8BTpMPpJhRxQhAVpOw
         W3uu9avr2G+owXjKbyq/cyzU7xp5OHNVYnBXgmdB5Xn+1DWVC51L3bYUe53IBK4kxN
         cnsN2wdI8Q4LBPL12zPJNGJUrFc4rrWipqiJguA6lxcK6uT3TggQmZnECOy563LKk2
         +Xo0GMiTtgTxfnvp9H8EocScNsJhE2tVgNgtCtdRHspekUWJYOlTRklTQRHywN80UX
         tyL/bDzbypuAg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.35] ([91.47.154.159]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MWi9q-1pTn2I2560-00XFUN; Fri, 02
 Dec 2022 17:51:14 +0100
Message-ID: <cbe88abc-c1fb-cb50-6057-47ff27f7a12d@web.de>
Date:   Fri, 2 Dec 2022 17:51:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: [PATCH 2/1] t3920: support CR-eating grep
To:     Johannes Sixt <j6t@kdbg.org>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
References: <febcfb0a-c410-fb71-cff9-92acfcb269e2@kdbg.org>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <febcfb0a-c410-fb71-cff9-92acfcb269e2@kdbg.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:1EKaGuOf0WnI9a/DgojWKpm+TEs1OKswOPPioDNVs1Pllq2771/
 1Rn25cFwxMYZDpnQbJZlZ0HnytuLbTQrpSOO09YjnmuzHit6I3Ysq1hD84+JsigCTFJu3ay
 WN9MfCCGRmz5UqK3IKKT/Iv0sua7x1uJEiqF44SgYV8rr/5xBTjC8gUiwatcAqoAGCfTlKb
 ZY+Bg8/aOSfbUMYqrnByQ==
UI-OutboundReport: notjunk:1;M01:P0:Rk6Mj6BBGT0=;R/ZJ8+/a0QS1/vod3UHRsRvsvtm
 4g/GcT2kRwfv59RwO5z2xo8yQSqnp8dETK2yFNTgDGWQ+fa1J/lbeBroZCSQM0VPW1qOp+u/E
 88nWeteWqf+hNmI0Rb31kT0IUBE1z/hyRQb2Ew1jyfH4IDJ3UiwtLBoRC5dMGN1z4KD+dpvD3
 yxLnMJqsSlgtV+nB9/vgrEoCRBxVHHHPJw6qjLDa1lIEHXzuUYmB9VXm/HfOEhGyKNjVg2M+K
 6tYoOvnRb09aM7fTZ4bBR/iR3ROy7mBNgihj/BHxmczFgT9CL10GQeoT90I0Ovr+CoG0/3RN0
 BbY/nRgzZq7b330afm9MDV1sDKoQdgJpnacuiMcRoWNmSI0Mf1OS56YWAy5v9CYg27SrqPE9I
 BDL5N8JZv3Cyn1IrHtdktBpK9DYkdxbMcK1Z4qGQmcK04qcwgm32lruMZDJ7M5awY2M/ppZBz
 tR4RtYbc0G+DADeBwUttvSoUPIRiuzPclpNsTJnrQ5VPBeX31ao06Ncr2MfR1CnqdrERsoKsX
 5EsT901QEI04S5fs9lwPEx+nhqjt7TXKbN10T2aO14lrlZeBvR52tH3iQ1OOckEkwvoJcJtM7
 CRR+P4fgdKcE369QVWrc3+bvRlIHeOvA1aWLCdY215SHDujcTkwV2QdX1u6lwnKstGA/InB7V
 o745U6m2rDPZVljpxwMyog9HTpEcupkpBc84as+oia3xVC2b/2ipXW5U0BIHxJMS16fP0UOWN
 ySVorfUzOtqECSzgQqYxD8y1mDflm0S4jO5fddBGXlPilxpN7IaKMF8tMj63Wj4rlSlrayywz
 8G/56rEavd4aC9ti3vWhBuoPNf15LoC5lHmalDxu+92YCBvMY3OVQ3fZkeyL2JupHQ5IfuUC4
 BqMrOT8JgnIgOSO/LdEK+/d/KcPD3omsUwRni3IsmLokYn6/RLxBuF8tZmW5P2yxPt6zgfAAb
 AuNC4McXMMQte5f0nV4Eqo/qydA=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

grep(1) converts CRLF line endings to CR on current MinGW:

   $ uname -sr
   MINGW64_NT-10.0-22621 3.3.6-341.x86_64

   $ printf 'a\r\n' | hexdump.exe -C
   00000000  61 0d 0a                                          |a..|
   00000003

   $ printf 'a\r\n' | grep . | hexdump.exe -C
   00000000  61 0a                                             |a.|
   00000002

Create the intended test file by grepping the original file with LF
line endings and adding CRs explicitly.

The missing CRs went unnoticed because test_cmp on MinGW ignores line
endings since 4d715ac05c (Windows: a test_cmp that is agnostic to random
LF <> CRLF conversions, 2013-10-26).  Fix this test anyway to avoid
depending on that special test_cmp behavior, especially since this is
the only test that needs it.

Piping the output of grep(1) through append_cr has the side-effect of
ignoring its return value.  That means we no longer need the explicit
"|| true" to support commit messages without a body.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 t/t3920-crlf-messages.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t3920-crlf-messages.sh b/t/t3920-crlf-messages.sh
index a58522c163..67fd2345af 100755
=2D-- a/t/t3920-crlf-messages.sh
+++ b/t/t3920-crlf-messages.sh
@@ -12,7 +12,7 @@ create_crlf_ref () {
 	cat >.crlf-orig-$branch.txt &&
 	cat .crlf-orig-$branch.txt | append_cr >.crlf-message-$branch.txt &&
 	grep 'Subject' .crlf-orig-$branch.txt | tr '\n' ' ' | sed 's/[ ]*$//' | =
tr -d '\n' >.crlf-subject-$branch.txt &&
-	{ grep 'Body' .crlf-message-$branch.txt >.crlf-body-$branch.txt || true;=
 } &&
+	grep 'Body' .crlf-orig-$branch.txt | append_cr >.crlf-body-$branch.txt &=
&
 	LIB_CRLF_BRANCHES=3D"${LIB_CRLF_BRANCHES} ${branch}" &&
 	test_tick &&
 	hash=3D$(git commit-tree HEAD^{tree} -p HEAD -F .crlf-message-${branch}.=
txt) &&
=2D-
2.38.1.windows.1
