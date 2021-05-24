Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF9E9C04FF3
	for <git@archiver.kernel.org>; Mon, 24 May 2021 09:50:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A61F86113B
	for <git@archiver.kernel.org>; Mon, 24 May 2021 09:50:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232488AbhEXJwV (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 May 2021 05:52:21 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:42917 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232313AbhEXJwU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 May 2021 05:52:20 -0400
Received: from host-92-1-139-132.as13285.net ([92.1.139.132] helo=[192.168.1.37])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1ll7EZ-0008AQ-DJ; Mon, 24 May 2021 10:50:51 +0100
Subject: Re: fast forward merge overwriting my code
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Andre Ulrich <andre.ulrich@smail.fh-koeln.de>, git@vger.kernel.org
References: <20210522154815.Horde.rqiNSyIc3CGJECACotWLO1T@webmail.th-koeln.de>
 <8f3d4d1e-18f4-ccb2-9439-80a5812c2f36@iee.email> <xmqqo8d1o5ni.fsf@gitster.g>
From:   Philip Oakley <philipoakley@iee.email>
Message-ID: <f3f8927f-75af-c3bd-07af-5fd4b64987e9@iee.email>
Date:   Mon, 24 May 2021 10:50:50 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <xmqqo8d1o5ni.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 23/05/2021 16:01, Junio C Hamano wrote:
> Philip Oakley <philipoakley@iee.email> writes:
>
>> On 22/05/2021 16:48, Andre Ulrich wrote:
>>> .... Then I use
>>>
>>> git checkout master
>>>
>>> and
>>>
>>> git merge testing
>>>
>>> I would expect git to tell me "hey, wait, you have changed some of the
>>> first lines in the .txt file. When you merge, your code on master will
>>> be altered". But git just merges everything in.
>> ...
>> maybe `git merge --no-ff testing` for use of a command line option
>>
>> or setup your .gitconfig e.g. `git config --global merge.ff no`,
>> but also `git config --global pull.ff yes` if you are using `git pull`
>> (=fetch + merge)
> I didn't get an impression that this has anything to do with
> fast-forwarding, though.  

Andre had (in the body of the text) explicitly said that it was the fast
forward that was the problem for him.

I suspect he had a mental model / world view / weltanshauung that was
more aligned to a swim lane model of branches (named lines of
development) and that, possibly in a GUI, the loss two lanes was rather
confusing.

> The file in question has changes on the
> "testing" branch since it forked from "master", and the user is
> merging, i.e. the user _assumes_ that the tip of each branch suits
> his/her purpose better than the tip of the other branch, hence wants
> to take improvements on both branches incorporated into a single
> history--- which is the point of "merging" the testing branch into
> the master branch.  

In his description it's not always clear "also change some of the
already existing lines" what happened elsewhere that could lead to the
confusion. It will have been tricky for Andre, as someone new to git, to
really know what was going on. We can't assume the new user knows what
Git will do.

> The result of merging might reveal that the tip
> of the other branch wasn't as great as s/he earlier thought, in
> which case s/he may want to undo the merge.  But if the result of
> merging better suites his/her purpose, it would be an improvement
> over where 'master' used to be (and it would also be an improvement
> over where 'testing' used to be), and the world makes a progress.
>
> In this particular case, the "master" side did not move since the
> two branches forked, so the merge was to take improvements made on
> "testing" into "master", and if the edit to the file in question
> made on "testing" were bogus, the merging operation of course will
> bring that breakage in, together with all the other changes.  Since
> the lack of any progress on the "master" side does not change this
> picture, I do not think fast-forwardness has anything to do with
> what Andre is complaining about.
>
> "git merge" cannot be expected to inspect the file and point out
> "no, the edit they made on the testing branch is totally bogus,
> don't merge it".  That is left for humans and tools other than Git
> (like test suite) may help them.
>
>
The changes to mental models that are needed to understand Git can take
some time, especially for those who haven't grown up with it.

Philip
