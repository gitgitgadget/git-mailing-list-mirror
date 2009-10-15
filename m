From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: [PATCH] Proof-of-concept patch to remember what the detached
 HEAD  was
Date: Thu, 15 Oct 2009 16:11:51 +0200
Message-ID: <20091015141151.GA7867@atjola.homenet>
References: <alpine.LNX.2.00.0910140037570.32515@iabervon.org>
 <76718490910141156g440ee455t2e1db72ad72b7049@mail.gmail.com>
 <alpine.LNX.2.00.0910141509200.32515@iabervon.org>
 <alpine.LFD.2.00.0910141616530.20122@xanadu.home>
 <7v7huxbtbk.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.00.0910141647390.20122@xanadu.home>
 <7vws2xa9lu.fsf@alter.siamese.dyndns.org>
 <20091014230934.GC29664@coredump.intra.peff.net>
 <885649360910150036o72c3bd97ofad85d5316dc5b35@mail.gmail.com>
 <m3bpk8g6nj.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: James Pickens <jepicken@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	Nicolas Pitre <nico@fluxnic.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jay Soffian <jaysoffian@gmail.com>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 15 16:14:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MyR5Z-000724-Vb
	for gcvg-git-2@lo.gmane.org; Thu, 15 Oct 2009 16:13:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753563AbZJOOMp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 15 Oct 2009 10:12:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751781AbZJOOMp
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Oct 2009 10:12:45 -0400
Received: from mail.gmx.net ([213.165.64.20]:42605 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752529AbZJOOMn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Oct 2009 10:12:43 -0400
Received: (qmail invoked by alias); 15 Oct 2009 14:11:55 -0000
Received: from i59F5472B.versanet.de (EHLO atjola.homenet) [89.245.71.43]
  by mail.gmx.net (mp021) with SMTP; 15 Oct 2009 16:11:55 +0200
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX18wM68sxgUwY8YQeKNotMRJpmbD6c8KJtTCyPxZ6D
	R+3X7nUX/8riTP
Content-Disposition: inline
In-Reply-To: <m3bpk8g6nj.fsf@localhost.localdomain>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.58
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130392>

On 2009.10.15 05:54:52 -0700, Jakub Narebski wrote:
> James Pickens <jepicken@gmail.com> writes:
> > Perhaps as an additional safety feature, Git could refuse to switch
> > away from a detached head if the head isn't reachable from any ref,
> > and require -f to override:
> >=20
> > $ git checkout $sha1
> > $ git commit
> > $ git checkout master ;# complain
> > $ git checkout -f master ;# ok
> >=20
> > Maybe I'm missing something and this all can't be done, but it seem=
s simpler
> > than the other options I've seen in this thread.
>=20
> I'm not sure about overloading '-f' option, unless we would require
> doubled '-f' for overriding both safety checks: checkout from detache=
d
> HEAD, and current meaning of forcing a switch even if index or the
> working are differs from HEAD.  So you would need
>=20
>   $ git checkout -f -f master
>=20
> if you are on detached HEAD and have uncommitted changes (dirty tree=20
> or dirty index).

A dirty index/worktree doesn't necessarily stop you from checking out a
different branch head/commit. Only if you have uncommitted changes to a
file that also has changes between HEAD and <other_branch>, git refuses
to switch. And if you want to keep your uncommitted changes, you want t=
o
use -m (3-way merge), not -f (drop changes).

git checkout -f foo ~=3D git reset --hard && git checkout foo

So -f is most likely _not_ the flag one wants to overload.

Bj=F6rn
