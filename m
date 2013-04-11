From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [ITCH] Specify refspec without remote
Date: Thu, 11 Apr 2013 13:08:48 +0530
Message-ID: <CALkWK0nvTisYCFjxwuGaBbWawwBahzeBHZ84rFkUYL8sjJuxvw@mail.gmail.com>
References: <20130410202456.GF24177@sigill.intra.peff.net> <CALkWK0k_gYWg9=zjRKGrq-evsWG+hCrLjrpLfYp=_uoHVKBzHw@mail.gmail.com>
 <20130410210455.GA2999@sigill.intra.peff.net> <CALkWK0k-YJwT__8Tc4B4WXq30ij3i8_d6qwyOCP5RLsKF9eazQ@mail.gmail.com>
 <20130410211824.GC27070@google.com> <CALkWK0nxpoLL4zoinE4j8y8NLHo0-b=PcimNLykCjMjOpWYEfQ@mail.gmail.com>
 <20130410212911.GE27070@google.com> <CALkWK0m=iDw+N0zcfEEt1jzFD4wOOzLgyBWNyc=HZ+xLe5SBLw@mail.gmail.com>
 <20130410215658.GC6215@sigill.intra.peff.net> <CALkWK0=Y-pO3+g21PLCWOxx+M-7fSmp2FedMBtZ68PWU_TOHDw@mail.gmail.com>
 <20130410222334.GC6930@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git List <git@vger.kernel.org>,
	=?UTF-8?B?RHV5IE5ndXnhu4Vu?= <pclouds@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Apr 11 09:39:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQC6Y-0007Dc-Fl
	for gcvg-git-2@plane.gmane.org; Thu, 11 Apr 2013 09:39:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753692Ab3DKHja (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Apr 2013 03:39:30 -0400
Received: from mail-ie0-f180.google.com ([209.85.223.180]:38489 "EHLO
	mail-ie0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752479Ab3DKHj3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Apr 2013 03:39:29 -0400
Received: by mail-ie0-f180.google.com with SMTP id a11so1675421iee.11
        for <git@vger.kernel.org>; Thu, 11 Apr 2013 00:39:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=8U3XhJyIO6qa1W8wzx6AiS60ULE0G12h7kX1d0dvAuM=;
        b=owvV5oc9W8+Z7qVJ1hbG2jtokzlPYBXcDkNAmgUDCBtB90s2MKJLOP+PU3M5i3B9ce
         31T8MMFWRJQz/VSGpidaHvtqlifEwg5x1P2mED1zELnq8lKgMA78ncM144X7Sn1489mS
         9kGTZQCqH//ni8mQM7jbRry7Hz2AtW3uTNLks0XiddqeqR8ZSSmXRssJ5K2AIWlcJrqJ
         bZJ8oE1PO7lS9L8oaPHgULPDUsMbbn6r+XwMnWPG+ndrgkMiQtliaB5QOaBVpTip/CRM
         UBnOufCvmYDetW4/Ksf3+12XsSQkGqSHcQv5fO/8IS8c84od1d0934bMymPBXzv8quBb
         KECg==
X-Received: by 10.50.117.3 with SMTP id ka3mr14728400igb.107.1365665968802;
 Thu, 11 Apr 2013 00:39:28 -0700 (PDT)
Received: by 10.64.34.80 with HTTP; Thu, 11 Apr 2013 00:38:48 -0700 (PDT)
In-Reply-To: <20130410222334.GC6930@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220830>

Jeff King wrote:
>   $ git clone https://github.com/upstream/project.git
>   $ cd project
>   $ hack hack hack; commit commit commit
>   $ git tag -m 'something of note' my-tag
>   $ git remote add me https://github.com/me/project.git
>   $ git config branch.master.remote me
>   $ git tag -m 'something of note'
>   $ git push master my-tag

Tags have nothing to do with branches, and it is illogical to respect
branch.* when pushing a tag.  You've illustrated a common case when
the user creates a tag on a specific branch and immediately pushes it.
 I would argue that optimizing our tools for this specific usecase
breaks the general case.  What if I create a branch on master, and
decide to push the tag after checking out implicit-push and doing some
work on it?  Does that not break user expectations?

In the "I push to the same place I pull from" (aka. single-remote)
case, there are never any problems and even "matching" works fine.
However, in the triangular workflow (aka. multiple-remote) case, you
must give git enough information about your workflow for it to DTRT.
I will argue that, in the above example, you have not configured git
for a multiple-remote case, and that you cannot expect it to DTRT
since you have supplied insufficient information.  As to how to
configure git for the general multiple-remote case:

Let us imagine that origin points to git/git.git (upstream), ram
points to artagnon/git.git and peff points to peff/git.git.  I fork
off from upstream and have various local branches that only have
corresponding refs in ram (say implicit-push).  Then, you fork off
from me, and have various local branches that only have corresponding
refs in peff (say implicit-push-next).  I have peff as a configured
remote, because I routinely review the changes you make to my fork.
In this case, I must have:

- push.default set to anything but matching, because matching makes no
sense in the multiple-remote scenario*.

- remote.default set to origin, because this is where I get new code
from for all branches.

- remote.pushdefault set to ram, because this is where I publish all
my refs to (whether branches or tags).  I might have local branches
that I will never publish, but that's a separate issue.  The point is
that all my tags will always be published here.

- branch.implicit-push.remote set to ram, because this is the correct
upstream for the implicit-push branch.

- branch.implicit-push-next.remote set to peff, because this is the
correct upstream for the implicit-push-next branch.

- branch.implicit-push-next.pushremote set to null**, because I will
never want to push this branch.

(Note that branch.implicit-push.pushremote is unnecessary because
remote.pushdefault takes care of that)

With these settings, git push will always DTRT when you specify
nothing, just a remote, or just a refspec.  Ofcourse, you can specify
both and be explicit (which is what we do now).  Does this make sense?
 Should we document this in gitworkflows.txt so that users know what
is expected of them when they move from a single-remote setup to a
multi-remote setup?

* I will definitely push for the deprecation of push.default=matching,
but I doubt we need to invent a new push.default.  current makes a lot
of sense to me personally.

** Yet to be invented.
