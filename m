From: Mark Wooding <mdw@distorted.org.uk>
Subject: Re: [PATCH] Use explicit pointers for execl...() sentinels.
Date: Sun, 12 Mar 2006 17:32:51 +0000 (UTC)
Organization: Straylight/Edgeware development
Message-ID: <slrne18mq3.fr9.mdw@metalzone.distorted.org.uk>
References: <20060311192954.GQ16135@artsapartment.org> <slrne17urp.fr9.mdw@metalzone.distorted.org.uk> <7v7j6zgaxx.fsf@assigned-by-dhcp.cox.net> <slrne18aae.fr9.mdw@metalzone.distorted.org.uk> <20060312171316.39d138f8.tihirvon@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 12 18:33:08 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FIURF-0005G2-Fc
	for gcvg-git@gmane.org; Sun, 12 Mar 2006 18:33:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751661AbWCLRc4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 12 Mar 2006 12:32:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751670AbWCLRcz
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Mar 2006 12:32:55 -0500
Received: from excessus.demon.co.uk ([83.105.60.35]:32200 "HELO
	metalzone.distorted.org.uk") by vger.kernel.org with SMTP
	id S1751659AbWCLRcz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Mar 2006 12:32:55 -0500
Received: (qmail 20520 invoked by uid 110); 12 Mar 2006 17:32:51 -0000
To: git@vger.kernel.org
Received: (qmail 20507 invoked by uid 9); 12 Mar 2006 17:32:51 -0000
Path: not-for-mail
Newsgroups: mail.vger.git
NNTP-Posting-Host: metalzone.distorted.org.uk
X-Trace: metalzone.distorted.org.uk 1142184771 20505 172.29.199.2 (12 Mar 2006 17:32:51 GMT)
X-Complaints-To: usenet@distorted.org.uk
NNTP-Posting-Date: Sun, 12 Mar 2006 17:32:51 +0000 (UTC)
User-Agent: slrn/0.9.8.1pl1 (Debian)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17520>

Timo Hirvonen <tihirvon@gmail.com> wrote:

> NULL should always be ((void *)0).

Says who?  I already gave chapter and verse for what NULL is required to
do.

Besides, (void *)0 fixes /this particular/ problem, because `void *' and
`char *' have the same representation (6.2.5#27).  This wouldn't help us
with a putative function which takes an arbitrary number of `foo *'
pointers, since nothing guarantees that `void *' and `foo *' have
similar representations.  You'd have to say `(foo *)0' or `(foo *)NULL'.

> What 64-bit systems declare NULL as plain 0 (not 0L)?

Don't know: didn't look.  0L won't do the right thing with IL32LLP64, if
anyone was actually crazy enough to specify such an ABI.  The point is,
there's not much 

> How about fixing those systems instead of making the git source code
> unreadable.

Because, according to the C and POSIX specs, they're not wrong.

The right fix from the point of view of a C implementation would be to
define NULL to be some weird __null_pointer token which the compiler
could warn about whenever it was used in an untyped argument context.

(Besides, I don't find bare or casted `0' unreadable.  Maybe I'm just
strange.)

-- [mdw]
