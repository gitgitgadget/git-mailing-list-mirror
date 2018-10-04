Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 253BD1F453
	for <e@80x24.org>; Thu,  4 Oct 2018 15:05:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727691AbeJDV7c (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 Oct 2018 17:59:32 -0400
Received: from mout.web.de ([212.227.15.4]:47267 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727354AbeJDV7c (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Oct 2018 17:59:32 -0400
Received: from [192.168.178.36] ([91.20.58.167]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0Lpw63-1fTGT31TD5-00fkwn; Thu, 04
 Oct 2018 17:05:42 +0200
Received: from [192.168.178.36] ([91.20.58.167]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0Lpw63-1fTGT31TD5-00fkwn; Thu, 04
 Oct 2018 17:05:42 +0200
Subject: [PATCH v3 0/5] oidset: use khash
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>
References: <64911aec-71cd-d990-5dfd-bf2c3163690c@web.de>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <14e57ec8-b8a2-10bd-688d-1cb926e77675@web.de>
Date:   Thu, 4 Oct 2018 17:05:37 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <64911aec-71cd-d990-5dfd-bf2c3163690c@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:YUAc4MNYv3vYwbo4SQjYUPfUqKijQkDsDgwt2kX9vD1TNdGiziS
 OCGta4chLRjLlZ8sNhTHzc0bG7nkZxskNzADxPALX5DY7y0BA/Yh0RzFrKDMO75khUoo9K7
 9NM1fv0f1FFfj3sGbEtP8z89E1a7d1ByK+NpUIQT2N+gGkACDM79sap/m9DREwZfFDD549T
 aaH8jmPdDAaLkuG7e9mnw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:7jcbhJuIras=:RKyDkqcL4l3Z1EiujmWQ8n
 99TwibhtyZsGta2YAKxXZVGLr6SqG0mjUgGSG6ruGXS0Ox+kaNZuzrCsjFJTJuW3VjwztYNER
 hjJMb4K+oZwLr7YQnni5wbkZLWgdfTwmxstPSLFiB/OLw1skNUC2Xlek/vUydP034ADbL62US
 OVDXCHlK6aR5H3I5lxfYqwyDLzxkKMw24adqGg4/HhBI74ySxUv+Mg8tud2uxGarWOXDlg+1y
 W/sGo6/+Yyi6gwCH5zJL8xuJYZY7YBcs1EwKg5GTZjMboH34NCvR+ml7YkRVz5qJ58Ri9MGKW
 y7kQN4wrsa7dvVFiu8RjH3/WvjCheoQKFtsl8/v4CSr8Lnz3nLPAN4j2BU/Q+eimpX7WCgitB
 1tleYbr80zYBF3+MItRyzGjVNLhXjj2XlTx50OgKtitD/F9SXCiSfrTVS7s8gG0Mt7rVop8H1
 0YqFKyBDpaNG8s8BKaY8F+Cpt7aaYB6FngDEXR5ApMxYBDT01mr/+JrSUtd4DKeUE3buz0Xd2
 f5Y0e+hx1G3QF9RX5c21sG31dBRBv2BOvNTjnLjZbP0KWYSdPoDMz/iRttG4KRYfiqYNrjqdY
 AcXhf7sIM4yBSLUvUNE/8x87pLoLimIliGCjDJmJyfYJ10JhPgCyJzKlUrD/MmPvjaHdvkR+2
 pjl3wVlBoKrJAMIqFZadZmPOEMJdEkcV/nR/uInbUAurmEXrFSRwHGB4OieGQpz47ZIhwaY6c
 iuCpxbhGPso0eL5HsyYefCZWUodyNaiEmaRXeiOzkIiYXBrTUBAC5Dz+kZoNdQ8FXmXz4CiIy
 DywnxC2/JyrRwjDnOHD5RSLzLbvapLvs+vmtKpHhf4Uz3x4kYc=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Two new patches to avoid using oidset internals in fetch-pack:

  fetch-pack: factor out is_unmatched_ref()
  fetch-pack: load tip_oids eagerly iff needed

Unchanged patch:

  khash: factor out kh_release_*

Unchanged, except it doesn't touch fetch-pack anymore:

  oidset: use khash

A new patch, to reduce object text size:

  oidset: uninline oidset_init()

 fetch-pack.c | 49 +++++++++++++++++++++++--------------------------
 khash.h      |  9 +++++++--
 oidset.c     | 41 +++++++++++++++++++----------------------
 oidset.h     | 43 ++++++++++++++++++++++++++++++++-----------
 4 files changed, 81 insertions(+), 61 deletions(-)

-- 
2.19.0

