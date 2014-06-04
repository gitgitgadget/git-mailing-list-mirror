From: John Keeping <john@keeping.me.uk>
Subject: Re: [PATCH] t9001: avoid not portable '\n' with sed
Date: Wed, 4 Jun 2014 19:46:04 +0100
Message-ID: <20140604184604.GC14457@serenity.lan>
References: <538ED6DF.5020505@web.de>
 <xmqqr434vaeh.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 04 20:46:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WsGCZ-0007dD-HQ
	for gcvg-git-2@plane.gmane.org; Wed, 04 Jun 2014 20:46:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751340AbaFDSqO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 4 Jun 2014 14:46:14 -0400
Received: from hyena.aluminati.org ([64.22.123.221]:44927 "EHLO
	hyena.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751209AbaFDSqO convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 4 Jun 2014 14:46:14 -0400
Received: from localhost (localhost [127.0.0.1])
	by hyena.aluminati.org (Postfix) with ESMTP id 659D42171F;
	Wed,  4 Jun 2014 19:46:13 +0100 (BST)
X-Quarantine-ID: <3JQ8FOQZhDqj>
X-Virus-Scanned: Debian amavisd-new at hyena.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -0.2
X-Spam-Level: 
X-Spam-Status: No, score=-0.2 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_50=0.8] autolearn=no
Received: from hyena.aluminati.org ([127.0.0.1])
	by localhost (hyena.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3JQ8FOQZhDqj; Wed,  4 Jun 2014 19:46:12 +0100 (BST)
Received: from pichi.aluminati.org (pichi.aluminati.org [10.0.16.50])
	by hyena.aluminati.org (Postfix) with ESMTP id 505DE1FC24;
	Wed,  4 Jun 2014 19:46:12 +0100 (BST)
Received: from localhost (localhost [127.0.0.1])
	by pichi.aluminati.org (Postfix) with ESMTP id 3F00B161E570;
	Wed,  4 Jun 2014 19:46:12 +0100 (BST)
X-Quarantine-ID: <Aq45pa4crqDH>
X-Virus-Scanned: Debian amavisd-new at aluminati.org
Received: from pichi.aluminati.org ([127.0.0.1])
	by localhost (pichi.aluminati.org [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id Aq45pa4crqDH; Wed,  4 Jun 2014 19:46:11 +0100 (BST)
Received: from serenity.lan (banza.aluminati.org [10.0.7.182])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by pichi.aluminati.org (Postfix) with ESMTPSA id DA259161E40D;
	Wed,  4 Jun 2014 19:46:06 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <xmqqr434vaeh.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250756>

On Wed, Jun 04, 2014 at 10:42:46AM -0700, Junio C Hamano wrote:
> Torsten B=F6gershausen <tboegi@web.de> writes:
>=20
> > t9001 used a '\n' in a sed expression to split one line into two li=
nes.
> > Some versions of sed simply ignore the '\' before the 'n', treating
> > '\n' as 'n'.
> >
> > As the test already requires perl as a prerequisite, use perl inste=
ad of sed.
> >
> > Signed-off-by: Torsten B=F6gershausen <tboegi@web.de>
> > ---
>=20
> Hmph.  I read this in pubs.opengroup.org/onlinepubs/9699919799/utilit=
ies/sed.html
>=20
>     The escape sequence '\n' shall match a <newline> embedded in the
>     pattern space.
>=20
> so it may be better to be a bit more explicit in the log message to
> say whose implementation has this issue to warn people.
>=20
> > -	sed "s/^From:/$header: extra@address.com\nFrom:/" cover-to-edit.p=
atch >"$cover" &&
> > +	"$PERL_PATH" -pe "s/^From:/$header: extra\@address.com\nFrom:/" c=
over-to-edit.patch | tr Q "$LF" >"$cover" &&

Note that quoted section of POSIX says "embedded in the pattern space";
under the description of the "s" command, it says:

	The replacement string shall be scanned from beginning to end.
	[...]
	The meaning of a <backslash> immediately followed by any
	character other than '&', <backslash>, a digit, or the delimiter
	character used for this command, is unspecified.

	A line can be split by substituting a <newline> into it. The
	application shall escape the <newline> in the replacement by
	preceding it by a <backslash>.

So the portable way to do it is:

	sed "s/^From:/$header: extra@address.com\
=46rom:/" cover-to-edit.patch >"$cover" &&

but that requires the continuation to start in column 0, so the Perl
variant is probably neater.
