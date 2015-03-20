From: David Aguilar <davvid@gmail.com>
Subject: Re: A git hook that does git cherry-pick and push automatically
Date: Fri, 20 Mar 2015 00:16:26 -0700
Message-ID: <20150320071625.GA90632@gmail.com>
References: <CAA4Z6SXzekMdPgKKaXqAObPcpFXDWpaQvNhJg6DEsOxbMOy3Lw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Ray Xie <samuiotoko925@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 20 08:16:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YYrAT-0005B5-Mt
	for gcvg-git-2@plane.gmane.org; Fri, 20 Mar 2015 08:16:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751115AbbCTHQZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Mar 2015 03:16:25 -0400
Received: from mail-pd0-f179.google.com ([209.85.192.179]:35039 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751004AbbCTHQY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Mar 2015 03:16:24 -0400
Received: by pdbop1 with SMTP id op1so100617189pdb.2
        for <git@vger.kernel.org>; Fri, 20 Mar 2015 00:16:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=mLKE0qlUnyMk1eBw14WsOdxwth/5MJfIAjMjFrVtohc=;
        b=w3AhbW4UV+KjGN/uMuF2f+cm0QA9MfNrJM40e22S3k5CDF9pttWGWaNzLya+wp/DGL
         Z/sZZhVrqwUsYrMZ9YohqMkt8QVwZlke9H0tP1+mhIWVI7XUYWABKDoL8eYrCxdhuc+d
         eC38I7L4PG/4zqWi5WPoYyj6iE/TtXwqOKY1bOHEROfaBzKc31l1xVDYx5VdHsu166Uk
         XvN9+cYPzYU0SBGRFZ2dAhysoWDHaqg389DLH6SieANMlhYTwk2HjrpkgGyZTuHC54oT
         0hsGzZopa597yMFRUGnJD49jIf8K6qsPPQoQC8nTBEKYfAyWDnfB/f5TFgYouOCIW46F
         E3rg==
X-Received: by 10.66.66.108 with SMTP id e12mr186457044pat.31.1426835784149;
        Fri, 20 Mar 2015 00:16:24 -0700 (PDT)
Received: from gmail.com (208-106-56-2.static.sonic.net. [208.106.56.2])
        by mx.google.com with ESMTPSA id fu14sm6421224pad.44.2015.03.20.00.16.22
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 20 Mar 2015 00:16:23 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAA4Z6SXzekMdPgKKaXqAObPcpFXDWpaQvNhJg6DEsOxbMOy3Lw@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265866>

On Thu, Mar 19, 2015 at 09:07:28PM -0700, Ray Xie wrote:
> So today I had a shocking moment while I was doing my cherry-pick,
> after I performed all the pre-checkin duties (the usual build the
> code, run the test to make sure the cherry-pick infact works), I found
> out that my original commit was already cherry-picked, then I found
> out someone in engineering make the decision to do an automate
> cherry-pick from that branch to another so he added a git hook to run
> do cherry-pick and push on every commit, yes, a simple cherry-pick
> then push; mind you, these are not feature / dev branch, these are
> release branches, both of them.
> 
> Then after I came back from the shock, made a big protest about how
> this is the worst thing I have seen and I will never live with it, and
> that's why "git cherry-pick" and "git push" are 2 separate commands,
> as any reasonable developer, you do your very best to ensure you are
> not pushing something that is fundamentally broken; however for the
> life of me and talk these few people into senses.
> 
> So, I am sending this to seek for some expert advice how I can drive
> some sense into these people so they don't screw up my life as an
> developer.
> 
> Regards,
> Desperate developer, Ray.

It's interesting that your clone picked up the hooks that they
added.  Do you have a centrally managed git installation, where
perhaps they are modifying the default .git/hooks/ template that
is used to seed the initial repo when cloning?

One way to check that is to look at your git installation.
If your git is installed as /usr/bin/git then check
/usr/share/git-core/templates and see if the hook is present
there.

Assuming that you have the ability to create your own clones,
and that you are not all working in a common shared sandbox,
then the simplest solution would be to simply delete your
.git/hooks/* when cloning a new repo.

That way you can at least have your sandboxes work the way
you want them to work.  Hooks are local to your sandbox so you
have full control over them.

Is this hook resilient to rebasing?  Does it cause havoc if you
a feature onto this branch?  Those are the kinds of things that
sound scary based on your description of the hook.

I don't have any tips on how to convince people.  One thing that
might help is to remember that people are self-motivated ~ try
to focus on what *they* stand to benefit from not having this
hook.  If you can convince them that they are better-off without
the hook, from their POV, not from yours, then you might have a
better chance of persuading them.

Good luck,
-- 
David
