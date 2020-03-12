Return-Path: <SRS0=YYoh=45=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53394C10DCE
	for <git@archiver.kernel.org>; Thu, 12 Mar 2020 10:40:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3823F206BE
	for <git@archiver.kernel.org>; Thu, 12 Mar 2020 10:40:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726299AbgCLKkY convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Thu, 12 Mar 2020 06:40:24 -0400
Received: from smtp.msys.ch ([46.175.8.2]:38132 "EHLO sleipnir.msys.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725268AbgCLKkY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Mar 2020 06:40:24 -0400
Received: from mail.msys.ch (smtp.msys.ch [46.175.8.2])
        by sleipnir.msys.ch (8.14.3/8.14.3) with ESMTP id 02CBVDS6014394
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
        Thu, 12 Mar 2020 11:31:13 GMT
Received: from [46.175.8.181] ([46.175.8.181])
        (authenticated bits=0)
        by mail.msys.ch (8.14.3/8.14.3) with ESMTP id 02CBVCPM003329
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
        Thu, 12 Mar 2020 11:31:13 GMT
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.60.0.2.5\))
Subject: Re: Regression in git-subtree.sh, introduced in 2.20.1, after
 315a84f9aa0e2e629b0680068646b0032518ebed
From:   Marc Balmer <marc@msys.ch>
In-Reply-To: <BAB4CF6D-6904-4698-ACE1-EBEEC745E569@msys.ch>
Date:   Thu, 12 Mar 2020 11:40:09 +0100
Cc:     Tom Clarkson <tqclarkson@icloud.com>,
        "Strain, Roger L." <roger.strain@swri.org>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        "gitster@pobox.com" <gitster@pobox.com>,
        "ns@nadavsinai.com" <ns@nadavsinai.com>,
        "pclouds@gmail.com" <pclouds@gmail.com>
Content-Transfer-Encoding: 8BIT
Message-Id: <6FCBB30F-4557-46E4-8255-B9746887F151@msys.ch>
References: <nycvar.QRO.7.76.6.1912091615200.31080@tvgsbejvaqbjf.bet>
 <7E95BE86-BD96-482F-9ECA-DBDD9C10D114@msys.ch>
 <nycvar.QRO.7.76.6.1912092037540.31080@tvgsbejvaqbjf.bet>
 <D99ED706-EC49-4A52-8186-5C9B0B5BC744@icloud.com>
 <038c72f0349174bb92e1dd9c3b38f02543ba1d95.camel@swri.org>
 <5C8CA727-370E-4CEE-BBF9-F336C5921D98@icloud.com>
 <nycvar.QRO.7.76.6.1912131440400.46@tvgsbejvaqbjf.bet>
 <2BB5D7E6-D565-4DCF-8E4D-D410AC1F91F3@msys.ch>
 <BAB4CF6D-6904-4698-ACE1-EBEEC745E569@msys.ch>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-Mailer: Apple Mail (2.3608.60.0.2.5)
X-SMTP-Vilter-Version: 1.3.6
X-Spamd-Symbols: BAYES_00,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

G'day

Due to some issue in git subtree, a subtree push pushed all commits (over 8000) ever done to the main repository.  So the history of the subtree'ed repository not only showed commits done to the particular subtree, but all commits in the whole project (see E-mail exchange below).

Today we decided to no longer use subtrees, but to use two independend repository and managing merges manually.

How can we get rid of a subtree cache data?  Is it enough to remove the .git/subtree-cache directory?  Or is that dangerous?  Does git-subtree store any data anywhere else?

Thanks and regards,
Marc


