From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: Re: [JGIT PATCH 0/4] RepositoryTestCase cleanups
Date: Sat, 29 Nov 2008 13:01:11 +0100
Message-ID: <200811291301.12095.robin.rosenberg@dewire.com>
References: <1227820410-9621-1-git-send-email-robin.rosenberg@dewire.com> <20081127214916.GD23984@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, fonseca@diku.dk
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat Nov 29 13:02:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L6OWw-0002Ur-LQ
	for gcvg-git-2@gmane.org; Sat, 29 Nov 2008 13:02:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751260AbYK2MBS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Nov 2008 07:01:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751207AbYK2MBS
	(ORCPT <rfc822;git-outgoing>); Sat, 29 Nov 2008 07:01:18 -0500
Received: from mail.dewire.com ([83.140.172.130]:19004 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751172AbYK2MBR (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Nov 2008 07:01:17 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 72533147D539;
	Sat, 29 Nov 2008 13:01:15 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id buq89VdiEfKy; Sat, 29 Nov 2008 13:01:14 +0100 (CET)
Received: from sleipner.localnet (unknown [10.9.0.4])
	by dewire.com (Postfix) with ESMTP id 47EE78006BF;
	Sat, 29 Nov 2008 13:01:14 +0100 (CET)
User-Agent: KMail/1.10.3 (Linux/2.6.27-10-generic; KDE/4.1.3; i686; ; )
In-Reply-To: <20081127214916.GD23984@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101908>

torsdag 27 november 2008 22:49:16 skrev Shawn O. Pearce:
> Robin Rosenberg <robin.rosenberg@dewire.com> wrote:
> > Ok, so here is an attempt to improve the ability of the JGit's unit
> > tests to delete temporary repositories. This has probably been seen
> > by many, but Jonas Fonseca raised the issue.
> 
> Hmpph.  This takes 19 seconds to run the suite, where it used to be
> only 2 seconds on the same system.  The slower run isn't something
> I'm too happy about, actually I'd like to make the run even faster
> than 2 seconds.

So maybe we should clean up less. Every new test repo we create has
a new name so we could do without cleaning up so much. The cleanup
however is a verification that we close (and can close) our resources, 
though it only works on Windows :/ On unix we could spawn lsof but that
is really really slow. 

> If the issue is mmap'd files, why don't we instead disable mmap
> on Windows during JUnit tests, and use the non-mmap variant of
> pack access?  At least do that for the bulk of the tests, and
> then have a single test case which tests the mmap code path but
> has careful System.gc calls in place to try and ensure we can
> actually clean up the temporary files.
We would then need some other really slow test to play rough with
memory mapping and gc. As I mentioned above it is actually about
closing resources in general, mmapped files being an especially 
nasty case.

> I'd actually like to get that Repository refactoring done soon,
> someone else was asking about it for the RefDatabase (to store the
> refs in a SQL database so JGit ties into JTA) but I may also want
> it for Gerrit 2 - I'm looking at doing something that would put
> 200,000 refs per year into a repository.  That's so large that
> most operations can't afford to scan the entire ref database,
> and it really cannot be loose.  ;-)

Would be cool, but having that diff engine is more important to me.

> 
> 
> Refactoring repository is a fair chunk of work, disabling the mmap
> feature under Windows in JUnit may be easier.  Hmm, according to
> WindowCache's <clinit> its default by false.  Why is it enabling
> on Windows?  The only code that calls WindowCache.reconfigure()
> is in the Eclipse plugin, so pure JGit unit tests shouldn't be
> turning on mmap code *at all*.
> 
> Which also points out a gap in our tests.  Nothing new, we have
> lots of gaps.  *sigh*

Yep.  :/

-- robin
