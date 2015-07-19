From: Jacob Keller <jacob.keller@gmail.com>
Subject: Re: Git tag: pre-receive hook issue
Date: Sun, 19 Jul 2015 01:38:43 -0700
Message-ID: <CA+P7+xpevvV=5QdfBdzcD=8=2ff+m-kzxX-w1wLME8oRyn8QBA@mail.gmail.com>
References: <1437159533304-7635764.post@n2.nabble.com> <CA+P7+xoXgSHPVhMTm_GZbq+6Pps5yttK2rBZpMycTUFGfqOCvw@mail.gmail.com>
 <CAGDgvc2F7UMWTVrRFt5eK2xmbfz-kyWh6Vp-eQNEj7tixzRPYQ@mail.gmail.com>
 <CA+P7+xrbWt=n6hj4bTcdLRMPXa0K51gErNBD-omQy+g-So6TYw@mail.gmail.com> <CAGDgvc3O=q-k3ViiEds4iPMtDQTOSFMSJ4bUKRFyWzqwv7=J_Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Gaurav Chhabra <varuag.chhabra@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 19 10:41:10 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZGk9m-0005Hs-23
	for gcvg-git-2@plane.gmane.org; Sun, 19 Jul 2015 10:41:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751574AbbGSIjI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Jul 2015 04:39:08 -0400
Received: from mail-ig0-f181.google.com ([209.85.213.181]:37385 "EHLO
	mail-ig0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751317AbbGSIjE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 19 Jul 2015 04:39:04 -0400
Received: by igbpg9 with SMTP id pg9so63112027igb.0
        for <git@vger.kernel.org>; Sun, 19 Jul 2015 01:39:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=2YwGwHCjKJ5BCWJezbpIYyNLC422qDZG9dVjSXHga+o=;
        b=Al6CMJ7eooX1nHzCC9RuT/NjXbD8OL08Uj+13OAbeR2caN4iGay7I4Rvxny2E1ko+W
         vQrbIf/EtGLbvUzCG1pSsDvNof+HRvhhWZZmibh/uFPlC1YcXiTvzF61ATnXn1ifludK
         Xdl65/sMKzM76C7yAwlYo44CUtHAAqJLIls4L1rz9/obblNmCXtS3q6D8SRiPrFmf2nD
         VTYvrwYDXO4s+B12owJWvJSgXdKUUHb0WZmw1LxOKTur93+lc4VsLWUU6yhtnvXkaD5x
         b+AsqfxwlgkOt/gkJP/Dr+1UvCrEAfMPnjgMAWzJLYBvdy1Tmp1qFZSOUnkJelnI/4uu
         effg==
X-Received: by 10.50.33.82 with SMTP id p18mr6287318igi.8.1437295143008; Sun,
 19 Jul 2015 01:39:03 -0700 (PDT)
Received: by 10.107.157.75 with HTTP; Sun, 19 Jul 2015 01:38:43 -0700 (PDT)
In-Reply-To: <CAGDgvc3O=q-k3ViiEds4iPMtDQTOSFMSJ4bUKRFyWzqwv7=J_Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274205>

On Sun, Jul 19, 2015 at 12:55 AM, Gaurav Chhabra
<varuag.chhabra@gmail.com> wrote:
> @Junio: So from your detailed explanation (and Jake's comment), i
> understand that since my ref wasn't updated on remote so querying the
> same using "git describe" resulted in failure, and hence, code was not
> entering the IF block. Correct?
>

I assume so.

> Also, while i was reading your replies, i was just thinking that the
> following question that i asked Jake doesn't really make sense because
> a commit object _is_ being passed (on local machine) to "git
> describe", which is what it expects so it should work for sure:
>

It works yes. Git describe finds the nearest tag. --exact-match fails
unless it can find a tag at the commit specified.

> "If i got the above right, then shouldn't Git throw an error even on
> my local machine when i'm running "git describe --exact-match
> ac28ca721e67a"?"
>

only if ac28ca721e67a does not have an annotated tag associated to it



> @Junio: You wrote: "The part that I find questionable is that by
> checking with "is this commit a tagged one?" and doing different
> things. What makes the initial and the third special to deserve
> checking (because they are not annotated with a tag) while skipping
> the validation for the second (merely because it has an annotated tag
> added to it)?"
>> Isn't the code that i shared doing just the opposite of what you've written? It's checking for annotated tags only and skipping the lightweight ones (although it shouldn't be doing all such things in the first place). Was it a typo on your part?
>
>

I'm not sure what the code you have is trying to do. See below.

> @Jake: For the question you asked: "It would help a lot if we
> understood exactly what you are trying to accomplish."
>> I'm not sure how my colleague zeroed in on this "git describe" command but i at least know what we observed (and 'seemed' to work).  We saw that if we use git-describe and pass a commit object, it throws fatal error message. On the other hand, if we pass a tag object, it doesn't throw any fatal error. That's the reason he added that tag check portion.
>

Hmmm....

>
> @Junio/Jake: After going through all the responses that i've received
> so far on this forum, i'm thinking how this nonsense code worked for
> few cases in the past? When this check was put in place, devs were
> getting error while pushing annotated tags. Since we use Gitolite, we
> added the following to gitolite.conf and the tag push worked for them:
>
> RW+ refs/tags=developer_name
>

Sounds like you needed to add RW permissions to the refs/tags namespace.

> I'm wondering why.
>

Ok, so normally, pre-receive hook is used to implement policy. Ie:
prevent acceptance of pushes that have "bad" content as defined by the
repository owner. For example, preventing push of tags that don't
match some format, or preventing pushes which contain bad stuff.

I could provide some examples or suggestions if you would describe
what sort of policy you're trying to enforce..

git describe will tell you if the commit you're passing it is
associated with an annotated tag. I do not understand who this
information can help you implement any policy, so understanding what
the policy you want is would be the most helpful.

I can't really help more or understand exactly what you were doing
without understanding what policy you were/are trying to implement.

The thing your code is doing today is something like:

for each reference update, locate every commit

for each commit in this reference update, check to see if it already
has an associated tag connected to it.

If it doesn't have a tag, then "do some more checks" which are not
described here.

This doesn't make sense to me at all. I think what you *meant* was this:

for each reference update, if the reference being updated is a tag, skip it

otherwise, for each commit in the reference update do some checks on it.

That is *completely* different from the code you've written today.

Regards,
Jake
