From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [RFC/PATCH 0/7] Rework git core for native submodules
Date: Mon, 8 Apr 2013 02:19:10 +0530
Message-ID: <CALkWK0mNQesytoDwaVHb1cdY+EC=33WRCefpE03hwp_9za1Vbw@mail.gmail.com>
References: <7v61zz9fu3.fsf@alter.siamese.dyndns.org> <CALkWK0n64BW8zQXweR38T6DjT+iYBbsZDPCLZ-4igqGJHoFwKw@mail.gmail.com>
 <7vr4im7m1y.fsf@alter.siamese.dyndns.org> <CALkWK0=jrO9MQotB+anAn-5YtG1RBTLWEnGL5=K4wy=yi7E-CQ@mail.gmail.com>
 <20130407161209.GG2222@serenity.lan> <CALkWK0kSF_q0o1V6BhO6X2jKAJQxNQ0c6MCi5o=jZdMwrba48g@mail.gmail.com>
 <20130407170201.GH2222@serenity.lan> <CALkWK0nSxfEzP7KHZxGjmBYD7pX5aa3CbMt1qAGrz4tonrtHhA@mail.gmail.com>
 <20130407175210.GI2222@serenity.lan> <CALkWK0n=vtPT7aFn9+T+bRxUpfXG+mYvV29YKC=_OAampQXJSA@mail.gmail.com>
 <20130407182112.GJ2222@serenity.lan> <5161BC33.8060707@web.de>
 <CALkWK0mBW63P0i6OhuujmAYO99pxLsS=ffFeqw8gBcBDgUpOPg@mail.gmail.com> <5161D3C5.9060804@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: John Keeping <john@keeping.me.uk>,
	Junio C Hamano <gitster@pobox.com>,
	Git List <git@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Mon Apr 08 08:46:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UP5pO-0000sy-4N
	for gcvg-git-2@plane.gmane.org; Mon, 08 Apr 2013 08:45:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934319Ab3DGUtv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Apr 2013 16:49:51 -0400
Received: from mail-ie0-f175.google.com ([209.85.223.175]:43037 "EHLO
	mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934298Ab3DGUtv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Apr 2013 16:49:51 -0400
Received: by mail-ie0-f175.google.com with SMTP id c12so6030960ieb.20
        for <git@vger.kernel.org>; Sun, 07 Apr 2013 13:49:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=94KfyJaZ7p81Ap7csXgB/UPPE3qNz1KIMjfYnFlVwew=;
        b=viq6rcd2e/RpTwhgJ8JxvWxOWYuOHTFdhKDOmgR/uknTSkhkaVf9klI97bxyauaXTr
         VpcBJoNKpoiwljgvtbPw5Sc4vy8TSZPu97nFnLyAZpiGmRxdQtIFh21Q584JcAX7ta/1
         EQjNBMt1lH+qrYZpmy8c5ZmjEELxyT1TczK49dhIGuJOt0lQG2xEJoQ0Ouvc2t6rSkWg
         xefrFeiXslQHUuGAK6ubZmC3PmAVmL5OZQmIXrpD2UMgMB+RcfKnT+8Q2eIQUvHrokf6
         cVSUc3dZCUfuOV+yVTddhQ/ICPcnoAv2OzaRYt5DzZHp2LQzT/VfvJZjfMFwR1mv0/h0
         M1HA==
X-Received: by 10.50.117.3 with SMTP id ka3mr4629478igb.107.1365367790857;
 Sun, 07 Apr 2013 13:49:50 -0700 (PDT)
Received: by 10.64.34.80 with HTTP; Sun, 7 Apr 2013 13:49:10 -0700 (PDT)
In-Reply-To: <5161D3C5.9060804@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220378>

Jens Lehmann wrote:
> Just to be sure: I think we agree that both approaches are capable
> of allowing all relevant use cases, because they store the same
> information?

Yes.

> Disclaimer: I am not opposed to the link object per se, but after
> all we are talking about severely changing user visible behavior.
> So I want to see striking evidence that we gain something from it,
> discussed separately from UI deficiencies of the current code (no
> cd-to-toplevel please ;-).

The only mandatory user-visible behavior change is the absence of
.gitmodules.  The git submodule subcommand will be have to be present
and made to work, whether we like it or not.

> (I did not forget to add the point that you currently need a
> checked out work tree to access the .gitmodules file, as there is
> ongoing work to read the configuration directly from the database)

Read the configuration from the database?  How?
Also, I want refs quite badly: I really can't stand repo.

> (Another advantage would be that it is easier to merge the link
> object, but a - still to be coded - .gitmodules aware merge driver
> would work just as well)

It's very simple to implement: if you turn it into a blob, you can
diff and merge as usual.

> Disadvantages:
>
> * Changes in user visible behavior, possible compatibility
>   problems when Git versions are mixed.

Agreed.

> * Special tools are needed to edit submodule information where
>   currently a plain editor is sufficient.

Um, I actually really like this.  I don't want to cd-to-toplevel, open
up my .gitmodules and look for the relevant section.  And it's a very
simple tool: see the git cat-file that I posted earlier.

> * merge conflicts are harder to resolve and require special git
>   commands, solving them in .gitmodules is way more intuitive
>   as users are already used to conflict markers.

There shouldn't be that many merge conflicts to begin with!  It
happens because you've stuffed all the information into one gigantic
.gitmodules.  With links, life is *much* easier: you already have a
tight buffer format and a predefined order in which the key/value
pairs will appear.  But yes, we will require to grow git-core to merge
links seamlessly.

> * A link object has no unstaged counterpart that a file easily
>   has. What would that mean for adding a submodule and then
>   unstaging it (or how could we add a submodule unstaged, like
>   you proposed in another email)?

Adding a submodule untracked (not unstaged) is possible, and is
default: git clone gets the submodules, and you have to use git add to
stage it.  I agree that you can't edit-link and have an unstaged
change, but I really don't care about that.

> (I think when we also put the submodule name in the object we
> could also retain the ability to repopulated moved submodules
> from their old repo, which is found by that name)

Hm, considering that the information is not present anywhere
(certainly not in the tree), this is probably a good idea.  We'd have
the history of the submodule's name too.

> I'm not saying that this list is complete, I just wrote down
> what came to mind. When we e.g. find workable solutions to the
> Disadvantages we can remove them from the list and append them
> in parentheses for later reference like I did here. Does that
> sound like a plan?

Yes, good plan.
