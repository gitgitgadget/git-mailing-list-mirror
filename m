Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 933961F406
	for <e@80x24.org>; Thu, 10 May 2018 18:41:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751634AbeEJSls (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 May 2018 14:41:48 -0400
Received: from smtp122.iad3a.emailsrvr.com ([173.203.187.122]:51892 "EHLO
        smtp122.iad3a.emailsrvr.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751433AbeEJSlr (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 10 May 2018 14:41:47 -0400
X-Greylist: delayed 422 seconds by postgrey-1.27 at vger.kernel.org; Thu, 10 May 2018 14:41:47 EDT
Received: from smtp24.relay.iad3a.emailsrvr.com (localhost [127.0.0.1])
        by smtp24.relay.iad3a.emailsrvr.com (SMTP Server) with ESMTP id 566C024C0D;
        Thu, 10 May 2018 14:34:45 -0400 (EDT)
X-Auth-ID: mbranchaud@xiplink.com
Received: by smtp24.relay.iad3a.emailsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id 24B4324D3F;
        Thu, 10 May 2018 14:34:45 -0400 (EDT)
X-Sender-Id: mbranchaud@xiplink.com
Received: from [10.10.1.32] ([UNAVAILABLE]. [192.252.130.194])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA)
        by 0.0.0.0:465 (trex/5.7.12);
        Thu, 10 May 2018 14:34:45 -0400
Subject: Re: Is rebase --force-rebase any different from rebase --no-ff?
To:     Ilya Kantor <iliakan@gmail.com>
References: <CAFU8umjyrJc1m65hu6QMQUiNmsJtbV65tovcWjvmzFpsCr668A@mail.gmail.com>
 <CAGZ79kb05U91_Ku7DKuwQVCrtouYwGWTCPdJFQ=bgWo91inRGA@mail.gmail.com>
 <98279912-0f52-969d-44a6-22242039387f@xiplink.com>
 <CAFU8umhPCTTUc=EZYGDhFe=GeW7_GdyrqZU0DVg7xYaE+Ajg2A@mail.gmail.com>
Cc:     Stefan Beller <sbeller@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git <git@vger.kernel.org>
From:   Marc Branchaud <marcnarc@xiplink.com>
Message-ID: <bc722982-042a-53cc-e3b3-7c2428952062@xiplink.com>
Date:   Thu, 10 May 2018 14:34:44 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CAFU8umhPCTTUc=EZYGDhFe=GeW7_GdyrqZU0DVg7xYaE+Ajg2A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2018-05-09 03:46 PM, Ilya Kantor wrote:
> I tried to compare --force-rebase VS --no-ff for the following repository:
> http://jmp.sh/E7TRjcL
> 
> There's no difference in the resulf of:
> git rebase --force-rebase 54a4
> git rebase --no-ff 54a4
> 
> (rebases all 3 commits of feature)
> 
> Also, there's no difference in interactive mode:
> git rebase --force-rebase -i 54a4
> git rebase --no-ff -i 54a4
> 
> (picks all 3 commits of feature)
> 
> Is there a case where --no-ff differs from --force-rebase?

So now that "rebase -i" respects --force-rebase, the question is what to 
do about it:

1. Teach "rebase -i" to stop respecting --force-rebase (restoring the 
original intent when --no-ff was introduced)?

2. Deprecate --no-ff?

3. Deprecate --force-rebase?

As a heavy rebase user, I find --no-ff more intuitive than 
--force-rebase.  I'd be in favour of option 3, and keeping just --no-ff 
(with -f as a synonym).

		M.


> ---
> Best Regards,
> Ilya Kantor
> 
> 
> On Wed, May 9, 2018 at 10:27 PM, Marc Branchaud <marcnarc@xiplink.com> wrote:
>> On 2018-05-09 02:21 PM, Stefan Beller wrote:
>>>
>>> +cc Marc and Johannes who know more about rebase.
>>>
>>> On Wed, May 9, 2018 at 9:01 AM, Ilya Kantor <iliakan@gmail.com> wrote:
>>>>
>>>> Right now in "git help rebase" for --no-ff:
>>>> "Without --interactive, this is a synonym for --force-rebase."
>>>>
>>>> But *with* --interactive, is there any difference?
>>>
>>>
>>> I found
>>>
>>> https://code.googlesource.com/git/+/b499549401cb2b1f6c30d09681380fd519938eb0
>>> from 2010-03-24
>>
>>
>> In the original discussion around this option [1], at one point I proposed
>> teaching rebase--interactive to respect --force-rebase instead of adding a
>> new option [2].  Ultimately --no-ff was chosen as the better user interface
>> design [3], because an interactive rebase can't be "forced" to run.
>>
>> At the time, I think rebase--interactive only recognized --no-ff.  That
>> might have been muddled a bit in the migration to rebase--helper.c.
>>
>> Looking at it now, I don't have a strong opinion about keeping both options
>> or deprecating one of them.
>>
>>                  M.
>>
>> [1] https://public-inbox.org/git/4B9FD9C1.9060200@xiplink.com/t/
>> [2]
>> https://public-inbox.org/git/1269361187-31291-1-git-send-email-marcnarc@xiplink.com/
>> [3] https://public-inbox.org/git/7vzl1yd5j4.fsf@alter.siamese.dyndns.org/
>>
>>
>>>       Teach rebase the --no-ff option.
>>>
>>>       For git-rebase.sh, --no-ff is a synonym for --force-rebase.
>>>
>>>       For git-rebase--interactive.sh, --no-ff cherry-picks all the commits
>>> in
>>>       the rebased branch, instead of fast-forwarding over any unchanged
>>> commits.
>>>
>>>       --no-ff offers an alternative way to deal with reverted merges.
>>> Instead of
>>>       "reverting the revert" you can use "rebase --no-ff" to recreate the
>>> branch
>>>       with entirely new commits (they're new because at the very least the
>>>       committer time is different).  This obviates the need to revert the
>>>       reversion, as you can re-merge the new topic branch directly.  Added
>>> an
>>>       addendum to revert-a-faulty-merge.txt describing the situation and
>>> how to
>>>       use --no-ff to handle it.
>>>
>>> which sounds as if there is?
>>>
>>> Stefan
>>>
>>
