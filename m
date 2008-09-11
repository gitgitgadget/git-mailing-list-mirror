From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC] origin link for cherry-pick and revert
Date: Thu, 11 Sep 2008 16:10:26 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0809111533110.3384@nehalem.linux-foundation.org>
References: <20080909132212.GA25476@cuci.nl> <alpine.LFD.1.10.0809101733050.3384@nehalem.linux-foundation.org> <20080911062242.GA23070@cuci.nl> <200809111020.55115.jnareb@gmail.com> <20080911123148.GA2056@cuci.nl> <20080911135146.GE5082@mit.edu>
 <20080911153202.GD2056@cuci.nl> <20080911180037.GH5082@mit.edu> <20080911190335.GB1451@cuci.nl> <20080911200452.GM5082@mit.edu> <20080911214650.GB3187@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Theodore Tso <tytso@MIT.EDU>,
	"Stephen R. van den Berg" <srb@cuci.nl>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Sep 12 01:12:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KdvKk-0003fJ-Ft
	for gcvg-git-2@gmane.org; Fri, 12 Sep 2008 01:12:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754671AbYIKXLJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Sep 2008 19:11:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754657AbYIKXLI
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Sep 2008 19:11:08 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:50795 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753061AbYIKXLH (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 11 Sep 2008 19:11:07 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m8BNARDv005736
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 11 Sep 2008 16:10:28 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m8BNAQ0U021271;
	Thu, 11 Sep 2008 16:10:26 -0700
In-Reply-To: <20080911214650.GB3187@coredump.intra.peff.net>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
X-Spam-Status: No, hits=-3.939 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95664>



On Thu, 11 Sep 2008, Jeff King wrote:
>
> And obviously in Linus's workflow such references are basically useless,
> and they should just not be generated.

This has _nothing_ to do with workflows or anything else.

Why are people claiming these total red herrings?

I have asked several times what it is that makes it so important that the 
"origin" information be in the headers. Nobody has been able to explain 
why it's so different from just doing it in the free-form part. NOBODY.

If somebody has a workflow where they want to track "origin" commits, then 
they can do it today with the in-body approach. But that has nothing 
what-so-ever to do with the question of "let's change object file format 
to some odd special-case that we just made up and is only apparently 
useful for some special workflow that uses special tools and special 
rules".

I want the git object database to have really clear semantics. The fields 
we have now, we have because we _require_ them. There is nothing unclear 
what-so-ever about the semantics of author/commiter-ship, parenthood, 
trees, or anything else.

And there are _zero_ issues about "workflow". The workflow doesn't matter, 
the objects always make sense, and they always work exactly the same way. 
There are no special magic cases that are in the least questionable in any 
way.

So this argument is about more than just "minimalism", although I'll also 
admit to that being an issue - I want to be able to basically explain how 
git data structures work to any CS student, and not have any extra fat or 
any gray areas. It's about everything having a clear design, and a clear 
meaning, and there never being any question what-so-ever about what the 
real "meaning" of something is.

Then, if you have some special use case or rules for your particular 
project, well that's where you can have things like formatting rules for 
how the commit messages should look like. If somebody wants to use fixed 
format rules for their project, that's fine. And THAT is where "workflow" 
issues come up. 

But "workflow" has nothing to do with core git data structures. They were 
designed for speed, stability, simplicity and good taste. The _workflow_ 
part has been designed on separately on top of that (example: the whole 
thing with a single-line top summary of a commit so that we can have "git 
shortlog" and the "gitk" single-line commit view etc).

Of course, good and generally useful workflows can then be reflected in 
how tools work, where that single line commit summary is an example of 
that: it's not something that git data structures _enforce_ or even care 
about, but it's obviously something that a lot of the porcelain expects, 
and without it, lots of tools will output less useful information.

The same goes for the existing SHA1-in-comment support: some tools already 
support it and help view it in certain ways, even though it is in no way a 
core data structure issue. And _extending_ on that kind of helpful 
porcelain support certainly makes sense.

The only thing I have ever argued against is adding commit headers that 
have no sane semantics and don't make sense as internal git data 
structures.

			Linus
