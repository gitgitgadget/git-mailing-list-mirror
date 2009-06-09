From: Pierre Habouzit <madcoder@madism.org>
Subject: Re: [PATCH] show-branch: fix segfault when showbranch.default
	exists
Date: Tue, 9 Jun 2009 19:23:02 +0200
Message-ID: <20090609172302.GH9993@laphroaig.corp>
References: <7vfxe9udln.fsf@alter.siamese.dyndns.org> <4A2E0C88.70805@gmail.com> <20090609080612.GG9993@laphroaig.corp> <7viqj5nzgz.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Stephen Boyd <bebarino@gmail.com>, git@vger.kernel.org,
	Pierre Habouzit <madcoder@debian.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 09 19:23:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ME52Z-0004Hf-8n
	for gcvg-git-2@gmane.org; Tue, 09 Jun 2009 19:23:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753747AbZFIRXG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 9 Jun 2009 13:23:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754219AbZFIRXF
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Jun 2009 13:23:05 -0400
Received: from pan.madism.org ([88.191.52.104]:43905 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752749AbZFIRXE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jun 2009 13:23:04 -0400
Received: from laphroaig.corp (def92-12-88-177-251-208.fbx.proxad.net [88.177.251.208])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(Client did not present a certificate)
	by hermes.madism.org (Postfix) with ESMTPSA id 40EED3DCFE;
	Tue,  9 Jun 2009 19:23:05 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7viqj5nzgz.fsf@alter.siamese.dyndns.org>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<
	;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u
	*\.dJ8G!N&=EvlD
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121192>

On Tue, Jun 09, 2009 at 09:28:28AM -0700, Junio C Hamano wrote:
> Pierre Habouzit <madcoder@madism.org> writes:
>=20
> > On Tue, Jun 09, 2009 at 12:17:28AM -0700, Stephen Boyd wrote:
> >> Junio C Hamano wrote:
> >> > I am not sure if this is a bug in parse_options(), or a bug in t=
he caller,
> >> > and tonight I do not have enough concentration to figure out whi=
ch.  In
> >> > any case, this patch works the issue around.
> >>=20
> >> I am low on concentration tonight as well, but this looks right to=
 me.
> >> Parse options is expecting the regular old argv and argc. I overlo=
oked
> >> this code path during the conversion (though I remember figuring o=
ut
> >> what this path was doing). Faking the argv and argc a little more
> >> accurately, like you do, should work fine.
> >
> > yes, that's it.
>=20
> Wait a minute, please.
>=20
> Why is parse_options() allowed to clobber argv[0] in parse_options_en=
d()
> in the first place?
>=20
> I think the memmove() is there to allow the caller to find the remain=
ing
> arguments after the library parsed out the options in argv[], but wou=
ldn't
> the caller be expecting to inspect argv[] starting from position 1?
>=20
> In other words, anything moved to the position of original argv[0] wo=
uld
> be lost, and the problem I stumbled upon was exactly that (it trigger=
ed
> because the location of argv[0] was invalid and parse_options_end() w=
rote
> into it).

it does because it supposes that the command is there, and that when I
ported the old parsing stuff it's what it was doing.

=46WIW I believe it's a misfeature.

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@d=
ebian.org
OOO                                                http://www.madism.or=
g
