From: "Brian O'Mahoney" <omb@khandalf.com>
Subject: Re: SHA1 hash safety
Date: Sat, 16 Apr 2005 23:35:39 +0200
Message-ID: <4261852B.6090507@khandalf.com>
References: <Pine.LNX.4.62.0504160519330.21837@qynat.qvtvafvgr.pbz>
    <20050416123155.GA19908@elte.hu>
    <Pine.LNX.4.62.0504160542190.21837@qynat.qvtvafvgr.pbz>
    <4261132A.3090907@khandalf.com>
    <Pine.LNX.4.61.0504161040310.29343@cag.csail.mit.edu>
Reply-To: omb@bluewin.ch
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: omb@bluewin.ch, David Lang <david.lang@digitalinsight.com>,
	Ingo Molnar <mingo@elte.hu>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 16 23:33:04 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DMutw-0002y8-MU
	for gcvg-git@gmane.org; Sat, 16 Apr 2005 23:32:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262744AbVDPVgA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sat, 16 Apr 2005 17:36:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262753AbVDPVgA
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Apr 2005 17:36:00 -0400
Received: from mxout.hispeed.ch ([62.2.95.247]:55475 "EHLO smtp.hispeed.ch")
	by vger.kernel.org with ESMTP id S262744AbVDPVfj (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 16 Apr 2005 17:35:39 -0400
Received: from khandalf.com (80-218-57-125.dclient.hispeed.ch [80.218.57.125])
	(authenticated bits=0)
	by smtp.hispeed.ch (8.12.6/8.12.6/tornado-1.0) with ESMTP id j3GLZccb014165
	for <git@vger.kernel.org.>; Sat, 16 Apr 2005 23:35:38 +0200
Received: from [127.0.0.1] (localhost [127.0.0.1]) by
    teraflex.teraflex-research.com (8.12.10/8.12.10/SuSE Linux 0.7) with ESMTP
    id j3GLZg2Q005891; Sat, 16 Apr 2005 23:35:44 +0200
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: en-us, en
To: "C. Scott Ananian" <cscott@cscott.net>
In-Reply-To: <Pine.LNX.4.61.0504161040310.29343@cag.csail.mit.edu>
X-Enigmail-Version: 0.90.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
X-Md5-Body: 137631a9b136bacfa649df2da1569cdf
X-Transmit-Date: Saturday, 16 Apr 2005 23:36:13 +0200
X-Message-Uid: 0000b49cec9d257900000002000000004261854d00055b18000000010008ce89
Replyto: omb@bluewin.ch
X-Sender-Postmaster: Postmaster@80-218-57-125.dclient.hispeed.ch.
X-Virus-Scanned: ClamAV version 0.83, clamav-milter version 0.83 on smtp-06.tornado.cablecom.ch
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Please see below:

C. Scott Ananian wrote:
> On Sat, 16 Apr 2005, Brian O'Mahoney wrote:
>=20
>> (1) I _have_ seen real-life collisions with MD5, in the context of
>>    Document management systems containing ~10^6 ms-WORD documents.
>=20
>=20
> Dude!  You could have been *famous*!  Why the
> aitch-ee-double-hockey-sticks didn't you publish this when you found =
it?
> Seriously, man.

The MD5 has was fine, or at least the code (a) produced the correct
results on the published test cases, and, (b) was properly applied to
all bytes of the file(s). I was surprised when it happened, which is wh=
y
I bothered to post to this list at this time, so I make two more points

(1) These hashes were designed, to assist in the construction of digita=
l
signatures, ie so it is hard to produce a document to hash to a known
hash value, and that with a defined document format so they are designe=
d
(i) hash similar documents far apart, and (ii) be hard to reverse;

it says nothing about naturally ocurring collisions, ie where the
document is not constrained to be similar,

>=20
> Even given the known weaknesses in MD5, it would take much more than =
a
> million documents to find MD5 collisions.  I can only conclude that t=
he
> hash was being used incorrectly; most likely truncated (my wild-ass
> guess would be to 32 bits; a collision is likely with > 50% probabili=
ty
> in a million document store for a hash of less than 40 bits).
>=20
> I know the current state of the art here.  It's going to take more th=
an
> just hearsay to convince me that full 128-bit MD5 collisions are like=
ly.
> I believe there are only two or so known to exist so far, and those w=
ere
> found by a research team in China (which, yes, is fairly famous among
> the cryptographic community now after publishing a paper consisting o=
f
> little apart from the two collisions themselves).

(2) I am not concerned with cryptography here, merely sound engineering
tradeoffs and the avoidance of _pain_in_the_ass_ when we do see a
random collision, [NB the 2^69 is to 'cause a collision in SHA1' not th=
e
odds against such a collision] ... (below)

>=20
> Please, let's talk about hash collisions responsibly.  I posted earli=
er
> about the *actual computed probability* of finding two files with an
> SHA-1 collision before the sun goes supernova.  It's 10^28 to 1 again=
st.
> The recent cryptographic works has shown that there are certain
> situations where a decent amount of computer work (2^69 operations) c=
an
> produce two sequences with the same hash, but these sequences are not
> freely chosen; they've got very specific structure.  This attack does
> not apply to (effectively) random files sitting in a SCM.
>   http://www.schneier.com/blog/archives/2005/02/sha1_broken.html
>=20
> That said, Linux's widespread use means that it may not be unimaginab=
le
> for an attacker to devote this amount of resources to an attack, whic=
h
> would probably involve first committing some specially structured fil=
e
> to the SCM (but would Linus accept it?) and then silently corrupting
> said file via a SHA1 collision to toggle some bits (which would
> presumably Do Evil).  Thus hashes other than SHA1 really ought to be
> considered...
>
> ..but the cryptographic community has not yet come to a conclusion on
> what the replacement ought to be.  These attacks are so new that we
> don't really understand what it is about the structure of SHA1 which
> makes them possible, which makes it hard to determine which other has=
hes
> are similarly vulnerable.  It will take time.
>=20
> I believe Linus has already stated on this list that his plan is to
> eventually provide a tool for bulk migration of an existing SHA1 git
> repository to a new hash type.   Basically munging through the
> repository in bulk, replacing all the hashes.  This seems a perfectly
> adequate strategy at the moment.

=2E.. [I say again, the problem here is NOT forgery of hashes, though S=
CO
like paranoia ...] ... but the hashes are a tiny part of the total
space, even for trivial patches, so that, providing _NOW_ for a longer
hash (and then why not use, say, SHA-256 for now as well) is prudent.

We do not want to revisit the plumbing, in the next 3-10 years, for 16
bytes per hash.

=46inally I can do no more than quote Schneier:

"SHA-1 has been broken. Not a reduced-round version. Not a simplified
version. The real thing. ...

It's time for us all to migrate away from SHA-1.

Luckily, there are alternatives. The National Institute of Standards an=
d
Technology already has standards for longer -- and harder to break --
hash functions: SHA-224, SHA-256, SHA-384, and SHA-512. They're already
government standards, and can already be used." and there are FOSS
implementations.

Or, put more simply by Jon Callas, PGP's CTO: "It's time to walk, but
not run, to the fire exits. You don't see smoke, but the fire alarms
have gone off." That's basically what he said last August [2004].

>  --scott
>=20
> WASHTUB Panama Minister Moscow explosives KUGOWN hack Marxist LPMEDLE=
Y
> genetic immediate radar SCRANTON COBRA JANE KGB Shoal Bay atomic Beji=
ng
>                          ( http://cscott.net/ )
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20
>=20
>=20

--=20
mit freundlichen Gr=FC=DFen, Brian.

Dr. Brian O'Mahoney
Mobile +41 (0)79 334 8035 Email: omb@bluewin.ch
Bleicherstrasse 25, CH-8953 Dietikon, Switzerland
PGP Key fingerprint =3D 33 41 A2 DE 35 7C CE 5D  F5 14 39 C9 6D 38 56 D=
5
