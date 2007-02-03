From: Giorgos Keramidas <keramida@ceid.upatras.gr>
Subject: Re: newbie questions about git design and features (some wrt hg)
Date: Sat, 3 Feb 2007 23:20:30 +0200
Message-ID: <20070203212030.GA91453@kobe.laptop>
References: <3c6c07c20701300820l42cfc8dbsb80393fc1469f667@mail.gmail.com> <200702010058.43431.jnareb@gmail.com> <20070201003429.GQ10108@waste.org> <200702021055.49428.jnareb@gmail.com> <slrnes6mmr.3l6.mdw@metalzone.distorted.org.uk> <epvnln$fmn$1@sea.gmane.org> <Pine.LNX.4.64.0702020835550.15057@woody.linux-foundation.org> <20070202175923.GA6304@xanadu.kublai.com> <20070202182709.GA3861@kobe.laptop> <Pine.LNX.4.64.0702021050350.15057@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: jnareb@gmail.com, mercurial@selenic.com, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sat Feb 03 22:21:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HDSKR-0008P0-6a
	for gcvg-git@gmane.org; Sat, 03 Feb 2007 22:21:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751723AbXBCVVp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 3 Feb 2007 16:21:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751728AbXBCVVp
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Feb 2007 16:21:45 -0500
Received: from igloo.linux.gr ([62.1.205.36]:46492 "EHLO igloo.linux.gr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751723AbXBCVVp (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Feb 2007 16:21:45 -0500
Received: from kobe.laptop ([194.30.196.125])
	(authenticated bits=128)
	by igloo.linux.gr (8.13.8/8.13.8/Debian-3) with ESMTP id l13LKi5h012830
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sat, 3 Feb 2007 23:20:50 +0200
Received: from kobe.laptop (kobe.laptop [127.0.0.1])
	by kobe.laptop (8.13.8/8.13.8) with ESMTP id l13LKVbs098721;
	Sat, 3 Feb 2007 23:20:43 +0200 (EET)
	(envelope-from keramida@ceid.upatras.gr)
Received: (from keramida@localhost)
	by kobe.laptop (8.13.8/8.13.8/Submit) id l13LKUdT098720;
	Sat, 3 Feb 2007 23:20:30 +0200 (EET)
	(envelope-from keramida@ceid.upatras.gr)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0702021050350.15057@woody.linux-foundation.org>
X-Hellug-MailScanner: Found to be clean
X-Hellug-MailScanner-SpamCheck: not spam, SpamAssassin (not cached,
	score=-3.735, required 5, autolearn=not spam, ALL_TRUSTED -1.80,
	AWL 0.46, BAYES_00 -2.60, DNS_FROM_RFC_ABUSE 0.20)
X-Hellug-MailScanner-From: keramida@ceid.upatras.gr
X-Spam-Status: No
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38605>

On 2007-02-02 11:01, Linus Torvalds <torvalds@linux-foundation.org> wrote:
>On Fri, 2 Feb 2007, Giorgos Keramidas wrote:
>> Sometimes, 'sliding a tag' is a real-world need.  Losing the
>> information of who did the tag sliding and when, is not good.
>
> In practice, this is not much of an issue.

Sure it is.  Maybe not in the context of all projects or all teams, but
properly versioning tag names and knowing who installed the tag, and
when is quite often an issue with unversioned tags in some of the teams
I have worked with.

> First off, CVS tag usage is insane, but it's insane for *other*
> reasons (ie people use tags differently in CVS, but they do it not
> because they want to use tags that way, but because CVS makes it
> impossible to do anything saner).
>
> So pointing to CVS tag usage as an argument is pointless. You might as
> well say that you shouldn't save the merge information, because CVS
> doesn't do it, and manual tags are a good way to do it.
>
> Secondly, the problems with tags having "history" is that you can't
> really resolve them anyway. You have to pick one. You can't "merge"
> them.

Ok, maybe CVS was not so good as an example of why versioned tags *are*
useful, but my comment came from the experience I have with the tagging
of FreeBSD release builds.  The -STABLE branch os FreeBSD may be tagged
with RELENG_X_Y_Z_RELEASE at a particular point in time.  If we find
that some important bug fix has to go in, the fix is committed, and the
tag can 'slide' forward for only a particular file or set of files.

When tags are versioned, this operation is properly versioned too.  It's
apparent from browsing the global tag history that the specific tag
*was* moved forward; it's obvious where it was pointing before the
'slide' operation; it's obvious which files the 'slide' affected, etc.

Having the tags operations as an integral part of the visible history of
all public repositories is not necessarily useful for 100% of the
people who may skim through the logs, but I'm not sure why you suggest
that it's difficult to "merge" tags.

Since tags point to a very specific changeset hash, the hash serves as a
unique, unconflicting identifier of the tag's location in history.  When
a "pull" operation happens, there are no conflicts unless there is a
naming conflict between the "remote" and "local" repository.  It's not
impossible or even difficult to "merge" the two tag sets.

> In other words, tags are atomic *events*, not history. And I certainly
> agree that you shouldn't lose the events (unless you want to, of course).

Tags are a little of two different things:

(1) They are 'events' in the sense that someone has placed them to a
tree, and this operation is a very real, very natural event, and *this*
event should be versioned.

(2) They are 'pointers' to a particular changeset id.  The particular
changeset hash to which they point, when the user looks at a specific
revision of the history tree, is immuttable from the point of view of
someone looking at this specific revision.  It may *change* as the
viewer moves back and forth into the history tree though.

The pointer-nature of tags doesn't need to be versioned when one looks
at one particular changeset, but the event-nature of their placement
into the tree *can* be versioned and IMHO it *should* be versioned.
Otherwise, there is no good way to provide accountability for these
events, and some part of the repository 'history' is lost.

> I also do agree that you can absolutely have something that is
> basically a "tag that moves, and that you want to tie back to the
> previous state of the tag". In git, we just happen to call those
> things "branches".

You're confusing a single, one-time movement of a tag (to point to a
place *after* a bugfix, for instance), with the creation of a new,
entirely separate, full branch.  One of them is ok in some cases; the
other is probably necessary in others.

I can understand why they don't _both_ seem useful for all possible
cases, but I don't see why we should limit ourselves to only one of the
two options.

- Giorgos
