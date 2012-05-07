From: Jeff King <peff@peff.net>
Subject: Re: Broken Repo
Date: Mon, 7 May 2012 03:49:17 -0400
Message-ID: <20120507074917.GE18812@sigill.intra.peff.net>
References: <4FA74355.3020704@joezimjs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Joe Zim <contact@joezimjs.com>
X-From: git-owner@vger.kernel.org Mon May 07 09:49:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SRIhC-000736-0A
	for gcvg-git-2@plane.gmane.org; Mon, 07 May 2012 09:49:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754721Ab2EGHtV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 May 2012 03:49:21 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:60457
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753021Ab2EGHtU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 May 2012 03:49:20 -0400
Received: (qmail 17839 invoked by uid 107); 7 May 2012 07:49:38 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 07 May 2012 03:49:38 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 07 May 2012 03:49:17 -0400
Content-Disposition: inline
In-Reply-To: <4FA74355.3020704@joezimjs.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197241>

On Sun, May 06, 2012 at 10:36:53PM -0500, Joe Zim wrote:

> Hi, I'm new here. I'm using Github right now. I have a repository
> there and a local copy on my Windows 7 PC. I made a change, committed
> it, then attempted to push it. I got a strange error that I can't
> remember. Anyway, after several attempts I decided to just delete the
> local repository, restore it from github and try again later. I
> realize now that there were other ways this should have been handled,
> but right now it doesn't matter. I can't figure out how to restore a
> copy from Github and make this renewed repo the master branch. Can
> anyone give me a detailed, step by step answer please?

I don't quite understand your question. You deleted the original
repository, which I assume means you removed the whole working tree. So
can you not "git clone" the original repository again and redo your
work?

Or did you remove only the ".git" directory, leaving your modified
working tree in place? If that is the case, you probably want:

  # turn your directory back into a git repository
  cd $your_project
  git init

  # fetch the existing work again
  git remote add origin $your_remote_url
  git fetch

  # now tell git that we are basing our branch on the upstream master.
  # We must make sure not to use "--hard" here, because that would
  # overwrite the working tree.
  git reset origin/master

At this point you should be able to use "git status" to see your
changes, and commit as normal. You might also want to run:

  git branch --set-upstream master origin/master

to make "git pull" work without any arguments. This setup is done
automatically by "git clone", but not by the manual init+fetch we did
above.

-Peff
