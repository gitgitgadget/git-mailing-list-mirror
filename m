From: Jeff King <peff@peff.net>
Subject: Re: t5539 broken under Mac OS X
Date: Wed, 14 Jan 2015 16:17:12 -0500
Message-ID: <20150114211712.GE1155@peff.net>
References: <54B68D99.2040906@web.de>
 <xmqqmw5l9pje.fsf@gitster.dls.corp.google.com>
 <54B6C897.5030405@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Wed Jan 14 22:17:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YBVJX-0006PY-5W
	for gcvg-git-2@plane.gmane.org; Wed, 14 Jan 2015 22:17:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752692AbbANVRP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 14 Jan 2015 16:17:15 -0500
Received: from cloud.peff.net ([50.56.180.127]:34611 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751781AbbANVRO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Jan 2015 16:17:14 -0500
Received: (qmail 15739 invoked by uid 102); 14 Jan 2015 21:17:14 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 14 Jan 2015 15:17:14 -0600
Received: (qmail 6772 invoked by uid 107); 14 Jan 2015 21:17:36 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 14 Jan 2015 16:17:36 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 14 Jan 2015 16:17:12 -0500
Content-Disposition: inline
In-Reply-To: <54B6C897.5030405@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262432>

On Wed, Jan 14, 2015 at 08:50:47PM +0100, Torsten B=C3=B6gershausen wro=
te:

> But, why does e.g. t0004 behave more gracefully (and skips) and t5539=
 just dies ?
>=20
> ./t0004-unwritable.sh=20
> ok 1 - setup
> ok 2 # skip write-tree should notice unwritable repository (missing S=
ANITY of POSIXPERM,SANITY)

The http code uses test_skip_or_die when it runs into setup errors. The
intent there is that the user has either:

  1. Told us explicitly that they want http tests by setting
     GIT_TEST_HTTPD=3Dtrue.

  2. Wants to run http tests if they can by setting GIT_TEST_HTTPD=3Dau=
to
     (or leaving it unset, as that is the default).

In case (1), we treat this as a test failure. They asked for httpd
tests, and we could not run them. In case (2), we would just skip all o=
f
the tests.

You may want to loosen your GIT_TEST_HTTPD setting (pre-83d842dc, you
had to set it to true to run the tests at all, but nowadays we have
auto).

-Peff
