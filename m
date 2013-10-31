From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Fix '\%o' for printf from coreutils
Date: Thu, 31 Oct 2013 12:49:21 -0400
Message-ID: <20131031164920.GA18036@sigill.intra.peff.net>
References: <20131031115131.GA28379@camk.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Kacper Kornet <draenog@pld-linux.org>
X-From: git-owner@vger.kernel.org Thu Oct 31 17:49:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VbvR1-00029k-SB
	for gcvg-git-2@plane.gmane.org; Thu, 31 Oct 2013 17:49:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754118Ab3JaQtY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 31 Oct 2013 12:49:24 -0400
Received: from cloud.peff.net ([50.56.180.127]:59290 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751579Ab3JaQtX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Oct 2013 12:49:23 -0400
Received: (qmail 14011 invoked by uid 102); 31 Oct 2013 16:49:23 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 31 Oct 2013 11:49:23 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 31 Oct 2013 12:49:21 -0400
Content-Disposition: inline
In-Reply-To: <20131031115131.GA28379@camk.edu.pl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237128>

On Thu, Oct 31, 2013 at 12:51:32PM +0100, Kacper Kornet wrote:

> The printf utility provided by coreutils when interpreting '\%o' form=
at
> does not recognize %o as formatting directive. For example
> printf '\%o 0 returns \%o and warning: ignoring excess arguments,
> starting with =E2=80=980=E2=80=99, which results in failed tests in
> t5309-pack-delta-cycles.sh. In most shells the test ends with success=
 as
> the printf is a builtin utility.
>=20
> Fix it by using '\\%o' which is interpreted consistently in all versi=
ons
> of printf.

Thanks, this makes sense. POSIX says:

     [description of \n, \r, etc...]
     The interpretation of a backslash followed by any other
     sequence of characters is unspecified.

so we were wrong to rely on an unknown backslash-escape
being left alone. A quick grep seems indicate that this is
the only spot with the problem.

-Peff
