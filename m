Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E75B32082F
	for <e@80x24.org>; Sat, 15 Jul 2017 17:19:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751177AbdGORTI (ORCPT <rfc822;e@80x24.org>);
        Sat, 15 Jul 2017 13:19:08 -0400
Received: from mout.web.de ([212.227.17.12]:50304 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751088AbdGORTI (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Jul 2017 13:19:08 -0400
Received: from [192.168.178.36] ([79.237.60.227]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LzsGF-1djTP926KJ-014zaA; Sat, 15
 Jul 2017 19:18:56 +0200
Subject: Re: [PATCH 5/5] Makefile: disable unaligned loads with UBSan
To:     Jeff King <peff@peff.net>, git@vger.kernel.org
References: <20170710132418.d6bvzxwvbejretb4@sigill.intra.peff.net>
 <20170710132450.yxojk5cybejy7und@sigill.intra.peff.net>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <de9c876c-f018-ad6b-3813-576ea73dd49a@web.de>
Date:   Sat, 15 Jul 2017 19:18:56 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20170710132450.yxojk5cybejy7und@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:MbCCCtnm7uD/xcuwo7Sk2+LMf+TbbnzjHbJ+vW3mliVg427oyOF
 5f846491zPVogw74rz0UbPbbtgr1+i7MlaQ9NDZqwSLKBTgnEsOdKNS5oOveViIOJjr3vCT
 J/Ft6NnSB7sTEuJqni6piQyPMltEyVZanOKLhJC3eNkeZqJYykLBF97c8r/c/TIgSnu9eJ1
 b75cXN8B4ZoaytuON9XrA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:88/1PPcy/kE=:dZ1GjWfYm3Zkem+OwhR8B+
 W7Fdhd15mauqIu2BzBq8Pazkqc76mO3NmQo0MflUnR1cKD0f3ceynLpbaq+iDRo9/b7yiBh+p
 fkS2835XUvcD/y5BDDjqFDsxqrkQ9QuJ5G1ST8V0431AtkTTuskT27OmcebBkAsjEylEHvN39
 L28EZNd7FU6PolweNkbeaf4jyiKN8JF3jZifruapIGrmaSx813LkQ2xloaalM9vr1ReKnMrfm
 bY0dgyrn0adwcRr2OMDTySfE9zdi1gbNYmAe5Sw1mvgQbNW3dBT6xCWHd+7fhSRxl25k+0hsM
 UrL79NLOzfMWO4ez6YzpGkMzz7LYLMSPTxqOARfLt13Bg2Std6IugyUphazReRQv7VilGEI1n
 VYboregvbf9NfIwKsS2Wzn6MvuvhUEViGud3bA1bcX/WFybMwXF/o2s8aQPbTcwsnftG0oksU
 ZrMrOWF8H6v53hoksntqSil3wvOy408aKaOzvkOmuBbzXAiOqgnUoAZrHwxBkV5teczBYLRnt
 9wAZ/s2I3JMMy2QsWj94kZ5BZOfCVSPCv/BFXYibeNyiZI71dhj6mf0o00C8RMLx6kjW9rQoO
 OA+uNSpTa42JeJhlCCYEBMQIoB8Gik8i74nb4XxQhhhwUd0TdmBvhEeZb11yrGXDWZMD4dTpO
 SXAOvkwe4sbf7BEjrw+15LgvLxFXaTzBQnL0qMrWOW+11FknIHbX+bKHWzhMfGL4k01OvAkE9
 OJl6UTpJ+005bIislc2eefxCB0oLd8aaGpQmfR44sWMvCc1nw+v3SbXxnOPckFtl7iPJd2NP0
 47o9rrtPWm1ws5TXe4QsteLCgFUsc04GmxbfC1B5+IXWlOCOqU=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 10.07.2017 um 15:24 schrieb Jeff King:
> The undefined behavior sanitizer complains about unaligned
> loads, even if they're OK for a particular platform in
> practice. It's possible that they _are_ a problem, of
> course, but since it's a known tradeoff the UBSan errors are
> just noise.
> 
> Let's quiet it automatically by building with
> NO_UNALIGNED_LOADS when SANITIZE=undefined is in use.
> 
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>   Makefile | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/Makefile b/Makefile
> index cc03b3c95..3c341b2a6 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1015,6 +1015,9 @@ endif
>   ifdef SANITIZE
>   BASIC_CFLAGS += -fsanitize=$(SANITIZE) -fno-sanitize-recover=$(SANITIZE)
>   BASIC_CFLAGS += -fno-omit-frame-pointer
> +ifeq ($(SANITIZE),undefined)
> +BASIC_CFLAGS += -DNO_UNALIGNED_LOADS
> +endif
>   endif
>   
>   ifndef sysconfdir

Nice, but let's be even nicer!

-- >8 --
Subject: [PATCH] Makefile: allow combining UBSan with other sanitizers

Multiple sanitizers can be specified as a comma-separated list.  Set
the flag NO_UNALIGNED_LOADS even if UndefinedBehaviorSanitizer is not
the only sanitizer to build with.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 Makefile | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index ba4359ef8d..9b98535a04 100644
--- a/Makefile
+++ b/Makefile
@@ -1022,10 +1022,15 @@ ifdef DEVELOPER
 CFLAGS += $(DEVELOPER_CFLAGS)
 endif
 
+comma := ,
+empty :=
+space := $(empty) $(empty)
+
 ifdef SANITIZE
+SANITIZERS := $(foreach flag,$(subst $(comma),$(space),$(SANITIZE)),$(flag))
 BASIC_CFLAGS += -fsanitize=$(SANITIZE) -fno-sanitize-recover=$(SANITIZE)
 BASIC_CFLAGS += -fno-omit-frame-pointer
-ifeq ($(SANITIZE),undefined)
+ifneq ($(filter undefined,$(SANITIZERS)),)
 BASIC_CFLAGS += -DNO_UNALIGNED_LOADS
 endif
 endif
-- 
2.13.3
