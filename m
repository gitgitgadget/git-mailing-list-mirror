Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 466ADC433FE
	for <git@archiver.kernel.org>; Sun, 13 Nov 2022 17:31:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234149AbiKMRbW (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 13 Nov 2022 12:31:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231252AbiKMRbU (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 13 Nov 2022 12:31:20 -0500
Received: from mout.web.de (mout.web.de [217.72.192.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C9B11117B
        for <git@vger.kernel.org>; Sun, 13 Nov 2022 09:31:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1668360664; bh=lE/EyO3Reswt+YVzILg9SPRRS5COSA9+3l7FMQTJb18=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=qklhG4bYcNOc1Wp6FznEjoO3UiC2VXAxXNyHP/UrqAC1HgCoDcUpXeQqdONNAZtUg
         rcfOJVgfhfU3t6bCwgndeQHsMMWQ8O2mS8J61s32u2cg5BrMhNzFJhQx2Ub3/vboqp
         b65zqDDNmWYeNkghFxfR/+WBZl+ZN3Ycsl0PA6h+LsoyimDzYaEDbv4ShHPN8/wxw6
         AjGNZTq+yMSMEns0a60WnyqY6721qcW4QxnT9MiKgSu9aN2S1En/h4XogxRhl7ONKz
         gg5//uYPYb7WPS71vx7zbCArsZzQ+Ka16xp06A9lf/U9vXxWxryDvdnkbHM/psYDzg
         RmxtD9p9NkJug==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.154.159]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MUUAM-1oTuFU1W3k-00Qen2; Sun, 13
 Nov 2022 18:31:04 +0100
Message-ID: <0222bc92-bbea-6947-3523-cb10edece9bb@web.de>
Date:   Sun, 13 Nov 2022 18:31:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.2
Subject: Re: [PATCH 2/3] pack-object: simplify --filter handling
Content-Language: en-US
To:     Jeff King <peff@peff.net>
Cc:     Git List <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFy?= =?UTF-8?Q?mason?= 
        <avarab@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>,
        Christian Couder <chriscool@tuxfamily.org>
References: <c64e4fa5-62c2-2a93-a4ef-bd84407ea570@web.de>
 <59abb8d2-e8e6-7423-ead8-49382293aaa6@web.de>
 <Y2/Rwvb2uiE40rW0@coredump.intra.peff.net>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <Y2/Rwvb2uiE40rW0@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:5ZlJHjTvFmmGmFDkHpePiy3BpeUnFQboCLP7CVOrOOb/4NSNk6X
 O/2Lmfg7DNKzUS1yCSgBeWDu+fQKel9ASY6MiJJXF7uoQ+URYJlnQdHSphoeHKlXNDypRqK
 ws2ljuowW3TI/z5TmuLb3Ognm/ukd03pORuzIFFuPkBFd4RbMhbEWjDX5HIOGRzFaZjqs7J
 8IiBiuSrj+SYZml8bV9Tg==
UI-OutboundReport: notjunk:1;M01:P0:6atfOG2y+fo=;VHxit40DUYH0caN0TxIfWZi86gE
 b9qjzw3Z+/YBypL68I5t6/+QsAVENw0BPIt5tZOEXTLLblzrzISFjrMG/azFuiDNLRkbhHox8
 Gl2GklrVaQsN9G8CxertjWpGzTMw6zGnQCQO3mPxuctEgnO02JmItAYGTvWzeVX5VGFzGuXOh
 MYqkeq91CLTQnbmMi7cRrLFZcAf2v4rXdipFgzOYT6y3skMZqcgFl1ztLWqOt6XEspzM/ok55
 dQRBM/fjJx6/yoF501AqtITSNsZqePgAiOh0ClQENKTw11IMtU8tEyI7NZw54ErRTcY5c1pcb
 R5TbeGzIZRJ9CnT0ycYczjvKVLYmPILVVcE4FZknOtqU/id1WMqW+qSWrOQHmQTzQNtUZtTzZ
 DKp1pKZFtCg5CBBarm1+/uufmEEwIqRGGeyrQdzYXMsJ7106V2bvJdGM0SjVj4S7Yqe4bHi42
 IvdW4tJ/vqdFPrLR/yjzWWGGyzPcW55CLJwuPNC0tSZg/a8+ZormA6DZwrwCplnvwpQmNL8Bk
 xh3Xo2joOnHX3q9YKG96rJDZodRdwBQZ92BURqedycc2wYj+POlCH2nyLE8QevfP0WU6RdC19
 KSUJwHk3IXYoSKkIG8zIl+YdtGE3YaOXJ0ssjkpWpmzPTPJBLu8Yj09G04OoeZvQsfDu0GNPH
 Vp8ASZKEh8CGQIiXOPZ15Y968ISLXdFM4DjYgSCSNFeUaM5pRENcNegcMk5M+PoIZENCG9CVs
 1aYkDqtsEVVL8RensTlsz1DyX9eRXdDwySJB1tu5NcoL9NvjYIVDzp8KPGNGl+SBVODpdIkxh
 wopZseQ1pm0AieBs6vBI+h5oymSYr6g4AmGQxzB95eDUA/HiP7wQ7CJwNUSDg9OWQ1snYMJKa
 lJKoQruTXzeDJn5b8uaR3tBpFAqbkRtiuerNcOcacyQSYOI3z0Z7gppOc+B58p7BWHXtiil81
 eXr/gg==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 12.11.22 um 18:02 schrieb Jeff King:
> On Sat, Nov 12, 2022 at 11:44:50AM +0100, Ren=C3=A9 Scharfe wrote:
>
>> pack-objects uses OPT_PARSE_LIST_OBJECTS_FILTER_INIT() to initialize th=
e
>> a rev_info struct lazily before populating its filter member using the
>> --filter option values.  It tracks whether the initialization is needed
>> using the .have_revs member of the callback data.
>>
>> There is a better way: Use a stand-alone list_objects_filter_options
>> struct and build a rev_info struct with its .filter member after option
>> parsing.  This allows using the simpler OPT_PARSE_LIST_OBJECTS_FILTER()
>> and getting rid of the extra callback mechanism.
>
> That seems like a reasonable fix (and I think we do it elsewhere). But I
> wonder if it wouldn't be simpler to just unconditionally initialize the
> rev_info in cmd_pack_objects(), and then unconditionally release it.
> True, we _might_ not use it if we are receiving objects directly over
> stdin, but I don't think initializing it is particularly costly.
>
> And then we don't have to worry about whether it's valid (it always is),
> or about copying between two representations of the filter (there's only
> one).

Indeed that's even simpler and what we had before 5cb28270a1
(pack-objects: lazily set up "struct rev_info", don't leak, 2022-03-28).

Ren=C3=A9
