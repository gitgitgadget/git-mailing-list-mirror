From: Kristian =?ISO-8859-1?Q?H=F8gsberg?= <krh@redhat.com>
Subject: Re: [PATCH 1/2] Add strbuf_initf()
Date: Thu, 06 Mar 2008 13:18:59 -0500
Message-ID: <1204827539.10084.9.camel@gaara.boston.redhat.com>
References: <1204138503-6126-1-git-send-email-johannes.sixt@telecom.at>
	 <1204138503-6126-4-git-send-email-johannes.sixt@telecom.at>
	 <alpine.LSU.1.00.0802281159550.22527@racer.site>
	 <200803052221.12495.johannes.sixt@telecom.at>
	 <alpine.LSU.1.00.0803052317350.15786@racer.site>
	 <7vir00lski.fsf@gitster.siamese.dyndns.org>
	 <alpine.LSU.1.00.0803052327570.15786@racer.site>
	 <alpine.LSU.1.00.0803060212170.15786@racer.site>
	 <20080306063331.GA7325@glandium.org>
	 <3f4fd2640803060103i7fce7578ka40b5b4cc23a577f@mail.gmail.com>
	 <alpine.LSU.1.00.0803061153400.15786@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Reece Dunn <msclrhd@googlemail.com>, Mike Hommey <mh@glandium.org>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <johannes.sixt@telecom.at>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Mar 06 19:37:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JXKyB-0007S1-8A
	for gcvg-git-2@gmane.org; Thu, 06 Mar 2008 19:37:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753245AbYCFSgw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 6 Mar 2008 13:36:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753190AbYCFSgw
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Mar 2008 13:36:52 -0500
Received: from mx1.redhat.com ([66.187.233.31]:42793 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752008AbYCFSgu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Mar 2008 13:36:50 -0500
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id m26IJ5XQ032457;
	Thu, 6 Mar 2008 13:19:05 -0500
Received: from pobox.corp.redhat.com (pobox.corp.redhat.com [10.11.255.20])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id m26IJ5P2025868;
	Thu, 6 Mar 2008 13:19:05 -0500
Received: from [192.168.1.104] (dhcp83-9.boston.redhat.com [172.16.83.9])
	by pobox.corp.redhat.com (8.13.1/8.13.1) with ESMTP id m26IJ4L1002108;
	Thu, 6 Mar 2008 13:19:04 -0500
In-Reply-To: <alpine.LSU.1.00.0803061153400.15786@racer.site>
X-Mailer: Evolution 2.21.91 (2.21.91-2.fc9) 
X-Scanned-By: MIMEDefang 2.58 on 172.16.52.254
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76407>

On Thu, 2008-03-06 at 11:55 +0100, Johannes Schindelin wrote:
> Hi,
>=20
> On Thu, 6 Mar 2008, Reece Dunn wrote:
>=20
> > On 06/03/2008, Mike Hommey <mh@glandium.org> wrote:
> > > On Thu, Mar 06, 2008 at 02:14:43AM +0100, Johannes Schindelin wro=
te:
> > >  >
> > >  > The most common use of addf() was to init a strbuf and addf() =
right=20
> > >  > away. Since it is so common, it makes sense to have a function=
=20
> > >  > strbuf_initf() to wrap both calls into one.
> > >  >
> > >  > Unfortunately, C (and cpp) has no way to make this easy withou=
t=20
> > >  > code duplication, as we need to va_init() in strbuf_addf() pos=
sibly=20
> > >  > a few times.  So the code for addf() is copied.  Fortunately, =
the=20
> > >  > code is pretty short, so not too much had to be copied as-is.
> > >
> > >
> > > The problem with code duplication is not about code size, but mor=
e=20
> > > about not forgetting to fix bugs in all incarnations of the dupli=
cated=20
> > > code.
> > >
> > > Is it so ugly to use a macro ?
> >=20
> > Why not have a strbuf_vaddf and strbuf_vinitf that take a va_arg as=
 a=20
> > parameter. This would mean that you don't have code duplication, an=
d it=20
> > is flexible enough if you want to add more customisations in the fu=
ture.=20
> > No macro needed. This is what the printf/scanf family of functions =
do.
>=20
> The problem is that we have to restart va_list() if the buffer was to=
o=20
> small.

I think we've spent more time debating va_copy than it would take for
somebody to just lift the implementation and checks from something like
glib.  But the recent patch for vsnprintf[1] doesn't actually fix the
problem of reusing va_args in the general case; the va_list argument,
ap, is undefined after the vsnprintf() call, yet it calls it in a loop.
Just bite the bullet and pull in va_copy.  =EF=BB=BFOf course, I'm just=
 adding
to the debate here and not sending patches :/

> So your suggestion is out, unless you suggest to implement the whole=20
> printf mechanism... which I hope you're not.

It's not a terrible idea, honestly.  There are several mature vsnprintf
implementations out there under friendly licenses.  We could just stick
it in compat/.  It's the only way to do reliable, cross platform
vsnprintf, in my experience.  And the issue with %I64u vs %llu could be
handle by implementing both, as Wayne Davison suggests.

Kristian

[1] Message-Id: =EF=BB=BF200803051646.13343.michal.rokos@nextsoft.cz fr=
om Michal Rokos

