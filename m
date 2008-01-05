From: Matthias Kestenholz <mk@spinlock.ch>
Subject: Re: [PATCH/resend] add--interactive: allow diff colors without
	interactive colors
Date: Sat, 05 Jan 2008 15:10:26 +0100
Message-ID: <1199542226.6209.34.camel@futex>
References: <20080104083521.GB3354@coredump.intra.peff.net>
	 <7v3atdi0na.fsf@gitster.siamese.dyndns.org> <1199530684.6209.6.camel@futex>
	 <7vd4sga5n6.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Jakub Narebski <jnareb@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 05 15:11:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JB9jr-0005QE-Dm
	for gcvg-git-2@gmane.org; Sat, 05 Jan 2008 15:11:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752651AbYAEOKb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 5 Jan 2008 09:10:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752606AbYAEOKb
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Jan 2008 09:10:31 -0500
Received: from fg-out-1718.google.com ([72.14.220.158]:19215 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752605AbYAEOKa (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Jan 2008 09:10:30 -0500
Received: by fg-out-1718.google.com with SMTP id e21so3832884fga.17
        for <git@vger.kernel.org>; Sat, 05 Jan 2008 06:10:29 -0800 (PST)
Received: by 10.86.80.5 with SMTP id d5mr17945205fgb.20.1199542228795;
        Sat, 05 Jan 2008 06:10:28 -0800 (PST)
Received: from ?192.168.1.8? ( [83.78.66.175])
        by mx.google.com with ESMTPS id e20sm20190147fga.1.2008.01.05.06.10.27
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 05 Jan 2008 06:10:28 -0800 (PST)
In-Reply-To: <7vd4sga5n6.fsf@gitster.siamese.dyndns.org>
X-Mailer: Evolution 2.21.4 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69669>

On Sat, 2008-01-05 at 03:11 -0800, Junio C Hamano wrote:
> Matthias Kestenholz <mk@spinlock.ch> writes:
>=20
> > I managed to throw something together which works and passes all
> > the tests. Documentation included. :-)
>=20
> Is it because we do not usually test colours and the tests run
> without terminals to make sure "color.* =3D auto" does not kick
> in?
>=20

Probably, yes. I've to confess that I have not thought too much about
how color output could be tested.=20

> > I would be happy for feedback and suggestions.
>=20
>  * Shouldn't "color.git =3D true" with "color.diff =3D false" mean
>    "I want colour for everything by default but I do not want to
>    see coloured diff"?
>=20

This works with the new patch below.

>  * git_foo_config() callback from git_config() returns 0 on
>    success; the API change needs to be documented to warn
>    others.
>=20

I've changed the config reader. It behaves like the others now.

> I haven't studied your patch very deeply so I may have misread
> what you tried to do, regarding the first point, though.

Still missing are the updates for git add -i and git svn.


I have added a new function git_color_config() which should be called
after git_config() has finished its work. The function needs to run whe=
n
all config reading has been done, because otherwise the color setup
would be sensitive to the order in which the variables are placed in th=
e
config file, which I'd rather avoid.

I've also unified the colorbool variables, because otherwise the
individual colorbool variables would need to be exported into other C
files, and I don't see the point of multiple colorbools anyway.

The patch got somewhat big, therefore I've splitted it up into several
pieces:

[PATCH 1/4] Add infrastructure for a single color config variable
=EF=BB=BF[PATCH 2/4] git branch: Use color configuration infrastructure
=EF=BB=BF[PATCH 3/4] status and commit: Use color configuration infrast=
ructure
=EF=BB=BF[PATCH 4/4] diff and log: Use color configuration infrastructu=
re
