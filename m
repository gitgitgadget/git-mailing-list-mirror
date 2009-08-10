From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Using both JGit and C Git
Date: Mon, 10 Aug 2009 08:12:55 -0700
Message-ID: <20090810151255.GP1033@spearce.org>
References: <4A7726E1.2020501@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Semen Vadishev <Semen.Vadishev@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 10 17:13:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MaWYZ-0008Sj-DO
	for gcvg-git-2@gmane.org; Mon, 10 Aug 2009 17:13:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755244AbZHJPMy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Aug 2009 11:12:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752986AbZHJPMy
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Aug 2009 11:12:54 -0400
Received: from george.spearce.org ([209.20.77.23]:33756 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751144AbZHJPMy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Aug 2009 11:12:54 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 25767381FE; Mon, 10 Aug 2009 15:12:55 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <4A7726E1.2020501@gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125456>

Semen Vadishev <Semen.Vadishev@gmail.com> wrote:
> I'm working on git client written in Java. Now the application uses both
> implementations but our team is interested in switching to JGit
> completely some day. We consider that for the first version all
> read-only operations should be implemented with JGit and read-write
> functionality should use exec calls to git executable. We would keep
> that approach until we have even the smallest suspect that pure Java
> implementation could corrupt repository somehow. Also we have a number
> of read-write operations implemented with JGit and we will use them
> internally to collect more experience and to see if any problems will
> appear.
> 
> Does anyone here already have any experience with using both JGit and C
> Git together. Is there any kind of test suites which allow to check
> JGit's behavior on different platforms comparing with native git. Is
> there any known issues/workarounds? Any feedback is much appreciated.
> 
> I've noticed that such a question was raised here, but the answers are
> probably out of date now.

There are some tests in the JGit test suite that validate JGit
against C Git output to ensure the data is the same.  For example
we have created certain content with C Git, checked a copy of the
pack file into the JGit repository, then create the same content
in JGit and validate that the data is the same.  But this sort of
test is difficult because of potential unimportant variations in
the zlib library.  The compressed output can safely differ, when
running the output through the inflate method the original content
is still restored.  So we tend not to rely on it that much.


I can say that JGit completely powers Gerrit Code Review[1], and
that Gerrit Code Review is in use at many different sites as a
production server, relied upon by thousands for their daily work.
As a case in point, Gerrit Code Review powers the Android Open
Source Project... and also the Android related teams for many device
manufacturers who are building devices running that operating system.
It also powers the servers used by the Google developers who work
on Android.

Gerrit Code Review completely runs the server side portion of Git,
both the git-upload-pack and git-receive-pack, in a pure Java SSHD.
Its the only interface the teams have to their repository... and
it does it quite nicely.  The users don't know the difference,
it just works.

So, in my humble opinion, as a server technology, JGit is quite
stable and works well.  It doesn't perform as well as C Git does,
especially under high user loads, but we aren't serving volume here
as a public read-only mirror, we are supporting a smaller group.


[1] http://code.google.com/p/gerrit/

-- 
Shawn.