> Am 14.12.2019 um 14:59 schrieb Marc Balmer <marc@msys.ch>:
> 
> 
> 
>> Am 14.12.2019 um 09:29 schrieb Marc Balmer <marc@msys.ch>:
>> 
>> 
>> 
>>> Am 13.12.2019 um 14:41 schrieb Johannes Schindelin <Johannes.Schindelin@gmx.de>:
>>> 
>>> Hi Tom,
>>> 
>>> On Thu, 12 Dec 2019, Tom Clarkson wrote:
>>> 
>>>> 
>>>>> This makes me wonder if the problem is perhaps related to the hardware
>>>>> involved; maybe the algorithm is doing exactly what it should, but the
>>>>> available RAM isn't sufficient. If that's the problem, perhaps we could
>>>>> find a way to perform the recursive work without using actual
>>>>> recursion, reducing the number of instances on the stack.
>>>> 
>>>> It’s not so much hardware as OS I think - After adding stack depth (the indent parameter on check_parents) to the log, I have been able to get different results with ulimit settings.
>>> 
>>> Do you mean to say that the stack overflow is reported as a segmentation
>>> fault? If so, that message was sure a red herring...
>> 
>> FWIW, changing the stack limit using ulimit does not change anything on my (Fedora) system.  At some point, with exactly the same two leading numbers (those separated with a /)it seems to enter an endless (recursive) loop, eventually eating up all memory.  And then, after some time, it segfaults.
>> 
>> 
> 
> So today I tried a subtree push again.  It took hours.... Then it pushed every single commit that was ever done to repository.
> 
> I can definitely say that git subtree is totally broken and unusable at this moment.
> 
> We will now split out what once was a subtree into a proper repository of it's own.  git subtree was a nice idea, but it does not work.
> 
>>> 
>>> Thanks,
>>> Dscho
>>> 
>>>> 
>>>> With the default stack size on macOS of 8MB, It falls over at depth 445. Being less than the shortest path to the root commit, that matches my initial count, which was just the number of lines in the log.
>>>> 
>>>> Reducing the stack size with ulimit -s 4096 makes it fall over at 225
>>>> 
>>>> Increasing to the hard limit of 64MB should allow a depth of around 4000, and as it turns out that did allow the script to complete, reaching a maximum depth of 1148.
>>>> 
>>>> I’m not seeing any issues with the hashes being wrong (all show no parents or subtree) but processing all those commits that resolve to nothing does take forever.
>>>> 
>>>> The mainline commit test seems to work ok on my repo, but it’s fairly easy to see scenarios where it would break, such as having a  subfolder with the same name within the subtree.
>>>> 
>>>> So while part of the fix will be a more reliable test, it also needs to work before parent commits are processed to mitigate the recursion issues.
>>>> 
>>>> The rules I have  come up with so far are below. There are still scenarios where the recursion is unavoidable such as running an initial split on a large repo, but that should be much less common than using a small subtree with a more complex existing repo.
>>>> 
>>>> In the initial setup of cmd_split, collect some extra information:
>>>> 
>>>> 	- Add rev-list of all git-subtree-split values to the cache. I’d expect subtrees to usually be smaller than mainline, but since we can do that non-recursively we may as well.
>>>> 
>>>> 	- Find the git-subtree-mainline value from subtree add/rejoin. Anything in its rev list should only be reachable by mainline commits. If not (which probably requires doing something convoluted like having subtree include mainline as its own subtree), this is a good place to check that and fall back to the existing behavior.
>>>> 
>>>> 
>>>> When processing each commit:
>>>> 
>>>> If no prior splits were found, we only have mainline commits.
>>>> 
>>>> 	- If $dir exists, it is a mainline commit needing copy - use existing process.
>>>> 	- If $dir does not exist, it is a mainline commit that will map to nothing - no need to process further.
>>>> 
>>>> If we do have some known subtree commits:
>>>> 
>>>> 	- If it is in the cache, it is a subtree commit we don’t need to process further.
>>>> 	- If subtree root is not reachable (rev-list or merge-base), must be mainline pre subtree add. Map to nothing and skip further processing.
>>>> 	- If any subtree root is reachable, could be either mainline commit with subtree merged in, or subtree commit newer than the last add/squash (subtree pull/merge without squash does not use a custom commit message)
>>>> 		- If $dir does not exist, must be subtree - add to the cache as mapped to self, no need to process parents.
>>>> 		- If the folder does exist, it is  either a mainline commit to be processed normally, or a subtree that happens to contain a folder with the same name.  Check if mainline root is reachable.

