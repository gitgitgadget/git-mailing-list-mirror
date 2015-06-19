From: John Keeping <john@keeping.me.uk>
Subject: Re: Using clean/smudge filters with difftool
Date: Fri, 19 Jun 2015 10:32:51 +0100
Message-ID: <20150619093251.GQ18226@serenity.lan>
References: <CAGA3+++_mx=O=Un0pip8Q41X5PZBLmES=Hd=U=aSowryx5r=8w@mail.gmail.com>
 <20150618141116.GK18226@serenity.lan>
 <CAGA3+++ibw=8Q1LtM6yJrZ7Q4eVs_MEHmPAzctSVSREXMmBiMQ@mail.gmail.com>
 <20150618142852.GL18226@serenity.lan>
 <CAGA3+++LqZ8Qv6tpuoqQwi37kO5LLODwcbFQtvneorjiV4KARw@mail.gmail.com>
 <20150618160133.GO18226@serenity.lan>
 <xmqqsi9oeqhn.fsf@gitster.dls.corp.google.com>
 <20150618223927.GP18226@serenity.lan>
 <xmqqr3p8bp8l.fsf@gitster.dls.corp.google.com>
 <5583D993.4090305@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Florian Aspart <florian.aspart@gmail.com>, git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri Jun 19 11:33:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5sfi-0000xa-E3
	for gcvg-git-2@plane.gmane.org; Fri, 19 Jun 2015 11:33:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753569AbbFSJdK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 19 Jun 2015 05:33:10 -0400
Received: from jackal.aluminati.org ([72.9.247.210]:37916 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751512AbbFSJdH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 19 Jun 2015 05:33:07 -0400
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id 8C78FCDA568;
	Fri, 19 Jun 2015 10:33:06 +0100 (BST)
X-Quarantine-ID: <lcuwNkLoUAdI>
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -2.899
X-Spam-Level: 
X-Spam-Status: No, score=-2.899 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_00=-1.9, URIBL_BLOCKED=0.001]
	autolearn=no
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id lcuwNkLoUAdI; Fri, 19 Jun 2015 10:33:05 +0100 (BST)
Received: from serenity.lan (banza.aluminati.org [10.0.7.182])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by jackal.aluminati.org (Postfix) with ESMTPSA id 2FDEFCDA5AE;
	Fri, 19 Jun 2015 10:32:53 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <5583D993.4090305@drmicha.warpmail.net>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272113>

On Fri, Jun 19, 2015 at 10:57:55AM +0200, Michael J Gruber wrote:
> Junio C Hamano venit, vidit, dixit 19.06.2015 00:55:
> > John Keeping <john@keeping.me.uk> writes:
> >=20
> >> I think the summary is that there are some scenarios where the ext=
ernal
> >> diff tool should see the smudged version and others where the clea=
n
> >> version is more appropriate and Git should support both options.  =
It
> >> seems this is a property of the filter, so I wonder if the best so=
lution
> >> is a new "filter.<name>.extdiff =3D [clean|smudge]" configuration
> >> variable (there's probably a better name for the variable than
> >> "extdiff").
> >=20
> > Not just the external diff, but the textconv filter obeys the same
> > rule.  The setting should be done the same way for both, if we are
> > going to go in that direction.
> >=20
>=20
> textconv is a "one-way" filter from "blob" to "readable blob". Extern=
al
> diffs may prefer to work on "blob" rather than "readable blob", but t=
he
> currect setup does not seem to produce surprises.
>=20
> clean and smudge are two-way filters: clean from "worktree blob" (aka
> file) to "repo blob", smudge the other way round.
>=20
> Typically, the user perceives these as inverse to each other. But we
> only require clean to be a left-inverse of smudge, i.e. "(cat-file th=
en)
> smudge then clean" should give the same "repo blob" (as "cat-file").
>=20
> We don't require that the other way round, i.e. we don't require smud=
ge
> to be a left-inverse of clean, and in most setups (like the current o=
ne)
> it is not: smudge does not recreate what clean has cleaned out. It is=
 a
> no-op (the "identity", while clean is a "projection").
>=20
> Now, since external diff runs on smudged blobs, it appears as if we
> mixed cleaned and smudged blobs when feeding external diffs; whereas
> really, we mix "worktree blobs" and "smudged repo blobs", which is ok=
ay
> as per our definition of clean/smudge: the difference is irrelevant b=
y
> definition.

I agree with this.

But I was wrong that "should diff clean"/"should diff smudged" is a
property of the filter.  I can also imagine a situation where a more
intelligent external diff tool wants to see the smudged version where a
na=EFve tool would want the clean version.

=46or example, some of the big file stores (e.g. git-lfs [1]) use
clean/smudge filters and I can imagine a diff utility that avoids
needing to fetch the data for large files and instead shows the diff on
the server when both blobs are available there.  In that case we
generally want to use the smudged copy for external diff, so the filter
would use that setting, but the diff utility knows better and would wan=
t
to override that.

[1] https://github.com/github/git-lfs
