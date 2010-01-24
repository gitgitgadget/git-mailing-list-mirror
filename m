From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH] Handle double slashes in make_relative_path()
Date: Sun, 24 Jan 2010 14:57:42 +0100
Message-ID: <201001241457.43297.trast@student.ethz.ch>
References: <379d55c6a4110736aadb8ace3b050de879a9deab.1264118830.git.trast@student.ethz.ch> <201001232141.49556.j6t@kdbg.org> <fabb9a1e1001231301o149bb13es236a7150f57ce161@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Johannes Sixt <j6t@kdbg.org>, Junio C Hamano <gitster@pobox.com>,
	Robin Rosenberg <robin.rosenberg@dewire.com>,
	<git@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jan 24 14:58:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NZ2yV-000274-OJ
	for gcvg-git-2@lo.gmane.org; Sun, 24 Jan 2010 14:58:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753171Ab0AXN5w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Jan 2010 08:57:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752536Ab0AXN5w
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Jan 2010 08:57:52 -0500
Received: from gwse.ethz.ch ([129.132.178.237]:37846 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752475Ab0AXN5v (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Jan 2010 08:57:51 -0500
Received: from CAS00.d.ethz.ch (129.132.178.234) by gws00.d.ethz.ch
 (129.132.178.237) with Microsoft SMTP Server (TLS) id 8.2.213.0; Sun, 24 Jan
 2010 14:57:51 +0100
Received: from thomas.localnet (129.132.210.59) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.213.0; Sun, 24 Jan
 2010 14:57:51 +0100
User-Agent: KMail/1.13.0 (Linux/2.6.31.8-0.1-desktop; KDE/4.3.90; x86_64; ; )
In-Reply-To: <fabb9a1e1001231301o149bb13es236a7150f57ce161@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137897>

On Saturday 23 January 2010 22:01:38 Sverre Rabbelier wrote:
> Heya,
> 
> On Sat, Jan 23, 2010 at 21:41, Johannes Sixt <j6t@kdbg.org> wrote:
> 
> > OTOH, it can be worked around easily by the user (just insert the drive
> > prefix). Dunno...
> 
> I think it's preferable to keep the old behavior where we fail if the
> user gives us an invalid argument, rather than fix a user error and
> break on a a valid argument instead. I think we should be correct
> first, and try and fix incorrect user behavior after.

I can't really comment on the Windows side of things, but I tried to
come up with some more data points.

POSIX specifies that multiple slashes must be treated as if they were
a single slash (except as in the next bullet point).  Leading _double_
slashes may be treated implementation-dependently. [1]  Non-leading
double slashes do not seem to be specified.

There's a manpage path_resolution(7) on my system, which can also be
found on the web quite easily, e.g. [2].  It doesn't say anything
about multiple slashes, but experimentally my Linux resolves them as
if they were single slashes (even a leading double slash).

Junio's patch is already in maint, so I suppose we're in the somewhat
unfortunate situation where the old version didn't work in all cases
on Linux, but the current one breaks on Windows in some cases.  Then
again, shouldn't windows get special support to figure out that /c/foo
[3] is a prefix of /foo and vice versa, assuming you're currently in
C:?


[1] http://www.opengroup.org/onlinepubs/009695399/basedefs/xbd_chap04.html#tag_04_11
Actually the server doesn't work for me, but google has a cached copy:
http://209.85.129.132/search?q=cache:QUuajH7Dp5gJ:www.opengroup.org/onlinepubs/009695399/basedefs/xbd_chap04.html+http://www.opengroup.org/onlinepubs/009695399/basedefs/xbd_chap04.html#tag_04_11&cd=1&hl=en&ct=clnk&gl=uk

[2] http://www.kernel.org/doc/man-pages/online/pages/man7/path_resolution.7.html

[3] Don't blame me if I didn't get that syntax right, I'm actively
trying to forget I ever used Windows and it shows.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
