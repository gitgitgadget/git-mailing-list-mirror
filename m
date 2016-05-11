From: Jeff King <peff@peff.net>
Subject: Re: Bug: `git-filter-branch =?utf-8?B?4oiS?=
 =?utf-8?B?4oiSc3ViZGlyZWN0b3J54oiSZmlsdGVyYA==?= fails on Darwin, others?
Date: Wed, 11 May 2016 10:08:02 -0400
Message-ID: <20160511140802.GA20134@sigill.intra.peff.net>
References: <154a01265c2.c271895e226206.8641058706319152212@geoff.codes>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Geoff Nixon <geoff@geoff.codes>
X-From: git-owner@vger.kernel.org Wed May 11 16:08:13 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0Uo9-0007A4-7e
	for gcvg-git-2@plane.gmane.org; Wed, 11 May 2016 16:08:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932764AbcEKOII convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 May 2016 10:08:08 -0400
Received: from cloud.peff.net ([50.56.180.127]:38041 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932694AbcEKOIH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 May 2016 10:08:07 -0400
Received: (qmail 15183 invoked by uid 102); 11 May 2016 14:08:05 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 11 May 2016 10:08:05 -0400
Received: (qmail 12315 invoked by uid 107); 11 May 2016 14:08:19 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 11 May 2016 10:08:19 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 11 May 2016 10:08:02 -0400
Content-Disposition: inline
In-Reply-To: <154a01265c2.c271895e226206.8641058706319152212@geoff.codes>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294346>

On Wed, May 11, 2016 at 06:47:20AM -0700, Geoff Nixon wrote:

> I believe I have found a bug in git. On Mac OS X (at least 10.9
> through 10.11), and versions of git from the current HEAD down throug=
h
> at least 1.8.x, `git filter-branch =E2=88=92=E2=88=92subdirectory=E2=88=
=92filter ...` fails.
> Using, e.g., the following example (from the docs for
> git-filter-branch), `git filter-branch --subdirectory-filter foodir -=
-
> --all`, and using the git repository as the example repository, `git
> filter-branch --subdirectory-filter Documentation -- --all`, the
> "error message" one receives is "fatal: bad revision
> '=E2=88=92=E2=88=92subdirectory=E2=88=92filter'".

I just double-checked, and it works fine for me in a simple test:

  git init
  mkdir subdir
  for i in 1 2 3 4 5; do
    echo $i >base-$i
    echo $i >subdir/sub-$i
    git add .
    git commit -m $i
  done
  git filter-branch --subdirectory-filter subdir -- --all

That's on:

  $ sw_vers
  ProductName:    Mac OS X
  ProductVersion: 10.9.5
  BuildVersion:   13F34

However, I notice the error message you show has non-ascii dashes when
it prints "--subdirectory-filter". That matches what you said below:

>     - Exporting PS4 to 'WTF: $LINENO ' and setting `-x` is practicall=
y
>     of no use, except that the last line before it fails appears to b=
e
>     `git rev-parse --no-flags --revs-only --symbolic-full-name
>     --default HEAD $'=EF=BF=BD\210\222=EF=BF=BD\210\222subdirectory=EF=
=BF=BD\210\222filter`
>     (including the octal sequences and bad-unicode character, those
>     are not email artifacts)

Are you sure that you are invoking filter-branch with regular ascii
dashes, and not Unicode "minus-sign" (U+2212)?

I seem to recall this coming up once before related to OS X, but I can'=
t
seem to find it in the archive. And I don't recall if it was related to
the terminal, a keyboard setting, or something else.

-Peff
