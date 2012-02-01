From: Jeff King <peff@peff.net>
Subject: Re: General support for ! in git-config values
Date: Wed, 1 Feb 2012 13:40:20 -0500
Message-ID: <20120201184020.GA29374@sigill.intra.peff.net>
References: <CACBZZX6U+1Fmdaz2ikbbc6zUyF=pMGQOqUGVOWCkUFBUkovCBw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 01 19:40:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rsf6b-0007oD-2r
	for gcvg-git-2@plane.gmane.org; Wed, 01 Feb 2012 19:40:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753377Ab2BASkX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 1 Feb 2012 13:40:23 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:52307
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753353Ab2BASkW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Feb 2012 13:40:22 -0500
Received: (qmail 11385 invoked by uid 107); 1 Feb 2012 18:47:26 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 01 Feb 2012 13:47:26 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 01 Feb 2012 13:40:20 -0500
Content-Disposition: inline
In-Reply-To: <CACBZZX6U+1Fmdaz2ikbbc6zUyF=pMGQOqUGVOWCkUFBUkovCBw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189530>

On Wed, Feb 01, 2012 at 06:33:47PM +0100, =C3=86var Arnfj=C3=B6r=C3=B0 =
Bjarmason wrote:

> For a program I'm working on (git-deploy) I'd like to have this as a
> general facility, i.e. users can specify either:
>=20
>     foo.bar =3D value
>=20
> Or:
>=20
>     foo.bar =3D !cat /some/path
>=20
> I'm wondering why git-config doesn't do this already, if there's no
> reason in particular I can just patch it in, either as a new option:
>=20
>     git config --with-exec --get foo.bar

I'm not clear on what you want --with-exec to do. By default, config
values are strings. I would expect the "!" to be a special marker that
the caller would recognize in the string, and then act appropriately.

So if I were implementing git aliases in the shell, the code would look
like:

  v=3D$(git config alias.$alias)
  case "$v" in
  "")
          die "no such alias: $alias" ;;
  "!*)
          cmd=3D"${v#!}" ;;
  *)
          cmd=3D"git $v" ;;
  esac
  eval "$cmd"

I.e., everything pertaining to "!" happens after we get the config
string. So what is it that you want "git config --with-exec" to do?

-Peff
