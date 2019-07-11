Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D1B0C1F461
	for <e@80x24.org>; Thu, 11 Jul 2019 17:11:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728764AbfGKRLT (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Jul 2019 13:11:19 -0400
Received: from bsmtp7.bon.at ([213.33.87.19]:9883 "EHLO bsmtp7.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728549AbfGKRLT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Jul 2019 13:11:19 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp7.bon.at (Postfix) with ESMTPSA id 45l2dc3q9Kz5tlD;
        Thu, 11 Jul 2019 19:11:16 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 7807D1D1E;
        Thu, 11 Jul 2019 19:11:15 +0200 (CEST)
Subject: Re: [PATCH] gitk: fix --all behavior combined with --not
To:     Junio C Hamano <gitster@pobox.com>, Heiko Voigt <hvoigt@hvoigt.net>
Cc:     paulus@samba.org, max@max630.net, git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <20190704080907.GA45656@book.hvoigt.net>
 <xmqq4l3wz6y8.fsf@gitster-ct.c.googlers.com>
 <xmqqr26zx0wr.fsf@gitster-ct.c.googlers.com>
 <xmqqk1crwzwd.fsf@gitster-ct.c.googlers.com>
 <20190710075835.GB65621@book.hvoigt.net>
 <xmqqa7dlu40d.fsf@gitster-ct.c.googlers.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <ca11f7c4-d6d4-3813-3066-37775ce3f48f@kdbg.org>
Date:   Thu, 11 Jul 2019 19:11:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <xmqqa7dlu40d.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 10.07.19 um 20:40 schrieb Junio C Hamano:
> Heiko Voigt <hvoigt@hvoigt.net> writes:
> 
>> behavior. How about '--all-include-head'. Then e.g.
>>
>>     git rev-parse --all-include-head --all --not origin/master
>>
>> would include the head ref like you proposed below?
>>
>> What do you think? Or would you rather go the route of changing
>> rev-parse behavior?
> 
> Depends on what you mean by the above.  Do you mean that now the end
> user needs to say
> 
> 	gitk --all-include-head --not origin/master
> 
> to get a rough equivalent of
> 
> 	git log --graph --oneline --all --not origin/master
> 
> due to the discrepancy between how "rev-parse" and "rev-list" treat
> their "--all" option?  Or do you mean that the end user still says
> "--all", and after (reliably by some means) making sure that "--all"
> given by the end-user is a request for "all refs and HEAD", we turn
> that into the above internal rev-parse call?
> 
> If the former, then quite honestly, we shouldn't doing anything,
> perhaps other than reverting 4d5e1b1319.  The users can type
> 
> 	$ gitk --all HEAD --not origin/master
> 	$ gitk $commit --not --all HEAD
> 
> themselves, instead of --all-include-head.

When --all is in the game, HEAD of the current worktree isn't all that
special among the heads of all worktrees, I would think. What if we
added a new option --heads that incorporates all worktree heads?

If we require users to type something to tell what they mean, then I
think a more generally useful command line option would be preferable
over an option that modifies the meaning of another option.

-- Hannes
