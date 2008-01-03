From: Bruno Cesar Ribas <ribas@c3sl.ufpr.br>
Subject: Re: Git and securing a repository
Date: Thu, 3 Jan 2008 02:30:09 -0200
Message-ID: <20080103043009.GA365@c3sl.ufpr.br>
References: <477B39B5.5010107@advancedsl.com.ar> <31e679430801012234x20bbebe7vb496a338bf2699d5@mail.gmail.com> <477B6199.6070601@advancedsl.com.ar> <ee77f5c20801020126n1776d625ya6928c2e4bfdf497@mail.gmail.com> <477B69ED.3090107@advancedsl.com.ar> <m3ir2co5s4.fsf@roke.D-201> <20080103035838.GA24004@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jakub Narebski <jnareb@gmail.com>,
	Gonzalo =?utf-8?Q?Garramu=C3=B1o?= <ggarra@advancedsl.com.ar>,
	David Symonds <dsymonds@gmail.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Jan 03 05:56:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JAI8V-0006Zm-Hk
	for gcvg-git-2@gmane.org; Thu, 03 Jan 2008 05:56:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755605AbYACE42 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 2 Jan 2008 23:56:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755440AbYACE42
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Jan 2008 23:56:28 -0500
Received: from mx.inf.ufpr.br ([200.17.202.3]:53580 "EHLO urquell.c3sl.ufpr.br"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755433AbYACE42 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jan 2008 23:56:28 -0500
X-Greylist: delayed 1572 seconds by postgrey-1.27 at vger.kernel.org; Wed, 02 Jan 2008 23:56:27 EST
Received: from localhost (unknown [201.21.136.136])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: ribas)
	by urquell.c3sl.ufpr.br (Postfix) with ESMTP id 58BE3301B300;
	Thu,  3 Jan 2008 02:30:10 -0200 (BRST)
Content-Disposition: inline
In-Reply-To: <20080103035838.GA24004@spearce.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69510>

I lost ohter mails, so replying here =3D)

I wrote sometime ago i wrote[1] a bunch of BASH scripts to manage SSH_A=
CL and "internal"
plugin is to manage GIT repositories.=20
It is simple and you can grant access to a user for R or W. And there i=
s NO
need to create more users just a "git" user is nice.

I'm re-writing it to become more flexible about configuration and to ad=
d more
plugins.

We are using it at C3SL[2] to manage our projects and Write permissions=
 are
set because we don't want some developers pushing to anothers projects.

bruno

[1]http://www.inf.ufpr.br/ribas/ssh_acl/
[2]http://www.c3sl.ufpr.br
On Wed, Jan 02, 2008 at 10:58:38PM -0500, Shawn O. Pearce wrote:
> Jakub Narebski <jnareb@gmail.com> wrote:
> > Gonzalo Garramu=C3=B1o <ggarra@advancedsl.com.ar> writes:
> > > David Symonds wrote:
> > >>
> > >> You can do arbitrarily-fine-grained authentication via the
> > >> pre-receive hook.
> > >=20
> > > Can you provide some more info?  Looking at the kernel.org git do=
cs,
> > > the pre-receive hook seems very limited as no parameters are allo=
wed.
> > > So I'm not sure how an authentication system could be created.
>=20
> If you read the documentation carefully you will note that the
> pre-receive hook receives input on stdin; 1 line of data per ref
> that is being pushed with the old/new SHA-1 values and the ref
> name.  The hook exits 0 to allow all changes to take place and
> can exit > 0 to abort and disallow all updates.
>=20
> This is a "batch" form of the update hook.
>=20
> > > It also seems to be a push hook only (not invoked on pulls).
> >=20
> > Some of read-only (fetch only) access protocols do not support
> > authentication: http, ftp, rsync, git. Authentication is provided o=
nly
> > for access via ssh and for push via https (WebDAV).
>=20
> Authentication could be supported for http, ftp, or ssh based fetch,
> but there you are relying on the server that provides access to do
> the authentication and authorization for you; typically that will
> boil down to UNIX filesystem read permission.  Though with HTTP
> and a fancy Apache config it doesn't have to be.
> =20
> > There is example update hook in contrib/hooks, named update-paranoi=
d,
> > which could be base of what you want. Note that you probably rather
> > use newer pre-receive hook instead of older update hook.
>=20
> update-paranoid uses the update hook rather than pre-receive to
> allow it to allow/deny on a per-ref basis.  One of the flaws of
> the pre-receive hook "API" is it is an all-or-nothing proposition.
>=20
> So by using the "older" update hook update-paranoid can make its
> decision on a per-ref basis and allow some refs to change in this
> push but abort/deny others.  I find that useful but not everyone
> might.
> =20
> > AFAIK both update and pre-receive hooks are invoked also on fetch..=
=2E
> > but I might be mistaken.
>=20
> No, they are *not* invoked on fetch.  Currently no hooks execute
> during fetch; either on the server *or* on the client side of
> the connection.
>=20
> --=20
> Shawn.
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--=20
Bruno Ribas - ribas@c3sl.ufpr.br
http://web.inf.ufpr.br/ribas
C3SL: http://www.c3sl.ufpr.br=20
