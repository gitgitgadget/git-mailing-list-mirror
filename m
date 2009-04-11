From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: [PATCH] process_{tree,blob}: Remove useless xstrdup calls
Date: Sun, 12 Apr 2009 01:24:31 +0200
Message-ID: <20090411232431.GA22747@atjola.homenet>
References: <20090408112854.GA8624@atjola.homenet> <alpine.LFD.2.00.0904101517520.4583@localhost.localdomain> <alpine.LFD.2.00.0904101714420.4583@localhost.localdomain> <alpine.LFD.2.00.0904101806340.4583@localhost.localdomain> <20090411134112.GA1673@atjola.homenet> <20090411140756.GA15288@atjola.homenet> <alpine.LFD.2.00.0904111055480.4583@localhost.localdomain> <20090411205044.GA21673@atjola.homenet> <alpine.LFD.2.00.0904111441240.4583@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nicolas Pitre <nico@cam.org>, Jakub Narebski <jnareb@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>, david@lang.hm,
	Junio C Hamano <gitster@pobox.com>,
	Nicolas Sebrecht <nicolas.s-dev@laposte.net>,
	"Robin H. Johnson" <robbat2@gentoo.org>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sun Apr 12 01:26:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lsman-0000SV-LD
	for gcvg-git-2@gmane.org; Sun, 12 Apr 2009 01:26:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759522AbZDKXYh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 11 Apr 2009 19:24:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759493AbZDKXYh
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Apr 2009 19:24:37 -0400
Received: from mail.gmx.net ([213.165.64.20]:59452 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1758947AbZDKXYg (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Apr 2009 19:24:36 -0400
Received: (qmail invoked by alias); 11 Apr 2009 23:24:34 -0000
Received: from i59F56F7C.versanet.de (EHLO atjola.local) [89.245.111.124]
  by mail.gmx.net (mp011) with SMTP; 12 Apr 2009 01:24:34 +0200
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX1+JgDxluTuJIK+sXgsaIqf1gAENY3iVnXqpmgfRFu
	SWNBnOr/QoIoGQ
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.0904111441240.4583@localhost.localdomain>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.64
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116359>

On 2009.04.11 14:43:14 -0700, Linus Torvalds wrote:
> On Sat, 11 Apr 2009, Bj=F6rn Steinbrink wrote:
> > >=20
> > > And I think I can see why. The new code actually does a _better_ =
job of=20
> > > the resulting list being in "recency" order, whereas the old code=
 used to=20
> > > output the root trees all together. Now they're spread out accord=
ing to=20
> > > how soon they are reached.
> >=20
> > Hm, I don't think that was the case. When iterating over the commit=
s,
> > process_tree was called with commit->tree, and that added the root =
tree
> > to the objects array as well as walking it to add all referenced ob=
jects.
>=20
> Oh, you're right. We actually ended up walking the trees at that poin=
t,=20
> so recency should be the same.=20
>=20
> Hmm. Where does the difference in ordering come from, then?=20

Ah! The tag objects. Previously, they were added to the end of the
objects array, after all the objects from the process_tree() calls. But
now, the pending array is directly processed, causing the tags to show
up earlier. The same is of course true for any other pending object, bu=
t
verifying that for the tag objects was easier :-)

Bj=F6rn
