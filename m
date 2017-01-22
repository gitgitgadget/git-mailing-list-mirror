Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6087620A17
	for <e@80x24.org>; Sun, 22 Jan 2017 17:47:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751125AbdAVRrk (ORCPT <rfc822;e@80x24.org>);
        Sun, 22 Jan 2017 12:47:40 -0500
Received: from mout.web.de ([212.227.15.4]:54846 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750907AbdAVRrk (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Jan 2017 12:47:40 -0500
Received: from [192.168.178.36] ([79.237.55.102]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0M9Xfb-1cg4053Kf9-00Cz7w; Sun, 22
 Jan 2017 18:47:22 +0100
To:     Git List <git@vger.kernel.org>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH v2 0/5] string-list: make string_list_sort() reentrant
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Message-ID: <67ac53cd-3fc0-8bd0-30f4-129281c3090f@web.de>
Date:   Sun, 22 Jan 2017 18:47:18 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:nuqubi+XoG1jel9NDGezR8Pb8/Ewc9PDnRxeprhD+jjNkWBQWTL
 5us3joT80d2I5BTT9FDefKH/xX8MuZnx4/mnqvzq7oU5h7lADl2ohcKxmKssC657MDta1mZ
 iZvjcxEPVc7xEJBH2ruiLzAZPRJL67VATPlARH8GwKjSYo9fd3nvNW7WqZ8nGa6LnCuBjJI
 Qg33zMvOQPEu6LodRmxig==
X-UI-Out-Filterresults: notjunk:1;V01:K0:6AVqXribMNA=:ggaK1KcgYXTWd6MlhPEjVM
 7biJOzR0lQh/r/BupSu24IPao/NL/p8K1sYCttrqABO17N2FuUtiP7FbPOgcDcZOgBwNOI6Ex
 COzOE7dFw6pt3K6BgU2SZrECdyuOfmgi2V0o/S1uHkKUUcH/blgy15/WrcQRf1kovauUdcuJ0
 ihU5mj9XgNoRk6mQ0B5aIssJxYYrT1VZ9ip2SfSRJulD8sTqEE7YM77uB+QpDsbV2dQVvqr+k
 KgPR88XA6ZXCj4vUulo8ga6f78nrBs1r1xf199lpKYLJ6kQTnHEjGXCievGam5Uuw7+JS2hEv
 Q1izrN8mDIo/JIlmAhg5Xrd1pe/cDPqp1czGmKXlCeclJ43h2emlFdaX+R4Gdp9HIP30A+8RA
 6r3y7E61mGiV8v4MhjaFKp3KK2CfEUuFio5cn2zWQuDA5WJQIFAWFnaq4NP8CILtxEJyHvOtq
 WsEBivYnOph1SwHNI2c1TTTZJTnY5ELM4IB91zKw4YsMDzKrU3Cs+tAnqGggO1Aplk1sBrXdx
 ZQ3UOmryUMbJCxbq965uYr/jKwPeNL7Bqo2FcAUICiGN+7GwvvnKM9jeI/CMaWzvvHBxXTqiM
 OM6sPGgm7Cr7jBQ1Xa/0Kxb7mkMSy64Rk1M/HDi+eqStZEerkcp6/S009mWN3INX032PA5tC6
 FiL5UhLuyA6wQ7huCSay3rb5LAlKorCVcEJYbc01bXKl/1RBEFT4s2ZToT5v81gRIV95Vy/8m
 +GwePjvfL1xMcLc5ZEUzjfV3TicFdaR7XgWb9U2BMOddJ/x6UGPUY/k/bXhKzBlB0w6NiaDQp
 wg7iOK/
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Use qsort_s() from C11 Annex K to make string_list_sort() safer, in
particular when called from parallel threads.

Changes from v1:
* Renamed HAVE_QSORT_S to HAVE_ISO_QSORT_S in Makefile to disambiguate.
* Added basic perf test (patch 3).
* Converted a second caller to QSORT_S, in ref-filter.c (patch 5).

  compat: add qsort_s()
  add QSORT_S
  perf: add basic sort performance test
  string-list: use QSORT_S in string_list_sort()
  ref-filter: use QSORT_S in ref_array_sort()

 Makefile                    |  8 ++++++
 compat/qsort_s.c            | 69 +++++++++++++++++++++++++++++++++++++++++++++
 git-compat-util.h           | 11 ++++++++
 ref-filter.c                |  6 ++--
 string-list.c               | 13 ++++-----
 t/helper/test-string-list.c | 25 ++++++++++++++++
 t/perf/p0071-sort.sh        | 26 +++++++++++++++++
 7 files changed, 146 insertions(+), 12 deletions(-)
 create mode 100644 compat/qsort_s.c
 create mode 100755 t/perf/p0071-sort.sh

-- 
2.11.0

