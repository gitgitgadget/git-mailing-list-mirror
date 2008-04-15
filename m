From: Jeff King <peff@peff.net>
Subject: Re: branch description
Date: Tue, 15 Apr 2008 15:19:30 -0400
Message-ID: <20080415191930.GC31395@sigill.intra.peff.net>
References: <9b3e2dc20804150951scf8b3c7x26f3a56eab1f9840@mail.gmail.com> <f9d2a5e10804151031o1d09c1f9od0ad78dcf9b746c5@mail.gmail.com> <C55CA6EB-D427-4CF5-923E-DE0071D2F870@silverinsanity.com> <7vej97x78v.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Brian Gernhardt <benji@silverinsanity.com>,
	Russ Dill <russ.dill@gmail.com>,
	Stephen Sinclair <radarsat1@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 15 21:29:29 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JlqoH-0003E8-Mk
	for gcvg-git-2@gmane.org; Tue, 15 Apr 2008 21:27:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755239AbYDOT0P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Apr 2008 15:26:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755071AbYDOT0O
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Apr 2008 15:26:14 -0400
Received: from [208.65.91.99] ([208.65.91.99]:2510 "EHLO peff.net"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1754490AbYDOT0O (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Apr 2008 15:26:14 -0400
X-Greylist: delayed 401 seconds by postgrey-1.27 at vger.kernel.org; Tue, 15 Apr 2008 15:26:13 EDT
Received: (qmail 9148 invoked by uid 111); 15 Apr 2008 19:19:31 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Tue, 15 Apr 2008 15:19:31 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 15 Apr 2008 15:19:30 -0400
Content-Disposition: inline
In-Reply-To: <7vej97x78v.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79622>

On Tue, Apr 15, 2008 at 12:12:16PM -0700, Junio C Hamano wrote:

> > No special tags needed.  A simple file that I'll call .git/info/
> > ref_names could be a set of lines that have "<ref>\t<description>",
> > like the following:
> >
> > refs/heads/master	Collection point for all my work
> > refs/heads/ref_names	Add descriptions for branches
> > refs/heads/segfault	Trying to fix bug #12345
> >
> > Simple, no tags, new object types or anything.  All you have to do is
> > add the bits to git-branch to add, edit, and remove the description
> > alongside the branch itself.
> 
> Not complicated at all.  Put that description in-tree in a known location
> (say, "help-branch") in-tree and your propagation problem is solved.
>
> And have a scriptlet in $HOME/bin/git-help-branch to grep from that file.

It is perhaps a little slow if you want to do things like adding the
help text to branch name decorations in log output. Maybe instead of a
flat file, you could parallel the ref name hierarchy in a tree? I.e.,

  git checkout help-branch
  echo 'Collection point for all my work' >refs/heads/master
  git commit -a

As a bonus, you don't even need a git-help-branch script:

  git show help-branch:refs/heads/master

And if you have more than one person tweaking the help-branch text,
merging will be much less painful.

-Peff
