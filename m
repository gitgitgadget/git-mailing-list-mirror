From: Jeff King <peff@peff.net>
Subject: Re: "git add -u" broken in git 1.7.4?
Date: Sun, 6 Feb 2011 00:13:33 -0500
Message-ID: <20110206051333.GA3458@sigill.intra.peff.net>
References: <4D4DEDC4.4080708@hartwork.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git ML <git@vger.kernel.org>
To: Sebastian Pipping <webmaster@hartwork.org>
X-From: git-owner@vger.kernel.org Sun Feb 06 06:13:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PlwwS-0004lk-JM
	for gcvg-git-2@lo.gmane.org; Sun, 06 Feb 2011 06:13:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751380Ab1BFFNj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Feb 2011 00:13:39 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:33158 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750964Ab1BFFNj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Feb 2011 00:13:39 -0500
Received: (qmail 19085 invoked by uid 111); 6 Feb 2011 05:13:37 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Sun, 06 Feb 2011 05:13:37 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 06 Feb 2011 00:13:33 -0500
Content-Disposition: inline
In-Reply-To: <4D4DEDC4.4080708@hartwork.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166141>

On Sun, Feb 06, 2011 at 01:39:32AM +0100, Sebastian Pipping wrote:

> I just ran into case where
> 
>   git add -u
> 
> repetedly did not update the index.  In contrast, picking stuff using
> 
>   git add -p
> 
> works just fine.
> 
> Could it be "git add -u" is broken in git 1.7.4?

It could be. However, I can think of one such case where you might see
that behavior. "git add -u" operates from the current subdirectory,
whereas "git add -p" operates from the top of the project tree (yes,
this inconsistency confusing, but it's not as serious as "git add -u
doesn't work").

You can demonstrate it with:

  mkdir repo && cd repo && git init
  mkdir subdir && echo content >file
  git add . && git commit -m base
  echo more >>file

  mkdir subdir && cd subdir
  git add -u
  git status ;# still not staged for commit

  git add -p ;# finds it

Might you have been in a subdirectory of the project when you saw this
behavior?

-Peff
