From: Jeff King <peff@peff.net>
Subject: Re: Question regarding: git pull --no-commit origin
Date: Sun, 25 Mar 2007 21:47:58 -0400
Message-ID: <20070326014757.GA28592@coredump.intra.peff.net>
References: <93c3eada0703251632s3be48b60na03728ce72b8ab8c@mail.gmail.com> <20070325233823.GA13247@spearce.org> <93c3eada0703251816lc430e03l71ee2ffaa3d8796@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Geoff Russell <geoffrey.russell@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 26 03:48:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HVeJr-0006rz-DC
	for gcvg-git@gmane.org; Mon, 26 Mar 2007 03:48:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933282AbXCZBsD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 25 Mar 2007 21:48:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933290AbXCZBsD
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Mar 2007 21:48:03 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2952 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933282AbXCZBsB (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Mar 2007 21:48:01 -0400
Received: (qmail 22894 invoked from network); 26 Mar 2007 01:48:30 -0000
Received: from coredump.intra.peff.net (10.0.0.2)
  by peff.net with (DHE-RSA-AES128-SHA encrypted) SMTP; 26 Mar 2007 01:48:30 -0000
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 25 Mar 2007 21:47:58 -0400
Content-Disposition: inline
In-Reply-To: <93c3eada0703251816lc430e03l71ee2ffaa3d8796@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43104>

On Mon, Mar 26, 2007 at 10:46:09AM +0930, Geoff Russell wrote:

> If --no-commit won't let me do this then perhaps I need something like:
> 
>          git pull origin:testing
>          git checkout testing
>           .... test
>          git checkout master ; git pull . testing

Close.  Remember that a pull is basically a fetch + merge; so your first
command is just the fetch:

  # fetches everything from origin
  git fetch
  # see what they have that we don't
  git whatchanged HEAD..origin/testing
  # check out their code in more detail
  git checkout origin/testing
  # or even make our own branch in case we have tweaks to make
  git checkout -b testing origin/testing
  # and once we're OK, do the merge
  git checkout master; git merge origin/testing

All of that assumes git 1.5 or greater, which uses the separate remote
layout and has some interface improvements. For older versions, their
'testing' branch will be pulled into your 'testing' branch, and I
believe you will need to 'git pull . testing' to merge it.

-Peff
