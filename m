From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [RFC/PATCH 0/7] Rework git core for native submodules
Date: Sun, 7 Apr 2013 23:37:02 +0530
Message-ID: <CALkWK0n=vtPT7aFn9+T+bRxUpfXG+mYvV29YKC=_OAampQXJSA@mail.gmail.com>
References: <1365100243-13676-1-git-send-email-artagnon@gmail.com>
 <CALkWK0mM9HBUvHGHPEw4Vdosp_qfu_1L49TaZrzdC5n3soWkYg@mail.gmail.com>
 <7v61zz9fu3.fsf@alter.siamese.dyndns.org> <CALkWK0n64BW8zQXweR38T6DjT+iYBbsZDPCLZ-4igqGJHoFwKw@mail.gmail.com>
 <7vr4im7m1y.fsf@alter.siamese.dyndns.org> <CALkWK0=jrO9MQotB+anAn-5YtG1RBTLWEnGL5=K4wy=yi7E-CQ@mail.gmail.com>
 <20130407161209.GG2222@serenity.lan> <CALkWK0kSF_q0o1V6BhO6X2jKAJQxNQ0c6MCi5o=jZdMwrba48g@mail.gmail.com>
 <20130407170201.GH2222@serenity.lan> <CALkWK0nSxfEzP7KHZxGjmBYD7pX5aa3CbMt1qAGrz4tonrtHhA@mail.gmail.com>
 <20130407175210.GI2222@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Sun Apr 07 20:07:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UOu0K-0006rb-2Z
	for gcvg-git-2@plane.gmane.org; Sun, 07 Apr 2013 20:07:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934192Ab3DGSHn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Apr 2013 14:07:43 -0400
Received: from mail-ie0-f180.google.com ([209.85.223.180]:34791 "EHLO
	mail-ie0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934151Ab3DGSHn (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Apr 2013 14:07:43 -0400
Received: by mail-ie0-f180.google.com with SMTP id a11so5951812iee.39
        for <git@vger.kernel.org>; Sun, 07 Apr 2013 11:07:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=UEqn2yT5A7XddBk3BY/nZXS+Qx4tvz+ONepFF7gWCt4=;
        b=E7n/B5c0H0D1EG9mEqQ97QP5tUELpEV+j54flV+UPKYuCIN2VLT/staiK8oX1iW45q
         R/RobhnogMQj46w+mqeIypSpP8ESxiReq6+eqHQf1tvtPA9MIIeFG/BwqRw94sLEkX5I
         0mK9MpZIwxdr+Lpg+YZo0t1mf2/GaRdByDLooJB96k79s0CTKCIpM4mkR23S1DzgYqVp
         drKUzVyn+kXS+ugcWk61yi+IWwW2FD9erbX03V73/v9s7QhDzwL0NCYCGUM0HiJlGRY0
         YkOG6z9s7WGiyKcOYascQHdUeIj08Y5oDAlb7pVjHKsLEftra12+VrAKmzDQwRCpI3W5
         Vx0g==
X-Received: by 10.50.17.166 with SMTP id p6mr4707203igd.12.1365358062588; Sun,
 07 Apr 2013 11:07:42 -0700 (PDT)
Received: by 10.64.34.80 with HTTP; Sun, 7 Apr 2013 11:07:02 -0700 (PDT)
In-Reply-To: <20130407175210.GI2222@serenity.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220353>

John Keeping wrote:
> On Sun, Apr 07, 2013 at 10:52:50PM +0530, Ramkumar Ramachandra wrote:
>> Sure, I'll write it out for you from an end-user perspective:
>
> To play Devil's Advocate for a bit...

Yes!

>> 0. Great UI/UX.  No more cd-to-toplevel, and a beautiful set of native
>> commands that are consistent with the overall design of git-core.
>> Which means: clone (to put something in an unstaged place), add (to
>> stage), and commit (to commit the change).  There's now exactly one
>> place in your worktree (which is represented as one file in git; think
>> of it a sort of symlink)  to look in for all the information.  git
>> cat-link <link> to figure out its parameters, git edit-link to edit
>> its parameters: no more "find the matching pwd in .gitmodules in
>> toplevel".  To remove a submodule, just git rm.  And git mv works!
>
> Presumably now without .git/config support, so I can't override the
> checked-in settings without my own custom branch.  Even carrying a dirty
> working tree seems problematic here since a checked-out link object is a
> directory, which can't have information like the remote URL in it.

Sure you can have a dirty worktree.  It's just like .gitmodules:
there's zero difference but for the fact that .gitmodules is
accessible directly via your filesystem, while links are not.

>> 1. True floating submodules.  You can have a submodule checked out at
>> `master` or `v3.1`: no more detached HEADs in submodules unless you
>> want fixed submodules.  No additional cruft required to do the
>> floating: the information is native, in a link object.
>
> Can't I do that now with "submodule.<name>.branch" and "git submodule
> update --remote --rebase" and friends?

Yes, but that is not true floating: you shouldn't have to be sorry and
rebase.  In new-style submodules, they're first class citizens (ie.
true): you can just replace the SHA-1 with a ref in the link.

>> 2. Initializing a nested submodule without having to initialize the
>> outer one: no more repo XML nonsense.  And it's composable: you don't
>> need to put the information about all submodules in one central place.
>
> How does this interact when there is the following structure:
>
>     super
>     `-- sub
>         `-- subsub   (specified by sub)
>
> and subsub is specified as a submodule in *both* super and sub but with
> different settings.  Do I get different behaviour depending on $PWD?

This is a very fringe case that I haven't thought about.  I don't know
how it will behave: I haven't built it yet (and don't have the entire
implementation in my head yet).

>> 3. Ability to have very many large submodule repositories without the
>> performance hit.  It makes sense to block stat() from going through
>> when you have floating submodules.  This means that many levels of
>> nesting are very easily possible.
>
> Can't I already control this to some degree?  Certainly the following
> commands take different amounts of time to run:
>
>     git status
>     git -c status.submodulesummary=true status

You can't control the most fundamental thing, stat(): this is the
primary killer of performance on a large worktree.  There is currently
no way to block stat(): new-style submodules offers a way to configure
which submodules to block the stat() on.
