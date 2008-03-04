From: Jeff King <peff@peff.net>
Subject: Re: git-rebase dirty index and email address bug?
Date: Tue, 4 Mar 2008 07:08:04 -0500
Message-ID: <20080304120804.GA9042@sigill.intra.peff.net>
References: <slrnfsjfpo.3fl.jgoerzen@katherina.lan.complete.org> <20080302072622.GB3935@coredump.intra.peff.net> <200803022128.14511.jgoerzen@complete.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: John Goerzen <jgoerzen@complete.org>
X-From: git-owner@vger.kernel.org Tue Mar 04 13:08:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JWVx2-0004xS-8W
	for gcvg-git-2@gmane.org; Tue, 04 Mar 2008 13:08:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751466AbYCDMIJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Mar 2008 07:08:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752767AbYCDMIH
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Mar 2008 07:08:07 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:1835 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752768AbYCDMIG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Mar 2008 07:08:06 -0500
Received: (qmail 5574 invoked by uid 111); 4 Mar 2008 12:08:04 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Tue, 04 Mar 2008 07:08:04 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 04 Mar 2008 07:08:04 -0500
Content-Disposition: inline
In-Reply-To: <200803022128.14511.jgoerzen@complete.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76077>

On Sun, Mar 02, 2008 at 09:28:14PM -0600, John Goerzen wrote:

> That repo contains some local configuration and password information.  
> However, I would be happy to make it available to you or any other Git 
> developer privately.  Could you contact me off-list if you'd like me to send 
> it to you?  The .git directory in question is about 4.5MB, and I'd be happy 
> to email it.

I was able to turn this into a much smaller test case.

What is happening is that rebase works something like:
  1. reset to "onto" commit
  2. replay each commit between "upstream" and "branch"
but there is a bug in step 1 that is leaving the bogus
"public/dispatch.fcgi" file in the index and working tree. So step 2
correctly complains that the file is already there and uncommitted.

The bug in step 1 seems to be very hard to trigger, and requires that
the "branch" commit and the "onto" commit differ such that:

  - there is a file on the branch that was a directory in "onto"

  - there is a file on the branch that is new since "onto", and that
    sorts lexically after the file mentioned above

So you can see that it is rare for it to come up. :)

I'm not sure of the correct fix for the bug, but I have posted a request
for help under the subject "bug in unpack_trees", so hopefully somebody
more wise than I will have something to say.

-Peff
