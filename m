From: Gaurav Chhabra <varuag.chhabra@gmail.com>
Subject: Re: Git tag: pre-receive hook issue
Date: Sun, 19 Jul 2015 15:43:54 +0530
Message-ID: <CAGDgvc1CwmQV75mo22v5LQH4q-kNMFtVq3Y9eSt9LL44JHr5Og@mail.gmail.com>
References: <1437159533304-7635764.post@n2.nabble.com>
	<CA+P7+xoXgSHPVhMTm_GZbq+6Pps5yttK2rBZpMycTUFGfqOCvw@mail.gmail.com>
	<CAGDgvc2F7UMWTVrRFt5eK2xmbfz-kyWh6Vp-eQNEj7tixzRPYQ@mail.gmail.com>
	<CA+P7+xrbWt=n6hj4bTcdLRMPXa0K51gErNBD-omQy+g-So6TYw@mail.gmail.com>
	<CAGDgvc3O=q-k3ViiEds4iPMtDQTOSFMSJ4bUKRFyWzqwv7=J_Q@mail.gmail.com>
	<CA+P7+xpevvV=5QdfBdzcD=8=2ff+m-kzxX-w1wLME8oRyn8QBA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jul 19 12:18:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZGlfz-0003sL-MU
	for gcvg-git-2@plane.gmane.org; Sun, 19 Jul 2015 12:18:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753059AbbGSKN5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Jul 2015 06:13:57 -0400
Received: from mail-wi0-f172.google.com ([209.85.212.172]:37723 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752773AbbGSKN4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Jul 2015 06:13:56 -0400
Received: by wibud3 with SMTP id ud3so73721961wib.0
        for <git@vger.kernel.org>; Sun, 19 Jul 2015 03:13:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type;
        bh=2cXVaL2H+rUxuQ6WRsP/pf1sRbaHk+HrLM4SvqQh3hY=;
        b=bvR4wijdZqIUnqk1Aprc7+IAmGo/7euNu4B/CPji60SznmhuxQKyC5+bSRkDJDgcU5
         EpDn+Hv3gc8BrxWpbXhfjcJXOvu6JES/RB4I82aoCE9pnvAgzK+Y0vlp8qxtKxi4gIqX
         TLF6QOfws+q5mlaP3V1rDQsBtHq+RTLIVdrOa0+luz9bzS7Xl4D66KjR/ISmDpJa/aT0
         0QFOsG69V/tbMCMZdeWRTs3HrNF0z68NCKl7p1jHI/S3qZ1O2fcLMJEnQoViFzLLQDu8
         SzPw4UapeGhDJ2+FQ9l3G5af5uLl9JxxJDWYScUyeBCrTVoFAgY1ssIJzjDZU10iE9U1
         PtNA==
X-Received: by 10.180.198.44 with SMTP id iz12mr11650831wic.62.1437300835060;
 Sun, 19 Jul 2015 03:13:55 -0700 (PDT)
Received: by 10.28.143.1 with HTTP; Sun, 19 Jul 2015 03:13:54 -0700 (PDT)
In-Reply-To: <CA+P7+xpevvV=5QdfBdzcD=8=2ff+m-kzxX-w1wLME8oRyn8QBA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274207>

The only thing we wanted to check was whether a ref is a tag. :) Rest
other things are working fine (except for the "commits=$new_sha1"
thing which Junio already pointed out and corrected). I will correct
the pre-receive hook.

The only mystery that remains is about the current nonsensical code
working fine in the past for few annotated tag pushes. It shouldn't
have worked just by providing:

RW+ refs/tags=developer_name

Ref: http://gitolite.com/gitolite/g2/aac.html (Section: "deny" rules
for refs in a repo)


