Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 88C64207EC
	for <e@80x24.org>; Tue, 11 Oct 2016 11:51:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752622AbcJKLvQ convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Tue, 11 Oct 2016 07:51:16 -0400
Received: from iramx2.ira.uni-karlsruhe.de ([141.3.10.81]:38622 "EHLO
        iramx2.ira.uni-karlsruhe.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751479AbcJKLvP (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 11 Oct 2016 07:51:15 -0400
Received: from irawebmail.ira.uni-karlsruhe.de ([141.3.10.230] helo=webmail)
        by iramx2.ira.uni-karlsruhe.de with esmtps port 25 
        iface 141.3.10.81 id 1btvaN-0006Xr-Vj; Tue, 11 Oct 2016 13:51:08 +0200
Received: from apache by webmail with local (Exim 4.84_2)
        (envelope-from <szeder@ira.uka.de>)
        id 1btvaN-0003zX-TF; Tue, 11 Oct 2016 13:51:07 +0200
Received: from x590ca9e0.dyn.telefonica.de (x590ca9e0.dyn.telefonica.de
 [89.12.169.224]) by webmail.informatik.kit.edu (Horde Framework) with HTTPS;
 Tue, 11 Oct 2016 13:51:07 +0200
Date:   Tue, 11 Oct 2016 13:51:07 +0200
Message-ID: <20161011135107.Horde.XsPGOYSpK0L1qW2xMcGqD1i@webmail.informatik.kit.edu>
From:   SZEDER =?utf-8?b?R8OhYm9y?= <szeder@ira.uka.de>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Jakub =?utf-8?b?TmFyxJlic2tp?= <jnareb@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>,
        Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH/RFC] git.c: support "!!" aliases that do not move cwd
References: <20161006114124.4966-1-pclouds@gmail.com>
 <xmqq60p5l3om.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.20.1610071319520.35196@virtualbox>
 <e1b432bc-97b4-15be-aa44-71921c64cd15@gmail.com>
 <alpine.DEB.2.20.1610071616390.35196@virtualbox>
 <f41a1371-7771-1960-27e0-cba0ee5b1461@gmail.com>
 <CACsJy8Bip0mscutDHib-2O1g+eN2twO0m+OyOg2BTUudjOdwfw@mail.gmail.com>
In-Reply-To: <CACsJy8Bip0mscutDHib-2O1g+eN2twO0m+OyOg2BTUudjOdwfw@mail.gmail.com>
User-Agent: Horde Application Framework 5
Content-Type: text/plain; charset=utf-8; format=flowed; DelSp=Yes
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
X-ATIS-AV: ClamAV (iramx2.ira.uni-karlsruhe.de)
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de 1476186668.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Quoting Duy Nguyen <pclouds@gmail.com>:

> On Fri, Oct 7, 2016 at 10:55 PM, Jakub Narębski <jnareb@gmail.com> wrote:
>> W dniu 07.10.2016 o 16:19, Johannes Schindelin pisze:
>>> On Fri, 7 Oct 2016, Jakub Narębski wrote:
>>
>>>> Note that we would have to teach git completion about new syntax;
>>>> or new configuration variable if we go that route.
>>>
>>> Why would we? Git's completion does not expand aliases, it only completes
>>> the aliases' names, not their values.
>>
>> Because Git completion finds out which _options_ and _arguments_
>> to complete for an alias based on its expansion.
>>
>> Yes, this is nice bit of trickery...
>
> It's c63437c (bash: improve aliased command recognition - 2010-02-23)
> isn't it? This may favor j6t's approach [1] because retrieving alias
> attributes is much easier.
>
> [1]
> https://public-inbox.org/git/20161006190720.4ecf3ptl6msztoya@sigill.intra.peff.net/T/#mb1d7b8f31d595b05105b8ea2137756761e13dbf4
> --
> Duy

The completion script is concerned in three ways:

   1. it has to get the names of all aliases, to offer them along with
      git commands for 'git <TAB>' or 'git help <TAB>',

   2. it has to get the command executed in place of the alias, and

   3. strip everything that can't be a git command, so it can offer the
      right options for the aliased command.


The '!!' syntax is the easiest, I think it will just work even with
the current completion code, no changes necessary.

The '(nocd)' form is still easy, we only have to add this '(nocd)' to
that list of stripped words for (3), but no further changes necessary
for (1) and (2).

'alias.d2u.command' is tricky.  Both (1) and (2) require adjustments,
preferably in a way that doesn't involve additional git processes, at
least for (1), as it is executed often, for every 'git <TAB>', for the
sake of users on platforms with not particularly stellar fork()+exec()
performance.  I think it would be possible to have only one 'git
config --get-regexp' and a little bit of post processing in each case,
but I didn't think too hard about possible pitfalls, especially when
dealing with ambiguity when both 'alias.d2u' and 'alias.d2u.command'
are set.  And I won't think any more about it until a conclusion is
reached that we'll go this route :)


