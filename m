From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: GSOC remote-svn
Date: Sun, 22 Jul 2012 16:43:33 -0500
Message-ID: <20120722214333.GB680@burratino>
References: <4514544.Xip1OCQ7Uj@flomedio>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: davidbarr@google.com, git@vger.kernel.org
To: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 22 23:43:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1St3wH-0004ZX-GK
	for gcvg-git-2@plane.gmane.org; Sun, 22 Jul 2012 23:43:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752654Ab2GVVnj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Jul 2012 17:43:39 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:50354 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752626Ab2GVVni (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Jul 2012 17:43:38 -0400
Received: by obbuo13 with SMTP id uo13so8470072obb.19
        for <git@vger.kernel.org>; Sun, 22 Jul 2012 14:43:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=Ld/CUyvYSfMQvbMnuObrUBf2xxBWqLjp9DLCfW++XVA=;
        b=pK8RSasku3pYZjCisXdB9yPFpq2kgNM0xXVmDxW20KrcenXG6niOmMSggJ49c4xnDG
         IVljZak//aHdoD5+3jxrAIM5BlqAPxEq+aseOQuB+UA9l5uwaqS80UE+gOqPsU10+WHm
         g6HmP8mBf1Jnb9m+932SwIf3Eene3SDKO8UhyL6ycTnee1c7Cth5T0mo+QXEUlIjyLpv
         0n0hIzPImZ2TenkgPNp05zTaUIYTpE8OwjX5EDO+q61ZOzq7qsoPShlOukmhj8bbz6z3
         iSsmsehM0BnfjW9kIOG+OCAWCQkRw5heZ+wmuwvp3fYRhbGj6zUkkm9TGg7KS2adEp2L
         QPuw==
Received: by 10.50.219.162 with SMTP id pp2mr13132402igc.40.1342993418002;
        Sun, 22 Jul 2012 14:43:38 -0700 (PDT)
Received: from burratino (cl-1372.chi-02.us.sixxs.net. [2001:4978:f:55b::2])
        by mx.google.com with ESMTPS id ch4sm4458122igb.2.2012.07.22.14.43.36
        (version=SSLv3 cipher=OTHER);
        Sun, 22 Jul 2012 14:43:37 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4514544.Xip1OCQ7Uj@flomedio>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201872>

Hi,

Florian Achleitner wrote:

> After several mailing iterations, showing me that I was wrong, I found what 
> the right point is, namely that the remote helper writes references to a 
> really private dir in refs/<remote name>/, it doesn't touch anything else, and 
> by advertising the 'refspec' capability, git-fetch knows where the private 
> refs are and updates non-private references according to the fetch refspec in 
> some post-processing in store_updated_refs.

Right, that's fine.  And you did a fine job of navigating the existing
documentation (which could be improved, hint hint).

What I am more concerned about is that you had code you sent a while
ago for review, that this would have been obvious to David, Ram,
Dmitry, or me if we had seen it, and yet none of us gave you that
help.  We are failing at _our_ job of giving you prompt advice and
instead you have had to work on your own.

Isn't it likely that there are multiple other bugs like that which
still haven't been fixed?

That's why I think we need to get into a habit of giving and getting
feedback quickly and incrementally improving work.  Soon, before the
summer ends.

[...]
>> [23:01:10] <jrnieder> and it should not be named remote-svn, since we 
> haven't pinned down details about the svn:: conversion yet.  That's why 
> Dmitry's was called git-remote-svn-alpha)
>
> Ok. Why is that important? I think if it's not called remote-svn git doesn't 
> fid it as a helper for the 'svn' protocol.

It finds it as a helper for the 'svn-alpha' protocol instead.

The point is that when I perform the following steps:

	git clone svn://path/to/remote/repo

	... wait a day, update git

	cd repo
	git pull

nobody would expect the result to be a non-fast-forward update caused
by the details of svn-to-git conversion changing.  Using a name like
testsvn or svn-alpha would help in managing expectations --- the
remote helper is meant for experimentation for now and not meant to be
something people can rely on for collaboration.

[...]
>> [23:03:05] <jrnieder>  * I really rely on patches that do one logical thing 
> with a commit message describing the context and what the patch is trying to 
> accomplish.  That makes review way, way easier when it is happening.
>
> Probably I should stop sending proposals or incomplete stuff to the list/you.
> The current state may probably be viewed easier in my github repo.

No, incomplete stuff is nice.  Just please do explain the _purpose_ of
the code you are sending out.  The best possible outcome is if someone
realizes that something that would have taken hours doesn't need to be
done at all.

[...]
> I wrote a small simulation script in python that mimics svnrdumps behaviour by 
> replaying an existing svn dump file from a start rev up to an end rev to test 
> incremental imports. I use it together with a little testrepo shell script.
> Will need to bring that into t/ later, after figuring out how the test 
> framework works. As it's not finished it's not published.

Sounds neat --- how can one try it out?

> Incremental import:
> By reading the latest svn revision number from a note attached to the private 
> master ref, it starts future imports from the next svn revision. That 
> basically works well.
> It doesn't reuse mark files. What's the point of reusing them? Dmitry's svn-
> alpha did that.
> All I need to know is the revision to start from and the branch i want to add 
> commits to, right? It now simply reads that from the note.

The marks are used to handle copyfrom operations referring to older
revisions.  Are you sure you want to abandon them?  Can you explain a
little more about your plan?

[...]
> This state hasn't hit the list of course, as it's in no way useful nor 
> complete.

A good habit to get into is to make sure your partial progress toward
a goal is in a usable state periodically, even if it is not complete.
That makes it a lot easier to test and to get other people to look it
over.

A rule of thumb is that unless you are adding a new and complicated
feature, it should be possible to fit each change in a patch of around
250 lines including context (not including documentation and tests).

> I often get caught in the traingle of those three processes (git transport-
> helper, fast-import, remote-svn) needing to understand a lot about the 
> existing two to understand why things don't work and why they need to work 
> like they do.

Probably you are finding documentation bugs right and left (yes,
information not being easy to find is a bug) that don't get fixed
because no one has reported them.  Questions are welcome and very
useful.

Hope that helps,
Jonathan
