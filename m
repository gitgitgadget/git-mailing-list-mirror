From: Jeff King <peff@peff.net>
Subject: Re: Strange cogito behaviour
Date: Tue, 1 Aug 2006 11:12:58 -0400
Message-ID: <20060801151258.GB3923@coredump.intra.peff.net>
References: <200608011053.25112.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 01 17:13:35 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G7vvg-00077L-7c
	for gcvg-git@gmane.org; Tue, 01 Aug 2006 17:13:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751169AbWHAPNE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 1 Aug 2006 11:13:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751287AbWHAPND
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Aug 2006 11:13:03 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2190 "HELO
	peff.net") by vger.kernel.org with SMTP id S1751169AbWHAPNB (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 1 Aug 2006 11:13:01 -0400
Received: (qmail 11750 invoked from network); 1 Aug 2006 11:12:31 -0400
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by 66-23-211-5.clients.speedfactory.net with SMTP; 1 Aug 2006 11:12:30 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue,  1 Aug 2006 11:12:58 -0400
To: Andy Parkins <andyparkins@gmail.com>
Content-Disposition: inline
In-Reply-To: <200608011053.25112.andyparkins@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24599>

On Tue, Aug 01, 2006 at 10:53:24AM +0100, Andy Parkins wrote:

> It does the following:
>  * Create a repository, repo1, add a file to it
>  * Create a branch inside repo1 and change the file in it
>  * Switches repo1 to master branch
>  * Clones repo1 to repo2
>  * Switches repo1 to alternate branch
>  * Updates repo2
> 
> The odd behaviour is that repo2 changes in the update to show the branch 
> contents in the working copy.  The only actions that has happened in repo1 is 

A cogito fetch without a branch specifier defaults to the remote HEAD,
not master.  This is the documented behavior (see cg-branch-add(1)). I
agree it is confusing (I also thought it was a bug until I looked it up
:) ). If you want to always fetch from the master, you must say so
explicitly:
  $ cg-clone repo1#master repo2

> The script then continues with
>  * Switch repo1 back to master branch
>  * Update repo2
> This time repo2 doesn't change.  So I'm more confused :-)

This is because repo2's master is already at the branch, and repo1 is a
subset of that history. There is no need to merge since repo2 already
contains all of the commits in repo1 (plus another one which is only on
the branch in repo1).

-Peff
