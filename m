From: =?utf-8?B?T25kxZllaiBCw61sa2E=?= <neleai@seznam.cz>
Subject: Re: question about: Facebook makes Mercurial faster than Git
Date: Tue, 11 Mar 2014 15:23:25 +0100
Message-ID: <20140311142325.GB17336@domone.podge>
References: <531D8ED9.7040305@gmx.net>
 <alpine.DEB.2.02.1403100310080.25193@nftneq.ynat.uz>
 <20140310175102.GA17336@domone.podge>
 <alpine.DEB.2.02.1403101053120.20306@nftneq.ynat.uz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Dennis Luehring <dl.soluz@gmx.net>, git@vger.kernel.org
To: David Lang <david@lang.hm>
X-From: git-owner@vger.kernel.org Tue Mar 11 15:23:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WNNam-0007hM-3c
	for gcvg-git-2@plane.gmane.org; Tue, 11 Mar 2014 15:23:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752582AbaCKOXf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 11 Mar 2014 10:23:35 -0400
Received: from popelka.ms.mff.cuni.cz ([195.113.20.131]:35103 "EHLO
	popelka.ms.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751843AbaCKOXe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Mar 2014 10:23:34 -0400
Received: from domone.kolej.mff.cuni.cz (popelka.ms.mff.cuni.cz [195.113.20.131])
	by popelka.ms.mff.cuni.cz (Postfix) with ESMTPS id 8028056F47;
	Tue, 11 Mar 2014 15:23:26 +0100 (CET)
Received: by domone.kolej.mff.cuni.cz (Postfix, from userid 1000)
	id 585595F802; Tue, 11 Mar 2014 15:23:26 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.02.1403101053120.20306@nftneq.ynat.uz>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Virus-Scanned: clamav-milter 0.97.8 at popelka.ms.mff.cuni.cz
X-Virus-Status: Clean
X-Spam-Status: No, score=-1.9 required=5.0 tests=AWL,BAYES_00,FREEMAIL_FROM,
	UNPARSEABLE_RELAY autolearn=ham version=3.3.1
X-Spam-Checker-Version: SpamAssassin 3.3.1 (2010-03-16) on
	popelka.ms.mff.cuni.cz
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243866>

On Mon, Mar 10, 2014 at 10:56:51AM -0700, David Lang wrote:
> On Mon, 10 Mar 2014, Ond=C5=99ej B=C3=ADlka wrote:
>=20
> >On Mon, Mar 10, 2014 at 03:13:45AM -0700, David Lang wrote:
> >>On Mon, 10 Mar 2014, Dennis Luehring wrote:
> >>
> >>>according to these blog posts
> >>>
> >>>http://www.infoq.com/news/2014/01/facebook-scaling-hg
> >>>https://code.facebook.com/posts/218678814984400/scaling-mercurial-=
at-facebook/
> >>>
> >>>mercurial "can" be faster then git
> >>>
> >>>but i don't found any reply from the git community if it is a real=
 problem
> >>>or if there a ongoing (maybe git 2.0) changes to compete better in=
 this case
> >>
> >>As I understand this, the biggest part of what happened is that
> >>Facebook made a tweak to mercurial so that when it needs to know
> >>what files have changed in their massive tree, their version asks
> >>their special storage array, while git would have to look at it
> >>through the filesystem interface (by doing stat calls on the
> >>directories and files to see if anything has changed)
> >>
> >That is mostly a kernel problem. Long ago there was proposed patch t=
o
> >add a recursive mtime so you could check what subtrees changed. If
> >somebody ressurected that patch it would gave similar boost.
>=20
> btrfs could actually implement this efficiently, but for a lot of
> other filesysems this could be very expensive. The question is if it
> could be enough of a win to make it a good choice for people who are
> doing a heavy git workload as opposed to more generic uses.
>
Read next paragraph how do that efficiently, a directory update needs t=
o be done
only between application runs. Also there is no overhead when not used
(except if that makes headers bigger.)
=20
> there's also the issue of managed vs generated files, if you update
> the mtime all the way up the tree because a source file was compiled
> and a binary created, that will quickly defeat the value of the
> recursive mtime.
>
You could do marking on per-file basis. I am not sure if that is needed
as larger projects use makefiles to not recompile everything so its
probably recompiled because source at same directory changed. Also if
your compile time is five minutes a half second status would not make
much difference.

=20
>=20
> >There are two issues that need to be handled, first if you are conce=
rned
> >about one mtime change doing lot of updates a application needs to m=
ark
> >all directories it is interested on, when we do update we unmark
> >directory and by that we update each directory at most once per
> >application run.
> >
> >Second problem were hard links where probably a best course is keep =
list
> >of these and stat them separately.
