From: Jeff King <peff@peff.net>
Subject: Re: git show on bare repository?
Date: Sun, 2 Aug 2009 00:44:03 -0400
Message-ID: <20090802044402.GA21369@coredump.intra.peff.net>
References: <2729632a0908012051i28654bb7m418ff2ed00138815@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: skillzero@gmail.com
X-From: git-owner@vger.kernel.org Sun Aug 02 06:44:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MXSvq-00058J-Rb
	for gcvg-git-2@gmane.org; Sun, 02 Aug 2009 06:44:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750830AbZHBEoI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Aug 2009 00:44:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750811AbZHBEoI
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Aug 2009 00:44:08 -0400
Received: from peff.net ([208.65.91.99]:47128 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750784AbZHBEoH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Aug 2009 00:44:07 -0400
Received: (qmail 23850 invoked by uid 107); 2 Aug 2009 04:46:16 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sun, 02 Aug 2009 00:46:16 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 02 Aug 2009 00:44:03 -0400
Content-Disposition: inline
In-Reply-To: <2729632a0908012051i28654bb7m418ff2ed00138815@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124661>

On Sat, Aug 01, 2009 at 08:51:45PM -0700, skillzero@gmail.com wrote:

> I could have sworn I used to be able to use git show to display the
> contents of a file from the server, but now it always says this (if I
> use -- then it doesn't show anything):

It should work fine.

> fatal: ambiguous argument 'master:file.txt': unknown revision or path
> not in the working tree.
> Use '--' to separate paths from revisions

Either you don't have a 'master' ref, or the commit there doesn't have
'file.txt'. Try "git show master" and "git show master^{tree}" to see
which.

It would be nice if the error were more descriptive ("master resolved,
but does not contain file.txt"). The vagueness is an artifact of the way
the code is structured, I think (we try a lot of different things and
then barf at the toplevel, which doesn't know any of the details of how
far we got into each possibility).

> What I'm trying to do is allow people to get a single file without
> having to clone the entirely repository, like this:
> 
> ssh git.example.com "cd /MyRepo.git && git show master:File.txt"

I don't know if this is a cut and past error, but you say "File" here
and "file" above. That could cause the error you are seeing.

> If I do this with a non-bare repository, it works. The server is
> running git version 1.6.3.2 (I'm running 1.6.4 locally where it
> works).

The bareness of the repo shouldn't matter, as the filename is coming
from the tree pointed to by 'master'. Unless it is a bug, it is probably
just that the refs are different between the two repos.

-Peff
