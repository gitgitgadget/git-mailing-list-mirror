From: Jeff King <peff@peff.net>
Subject: Re: git log -Sfoo ignores indentation (whitespace?) changes...
Date: Tue, 3 Mar 2009 10:23:33 -0500
Message-ID: <20090303152333.GB24593@coredump.intra.peff.net>
References: <49AD3E78.1050706@sneakemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?Q?=22Peter_Valdemar_M=C3=B8rch_=28Lists=29=22?= 
	<4ux6as402@sneakemail.com>
X-From: git-owner@vger.kernel.org Tue Mar 03 16:25:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LeWUc-0004nE-V5
	for gcvg-git-2@gmane.org; Tue, 03 Mar 2009 16:25:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758605AbZCCPXo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 3 Mar 2009 10:23:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756774AbZCCPXo
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Mar 2009 10:23:44 -0500
Received: from peff.net ([208.65.91.99]:50480 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758573AbZCCPXk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Mar 2009 10:23:40 -0500
Received: (qmail 17086 invoked by uid 107); 3 Mar 2009 15:23:37 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 03 Mar 2009 10:23:37 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 03 Mar 2009 10:23:33 -0500
Content-Disposition: inline
In-Reply-To: <49AD3E78.1050706@sneakemail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112084>

On Tue, Mar 03, 2009 at 03:28:08PM +0100, "Peter Valdemar M=C3=B8rch (L=
ists)" wrote:

> Commits where only the indentation of 'foo' is changed are not shown =
with=20
> "git log -Sfoo". Is there any way to force showing them along with ot=
her=20
> changes involving foo? (E.g. for python, indentation matters!)
>
> Why doesn't the second commit show up in the following?

Because you misunderstand how "-S" works (but don't worry, it's not you=
r
fault -- the documentation is somewhat misleading). The documentation s=
ays:

  -S<string>
    Look for differences that contain the change in <string>.

but what it actually does is find changes where the string was introduc=
ed
or removed. So it literally counts the number of occurences before and
after the commit, and the commit is interesting if they are not equal.

> # Create text containing 'line' without whitespace
> $ echo 'line' > text
> $ git add text
> $ git commit -m "first" text
>
> # Here, I add one space of indentation in front of 'line'
> $ echo ' line' > text
> $ git commit -m "second" text

So "line" wasn't actually changed. It just happens to be on a line whic=
h
_did_ change.

> I would like to see both "first" and "second" somehow - can I do that=
?

I don't think there's an easy way to do this right now; you would need
to do "git log -p" and search through the output to get what you want (=
I
often do this just using the pager's search function).

-Peff
