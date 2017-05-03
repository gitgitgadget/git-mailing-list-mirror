Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6143F207F8
	for <e@80x24.org>; Wed,  3 May 2017 19:48:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754515AbdECTsx (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 May 2017 15:48:53 -0400
Received: from mout.web.de ([212.227.15.14]:50096 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754402AbdECTsv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 May 2017 15:48:51 -0400
Received: from [192.168.178.36] ([79.213.114.92]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MV4tp-1da00s3hev-00YPIC; Wed, 03
 May 2017 21:48:44 +0200
Subject: Re: [PATCH v3 01/25] mingw: avoid memory leak when splitting PATH
To:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Johannes Sixt <j6t@kdbg.org>, Jeff King <peff@peff.net>
References: <cover.1493387231.git.johannes.schindelin@gmx.de>
 <cover.1493740497.git.johannes.schindelin@gmx.de>
 <10fc0a4a37b4167f49c967ece08f531cb1e8d6b1.1493740497.git.johannes.schindelin@gmx.de>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <789a242b-7369-f24c-0b92-09f415f9fcb5@web.de>
Date:   Wed, 3 May 2017 21:48:42 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.0.1
MIME-Version: 1.0
In-Reply-To: <10fc0a4a37b4167f49c967ece08f531cb1e8d6b1.1493740497.git.johannes.schindelin@gmx.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:kqTuICDz0XmuuWOHZhsUzl2Pcueg+LBL2+uYpL9B0Q4snOC5ng2
 3pZ+CZJGHaqSCVW24oY5vOdMqszkhZZN8El4hjgJObiz1yzzb1hofR4NPB3GkcVzsPGEDqB
 maTVoPPsKhn643ZnLsEti/h+QPw5Gg/ZsepYQ8t7KWrg2ToRPnCmO0RmvrgYbJ5dXiWUcEs
 h4G4t+fGkmybyFvrQJqHg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:tOyBNJe13Dk=:JtoGuWD7Jv0Bvi5STKSO0E
 AgUK7WbOrfL9M38Nc7KhLYOlV4P+ghCgm28WlZ5ppb3sS1pQkHamwZqV44XKLkljMSJDH4HAw
 uqpqNX7UdU7UokkZWe8iV5cXvbz/bQ7sumQ3wDlIPtWedq/M8wkBKJHpDBrai1q0bNlQIWNdC
 8KgJ16U7VJjRUlYKgluB5sC/MKFnxn4X88VI0McQ9MRj2bhg7gjL1OAXKMrKr/NFlhdeWzYzk
 ZzUn9YYAVbwj0RcJtsbIxh45c6HDp7ah9lN3ai6J0pNSfTO0JpWkBQmJfdLcyQWE+S11gSgUt
 ncq/5Gznn2Jjr6vtE+1EhEWiZAiHx7sQwJM6KwOiTuPh0UXRwldefZIy/3FjXAgYj7s2WgLyE
 0z4lPdf1IZyTkeKUwIw7kanQOiOR3ICmF1tyRiWD5ppvj/ps2O1vV+NL7KChSzwmHx1Kb/Ynr
 nNP+xxKoZy7gwL6d99m6Ibh2tXfCUKtVuK2ON8BW5bBkWT8t2mxo59OqPei9QDI+NJ0Y+/oNL
 Z+om/wNWRdyd9aY/j/5NG9gikmvWuPiw1fdEe3PDn4gR+WDkBv3MmxKaxl+S5UPKRdwbp8ahb
 DxHYiDIHkhgSDq0apo+xksdjn/40wib3GLvx4RPWYgFVG+EqRXGDqB2e/9c/SitZMO3r7iXq9
 KkxpFcA1v2mnvjRT51VND9uv0DU7/ii9Xkw25O4EHlVMf86yFMb5a7gNYSxRshCYZRIE7d6Kl
 PzMQIT24zf/1WoAlVWg2T7cQbOVnckYPEpyryQZWQo8CPUqG3s+XIl7irnvOGaZ0KKfxutIrQ
 A7nX8xs
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 02.05.2017 um 18:00 schrieb Johannes Schindelin:
> In the (admittedly, concocted) case that PATH consists only of colons, we
> would leak the duplicated string.

Nit: It's about semicolons, right?  At least that's what get_path_split
is searching for.  Or is there some kind of translation going on?

René
