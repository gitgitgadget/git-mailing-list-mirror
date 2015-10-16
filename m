From: Tobias Klauser <tklauser@distanz.ch>
Subject: Re: [PATCH 2/3] stripspace: Implement --count-lines option
Date: Fri, 16 Oct 2015 10:40:19 +0200
Message-ID: <20151016084018.GO11304@distanz.ch>
References: <1444911524-14504-1-git-send-email-tklauser@distanz.ch>
 <1444911524-14504-3-git-send-email-tklauser@distanz.ch>
 <vpqzizkysyh.fsf@grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Fri Oct 16 10:40:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zn0Z0-0000ML-5a
	for gcvg-git-2@plane.gmane.org; Fri, 16 Oct 2015 10:40:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754076AbbJPIkY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 16 Oct 2015 04:40:24 -0400
Received: from sym2.noone.org ([178.63.92.236]:36596 "EHLO sym2.noone.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752771AbbJPIkX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Oct 2015 04:40:23 -0400
Received: by sym2.noone.org (Postfix, from userid 1002)
	id 3ncgsc4KMWzQWh1; Fri, 16 Oct 2015 10:40:20 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <vpqzizkysyh.fsf@grenoble-inp.fr>
X-Editor: Vi IMproved 7.3
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279739>

On 2015-10-15 at 18:52:54 +0200, Matthieu Moy <Matthieu.Moy@grenoble-in=
p.fr> wrote:
> Tobias Klauser <tklauser@distanz.ch> writes:
> > +static const char * const usage_msg[] =3D {
>=20
> Stick the * to usage_msg please.

Just noticed while looking at how other sub-commands define this, the v=
ast
majority use "const char * const" and not "const char const *".

Also it would change the meaning. The following wouldn't produce a
compiler warning:

	static const char const *usage_msg[] =3D { ... };
	...
	usage_msg[0] =3D "Foobar"

while

	static const char * const usage_msg[] =3D { ... };
	...
	usage_msg[0] =3D "Foobar"

would produce one:

	builtin/stripspace.c:36:2: error: assignment of read-only location =E2=
=80=98usage_msg[0]=E2=80=99

Even though I don't expect anyone to modify usage_msg at runtime I thin=
k
it'd be better to stick with the current version.
