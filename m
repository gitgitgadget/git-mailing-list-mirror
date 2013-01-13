From: John Keeping <john@keeping.me.uk>
Subject: Re: [PATCH 0/8] Initial support for Python 3
Date: Sun, 13 Jan 2013 00:41:30 +0000
Message-ID: <20130113004129.GH4574@serenity.lan>
References: <cover.1358018078.git.john@keeping.me.uk>
 <20130112234304.GC23079@padd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Eric S. Raymond" <esr@thyrsus.com>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Sebastian Morr <sebastian@morr.cc>
To: Pete Wyckoff <pw@padd.com>
X-From: git-owner@vger.kernel.org Sun Jan 13 01:47:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TuBjK-0007DF-RG
	for gcvg-git-2@plane.gmane.org; Sun, 13 Jan 2013 01:47:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753667Ab3AMAlo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Jan 2013 19:41:44 -0500
Received: from jackal.aluminati.org ([72.9.247.210]:40878 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753608Ab3AMAln (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Jan 2013 19:41:43 -0500
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id BC9B9CDA598;
	Sun, 13 Jan 2013 00:41:42 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -2.9
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_00=-1.9] autolearn=ham
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kKpOIg-8MtQp; Sun, 13 Jan 2013 00:41:41 +0000 (GMT)
Received: from pichi.aluminati.org (pichi.aluminati.org [10.0.16.50])
	by jackal.aluminati.org (Postfix) with ESMTP id 6B5DECDA563;
	Sun, 13 Jan 2013 00:41:41 +0000 (GMT)
Received: from localhost (localhost [127.0.0.1])
	by pichi.aluminati.org (Postfix) with ESMTP id 5A312161E55A;
	Sun, 13 Jan 2013 00:41:41 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at aluminati.org
Received: from pichi.aluminati.org ([127.0.0.1])
	by localhost (pichi.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TOcjOMkIcbWS; Sun, 13 Jan 2013 00:41:41 +0000 (GMT)
Received: from serenity.lan (mink.aluminati.org [10.0.7.180])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by pichi.aluminati.org (Postfix) with ESMTPSA id 7056F161E556;
	Sun, 13 Jan 2013 00:41:31 +0000 (GMT)
Content-Disposition: inline
In-Reply-To: <20130112234304.GC23079@padd.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213316>

On Sat, Jan 12, 2013 at 06:43:04PM -0500, Pete Wyckoff wrote:
> john@keeping.me.uk wrote on Sat, 12 Jan 2013 19:23 +0000:
>> I started having a look to see how much work would be needed to make Git
>> work with Python 3 and the answer is mostly not much.  The exception is
>> git-p4.py which is hit hard by the distinction between byte strings and
>> unicode strings, particularly because the Python output mode of p4
>> targets Python 2.
>> 
>> I don't know if it's worthwhile to actually apply these but here they
>> are in case anyone's interested.
>> 
>> Having said that, the changes are minimal and involve either wrapping
>> parentheses around arguments to print or being a bit more explicit about
>> how we expect byte strings to be decoded to unicode.
>> 
>> With these patches all tests pass with python3 except t98* (git-p4), but
>> there are a couple of topics in-flight which will affect that
>> (fc/remote-testgit-feature-done and er/replace-cvsimport).
>> 
>> John Keeping (8):
>>   git_remote_helpers: Allow building with Python 3
>>   git_remote_helpers: fix input when running under Python 3
>>   git_remote_helpers: Force rebuild if python version changes
>>   git_remote_helpers: Use 2to3 if building with Python 3
>>   svn-fe: allow svnrdump_sim.py to run with Python 3
>>   git-remote-testpy: hash bytes explicitly
>>   git-remote-testpy: don't do unbuffered text I/O
>>   git-remote-testpy: call print as a function
>> 
>>  contrib/svn-fe/svnrdump_sim.py     |  4 ++--
>>  git-remote-testpy.py               | 40 +++++++++++++++++++-------------------
>>  git_remote_helpers/.gitignore      |  1 +
>>  git_remote_helpers/Makefile        | 10 ++++++++--
>>  git_remote_helpers/git/importer.py |  2 +-
>>  git_remote_helpers/setup.py        | 10 ++++++++++
>>  6 files changed, 42 insertions(+), 25 deletions(-)
> 
> These look good, in that there are relatively few changed needed.
> 
> Sebastian Morr tried a similar patch a year ago, in
> 
>     http://thread.gmane.org/gmane.comp.version-control.git/187545
> 
> He made changes beyond yours, in particular "print >>" lines,
> that you seem to handle with 2to3 during the build.  I'm not sure
> which approach is better in the long run.  He worked on the
> other .py in contrib/ too.

In the long run I'd want to move away from "print >>" to use
"print(file=..., ...)" but that's only available from Python 2.6 onwards
(via a __future__ import) and I think we probably don't want to rule out
Python 2.5 yet.

Without 2to3 the only way to do this for both Python 2 and 3 is as
"file.write('...\n')".

> Can you give me some hints about the byte/unicode string issues
> in git-p4.py?  There's really only one place that does:
> 
>     p4 = subprocess.Popen("p4 -G ...")
>     marshal.load(p4.stdout)
> 
> If that's the only issue, this might not be too paniful.

The problem is that what gets loaded there is a dictionary (encoded by
p4) that maps byte strings to byte strings, so all of the accesses to
that dictionary need to either:

   1) explicitly call encode() on a string constant
or 2) use a byte string constant with a "b" prefix

Or we could re-write the dictionary once, which handles the keys... but
some of the values are also used as strings and we can't handle that as
a one-off conversion since in other places we really do want the byte
string (think content of binary files).

Basically a thorough audit of all access to variables that come from p4
would be needed, with explicit decode()s for authors, dates, etc.

> I hesitated to take Sebastian's changes due to the huge number of
> print() lines, but maybe a 2to3 approach would make that aspect
> of python3 support not too onerous.

I think we'd want to change to print() eventually and having a single
codebase for 2 and 3 would be nicer for development, but I think we need
to be able to say "no one is using Python 2.5 or earlier" before we can
do that and I'm not sure we're there yet.  From where we are at the
moment I think 2to3 is a good answer, particularly where we're already
using distutils to generate a release image.


John
