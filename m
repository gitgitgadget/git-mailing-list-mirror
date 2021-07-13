Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 537E2C07E95
	for <git@archiver.kernel.org>; Tue, 13 Jul 2021 10:43:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 33B4661249
	for <git@archiver.kernel.org>; Tue, 13 Jul 2021 10:43:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235574AbhGMKpw (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Jul 2021 06:45:52 -0400
Received: from smtprelay03.ispgateway.de ([80.67.29.7]:13703 "EHLO
        smtprelay03.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235423AbhGMKpw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Jul 2021 06:45:52 -0400
Received: from [84.163.66.71] (helo=[192.168.2.202])
        by smtprelay03.ispgateway.de with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <git@mfriebe.de>)
        id 1m3Fsh-00070G-6F; Tue, 13 Jul 2021 12:43:15 +0200
Subject: Re: PATCH: improve git switch documentation
To:     Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org
References: <c593a699-eaf2-c7ab-b522-bfd224fce829@mfriebe.de>
 <2b85a7eb-d0be-65e7-ecbb-1750abf53e53@mfriebe.de>
 <60e79c31aaa72_30b8a4208c1@natae.notmuch>
 <65362688-b65b-661c-20c1-94d7dc2118c7@mfriebe.de>
 <60e874e1c6845_215320861@natae.notmuch>
 <dbfa96f0-558e-ccaf-6e34-6d95c43848b5@mfriebe.de>
 <60e88a4b8592f_16bcb2082b@natae.notmuch>
 <ad58bd54-a9dd-59a9-4fce-f90be469cd60@mfriebe.de>
 <60e9f8d462bd9_7ef20898@natae.notmuch>
 <6f43b36b-abe1-41f2-6138-e820c974b1bd@mfriebe.de>
 <60ea07e3495e8_7ef2081d@natae.notmuch>
 <30e4c874-6b87-b03d-fa33-fde5b7e50b2a@mfriebe.de>
 <60ea2eb562f26_2a69208e8@natae.notmuch>
 <1e18c4ed-6975-5041-4b4f-75c4d3d21860@mfriebe.de>
 <60ec6d91deced_a452520825@natae.notmuch>
 <54644739-2138-8086-1696-d3c52960216c@mfriebe.de>
 <60ec74c513b2b_a45252081b@natae.notmuch>
 <0d7bd249-2aba-236a-9f93-3a5b30182d15@mfriebe.de>
 <60ec93155663f_a231f208fb@natae.notmuch>
 <3a84e4c9-4e48-1cbe-4fe6-150ff56c8508@mfriebe.de>
 <60ecbe577a086_a6b702082@natae.notmuch>
From:   Martin <git@mfriebe.de>
Message-ID: <d3678ef6-1bcd-2666-87dc-751aef2ca1a7@mfriebe.de>
Date:   Tue, 13 Jul 2021 12:42:56 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <60ecbe577a086_a6b702082@natae.notmuch>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Df-Sender: bWVAbWZyaWViZS5kZQ==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 13/07/2021 00:12, Felipe Contreras wrote:
> Martin wrote:
> A user that does:
> 
>    git switch -n <branch>
> 
> Would naturally expect a new branch to be created.
> 
> If that command creates a new branch safely, why would the user do:
> 
>    git switch -N <branch>
> 
> What do you think the user expects to happen without reading the
> documenation?

Well, first of all what would he think it does if he reads the doc? And 
if that doc looses no (explicit) word on the possible loss?

First of all (not sure, if I mentioned that before), I have seen *many* 
case like that:
The user wants to create a new branch on master "my-feature".
    git switch -c my-feature
Then he realizes that he had not been on master, but on some other 
branch. "-c" now gives an error.
So the  user reads the documentation.
Up to this point, everything is exactly as it should be.
Now what the user reads is that "-C" works if the branch already exists. 
At this point, without being prompted those user will not think of any 
content of the branch (they haven't even added some).
"-C" does in that case what they want.

Of course now, that they had no need to think about any commits, an no 
warning that would have prompted that, they believe "-C" to be save.
Next time they will have commit. And they are gone.

And as for the reflog, look at "checkout -B", "switch -C", "branch -f", 
or "reset".
In the context of re-creating/ressetting a branch, neither of them 
mention how to get it back. (and reflog is something most people learn a 
lot later)

As I said, the first part I have seen many times. The 2nd part, 
obviously only a subset. But that is rather down to people being lucky, 
than to people actually understanding that the commits will disappear.

Now, of course I cannot predict how many people would remember a warning 
it the docs.
But I can tell, if I read a doc, and it says "you may loose...", I will 
pay attention.




> 
> And what do you think they'll expect to happen given this documentation:
> 
>    Create a new branch like '--new', but if the branch already exists
>    it's replaced.
> 
> Forget about what they could misunderstand. Nobody does anything without
> a reason, so what would be the reason why a user does `git switch -N`
> instead of `git switch -n`?
> 

You and I will make the connection between "something happens to the 
branch" and "something happens to the commits".
A lot of people with less experience, who a busy looking through lots of 
stuff to solve their problem, they will not make that connection in that 
particular moment.
Heck, I've seen highly educated people missing far more obvious things 
like that.


> To me this is another instance of "do not drink scorching hot coffee".
> Sure, some users might benefit from reading this, but how many? And how
> many would be annoyed by the obvious unnecessary warning?

Well, at least in the U.S, you apparently have to tell your customers 
that the coffee you sell is hot. (If you recall, there was a "famous" 
court case).
I have always thought, that coffee should be hot (except iced coffee).
You also have to warn people not to put their pets into the microwave. 
Again to me: bleeding obvious.



> 
> Moreover, most users don't even read the documentation. Some might even
> be doing `git switch -h`, and others using zsh completion description.
> So we can't just rely on them reading this line.

Well, so we can't warn the rest? Why do we have docs at all?


> 
> If you are really worried about the user losing information, why don't
> we add a true warning:
> 
>    hint: The previous state of the '%s' branch might have been lost.
>    hint: The id was '%s'.
>    hint:
>    hint: If you didn't intend to do this, you can restore the previous
>    hint: state with:
>    hint:
>    hint:  git reset --hard @{1}
>    hint:
>    hint: Disable this message with "git config advice.switchForceNew false"
> 
> That way the user doesn't need to read the documentation.

Well yes, printing a recovery note, may be another helpful addition.

But as you said, a single way of pushing info, will not reach everyone. 
People putting the command in a script, may not read this.
Btw, a better warning would be similar to the one you get, if you leave 
behind a detached commit.
IIRC, print the sha1, and how to create a branch on that sha1.



Of course there is a different alternative, but IMHO it is overdone.
    git switch -C branch
will only force the current "head value" (I.e. the sha1 used a pointer).
So if you have no commits on that branch, or if they are part of another 
branch, then this will work.

If you stand to "loose" commits, you would have to do:
    git switch -D -C branch

(the D is just an example / other letters/words may be better)
   -D  drop commits


But even, then until that is implemented, a temporary fix by changing 
the docs would still be appropriate.
