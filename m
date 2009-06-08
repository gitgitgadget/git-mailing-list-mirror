From: Ralf Wildenhues <Ralf.Wildenhues@gmx.de>
Subject: Re: [PATCH] autoconf: Add link tests to each AC_CHECK_FUNC() test
Date: Mon, 8 Jun 2009 23:24:55 +0200
Organization: Department of Numerical Simulation, University of Bonn
Message-ID: <20090608212454.GA834@gmx.de>
References: <1225021939-11858-1-git-send-email-david.syzdek@acsalaska.net> <7v4p2q3662.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "David M. Syzdek" <david.syzdek@acsalaska.net>,
	git@vger.kernel.org, jnareb@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 08 23:25:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MDmLI-0003q7-6q
	for gcvg-git-2@gmane.org; Mon, 08 Jun 2009 23:25:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755502AbZFHVY4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Jun 2009 17:24:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755442AbZFHVYz
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Jun 2009 17:24:55 -0400
Received: from mail.gmx.net ([213.165.64.20]:47619 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755220AbZFHVYz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Jun 2009 17:24:55 -0400
Received: (qmail invoked by alias); 08 Jun 2009 21:24:56 -0000
Received: from xdsl-87-79-128-87.netcologne.de (EHLO localhost.localdomain) [87.79.128.87]
  by mail.gmx.net (mp029) with SMTP; 08 Jun 2009 23:24:56 +0200
X-Authenticated: #13673931
X-Provags-ID: V01U2FsdGVkX19wVxMtpzNw094PohCUeiFdOMI/ZHEDkHuuOtE+Bg
	G2mAi71TgmM96T
Received: from ralf by localhost.localdomain with local (Exim 4.69)
	(envelope-from <Ralf.Wildenhues@gmx.de>)
	id 1MDmKt-0000E3-7Z; Mon, 08 Jun 2009 23:24:55 +0200
Mail-Followup-To: Ralf Wildenhues <Ralf.Wildenhues@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,
	"David M. Syzdek" <david.syzdek@acsalaska.net>, git@vger.kernel.org,
	jnareb@gmail.com
Content-Disposition: inline
In-Reply-To: <7v4p2q3662.fsf@gitster.siamese.dyndns.org>
X-GMX-UID: QRwefooXX1VoTv/IvGFyBjZySDc4NIyp
X-Flags: 1000
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.45
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121112>

Hello, and please forgive me for replying to a very old thread,
<http://thread.gmane.org/gmane.comp.version-control.git/99159>.
(BTW, is that frowned upon on this list?)

* Junio C Hamano wrote on Sun, Nov 02, 2008 at 09:04:21AM CET:
> "David M. Syzdek" <david.syzdek@acsalaska.net> writes:
> > Update configure.ac to test libraries for getaddrinfo, strcasestr, memmem,
> > strlcpy, strtoumax, setenv, unsetenv, and mkdtemp.  The default compilers
> > on FreeBSD 4.9-SECURITY and FreeBSD 6.2-RELEASE-p4 do not generate warnings
> > for missing prototypes unless `-Wall' is used. This behavior renders the
> > results of AC_CHECK_FUNC() void on these platforms. The test AC_SEARCH_LIBS()
> > verifies a function is valid by linking to symbol within the system libraries.

This description does not make sense.  AC_CHECK_FUNC does not take into
account prototypes in the test; instead, it tries to link a program that
requires the function symbol.  In that matter, the patch that introduced

> It's been a looong time since I did any sizeable autoconf/m4 hacking, but
> the repetitititiveness of this patch loudly calls for a convenience macro
> of a higher order, perhaps something like:
> 
>         AC_DEFUN([GIT_CHECK_FUNC],[
>          AC_CHECK_FUNC([$1],[
>           AC_SEARCH_LIBS([$1},,
>           [$2],[$3])],
>           [$3])])
> 
> Then we can use it like:
> 
> 	GIT_CHECK_FUNC([getaddrinfo],[NO_IPV6=],[NO_IPV6=YesPlease])

(which is 1689c5de8730ea334535337a341db3c7a21ad002) is not necessary.
However, there might have been another reason altogether why David was
seeing false configure test results on his system, and it would be
interesting to know about them (both to possibly fix Autoconf, and the
comment introducing GIT_CHECK_FUNC in configure.ac).

Otherwise, I'd propose reverting the commit.

Thanks for any feedback,
Ralf
