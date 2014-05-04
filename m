From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: Pull is Mostly Evil
Date: Sun, 04 May 2014 05:17:33 -0500
Message-ID: <536613bd14e24_1c89b0930cac@nysa.notmuch>
References: <5363BB9F.40102@xiplink.com>
 <xmqqoazgaw0y.fsf@gitster.dls.corp.google.com>
 <5364A143.1060404@bbn.com>
 <5364b62d5fb7b_ac68dd30816@nysa.notmuch>
 <5365691C.1010208@bbn.com>
 <5365af33825c3_520db2b308bf@nysa.notmuch>
 <5365F10C.6020604@bbn.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Richard Hansen <rhansen@bbn.com>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Marc Branchaud <marcnarc@xiplink.com>
X-From: git-owner@vger.kernel.org Sun May 04 12:28:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wgteg-0008Jf-G5
	for gcvg-git-2@plane.gmane.org; Sun, 04 May 2014 12:28:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753374AbaEDK2Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 May 2014 06:28:16 -0400
Received: from mail-oa0-f45.google.com ([209.85.219.45]:40699 "EHLO
	mail-oa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753276AbaEDK2O (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 May 2014 06:28:14 -0400
Received: by mail-oa0-f45.google.com with SMTP id eb12so7232342oac.18
        for <git@vger.kernel.org>; Sun, 04 May 2014 03:28:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=cC0k1wK9GE3ZTvKpj1gOebhPUIHNmP941e/SpLxPOm4=;
        b=YXU7i1ZoCNunuCrnHZItACFOqcdBWzQVnKXSCTP1ZqmVyXkK/mbJlSPuHhqyEQS+7L
         X4MnnHKM6N4Sq0GVvLCYzVaja4P1VzskkZayt4sR5hKMG1MXaf/wun+jDigNNQEVgsDh
         oJwGIWvf0k743zqMfN7xeGlbV0PzszVaZfvVAEgNGUik+dmMb97ny+DPrddkF63qwaQj
         ZmObblLn8IIfRoD5F4AWh9ZKHM+IQB5ZlyYa0QxtwaWAj3r1kL/UPEUHLUeNXeHY9+Mb
         NG34molo8akgquZJs1mtcOR2jFEHGiZHHexSMX1acGmHik5Ps34l23+kM34R+COQj4Gs
         j81A==
X-Received: by 10.60.37.199 with SMTP id a7mr27021283oek.41.1399199294210;
        Sun, 04 May 2014 03:28:14 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id ci10sm22075736oec.0.2014.05.04.03.28.11
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 04 May 2014 03:28:13 -0700 (PDT)
In-Reply-To: <5365F10C.6020604@bbn.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248090>

Richard Hansen wrote:
> On 2014-05-03 23:08, Felipe Contreras wrote:
> > Richard Hansen wrote:
> >> Or are you proposing that pull --merge should reverse the parents if and
> >> only if the remote ref is @{u}?
> > 
> > Only if no remote or branch are specified `git pull --merge`.
> 
> OK.  Let me summarize to make sure I understand your full proposal:
> 
>   1. if plain 'git pull', default to --ff-only
>   2. if 'git pull --merge', default to --ff.  If the local branch can't
>      be fast-forwarded to the upstream branch, then create a merge
>      commit where the local branch is the *second* parent, not the first
>   3. if 'git pull $remote [$refspec]', default to --merge --ff.  If the
>      local branch can't be fast-forwarded to the remote branch, then
>      create a merge commit where the remote branch is the second parent
>      (the current behavior)
> 
> Is that accurate?

Yes, that is accurate. Note that 3. is the current behavior.

> >> If we change 'git pull' to default to --ff-only but let 'git pull
> >> $remote [$refspec]' continue to default to --ff then we have two
> >> different behaviors depending on how 'git pull' is invoked.  I'm worried
> >> that this would trip up users.  I'm not convinced that having two
> >> different behaviors would be bad, but I'm not convinced that it would be
> >> good either.
> > 
> > It is the only solution that has been proposed.
> 
> It's not the only proposal -- I proposed a few alternatives in my
> earlier email (though not in the form of code), and others have too.  In
> particular:
> 
>   * create a new 'git integrate' command/alias that behaves like 'git
>     pull --no-ff'

Yeah but that's for a different issue altogheter. I doesn't solve the
problems in 1. nor 2. nor 3.

>   * change 'git pull' and 'git pull $remote [$refspec]' to do --ff-only
>     by default
> 
> Another option that I just thought of:  Instead of your proposed
> pull.mode and branch.<name>.pullmode, add the following two sets of configs:
> 
>   * pull.updateMode, branch.<name>.pullUpdateMode:
> 
>     The default mode to use when running 'git pull' without naming a
>     remote repository or when the named remote branch is @{u}.  Valid
>     options: ff-only (default), merge-ff, merge-ff-there, merge-no-ff,
>     merge-no-ff-there, rebase, rebase-here, rebase-here-then-merge-no-ff

Those are way too many options to be able to sensibly explain them.

>   * pull.integrateMode, branch.<name>.pullIntegrateMode:
> 
>     The default mode to use when running 'git pull $remote [$refspec]'
>     when '$remote [$refspec]' is not @{u}.  Valid options are the same
>     as those for pull.updateMode.  Default is merge-ff.
> 
> This gives the default split behavior as you propose, but the user can
> reconfigure to suit personal preference (and we can easily change the
> default for one or the other if there's too much outcry).

If we reduce the number of options to begin with (more can be added
later), then it might make sense to have these two options.

However, that doesn't change the proposal you described above (1. 2.
3.).

> > Moreover, while it's a bit worrisome, it wouldn't create any actual
> > problems. Since `git pull $what` remains the same, there's no problems
> > there. The only change would be on `git pull`.
> > 
> > Since most users are not going to do `git pull $what` therefore it would
> > only be a small subset of users that would notice the discrepancy
> > between running with $what, or not. And the only discrepancy they could
> > notice is that when they run `git pull $what` they expect it to be
> > --ff-only, or when the run `git pull` they don't. Only the former could
> > be an issue, but even then, it's highly unlikely that `git pull $what`
> > would ever be a fast-forward.
> > 
> > So althought conceptually it doesn't look clean, in reality there
> > wouldn't be any problems.
> 
> Yes, it might not be a problem, but I'm still nervous.  I'd need more
> input (e.g., user survey, broad mailing list consensus, long beta test
> period, decree by a benevolent dictator) before I'd be comfortable with it.

The user surveys are not happening any more. The results were ignored by
the developers anyway.

Mailing list consensus might be possible, but that wouldn't tell us
much.

There's something we can do, and let me clarify my proposal. What you
described above is what I think should happen eventually, however, we
can start by doing something like what my patch series is doing; issue a
warning that the merge is not fast-forward and things might change in
the future.

If people find this behavior confusing they will complain in the mailing
list. Although I suspect it would be for other reasons, not the 'git
pull'/'git pull $there' division. Either way we would see in the
discussion.

> >>>>  3. integrate a more-or-less complete feature/fix back into the line
> >>>>     of development it forked off of
> >>>>
> >>>>     In this case the local branch is a primary line of development and
> >>>>     the remote branch contains the derivative work.  Think Linus
> >>>>     pulling in contributions.  Different situations will call for
> >>>>     different ways to handle this case, but most will probably want
> >>>>     some or all of:
> >>>>
> >>>>      * rebase the remote commits onto local HEAD
> >>>
> >>> No. Most people will merge the remote branch as it is. There's no reason
> >>> to rebase, specially if you are creating a merge commit.
> >>
> >> I disagree.  I prefer to rebase a topic branch before merging (no-ff) to
> >> the main line of development for a couple of reasons:
> > 
> > Well that is *your* preference. Most people would prefer to preserve the
> > history.
> 
> Probably.  My point is that the behavior should be configurable, and I'd
> like that particular behavior to be one of the options (but not the
> default -- that wouldn't be appropriate).

All right. But I'm a bit overwhelmed by all the things to keep in mind.
Does your proposed IntegradeMode/UpdateMode deal with this?

I will try to gather a bunch of discussions and create a new thread to
summrize what is probably the best, and Intage/Update mode is as far as
I'm willing to go into considering options.

> >>   * It makes commits easier to review.
> > 
> > The review in the vast majority of cases happens *before* the
> > integration.
> 
> True, although even when review happens before integration there is
> value in making code archeology easier.

I think I explained below why "code archeology" is better served by
preserving the history.

> > And the problem comes when the integrator makes a mistake, which they
> > inevitable do (we all do), then there's no history about how the
> > conflict was resolved, and what whas the original patch.
> 
> Good point, although if I was the integrator and there was a
> particularly hairy conflict I'd still rebase but ask the original
> contributor to review the results before merging (or ask the contributor
> to rebase).

Sure, asking the contributor to rebase is best. However, sending the
rebase results is not that useful; the contributor would like to see
what actually changed so an interdiff might be more than enough. But
then that's basically the same as reviewing the merge commit.

Anyway, I'll try to grab what I can from previous discussions (mainly
about switching the merge parents) and create a new thread with a
summary.

Cheers.

-- 
Felipe Contreras
