From: Jacob Keller <jacob.keller@gmail.com>
Subject: Re: Git tag: pre-receive hook issue
Date: Sun, 19 Jul 2015 16:35:24 -0700
Message-ID: <CA+P7+xqXxYtJiJ4xdYya25NgqrxncWP3rpVMLYBWTbnnA_oynQ@mail.gmail.com>
References: <1437159533304-7635764.post@n2.nabble.com> <CA+P7+xoXgSHPVhMTm_GZbq+6Pps5yttK2rBZpMycTUFGfqOCvw@mail.gmail.com>
 <CAGDgvc2F7UMWTVrRFt5eK2xmbfz-kyWh6Vp-eQNEj7tixzRPYQ@mail.gmail.com>
 <CA+P7+xrbWt=n6hj4bTcdLRMPXa0K51gErNBD-omQy+g-So6TYw@mail.gmail.com>
 <CAGDgvc3O=q-k3ViiEds4iPMtDQTOSFMSJ4bUKRFyWzqwv7=J_Q@mail.gmail.com>
 <CA+P7+xpevvV=5QdfBdzcD=8=2ff+m-kzxX-w1wLME8oRyn8QBA@mail.gmail.com> <CAGDgvc1CwmQV75mo22v5LQH4q-kNMFtVq3Y9eSt9LL44JHr5Og@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Gaurav Chhabra <varuag.chhabra@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 20 01:35:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZGy7g-0005Bi-V8
	for gcvg-git-2@plane.gmane.org; Mon, 20 Jul 2015 01:35:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754101AbbGSXfp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Jul 2015 19:35:45 -0400
