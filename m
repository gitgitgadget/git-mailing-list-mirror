From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: Performance issue: initial git clone causes massive repack
Date: Thu, 23 Apr 2009 00:50:19 +0200
Message-ID: <20090422225019.GA17039@atjola.homenet>
References: <alpine.LFD.2.00.0904071454250.6741@xanadu.home> <20090407202725.GC4413@atjola.homenet> <alpine.LFD.2.00.0904080041240.6741@xanadu.home> <20090410T203405Z@curie.orbis-terrarum.net> <alpine.DEB.1.00.0904141749330.10279@pacific.mpi-cbg.de> <alpine.LFD.2.00.0904141542161.6741@xanadu.home> <20090414T202206Z@curie.orbis-terrarum.net> <1240362948.22240.76.camel@maia.lan> <alpine.LFD.2.00.0904221011340.6741@xanadu.home> <49EF93CA.20207@vilain.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nicolas Pitre <nico@cam.org>,
	"Robin H. Johnson" <robbat2@gentoo.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>,
	Nick Edelen <sirnot@gmail.com>
To: Sam Vilain <sam@vilain.net>
X-From: git-owner@vger.kernel.org Thu Apr 23 00:52:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LwlIT-0002yi-Cv
	for gcvg-git-2@gmane.org; Thu, 23 Apr 2009 00:52:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751291AbZDVWub convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 22 Apr 2009 18:50:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750960AbZDVWub
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Apr 2009 18:50:31 -0400
Received: from mail.gmx.net ([213.165.64.20]:47515 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750825AbZDVWua (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Apr 2009 18:50:30 -0400
Received: (qmail invoked by alias); 22 Apr 2009 22:50:28 -0000
Received: from i59F5A8F4.versanet.de (EHLO atjola.local) [89.245.168.244]
  by mail.gmx.net (mp068) with SMTP; 23 Apr 2009 00:50:28 +0200
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX1+9Rg88o+e9otixH1wMj96LUkHmYaOSfThfLJxAiE
	A8GSnqyBFJ1g89
Content-Disposition: inline
In-Reply-To: <49EF93CA.20207@vilain.net>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.58
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117277>

On 2009.04.23 10:01:46 +1200, Sam Vilain wrote:
> Nicolas Pitre wrote:
> >> Now that the GSoC projects have been announced I can give you the =
good
> >> news that one of our two projects is to optimise this stage in
> >> git-daemon; I'm hoping we can get it down to being almost as cheap=
 as
> >> the workaround you described in your post. I'll certainly be using=
 your
> >> repository as a test case :-)
> >
> > Please keep me in the loop as much as possible. I'd prefer we're no=
t in
> > disagreement over the implementation only after final patches are p=
osted
> > to the list.
>=20
> Thanks Nico, given your close working knowledge of the pack-objects
> code this will be very much appreciated. Perhaps you can first help
> out by telling me what you have to say about moving object enumeratio=
n
> from upload-pack to pack-objects?

Here's a bit about that:
http://article.gmane.org/gmane.comp.version-control.git/116032

Note that my RSS measurement should be invalid by now. Linus's
patches(*) should have improved the memory usage for that scenario by
quite a bit, since we used to keep a lot of the stuff that the revision
enumeration required in memory, even after that processed finished,
which should no longer be the case IIRC. And the peak memory usage for
that process was also improved on its own, as the whole buffering is
gone.

Bj=F6rn

(*) These commits:
8d2dfc49b1     process_{tree,blob}: show objects without buffering
cf2ab916af     show_object(): push path_name() call further down
213152688c     process_{tree,blob}: Remove useless xstrdup calls
