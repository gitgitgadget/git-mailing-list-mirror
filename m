From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC] [PATCH 0/5] Implement 'prior' commit object links (and
Date: Sat, 29 Apr 2006 20:07:36 +0200
Organization: At home
Message-ID: <e309vq$m2r$1@sea.gmane.org>
References: <20060429165151.2570.qmail@science.horizon.com> <Pine.LNX.4.64.0604291006270.3701@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Sat Apr 29 20:07:41 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FZtqw-00028P-JX
	for gcvg-git@gmane.org; Sat, 29 Apr 2006 20:07:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750772AbWD2SHW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sat, 29 Apr 2006 14:07:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750771AbWD2SHW
	(ORCPT <rfc822;git-outgoing>); Sat, 29 Apr 2006 14:07:22 -0400
Received: from main.gmane.org ([80.91.229.2]:17318 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1750772AbWD2SHU (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 29 Apr 2006 14:07:20 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1FZtqS-00023a-Nf
	for git@vger.kernel.org; Sat, 29 Apr 2006 20:07:05 +0200
Received: from 193.0.122.19 ([193.0.122.19])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 29 Apr 2006 20:07:04 +0200
Received: from jnareb by 193.0.122.19 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 29 Apr 2006 20:07:04 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 193.0.122.19
User-Agent: KNode/0.7.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19312>

Linus Torvalds wrote:

> =A0-=A0Case=A01:=A0the
>=20
> =A0=A0=A0=A0=A0=A0=A0=A0merge-base <sha1>
[...]
> =A0-=A0Case=A02:=A0the
>=20
> =A0=A0=A0=A0=A0=A0=A0=A0note merge-base <sha1>
[...]
> =A0-=A0Case=A03:=A0the
>=20
> =A0=A0=A0=A0=A0=A0=A0=A0link <sha1> merge-base
[...]

> In short, the difference between three headers that on the face of it=
 say
> exactly the same thing: "merge-base <sha1>", "note merge-base <sha1>"=
, and
> "link merge-base <sha1>" is not that they have different syntax (hey,=
 even
> the syntax itself is almost identical), but exactly the fact that the=
y
> have different implications and _meaning_.
>=20
> Two of the three have no unintended consequences. One ("note") has no
> technical "consequences" at _all_, by definition. The other "merge-ba=
se"
> has no technical "unintended" at all, because it's throught through, =
and
> has been fully defined.
>=20
> The third? "unintended consequences". It doesn't have a clear definit=
ion
> ("It's cool. You can use it for any link you want"). So pretty much B=
Y
> DESIGN, it's set up so that you don't know what the consequences of i=
t
> will be for a project.
>=20
> And that's why "case 3" it's bad. Even though it looks very much like=
 the
> two other ones.

IF (and that is big if) git commit header will be extended to have some
extra "link" (enforcing connectivity) headers, like proposed "bind" for
subprojects, "prev" for pu-like union branches, "merge-base" for merges=
,
there would be repeated work on enforcing connectivity. Hence generic
"link" header (formerly "related") proposal. Having fsck report broken
links (or not), having purge removing commits (objects) reachable only =
via
"link" headers, having pull download commits via "link" headers... have=
 I
forgot anything? It _seems_ that this part is common, and does not depe=
nd
on semantics.

But with "links" (connectivity headers) there always would be some othe=
r
consequences. For example info/grafts deals for now only with commit
parents, and extending the format could be difficult.

And of course if we want connectivity, this is for some reason, so the
"link" has some other consequences, for example "prev" and "merge-base"=
 for
merging, "bind" for checkout, merge (but differently), etc.


I think that if it is 'helper' information (i.e. information which is
helpful, but we can do without it) and of no real importance to user th=
en
use "note". If it is of importance to user (for example "cherrypick" or
"reverted") and of use to git, then repeat such info in "note" header t=
o
avoid relying on parsing free-form part aka. commit comment. If
connectivity is needed... hmmm...

--=20
Jakub Narebski
Warsaw, Poland
