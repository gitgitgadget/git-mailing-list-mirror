From: Johan Herland <johan@herland.net>
Subject: Re: [RFCv3 2/4] Add Python support library for CVS remote helper
Date: Wed, 12 Aug 2009 11:08:28 +0200
Message-ID: <200908121108.28714.johan@herland.net>
References: <1250036031-32272-1-git-send-email-johan@herland.net>
 <1250036031-32272-3-git-send-email-johan@herland.net>
 <20090812021017.GB62301@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, barkalow@iabervon.org, gitster@pobox.com,
	Johannes.Schindelin@gmx.de
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 12 11:08:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mb9p5-0004Ue-VJ
	for gcvg-git-2@gmane.org; Wed, 12 Aug 2009 11:08:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932221AbZHLJIc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Aug 2009 05:08:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932202AbZHLJIc
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Aug 2009 05:08:32 -0400
Received: from smtp.getmail.no ([84.208.15.66]:60519 "EHLO
	get-mta-out01.get.basefarm.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S932181AbZHLJIb (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 12 Aug 2009 05:08:31 -0400
Received: from mx.getmail.no ([10.5.16.4]) by get-mta-out01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KO900D5EAQ68E80@get-mta-out01.get.basefarm.net> for
 git@vger.kernel.org; Wed, 12 Aug 2009 11:08:30 +0200 (MEST)
Received: from alpha.localnet ([84.215.102.95])
 by get-mta-in01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KO900C7HAQ5UNA0@get-mta-in01.get.basefarm.net> for
 git@vger.kernel.org; Wed, 12 Aug 2009 11:08:30 +0200 (MEST)
X-PMX-Version: 5.5.3.366731, Antispam-Engine: 2.7.0.366912,
 Antispam-Data: 2009.8.12.85419
User-Agent: KMail/1.12.0 (Linux/2.6.30-ARCH; KDE/4.3.0; x86_64; ; )
In-reply-to: <20090812021017.GB62301@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125685>

First, thank you very much for the review. It is very helpful, and I really 
appreciate it.

On Wednesday 12 August 2009, David Aguilar wrote:
> On Wed, Aug 12, 2009 at 02:13:49AM +0200, Johan Herland wrote:
> > This patch introduces a Python package called "git_remote_cvs"
> > containing the building blocks of the CVS remote helper. The CVS remote
> > helper itself is NOT part of this patch.
>
> Interesting...
>
> > diff --git a/git_remote_cvs/changeset.py b/git_remote_cvs/changeset.py
> > new file mode 100644
> > index 0000000..27c4129
> > --- /dev/null
> > +++ b/git_remote_cvs/changeset.py
> > @@ -0,0 +1,114 @@
> > +#!/usr/bin/env python
> > +
> > +"""Functionality for collecting individual CVS revisions into
> > "changesets" +
> > +A changeset is a collection of CvsRev objects that belong together in
> > the same +"commit". This is a somewhat artificial construct on top of
> > CVS, which only +stores changes at the per-file level. Normally, CVS
> > users create several CVS +revisions simultaneously by applying the "cvs
> > commit" command to several files +with related changes. This module
> > tries to reconstruct this notion of related +revisions.
> > +"""
> > +
> > +from util import *
>
> Importing * is frowned upon in Python.
>
> It's much easier to see where things are coming from if you
> 'import util' and use the namespaced util.foo() way of accessing
> the functions.

I'd rather do "from util import X Y Z", as the util stuff is used all over 
the place.

> Furthermore, you're going to want to use absolute imports.
> Anyone can create 'util.py' and blindly importing 'util' is
> asking for trouble.
>
> Instead use:
> from git_remote_cvs import util

I thought the python import rules specified that the current package was 
consulted first, and therefore the 'util' package would always come from the 
current package. However, I must confess that I don't know these rules very 
well, so I'll take your word for it and use absolute imports instead.

> > +class Changeset (object):
> > +	"""Encapsulate a single changeset/commit"""
>
> I think it reads better as Changeset(object)
> (drop the spaces before the parens).
>
> That applies to the rest of this patch as well.

Ok. Will change.

> This also had me wondering about the following:
> 	git uses tabs for indentation
>
> BUT, the python convention is to use 4-space indents ala PEP-8
> http://www.python.org/dev/peps/pep-0008/

Interesting. I have (obviously) never looked at PEP 8... :)

> It might be appealing to when-in-Rome (Rome being Python) here
> and do things the python way when we code in Python.
>
> Consistency with pep8 is good if we expect to get python hackers
> to contribute to git_remote_cvs.

I see your point, but I believe that since git_remote_cvs is not an 
independent project (but very much coupled to git), its allegiance is with 
Git, and it should therefore follow the Git coding style. In other words, I 
claim exception (2) in PEP 8

> > +
> > +	__slots__ = ('revs', 'date', 'author', 'message')
>
> __slots__ is pretty esoteric in Python-land.
>
> But, if your justification is to minimize memory usage, then
> yes, this is a good thing to do.

Yes, I only use __slots__ for classes that potentially have a large number 
of instances.

> > +	def __init__ (self, date, author, message):
> > +		self.revs    = {}      # dict: path -> CvsRev object
> > +		self.date    = date    # CvsDate object
> > +		self.author  = author
> > +		self.message = message # Lines of commit message
>
> pep8 and other parts of the git codebase recommend against
> lining up the equals signs like that.  Ya, sorry for the nits
> being that they're purely stylistic.

I can't find a good rationale for this rule in PEP8 (other than Guido's 
personal style), and I personally find the above much more readable 
(otherwise I wouldn't go through the trouble of lining them all up...). Can 
I claim exception (1) (readability)?

> > +		if len(msg) > 25: msg = msg[:22] + "..." # Max 25 chars long
> > +		return "<Changeset @(%s) by %s (%s) updating %i files>" % (
> > +			self.date, self.author, msg, len(self.revs))
>
> Similar to the git coding style, this might be better written:
>
> ...
> if len(msg) > 25:
>     msg = msg[:22] + '...' # Max 25 chars long
> ...
>
> (aka avoid single-line ifs)
>
> There's a few other instances of this in the patch as well.

Ok. Will try to eliminate single-line ifs.

> > diff --git a/git_remote_cvs/cvs.py b/git_remote_cvs/cvs.py
> > new file mode 100644
> > index 0000000..cc2e13f
> > --- /dev/null
> > +++ b/git_remote_cvs/cvs.py
> > @@ -0,0 +1,884 @@
> > [...]
> > +
> > +	def enumerate (self):
> > +		"""Return a list of integer components in this CVS number"""
> > +		return list(self.l)
>
> enumerate has special meaning in Python.
>
> items = (1, 2, 3, 4)
> for idx, item in enumerate(items):
>     print idx, item
>
>
> I'm not sure if this would cause confusion...

Good point, I should probably rename this method.

> > [...]
> > +		else: # revision number
> > +			assert self.l[-1] > 0
>
> asserts go away when running with PYTHONOPTIMIZE.
>
> If this is really an error then we should we raise an exception
> instead?

I use asserts to verify pre/post-conditions and other invariants. I believe 
that if this assert fails, it is indicative of something horribly wrong with 
the code itself. However, I now see that one can also trigger this case with 
bad input (e.g. CvsNum("1.2.3.0").parent()). I will keep the assert here, 
but will also add some input verification to the CvsNum class.

> > +	@classmethod
> > +	def test (cls):
> > +		assert cls("1.2.4") == cls("1.2.0.4")
>
> Hmm.. Does it make more sense to use the unittest module?
>
> e.g. self.assertEqual(foo, bar)

Probably. I'm not familiar with 'unittest', but will take a look.

> > diff --git a/git_remote_cvs/cvs_revision_map.py
> > b/git_remote_cvs/cvs_revision_map.py new file mode 100644
> > index 0000000..7d7810f
> > --- /dev/null
> > +++ b/git_remote_cvs/cvs_revision_map.py
> > @@ -0,0 +1,362 @@
> > +#!/usr/bin/env python
> > +
> > +"""Functionality for mapping CVS revisions to associated
> > metainformation""" +
> > +from util import *
> > +from cvs  import CvsNum, CvsDate
> > +from git  import GitFICommit, GitFastImport, GitObjectFetcher
>
> We definitely need absolute imports here.
>
> 'import git' could find the git-python project's git module.

Ok. Will fix.

> Nonetheless, interesting stuff.

Thanks for the review!


Have fun! :)

...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
