From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] tests: eliminate unnecessary setup test assertions
Date: Fri, 6 May 2011 17:48:01 -0400
Message-ID: <20110506214801.GA17848@sigill.intra.peff.net>
References: <20110503090351.GA27862@elie>
 <4DC1CE16.5030808@dailyvoid.com>
 <7vsjsuc704.fsf@alter.siamese.dyndns.org>
 <20110506205441.GA20182@elie>
 <20110506205851.GB20182@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Michael Grubb <devel@dailyvoid.com>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 06 23:48:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QISse-0007SB-9z
	for gcvg-git-2@lo.gmane.org; Fri, 06 May 2011 23:48:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752648Ab1EFVsG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 6 May 2011 17:48:06 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:40502
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752211Ab1EFVsF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 May 2011 17:48:05 -0400
Received: (qmail 13731 invoked by uid 107); 6 May 2011 21:49:59 -0000
Received: from sigill-wired.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.8)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 06 May 2011 17:49:59 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 06 May 2011 17:48:01 -0400
Content-Disposition: inline
In-Reply-To: <20110506205851.GB20182@elie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173016>

On Fri, May 06, 2011 at 03:58:52PM -0500, Jonathan Nieder wrote:

> Two scripts use a different style with this kind of trivial code
> enclosed by a test assertion; fix them.  The usual style is easier to
> read since there is less indentation to keep track of and no need to
> worry about nested quotes; and on the other hand, because the command=
s
> in question are trivial, it should not make the test suite any worse
> at catching future bugs in git.

Thanks. Glancing at the first few hunks, this change didn't seem like a
big cleanup, but then I got to the hunk with all the ugly '\'' bits. :)

The patch looks correct to me (reviewing with "git diff -b" was a big
help).

> While at it, make some other small tweaks:
>=20
>  - spell function definitions with a space before () for consistency
>    with other scripts;

Hmm.

  $ cd t
  $ git grep ' ()' *.sh  | wc -l
  271
  $ git grep '[^ ]()' *.sh  | wc -l
  247

I'm not sure you are making things any more consistent. But I don't
really care either way.

Just for giggles, I was curious who introduced the styles:

  pattern_authors() {
    git grep -n "$@" |
    while IFS=3D: read file line match; do
      git blame -L "$line,$line" "$file"
    done |
    perl -lpe '/\((.*?) \d+-\d+-\d+/; $_=3D$1'
  }

  $ pattern_authors ' ()' t/*.sh | sort | uniq -c | sort -rn
  84 Junio C Hamano
  32 Jonathan Nieder
  16 Thomas Rast
  16 Johan Herland
  12 Johannes Sixt
  12 Johannes Schindelin
  ...

  $ pattern_authors '[^ ]()' t/*.sh | sort | uniq -c | sort -rn
  52 Jeff King
  26 Jonathan Nieder
  18 Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy
  16 Wincent Colaiuta
  14 Jon Seymour
  10 Tay Ray Chuan
  ...

So there are definitely particular people who prefer different styles
(and I recalled that Junio and I differed on this style point, which is
confirmed here). Interestingly, you are the only person to fall right i=
n
the middle.  I guess that means you are good at emulating surrounding
code. :)

-Peff
