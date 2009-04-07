From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: Performance issue: initial git clone causes massive repack
Date: Tue, 7 Apr 2009 16:21:47 +0200
Message-ID: <20090407142147.GA4413@atjola.homenet>
References: <20090405T001239Z@curie.orbis-terrarum.net> <20090405035453.GB12927@vidovic> <20090405070412.GB869@curie-int> <20090405190213.GA12929@vidovic> <alpine.DEB.1.10.0904051419490.6245@asgard.lang.hm> <fabb9a1e0904051436i1dc9c1bdhe86a23e470c756f9@mail.gmail.com> <alpine.LFD.2.00.0904052315210.6741@xanadu.home> <20090407081019.GK20356@atjola.homenet> <m3tz5023rq.fsf@localhost.localdomain> <alpine.LFD.2.00.0904070903020.6741@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jakub Narebski <jnareb@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>, david@lang.hm,
	Junio C Hamano <gitster@pobox.com>,
	Nicolas Sebrecht <nicolas.s-dev@laposte.net>,
	"Robin H. Johnson" <robbat2@gentoo.org>,
	Git Mailing List <git@vger.kernel.org>
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Tue Apr 07 16:26:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LrCD0-000504-Ro
	for gcvg-git-2@gmane.org; Tue, 07 Apr 2009 16:23:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754060AbZDGOVx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 7 Apr 2009 10:21:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754003AbZDGOVw
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Apr 2009 10:21:52 -0400
Received: from mail.gmx.net ([213.165.64.20]:58284 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753727AbZDGOVw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Apr 2009 10:21:52 -0400
Received: (qmail invoked by alias); 07 Apr 2009 14:21:49 -0000
Received: from i59F5A3DA.versanet.de (EHLO atjola.local) [89.245.163.218]
  by mail.gmx.net (mp025) with SMTP; 07 Apr 2009 16:21:49 +0200
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX1/AWKpcQOHAFBXFiNiW0lm0KwBsspU6vC7E3JLO99
	uGE2L3TB7gLlWO
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.0904070903020.6741@xanadu.home>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.57
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115959>

On 2009.04.07 09:13:45 -0400, Nicolas Pitre wrote:
> On Tue, 7 Apr 2009, Jakub Narebski wrote:
>=20
> > Bj=F6rn Steinbrink <B.Steinbrink@gmx.de> writes:
> > > On 2009.04.05 23:24:27 -0400, Nicolas Pitre wrote:
> > > > On Sun, 5 Apr 2009, Sverre Rabbelier wrote:
> > > > >=20
> > > > > I agree here, we should either say "look, we don't really sup=
port big
> > > > > repositories because [explanation here], unless you [workarou=
nds
> > > > > here]" OR we should work to improve the support we do have. O=
f course,
> > > > > the latter option does not magically create developer time to=
 work on
> > > > > that, but if we do go that way we should at least tell people=
 that we
> > > > > are aware of the problems and that it's on the global TODO li=
st (not
> > > > > necessarily on anyone's personal TODO list though).
> > > >=20
> > > > For the record... I at least am aware of the problem and it is =
indeed on=20
> > > > my personal git todo list.  Not that I have a clear solution ye=
t (I've=20
> > > > been pondering on some git packing issues for almost 4 years no=
w).
> > > >=20
> > > > Still, in this particular case, the problem appears to be uncle=
ar to me,=20
> > > > like "this shouldn't be so bad".
> > >=20
> > > It's not primarily pack-objects, I think. It's the rev-list that'=
s run
> > > by upload-pack.  Running "git rev-list --objects --all" on that r=
epo
> > > eats about 2G RSS, easily killing the system's cache on a small b=
ox,
> > > leading to swapping and a painful time reading the packfile conte=
nts
> > > afterwards to send them to the client.
> >=20
> > Than I think that "packfile caching" GSoC project (which is IIRC
> > "object enumeration caching", or at least includes it) should help
> > here.
>=20
> NO!
>=20
> Please people stop being so creative with all sort of ways to simply=20
> avoid the real issue and focussing on a real fix.  Git has not become=
=20
> what it is today by the accumulation of workarounds and ignorance of=20
> fundamental issues.
>=20
> Having git-rev-list consume about 2G RSS for the enumeration of 4M=20
> objects is simply inacceptable, period.  This is the equivalent of 50=
0=20
> bytes per object pinned in memory on average, just for listing object=
,=20
> which is completely silly. We ought to do better than that.

Ah, crap, I might have been fooled by "ps aux", top actually shows abou=
t
1.3G being shared, likely the mmapped pack files. And that will be
reused, assuming the box has enough memory to keep all that stuff.

But that's still 700MB or about 150 bytes per object on average.

A "struct tree" is 40 bytes here, adding the average path length (19 in
this repo) that's 59 byte, leaving about 90 bytes of "overhead" per
object, as end the end we seem to care only about the sha1 and the path
name.

And in the upload-pack case, there's also pack-objects running
concurrently, already going up to 950M RSS/100M shared _while_ the
rev-list is still running. So that's 3G of memory usage (2G if you
ignore the shared stuff) before the "Compressing objects" part even
starts. And of course, pack-objects will apparently start to mmap the
pack files only after the rev-list finished, so a "smart" OS might have
removed a lot of the mmapped stuff from memory again, causing it to be
re-read. :-/

Bj=F6rn
