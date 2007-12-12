From: Kristian =?ISO-8859-1?Q?H=F8gsberg?= <krh@redhat.com>
Subject: Re: [PATCH] builtin-clone: Implement git clone as a builtin
	command.
Date: Wed, 12 Dec 2007 10:24:23 -0500
Message-ID: <1197473063.9269.20.camel@hinata.boston.redhat.com>
References: <20071211195712.GA3865@bitplanet.net>
	 <Pine.LNX.4.64.0712111549490.5349@iabervon.org>
	 <1197416286.7552.4.camel@hinata.boston.redhat.com>
	 <7vejdsbo7d.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 12 16:27:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J2TUY-0001at-TE
	for gcvg-git-2@gmane.org; Wed, 12 Dec 2007 16:27:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756288AbXLLP1A convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 12 Dec 2007 10:27:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755965AbXLLP07
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Dec 2007 10:26:59 -0500
Received: from mx1.redhat.com ([66.187.233.31]:51862 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754790AbXLLP07 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Dec 2007 10:26:59 -0500
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.8/8.13.1) with ESMTP id lBCFOVeH009098;
	Wed, 12 Dec 2007 10:24:31 -0500
Received: from pobox.corp.redhat.com (pobox.corp.redhat.com [10.11.255.20])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id lBCFOUng006866;
	Wed, 12 Dec 2007 10:24:30 -0500
Received: from [192.168.1.100] (dhcp83-9.boston.redhat.com [172.16.83.9])
	by pobox.corp.redhat.com (8.13.1/8.13.1) with ESMTP id lBCFOSCa003996;
	Wed, 12 Dec 2007 10:24:28 -0500
In-Reply-To: <7vejdsbo7d.fsf@gitster.siamese.dyndns.org>
X-Mailer: Evolution 2.11.90 (2.11.90-4.fc8) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68049>


On Tue, 2007-12-11 at 19:12 -0800, Junio C Hamano wrote:
> Kristian H=C3=B8gsberg <krh@redhat.com> writes:
>=20
> > On Tue, 2007-12-11 at 15:59 -0500, Daniel Barkalow wrote:
> >> On Tue, 11 Dec 2007, Kristian H=C3=B8gsberg wrote:
> >>=20
> >> > Ok, don't flame me, I know this isn't appropriate at the moment =
with
> >> > stabilization for 1.5.4 going on, but I just wanted to post a he=
ads up
> >> > on this work to avoid duplicate effort.  It's one big patch at t=
his point
> >> > and I haven't even run the test suite yet, but that will change.
> >>=20
> >> Is that why you misspelled Junio's email address? :)=20
> >
> > Hehe, yeah, do not mess with maintainers in release mode :)
>=20
> Actually this is a bit unfortunate, regardless of everybody being in
> release and bugfix only mode.

Well, let's just pick up the discussion in January, I have a lot of
other stuff I'm trying to do anyway :)

> I was hoping that the evolution path for clone would be to first make=
 it
> a very thin wrapper around:
>=20
> 	git init
>         git remote add -f
>         git checkout
>=20
> sequence.

However, let me just say that the patch I sent is almost just that.
Part of the patch refactors init-db to be useful from clone, part of th=
e
code is option parsing and figuring out the git dir, work tree.  Also,
the part of the patch that does 'git checkout' is approximately 20 line=
s
that end up calling unpack_tre() and then write_cache().  The bulk of
the work here is really just builtin boilerplate code, option parsing
and the builtin-clone tasks you describe below (HEAD discovery, --share=
d
and --reference optimizations and the local hardlink optimization - all
these are in the 500 line builtin-clone.c I sent).

And maybe it makes sense to use builtin-remote for the remote add -f
part, but the fetch part of the patch is 10 lines to set up for
fetch_pack().  So while I do agree that it makes sense to keep remotes
handling in one place, doing the fetch_pack() in builtin-clone.c doesn'=
t
seem like a big duplication of code.  And either way, I agree with
Dscho, once we have either builtin-clone or builtin-fetch it's easier t=
o
share code and refactor, and there is not a strong reason to do one or
the other first.

cheers,
Kristian
