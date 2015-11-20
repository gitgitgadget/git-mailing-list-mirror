From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] t1450: add tests for NUL in headers of commits and
 tags
Date: Fri, 20 Nov 2015 06:14:55 -0500
Message-ID: <20151120111454.GB11198@sigill.intra.peff.net>
References: <564DF6BE.6020609@web.de>
 <CAPig+cSXiGVLvq59sUFAzTRoQFf-QswAoMSk20LvJqntzaf65A@mail.gmail.com>
 <564E371E.50606@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
X-From: git-owner@vger.kernel.org Fri Nov 20 12:15:10 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zzjel-0002oo-6w
	for gcvg-git-2@plane.gmane.org; Fri, 20 Nov 2015 12:15:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759836AbbKTLO6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 20 Nov 2015 06:14:58 -0500
Received: from cloud.peff.net ([50.56.180.127]:60054 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1759544AbbKTLO5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Nov 2015 06:14:57 -0500
Received: (qmail 17618 invoked by uid 102); 20 Nov 2015 11:14:57 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 20 Nov 2015 05:14:57 -0600
Received: (qmail 26408 invoked by uid 107); 20 Nov 2015 11:15:29 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 20 Nov 2015 06:15:29 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 20 Nov 2015 06:14:55 -0500
Content-Disposition: inline
In-Reply-To: <564E371E.50606@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281505>

On Thu, Nov 19, 2015 at 09:54:54PM +0100, Ren=C3=A9 Scharfe wrote:

> >>diff --git a/t/t1450-fsck.sh b/t/t1450-fsck.sh
> >>@@ -176,6 +176,18 @@ test_expect_success 'integer overflow in times=
tamps is reported' '
> >>+test_expect_success 'commit with NUL in header' '
> >>+       git cat-file commit HEAD >basis &&
> >>+       sed "s/author ./author Q/" <basis | q_to_nul >commit-NUL-he=
ader &&
> >>+       new=3D$(git hash-object -t commit -w --stdin <commit-NUL-he=
ader) &&
> >>+       test_when_finished "remove_object $new" &&
> >>+       git update-ref refs/heads/bogus "$new" &&
> >>+       test_when_finished "git update-ref -d refs/heads/bogus" &&
> >>+       test_must_fail git fsck 2>out &&
> >>+       cat out &&
> >
> >What is the purpose of this 'cat'?
>=20
> It shows the full error message when the test is run with --debug, wh=
ich is
> convenient when the following grep doesn't match.  The same is done i=
n most
> tests in that file.

I'm slightly negative on such a construct, just because it wastes a
process in the case where we are not in --verbose mode. I don't mind it
in this patch in the spirit of consistency within t1450, but I think we
should probably avoid spreading it.

-Peff
