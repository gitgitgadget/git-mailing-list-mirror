From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [RFC/PATCH 0/7] Rework git core for native submodules
Date: Sun, 7 Apr 2013 22:52:50 +0530
Message-ID: <CALkWK0nSxfEzP7KHZxGjmBYD7pX5aa3CbMt1qAGrz4tonrtHhA@mail.gmail.com>
References: <1365100243-13676-1-git-send-email-artagnon@gmail.com>
 <CALkWK0mM9HBUvHGHPEw4Vdosp_qfu_1L49TaZrzdC5n3soWkYg@mail.gmail.com>
 <7v61zz9fu3.fsf@alter.siamese.dyndns.org> <CALkWK0n64BW8zQXweR38T6DjT+iYBbsZDPCLZ-4igqGJHoFwKw@mail.gmail.com>
 <7vr4im7m1y.fsf@alter.siamese.dyndns.org> <CALkWK0=jrO9MQotB+anAn-5YtG1RBTLWEnGL5=K4wy=yi7E-CQ@mail.gmail.com>
 <20130407161209.GG2222@serenity.lan> <CALkWK0kSF_q0o1V6BhO6X2jKAJQxNQ0c6MCi5o=jZdMwrba48g@mail.gmail.com>
 <20130407170201.GH2222@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Sun Apr 07 19:23:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UOtJY-000251-KU
	for gcvg-git-2@plane.gmane.org; Sun, 07 Apr 2013 19:23:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934131Ab3DGRXc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Apr 2013 13:23:32 -0400
Received: from mail-ie0-f176.google.com ([209.85.223.176]:50599 "EHLO
	mail-ie0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934124Ab3DGRXc (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Apr 2013 13:23:32 -0400
Received: by mail-ie0-f176.google.com with SMTP id x14so5906761ief.7
        for <git@vger.kernel.org>; Sun, 07 Apr 2013 10:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=l763vJ8h1Ifg7zN2uq1cgvqGv+qUbVPGXMSvi2Hp91k=;
        b=HYMv9XHj5Z33lTfdVJsuQylBfABYzmKT7+mhL8oPxVIBaNxXIlUDvKWiZxP2z1gRI5
         XCDIdcP65CkAJFDxUR3+55wEJ0RB8dh/+m3U+22/VaL3In4Gjero5xfDZqCLY0+xpypl
         /bL8+mG5YqU/ZZeW/RfeD/vrNNCvsa0IcC70JXPkj5iFVXrq+NvR9qwc0eU9IhhhxpnO
         nfJjyDU2L/bVq/20l49Rg+dLpjjKsySEN0v+6tyiK8xpF5R0wi16rpwUz89DPhdF3bz6
         6a1rv+FnpEo/5RWYDBBgJvJ7pGhqiFm4c8MnmdKeiyRHpANtrNsHVVNUg2X8iXR53u9W
         pnwA==
X-Received: by 10.50.17.166 with SMTP id p6mr4628327igd.12.1365355411590; Sun,
 07 Apr 2013 10:23:31 -0700 (PDT)
Received: by 10.64.34.80 with HTTP; Sun, 7 Apr 2013 10:22:50 -0700 (PDT)
In-Reply-To: <20130407170201.GH2222@serenity.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220334>

John Keeping wrote:
> So not a flag day, but still some point at which the repository
> transitions to "will not work with Git older than version X".  And if
> you need to add a new submodule then you cannot delay that transition
> any longer.

Yes, that is true.  I don't see any way out of this.

> I haven't seen anywhere a concise list of what functionality this is.
> Do you have a simple bulleted list of what new features this would
> allow?

Sure, I'll write it out for you from an end-user perspective:

0. Great UI/UX.  No more cd-to-toplevel, and a beautiful set of native
commands that are consistent with the overall design of git-core.
Which means: clone (to put something in an unstaged place), add (to
stage), and commit (to commit the change).  There's now exactly one
place in your worktree (which is represented as one file in git; think
of it a sort of symlink)  to look in for all the information.  git
cat-link <link> to figure out its parameters, git edit-link to edit
its parameters: no more "find the matching pwd in .gitmodules in
toplevel".  To remove a submodule, just git rm.  And git mv works!

1. True floating submodules.  You can have a submodule checked out at
`master` or `v3.1`: no more detached HEADs in submodules unless you
want fixed submodules.  No additional cruft required to do the
floating: the information is native, in a link object.

2. Initializing a nested submodule without having to initialize the
outer one: no more repo XML nonsense.  And it's composable: you don't
need to put the information about all submodules in one central place.

3. Ability to have very many large submodule repositories without the
performance hit.  It makes sense to block stat() from going through
when you have floating submodules.  This means that many levels of
nesting are very easily possible.

4. It's suddenly much easier to add new features to this
implementation.  You don't need to do the kind of gymnastics you'd
have to do if you were hacking on submodule.c/ git-submodule.sh.

This is basically how "great design" plays out.
