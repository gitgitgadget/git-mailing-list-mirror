Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E267F1F803
	for <e@80x24.org>; Mon,  7 Jan 2019 17:29:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727899AbfAGR3i (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Jan 2019 12:29:38 -0500
Received: from mout.web.de ([217.72.192.78]:44849 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727370AbfAGR3i (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Jan 2019 12:29:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1546882165;
        bh=hYflLaaXQ0ZUhLKGX+ye4sqeM6hygeVBK5eVSJy12d4=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=bu9ItfaZXnXqLoOx9H/BhV3LSlBi/CdNfAUgG5X+w0DXZYmDwdOXksOcmnNyaOBlW
         8yp8luXz1vAraWTdaPeJbk5hAgEJ/pV3CFZmQy8GcFxvxIttAcKXpW/QQUhE+uL5gl
         qcjqD+cFHsRIiPwAtRyIaZZBk0guE+77dq+B5ojY=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.36] ([91.20.59.41]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LetYx-1h4wA63Elz-00qkFF; Mon, 07
 Jan 2019 18:29:25 +0100
Subject: Re: [PATCH 1/3] object-store: factor out odb_loose_cache()
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
References: <xmqqh8explya.fsf@gitster-ct.c.googlers.com>
 <3512c798-aa42-6fba-ee82-d33a8985be91@web.de>
 <b87e7e01-baa6-6fb2-7081-0042ecd3b6b7@web.de>
 <20190107082702.GB21362@sigill.intra.peff.net>
 <4b9198d2-4994-6d26-74ee-e737ecc34af3@web.de>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <dd0504df-618a-e27b-ccc4-a6a316cd965e@web.de>
Date:   Mon, 7 Jan 2019 18:29:25 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <4b9198d2-4994-6d26-74ee-e737ecc34af3@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:AqjiZ+Hty+uOzxXct2LFFBchmQvN1kvyarquG2dznL10ufE9OUh
 Ek5FfAnyiERXDKJ9g+Wt1rHFZSiTB8Hj9l0vxGTvbImy+FD6IS5Cjnc2GkaL2G0XerPE+dU
 cp5+dQAiHgA9AXyBq0Xs/2u9xPbkcYAF8OlDuACVk9ltjzg64ZsHfeH48gb6G02NS7SoWZb
 05MFXkO3C+9CdtrWiC7iw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:k2HlZYJdDRU=:FIgjNiQBJ6+xmMOTwwi25g
 msBlz6cs1LJ76NLO1YKppCsndpe3KjTQOq0sMnc05gp2uQdv3EdrDjYjydFIAR9ido2ItFJ+q
 kNwbUtPChZzoSlWqy2ljtPi3dUi7kLXEbnrLpeZxHw6UqoLJ58A/QyDApZdbk6n6aKabOkpK1
 H/twXc6apu26uCL/bltA9MwLfkEzbi46yLHAUUH4QRbsyFOUBGlx4eoxRuh+8uMZ7RMvboQ9u
 EkxfaAK/zirAm+7GxEk4UBiuJKyKkDphMNbzpJmY0nSYGxiCjRg6FKpSPnjeZq0vbWP2OiaGM
 9hGedClSw6UmyZFQhH5EAl8JiswYqv1fjuZX6TKifWuLLa87kI/y11cHtljVAWNrtu4yOVDst
 p8+eLXo0OMLLCLnKzkJcsBxm9NYvyUYIhtpjp6A/p1CZVtUTdkjVmImTRp0hLQrZGCyKi4yL/
 FLEGORhTVtSuAuCu0NzMe1EZFcJi3oUf0lA0ww8GWkihP4dMR829zBhEV+OhGYb3AWyJLWDNZ
 PTqK8Zm620wf7lu35NPcjyZIw7mG3HN0CzYxCiESvkdrrmQ6oc9kP5C1t/5XpgL9EXuu9bD+3
 rEzfeVxeYu/s2gw29wspzUGXFVg2hOMeQhTZ7ZmXGAFylNgnDitcKpkNwNVlgqT4aG2NVUNdl
 cgcqVYNcUIvXhqSmuPiaBI30aZy3iAB9H3g1MBoZnP2hdruUiaLrWppI4MC+M4huGTqx0JjL0
 IxIiv3t93c4vI1a03tLph4tt/Pbl7MR6KxNpnHNVg+XtuPwkzhME5/9AGXxIXqvmgS4cvPZOd
 hUzFJZA+44nyY8zcMjU1kwdq24D3bo25dI3h/sbAVX+P1aWn56rcRicbt2rAvmLZX3tCmqbBB
 FnhohQyL3lOLnsd8jtSADh/SR12xFOPXF0m22Qm1fiW6woFpIY1yXi4e75UccQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 07.01.2019 um 14:26 schrieb René Scharfe:
> Yes, the functions are arranged so that odb_load_loose_cache() can be
> inlined easily.  I meant to include a patch for that but then quibbled
> about keeping the BUG check (which is probably optimized out) or not,
> and dropped it for now to get the performance fix in more quickly..

... which is probably just my laziness talking.  Sent a minimal patch
for that now.

René
