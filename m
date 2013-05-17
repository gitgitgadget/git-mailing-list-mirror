From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [RFC] New kind of upstream branch: base branch
Date: Fri, 17 May 2013 15:15:02 -0500
Message-ID: <CAMP44s14CtWS=cGsF=ZqYPrCmSPjjc-8XQFZ7gD==Dg8sESRfQ@mail.gmail.com>
References: <CAMP44s3LQ0GN4rrXdpb8Fe0iLeAEm2VjkH6BHK64pmX-xpc7+Q@mail.gmail.com>
	<51968311.1020107@bracey.fi>
	<7va9ntxu3w.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Kevin Bracey <kevin@bracey.fi>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 17 22:15:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UdR3Y-0006Cq-To
	for gcvg-git-2@plane.gmane.org; Fri, 17 May 2013 22:15:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754435Ab3EQUPG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 May 2013 16:15:06 -0400
Received: from mail-la0-f45.google.com ([209.85.215.45]:36876 "EHLO
	mail-la0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754126Ab3EQUPE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 May 2013 16:15:04 -0400
Received: by mail-la0-f45.google.com with SMTP id ec20so4418832lab.32
        for <git@vger.kernel.org>; Fri, 17 May 2013 13:15:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=7MtKqo9Fj5MinY+fejkQ5qolNhK5SIork17pmoKzg4w=;
        b=LEwDOnSgS+xSyJ1zu+X4oF+GzcC++RHuy9UhtVNhURd72Q1pxnnfKa097MIBT+BAed
         cOvlCxv1Z15eaPxv5hF2xFMaKJ8aZMSnMkDBL4clF3/qreZGzDa6VieMEJqyg/h2melZ
         17iLSm12s/ZG/E+Sy64sVFM/tSnuTVBR8q9vgbRjZfMJfWI0/1bddxdR2YKJtA2qnzi+
         SrEjmzuiuctFLEUgoA8yhhC3PYPauROUKGGJQhre4hviB6YpyG/W4MyjLV2VN17SeNdq
         zLTKIFG2QHYXhw6jeYDeMBiY5gsx7qJAApB9UFk4tv1VJ4z67tKOGrbz3kZtFM+U73jp
         e9MQ==
X-Received: by 10.112.145.72 with SMTP id ss8mr23394553lbb.12.1368821702264;
 Fri, 17 May 2013 13:15:02 -0700 (PDT)
Received: by 10.114.184.3 with HTTP; Fri, 17 May 2013 13:15:02 -0700 (PDT)
In-Reply-To: <7va9ntxu3w.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224735>

On Fri, May 17, 2013 at 2:51 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Kevin Bracey <kevin@bracey.fi> writes:
>
>> On 15/05/2013 23:34, Felipe Contreras wrote:
>>>   I think I'm using 'upstream' for something it was not intended to,
>>> and
>>> I think the current 'upstream' behavior should be split into
>>> 'upstream' and 'base'.
>>>
>> I found myself thinking the same thing. It's really convenient being
>> able to set your topic branch's upstream to another local branch, so
>
> What is that "another local branch"?

refs/heads/*

> Is the use case "master forks from origin/master and has its own
> changes on top, and then topic builds on my master but the range of
> commits origin/master..topic includes both changes, that is
> inconvenient to when rebuilding topic on top of my master"?

No it's not. You just 'git rebase -i' and everything works.

> I'd assume that it is the case, and the answer to the previous
> question is 'master' in the example.
>
>> git rebase works without parameters. But then I can't use upstream to
>> point to a remote version of that topic branch. I want my topic branch
>> to know both that it's based on master (or origin/master), and that
>> it's upstream is origin/topic.
>
> If we do s/and that it's upstream is/and that it is pushed to/, then
> I think I am in general agreement (I wrote about it earlier in a
> separate message).
>
>> So, yes, here's a vote in favour of the general concept.
>
> Yes, you should be able to treat what you build on top (upstream)
> and where you publish the result (we are still looking for a better
> name in the other thread) as two distinct things in a triangular
> workflow.  I agree that it is an issue we need to address.
>
> We have solved a half ("push goes to a different repository") but
> not the other half ("updates a branch whose name is different from
> the upstream") in the upcoming 1.8.3 release.
>
> The latest round of design from Felipe calls it branch.$name.push,
> if I am not mistaken.
>
> I think it is somewhat an overkill, though.

It is needed.

> It is normal for upstream's name not to match the topic's name
> (i.e. your 'topic' may branch off of a generic 'master', but would
> be named after a more specific purpose of the branch and is unlikely
> to be named 'master'.  In other words, branch.$name.merge that
> points at an upstream that has a name that is totally different from
> $name is not an exception.  So branch.$name.merge that you have to
> set for each branch is a necessity.
>
> However, if you were to push out 'topic' directly (as opposed to
> pushing out a result of integrating it and other topic branches to
> your 'master') to your own publishing point, it is likely you would
> push it out to the same name (i.e. 'topic' will be pushed out as
> 'topic', not as 'master').

Likely, but not certain.

> And if that is your workflow, setting
> push.default to "current" (and setting remote.pushdefault to your
> publishing repository) should be a sufficient interim solution, and
> you do not need to set branch.$name.push to each and every branch
> you intend to push out, I think.

If git needs configurations to behave sanely, git is broken.

If we set:
branch.autosetupmerge = always
push.default = simple

By default in v2.0, and there's a UI to set remote.pushdefault, then I
might be inclined to agree that branch.$name.push is overkill.

But I don't see that happening; the user still needs a sane way to
make trivial workflows work without hacking the configuration.

-- 
Felipe Contreras
