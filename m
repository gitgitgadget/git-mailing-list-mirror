From: "David Frech" <david@nimblemachines.com>
Subject: Re: CVS -> SVN -> Git
Date: Sat, 14 Jul 2007 16:23:27 -0700
Message-ID: <7154c5c60707141623s3f70e967s226e5da29965a173@mail.gmail.com>
References: <Pine.LNX.4.64.0707131541140.11423@reaper.quantumfyre.co.uk>
	 <469804B4.1040509@alum.mit.edu>
	 <46a038f90707132230n120e6392uaf5cd86ff10b6012@mail.gmail.com>
	 <4699034A.9090603@alum.mit.edu> <20070714195252.GB11010@thyrsus.com>
	 <46994BDF.6050803@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: esr@thyrsus.com, "Martin Langhoff" <martin.langhoff@gmail.com>,
	"Julian Phillips" <julian@quantumfyre.co.uk>, git@vger.kernel.org,
	dev <dev@cvs2svn.tigris.org>
To: "Michael Haggerty" <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Sun Jul 15 01:23:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I9qxY-0004rR-3c
	for gcvg-git@gmane.org; Sun, 15 Jul 2007 01:23:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764840AbXGNXX3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 14 Jul 2007 19:23:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764601AbXGNXX3
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Jul 2007 19:23:29 -0400
Received: from wa-out-1112.google.com ([209.85.146.181]:18794 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752584AbXGNXX2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Jul 2007 19:23:28 -0400
Received: by wa-out-1112.google.com with SMTP id v27so1079252wah
        for <git@vger.kernel.org>; Sat, 14 Jul 2007 16:23:28 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=dpuk6LHG8kIIJmRKKNEPF9xWcnADSV9NZa6vSzK2bLVV/drfwZC+nbcVetpG8M9KLdRZPUqjMDedFe6wFIYG0IYNOz6wPj07owWi50e2nF6GQ5ZU6GXmjkXVw4YYYQJMmMk/l9qwkGHLJdMVlKoMxFgrtWgDzPXRM7N5tjS3tmw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=rbur+u47Ahp5VP1YRg1xVzd5YC7zeVOxhffMa/9leRcMdljk5zIsAlXdeFd9w4YN6HpC1mvAX2uRGzTUUJ0UsDG0BiXfnAmGH/kdQtnv+RMk54q3LFFqrNFjfFE6OTwsvDatRFqc5s/HFZOqYf/LfISpf1WuBzilI3tp5vOBqUk=
Received: by 10.114.174.2 with SMTP id w2mr2875596wae.1184455407542;
        Sat, 14 Jul 2007 16:23:27 -0700 (PDT)
Received: by 10.115.59.9 with HTTP; Sat, 14 Jul 2007 16:23:27 -0700 (PDT)
In-Reply-To: <46994BDF.6050803@alum.mit.edu>
Content-Disposition: inline
X-Google-Sender-Auth: 4dc4eb37ab312a1f
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52517>

Now that this party is really rollicking, I think I'll join in. ;-)

I have a modest svn repo (about 800 commits) that contains fifteen or
so small projects. It started life as a CVS repo, and as the projects
grew and changed, and as I learned more about CVS, things got moved
around. Later, when I got interested in svn (in 2005) I converted the
repo, using cvs2svn. It got a few things wrong - mostly, that it
thought there was one project in the repo, and created toplevel
trunk/, branches/, and tags/ directories, and lumped everything below
these.

So, in svn, I moved things around some more.

Now I want to switch to git. I've since added enough to svn that there
is no option but to use th svn repo as my source. git-svnimport
doesn't work for me because its idea of the structure of my repo is
too limited. I looked around, stumbled over fast-import, and got
hooked on the idea of using it. It seemed simple enough... I wrote a
350-line Lua (!!) program that parses the svn dump file and creates a
commit stream for fast-import.

It took a day and half to get the svn dump parsing right (it's an
egregiously bad format) but only a couple of hours to write the
fast-import backend.

The code "works" in the sense that it can read an svn dump and create
a git repo that looks reasonable, but it misses a few things, like
properly inferring branch creation from the "copyfrom" info in the svn
dump.

However, it's fairly fast (~35 commits/sec) and flexible. I want to,
in the process of doing this conversion, "canonicalize" the structure
of the repo and throw away all the commits from cvs and svn that just
moved things around. This poses another inference challenge, but
having a modest simple tool (ie, a short enough program to easily
understand and modify) helps.

Having done all this, I realized that this is a good way to go.
Separating, as Michael suggests, the "parsing" part from the "commit
generating" part, not only makes the tools easier to write, but makes
them more flexible. If hg or bzr had a git-like fast-import (maybe
they do) it would take me about 35 minutes to target that instead. And
in the process I came across some "missing features" in fast-import,
which Shawn Pearce was able to quickly add.

My repo is tiny, but I still think that speed and flexibility are key
in this process. If I can write a little script that can be useful to
someone with 100k commits instead of my measly 800, that's great.

For that matter, fast-import is a fairly short program. It wouldn't be
hard for other scm projects to do something similar. fast-import could
become a "standard" intermediate format. But even if that doesn't
happen, the amounts of code we're talking about (to do parsing and
commit generation) are reasonably modest and easy to change.

As soon as I make a bit more progress I'm going to make my code available.

Cheers,

- David

On 7/14/07, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> My idea is not to built (for example) cvs2git; rather, I'd like cvs2svn
> to be split conceptually into two tools:
>
> cvs2<abstract_description_of_cvs_history>, whose job it is to determine
> the most likely "true" CVS history based on the data stored in the CVS
> repository, and
>
> <abstract_description_of_cvs_history>2svn
>
> Then later write
>
> <abstract_description_of_cvs_history>2git
> <abstract_description_of_cvs_history>2hg
>
> etc.
>
> The first split is partly done in cvs2svn 2.0.  And I naively imagine
> that writing the new output back ends won't be all that much work.
>
> Michael
>
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

-- 
If I have not seen farther, it is because I have stood in the
footsteps of giants.
