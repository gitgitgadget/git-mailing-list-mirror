From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: On pathnames
Date: Fri, 25 Jan 2008 11:25:05 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0801251111540.13593@iabervon.org>
References: <34103945-2078-4983-B409-2D01EF071A8B@sb.org> <alpine.LFD.1.00.0801211846010.2957@woody.linux-foundation.org> <E3E4F5B3-1740-47E4-A432-C881830E2037@sb.org> <20080122133427.GB17804@mit.edu> <20080123000841.GA22704@mit.edu>
 <alpine.LFD.1.00.0801221625510.1741@woody.linux-foundation.org> <20080123013325.GB1320@mit.edu> <20080123064139.GC16297@glandium.org> <4697E0BA-7243-4C35-A384-0BD261EC21AF@sb.org> <20080123094052.GB6969@glandium.org> <20080123133802.GC7415@mit.edu>
 <alpine.LFD.1.00.0801230808440.1741@woody.linux-foundation.org> <98F90EB6-1930-4643-8C6C-CA11CB123BAA@sb.org> <alpine.LFD.1.00.0801230930390.1741@woody.linux-foundation.org> <7vprvr7x8h.fsf@gitster.siamese.dyndns.org> <alpine.LNX.1.00.0801242227250.13593@iabervon.org>
 <7vprvq7cy7.fsf@gitster.siamese.dyndns.org> <alpine.LSU.1.00.0801251134570.5731@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Kevin Ballard <kevin@sb.org>, Theodore Tso <tytso@MIT.EDU>,
	Mike Hommey <mh@glandium.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jan 25 17:25:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JIRN6-0005Ye-R6
	for gcvg-git-2@gmane.org; Fri, 25 Jan 2008 17:25:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753277AbYAYQZJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jan 2008 11:25:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753164AbYAYQZJ
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Jan 2008 11:25:09 -0500
Received: from iabervon.org ([66.92.72.58]:40604 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752482AbYAYQZH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jan 2008 11:25:07 -0500
Received: (qmail 13123 invoked by uid 1000); 25 Jan 2008 16:25:05 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 25 Jan 2008 16:25:05 -0000
In-Reply-To: <alpine.LSU.1.00.0801251134570.5731@racer.site>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71716>

On Fri, 25 Jan 2008, Johannes Schindelin wrote:

> Hi,
> 
> On Thu, 24 Jan 2008, Junio C Hamano wrote:
> 
> > Daniel Barkalow <barkalow@iabervon.org> writes:
> > 
> > > $ git checkout branch
> > > Warning: xt_CONNMARK.c conflicts with xt_connmark.c; not checking it out
> > > $ git checkout xt_CONNMARK.c --as xt_CONNMARK_caps.c
> > > $ edit xt_CONNMARK_caps.c
> > > $ git add xt_CONNMARK_caps.c
> > 
> > Heh, I like that very much.
> 
> It would make it easier to test on Linux, too, yes.
> 
> But then, it would break the build process all the same.

Sure, but it would permit a user of a filesystem that can't handle the 
project to make modifications that generate a commit the filesystem can 
handle, which is currently pretty difficult.

$ git checkout xt_CONNMARK.c --as xt_CONNMARK_tmp.c
$ mv xt_CONNMARK_tmp.c xt_connmark_flag.c
$ edit Makefile
$ git add xt_connmark_flag.c
$ git commit -a

(The key thing here being that git will determine that you removed 
xt_CONNMARK.c despite open(xt_CONNMARK.c) returning something unrelated)

Remember that this level of support is to allow users who can't have the 
project checked out in their filesystems to manipulate the project's data, 
not to actually make the project work as presented in the filesystem by 
git.

> And the implementation would _need_ the index extension Linus seems to 
> resent so.

Linus was objecting to having redundant information stored, because it 
could get skewed. If the information being stored is not redundant (i.e., 
the normal case is that entries have a flag saying they exist in the 
filesystem under their own names, and the new cases are that the entry 
isn't present in the filesystem at all or that the entry is present in the 
filesystem under some other name), that isn't an issue.

	-Daniel
*This .sig left intentionally blank*
