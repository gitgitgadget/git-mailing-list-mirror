From: Jeff King <peff@peff.net>
Subject: Re: [bug] git checkout lies about number of ahead commits when
 switching from detached HEAD
Date: Sat, 19 Mar 2011 18:28:52 -0400
Message-ID: <20110319222852.GB7116@sigill.intra.peff.net>
References: <4D8525C9.2060203@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 19 23:29:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q14e0-0005YZ-Fo
	for gcvg-git-2@lo.gmane.org; Sat, 19 Mar 2011 23:29:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757655Ab1CSW24 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Mar 2011 18:28:56 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:56953
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757624Ab1CSW2z (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Mar 2011 18:28:55 -0400
Received: (qmail 19991 invoked by uid 107); 19 Mar 2011 22:29:30 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 19 Mar 2011 18:29:30 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 19 Mar 2011 18:28:52 -0400
Content-Disposition: inline
In-Reply-To: <4D8525C9.2060203@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169472>

On Sat, Mar 19, 2011 at 10:53:13PM +0100, Piotr Krukowiecki wrote:

> It says "by 0 commits" when going back from detached HEAD to
> master branch:
> 
> 
> $ git checkout HEAD^
> 
> $ git checkout master
> Previous HEAD position was af4c62a... Merge branch 'maint'
> Switched to branch 'master'
> Your branch is ahead of 'origin/master' by 0 commits.
>                                         ^^^^^^^^^^^^
> 
> $ git status
> # On branch master
> # Your branch is ahead of 'origin/master' by 1 commit.
>                                           ^^^^^^^^^^^

Hmm. My guess is that the new "check for connectivity when leaving
detached HEAD" test is polluting the commit flags for the ahead/behind
test.

[bisect bisect bisect]

Yep, it bisects to 8e2dc6a (commit: give final warning when reattaching
HEAD to leave commits behind, 2011-02-18). We probably need to clean the
uninteresting flags between the two traversals.

-Peff
