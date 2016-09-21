Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9ACF01F935
	for <e@80x24.org>; Wed, 21 Sep 2016 20:47:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933361AbcIUUrn (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Sep 2016 16:47:43 -0400
Received: from bsmtp4.bon.at ([195.3.86.186]:44529 "EHLO bsmtp4.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752614AbcIUUrk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Sep 2016 16:47:40 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp4.bon.at (Postfix) with ESMTPSA id 3sfWsQ52Phz5tlC;
        Wed, 21 Sep 2016 22:47:38 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 169375307;
        Wed, 21 Sep 2016 22:47:38 +0200 (CEST)
Subject: Re: [PATCH tg/add-chmod+x-fix 2/2] t3700-add: protect one --chmod=+x
 test with POSIXPERM
To:     Junio C Hamano <gitster@pobox.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
References: <cee3c784-8f03-c524-2f67-d35cb3755a41@kdbg.org>
 <5effaf36-d017-3ff1-1de1-d9b303c04f23@kdbg.org> <20160920193444.GG8254@hank>
 <xmqqtwd986ml.fsf@gitster.mtv.corp.google.com>
Cc:     Git Mailing List <git@vger.kernel.org>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <8b612559-ce78-db7d-235f-61b5f78720e4@kdbg.org>
Date:   Wed, 21 Sep 2016 22:47:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <xmqqtwd986ml.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 21.09.2016 um 20:12 schrieb Junio C Hamano:
> Thomas Gummerer <t.gummerer@gmail.com> writes:
>
>>>  I am surprised that add --chmod=+x changes only the index, but not
>>>  the file on disk!?!
>>
>> I *think* --chmod is mainly thought of as a convenience for git users
>> on a filesystem that doesn't have an executable flag.  So it was
>> introduced this way as the permissions on the file system don't matter
>> in that case.

OK.

>>  A change of that behaviour may make sense for this
>> though.

Hm, git-add is for moving content from the worktree to the index. I 
don't think it should change the worktree. I should not have been surprised.

It should probably not even introduce a change in the index that it does 
not see in the worktree, but, hey, git-add is a reasonable porcelain 
substitute for the --chmod task that otherwise git-update-index would 
have to do.

> Perhaps we shouldn't even test this, then?

If I am right that git-add should not change the worktree, it should be 
tested. But 'git status -s' is probably the wrong tool for the reasons 
you gave (it could accidentally detect a change due to content 
difference instead of a file mode difference). At any rate, such a test 
must be protected with POSIXPERM.

-- Hannes

