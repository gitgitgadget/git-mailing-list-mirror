Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EC42E1FA14
	for <e@80x24.org>; Sun, 16 Apr 2017 06:15:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753131AbdDPGPq (ORCPT <rfc822;e@80x24.org>);
        Sun, 16 Apr 2017 02:15:46 -0400
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:59978 "EHLO
        alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752316AbdDPGPp (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 16 Apr 2017 02:15:45 -0400
X-AuditID: 12074414-7efff70000002bfd-13-58f30c0ea77a
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id 3C.5D.11261.E0C03F85; Sun, 16 Apr 2017 02:15:43 -0400 (EDT)
Received: from [192.168.69.190] (p5B1058DF.dip0.t-ipconnect.de [91.16.88.223])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v3G6FdVZ024781
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
        Sun, 16 Apr 2017 02:15:40 -0400
Subject: Re: [PATCH v2 00/20] Separate `ref_cache` into a separate module
To:     Duy Nguyen <pclouds@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
References: <cover.1490966385.git.mhagger@alum.mit.edu>
 <xmqq1std1lmb.fsf@gitster.mtv.corp.google.com>
 <13eaacf0-5923-ad33-79ed-2cec47660904@alum.mit.edu>
 <CACsJy8BErEEmbq884XOvg=pQbcVhCkdmsaux58sMaNW_B0nSZg@mail.gmail.com>
 <CACsJy8ArrVRjmBoXtxKVtftNaSoSX_nXkuExsXwaBFkayv9kQg@mail.gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        David Turner <novalis@novalis.org>,
        Git Mailing List <git@vger.kernel.org>
From:   Michael Haggerty <mhagger@alum.mit.edu>
Message-ID: <23a5cf22-5b5d-bb2a-e0c5-50fce6abddfd@alum.mit.edu>
Date:   Sun, 16 Apr 2017 08:15:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Icedove/45.6.0
MIME-Version: 1.0
In-Reply-To: <CACsJy8ArrVRjmBoXtxKVtftNaSoSX_nXkuExsXwaBFkayv9kQg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrIKsWRmVeSWpSXmKPExsUixO6iqMvP8znCYMUbNYu1z+4wWXRd6Way
        aOi9wmyx5OFrZovuKW8ZLX609DBbzLxqbbF5czuLA4fHzll32T0WbCr16Go/wubxrHcPo8fF
        S8oe+5duY/P4vEkugD2KyyYlNSezLLVI3y6BK2P61/uMBdfZKqZOfcjUwLiMtYuRg0NCwETi
        +02bLkYuDiGBHUwSC+6vYIRwzjFJ3L7TBORwcggLeEosXj6bFcQWEfCTuLlwAhtE0RomiYPN
        B9hBHGaBiUwSJ748ZAKpYhPQlVjU0wxm8wrYS7w6M4MZxGYRUJXo+N0FNklUIERizsIHjBA1
        ghInZz5hAbE5BQIlJp28BhZnFlCX+DPvEjOELS+x/e0c5gmM/LOQtMxCUjYLSdkCRuZVjHKJ
        OaW5urmJmTnFqcm6xcmJeXmpRboWermZJXqpKaWbGCGhL7KD8chJuUOMAhyMSjy8Fv6fIoRY
        E8uKK3MPMUpyMCmJ8sr8BwrxJeWnVGYkFmfEF5XmpBYfYpTgYFYS4U1m+RwhxJuSWFmVWpQP
        k5LmYFES5/22WN1PSCA9sSQ1OzW1ILUIJivDwaEkwdvPBdQoWJSanlqRlplTgpBm4uAEGc4D
        NPwaSA1vcUFibnFmOkT+FKMux5x7X98zCbHk5eelSonzfucEKhIAKcoozYObA0tZrxjFgd4S
        5pXgBqriAaY7uEmvgJYwAS1hmPwBZElJIkJKqoEx9VPy4/3bFHhZmvbmvhDJEKsMqtFiiV8v
        6/D+2Uzlmcn53FkLZfeoZIrVVPvea2za8MbibYFV3MGL9yvi5Nmrjf/ZrNsUPvUR07OS/3pb
        im8avdx05dYPz79s+ZIXaw6lijPXqm6wv+Z168JXZf75RyZ/muQ28WZA6OY9b8K2WTqGKm0I
        fKSkxFKckWioxVxUnAgAw/Wv+zQDAAA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 04/07/2017 01:53 PM, Duy Nguyen wrote:
> On Wed, Apr 5, 2017 at 9:03 PM, Duy Nguyen <pclouds@gmail.com> wrote:
>> On Sat, Apr 1, 2017 at 12:16 PM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
>>> Duy, have you looked over my patch series? Since you've been working in
>>> the area, your feedback would be very welcome, if you have the time for it.
>>
>> You probably have guessed my answer based on my lack of response :)
>> Tomorrow is holiday though, will have a look. But I doubt I would find
>> anything given that both you and Jeff are involved in this.
> 
> Overall, very nice. I made a comment here and there, but they're more
> questions for my education than actual code review ) At least there's
> another set of eyes on this series now.

Thanks for your review! I'll submit v3 shortly to address your feedback.

Michael

