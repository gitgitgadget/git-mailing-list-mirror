From: Jeff King <peff@peff.net>
Subject: Re: Update a bare repository
Date: Tue, 17 Jul 2007 03:04:29 -0400
Message-ID: <20070717070428.GA13266@coredump.intra.peff.net>
References: <20070717063026.GA5823@cip.informatik.uni-erlangen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT <git@vger.kernel.org>
To: Thomas Glanzmann <thomas@glanzmann.de>
X-From: git-owner@vger.kernel.org Tue Jul 17 09:04:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IAh6t-0003pz-1Y
	for gcvg-git@gmane.org; Tue, 17 Jul 2007 09:04:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763312AbXGQHEd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Jul 2007 03:04:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762157AbXGQHEc
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Jul 2007 03:04:32 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4433 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760549AbXGQHEb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jul 2007 03:04:31 -0400
Received: (qmail 13350 invoked from network); 17 Jul 2007 07:04:57 -0000
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by peff.net with (DHE-RSA-AES128-SHA encrypted) SMTP; 17 Jul 2007 07:04:57 -0000
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 17 Jul 2007 03:04:29 -0400
Content-Disposition: inline
In-Reply-To: <20070717063026.GA5823@cip.informatik.uni-erlangen.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52742>

On Tue, Jul 17, 2007 at 08:30:26AM +0200, Thomas Glanzmann wrote:

> I have a _bare_ clone of a git repository and would like to update it
> from Junios repository at kernel.org from time to time.
> [...]
> "git pull" does not work. "git fetch" does, but it does update all
> references?

You don't want to pull because that involves merging, which doesn't make
sense. A git-fetch is what you want, and you can use wildcards to make
sure you get all of the refs. The default is something like this:

[remote "origin"]
  url = git://git2.kernel.org/pub/scm/git/git.git
  fetch = +refs/heads/*:refs/remotes/origin/*

However, if you are intending to make this an _exact_ copy of Junio's
(because you will be fetching from it with your other, non-bare repos),
then you probably don't want the "separate remotes" layout. You want to
copy the refs with the same names:

[remote "origin"]
  url = git://git2.kernel.org/pub/scm/git/git.git
  fetch = +refs/heads/*:refs/heads/*

The "+" in both cases means that it copies whatever Junio has, even if
it might lose some commits of yours. But that seems to be what you want
in this case.

> I also would like to check that it is impossible to push anything to the
> repository.

The simplest thing is not to give write access to the repo for your
pushers. However, you could also put in a pre-receive hook that rejects
all pushes.

-Peff
