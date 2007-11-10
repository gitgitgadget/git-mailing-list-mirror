From: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH 2/2] --pretty=format: on-demand format expansion
Date: Sat, 10 Nov 2007 12:12:33 +0100
Message-ID: <47359221.7090707@lsrfire.ath.cx>
References: <4733AEA6.1040802@lsrfire.ath.cx> <20071109045040.GC31760@sigill.intra.peff.net> <4734EA4E.8070405@lsrfire.ath.cx> <20071110004635.GA14992@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Paul Mackerras <paulus@samba.org>,
	Git Mailing List <git@vger.kernel.org>,
	Pierre Habouzit <madcoder@debian.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Nov 10 12:13:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IqoHM-0006d6-I1
	for gcvg-git-2@gmane.org; Sat, 10 Nov 2007 12:13:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753178AbXKJLNO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 10 Nov 2007 06:13:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751306AbXKJLNO
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Nov 2007 06:13:14 -0500
Received: from static-ip-217-172-187-230.inaddr.intergenia.de ([217.172.187.230]:54475
	"EHLO neapel230.server4you.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751297AbXKJLM5 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 10 Nov 2007 06:12:57 -0500
Received: from [10.0.1.201] (p57B7EF01.dip.t-dialin.net [87.183.239.1])
	by neapel230.server4you.de (Postfix) with ESMTP id D9601873BA;
	Sat, 10 Nov 2007 12:12:55 +0100 (CET)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <20071110004635.GA14992@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64328>

Jeff King schrieb:
> On Sat, Nov 10, 2007 at 12:16:30AM +0100, Ren=E9 Scharfe wrote:
>=20
>>> A partial patch on top of yours is below (it caches commit and tree=
=20
>>> abbreviations; parent abbreviations and person-parsing are probably=
=20
>>> worth doing). Some timings:
>> ... but I object to the choice of items to cache.  Are there real-wo=
rld
>> formats containing the same placeholder twice or even more often?
>=20
> My choice of items was more "here is what I am talking about" and not
> "this is the best set of items."
>=20
> As for what real-world workloads are like, part of the _point_ of
> --pretty=3Dformat: is for one-off formats that users use in their
> workflow. So yes, I have used formats that repeat specifiers, but the=
y
> are probably not common.

Hmm, OK.

> The point of my timings was to show not only that we sped up that
> uncommon case, but that there was negligible cost to the common case.
> And since we don't know what formats users will provide, it makes sen=
se
> not to have lousy performance on the uncommon.

My suspicion was that it's more like "never used" rather than
"uncommon".  Since you're a duplicate placeholder user, it's not "never=
"
any more. :)

>> There is probably more to gain from the interdependencies of differe=
nt
>> placeholders.  The patch below attempts to avoid parsing the commit
>> twice, by saving pointers to the different parts.
>=20
> Looks sane, although I don't see any reason this couldn't just go on =
top
> of my patch, and then we can speed up both cases.

Yes, the two are independent.  I don't like the malloc()'s in your
patch, though, and have cooked up a different one on top of a cleaned u=
p
version of mine.  It plays the dirty trick of reading expansions of
repeated placeholders from the strbuf..

Ren=E9
