Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3789C11F64
	for <git@archiver.kernel.org>; Thu,  1 Jul 2021 17:29:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 988AF61407
	for <git@archiver.kernel.org>; Thu,  1 Jul 2021 17:29:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233207AbhGARbl (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Jul 2021 13:31:41 -0400
Received: from smtprelay08.ispgateway.de ([134.119.228.110]:20508 "EHLO
        smtprelay08.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233239AbhGARbl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jul 2021 13:31:41 -0400
Received: from [84.163.72.76] (helo=[192.168.2.202])
        by smtprelay08.ispgateway.de with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <git@mfriebe.de>)
        id 1lz0Ud-0007wx-FC; Thu, 01 Jul 2021 19:28:51 +0200
From:   Martin <git@mfriebe.de>
Subject: Re: PATCH: improve git switch documentation
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
References: <c593a699-eaf2-c7ab-b522-bfd224fce829@mfriebe.de>
 <xmqqk0mcy6g2.fsf@gitster.g>
 <b667ca37-b3cb-fce2-a298-63c3b839089d@mfriebe.de>
 <xmqqpmw4uwh2.fsf@gitster.g>
 <7870a0ad-8fa1-9dbd-1978-1f44ec6970c5@mfriebe.de>
 <xmqqy2arrmba.fsf@gitster.g>
 <b80bf908-0c31-2b3a-6d6c-1a3fba5b2334@mfriebe.de>
 <xmqqh7hersgp.fsf@gitster.g>
Message-ID: <167b8fe6-0586-b980-dfb9-9fa3a29d48bb@mfriebe.de>
Date:   Thu, 1 Jul 2021 19:29:06 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <xmqqh7hersgp.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
X-Df-Sender: bWVAbWZyaWViZS5kZQ==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 01/07/2021 16:58, Junio C Hamano wrote:
> If I understand you correctly, the confusion your hypothetical
> newbie would have is caused by the word "start-point" in
>
> 	git branch -f <branch-name> <start-point>
>
> That is, if we repoint the branch that is currently at Z to point at
> X with "git branch -f B X", it is possible to imagine that we build
> more history on top of "X" simply because "X" is called "start-point",
> i.e. we start at X and do something more.
It is probably more the use of the word "branch" than it is "start point"

Sergey made an excellent point:
> On 01/07/2021 13:27, Sergey Organov wrote:
>> For example:
>>
>> "branch": a chain of commits
>>
>> "branch tip": the most recent commit in a branch
>>
>> "branch name": specific type of symbolic reference pointing to a branch tip

A lot of people think of the "chain of commits" when the word "branch" 
is used.

If we take the sentence from the current doc:
    --force-create
     Similar to |--create| except that if |<new-branch>| already exists, 
it will be reset to |<start-point>|
and replace "branch" with "chain of commits"
     Similar to |--create| except that if |<new-||"chain of commits">| 
already exists, it will be reset to |<start-point>|

What would you expect to happen?
I would think the "chain of commits" is created at the new <start-point>

What we want to say is
     The "branch name" will point to a new "branch tip" at <start-point>

However, this still leaves the point, that new users need to understand 
certain concepts and implications.
Such as moving a "branch name" abandons the old "chain of commits" (they 
do not follow).
"branch name" helps to remember that distinction, but it still needs to 
be learned first.
"abandon" => leave them to the reflog until expiry.

The point is, that those concepts (difference between branchname, and 
commits in branch) may all be documented.
But the reader may still be learning all this.
Then it will certainly help new users to learn , if the consequences of 
those are mentioned in places like "switch -C".


> But I find two problems with the proposed solution to solve that
> confusion.
>   * In general, when an explanation in the documentation says that
>     a command does A, it shouldn't have to say "the command does A
>     but does not do B or C on top of that".
Ok, that make sense. In general "negative" statements are not helpful.



> I think the source of the confusion is the <start point>.  It does
> not change what the explanation wants to say at all if we changed
> it to <end point>.
I don't actually see <start point> as the issue. But if it was then <end 
point> would mean
that your existing "chain of commits" would end there (as if it was a 
merge).


>   It is where the branch's tip ends up to be after
> "git branch -f" (or "git switch -C") finishes, so it might even be
> technically more correct.
But it is also where new commits for that branch will start. (they start 
at the current end, but that is confusing...)
Thinking about the name <fork point> would be more meaningful?

IMHO, start is way better than end. But "fork" is good too.

While going through the patch, I just noted

"git branch" uses <branchname>
"git switch" uses <new-branch>

It would be (a tiny) improvement, if "git switch" also used <branchname>
1)  it does help to get away from  "chain of commits"
2)  in case of -C the "new" part is actually wrong.

Using <commit> instead of <start-point> is better too.
Not so much for the above reasons.
<start-point>  described the function. But it did not tell you that you 
need a <commit>
Now you know you need a <commit>, and then you can check the function 
from the doc.


>   ------------
> @@ -70,7 +70,7 @@ $ git switch <new-branch>
>   -C <new-branch>::
>   --force-create <new-branch>::
>   	Similar to `--create` except that if `<new-branch>` already
> -	exists, it will be reset to `<start-point>`. This is a
> +	exists, it will be reset to `<commit>`. This is a
>   	convenient shortcut for:
>   +
>   ------------

Now with <branchname> that would be

  --force-create <new-branch>::
  	Similar to `--create` except that if `<branchname>` already
	exists, it will be reset to [point to] `<commit>`. This is a
  	convenient shortcut for:

At least, there would no longer be a word, that can be read as "chain of 
commits"
So <branchname> would be a definite improvement too.

Not sure if  [point to]  should be inserted?


I would still think, users should be somehow reminded of the implicit 
consequences.
Users reading that part of the doc may still be in the progress of 
learning all the concepts.
If nothing else, then maybe
       The branch previously at [pointed to by] <branchname> will/may no 
longer be reachable.
That is, it is obviously no longer reachable by <branchname>. But it may 
not be reachable by anything else either (reflog excluded).

However, adding any such "reminder" may be part of a more general 
discussion how verbose the documentation should be.
I.e. as you wrote in an earlier email, why for "switch" but not for others.
The argument that "switch" is one of the more essential commands, may 
not be enough.

