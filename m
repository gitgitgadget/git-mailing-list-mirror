From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH 0/2] 'git svn info' fixes
Date: Mon, 1 Sep 2008 15:58:31 -0700
Message-ID: <20080901225831.GA26913@untitled>
References: <20080829081654.GA6680@yp-box.dyndns.org> <1220017369-32637-1-git-send-email-trast@student.ethz.ch> <20080830010319.GA2940@untitled> <200809011146.44909.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Tue Sep 02 00:59:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KaIN2-0006Rl-0I
	for gcvg-git-2@gmane.org; Tue, 02 Sep 2008 00:59:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751389AbYIAW6e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Sep 2008 18:58:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751301AbYIAW6e
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Sep 2008 18:58:34 -0400
Received: from hand.yhbt.net ([66.150.188.102]:35967 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750821AbYIAW6d (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Sep 2008 18:58:33 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id 5B21C2DC01B;
	Mon,  1 Sep 2008 15:58:32 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <200809011146.44909.trast@student.ethz.ch>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94622>

Thomas Rast <trast@student.ethz.ch> wrote:
> Eric Wong wrote:
> > Yes.  Please maintain compatibility with svn 1.5.  The current version
> > of git-svn should strive to maintain compatibility with the current
> > version of svn whenever possible.
> 
> Ok, that certainly clarifies the goal.
> 
> > > Unfortunately this does raise the question whether the URL-encoding
> > > issue treated in the other series is in fact a similar incompatibility
> > > between 1.4 and 1.5, not a (minor but long-standing) bug in git-svn.
> > 
> > It should match svn 1.5 for "git svn info".
> [...]
> > 	svn log -v `git svn info --url`
> > [should] just work.
> > 
> > I seem to recall the rules being slightly different for http(s):// and
> > (file://|svn://) URLs with the command-line client; but my memory may
> > just be fuzzy...
> 
> I've finally found a system with SVN 1.4 that I have access to, and
> ran a few tests.  I don't have svn:// servers with weird directory
> names at hand, but I could verify that even SVN 1.4 quotes output and
> requires the input to be properly quoted:
> 
>   $ svn info
>   Path: .
>   URL: file:///home/thomas/test%20directory%3F
>   Repository Root: file:///home/thomas/test%20directory%3F
>   [...]
> 
>   $ svn info file:///home/thomas/test%20directory%3F
>   Path: test directory?
>   URL: file:///home/thomas/test%20directory%3F
>   Repository Root: file:///home/thomas/test%20directory%3F
>   [...]
> 
>   $ svn info file:///home/thomas/'test directory?'
>   svn: URL 'file:///home/thomas/test directory?' is not properly URI-encoded
> 
> Variations with https:// and SVN 1.5 give the same results.  So unless
> I'm missing something, the two patch series are needed to get the
> correct output.

Thank you very much for the fixes an analysis.  This series acked and
pushed out to git://git.bogomips.org/git-svn.git

-- 
Eric Wong
