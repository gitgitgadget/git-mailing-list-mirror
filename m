From: Jeff King <peff@peff.net>
Subject: Re: Any difference to unstage files using "git checkout" and "git rm"
Date: Mon, 19 May 2014 12:01:07 -0400
Message-ID: <20140519160107.GE20289@sigill.intra.peff.net>
References: <6833494.47nikG189t@linux-wzza.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Arup Rakshit <aruprakshit@rocketmail.com>
X-From: git-owner@vger.kernel.org Mon May 19 18:01:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WmQ02-0007MF-NW
	for gcvg-git-2@plane.gmane.org; Mon, 19 May 2014 18:01:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932288AbaESQBK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 May 2014 12:01:10 -0400
Received: from cloud.peff.net ([50.56.180.127]:55079 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752794AbaESQBJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 May 2014 12:01:09 -0400
Received: (qmail 25465 invoked by uid 102); 19 May 2014 16:01:09 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 19 May 2014 11:01:09 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 19 May 2014 12:01:07 -0400
Content-Disposition: inline
In-Reply-To: <6833494.47nikG189t@linux-wzza.site>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249593>

On Mon, May 19, 2014 at 09:12:47PM +0630, Arup Rakshit wrote:

> Is there any difference between the below 2 commands ? I didn't see anything.
> 
> git rm --cached  -- <file1> .. <fileN>

This one removes the index entries for those files.

> git checkout  -- <file1> .. <fileN>

This one checks out the content from the index into the working tree
(for just those files).

Try:

  # setup...
  git init
  echo content >file
  git add file
  git commit -m one

  # now rm
  git rm --cached -- file
  git status

which yields:

  rm 'file'

  On branch master
  Changes to be committed:
          deleted:    file
  
  Untracked files:
          file
  

but it we restore our state and try checkout:

  git reset
  git checkout -- file

nothing happens:

  On branch master
  nothing to commit, working directory clean

but if you had changes in the working tree:

  echo changes >file
  git status | sed 's/^/before> /'
  git checkout -- file
  git status | sed 's/^/ after> /'

you get:

  before> On branch master
  before> Changes not staged for commit:
  before>         modified:   file
  before> 
  before> no changes added to commit

   after> On branch master
   after> nothing to commit, working directory clean

Does that help?

-Peff
