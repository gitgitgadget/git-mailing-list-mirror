From: Bruce Stephens <bruce.stephens@isode.com>
Subject: Re: refining .gitignores
Date: Thu, 15 Nov 2007 21:13:04 +0000
Message-ID: <807ikjdxgf.fsf@tiny.isode.net>
References: <804pfobgkp.fsf@tiny.isode.net>
            <20071114230258.GG3973@steel.home>
            <807ikj3fge.fsf@tiny.isode.net>
            <20071115192654.GA3552@steel.home>
            <80ejerdzjd.fsf@tiny.isode.net>
            <alpine.LFD.0.9999.0711151237550.4260@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Nov 15 22:13:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ism1g-0002Rr-LQ
	for gcvg-git-2@gmane.org; Thu, 15 Nov 2007 22:13:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754375AbXKOVNM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Nov 2007 16:13:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758141AbXKOVNL
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Nov 2007 16:13:11 -0500
Received: from rufus.isode.com ([62.3.217.251]:40770 "EHLO rufus.isode.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754375AbXKOVNK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Nov 2007 16:13:10 -0500
Received: from tiny.isode.net (shiny.isode.com [62.3.217.250]) 
          by rufus.isode.com (smtp internal) via TCP with SMTP 
          id <Rzy2YABBVC2E@rufus.isode.com>; Thu, 15 Nov 2007 21:13:04 +0000
Received: by tiny.isode.net (sSMTP sendmail emulation);
          Thu, 15 Nov 2007 21:13:04 +0000
X-Hashcash: 1:20:071115:torvalds@linux-foundation.org::nLNiqDJe1h8jWExh:000000000000000000000000000000007/t9
X-Hashcash: 1:20:071115:raa.lkml@gmail.com::a/zpKeUh8eCuD5ph:000000000000000000000000000000000000000000037Wm
X-Hashcash: 1:20:071115:git@vger.kernel.org::mJmX5qRBSBUN9nXs:0000000000000000000000000000000000000000000q6O
In-Reply-To: <alpine.LFD.0.9999.0711151237550.4260@woody.linux-foundation.org> (Linus Torvalds's message of "Thu\, 15 Nov 2007 12\:40\:14 -0800 \(PST\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65159>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Thu, 15 Nov 2007, Bruce Stephens wrote:
>>
>> They are in the index.  What I want is a list of files which are known
>> to git, which are matched by the default rules (in particular the
>> .gitignore files).
>
> Ahh.
>
> *All* the .gitignore rules are purely about files that git does not 
> already know about. Once git tracks a pathname, the ignore rules simply 
> do not matter.
>
> Files that are in the index are simply never ignored. There's no way to 
> ignore them, and in fact, the whole "git add -f" thing is a way to add 
> files to the index and override the exclude rules - at which point git 
> then tracks them regardless of any such exclude rules.

OK.  I think I sort of understood that, but it's nice to have it
clearly stated.

I'm not worried so much about files that already exist.  I'm worried
that we may in the future create files that we want to store in git
and which are ignored.  If we do that there's a chance we'll miss them
(because "git gui", "git status", etc., won't bring attention to
them).

So it seemed valuable to try to make the .gitignore patterns precise:
so that they ignore all the generated files that our builds produce,
while not matching any files that git knows about.

That certainly wouldn't guarantee that new files wouldn't be caught by
the patterns, but it ought to lower the probability of this, since
there's a decent chance that such files will either be not touched by
the patterns (because they're *.java or something), or they'll fit
into one of the already handled exceptions (Doxyfile.local is one:
most *.local files are build products, but Doxyfile.local aren't).

I guess if you're starting off with some project in git then this
isn't such an issue: you evolve the patterns and the build process and
so on in parallel.  So maybe there's not such a demand for finding
this information, and those of us who do want to do it are best using
the "git add" loop approach?
