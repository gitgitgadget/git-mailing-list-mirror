Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,
	STOX_REPLY_TYPE shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 48A131FBB0
	for <e@80x24.org>; Sun,  4 Sep 2016 10:57:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753265AbcIDK5x (ORCPT <rfc822;e@80x24.org>);
        Sun, 4 Sep 2016 06:57:53 -0400
Received: from smtp-out-3.talktalk.net ([62.24.135.67]:2604 "EHLO
        smtp-out-3.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752791AbcIDK5w (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Sep 2016 06:57:52 -0400
Received: from PhilipOakley ([92.22.24.43])
        by smtp.talktalk.net with SMTP
        id gV7Vb4GxpxR4bgV7Vboy1q; Sun, 04 Sep 2016 11:57:50 +0100
X-Originating-IP: [92.22.24.43]
X-Spam: 0
X-OAuthority: v=2.2 cv=JNN5iICb c=1 sm=1 tr=0 a=ZBOQwd+zDMuFpFo4vDT3kw==:117
 a=ZBOQwd+zDMuFpFo4vDT3kw==:17 a=8nJEP1OIZ-IA:10 a=Zuqv9LRU0NVfUEFy61cA:9
 a=j7vvuKjHx3Ervkvb:21 a=BOLkJdh1ndbkzNHh:21 a=wPNLvfGTeEIA:10
Message-ID: <B8553589D87B4CFAB94CFB22027B9E7D@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
From:   "Philip Oakley" <philipoakley@iee.org>
To:     "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
        "Jeff King" <peff@peff.net>
Cc:     "Aaron M Watson" <watsona4@gmail.com>, <git@vger.kernel.org>,
        "Jon Seymour" <jon.seymour@gmail.com>,
        "David Caldwell" <david@porkrind.org>,
        =?iso-8859-1?Q?=D8ystein_Walle?= <oystwa@gmail.com>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>,
        "David Aguilar" <davvid@gmail.com>,
        "Alex Henrie" <alexhenrie24@gmail.com>
References: <1472944878.19860.4.camel@gmail.com> <20160904015209.ba6arov46ntr2ouq@sigill.intra.peff.net> <alpine.DEB.2.20.1609040914200.129229@virtualbox>
Subject: Re: [PATCH] stash: allow ref of a stash by index
Date:   Sun, 4 Sep 2016 11:57:51 +0100
Organization: OPDS
MIME-Version: 1.0
Content-Type: text/plain;
        format=flowed;
        charset="iso-8859-1";
        reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
X-CMAE-Envelope: MS4wfBo9sNSelRtnk1ftB0Hs47fTU18gX6w4P6nxq+q/VfrsinrSaCk6ki54hij8M0POKT8DajjMBTdWbEj7/sVlFWk0s2WbXeZqurbtDHvYeOW52lw1qZVa
 Z2fe6vez3/x8n7OfLKEhn/SuTwIecjWnHv9+mcIiGn2nxATcLGiIMC32vnJ1MCi4UetX3ZDVZJ16tJAB+VKNVzWJoXlqPQEw0I3BtzP+D1qCJLEgvp88PaYo
 ctXIZvdOA2FgdCvZh6lnUM+JlcupfH7/7FB1qqZJqyedG3oVhOxmz6soUf2ehn0/Be+NGSYq6HL7OiONz8sECFlPMn4V3cJ2scKPdEqMkOJtNZQH47KSddhY
 6cOJ6w7uAMb7U0mbGsJdRUR6uchZ1MR0r4+gTKqF3pLgQ7+jqR1g85gbR+CYsamto8oTqvoadX7n4CC0XkRnncyeG01x0g==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
> Hi,
>
> On Sat, 3 Sep 2016, Jeff King wrote:
>
>> On Sat, Sep 03, 2016 at 07:21:18PM -0400, Aaron M Watson wrote:
>>
>> > Allows stashes to be referenced by index only. Instead of referencing
>> > "stash@{n}" explicitly, it can simply be referenced as "n".
>>
>> This says "what" but not "why". I assume it is "because the former is
>> more annoying to type".
>>
>> Are there any backwards-compatibility issues you can think of?
>>
>> I think that "123456" could be a sha1, but I do not see much point in
>> referencing a sha1 as the argument of "stash show". And it looks like
>> this code path is called only from is_stash_like(), so presumably the
>> same logic would apply to other callers.
>
> Maybe we could make it unambiguous, e.g. by using #<n> instead: #123456
> cannot refer to a SHA-1.

The alternative is to limit the length to less that the shortest ambiguous 
sha1 length that has been used (by Git users - 5, 6, 7? )? Which is probably 
allowing 1-4 characters, which is a reasonbly deep stash index...

If you need to refer to stash@{9362} you have bigger problems.

> But then, '#' are comment-starting in shells, so they would have to by
> escaped. Maybe the best option would be to introduce a -n <n> option,
> with the shortcut -<n> thanks to e0319ff (parseopt: add
> OPT_NUMBER_CALLBACK, 2009-05-07).
>
> Ciao,
> Johannes
> 

