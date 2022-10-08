Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3B1FC433F5
	for <git@archiver.kernel.org>; Sat,  8 Oct 2022 11:06:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229600AbiJHLGN (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 8 Oct 2022 07:06:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbiJHLGM (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Oct 2022 07:06:12 -0400
Received: from mout.web.de (mout.web.de [212.227.17.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 703A1481FE
        for <git@vger.kernel.org>; Sat,  8 Oct 2022 04:06:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1665227144; bh=1km+WSbJ5ORuGEPVNymy5V4Sx+Be3ObtN816AgOO0RI=;
        h=X-UI-Sender-Class:Date:To:Cc:From:Subject;
        b=LoLfmzJLCzsPcoDdOU64J/O9eHIcbzvHfMK8CTEVecUSdXoD0ZxBWgJhtRtH7hfXz
         5wox1MmyWU18R58qz9urQKBMozIU+887l+Wg1VJPnY/5ecgwcCCTGxedLKhlV0rlJy
         t3t+ZDXCDtrO4Z8YG5N2QksPJCnqwSJrQSbpriQGy4gbi9YckiNV/nISZfpLwrm54Z
         n9otElfulG4jqNVOJxCQAQXRXu2FNV9Ow1QzN3yj5fFGd301Lk7Aou1H7HY0H+7wJm
         dn/UivL50jtFjUt7kYL05WxO8vCIHgumhTB5yGze322SB7kln54qDPsJURNNPHIMjs
         /joZBYhZu6MqQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([79.203.23.161]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MGxMP-1oucBv28H5-00DoXV; Sat, 08
 Oct 2022 13:05:44 +0200
Message-ID: <cb6ffcdb-d719-7928-96b8-e46482dd141f@web.de>
Date:   Sat, 8 Oct 2022 13:05:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.3.2
Content-Language: en-US
To:     Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] dir: use fspathncmp() in pl_hashmap_cmp()
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ftMI8fROI6Nwi5zxNgnSWaR8ttRR202JVaygm0aPUUzh2gNdwdJ
 cWxUsdTxbb2xxnun7rdWizItthi1WgD6dbsdHkNz+RC+mDsVGQCQPMD5RdrMwbw5j2D2TQT
 7rq1hb0E4xYBeSY0KgBaMo4mMO47keRunxLFOHTb8v+1YhW4Qq70BES4YBhYzhLH2oKfF2h
 foQZ/IJ21Vg6/O4L+T9Ug==
X-UI-Out-Filterresults: notjunk:1;V03:K0:M0TGfG0ePek=:ZDkNSsvTVMoyDotOasrxr0
 qb8qokr2Xm6mwF1r6DdwOh0sGgvic9Yns7rXyV0125NHIaPOzdSm3lPrDYicc5vGfsbgYpTsg
 TGwZG5CYI38X8QCdxgV6/OPCZGhnv2a5/D+5WoymkPy+LHXhc9mUPdGFhxIIZT50u4TInNgaF
 rZccGKrO3HTTWZAvL23lJ9BnO6V7mTP6c8zHOPWvt1FqTJ2wjNp+9H7aCD76VFX2eT8d/TWkI
 LwZisaRp33x92YUNdDxNv8rxqryFgA/IPnCn5vU7m2XQLobDGnD5IimCWEhDJubMVa1UksANc
 3LuRExtS1XnrKBtXEpDfvwYkjRvNoDA+E0Oa/hwB2Y8h65Z7qGID3X10gl+VaQrxavqH4j7s7
 mYTW/l0gcL9cBrajLzlCz25V+t4WZphUel72pREaXpnz/eij7td4e8YeY8oYQt7caKJmEiYXU
 NTVLWNkGzqC94pRWpQd+NPOKm4+eFgAiu4IXHmzcN+nFTWQx1pmbF5dQFPQ9CkD15VR5wIG6o
 cglfqMUIt+Y0hx6zMJiGB5H6v38YoaseDmtIrgk7t5FhiV1bw9xIclNPP3mpHuhZKaVFybcjG
 SXFy5ZILJ+XBVLLsOlCwe/D67/DihdhiSDUO1K9KMVohTyXccB6uAVgmvwCFwMN19ktCE++3t
 5uHMgBs0YKNpO7knS6bDQb0EIrv2z7M1Xb0RbrzdpL+tJ3MWi2FUrNP96Q/iV1SOfX1l3TEBb
 qGdySICizT7GbtobI2xV5wCYJJIQg+VOPgWmZoFP/2/R7NrBH9ZdwV+pbQ3rZu0GnAThPe5Xd
 BvwpFjBxaoPhocq5LMlcmKTVtjFHsA7Ef6L8PJy/jEET3J1Z70eFQMLB4G0j6Rl5g832yeiI4
 Zhg2kqJzH4lhe99IMkIExiq9K6v523D9Qu4mrLIyspsI6mQc172gJaFU3wVTgfRrEYzuIe0ih
 zs5KKe/nFNyxydCOF+fbJ2T8pJ5L8RxiskIvfUhSKEJjv3RJApcrKJRLr47DvsO0aXTh5lBwl
 DcOrZ2R1MIukwKfURJVlk6rVXOhWpSRuWrYwwe7CiDOd6ghvo482uReuGp3uVa1HfFy1cPtK0
 I0opsnQiOln7o2azvpTdPw9Pa4rjRLYLu38/8SMHEfvf2LWoGBkP7GMxseSJFG483QAQb9ArW
 1Zpa2jHvb6cWGip53pd7y8Vk1Z5HRE1PNcapogN41siivJfKCdOcvyx5aYCG/Zpu8LqVypgcS
 hkGMZWbFpuLnIAf4OC8MDfOg4ZIryrhtRPBVSyItcaw92vX+lmaVTInEZs3hFb6RP/PzsT35G
 wdHtbJMuOkXGjFMZiGO3vJG9aU/z4ct4FyIlQ3SryjAr7TfjrZWb3AwK2jSV4Mjid/NOZcXj3
 06vTw0fhq9Lb/jyA+aLIt+XhWZQaU1fhY23qFzi7+UtRUtmLgb12zn/3ETapylzcvzqs932RH
 aGsDKfpsLC4arz3bkUpU8c7yiIG0K3IhPl9kZIhNuhPuOYsanLkFimr3TokSoDh6aeH6/rhgW
 xESPy4FC/QVh+3+2Z1yahyhxMTG599T42zMuX7G3/4Cfm
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff King <peff@peff.net>

Call fspathncmp() instead of open-coding it.  This shortens the code and
makes it less repetitive.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
=46rom https://lore.kernel.org/git/YSv1XZJvYdYj1JtP@coredump.intra.peff.ne=
t/

 dir.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/dir.c b/dir.c
index 7d56d68355..28f4c6895b 100644
=2D-- a/dir.c
+++ b/dir.c
@@ -669,9 +669,7 @@ int pl_hashmap_cmp(const void *cmp_data UNUSED,
 			 ? ee1->patternlen
 			 : ee2->patternlen;

-	if (ignore_case)
-		return strncasecmp(ee1->pattern, ee2->pattern, min_len);
-	return strncmp(ee1->pattern, ee2->pattern, min_len);
+	return fspathncmp(ee1->pattern, ee2->pattern, min_len);
 }

 static char *dup_and_filter_pattern(const char *pattern)
=2D-
2.38.0
