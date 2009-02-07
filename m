From: Jeff King <peff@peff.net>
Subject: Re: [BUG] 'git log --quiet' doesn't suppress the output
Date: Sat, 7 Feb 2009 01:56:02 -0500
Message-ID: <20090207065602.GA14995@coredump.intra.peff.net>
References: <885649360902041819k4a168407wc57017e6a1c7d00a@mail.gmail.com> <20090206191146.GC19494@coredump.intra.peff.net> <885649360902062244v715a61b7nf32003c97cc4f707@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git ML <git@vger.kernel.org>
To: James Pickens <jepicken@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 07 07:58:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LVh93-0005el-AM
	for gcvg-git-2@gmane.org; Sat, 07 Feb 2009 07:58:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753113AbZBGG4J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Feb 2009 01:56:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752898AbZBGG4H
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Feb 2009 01:56:07 -0500
Received: from peff.net ([208.65.91.99]:35331 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752869AbZBGG4G (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Feb 2009 01:56:06 -0500
Received: (qmail 19081 invoked by uid 107); 7 Feb 2009 06:56:18 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sat, 07 Feb 2009 01:56:18 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 07 Feb 2009 01:56:02 -0500
Content-Disposition: inline
In-Reply-To: <885649360902062244v715a61b7nf32003c97cc4f707@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108818>

On Fri, Feb 06, 2009 at 11:44:59PM -0700, James Pickens wrote:

> I was writing a script, and looking for a way to figure out
> whether there were any commits in origin/master that aren't in
> master (i.e., whether I need to pull before I can push), and 'git
> log --quiet origin/master..master' was the first thing I thought
> of.

OK, that does make sense.

In this case, though, you should be using the "git rev-list" plumbing
instead of the "git log" porcelain for a script. And "git rev-list" does
support "--quiet", but it doesn't quite do what you want. It silences
the output, but the exit code does not depend on whether or not there
were any commits in range.

So you would need a patch for rev-list to support --exit-code to mean
"did we see anything?".

In the past I have accomplished something similar through:

  git rev-list origin/master..master | wc -l

and checking the result for "0" (I think you could even speed things up
by using "git rev-list -1", because you only care about whether there
are 0 or more than 0 commits, so parsing and writing the other N is
pointless).

-Peff
