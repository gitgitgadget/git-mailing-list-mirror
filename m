Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 784391F576
	for <e@80x24.org>; Sun,  4 Mar 2018 10:44:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752602AbeCDKod (ORCPT <rfc822;e@80x24.org>);
        Sun, 4 Mar 2018 05:44:33 -0500
Received: from smtprelay01.ispgateway.de ([80.67.29.23]:43260 "EHLO
        smtprelay01.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751844AbeCDKoc (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Mar 2018 05:44:32 -0500
X-Greylist: delayed 89811 seconds by postgrey-1.27 at vger.kernel.org; Sun, 04 Mar 2018 05:44:32 EST
Received: from [91.113.179.170] (helo=[192.168.92.26])
        by smtprelay01.ispgateway.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.89)
        (envelope-from <marc.strapetz@syntevo.com>)
        id 1esR81-0002EN-Fi; Sun, 04 Mar 2018 11:44:29 +0100
Subject: Re: git stash push -u always warns "pathspec '...' did not match any
 files"
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     git@vger.kernel.org
References: <349f9369-b799-4f7b-bda1-33bcbd7ea067@syntevo.com>
 <20180303154654.GH2130@hank>
From:   Marc Strapetz <marc.strapetz@syntevo.com>
Message-ID: <08d765ec-b2d7-7087-fca5-2eecefcef9cf@syntevo.com>
Date:   Sun, 4 Mar 2018 11:44:30 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180303154654.GH2130@hank>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Df-Sender: bWFyYy5zdHJhcGV0ekBzeW50ZXZvLmNvbQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03.03.2018 16:46, Thomas Gummerer wrote:
> On 03/03, Marc Strapetz wrote:
>> Reproducible in a test repository with following steps:
>>
>> $ touch untracked
>> $ git stash push -u -- untracked
>> Saved working directory and index state WIP on master: 0096475 init
>> fatal: pathspec 'untracked' did not match any files
>> error: unrecognized input
>>
>> The file is stashed correctly, though.
>>
>> Tested with Git 2.16.2 on Linux and Windows.
> 
> Thanks for the bug report and the reproduction recipe.  The following
> patch should fix it:

Thanks, I can confirm that the misleading warning message is fixed.

What I've noticed now is that when using -u option, Git won't warn if 
the pathspec is actually not matching a file. Also, an empty stash may 
be created. For example:

$ git stash push -u -- nonexisting
Saved working directory and index state WIP on master: 171081d initial 
import

I would probably expect to see an error message as for:

$ git stash push -- nonexisting
error: pathspec 'nonexisting' did not match any file(s) known to git.
Did you forget to 'git add'?

That said, this is no problem for us, because I know that the paths I'm 
providing to "git stash push" do exist. I just wanted to point out.

-Marc

