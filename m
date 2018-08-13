Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AD0F51F404
	for <e@80x24.org>; Mon, 13 Aug 2018 20:26:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729087AbeHMXKR (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Aug 2018 19:10:17 -0400
Received: from mout.web.de ([212.227.15.3]:33927 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728540AbeHMXKR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Aug 2018 19:10:17 -0400
Received: from [192.168.178.36] ([91.20.56.63]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0M3gLx-1g6Qf83N21-00rFf0; Mon, 13
 Aug 2018 22:26:23 +0200
Subject: Re: [PATCH 2/2] fsck: use oidset for skiplist
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFy?= =?UTF-8?Q?mason?= 
        <avarab@gmail.com>, Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
References: <c1ea6be5-57f7-68f1-0215-b4dceb07603a@web.de>
 <54a5367f-f832-402c-f51b-3225c92b41ad@web.de>
 <xmqqmutq5cpo.fsf@gitster-ct.c.googlers.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <49564417-fac3-ede2-7fd1-e3a5a03e4cfe@web.de>
Date:   Mon, 13 Aug 2018 22:26:22 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <xmqqmutq5cpo.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:VCDqG7Iseadg/2bxdp3G6W0S8H9H8dO3STgsIXPxSCfrKxrzevo
 +uqGOob1b72RGbQAUKb6abt/N1DhE4CoNb9aCRAAI8cDS2T3d6tWBuM+JEL/9Ygvi+LGTUx
 kuLPrx1sZGQ8J8V8ZWcGz3cVIb+tY8yerCKzdjv0STpluF9NQwCURc8TNlGfPFbSdCn/GQJ
 VOZMnQTF4kIMUUdLq3yMQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:PzWsc43EJPs=:YVdMal0JJrSjF2+d+JMzex
 gk2T5IBcN0d98hK3eQPytUBYp6nYZh+c3MW2L/mBrm8wiTNSGGo1ZEygkWSPzKVxG+847C3pd
 /ZMxe8AEggTmf0ebbfT8z0CNwTHxEsXyKCiJViWenBLYQpJbjdo1K82haEP4WHIPbDXkttikn
 9gyCZOAQ20xEmV+/NsjWjjvdz1K6seYXiABdSDNsD8SZigoGuT5t2u6P0ciMY+hqHbyEw6Ets
 WOKH3l4HN4xNWH6veCU/qT6fYm7BK87Ra5vRMEvJqtAn2glUc9i8R6zNGed7byu2QBeql/Dji
 rEUfB97w3pi62cjNCBl+DbgG1q37iaUzemwgzDMU3jCJr+TKkt1MvvF0OvJS6HUUxW084qXVi
 +v15hpPr0/gf/NB97cegnoQWm9k/d29WMKSmjsyCqWX4b2PrsK7zAX9/0sRHI7yB2dAJpt7Pg
 ZikZqEskKM8Gr/nIrYrv80ewxkru/wjFRZtGSByzhxpJasz9YgZO4VPAYJXBQYjFxeOcb+Szb
 1LUsQzLvV0ABll1NqWjeM3bDQvAp1noPN77PdKQksodl/hw01kwPi3RU9MCDjYdtH8wZyu/DL
 06ntGIJE7oWDwAQuD2rIu27bvoc83up2mrpwNQrREwTIpaqXmzk1v7sBmK6sOzONHF4WyaudP
 jS9E21s9jppgnAzrhYoI5SiscAVtKFBx7cHnpiOdXCOqX70C6sM5N5gU5Qh8dPC/HcBJpIvgM
 I0YMg2FqYaB8I2ZQvaWnURJwwLjbdhf/eH+BIcWlOFrTN6ydDbcrVKf/6btpFL7R0jLBoRM2A
 Y7kWUM9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 13.08.2018 um 20:43 schrieb Junio C Hamano:
> René Scharfe <l.s.r@web.de> writes:
> 
>> @@ -182,19 +181,10 @@ static int fsck_msg_type(enum fsck_msg_id msg_id,
>>   static void init_skiplist(struct fsck_options *options, const char
>> *path)
>>   {
>> -	static struct oid_array skiplist = OID_ARRAY_INIT;
>> -	int sorted;
>>   	FILE *fp;
>>   	struct strbuf sb = STRBUF_INIT;
>>   	struct object_id oid;
>>   -	if (options->skiplist)
>> -		sorted = options->skiplist->sorted;
>> -	else {
> 
> That SP before '-' on the removed line is the most curious aspect of
> this patch; I do not recall the last time I saw a corrupt patch from
> you---changed where you read/write your mails recently?

Well, I updated Thunderbird to version 60 a few days ago, but I can't
see that extra space in my Sent folder, nor via the NNTP interface of
the mailing list [1], nor on the web interface [2].  The latter shows
extra spaces on the context lines of the first hunk, though, which I
can't see anywhere else.  All the lines look fine in the citation of
Ramsay's reply [3].  So I don't know where these extra spaces are
coming from. :-/

René


[1] news://news.public-inbox.org:119/54a5367f-f832-402c-f51b-3225c92b41ad@web.de
[2] https://public-inbox.org/git/54a5367f-f832-402c-f51b-3225c92b41ad@web.de/
[3] https://public-inbox.org/git/bc9f21c6-b362-2e3f-1820-7da93a76a7c8@ramsayjones.plus.com/

