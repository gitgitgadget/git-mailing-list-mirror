From: Fedor Brunner <fedor.brunner@azet.sk>
Subject: Re: How safe are signed git tags? Only as safe as SHA-1 or somehow
 safer?
Date: Tue, 25 Nov 2014 13:59:00 +0100
Message-ID: <54747D14.2020406@azet.sk>
References: <5468C33E.2080108@whonix.org> <20141117212657.GC15880@peff.net> <546FC446.50101@whonix.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, whonix-devel@whonix.org, mikegerwitz@gnu.org
To: Patrick Schleizer <patrick-mailinglists@whonix.org>,
	Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Nov 25 14:08:08 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XtFqc-0006vX-Oe
	for gcvg-git-2@plane.gmane.org; Tue, 25 Nov 2014 14:08:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752386AbaKYNH6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 25 Nov 2014 08:07:58 -0500
Received: from smtp-06-out.s.azet.sk ([91.235.53.31]:35351 "EHLO
	smtp-01-out.s.azet.sk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751837AbaKYNH5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Nov 2014 08:07:57 -0500
X-Greylist: delayed 520 seconds by postgrey-1.27 at vger.kernel.org; Tue, 25 Nov 2014 08:07:57 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=azet.sk; s=azet;
	t=1416920354; bh=IPWw9m0MXVdROY6pGRvidnzVQ6I4CiJXPNC3Y1qo3SM=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=tzkz1z+cfxyKCPvbVxUGjHMBSODOZ2Lmdarx3PKhGH3mAhGh32l7d9Trm4WmdY5Kk
	 VxKzvwWtAZLczhwVh40taBvzQW8stmX8l/hd17OxZV9M4zmJwiX+FdpwdGV2koAodC
	 3yVvI7BSvbke6rOhNa9BH771W3u0r2f06unHaWOY=
X-Virus-Scanned: by AntiSpam at azet.sk
X-Spam-Flag: NO
Received: from [0.0.0.0] (root457.ip-projects.de [82.211.0.201])
	(Authenticated sender: fedor.brunner@azet.sk)
	by smtp.azet.sk (Postfix) with ESMTPA id 32C7486;
	Tue, 25 Nov 2014 13:59:02 +0100 (CET)
X-SenderID: Sendmail Sender-ID Filter v1.0.0 smtp.azet.sk 32C7486
Authentication-Results: smtp.azet.sk; sender-id=fail (NotPermitted) header.from=fedor.brunner@azet.sk; auth=pass (PLAIN); spf=fail (NotPermitted) smtp.mfrom=fedor.brunner@azet.sk
In-Reply-To: <546FC446.50101@whonix.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260214>

On 22.11.2014 00:01, Patrick Schleizer wrote:
> Dear git developers!
>=20
> Jeff King wrote:
>> On Sun, Nov 16, 2014 at 03:31:10PM +0000, Patrick Schleizer wrote:
>>
>>> How safe are signed git tags? Especially because git uses SHA-1. Th=
ere
>>> is contradictory information around.
>>>
>>> So if one verifies a git tag (`git tag -v tagname`), then `checksou=
t`s
>>> the tag, and checks that `git status` reports no untracked/modified
>>> files, without further manually auditing the code, how secure is th=
is
>>> actually? Is it only as safe as SHA-1?
>>
>> Yes, it is only as "safe as SHA-1" in the sense that you have GPG-si=
gned
>> only a SHA-1 hash. If somebody can find a collision with a hash you =
have
>> signed, they can substitute the colliding data for the data you sign=
ed.
>>
>> Of course, "safe as SHA-1" and "find a collision" are vague. If
>> pre-image attacks are feasible (i.e., given already-published SHA-1,=
 I
>> can find a different input with the same SHA-1), then attacks are
>> trivial. But when people talk about attacks on SHA-1, they are usual=
ly
>> referring to finding a collision between two new pieces of data. You=
 can
>> also use that in an attack, but it's much less straightforward
>> (basically, you need to get somebody to sign one of the colliding pi=
eces
>> of data and then replace it with the other).
>=20
> Sounds pretty sad. Isn't this a security issue that should be fixed?
>=20
> Rather than discussing how feasible collisions in SHA-1 are... Attack=
s
> on SHA-1 are only getting worse, no? Since the Snowden revelations we
> know that powerful adversaries that are working on such things and wo=
uld
> use such weaknesses to exploit users.
>=20
> Dear git developers, could you please make a long story short? Change=
 to
> some stronger hash algorithm? (sha256, sha512, or so?) Or provide an
> option for that?
>=20
>> And of course there is the question of getting the colliding data to=
 the
>> victim. Git does collision checks whenever a remote (e.g., from a "g=
it
>> fetch") gives us data that we already have. So you could poison new
>> cloners with bad data, but you could not convince a repository with =
the
>> existing "good" half of the collision to fetch the "evil" half.
>=20
> Poison git cloners with bad data is exactly my point here. Because
> sometimes I am a cloner of my own code - cloning it on a separate
> machine - then verify it using gpg - but don't check it any further. =
In
> such cases, I'd prefer if security wouldn't depend on SHA-1.
>=20
> Cheers,
> Patrick
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20

Dear git developers,
how about skipping SHA-2 and moving to SHA-3 finalist BLAKE.

NIST, in the final report of the SHA-3 competition, said this about the
finalists (which included BLAKE, Keccak, Skein, and Gr=C3=B8stl):

    BLAKE had a security margin =E2=80=94 the gap between a known-weak =
reduced
version and the full version =E2=80=94 comparable to Keccak and superio=
r to the
other finalists. (=C2=A74.3: =E2=80=9CBLAKE and Keccak have very large =
security
margins.=E2=80=9D)
    BLAKE had a depth of analysis =E2=80=94 the amount of published res=
earch
analyzing its security =E2=80=94 comparable to Gr=C3=B8stl and Skein an=
d superior to
the other finalists. (=C2=A73.1: =E2=80=9CKeccak received a significant=
 amount of
cryptanalysis, although not quite the depth of analysis applied to
BLAKE, Gr=C3=B8stl, or Skein=E2=80=9D)
    BLAKE had performance (in software) comparable to Skein and superio=
r
to the other finalists. (=C2=A75.1.4: =E2=80=9CSkein and BLAKE [=E2=80=A6=
] have the best
overall software performance.=E2=80=9D)

http://nvlpubs.nist.gov/nistpubs/ir/2012/NIST.IR.7896.pdf



Measurements of SHA-3 finalists, indexed by machine

http://bench.cr.yp.to/results-sha3.html


=46edor
