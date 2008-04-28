From: =?UTF-8?Q?J=C3=B6rg?= Sommer <joerg@alea.gnuu.de>
Subject: Re: [PATCH] Use perl instead of tac
Date: Mon, 28 Apr 2008 15:15:55 +0000 (UTC)
Message-ID: <slrng1bqhb.25r.joerg@alea.gnuu.de>
References: <8D73338C-4EC3-4078-8A34-51DAC1842C2B@silverinsanity.com>
 <20080427064250.GA5455@sigill.intra.peff.net>
 <739FA851-F7F5-4CF9-B384-25AA7022B0C2@silverinsanity.com>
 <slrng1be8l.25r.joerg@alea.gnuu.de> <86k5iib0g9.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 28 18:48:22 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JqWW9-0001PC-9F
	for gcvg-git-2@gmane.org; Mon, 28 Apr 2008 18:47:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936071AbYD1QrF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 Apr 2008 12:47:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936039AbYD1QrE
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Apr 2008 12:47:04 -0400
Received: from banki.eumelnet.de ([83.246.114.63]:1425 "EHLO uucp.gnuu.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S936010AbYD1QrB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2008 12:47:01 -0400
Received: by uucp.gnuu.de (Postfix, from userid 10)
	id EBDB3488068; Mon, 28 Apr 2008 18:46:59 +0200 (CEST)
Received: from news by alea.gnuu.de with local (Exim 4.63)
	(envelope-from <news@alea.gnuu.de>)
	id 1JqV5A-0004HR-1a
	for git@vger.kernel.org; Mon, 28 Apr 2008 17:15:56 +0200
Path: not-for-mail
Newsgroups: local.mailinglist.git
X-Trace: alea.gnuu.de 1209395755 16388 192.168.0.5 (28 Apr 2008 15:15:55 GMT)
X-Complaints-To: usenet@alea.gnuu.de
User-Agent: slrn/pre0.9.9-102 (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80562>

Hallo Randal,

Randal L. Schwartz <merlyn@stonehenge.com> wrote:
>>>>>> "J=C3=B6rg" =3D=3D J=C3=B6rg Sommer <joerg@alea.gnuu.de> writes:
>
> J=C3=B6rg> What about using a shell function and a *big* variable or =
an intermediate
> J=C3=B6rg> file?
>
> What makes you think that's any more faster or efficient than calling=
 Perl
> at this point?

Nothing. My intention was not the speed, but the dependency on Perl. Bu=
t
your are right. Except from the point that my suggestion is broken, it'=
s
*much* slower:

% time dash -c 'while IFS=3D read -r line; do rev=3D"$line
$rev"; done; printf "%s" "$rev"' < gitk-git/gitk-wish DN
dash -c  < gitk-git/gitk-wish > /dev/null 2> /dev/null  17,89s user 2,6=
8s system 96% cpu 21,352 total

% time tac < gitk-git/gitk-wish DN
tac < gitk-git/gitk-wish > /dev/null 2> /dev/null  0,01s user 0,01s sys=
tem 91% cpu 0,017 total

% time perl -e 'print reverse <>' < gitk-git/gitk-wish DN
perl -e 'print reverse <>' < gitk-git/gitk-wish > /dev/null 2> /dev/nul=
l  0,07s user 0,01s system 59% cpu 0,141 total

But I doubt this hurts, because we don't have such a big input.

% wc -l git.c
390 git.c

% time dash -c 'while IFS=3D read -r line; do rev=3D"$line
$rev"; done; printf "%s" "$rev"' < git.c DN
dash -c  < git.c > /dev/null 2> /dev/null  0,04s user 0,04s system 62% =
cpu 0,115 total

And what about something like this: 'tac || rev || perl =E2=80=A6'

Bye, J=C3=B6rg.
--=20
Was der Bauer nicht kennt, das frisst er nicht. W=C3=BCrde der St=C3=A4=
dter kennen,
was er frisst, er w=C3=BCrde umgehend Bauer werden.
                                                       Oliver Hassencam=
p
