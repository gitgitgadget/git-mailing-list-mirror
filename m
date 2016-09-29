Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3D5D8207EC
	for <e@80x24.org>; Thu, 29 Sep 2016 15:24:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754772AbcI2PYL (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Sep 2016 11:24:11 -0400
Received: from mout.web.de ([212.227.15.4]:58755 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754542AbcI2PYL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Sep 2016 11:24:11 -0400
Received: from [192.168.178.36] ([79.213.113.239]) by smtp.web.de (mrweb004)
 with ESMTPSA (Nemesis) id 0MGCm7-1bkMH943x1-00FCTY; Thu, 29 Sep 2016 17:23:53
 +0200
X-Mozilla-News-Host: news://news.gmane.org:119
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH 1/3] add QSORT
Message-ID: <67bddc37-4ee2-fef0-c852-e32645421e4c@web.de>
Date:   Thu, 29 Sep 2016 17:23:43 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:rK6sRkbDLh/tjo+Wc5/aAhrzRKWI9NI94q5GkS1BHs8Y309mn3w
 6/ghiFnfqnbq+J8Sa5JQFc5v7tpcVTcA618BnVEU9of60h2tHk02oMKjaHb/HIKfl4GvBrb
 NJq+qAoDm3KcV5NiYgQ3PknUy6PetSIN1G2NiLjHnIKQg6oNPkqXU28LHY7diLFQhXytYZ5
 QMikB8y9+pqSJvqTnG5ZQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:sG6eMGY+oK0=:dc68ca5/3Cw6kVmRK8o192
 ujtfN4gYtE611lVdOWsnjQdMWbA5sHFH0XG/UMSzXLN6bm0xcC/I4DD8Znsv+vpC+1Gya+sL4
 o19vDTACoLphTkTApunY4byJm97PnmGfvKsyiYJpBzytP/k99dJPp1ln8ZUGKqy/Hv+AERln5
 qUjKki9ismfcnArKTvVOnQ3+TYYVOXLCfJjQvZgDkl6PcY/J+0MRMsydgLTV0NEX61ZhjoUna
 1xux8lzsUDKufm06IjeYBadv3tLQ6YadD2fPkzImOyxcgvZ77sqf3QKX3AAa4TC8H8VRZM8uf
 YMDL96R+aljCCbsOolTUPrq8kYU/d9a10mphNGXobq9QaHurvw4NtkdwiYxgRzM4yG9mkzx58
 jAoO2+uLvB8xm9ck3XH2a8lyweL3vEFb5+bj+dGNrPnJgnRvV+AJ7kwU7gc2VmJ+d68BzrGVy
 fDaFyo3yyL8CeQUseBmJzmcEt9Lo1DoSAcR3h07C2JghC0ejT+NgXXYyCNf2EfbjySFK3odin
 hM76ckZJ4Ja/2ukvthbAsIDI9q7O8jAWXltckM46rDGXSuby5WNY4CBvzGHVeVoYbTduTzOWk
 TTMaRvKiGJCaC/QFncfE30kmlAVhEua/RsDvF1IcPI5E/9AHXEt23ntdHT/M49mTMapotcjTI
 Tg5coVxqGh7diVG1D1zwjupsJNZSIfiVNXT81WI2kW12/lpvOddAV+LTD9fEgzWNCg100h1s1
 QsnR6tPXhd/hVTBAvN1oRptqNRvUE6uI6+QP8yzYrQz3ZJINHGED1g0HlIggNH+1kOHBopdSc
 BWRfeu6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add the macro QSORT, a convenient wrapper for qsort(3) that infers the
size of the array elements and supports the convention of initializing
empty arrays with a NULL pointer, which we use in some places.

Calling qsort(3) directly with a NULL pointer is undefined -- even with
an element count of zero -- and allows the compiler to optimize away any
following NULL checks.  Using the macro avoids such surprises.

Add a semantic patch as well to demonstrate the macro's usage and to
automate the transformation of trivial cases.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 contrib/coccinelle/qsort.cocci | 19 +++++++++++++++++++
 git-compat-util.h              |  8 ++++++++
 2 files changed, 27 insertions(+)
 create mode 100644 contrib/coccinelle/qsort.cocci

diff --git a/contrib/coccinelle/qsort.cocci b/contrib/coccinelle/qsort.cocci
new file mode 100644
index 0000000..a094e7c
--- /dev/null
+++ b/contrib/coccinelle/qsort.cocci
@@ -0,0 +1,19 @@
+@@
+expression base, nmemb, compar;
+@@
+- qsort(base, nmemb, sizeof(*base), compar);
++ QSORT(base, nmemb, compar);
+
+@@
+expression base, nmemb, compar;
+@@
+- qsort(base, nmemb, sizeof(base[0]), compar);
++ QSORT(base, nmemb, compar);
+
+@@
+type T;
+T *base;
+expression nmemb, compar;
+@@
+- qsort(base, nmemb, sizeof(T), compar);
++ QSORT(base, nmemb, compar);
diff --git a/git-compat-util.h b/git-compat-util.h
index 8aab0c3..d7ed137 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -977,6 +977,14 @@ void git_qsort(void *base, size_t nmemb, size_t size,
 #define qsort git_qsort
 #endif
 
+#define QSORT(base, n, compar) sane_qsort((base), (n), sizeof(*(base)), compar)
+static void inline sane_qsort(void *base, size_t nmemb, size_t size,
+			      int(*compar)(const void *, const void *))
+{
+	if (nmemb > 1)
+		qsort(base, nmemb, size, compar);
+}
+
 #ifndef REG_STARTEND
 #error "Git requires REG_STARTEND support. Compile with NO_REGEX=NeedsStartEnd"
 #endif
-- 
2.10.0

