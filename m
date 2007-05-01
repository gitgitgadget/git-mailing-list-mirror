From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 4/8] git-repack --max-pack-size: add fixup_header_footer()
Date: Tue, 1 May 2007 02:03:40 -0400
Message-ID: <20070501060340.GD5942@spearce.org>
References: <463679EB.2010301@gmail.com> <20070501050633.GZ5942@spearce.org> <56b7f5510704302241n79601619kda8251a9f7776884@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
To: Dana How <danahow@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 01 08:03:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HilSs-0003gD-1h
	for gcvg-git@gmane.org; Tue, 01 May 2007 08:03:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423811AbXEAGDv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 1 May 2007 02:03:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423815AbXEAGDv
	(ORCPT <rfc822;git-outgoing>); Tue, 1 May 2007 02:03:51 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:33289 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423811AbXEAGDt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 May 2007 02:03:49 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HilSg-0001IX-TF; Tue, 01 May 2007 02:03:43 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id DEFAD20FBAE; Tue,  1 May 2007 02:03:40 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <56b7f5510704302241n79601619kda8251a9f7776884@mail.gmail.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45920>

Dana How <danahow@gmail.com> wrote:
> On 4/30/07, Shawn O. Pearce <spearce@spearce.org> wrote:
> >Why not
> >refactor both to use the same implementation and stuff it away in
> >say pack-check.c (for lack of a better place), or start a new file
> >(pack-write.c)?
> Actually I didn't just copy it, I tried to rewrite it for my use
> as well as the fast-import.c use (note there is a 3rd copy
> in some *index*.c file which I didn't try to merge in yet).
> However I didn't yet put it in a new file or change fast-import.c
> to call it since I wanted to change as little as possible.
...
> I agree with all your arguments.  I had several reasons
> to avoid extra rearrangements/refactorings:
> (a) First patch to git, not previously known to me;
> (b) I prefer to separate new functionality from "clean-up" work;

A really good reason.  ;-)

But I'd still rather see it done right the first time, then done
partially (copied) and wait for someone to clean it up later.
Sometimes that cleanup doesn't happen.  Anyway, I'm not against
you copying it, I just think there's a better way (refactor at
least fast-import's use of it).
 
> (c) I didn't really view myself as the person to make the *writing*
>    code in git as well organized/minimized as the *reading* code
>    [e.g. the sliding mmap stuff -- nice!];

Not sure I follow that argument, but thanks for the compliment on
the sliding mmap work.  I think I was trying to point out that that
one particular function is actually quite simple, and you did a
direct copy of it from fast-import.c.  Instead a simple refactoring
that allows both pack-objects.c and fast-import.c share the same
implementation of those 30 or so lines of code would be a good
start towards cleaning up the writing code.  Yes it doesn't help
the index-pack.c usage of same logic, but baby steps will help us
to cleanup the mess we have already made!

We like baby steps around here...  ;-)

> (d) Apparently you and Nicolas Pitre have a lot of pending changes
>    affecting the packing code.

Yes, but Nico's work has also destroyed in pack v4 topic.  Nico has
promised to start working on porting some of that work over, but I
don't know if he has been able to start doing so yet.  I personally
have been too busy this past month and a half to really work on
packv4, but I'm hoping to circle back to it before the end of May
(if Nico doesn't beat me to it!).

> I'd have no problem submitting a follow-on patch later containing
> some clean-up work if you & NP clear it, so I know I won't have
> problems from (d).  Note I had to completely rewrite this patch
> when NP submitted some of his pending stuff.

Yea, hazard of working in this part of the code when Nico is
also active.  My own sliding mmap stuff was written twice too,
for the same reason - Nico doing much needed improvements right in
the same spot as I was working, at the same time.
 
> NP wrote that you posted a summary of v3/v4 pack ideas,
> but I couldn't find it in the list archives.  Could you either
> email it to me, or (re-)post it to the list?

You can start here:

  http://news.gmane.org/find-root.php?group=gmane.comp.version-control.git&article=40799
  http://article.gmane.org/gmane.comp.version-control.git/42423
  http://article.gmane.org/gmane.comp.version-control.git/45406
  http://news.gmane.org/find-root.php?group=gmane.comp.version-control.git&article=43046

anything by me or Nico in those threads is good reading on pack v4.
The last link is probably the best thread available on the subject.

-- 
Shawn.
