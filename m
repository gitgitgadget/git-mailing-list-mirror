From: Andrew Sayers <andrew-git@pileofstuff.org>
Subject: Re: [spf:guess] Re: Approaches to SVN to Git conversion (was: Re:
 [RFC] "Remote helper for Subversion" project)
Date: Wed, 07 Mar 2012 22:06:40 +0000
Message-ID: <4F57DBF0.4060101@pileofstuff.org>
References: <ab5eb5a7-a446-4dc3-b8e8-e3f7ec306452@mail> <4F56A4DF.8060807@vilain.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Stephen Bash <bash@genarts.com>, Nathan Gray <n8gray@n8gray.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>, git@vger.kernel.org,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Dmitry Ivankov <divanorama@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	David Barr <davidbarr@google.com>
To: Sam Vilain <sam@vilain.net>
X-From: git-owner@vger.kernel.org Thu Mar 08 02:00:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S5RiK-0003Bd-C7
	for gcvg-git-2@plane.gmane.org; Thu, 08 Mar 2012 02:00:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751159Ab2CHBAL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 7 Mar 2012 20:00:11 -0500
Received: from queueout02-winn.ispmail.ntl.com ([81.103.221.56]:18940 "EHLO
	queueout02-winn.ispmail.ntl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751105Ab2CHBAK (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 7 Mar 2012 20:00:10 -0500
Received: from aamtaout04-winn.ispmail.ntl.com ([81.103.221.35])
          by mtaout03-winn.ispmail.ntl.com
          (InterMail vM.7.08.04.00 201-2186-134-20080326) with ESMTP
          id <20120307220642.IVVA14668.mtaout03-winn.ispmail.ntl.com@aamtaout04-winn.ispmail.ntl.com>;
          Wed, 7 Mar 2012 22:06:42 +0000
Received: from [192.168.0.2] (really [94.170.150.126])
          by aamtaout04-winn.ispmail.ntl.com
          (InterMail vG.3.00.04.00 201-2196-133-20080908) with ESMTP
          id <20120307220642.TDQG23925.aamtaout04-winn.ispmail.ntl.com@[192.168.0.2]>;
          Wed, 7 Mar 2012 22:06:42 +0000
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.27) Gecko/20120216 Thunderbird/3.1.19
In-Reply-To: <4F56A4DF.8060807@vilain.net>
X-Cloudmark-Analysis: v=1.1 cv=JvdXmxIgLJv2/GthKqHpGJEEHukvLcvELVXUanXFreg= c=1 sm=0 a=pFZ1vDXyzkQA:10 a=wKSmR4tDAfEA:10 a=u4BGzq-dJbcA:10 a=IkcTkHD0fZMA:10 a=TSbVqHtbAAAA:8 a=xTRpLQ-FlbvAvZdDQTkA:9 a=PhJPrzD4FnTXCVGbgBQA:7 a=QEXdDO2ut3YA:10 a=HpAAvcLHHh0Zw7uRqdWCyQ==:117
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192512>

It sounds like we've approached two similar problems in similar ways, s=
o
I'm curious about the differences where they exist.  I've been reading
this message of yours from 18 months ago alongside this thread:
http://article.gmane.org/gmane.comp.version-control.git/150007
Unfortunately these comprise everything I know about Perforce.

I notice that git-p4raw stores all of its data in Postgres and provides
a programmatic interface for querying it, whereas I've focussed on
providing ASCII interfaces at relevant points.  I can see how a DB stor=
e
would help manage the amount of data you'd need to process in a big
repository, but were there any other issues that drove you down this
route?  Did you consider a text-based interface?

On 06/03/12 23:59, Sam Vilain wrote:
<snip>
> What I did for the Perl Perforce conversion is make this a multi=E2=80=
=93step
> process; first, the heuristic goes through and detects branches and
> merge parents.  Then you do the actual export.  If, however, the
> heuristic gets it wrong, then you can manually override the branch
> detection for a particular revision, which invalidates all of the
> _automatic_ decisions made for later revisions the next time you run =
it.

Could you give an example of overriding branch/merge detection?  It
sounds like you're saying that if there's some problem detecting merge
parents in an early revision, then all future merges are ignored by the
script.

<snip>
> The manual input is extremely useful for bespoke conversions; there w=
ill
> always be warts in the history and no heuristic is perfect (even if y=
ou
> can supply your own set of expressions, a way to override it for just
> one revision is handy).

Again, would you mind providing a few examples?  It sounds like you hav=
e
some edge cases that could be handled by extending the branch history
format, but I'd like to pin it down a bit more before discussing soluti=
ons.

<snip>
>   3. skip bad sections of history, for instance squash merging merges
> which happened over several commits (SVN and Perforce, of course,
> support insane piecemeal merging prohibited by git)

This is an excellent point I've stumbled past in my experiments without
realising what I was seeing.  A simple SVN example might look like this=
:

	svn add trunk branches
	svn add trunk/foo trunk/bar
	svn ci -m "Initial revision" # r1

	svn cp trunk branches/my_branch
	svn ci -m "Created my_branch" # r2

	# edit files in my_branch

	svn merge branches/my_branch/foo trunk/foo
	svn ci -m "Merge my_branch -> trunk (1/3)" # r11

	svn merge branches/my_branch/bar trunk/bar
	svn ci -m "Merge my_branch -> trunk (2/3)" # r12

	svn cp branches/my_branch/new_file trunk/new_file
	svn ci -m "Merge my_branch -> trunk (3/3)" # r13

This strikes me as a sensibly cautious workflow in SVN, where merge
conflicts are common and changes are hard to revert.  The best
representation for this in the current branch history format would be
something like this:

	In r1, create branch "trunk"
	In r2, create branch "branches/my_branch" from "trunk"
	In r13, merge "branches/my_branch" r13 into "trunk"

In other words, pretend r11 and r12 are just normal commits, and that
r13 is a full merge.  A more useful (and arguably more accurate)
representation would be possible if we extended the format a bit:

	In r1, create branch "trunk"
	In r2, create branch "branches/my_branch" from "trunk"
	In r12, squash changes in "branches/my_branch"
	In r13, squash changes in "branches/my_branch"
	In r13, merge "branches/my_branch" r13 into "trunk"

Adding "squash" and "fixup" commands would let us represent the whole
messy business as a single commit, which is closer to what the user was
trying to say even if it's further from what they actually had to say.

	- Andrew
