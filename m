From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] daemon: accept "git program" as well
Date: Thu, 26 Jun 2008 16:42:03 -0700
Message-ID: <7vd4m3ojas.fsf@gitster.siamese.dyndns.org>
References: <20080625034538.GW11793@spearce.org>
 <7vk5ge6soc.fsf@gitster.siamese.dyndns.org>
 <20080625044409.GE11793@spearce.org>
 <7v8wwu6qxr.fsf@gitster.siamese.dyndns.org>
 <7v4p7i6qs1.fsf@gitster.siamese.dyndns.org>
 <7vy74u5bkk.fsf@gitster.siamese.dyndns.org>
 <20080625053848.GJ11793@spearce.org>
 <7v4p7hxhbd.fsf@gitster.siamese.dyndns.org>
 <20080625230228.GR11793@spearce.org>
 <7vmyl9w0y1.fsf@gitster.siamese.dyndns.org>
 <20080626082013.GT22344@eagain.net> <4864286C.80609@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Tommi Virtanen <tv@eagain.net>,
	Git Mailing List <git@vger.kernel.org>,
	=?iso-2022-jp?B?GyRCJDckaSQkJDckSiRKJDMbKEI=?= 
	<nanako3@lavabit.com>, Miklos Vajna <vmiklos@frugalware.org>,
	pclouds@gmail.com,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Pieter de Bie <pdebie@ai.rug.nl>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Olivier Marin <dkr+ml.git@free.fr>
X-From: git-owner@vger.kernel.org Fri Jun 27 01:43:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KC17c-0003sw-Vn
	for gcvg-git-2@gmane.org; Fri, 27 Jun 2008 01:43:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753247AbYFZXm3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 26 Jun 2008 19:42:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753213AbYFZXm3
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Jun 2008 19:42:29 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:55343 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752748AbYFZXm2 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 26 Jun 2008 19:42:28 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 33BBB2242A;
	Thu, 26 Jun 2008 19:42:25 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id A75F022429; Thu, 26 Jun 2008 19:42:12 -0400 (EDT)
In-Reply-To: <4864286C.80609@free.fr> (Olivier Marin's message of "Fri, 27
 Jun 2008 01:38:20 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 878B3110-43D9-11DD-B7E4-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86505>

Olivier Marin <dkr+ml.git@free.fr> writes:

> Hi,
>
> Tommi Virtanen a =C3=A9crit :
>> On Wed, Jun 25, 2008 at 04:26:46PM -0700, Junio C Hamano wrote:
>>>
>>> In gitosis/serve.py, there are COMMANDS_READONLY and COMMANDS_WRITE=
 array
>>> that holds 'git-upload-pack' and 'git-receive-pack' commands, and t=
hey are
>>> compared with user commands after doing:
>>=20
>> Yeah, that's pretty much a trivial change, doing it now to future-pr=
oof
>> gitosis.
>>=20
>
> This just happened to me with a dashless client, so I tried your patc=
h but it
> does not work. The problem comes from git-shell that do not support d=
ashless
> argument, yet (IOW: git shell -c 'git upload-pack ...' give an error)=
=2E
>
> The following patch on top of yours fix the problem. The s/git-shell/=
git shell/
> part is not really necessary, but why not?
>
> diff --git a/gitosis/serve.py b/gitosis/serve.py
> index 9a91fcb..5aac355 100644
> --- a/gitosis/serve.py
> +++ b/gitosis/serve.py
> @@ -21,12 +21,10 @@ ALLOW_RE =3D re.compile("^'/*(?P<path>[a-zA-Z0-9]=
[a-zA-Z0-9@._-]*(/[a-zA-Z0-9][a-z
> =20
>  COMMANDS_READONLY =3D [
>      'git-upload-pack',
> -    'git upload-pack',
>      ]
> =20
>  COMMANDS_WRITE =3D [
>      'git-receive-pack',
> -    'git receive-pack',
>      ]
> =20
>  class ServingError(Exception):
> @@ -75,7 +73,7 @@ def serve(
>              # all known "git foo" commands take one argument; improv=
e
>              # if/when needed
>              raise UnknownCommandError()
> -        verb =3D '%s %s' % (verb, subverb)
> +        verb =3D '%s-%s' % (verb, subverb)
> =20
>      if (verb not in COMMANDS_WRITE
>          and verb not in COMMANDS_READONLY):
> @@ -201,6 +199,6 @@ class Main(app.App):
>              sys.exit(1)
> =20
>          main_log.debug('Serving %s', newcmd)
> -        os.execvp('git-shell', ['git-shell', '-c', newcmd])
> -        main_log.error('Cannot execute git-shell.')
> +        os.execvp('git', ['git', 'shell', '-c', newcmd])
> +        main_log.error('Cannot execute git.')
>          sys.exit(1)

Hmm, Tommi, if you are doing command sanitizing yourself, is there a
reason to still invoke the command via git-shell?
