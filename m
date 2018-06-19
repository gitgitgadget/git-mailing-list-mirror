Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0B08E1F403
	for <e@80x24.org>; Tue, 19 Jun 2018 18:31:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967136AbeFSSbm (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Jun 2018 14:31:42 -0400
Received: from bsmtp7.bon.at ([213.33.87.19]:46788 "EHLO bsmtp7.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S967097AbeFSSbl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jun 2018 14:31:41 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp7.bon.at (Postfix) with ESMTPSA id 419Gkz4Hxlz5tlK;
        Tue, 19 Jun 2018 20:31:39 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 339E81CA9;
        Tue, 19 Jun 2018 20:31:39 +0200 (CEST)
Subject: Re: want <reason> option to git-rebase
To:     Jonathan Nieder <jrnieder@gmail.com>,
        Ian Jackson <ijackson@chiark.greenend.org.uk>
Cc:     git@vger.kernel.org
References: <23335.52730.475955.861241@chiark.greenend.org.uk>
 <20180619010655.GA173168@aiede.svl.corp.google.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <c5fc1505-9847-25d8-02f3-c0e666afdd1d@kdbg.org>
Date:   Tue, 19 Jun 2018 20:31:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180619010655.GA173168@aiede.svl.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 19.06.2018 um 03:06 schrieb Jonathan Nieder:
> Ian Jackson wrote[1]:
>> git-rebase leaves entries like this in the reflog:
>>
>>    c15f4d5391 HEAD@{33}: rebase: checkout c15f4d5391ff07a718431aca68a73e672fe8870e
>>
>> It would be nice if there were an option to control this message.
>> Particularly, when another tool invokes git-rebase, the other tool may
>> specify an interesting --onto, and there is no way to record any
>> information about that --onto commit.
>>
>> git-rebase already has a -m option, so I suggest
>>    --reason=<reason>
>>
>> It doesn't matter much exactly how the provided string is used.
>> Any of the following would be good IMO:
>>    <reason>
>>    rebase start: <reason>
> 
>  From git(1):
> 
>   GIT_REFLOG_ACTION
> 	When a ref is updated, reflog entries are created to keep
> 	track of the reason why the ref was updated (which is
> 	typically the name of the high-level command that updated the
> 	ref), in addition to the old and new values of the ref. A
> 	scripted Porcelain command can use set_reflog_action helper
> 	function in git-sh-setup to set its name to this variable when
> 	it is invoked as the top level command by the end user, to be
> 	recorded in the body of the reflog.
> 
> "git rebase" sets this itself, so it doesn't solve your problem.

If it does so unconditionally, then that is a bug. If a script wants to 
set GIT_REFLOG_ACTION, but finds that it is already set, then it must 
not change the value. set_reflog_action in git-sh-setup does the right 
thing.

So, if there is another script or application around git-rebase, then it 
should just set GIT_REFLOG_ACTION (if it is not already set) and export 
the environment variable to git-rebase.

-- Hannes
