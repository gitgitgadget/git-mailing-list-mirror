Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CBECD1F461
	for <e@80x24.org>; Mon, 19 Aug 2019 15:33:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726373AbfHSPd0 (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Aug 2019 11:33:26 -0400
Received: from smtp01.domein-it.com ([92.48.232.141]:58264 "EHLO
        smtp01.domein-it.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725536AbfHSPd0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Aug 2019 11:33:26 -0400
Received: by smtp01.domein-it.com (Postfix, from userid 1000)
        id 93373807B723; Mon, 19 Aug 2019 17:33:24 +0200 (CEST)
Received: from ferret.domein-it.nl (unknown [84.244.139.72])
        by smtp01.domein-it.com (Postfix) with ESMTP id 6687E807B723;
        Mon, 19 Aug 2019 17:33:21 +0200 (CEST)
Received: from 80-112-22-40.cable.dynamic.v4.ziggo.nl ([80.112.22.40]:47868 helo=[192.168.1.10])
        by ferret.domein-it.nl with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92)
        (envelope-from <ben@wijen.net>)
        id 1hzjel-00015d-UU; Mon, 19 Aug 2019 17:33:15 +0200
Subject: Re: [PATCH 0/2] git rebase: Make sure upstream branch is left alone.
To:     phillip.wood@dunelm.org.uk, git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Pratik Karki <predatoramigo@gmail.com>
References: <20190818095349.3218-1-ben@wijen.net>
 <0bef598c-6c89-c699-5290-ee2003db5979@gmail.com>
From:   Ben <ben@wijen.net>
Message-ID: <81b244b9-8b26-e638-56ae-827bbc522dc2@wijen.net>
Date:   Mon, 19 Aug 2019 17:33:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <0bef598c-6c89-c699-5290-ee2003db5979@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Domein-IT-MailScanner-Information: Please contact the ISP for more information
X-Domein-IT-MailScanner-ID: 1hzjel-00015d-UU
X-Domein-IT-MailScanner: Found to be clean
X-Domein-IT-MailScanner-SpamCheck: 
X-Domein-IT-MailScanner-From: ben@wijen.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip,

The expected behavior: (as per v2.21.0:/git-legacy-rebase.sh:679)
    AUTOSTASH=$(git stash create autostash)
    git reset --hard
    git checkout master
    git rebase upstream
    git stash apply $AUTOSTASH 


The actual behavior:
    AUTOSTASH=$(git stash create autostash)
    git reset --hard master
    git checkout master
    git rebase upstream
    git stash apply $AUTOSTASH 

So, the problem with the actual behavior is the move of the currently active branch with 'git reset --hard master'


Best regards,

Ben...

On 19-08-2019 11:26, Phillip Wood wrote:
> Hi Ben
> 
> On 18/08/2019 10:53, Ben Wijen wrote:
>> I found an issue with git rebase --autostash <upstream> <branch> with an dirty worktree/index.
>> It seems the currently active branch is moved, which is not correct.
> 
> I'm not sure I understand what you mean by "the currently active branch is moved". 'git rebase --autostash <upstream> <branch>' should checkout <branch> (presumably stashing any unstaged and uncommitted changes first) and then do rebase <upstream> - what's it doing instead?
> 
> Best Wishes
> 
> Phillip
> 
>> The following patches contain both a test and a fix.
>>
>> Ben Wijen (2):
>>    t3420: never change upstream branch
>>    rebase.c: make sure current branch isn't moved when autostashing
>>
>>   builtin/rebase.c            | 18 ++++++------------
>>   t/t3420-rebase-autostash.sh | 13 +++++++++----
>>   2 files changed, 15 insertions(+), 16 deletions(-)
>>
> 
