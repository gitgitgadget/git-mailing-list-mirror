From: Junio C Hamano <gitster@pobox.com>
Subject: Re: CRLF problems with Git on Win32
Date: Tue, 08 Jan 2008 12:11:25 -0800
Message-ID: <7vbq7wrsb6.fsf@gitster.siamese.dyndns.org>
References: <Pine.LNX.4.64.0801071010340.1864@ds9.cixit.se>
	<200801071947.28586.robin.rosenberg.lists@dewire.com>
	<alpine.LSU.1.00.0801071915470.10101@racer.site>
	<200801072203.23938.robin.rosenberg.lists@dewire.com>
	<alpine.LSU.1.00.0801072115120.10101@racer.site>
	<3B08AC4C-A807-4155-8AD7-DC6A6D0FE134@zib.de>
	<20080108172957.GG22155@fieldses.org>
	<CE10C08D-AAF1-44B5-89B5-9A16A4AB70EA@zib.de>
	<7vmyrgry20.fsf@gitster.siamese.dyndns.org>
	<02DC77F5-7465-418D-972E-0F76E56C3F75@zib.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Robin Rosenberg <robin.rosenberg.lists@dewire.com>,
	Jeff King <peff@peff.net>,
	Peter Karlsson <peter@softwolves.pp.se>,
	Git Mailing List <git@vger.kernel.org>,
	msysGit <msysgit@googlegroups.com>
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Tue Jan 08 21:12:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JCKo2-0001Zd-5X
	for gcvg-git-2@gmane.org; Tue, 08 Jan 2008 21:12:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751691AbYAHULp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jan 2008 15:11:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751642AbYAHULo
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Jan 2008 15:11:44 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:38912 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751264AbYAHULn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jan 2008 15:11:43 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 19E9BC1AF;
	Tue,  8 Jan 2008 15:11:41 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id EDD87C13E;
	Tue,  8 Jan 2008 15:11:27 -0500 (EST)
In-Reply-To: <02DC77F5-7465-418D-972E-0F76E56C3F75@zib.de> (Steffen Prohaska's
	message of "Tue, 8 Jan 2008 19:58:57 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69910>

Steffen Prohaska <prohaska-wjoc1KHpMeg@public.gmane.org> writes:

	By the way, is it your setting that mangles people's
	e-mail addresses?  If it is, is it possible for you to
	configure it to stop doing that?

> I don't think a solution will be found by declaring one platform
> native (UNIX) and all other platform non-native.  The question to
> answer is how to support cross-platform projects.  A valid
> solution should never corrupt data unless the user explicitly
> told git to do so.

I realize I might have misunderstood your intention.

I did not use the word "native" to mean "native vs second class
citizen".  The "native" in my description should have said "a
platform whose native line ending convention happens to match
what the project chose to use as its canonical blob object
representation".  And on such a platform, there is no need to
worry about accidental corruption because there is no autocrlf
involved.   I could have said "lucky platform" instead of
"native".

I have been assuming that both of us are assuming LF line ending
is what a typical cross-platform project would pick as the
canonical blob object representation.  If you are assuming CRLF
line ending as the canonical blob object representation for
projects originating from Windows, UNIX is not native (or
"lucky") in such a project.  Of course, in such a project,
setting "core.autocrlf = true" is absolutely a wrong thing to do
on Windows.  Perhaps you meant that, and I would agree with you.

In such a project, setting "core.autocrlf = reversed" (which
would convert work tree LF line endings to canonical CRLF when
creating a blob, but we currently do not support it) on UNIX
would become necessary, if you want the resulting mess to work
reasonably without configuration.

As long as "cross-platform" needs to support checkouts on
platforms with different conventions, and if you do not give
explicit marking about the binariness, platforms that are not
"lucky" needs to guess.  The alternative is to check out
verbatim and effectively get it all wrong, from the platform
convention's point of view.

There is no avoiding that.

HOWEVER.

If you mean by "cross platform project" a project that picks LF
line ending as the canonical representation, then you cannot
deny the fact that Windows is not "lucky" and without explicit
marking about the binariness, it needs to guess.  Again, the
alternative is to check out verbatim and get it all wrong.