On Sun, Jul 19, 2015 at 2:09 PM, Jacob Keller [via git]
<ml-node+s661346n7635875h48@n2.nabble.com> wrote:
> On Sun, Jul 19, 2015 at 12:55 AM, Gaurav Chhabra
> <[hidden email]> wrote:
>> @Junio: So from your detailed explanation (and Jake's comment), i
>> understand that since my ref wasn't updated on remote so querying the
>> same using "git describe" resulted in failure, and hence, code was not
>> entering the IF block. Correct?
>>
>
> I assume so.
>
>> Also, while i was reading your replies, i was just thinking that the
>> following question that i asked Jake doesn't really make sense because
>> a commit object _is_ being passed (on local machine) to "git
>> describe", which is what it expects so it should work for sure:
>>
>
> It works yes. Git describe finds the nearest tag. --exact-match fails
> unless it can find a tag at the commit specified.
>
>> "If i got the above right, then shouldn't Git throw an error even on
>> my local machine when i'm running "git describe --exact-match
>> ac28ca721e67a"?"
>>
>
> only if ac28ca721e67a does not have an annotated tag associated to it
>
>
>
>> @Junio: You wrote: "The part that I find questionable is that by
>> checking with "is this commit a tagged one?" and doing different
>> things. What makes the initial and the third special to deserve
>> checking (because they are not annotated with a tag) while skipping
>> the validation for the second (merely because it has an annotated tag
>> added to it)?"
>>> Isn't the code that i shared doing just the opposite of what you've
>>> written? It's checking for annotated tags only and skipping the lightweight
>>> ones (although it shouldn't be doing all such things in the first place).
>>> Was it a typo on your part?
>>
>>
>
> I'm not sure what the code you have is trying to do. See below.
>
>> @Jake: For the question you asked: "It would help a lot if we
>> understood exactly what you are trying to accomplish."
>>> I'm not sure how my colleague zeroed in on this "git describe" command
>>> but i at least know what we observed (and 'seemed' to work).  We saw that if
>>> we use git-describe and pass a commit object, it throws fatal error message.
>>> On the other hand, if we pass a tag object, it doesn't throw any fatal
>>> error. That's the reason he added that tag check portion.
>>
>
> Hmmm....
>
>>
>> @Junio/Jake: After going through all the responses that i've received
>> so far on this forum, i'm thinking how this nonsense code worked for
>> few cases in the past? When this check was put in place, devs were
>> getting error while pushing annotated tags. Since we use Gitolite, we
>> added the following to gitolite.conf and the tag push worked for them:
>>
>> RW+ refs/tags=developer_name
>>
>
> Sounds like you needed to add RW permissions to the refs/tags namespace.
>
>> I'm wondering why.
>>
>
> Ok, so normally, pre-receive hook is used to implement policy. Ie:
> prevent acceptance of pushes that have "bad" content as defined by the
> repository owner. For example, preventing push of tags that don't
> match some format, or preventing pushes which contain bad stuff.
>
> I could provide some examples or suggestions if you would describe
> what sort of policy you're trying to enforce..
>
> git describe will tell you if the commit you're passing it is
> associated with an annotated tag. I do not understand who this
> information can help you implement any policy, so understanding what
> the policy you want is would be the most helpful.
>
> I can't really help more or understand exactly what you were doing
> without understanding what policy you were/are trying to implement.
>
> The thing your code is doing today is something like:
>
> for each reference update, locate every commit
>
> for each commit in this reference update, check to see if it already
> has an associated tag connected to it.
>
> If it doesn't have a tag, then "do some more checks" which are not
> described here.
>
> This doesn't make sense to me at all. I think what you *meant* was this:
>
> for each reference update, if the reference being updated is a tag, skip it
>
> otherwise, for each commit in the reference update do some checks on it.
>
> That is *completely* different from the code you've written today.
>
> Regards,
> Jake
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to [hidden email]
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
> ________________________________
> If you reply to this email, your message will be added to the discussion
> below:
> http://git.661346.n2.nabble.com/Git-tag-pre-receive-hook-issue-tp7635764p7635875.html
> To unsubscribe from Git tag: pre-receive hook issue, click here.
> NAML
