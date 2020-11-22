Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EEF2C5519F
	for <git@archiver.kernel.org>; Sun, 22 Nov 2020 11:20:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2453620773
	for <git@archiver.kernel.org>; Sun, 22 Nov 2020 11:20:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727457AbgKVLUb (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 22 Nov 2020 06:20:31 -0500
Received: from smtp.hosts.co.uk ([85.233.160.19]:18708 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727373AbgKVLUa (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Nov 2020 06:20:30 -0500
Received: from host-89-243-187-160.as13285.net ([89.243.187.160] helo=[192.168.1.37])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1kgnPv-000Byu-8E; Sun, 22 Nov 2020 11:20:27 +0000
Subject: Re: [PATCH 00/28] Use main as default branch name
To:     Sergey Organov <sorganov@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
References: <pull.762.git.1605221038.gitgitgadget@gmail.com>
 <87r1oraewl.fsf@x220.int.ebiederm.org>
 <xmqqv9e34mq5.fsf@gitster.c.googlers.com>
 <1389dabc-33c9-1e65-a3de-43729a6c2e70@iee.email>
 <xmqqh7pmyuzn.fsf@gitster.c.googlers.com>
 <7df660f2-ad74-7d1f-eb13-a0edadffbfbf@iee.email> <871rgpr497.fsf@osv.gnss.ru>
 <xmqqpn46qppl.fsf@gitster.c.googlers.com> <87y2it8zfm.fsf@osv.gnss.ru>
From:   Philip Oakley <philipoakley@iee.email>
Message-ID: <9be54e8e-a702-0eb9-97c9-7a1fac82ed5d@iee.email>
Date:   Sun, 22 Nov 2020 11:20:26 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <87y2it8zfm.fsf@osv.gnss.ru>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 22/11/2020 10:21, Sergey Organov wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> Sergey Organov <sorganov@gmail.com> writes:
>>
>>> To me "not on a branch [tip]" is also confusing, as in fact you are, as
>>> is easily seen after you perform a few commits, and now HEAD points
>>> directly to the tip of the branch (that has no other references).
>> Aren't you confused about what "on a branch" means?
> I believe I'm not.

Isn't this one of those "implementation detail" viewpoint arguments,
combined with some incompleteness in various places.

From a naive english user perspective , 'on' a branch can also mean
anywhere along a branch and not just at the tip. Being at a commit along
a branch can be tricky to appreciate (that on/at distinction isn't
immediately obvious..)
>
>> After either of these two operations, your HEAD may point at the
>> same commit, but the former is on a branch (the master branch), and
>> the latter is not.
>>
>>     git checkout master
>>     git checkout master^0
>>
>> The difference between these two states does *NOT* come from which
>> commit HEAD points at.
> Sure.
From an implementation perspective one can go two ways, and we tell the
user which way we went, even though, ultimately, we look at the same
commit.

Though, for an unborn branch we don't have a null commit value (c.f.
empty tree) to help in being 'detached at nowhere'.
>
>> The difference comes from what happens when you make a new commit
>> starting from that state.  The former (i.e. you are on a branch)
>> grows the branch.
> Sure.
>
>> The latter (i.e. you are not on a branch) does not grow any branch.
> That's one way of looking at it, resulting in this "detached HEAD"
> thingy that is too technical for the git user proper, I think. Moreover,
> it immediately raises the question: if it doesn't grow any branch, /what/
> does it grow?
>
> Another way of describing it, that I prefer, is that you /are/ on an
> /unnamed/ branch and new commits grow this particular /unnamed/ branch.
> No need not only for "detached", but even for "HEAD" to be known to the
> user to get the idea, I think.
I don't think we can start like this and continue with a commit on top
of the orphaned 'unnamed' branch. (Not tried it though..)
>
>> This is an unrelated trivia, but did anybody know that we were
>> pretty much on the detached HEAD all the time for more than a month
>> of early life of Git, until cad88fdf (git-init-db: set up the full
>> default environment, 2005-05-30)?
> I was not aware, and it seems that in my terminology it'd sound: "Git
> didn't have named branches until cad88fdf".
>
> -- Sergey

