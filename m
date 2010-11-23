From: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
Subject: Re: disabling PROPFIND when using smart http
Date: Tue, 23 Nov 2010 18:10:18 +0200
Message-ID: <20101123161018.GB10420@LK-Perkele-V2.elisa-laajakaista.fi>
References: <AANLkTikwqtPDDk6i0nMKJiXn5cc3DmTGYp0==daX96yd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Sitaram Chamarty <sitaramc@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 23 17:10:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PKvRh-000215-UJ
	for gcvg-git-2@lo.gmane.org; Tue, 23 Nov 2010 17:10:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754895Ab0KWQKJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 23 Nov 2010 11:10:09 -0500
Received: from emh02.mail.saunalahti.fi ([62.142.5.108]:44282 "EHLO
	emh02.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753777Ab0KWQKJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 23 Nov 2010 11:10:09 -0500
Received: from saunalahti-vams (vs3-12.mail.saunalahti.fi [62.142.5.96])
	by emh02-2.mail.saunalahti.fi (Postfix) with SMTP id 89B32EF61B;
	Tue, 23 Nov 2010 18:10:07 +0200 (EET)
Received: from emh06.mail.saunalahti.fi ([62.142.5.116])
	by vs3-12.mail.saunalahti.fi ([62.142.5.96])
	with SMTP (gateway) id A0685D633D8; Tue, 23 Nov 2010 18:10:07 +0200
Received: from LK-Perkele-V2 (a88-112-50-174.elisa-laajakaista.fi [88.112.50.174])
	by emh06.mail.saunalahti.fi (Postfix) with ESMTP id 6C396E51A2;
	Tue, 23 Nov 2010 18:10:04 +0200 (EET)
Content-Disposition: inline
In-Reply-To: <AANLkTikwqtPDDk6i0nMKJiXn5cc3DmTGYp0==daX96yd@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161978>

On Tue, Nov 23, 2010 at 09:10:43PM +0530, Sitaram Chamarty wrote:
> Hello,
>=20
> Although smart http worked fine for me out of the box, following "man
> git-http-backend", I've found folks on #git for whom it seems to fail
> on doing a PROPFIND (found by setting GIT_CURL_VERBOSE=3D1).  Enablin=
g
> WebDAV also doesn't seem to help, although that is quite likely to be
> some nuance in the Apache config I suppose.
>=20
> The thing is, I *think* that PROPFIND is not, strictly speaking,
> needed when you use the smart HTTP mode.=C2=A0 If that is indeed true=
, can
> we stop git from even attempting it, and so avoid the need to setup
> WebDAV on Apache?

I thought that this is quite strange, and as consequence, decided to
dig a bit.=20

This is pretty telling:

$ git grep -i --files-with-matches "propfind"
http-push.c

http-push.c is AFAIK not used by smart HTTP, only by dumb HTTP
push.

Apparently pusher is falling back to dumb WebDAV push for some
reason. And then failing because server does not support it
or isn't configured apporiately for it.

-Ilari
