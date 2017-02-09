Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2C0EE1FCC7
	for <e@80x24.org>; Thu,  9 Feb 2017 15:07:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753280AbdBIPHc (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Feb 2017 10:07:32 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:43899 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753023AbdBIPH3 (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 9 Feb 2017 10:07:29 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 323E320B4D;
        Thu,  9 Feb 2017 10:07:24 -0500 (EST)
Received: from frontend2 ([10.202.2.161])
  by compute1.internal (MEProxy); Thu, 09 Feb 2017 10:07:24 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=warpmail.net; h=cc
        :content-transfer-encoding:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc:x-sasl-enc; s=mesmtp; bh=8GeLXL1vbIm5L5K
        7EaKHDT6SaBU=; b=FkJLJHTdwcg6JhJDH2uQp8AbyE8sN4RQpvwx9s2jOovEdeN
        VW0zqFd43j0W262AGf2rVEAlXFcsZ9yNwP/svV3DXRHX2DAkLKjyWLHJj6FHVg7R
        sjipe5Np0fsNeCdiL/1q2WHaUagO0nzgMbjP/jB279AKTjBHRJmpuTlp8yh4=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-sender:x-me-sender:x-sasl-enc:x-sasl-enc; s=
        smtpout; bh=8GeLXL1vbIm5L5K7EaKHDT6SaBU=; b=EEE1dxZ/5PTLXPjeIS/C
        ZNcP86b9gvLuINbU6NDkbYaMyKRi5TiwXhtV9qiYWFVlvIe9IXaDHNFXXO9ZwGBA
        v0J5vWzu3WcieC74UH3IUClmrcE8U1r12VwO1xsu17uDIA8yIck75lgjVJVSV26z
        IsHAHyVlHdpTg4GkhqJ/ZZ4=
X-ME-Sender: <xms:rIWcWPhd45UX4ekR2vvpj7Bun_7jEhGtsCyaajr5EgdyyTPr8kSNSw>
X-Sasl-enc: jWCrzdgusd5wbJnj0TopYZH5unk6jx2PNMdAS6MkhvRi 1486652843
Received: from skimbleshanks.math.uni-hannover.de (skimbleshanks.math.uni-hannover.de [130.75.46.4])
        by mail.messagingengine.com (Postfix) with ESMTPA id 543AF24605;
        Thu,  9 Feb 2017 10:07:23 -0500 (EST)
Subject: Re: Bug with fixup and autosquash
To:     Junio C Hamano <gitster@pobox.com>,
        Ashutosh Bapat <ashutosh.bapat@enterprisedb.com>
References: <CAFjFpRe8zqxs4OLbCrjnuEzF=75sbBJ+HuZqek49B=O=TFHq8A@mail.gmail.com>
 <xmqqbmucuwb0.fsf@gitster.mtv.corp.google.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Matthieu Moy <Matthieu.Moy@imag.fr>
From:   Michael J Gruber <git@drmicha.warpmail.net>
Message-ID: <07eb2367-9509-afb0-2494-f02a44304bc4@drmicha.warpmail.net>
Date:   Thu, 9 Feb 2017 16:07:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.0
MIME-Version: 1.0
In-Reply-To: <xmqqbmucuwb0.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano venit, vidit, dixit 08.02.2017 23:55:
> Ashutosh Bapat <ashutosh.bapat@enterprisedb.com> writes:
> 
>> I have been using git rebase heavily these days and seem to have found a bug.
>>
>> If there are two commit messages which have same prefix e.g.
>> yyyyyy This is prefix
>> xxxxxx This is prefix and message
>>
>> xxxxxx comitted before yyyyyy
>>
>> Now I commit a fixup to yyyyyy using git commit --fixup yyyyyy
>> zzzzzz fixup! This is prefix
>>
>> When I run git rebase -i --autosquash, the script it shows me looks like
>> pick xxxxxx This is prefix and message
>> fixup zzzzzz fixup! This is prefix
>> pick yyyyyy This is prefix
>>
>> I think the correct order is
>> pick xxxxxx This is prefix and message
>> pick yyyyyy This is prefix
>> fixup zzzzzz fixup! This is prefix
>>
>> Is that right?
> 
> Because "commit" pretends as if it took the exact commit object name
> to be fixed up (after all, it accepts "yyyyyy" that is a name of the
> commit object), it would be nice if the fixup is applied to that
> exact commit, even if you had many commits that share exactly the
> same title (i.e. not just shared prefix).
> 
> Unfortunately, "rebase -i --autosquash" reorders the entries by
> identifying the commit by its title, and it goes with prefix match
> so that fix-up commits created without using --fixup option but
> manually records the title's prefix substring can also work.  
> 
> We could argue that the logic should notice that there is one exact
> match and another non-exact prefix match and favor the former, and
> certainly such a change would make your made-up example (you didn't
> actually have a commit whose title is literally "This is prefix")
> above work better.
> 
> But I am not sure if adding such heuristics would really help in
> general.  It would not help those whose commits are mostly titled
> ultra-vaguely, like "fix", "bugfix", "docfix", etc.
> 
> Another possibility is to teach "commit --fixup" to cast exact
> commit object name in stone.  That certainly would solve your
> immediate problem, but it has a grave negative impact when the user
> rebases the same topic many times (which happens often).
> 
> For example, I may have a series of commits A and B, notice that A
> could be done a bit better and have "fixup A" on top, build a new
> commit C on it, and then realize that the next step (i.e. D) would
> need support from a newer codebase than where I started (i.e. A^).
> 
> At that point, I would have a 4-commit series (A, B, "fixup A", and
> C), and I would rebase them on top of something newer.  I am
> undecided if that "fixup A" is really an improvement or unnecessary,
> when I do this, but I do know that I want to build the series on top
> of a different commit.  So I do rebase without --autosquash (I would
> probably rebase without --interactive for this one).
> 
> Then I keep working and add a new commit D on top.  After all that,
> I would have a more-or-less completed series and would be ready to
> re-assess the whole series.  I perhaps decide that "fixup A" is
> really an improvement.  And then I would "rebase -i" to squash the
> fix-up into A.
> 
> But notice that at this point, what we are calling A has different
> object name than the original A the fixup was written for, because
> we rebased once on top of a newer codebase.  That commit can still
> be identified by its title, but not with its original commit object
> name.
> 
> I think that is why "commit --fixup <commit>" turns the commit
> object name (your "yyyyyy") into a string (your "This is prefix")
> and that is a reasonable design decision [*1*].
> 
> So from that point of view, if we were to address your issue, it
> should happen in "rebase -i --autosquash" side, not "commit --fixup"
> side.
> 
> Let's hear from some of those (Cc'ed) who were involved in an
> earlier --autosquash thread.
> 
> https://public-inbox.org/git/cover.1259934977.git.mhagger@alum.mit.edu/
> 
> 
> [Footnote]
> 
> *1* "rebase -i --autosquash" does understand "fixup! yyyyyy", so if
>     you are willing to accept the consequence of not being able to
>     rebase twice, you could instead do
> 
> 	$ git commit -m "fixup! yyyyyy"
> 
>     I would think.

Doesn't this indicate that rebase is fine as is? How about:

- introduce "git commit --fixup-fixed=<rev>" or the like which parses
<rev> commits "-m fixup! <sha1>"

- teach "git commit --fixup=<rev>" to check for duplicates (same prefix,
maybe only in "recent" history) and make it issue a warning, say:

prefix <prefix> matches the following commits:
<sha1> <subject>
Issue
git commit --amend -m 'fixup! <sha1>'
to fixup a specific commit.

(Or git commit --amend --fixup-fixed=<rev> if that flies.)

Additionally, we could teach commit --fixup-fixed to commit -m "fixup!
<sha1> <prefix>" so that we have both uniqueness and verbosity in the
rebase-i-editor. This would allow "rebase -i" to fall back to the old
mode when "<sha1>" is not in the range it operates on. We could also try
to rewrite <sha1>s when rebasing (without squashing) fixup!-commits, of
course.

Michael
