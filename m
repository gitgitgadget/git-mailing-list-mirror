From: Jacob Keller <jacob.keller@gmail.com>
Subject: Re: Git's inconsistent command line options
Date: Tue, 25 Aug 2015 21:09:41 -0700
Message-ID: <CA+P7+xoQnq-nCP=_Wtfh39fxxwTvEo+m-=o7fcmrdyaBBfbt8A@mail.gmail.com>
References: <mrh7ck$r0g$1@ger.gmane.org> <CAPc5daUdVQSAhrig046qGopVuxCDagZg3v9bwXOaC3SvC2MRnw@mail.gmail.com>
 <CA+P7+xrYugueYYrrJV0pduAHCg7CLknE_0QYcU8mO6idntz=VA@mail.gmail.com>
 <CAGZ79kZ6KK0qVtzrxmmsBQqmz-dgamC4f6W0zVTQLcuYi==0fw@mail.gmail.com> <xmqqa8tfvsr9.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Stefan Beller <sbeller@google.com>,
	Graeme Geldenhuys <graemeg@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 26 06:10:11 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZUS2N-0002JV-0M
	for gcvg-git-2@plane.gmane.org; Wed, 26 Aug 2015 06:10:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751816AbbHZEKD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Aug 2015 00:10:03 -0400
Received: from mail-io0-f172.google.com ([209.85.223.172]:33636 "EHLO
	mail-io0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750979AbbHZEKB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Aug 2015 00:10:01 -0400
Received: by iods203 with SMTP id s203so4961018iod.0
        for <git@vger.kernel.org>; Tue, 25 Aug 2015 21:10:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=uX8J3alQhBcrgV2dnKz8iVlNZACHpXnvS17aKABWdro=;
        b=AZ/NRIfiiXG4gXFyLh3NNm/bnzcglFLpP8SVwlzux7mGEF7YNBeHQiNgG4pntpwNjw
         MwIrjEfk8LbopRjC/uif4aVi45RP6QfUhxtxn3CjD2DaEmJAhtIjVK9EPvy8t0DzHFB3
         EFQ0J2PGuh05hKXpeXniJGxjxi5dg8WSq+Wr9NT26IPMKLZmiCrkl5s2Jl48pjbw3b+a
         +wPhRXZI45A9HbE4wubHiFJAJP+yLgSUrOzDWliN2W6la4y4B617fOIm47imko6STBOx
         GcJt95B26t0fXxqr2+iEeVUdrQ8Afrbqmv+RJiMZ/VfV14EGQD0R1vF1KuPHVQogn81K
         FggA==
X-Received: by 10.107.133.137 with SMTP id p9mr826788ioi.146.1440562200804;
 Tue, 25 Aug 2015 21:10:00 -0700 (PDT)
Received: by 10.107.5.203 with HTTP; Tue, 25 Aug 2015 21:09:41 -0700 (PDT)
In-Reply-To: <xmqqa8tfvsr9.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276594>

On Tue, Aug 25, 2015 at 4:43 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>>  $ git tag --delete master
>>  $ echo $?
>>  # 0 # actually works as of today!
>>
>>  $ git tag delete master
>>  #  Due to the planned switch to command words, this doesn't work.
>>  #  For details see road map at  `man git commandwords-roadmaps`
>>  $ echo $?
>>  # 128 maybe ?
>
> This is way too aggressive behaviour and is unacceptable as the
> first step.  The first step of a transition that breaks backward
> compatibility should warn loudly about a command line that would
> behave differently in the endgame version (either the command line
> that will not do anything or do a totally different thing), but
> still perform the operation asked for the current version.
>


>     e.g. "git tag delete master" would create a tag named 'delete'
>     out of 'master', but tell the user that this will instead delete
>     'master' in future versions of Git.  "git tag create master"
>     would create a tag named 'create' out of 'master', but tell the
>     user that this will instead create 'master' out of HEAD in
>     future versions of Git.
>
>     e.g. "git tag -d foo" would delete a tag named 'foo', but tell
>     the user that this will have to be spelled 'git tag delete foo'
>     in the future versions of Git.
>
> One thing that I am not enthused about the transition plan is that
> "git tag delete master" will *never* be an invalid operation during
> the transition.  When making an operation that used to mean one
> thing to mean something else, a good transition plan should be to
>
>  * First warn but do the old thing, and tell users a new way to do
>    that in the new world order.  At the same time, find the new way
>    that used to be an invalid operation in the old world order, and
>    implement it.
>
>  * Then stop supporting the old thing and support only the new
>    thing.
>
> Then during the transition period, while transitioning to the new
> way, people can gradually start using the new way with the new
> system, and when they occasionally have to interact with an old
> system, the new way will _error out_, because we make sure we find
> the new way that "used to be an invalid operation" when planning the
> whole transition plan, without causing any harm.  And once people
> retrain their finger after 2-3 years, nobody will be hurt if we
> dropped the old way.
>
> I do not see a good way to do such a safe transition with command
> words approach, *unless* we are going to introduce new commands,
> i.e. "git list-tag", "git create-tag", etc.
>
> So don't hold your breath.  What you two are discussing is way too
> uncooked for 2.6 timeframe.
>
>
>

Ya, there isn't really a way to make it work, because we can't exactly
stop supporting "git tag create master" by turning it into a no-op,
because there is no equivalent tag option that would work for now.
Since there is no alternative syntax for "create" I think this is the
issue. One way might be to use the -- splitter to say,

"if you really mean to create a tag named create, use

git tag -- create master

So we'd do:

- step 1 -
git tag create master
# warn that this will change behavior in the future and they must
explicitely pass -- before it

- step 2 -
break create, but don't add anything new. If user really needs it,
they can pass "git tag -- create master" as per above warning, but
keep warning on "git tag create master" to say they must be explicit.

- step 3 -

implement git tag create master to actually perform tag creation

I think this might work, as long as "git tag -- create master" is acceptable?

then, eventually we can make it so that "git tag" doesn't mean create
by default if we ever wanted?

How does this sound? By the way, this wouldn't be necessarily done
over 2.6 or even over only a single release, I think the time frame
would have to be fairly long.

The downside is that there is no point where new and old syntax are
usable at the same time... but I don't think that will ever be the
case. We'd need to way the concern of whether this is actually worth
doing to streamline the overall feel at some point in the future or we
just live with the warts.

Regards,
Jake
