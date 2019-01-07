Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3BA3B1F803
	for <e@80x24.org>; Mon,  7 Jan 2019 13:11:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731303AbfAGNLl (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Jan 2019 08:11:41 -0500
Received: from mout.web.de ([217.72.192.78]:53935 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729844AbfAGNLl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Jan 2019 08:11:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1546866692;
        bh=O45Vfqaba/EVvKeizrAERM23ZvP/g0mivY6qnyyYeMY=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=bDvGJoPXOW15e4QEW400Bj6c31JowbvSJZ6prpBzPGFOJvGB8htL2aVxxavUkY5bc
         AEUFRBnKGnhG+94YGg1mFM6mzu/U5HaEScP2QVdYrjygst3yF1RX8/Z1ur5fj9GWh6
         iF/IvLgEBT5FQJJuqxx3Bep38ho6Jct6qKxFhpaE=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.36] ([91.20.59.41]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MUncu-1go9h140J2-00YAwj; Mon, 07
 Jan 2019 14:11:32 +0100
Subject: Re: [PATCH 1/3] object-store: factor out odb_loose_cache()
To:     Jeff King <peff@peff.net>, Philip Oakley <philipoakley@iee.org>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
References: <xmqqh8explya.fsf@gitster-ct.c.googlers.com>
 <3512c798-aa42-6fba-ee82-d33a8985be91@web.de>
 <b87e7e01-baa6-6fb2-7081-0042ecd3b6b7@web.de>
 <0797a920-32f3-aaaf-9321-528f78d980ae@iee.org>
 <20190107123012.GA6032@sigill.intra.peff.net>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <54fdfe9f-e3ec-411d-5b3c-f7f712bae5e7@web.de>
Date:   Mon, 7 Jan 2019 14:11:27 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190107123012.GA6032@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:CevO+K+2PQISjZ7uHzgORbSafrbOj+i9uWgyyVf9QHgaAaNWkR4
 M3OjZyztQaJOLOSbiMqg8WgE/v5rT0+1OwdHvdOIUvnwYlyUqhNQs9lQsaIikQAewok1reY
 OwwZA+OFxmiXLlmEsulDFULKbQNeUxTr7Y1AAwXpzsqA1bGgVI033Nmy2o2BfcHHCbE6oRT
 OJmCwNqMsK3YqVj1lDTbA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:wGdi14UIjcM=:bb1Ddg5Aok3Q3u/Hwwlp3V
 XVzxt08qG1zlK1ipMBHwgDX8CYtw+Uu9eQDYMgtqlj3DuaONl22/76emFNDGoquLIQsTofxiy
 bvNW1k4GujUkp0VuI2qmG96yJKoaqBRBvS36GZ80yRiuUay/h27WHLy5amGRvUWnKbye2YHBl
 OKbHc1HXa+m/vAihnIhhKXt9FOdzMIu/CxWgXKiT1HGQRKgKQ8OHQAnhJlMfDktEPAy08utFp
 oxLOg+zdBbhjqCoEw9pY4xlhLIpkqc2hRdqVUBXTzeNIdF0V6K3twihg7enMNBKLGQPYZyyp/
 krIxtdHi28BXNb4L90STS+ap//IdEjTJUz9ebzXlxOOrpa3hMt9cIc4vuH5mLvix8AtYdaIL7
 w1ctflKmHVNmAj0vTqSWK7hFsF6lW8DJ2dYPFSYHPNyQ9st83ZHR5Bc7d4dy+ohXuTA7vKWp3
 0ok/feIreBqsVYe8fPmYePURG9F+wxpie2wTutXB/LH/mCdQhDRF61awl9gQ0SArkoHmagNYh
 YCxjIYNM7zYV4hdHR4eAIli0G8LTwdWMdf/gHseQXM7tNuV3Dpw2DKVKV9fiTR5K15Bo0+ISK
 XJFQYHPLMXW2bmQdHABJKmCBod/t1xbtF90s1zHNAKTUtKEUq7PziMW4s0YxDj3c9hF01FK0e
 hcadCnuaKF8KfyyEls9ZF6yMRfnCxjb3D5exkH2e6R6h0STVvMJLd0ddmXWQ82kPNVfk4EBn8
 sLhfI+wQ50tDIdnaX0DVe92zjXl4YAOWc9ulxwqmQRf+aLjg8Yucb34/74AAckz7sJjUoRsyi
 SCxrxsaJmfm+qHLGtkeBNo2d6Kz2syRCLO1ZkQ3T8effnuZVJScIvIqYL5T+O0Sgdj7yYCk/y
 BzWCtzwkp8E8q7C7BgMDZSuERzYzdhWan5lDT4lQp1YYiBguvKzrW09AyjPZZi
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 07.01.2019 um 13:30 schrieb Jeff King:
> On Mon, Jan 07, 2019 at 11:27:06AM +0000, Philip Oakley wrote:
> 
>> On 06/01/2019 16:45, René Scharfe wrote:
>>> Add and use a function for loading the entries if a loose object
>>> subdirectory for a given object ID.
>>
>> The second part of the sentence 'a loose object subdirectory for a given
>> object ID' does not scan for me. Is there a word missing?
> 
> I think s/if/in/ ?

Good guess and close, but I think I meant s/if/of/.  Anyway, the idea is
that a caller provides an object ID and the function then reads the
corresponding object subdirectory.

René