Received: from mail-ig0-f182.google.com ([209.85.213.182]:36710 "EHLO
	mail-ig0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753985AbbGSXfo (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Jul 2015 19:35:44 -0400
Received: by igbij6 with SMTP id ij6so71187878igb.1
        for <git@vger.kernel.org>; Sun, 19 Jul 2015 16:35:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=ZQn2dRYH7DlkSK3DxndOailqEQ2YFWj+j9CaoKiq09k=;
        b=ucUHmBflmiafIMB+ajwFmPNP53T3acDK86fOYfyi7a0Lf+NGBxVPOUrNHCaObwqzah
         BeuEwfnWTdkBOgu/mEMkwjErkRG2D3iO8Llf8f+IwHQgBoKq5PjOznLKIQBT1PPfMBgA
         5UZi8tmvDyaZUAvAvD5AECzYI5e12/lODgt5oSM32DqRaI21vdxWIormQJdG2yppvd2O
         EAztcNSXTAwANk3/grhQpPm8KDJ45QmJZMFd55ntzqfHi7QsWBTC7OcH9scMLedDE2wU
         X6yRQUnpqlVm4JDfQJ9OunLa6Xt1lFmm9Jah0xbCW21TUE7YxMdeVlZB6H0zMqCngqz1
         rNbw==
X-Received: by 10.107.14.65 with SMTP id 62mr30660543ioo.67.1437348943537;
 Sun, 19 Jul 2015 16:35:43 -0700 (PDT)
Received: by 10.107.157.75 with HTTP; Sun, 19 Jul 2015 16:35:24 -0700 (PDT)
In-Reply-To: <CAGDgvc1CwmQV75mo22v5LQH4q-kNMFtVq3Y9eSt9LL44JHr5Og@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274298>

To check whether the ref being updated is a tag, you need to check the
3rd parameter. pre-receive receives in the format

<old-value> <new-value> <ref-name>

so you need to check each line's 3rd value which is the ref-name being
updated. If it's in refs/tags then it's a tag update. If it's not, you
can check it as a branch update.

Then you should check all new commits for each branch, as Julio mentioned above.

Checking whether each commit has an associated tag is probably not
what you meant.

Regards,
Jake

On Sun, Jul 19, 2015 at 3:13 AM, Gaurav Chhabra
<varuag.chhabra@gmail.com> wrote:
> The only thing we wanted to check was whether a ref is a tag. :) Rest
> other things are working fine (except for the "commits=$new_sha1"
> thing which Junio already pointed out and corrected). I will correct
> the pre-receive hook.
>
> The only mystery that remains is about the current nonsensical code
> working fine in the past for few annotated tag pushes. It shouldn't
> have worked just by providing:
>
> RW+ refs/tags=developer_name
>
> Ref: http://gitolite.com/gitolite/g2/aac.html (Section: "deny" rules
> for refs in a repo)
>
>
> On Sun, Jul 19, 2015 at 2:09 PM, Jacob Keller [via git]
> <ml-node+s661346n7635875h48@n2.nabble.com> wrote:
>> On Sun, Jul 19, 2015 at 12:55 AM, Gaurav Chhabra
>> <[hidden email]> wrote:
>>> @Junio: So from your detailed explanation (and Jake's comment), i
>>> understand that since my ref wasn't updated on remote so querying the
>>> same using "git describe" resulted in failure, and hence, code was not
>>> entering the IF block. Correct?
>>>
>>
>> I assume so.
>>
>>> Also, while i was reading your replies, i was just thinking that the
>>> following question that i asked Jake doesn't really make sense because
>>> a commit object _is_ being passed (on local machine) to "git
>>> describe", which is what it expects so it should work for sure:
>>>
>>
>> It works yes. Git describe finds the nearest tag. --exact-match fails
>> unless it can find a tag at the commit specified.
>>
>>> "If i got the above right, then shouldn't Git throw an error even on
>>> my local machine when i'm running "git describe --exact-match
>>> ac28ca721e67a"?"
>>>
>>
>> only if ac28ca721e67a does not have an annotated tag associated to it
>>
>>
>>
>>> @Junio: You wrote: "The part that I find questionable is that by
>>> checking with "is this commit a tagged one?" and doing different
>>> things. What makes the initial and the third special to deserve
>>> checking (because they are not annotated with a tag) while skipping
>>> the validation for the second (merely because it has an annotated tag
>>> added to it)?"
>>>> Isn't the code that i shared doing just the opposite of what you've
>>>> written? It's checking for annotated tags only and skipping the lightweight
>>>> ones (although it shouldn't be doing all such things in the first place).
>>>> Was it a typo on your part?
>>>
>>>
>>
>> I'm not sure what the code you have is trying to do. See below.
>>
>>> @Jake: For the question you asked: "It would help a lot if we
>>> understood exactly what you are trying to accomplish."
>>>> I'm not sure how my colleague zeroed in on this "git describe" command
>>>> but i at least know what we observed (and 'seemed' to work).  We saw that if
>>>> we use git-describe and pass a commit object, it throws fatal error message.
>>>> On the other hand, if we pass a tag object, it doesn't throw any fatal
>>>> error. That's the reason he added that tag check portion.
>>>
>>
>> Hmmm....
>>
>>>
>>> @Junio/Jake: After going through all the responses that i've received
>>> so far on this forum, i'm thinking how this nonsense code worked for
>>> few cases in the past? When this check was put in place, devs were
>>> getting error while pushing annotated tags. Since we use Gitolite, we
>>> added the following to gitolite.conf and the tag push worked for them:
>>>
>>> RW+ refs/tags=developer_name
>>>
>>
>> Sounds like you needed to add RW permissions to the refs/tags namespace.
>>
>>> I'm wondering why.
>>>
>>
>> Ok, so normally, pre-receive hook is used to implement policy. Ie:
>> prevent acceptance of pushes that have "bad" content as defined by the
>> repository owner. For example, preventing push of tags that don't
>> match some format, or preventing pushes which contain bad stuff.
>>
>> I could provide some examples or suggestions if you would describe
>> what sort of policy you're trying to enforce..
>>
>> git describe will tell you if the commit you're passing it is
>> associated with an annotated tag. I do not understand who this
>> information can help you implement any policy, so understanding what
>> the policy you want is would be the most helpful.
>>
>> I can't really help more or understand exactly what you were doing
>> without understanding what policy you were/are trying to implement.
>>
>> The thing your code is doing today is something like:
>>
>> for each reference update, locate every commit
>>
>> for each commit in this reference update, check to see if it already
>> has an associated tag connected to it.
>>
>> If it doesn't have a tag, then "do some more checks" which are not
>> described here.
>>
>> This doesn't make sense to me at all. I think what you *meant* was this:
>>
>> for each reference update, if the reference being updated is a tag, skip it
>>
>> otherwise, for each commit in the reference update do some checks on it.
>>
>> That is *completely* different from the code you've written today.
>>
>> Regards,
>> Jake
>> --
>> To unsubscribe from this list: send the line "unsubscribe git" in
>> the body of a message to [hidden email]
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>>
>> ________________________________
>> If you reply to this email, your message will be added to the discussion
>> below:
>> http://git.661346.n2.nabble.com/Git-tag-pre-receive-hook-issue-tp7635764p7635875.html
>> To unsubscribe from Git tag: pre-receive hook issue, click here.
>> NAML
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
