From: David Aguilar <davvid@gmail.com>
Subject: Re: [RFCv3 2/4] Add Python support library for CVS remote helper
Date: Tue, 11 Aug 2009 19:10:27 -0700
Message-ID: <20090812021017.GB62301@gmail.com>
References: <1250036031-32272-1-git-send-email-johan@herland.net> <1250036031-32272-3-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, barkalow@iabervon.org, gitster@pobox.com,
	Johannes.Schindelin@gmx.de
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Wed Aug 12 04:10:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mb3IX-0004RQ-MM
	for gcvg-git-2@gmane.org; Wed, 12 Aug 2009 04:10:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754232AbZHLCKb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Aug 2009 22:10:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751606AbZHLCKb
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Aug 2009 22:10:31 -0400
Received: from rv-out-0506.google.com ([209.85.198.236]:57224 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751468AbZHLCKb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Aug 2009 22:10:31 -0400
Received: by rv-out-0506.google.com with SMTP id f6so1466839rvb.1
        for <git@vger.kernel.org>; Tue, 11 Aug 2009 19:10:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=DaNmIse7SJkwZYRFL3MTtP0MUm/yEUkDko+KmyDUL84=;
        b=dU1vmuZQyfeFZnkLYRNlmbqxY5QwAIB1YNRbQwBVkXsvBUY269ChpIq1obdewDK8Bo
         40v++g1Tq1ZwFFTXDBTLtQzJ1x0uNsbFSLzMk5j0ifQYsieuNyLWtjXNmOQXYwTK0zWE
         pJ2Rwi8+AfUU12SYnMLATEkwu879bGgXNiyJg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=JCQNMIgiAfX4BOPIuSsW3iMWkDLLX96C4Vlj5JGx1QaiKK5lF2K2CofuBCjh6UA2EB
         5CcNsV9UHBIEzpb0dTxPdJ7q5DB+cDwMh6kpA9O4tYhzESskAhejpB9iuQxrRwf5njOz
         SPQkH9ewAs6nPunvTcCMWd9V5JR5P3AfC52Y8=
Received: by 10.140.207.2 with SMTP id e2mr3040241rvg.298.1250043032158;
        Tue, 11 Aug 2009 19:10:32 -0700 (PDT)
Received: from gmail.com (wdas-1.disneyanimation.com [12.188.26.1])
        by mx.google.com with ESMTPS id k41sm32629031rvb.38.2009.08.11.19.10.29
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 11 Aug 2009 19:10:30 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1250036031-32272-3-git-send-email-johan@herland.net>
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125642>

On Wed, Aug 12, 2009 at 02:13:49AM +0200, Johan Herland wrote:
> This patch introduces a Python package called "git_remote_cvs" containing
> the building blocks of the CVS remote helper. The CVS remote helper itself
> is NOT part of this patch.

Interesting...

> diff --git a/git_remote_cvs/changeset.py b/git_remote_cvs/changeset.py
> new file mode 100644
> index 0000000..27c4129
> --- /dev/null
> +++ b/git_remote_cvs/changeset.py
> @@ -0,0 +1,114 @@
> +#!/usr/bin/env python
> +
> +"""Functionality for collecting individual CVS revisions into "changesets"
> +
> +A changeset is a collection of CvsRev objects that belong together in the same
> +"commit". This is a somewhat artificial construct on top of CVS, which only
> +stores changes at the per-file level. Normally, CVS users create several CVS
> +revisions simultaneously by applying the "cvs commit" command to several files
> +with related changes. This module tries to reconstruct this notion of related
> +revisions.
> +"""
> +
> +from util import *


Importing * is frowned upon in Python.

It's much easier to see where things are coming from if you
'import util' and use the namespaced util.foo() way of accessing
the functions.

Furthermore, you're going to want to use absolute imports.
Anyone can create 'util.py' and blindly importing 'util' is
asking for trouble.

Instead use:
from git_remote_cvs import util


> +class Changeset (object):
> +	"""Encapsulate a single changeset/commit"""

I think it reads better as Changeset(object)
(drop the spaces before the parens).

That applies to the rest of this patch as well.


This also had me wondering about the following:
	git uses tabs for indentation

BUT, the python convention is to use 4-space indents ala PEP-8
http://www.python.org/dev/peps/pep-0008/


It might be appealing to when-in-Rome (Rome being Python) here
and do things the python way when we code in Python.

Consistency with pep8 is good if we expect to get python hackers
to contribute to git_remote_cvs.


> +
> +	__slots__ = ('revs', 'date', 'author', 'message')


__slots__ is pretty esoteric in Python-land.

But, if your justification is to minimize memory usage, then
yes, this is a good thing to do.


> +	def __init__ (self, date, author, message):
> +		self.revs    = {}      # dict: path -> CvsRev object
> +		self.date    = date    # CvsDate object
> +		self.author  = author
> +		self.message = message # Lines of commit message

pep8 and other parts of the git codebase recommend against
lining up the equals signs like that.  Ya, sorry for the nits
being that they're purely stylistic.

> +		if len(msg) > 25: msg = msg[:22] + "..." # Max 25 chars long
> +		return "<Changeset @(%s) by %s (%s) updating %i files>" % (
> +			self.date, self.author, msg, len(self.revs))

Similar to the git coding style, this might be better written:

...
if len(msg) > 25:
    msg = msg[:22] + '...' # Max 25 chars long
...

(aka avoid single-line ifs)

There's a few other instances of this in the patch as well.



> diff --git a/git_remote_cvs/cvs.py b/git_remote_cvs/cvs.py
> new file mode 100644
> index 0000000..cc2e13f
> --- /dev/null
> +++ b/git_remote_cvs/cvs.py
> @@ -0,0 +1,884 @@
> [...]
> +
> +	def enumerate (self):
> +		"""Return a list of integer components in this CVS number"""
> +		return list(self.l)

enumerate has special meaning in Python.

items = (1, 2, 3, 4)
for idx, item in enumerate(items):
    print idx, item


I'm not sure if this would cause confusion...


> [...]
> +		else: # revision number
> +			assert self.l[-1] > 0

asserts go away when running with PYTHONOPTIMIZE.

If this is really an error then we should we raise an exception
instead?


> +	@classmethod
> +	def test (cls):
> +		assert cls("1.2.4") == cls("1.2.0.4")

Hmm.. Does it make more sense to use the unittest module?

e.g. self.assertEqual(foo, bar)

> diff --git a/git_remote_cvs/cvs_revision_map.py b/git_remote_cvs/cvs_revision_map.py
> new file mode 100644
> index 0000000..7d7810f
> --- /dev/null
> +++ b/git_remote_cvs/cvs_revision_map.py
> @@ -0,0 +1,362 @@
> +#!/usr/bin/env python
> +
> +"""Functionality for mapping CVS revisions to associated metainformation"""
> +
> +from util import *
> +from cvs  import CvsNum, CvsDate
> +from git  import GitFICommit, GitFastImport, GitObjectFetcher

We definitely need absolute imports here.

'import git' could find the git-python project's git module.


Nonetheless, interesting stuff.


-- 
		David
