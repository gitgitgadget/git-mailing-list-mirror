From: Jeff King <peff@peff.net>
Subject: Re: git diff: add option for omitting the contents of deletes
Date: Tue, 8 Mar 2011 16:31:34 -0500
Message-ID: <20110308213133.GA5786@sigill.intra.peff.net>
References: <4D6B4F6B.1040209@drmicha.warpmail.net>
 <20110228121726.GA5197@sigill.intra.peff.net>
 <20110228122335.GB5197@sigill.intra.peff.net>
 <7vy650hvwa.fsf@alter.siamese.dyndns.org>
 <20110228222352.GC5854@sigill.intra.peff.net>
 <7vfwr7hh7f.fsf@alter.siamese.dyndns.org>
 <7vy64zg0ms.fsf@alter.siamese.dyndns.org>
 <AANLkTinBTWPrAOq9BOkBJc5GOhFkzsr__9wqEWnWdwYR@mail.gmail.com>
 <7vipvte6jc.fsf@alter.siamese.dyndns.org>
 <AANLkTim9juvhBJKraHBkV8AC=zY75xt_1BnyhTDTcoUZ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	git@vger.kernel.org
To: Mart =?utf-8?B?U8O1bWVybWFh?= <mrts.pydev@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 08 22:31:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Px4VI-000340-NJ
	for gcvg-git-2@lo.gmane.org; Tue, 08 Mar 2011 22:31:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755876Ab1CHVbf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 8 Mar 2011 16:31:35 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:49792
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753000Ab1CHVbe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Mar 2011 16:31:34 -0500
Received: (qmail 4795 invoked by uid 107); 8 Mar 2011 21:32:01 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 08 Mar 2011 16:32:01 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 08 Mar 2011 16:31:34 -0500
Content-Disposition: inline
In-Reply-To: <AANLkTim9juvhBJKraHBkV8AC=zY75xt_1BnyhTDTcoUZ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168701>

On Tue, Mar 08, 2011 at 11:25:04PM +0200, Mart S=C3=B5mermaa wrote:

> "It also might make sense to apply the similar principle to shorten t=
he output
> with -B when a rewrite patch is expressed as a single hunk patch that=
 removes
> everything old and then adds everthing new."
>=20
> I have to admit that I've never used -B, only -M, so please don't min=
d that
> its semantics and exact behavior are a bit foreign to me.
>=20
> After running t/t4130-apply-criss-cross-rename.sh,
> `git diff -M -B` outputs the following:
>=20
> diff --git a/file2 b/file1
> similarity index 100%
> rename from file2
> rename to file1
> diff --git a/file1 b/file2
> similarity index 100%
> rename from file1
> rename to file2
>=20
> Can you bring a similar example of changes in the output after
> the above-mentioned similar principle has been implemented for -B?

Try:

  $ git init
  $ perl -e 'print "a\n" for (1 .. 1000)' >file
  $ git add file && git commit -m one
  $ perl -e 'print "b\n" for (1 .. 1000)' >file

Now you can see that -B breaks notes it as a rewrite:

  $ git diff --stat --summary -B
   file | 2000 +++++++++++++++++++++++++++----------------------------
   1 files changed, 1000 insertions(+), 1000 deletions(-)
   rewrite file (100%)

And the diff is long:

  $ git diff -B
  diff --git a/file b/file
  dissimilarity index 100%
  index 5cfafaa..a7b871a 100644
  --- a/file
  +++ b/file
  @@ -1,1000 +1,1000 @@
  -a
  -a
  [... x 1000]
  +b
  +b
  [... x 1000]

But we could perhaps drop the actual 1000-line hunks (or maybe even jus=
t
the deletion half).

-Peff
