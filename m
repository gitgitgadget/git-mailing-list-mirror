From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: git on MacOSX and files with decomposed utf-8 file names
Date: Sat, 19 Jan 2008 21:45:40 -0800 (PST)
Message-ID: <alpine.LFD.1.00.0801192130180.2957@woody.linux-foundation.org>
References: <alpine.LFD.1.00.0801171017460.14959@woody.linux-foundation.org> <F666FFD2-9777-47EA-BEF4-C78906CA8901@simplicidade.org> <alpine.LFD.1.00.0801171100330.14959@woody.linux-foundation.org> <Pine.LNX.4.64.0801181114430.817@ds9.cixit.se>
 <alpine.LFD.1.00.0801180909000.2957@woody.linux-foundation.org> <2E6F57FC-3E78-4DD2-9B5B-CF75975D6A60@sb.org> <20080119084814.GH14871@dpotapov.dyndns.org> <alpine.LFD.1.00.0801191026500.2957@woody.linux-foundation.org> <B4FDA32F-16C9-497A-AAD8-27A8D510C4CB@wincent.com>
 <alpine.LFD.1.00.0801191659350.2957@woody.linux-foundation.org> <20080120052735.GA18581@glandium.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Wincent Colaiuta <win@wincent.com>,
	Dmitry Potapov <dpotapov@gmail.com>,
	Kevin Ballard <kevin@sb.org>,
	Peter Karlsson <peter@softwolves.pp.se>,
	Mark Junker <mjscod@web.de>,
	Pedro Melo <melo@simplicidade.org>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Sun Jan 20 06:47:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JGT1P-0001uX-K5
	for gcvg-git-2@gmane.org; Sun, 20 Jan 2008 06:47:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753238AbYATFqg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 20 Jan 2008 00:46:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752822AbYATFqg
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Jan 2008 00:46:36 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:43443 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752796AbYATFqf (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 20 Jan 2008 00:46:35 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m0K5jffB022131
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 19 Jan 2008 21:45:42 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m0K5jeA5005313;
	Sat, 19 Jan 2008 21:45:40 -0800
In-Reply-To: <20080120052735.GA18581@glandium.org>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
X-Spam-Status: No, hits=-2.721 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71156>



On Sun, 20 Jan 2008, Mike Hommey wrote:
>=20
> But there is no way to know whether '=E4' in a document is the Finnis=
h '=E4'
> or a '=E4' from, say, German, that sorts after 'a'.

=2E.. without knowing the locale. Correct.

That's why sorting is locale-dependent, even in Unicode. And why you=20
should always sort using the *combined* character, not think that you c=
an=20
sort by decompsed sequence.

That said, even then you get the wrong thing. Some things cannot be sor=
ted=20
character by character at all, and have semantical sorting at a higher=20
level entirely. I think most European family names are traditionally=20
sorted by effectively using the prefixes (ie d', von, etc) as a seconda=
ry=20
sort key (so even though they are in front, they sort as if they were=20
at the _end_ of the name).

So unicode doesn't help with sorting, and you shouldn't even try to fin=
d=20
sort rules in the Unicode spec or tech reports. But in general,=20
decomposing the characters just makes things worse, not better. To sort=
=20
well, you tend to need the bigger picture, not the details.

Of course, for something like git, we sort by binary value, because we=20
also require the sort to be not just well-defined, but *stable*. A sort=
=20
based on any kind of unicode rule is rather likely to change over time.

			Linus
