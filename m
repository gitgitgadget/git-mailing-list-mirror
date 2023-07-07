Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99E72EB64DA
	for <git@archiver.kernel.org>; Fri,  7 Jul 2023 19:08:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232946AbjGGTIp (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Jul 2023 15:08:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232941AbjGGTIo (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Jul 2023 15:08:44 -0400
Received: from mout.web.de (mout.web.de [212.227.15.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30124E6E
        for <git@vger.kernel.org>; Fri,  7 Jul 2023 12:08:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=s29768273; t=1688756913; x=1689361713; i=l.s.r@web.de;
 bh=Y6Ufqyvm/BrD4yXzKK5cnjkKF7/JPjxCWdgylDD467g=;
 h=X-UI-Sender-Class:Date:To:Cc:From:Subject;
 b=DBhPJx9bwOR1oGOUDO5ajc1Dy03d1ld9b+vXeSmIkp8tZqAXFOR3Ep3SlMBlcU0VTWw/q63
 UScUjYRlB8tz39IvGB23sVrFwbpRip82+bfiCv5uEHg7uf5sdisvFo/tvkgHLPSTOuKKdYrNO
 sVwVw5NVlmP/YJQJ7DrdragCj91IuPBvK1mnS8mI51aBV65K3qN96mZCOn+dZcxOOzxqanWfC
 RGjGXB/KoLIW31JQjOX03HBGcXggI/lTNUebbYLp2EPLVqJSeE8E2RmCiSdBgNx65Rd1CeRaj
 JQaO5Y1ny17pzdm54rnwWeUsckj0J4EoBgNKm5xl2xoSzxVyd1WA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.158.134]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M6pYY-1qLjEV3R3G-008l93; Fri, 07
 Jul 2023 21:08:33 +0200
Message-ID: <108ab1a2-28f4-dd62-1f90-64f37708aa8c@web.de>
Date:   Fri, 7 Jul 2023 21:08:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Content-Language: en-US
To:     Git List <git@vger.kernel.org>
Cc:     Jeff King <peff@peff.net>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] pretty: use strchr(3) in userformat_find_requirements()
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:csw+hz0jFV2t9WyjxaQKFmLEx+Sz/C1KRJA58epyKvrRdZjVMXD
 VGUp32FrMJ2W+AM5+r0dzxnrMsz3hz65YsUYjQDw6eqIzSFItr+EiT5E39J3q994m4NoX4J
 Q1KZ9cnVDqTVuLQiXAWZXI2RX7tFPFrANJ5y0QowP6doRa6OjkKczR1u7OcEbuvoAFS/SHN
 VblbH0eGjgS/hAESRui2g==
UI-OutboundReport: notjunk:1;M01:P0:OPjrlv9vQJI=;7pVD44sDAj7aQ7I2YldIWi6Bwtc
 Nkzgsgas5/L3vtGEO/RcyKv6sVlDRIX5No6CeASPcXbMSkZjA9pupuIzTDyMZ0IvnV933najd
 P+pvnoQQBASqMQ2IXyDsem4HX/WqEdlJ9u3MSSNvdXlGwEkdhwKITHxMh9B9+d1LBhfHh9pBG
 EmeuvdQ3qOk7F2hQlXd0uxrK5uflYqLBaobme0QQNbYc5Y2ioYsAMp81cB4zR+YlQutXdSS4+
 KfA1fe37Py9Ayrn0683ItWOul0srN+5ar+Jc4JB6fGHW9YrzbKj0QJAOlZv3XzyJSLpv1WxsB
 3QG504zXVGXwdboX/MBYpx12LKMy7Tgq69T71Bc4Xt/RiIyh0b2ziQzRekkTpkdRvC+76rNJN
 rJfo1pBnOnNHs/xULqdGnorBI3/5l7Z2zK1R9VoTVjvBFE4z/b3RGwUi2lYmNAfZOst06qbaH
 9mp7AhImb+tP653f9JRhvCrdCvk+zBFQDjD/1OPRl1suoSLYp+7tN0ufVt2Co6RNTZ+YoY0z8
 MssqTWad6De+jlJ1LzVRM8wLUQQDZSBrp5iQU1I3bGQC14ub2E8zj+l3ez+P8EEDc+7Dqlk5x
 htcAiiiratOltWN6TVjFAo0wd2uTjV2j+1AwUiwTywp6Bvd+u0dn5SE8kbTa2H1Ny0PC+j7CB
 5+Q/yRb+J4GdUeThcx8jB4wB83CQ3H4OMMqyf0Gy5AWb67MPt6bf/xSlbrZAgdueRNEaV/RKC
 gCq71ogNtgrDkArStYmOJkK2481WIFMPDa/iKNR2ShVMZZUmZVVnftIMeBBgnjvJVe7Wr3pEM
 Ba+7gvU3n6fMBIRuzUzpBQOsT0J8BhJ+qi4hSKV8BH4e0MVGJrH4Ql02c9UXcCGD4ul0t+pp5
 YydLelXODWjMD3Sq6Qmagzdqo9yPPKnrzWrZMucKvxLl5mMLEX75HbvDO0ATxFyH6TAwczaSb
 boO4FFfxuCwJjuGnOYvUJhOq47o=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The strbuf_expand_step() loop in userformat_find_requirements() iterates
through the percent signs in the string "fmt", but we're not interested
in its effect on the strbuf "dummy".  Use strchr(3) instead and get rid
of the strbuf that we no longer need.

Suggested-by: Jeff King <peff@peff.net>
Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 pretty.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/pretty.c b/pretty.c
index 7862be105d..d9419aa062 100644
=2D-- a/pretty.c
+++ b/pretty.c
@@ -1876,14 +1876,13 @@ static size_t format_commit_item(struct strbuf *sb=
, /* in UTF-8 */

 void userformat_find_requirements(const char *fmt, struct userformat_want=
 *w)
 {
-	struct strbuf dummy =3D STRBUF_INIT;
-
 	if (!fmt) {
 		if (!user_format)
 			return;
 		fmt =3D user_format;
 	}
-	while (strbuf_expand_step(&dummy, &fmt)) {
+	while ((fmt =3D strchr(fmt, '%'))) {
+		fmt++;
 		if (skip_prefix(fmt, "%", &fmt))
 			continue;

@@ -1903,7 +1902,6 @@ void userformat_find_requirements(const char *fmt, s=
truct userformat_want *w)
 			break;
 		}
 	}
-	strbuf_release(&dummy);
 }

 void repo_format_commit_message(struct repository *r,
=2D-
2.41.0
