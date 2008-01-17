From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git on MacOSX and files with decomposed utf-8 file names
Date: Thu, 17 Jan 2008 11:10:19 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0801171106510.17650@racer.site>
References: <478E1FED.5010801@web.de> <76718490801162043w3884435ex435f38b9de837540@mail.gmail.com> <76718490801162059i2472cd82va34010caa3130b7e@mail.gmail.com> <7vejchkp6o.fsf@gitster.siamese.dyndns.org> <32DB7E53-1062-4F7C-A42D-6EC5945A70A3@wincent.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463811741-954912509-1200568220=:17650"
Cc: Junio C Hamano <gitster@pobox.com>,
	Jay Soffian <jaysoffian+git@gmail.com>, git@vger.kernel.org
To: Wincent Colaiuta <win@wincent.com>
X-From: git-owner@vger.kernel.org Thu Jan 17 12:10:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFSe5-00054D-8C
	for gcvg-git-2@gmane.org; Thu, 17 Jan 2008 12:10:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751248AbYAQLKZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jan 2008 06:10:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751253AbYAQLKZ
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Jan 2008 06:10:25 -0500
Received: from mail.gmx.net ([213.165.64.20]:48035 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751055AbYAQLKY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jan 2008 06:10:24 -0500
Received: (qmail invoked by alias); 17 Jan 2008 11:10:22 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp036) with SMTP; 17 Jan 2008 12:10:22 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19EKBxSlYJElJwQSK0S+hSBC8EDntqD1Z0ACM//t/
	WYmA2Mj7M4trzk
X-X-Sender: gene099@racer.site
In-Reply-To: <32DB7E53-1062-4F7C-A42D-6EC5945A70A3@wincent.com>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70848>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463811741-954912509-1200568220=:17650
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT

Hi,

[Jay, don't cull Cc: lists on vger.kernel.org.  I consider it rude.]

On Thu, 17 Jan 2008, Wincent Colaiuta wrote:

> El 17/1/2008, a las 6:15, Junio C Hamano escribió:
> 
> > "Jay Soffian" <jaysoffian+git@gmail.com> writes:
> > 
> > > So here's what I can see as being useful additions to git:
> > > ...
> > > Thoughts (besides "patches welcomed")?
> > 
> > I think we already discussed a plan to store normalization mapping in 
> > the index extension section and use it to avoid getting confused by 
> > readdir(3) that lies to us.  Is there any more thing that need to be 
> > discussed?

Yes, and I think that a lot of time would have more wisely spent on 
reading that, and trying to implement it, than writing a number of long 
mails, repeating the _same_ (refuted) points over and over again.

> > I would presume that we would still add _new_ paths using the pathname 
> > we receive from the user (there is no need for us to be similarly 
> > insane as broken "normalizing" filesystems), but when deciding if a 
> > path is new or we already have it in the index would be done by seeing 
> > if an entry already exists in the index whose "normalized" form is the 
> > same as the "normalized" form of the given path --- that way we would 
> > not add two paths to the index that would "normalize" to the same 
> > string.

Agree.

> And what do we do when asked to check out a tree which has two different 
> files in it whose normalized forms are the same (ie. a clone of a repo 
> created on a non-HFS+ filesystem)?
> 
> We either have to fail catastrophically, preventing the user from 
> working with that tree on HFS+, or arbitrarily pick one of the files as 
> the "winner" which gets written out into the work tree. None of the 
> options is particularly attractive, although luckily this exact 
> situation is unlikely to come up in practice.

Anything else but failure would be Not What You Want.  You might want a 
special mode where you use a _different_ name on-disk (something like the 
infamous short names on FAT), but that _must_ be turned off by default: 
think of Martin's HEAD example.  Sometimes, it's just not possible to 
check such a tree out on a less-than-nice system.

Ciao,
Dscho

---1463811741-954912509-1200568220=:17650--
