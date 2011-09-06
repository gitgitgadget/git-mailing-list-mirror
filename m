From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: Git commit generation numbers
Date: Tue, 6 Sep 2011 15:32:03 +0530
Message-ID: <CALkWK0kJ_0_MyUgQ+F+FgGun6vtk=VTh6Gsbb0u+EUrcLT5cGg@mail.gmail.com>
References: <20110721202722.3765.qmail@science.horizon.com>
 <alpine.LFD.2.00.1107220907370.1762@xanadu.home> <alpine.DEB.2.02.1107221102180.6496@asgard.lang.hm>
 <201107222034.20510.jnareb@gmail.com> <CA+55aFzsZ6w_a_wPEuBjtDeSDYQviVfy9UmJMxPz4geu4CRthQ@mail.gmail.com>
 <CAMP44s2F429MG5DeRAULnSgNkCwrVGPfC2HeFw=iHXPXjkw0yA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Jeff King <peff@peff.net>, Jakub Narebski <jnareb@gmail.com>,
	david@lang.hm, Nicolas Pitre <nico@fluxnic.net>,
	George Spelvin <linux@horizon.com>,
	Anthony Van de Gejuchte <anthonyvdgent@gmail.com>,
	Phil Hord <hordp@cisco.com>,
	Shawn Pearce <spearce@spearce.org>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Sep 06 12:02:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R0sUB-0000Q5-5k
	for gcvg-git-2@lo.gmane.org; Tue, 06 Sep 2011 12:02:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754016Ab1IFKC0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Sep 2011 06:02:26 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:33409 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753884Ab1IFKCY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Sep 2011 06:02:24 -0400
Received: by wwf5 with SMTP id 5so6027677wwf.1
        for <git@vger.kernel.org>; Tue, 06 Sep 2011 03:02:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=V3drn8aM6Q+amaHvUsqcx6x4zPdUuTZLxcW9BLGhI+c=;
        b=kJK4Kl48/4irfTJwK06FGZSdMCU05WV5OhKWS2qaNOkG17UvSe5moofEQa9YXcI8TS
         lGr4uXo06aX8g9bxWsnxJKnGAI7dPrGwMuQsNQlSNhoaoDMOp8QNJdOmVVqBuTxc+tYm
         Ffo2hJ/9S3Hc9I1R9H98uQHsxUsbsb+0AH1Zg=
Received: by 10.216.167.5 with SMTP id h5mr3334662wel.96.1315303343207; Tue,
 06 Sep 2011 03:02:23 -0700 (PDT)
Received: by 10.216.51.135 with HTTP; Tue, 6 Sep 2011 03:02:03 -0700 (PDT)
In-Reply-To: <CAMP44s2F429MG5DeRAULnSgNkCwrVGPfC2HeFw=iHXPXjkw0yA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180783>

Hi,

First, let me start out by saying that I'm a fairly new contributor to
Git, and I'm far less experienced than the other people on this
thread.  I've read through all the discussions time and again, and
thought about the problem for some time now - I can't say I understand
it as fully as many of you do, but I think I may have a slightly
different perspective to offer.

In what way is Git fundamentally different from Subversion?  It's the
simplicity of the data model.  From the simplest building block, a
key-value store, we have been able to compose and build things on top
of it.  The reason we built centralized version control systems
earlier is because it was *easier* to address the composition
problems.  We dumped all related repository and problems into one
central server.  With so much information in one place, things are
tightly coupled and problems are easier to solve.  Still not
convinced?  What's the weakest component in Git today?  Undoubtedly
submodules.  Ofcourse, a large part of the reason is that many people
don't use submodules, and hence it doesn't improve -- but it's
actually a circular problem.  People don't use submodules, because
it's so featureless and hard to develop.  Why is it so hard?  Back to
the fundamental problem of composition from simple building blocks.
In submodules, we have to take entire DAGs and build a composite DAG.
The key pieces of information are deep inside Git's fundamnetals:
Gitlinks.  Other projects try like Gitslave try to attack the problem
on a more superficial level, but they all hit a barrier when they
discover that they can't compose big blocks of data: you need simple
building blocks to compose.

It's the same story with C (and now, Haskell).  Why does everyone like
C so much?  Because it only provides fundamental building blocks and
gives people the freedom to compose the way they like.  It doesn't
provide big "template blocks" like Java, because they tend to be
restrictive in the long run.  Sure, Java is easier to start out with,
but people soon realize that big blocks can't compose.

More than arguing about backward compatibility, and about how older
versions of Git commits won't have generation numbers, I think this is
what we should be focusing on.  Sure, it'll additionally make sense to
put in a cache to speed things up now, but we need to think about what
Git will be 10~15 years from now.  The fundamental pieces of
information required for composition must be present in the
fundamental building blocks.

The real question we should be asking is: "Should Git have had commit
generation numbers in 2005?".  If the answer is "yes", we should put
them in now before it becomes even harder, bending over backwards for
backward compatibility if necessary.  Otherwise, we'll regret this
decision 10~15 years later, when we're faced with deeper issues.  If
you want a concrete example, think about how you'd compose DAGs
together (again, the submodules problem): where is the information
required to prune each DAG and compose?

I wish I could write this in myself, but I'm afraid I don't have the
engineering skill yet.  I'll be happy to contribute whatever little I
can, and participate in the review process.

Thanks.

-- Ram
