Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09AB7C433FE
	for <git@archiver.kernel.org>; Tue,  4 Oct 2022 16:53:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229775AbiJDQxz (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Oct 2022 12:53:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbiJDQxx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Oct 2022 12:53:53 -0400
Received: from smtp.hosts.co.uk (smtp.hosts.co.uk [85.233.160.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D12552459
        for <git@vger.kernel.org>; Tue,  4 Oct 2022 09:53:51 -0700 (PDT)
Received: from 88-110-102-84.dynamic.dsl.as9105.com ([88.110.102.84] helo=[192.168.1.57])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1oflAy-0009jD-5E;
        Tue, 04 Oct 2022 17:53:48 +0100
Message-ID: <4e457155-38d2-4d34-2240-0d2f103004a1@iee.email>
Date:   Tue, 4 Oct 2022 17:53:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: Bug report [die() preserve-merges messages]
Content-Language: en-GB
To:     Alastair Douglas <alastair.douglas@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
References: <CADTs3HEn8JQzfWGP-rq_BBLvwGD163=c2i_7vFK17g+wAVec+Q@mail.gmail.com>
 <xmqqill0voft.fsf@gitster.g>
 <CADTs3HFZjX7P=n3PpjAtt=6E9m3PUgFKXksZKuOY4t71hSSnrw@mail.gmail.com>
From:   Philip Oakley <philipoakley@iee.email>
In-Reply-To: <CADTs3HFZjX7P=n3PpjAtt=6E9m3PUgFKXksZKuOY4t71hSSnrw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Alastair,

On 04/10/2022 11:15, Alastair Douglas wrote:
> On Mon, 3 Oct 2022 at 17:53, Junio C Hamano <gitster@pobox.com> wrote:
>> Alastair Douglas <alastair.douglas@gmail.com> writes:
>>
>>> I have found no solution to the issue below. Apologies if it has
>>> already been addressed.
>> Thanks for a report.
>>
>> The solution is to remove "[pull] rebase = preserve" and replace it
>> with "[pull] rebase = merges", I think.
>>
> Thanks for this reply. This seems to have worked, since I got no warning.
>
> Now that I know it is a new option to the rebase setting I have found
> it in the documentation:
>
> branch.<name>.rebase
> ...
>   When merges, pass the --rebase-merges option to git rebase so that
> the local merge commits are included in the rebase (see git-rebase(1)
> for details).
>   When preserve (deprecated in favor of merges), also pass
> --preserve-merges along to git rebase so that locally committed merge
> commits will not be flattened by running git pull.
>
> It does seem like nobody else on the internet is aware of this, since
> I didn't discover this by Googling it.
>
>> I also suspect that they were hoping that the users will read the
>> instruction based on these command line options and understand that
>> it also applies to the configuration variables.
>>
> I understood immediately that it applied to the config, but I couldn't
> find a single thing about what I *should* have done until you told me
> here.
>
> Having said all this, I am fairly sure that I checked the
> documentation for the rebase config and failed to spot that new part,
> so I am not blameless myself! I feel like *something* could be updated
> to point in the right direction, but I really don't know what.
> Yesterday, I genuinely thought there was no replacement config for the
> deprecated one!
>
> Thanks for your time, but I suppose, in conclusion, there's not a lot
> to be done.

Earlier this year, I tried to update the error messages to catch the
various ways that the removal of 'preserve-merges' could be confusing to
users, based on a Git for Windows user's report [1,2].

It is rare for a method to be removed, so there was little experience of
how best to handle all the different use cases.

In general, the approach was to ensure that users could not fail to
notice that something had changed, or needed to be changed. The problem
with 'preserve-merges' being that there were scenarios where the code
did the wrong thing and users were not noticing, and further it wasn't
clear to users which case that was, nor how to explain it, given the
mind-set confusions!

In general Git avoids rolling over old options to new variants, without
notification, if they do different things. It would have been nice to
cover more use cases, but often the cause was not known at the point the
problem was detected in the code, as you have seen.

It was expected that users should have been aware of their own
configuration settings, though that's not always true (see the mailing
list discussions).

Philip

[1]
https://lore.kernel.org/git/pull.1155.git.1645526016.gitgitgadget@gmail.com/
 Subject: [PATCH 0/2] Update the die() preserve-merges messages to help
some users   22 Feb 2022
[2]
https://lore.kernel.org/git/pull.1242.v2.git.1654341469.gitgitgadget@gmail.com/
Subject: [PATCH v2 0/4] Die preserve ggg   04 Jun 2022
