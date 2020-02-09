Return-Path: <SRS0=3Zv9=35=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2041AC35250
	for <git@archiver.kernel.org>; Sun,  9 Feb 2020 15:54:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1EC320715
	for <git@archiver.kernel.org>; Sun,  9 Feb 2020 15:54:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="gLH3+1KZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727768AbgBIPyM (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 9 Feb 2020 10:54:12 -0500
Received: from mout.web.de ([212.227.15.14]:54905 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727692AbgBIPyL (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Feb 2020 10:54:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1581263627;
        bh=LwO0Gxyq+arQQzB1uzReSQ7hc7ROWbPwCUx421c3lGI=;
        h=X-UI-Sender-Class:From:Subject:To:Cc:Date;
        b=gLH3+1KZR4KGEzq4qsBLKuo0IgH2qc3l9xEXKiLud/1+eKLtJRLM7ZDUvaNcxdaRG
         Dg1d/W/rfWqKBr/ST05bdGZ1ns6jdmyHN/bupWRBaIAS0xUmK7H2RC0X0+Fy1kg2lx
         YqP3QnzM28AnD3cR4hai5vxTM0LN5OjnbE99O4Ak=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([91.47.145.153]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0M7Kis-1jOh9J2NR0-00x0wT; Sun, 09
 Feb 2020 16:53:47 +0100
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH 0/4] parse-options: simplify parse_options_concat() and
 parse_options_dup()
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Jeff King <peff@peff.net>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1?= =?UTF-8?Q?y?= 
        <pclouds@gmail.com>
Message-ID: <11b82734-f61c-5e73-2d0c-22208c06d495@web.de>
Date:   Sun, 9 Feb 2020 16:53:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:QFGP4gugGmOT8fRUpuBwgfb26+WSEu/tBDYlsWxfh1BPJehtLw1
 Z0KFIWwas2sqUGNxu3/KfzshWaXKZ9g2bVqNoFJfaa5wqOG54mRxBrEvdcJfLFwaSWP0/qH
 XIhbhnbYf6t4WGXAC75/EPVH2CgWHvG95DjK1CSQ8eKBD7L735F6Yq6712xDZJ/SKhcQefz
 A8tp6hpEGgASRlXyV7Q/w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Y8dOkBumGeA=:MkjHc+jyWzuwdgnKX0mO8U
 mq+soeoWTSlEA2Yn4b5V0Vltt8QBKGsYYv+3eP7CshbcxAOU07y2hlMtC9q1kREnC4gt1BVd6
 xgwtOxxj1kHlKzXFKL5CFoUqnKKznJM7wIqFTdCMrRpTWgBE0Bv027nIJaZZ/JQE25TWblpwt
 Da4MJrnuMdWvm4fbZG+9Aff65pQbvLmg5YKcaHbJGLbnKERW39n3M7mU1k+FhUpEKGu4KFOk0
 UddE7Pg0E2SJaoS5srskUw6puVxG0qHXpAIODBa73n/3i/E886US8CYnaiAP6xt4Pma5aF4sO
 wJZA9ZGbBfZjqO4ONfkzyth24Muhde6jcMOX7D8vknHKMkQUipw/+5judhsL5XpBLuLCchO75
 VHbeVjN++q7gusO1ckQMnIk6F7rjs4cpku2lGrXzG72xfmviavsPtEM7itvwmn6SvBn/LVtCw
 WnW/dNqRDINqbdSD7XE9xYUj/xhXxtKiDKl71hz/chHiXz22gJRc/6loRaPJu/q2MZb3DpDyW
 YGbfMDHPqZaDg/HhFll42hDiBRqGzedwNOcUe0Vuy1ZiXYnOwHhLh57RsbshYK/3BFyVPvB85
 xzbCQ0M2LGljj7bF+UJGXxXg+/AfXCTM0SXitlqtbDB8hB80n9qWlzGal71pbXHS+c8V0Yxkm
 FjaS6N7KQKacrq4zTTE7a56L7jZ2hS2eQafJ7o7ERXJ8LozYoDAqxiGh1X5ANqVSCXqxH4yZv
 1f+0PjDSDpjPUNZBTUjzoEh4ZBtmWm13JAgloaYVX+hVenV8WXOa1uJV8fA0/z3jHsruCR/7o
 /8/KFpW02B+X7X+vwz+ivufSmhtMDZm6ANbFkqZh9nOv2kBEWY8FhNl4Sbdk/l2TKHXGcLSMY
 jDdRb2HE/QB+FE4rEYlOkHanSUDzWJQjcj/LBJyL7TAtn8ApJG81YHtxNZaely8ahuS5BKqkD
 UBTtB28j+QDzhA5Pw4g8SpbFyrUtptWJBA2Oq0Og72XstCZDQ1paLwdiSv8jGVsIHfe3hYi/7
 gKPv9Gem4qTpVbzK16p/2MiFgCFYDKpOwLiPoR+MDDYcEb4OcynfzDDbjIX8zhJ40qHySClge
 CVujbh4Tg+JeW5kawFH/8TS4HcbDgqcOtNMwoByT4UDTo7xD3xWvidsAysgp2XNR13mGaR95w
 d2rp2X3DbDchongk7JnAPzZ52Yhx74gv5dKoC2/MHOL3/gLmuJFxQ/Bf9D3AyGeWVPgzc=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Reduce code duplication.

Ren=C3=A9 Scharfe (4):
  parse-options: use COPY_ARRAY in parse_options_concat()
  parse-options: factor out parse_options_count()
  parse-options: const parse_options_concat() parameters
  parse-options: simplify parse_options_dup()

 parse-options-cb.c | 42 +++++++++++++++++-------------------------
 parse-options.h    |  2 +-
 2 files changed, 18 insertions(+), 26 deletions(-)

=2D-
2.25.0
