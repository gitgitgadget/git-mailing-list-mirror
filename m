From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Cross-Platform Version Control
Date: Wed, 13 May 2009 14:10:17 -0700 (PDT)
Message-ID: <alpine.LFD.2.01.0905131401170.3343@localhost.localdomain>
References: <419AD153-53B4-4DAB-AF72-4127C17B1CA0@gmail.com> <20090512151403.GS30527@spearce.org> <20090512161638.GB29566@coredump.intra.peff.net> <alpine.LFD.2.01.0905130915540.3343@localhost.localdomain> <alpine.LFD.2.01.0905130951100.3343@localhost.localdomain>
 <op.utvy5mie1e62zd@merlin.emma.line.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, "Shawn O. Pearce" <spearce@spearce.org>,
	Esko Luontola <esko.luontola@gmail.com>, git@vger.kernel.org
To: Matthias Andree <matthias.andree@gmx.de>
X-From: git-owner@vger.kernel.org Wed May 13 23:11:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M4LjD-0001Ay-EO
	for gcvg-git-2@gmane.org; Wed, 13 May 2009 23:11:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761359AbZEMVKz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 13 May 2009 17:10:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761330AbZEMVKz
	(ORCPT <rfc822;git-outgoing>); Wed, 13 May 2009 17:10:55 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:46048 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1761188AbZEMVKy (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 13 May 2009 17:10:54 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n4DLAHNq020351
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 13 May 2009 14:10:18 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n4DLAHSb028103;
	Wed, 13 May 2009 14:10:17 -0700
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <op.utvy5mie1e62zd@merlin.emma.line.org>
User-Agent: Alpine 2.01 (LFD 1184 2008-12-16)
X-Spam-Status: No, hits=-3.463 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119106>



On Wed, 13 May 2009, Matthias Andree wrote:

> Am 13.05.2009, 19:12 Uhr, schrieb Linus Torvalds
> <torvalds@linux-foundation.org>:
>=20
> > Use <stringprep.h> and stringprep_utf8_nfkc_normalize() or somethin=
g to do
> > the actual normalization if you find characters with the high bit s=
et. And
> > since I know that the OS X filesystems are so buggy as to not even =
do that
> > whole NFD thing right, there is probably some OS-X specific "use th=
is for
> > filesystem names" conversion function.
>=20
> Sorry for interrupting, but NF_K_C? You don't want that (K for compat=
ibility,
> rather than canonical, normalization) for anything except normalizing
> temporary variables inside strcasecmp(3) or similar. Probably not eve=
n that.
> The normalizations done are often irreversible and also surprising. Y=
ou don't
> want to turn 2=C2=B3.c into 23.c, do you?

No, you're right. We want just plain NFC. I just googled for how some=20
other projects handled this, and found the stringprep thing in a post=20
about rsync, and didn't look any closer.

But yes, you're absolutely right, stringprep is total crap, and nfkc is=
=20
horrible.

I have no idea of what library to use, though. For perl, there's=20
Unicode::Normalize, but that's likely still subtly incorrect for the OS=
-X=20
case due to the filesystem not using _strict_ NFD.

I have this dim memory of somebody actually pointing to the documentati=
on=20
of exactly which characters OS X ends up decomposing. Maybe we could ju=
st=20
do a git-specific inverse of that, knowing that NOBODY ELSE IN THE WHOL=
E=20
UNIVERSE IS SO TERMINALLY STUPID AS TO DO THAT DECOMPOSITION, and thus =
the=20
OS X case is the only one we need to care about?

			Linus
