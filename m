From: Mike Botsko <botsko@gmail.com>
Subject: Re: Unexpected/unexplained difference between git pull --rebase and
 git rebase
Date: Tue, 3 Mar 2015 15:54:05 -0800
Message-ID: <CAPfvZp5VCd+Q2LHczqTQ08ZR+yvkGHhubRHgBSCznGQJgekadg@mail.gmail.com>
References: <CAPfvZp6oNnM=M-9BAVqAE052jQApH-O_t3gEoq6JWC2kQrR8gg@mail.gmail.com>
	<20150303210900.GP890@serenity.lan>
	<CAPfvZp5KmEwY_903aUJE0p7qKMUbABYpC3Y8JvPSc_Dmd0ppGA@mail.gmail.com>
	<20150303214653.GQ890@serenity.lan>
	<xmqq61ahad18.fsf@gitster.dls.corp.google.com>
	<CAPfvZp5jTTbWVL0QuZTP83=SWvsvyZWX0BG_q7jPLK5wNNvCgg@mail.gmail.com>
	<20150303234057.GR890@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Wed Mar 04 00:54:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YSwdg-0007n1-Bg
	for gcvg-git-2@plane.gmane.org; Wed, 04 Mar 2015 00:54:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756984AbbCCXyH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Mar 2015 18:54:07 -0500
Received: from mail-ig0-f181.google.com ([209.85.213.181]:37485 "EHLO
	mail-ig0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756817AbbCCXyG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Mar 2015 18:54:06 -0500
Received: by igbhn18 with SMTP id hn18so32589701igb.2
        for <git@vger.kernel.org>; Tue, 03 Mar 2015 15:54:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=dfuciai72i2hshyGzoob5tgwHq+aFbGsXxtdIDBMlCI=;
        b=bMnrhK0hrsPh8sz98PHEhiBmf64Sh8Do3APNr8y39LXxVmbOWn6uQhHQFycFPd56WQ
         s1fwr86DrIHAP3TlpW/mnjhl6j4xzpHLcWA6fkxEXLi2ZUFHo/S1ttu0kh2KQhL3/q0N
         9ubBk9zApcUOGO88UV4cybjG+hR6nFPpSzcouXlIM6SXx68QTRkNUvxp7hN8/GGcTHxM
         GxOqqLC1ytG0irf0k4eNcZ7HztFdy7I4hlHPOBa+avnyC2IM1TbuzYBoN6ZmC7gfiEOk
         Qb6tlIgIqQ9ae8zsGm12XM+xMAer1Y2i1BQSnXcyW7MM7u98t6QRPaKhCH28PnX92A6n
         ZsLg==
X-Received: by 10.50.131.196 with SMTP id oo4mr6329663igb.2.1425426845260;
 Tue, 03 Mar 2015 15:54:05 -0800 (PST)
Received: by 10.107.169.94 with HTTP; Tue, 3 Mar 2015 15:54:05 -0800 (PST)
In-Reply-To: <20150303234057.GR890@serenity.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264711>

Thanks, that clarifies a lot.

I only have two follow-up questions:

In your branch example, how does git determine that C/D have been
rewritten and need to be "replaced" with their current versions
existing upstream? In this scenario I've encountered, the commit hash
and the patch ID of those commits changed because the contents of the
patches had to be modified slightly due to merge conflicts which
occurred when the upstream branch was rebased.

Also, you mentioned "not building off of upstream branches which might
be rewritten". We generally try to avoid this but I don't see any
alternative with the way we do things.

upstream/master <- An always-clean copy of what's fully approved and live
upstreamfeature-A
upstreamfeature-B, etc <- Feature branches designed to organized
long-term new feature work

Individual developers will then create local development branches
based on those feature branches. If three people are responsible for
tasks for feature-A, they'll create development branches for each
task, do their work, and(via github enterprise) submit a pull request
so we can properly review their work, test it, etc.

The problem I have today stems from situations where a feature branch
has been merged with master. If feature-B is merged with master, and
someone rebases feature-A, there may be merge conflicts. If they fix
the conflicts, that may alter the commit history of the feature
branch, which then impacts all branches developers have based on it.

Part of me feels like we should be able to never rebase feature
branches, they should exist outside of new work merged to master.
However, it's much easier to resolve merge conflicts in small doses,
and we're in a much better position to know that we're fully updated
and can catch other problems early.

Is there a better way to do this, so that we never risk rewriting the
"middle tier"?



On Tue, Mar 3, 2015 at 3:40 PM, John Keeping <john@keeping.me.uk> wrote:
> On Tue, Mar 03, 2015 at 03:20:48PM -0800, Mike Botsko wrote:
>> Maybe I'm lacking the distinction regarding what I'm being specific about.
>>
>> In both examples, I'm asking it specifically to rebase in changes from
>> the remote "upstream" and a named branch at that location. I'm giving
>> git the same information, it's just interpreting it differently - and
>> I'm not understanding why.
>
> Not quite.  If you say:
>
>         git rebase $sha1
>
> then you're telling git-rebase to apply the commits $sha1..HEAD onto
> $sha1.
>
> If you say:
>
>         git rebase
>
> then it will be re-written as:
>
>         git rebase --fork-point @{upstream}
>
> in which case Git will apply more complicated logic so that you can
> recover from the case where @{upstream} has been re-written.
>
> Consider the following scenario:
>
>                       F                 branch
>                      /
>                C -- D                   master@{1}
>               /
>         A -- B -- C' -- D' -- E         master
>
> where C' and D' are rewritten versions of C and D.
>
> In this case, imagine you are at F on "branch", "git rebase master" will
> replace C, D and F onto E because you have explicitly selected to replay
> master..branch onto master.
>
> "git rebase" will apply the fork-point logic and realise that D is a
> previous version of master, so it will only replay F onto E.
>
> In general if you just want to rebase onto your upstream it is simpler
> to just call "git rebase" which will do the right thing; it's also
> shorter to type ;-)
>
>> My local branch would have been created from the
>> upstream/feature-branch, and will eventually be merged back into it.
>> Until I'm ready for that, I regularly rebase the work done on
>> upstream/feature-branch so that my local work is always clean and
>> above anything else.
>
> In this case the problem stems from the fact that
> upstream/feature-branch has been rewritten.  Building on top of branches
> that will be rewritten is not advisable unless you have a really good
> reason to do so.
>
>> On Tue, Mar 3, 2015 at 3:15 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> > John Keeping <john@keeping.me.uk> writes:
>> >
>> >> git-rebase assumes that if you give an explicit upstream then you want
>> >> precisely what you asked for.  From git-rebase(1):
>> >>
>> >>       If either <upstream> or --root is given on the command line,
>> >>       then the default is `--no-fork-point`, otherwise the default is
>> >>       `--fork-point`.
>> >
>> > Correct.
>> >
>> > You ask it to rebase the history without guessing by being explicit;
>> > the command guesses when you are not explicit and being lazy ;-).



-- 
Mike Botsko
Lead Dev @ Helion3
Ph: 1-(503)-897-0155
