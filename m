From: Jeff King <peff@peff.net>
Subject: Re: interactive rebase of binary files?
Date: Sat, 1 Aug 2009 01:15:59 -0400
Message-ID: <20090801051559.GA26580@sigill.intra.peff.net>
References: <530ac78e0907312058i1fbc3685qad060d5c01f5b8ac@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git <git@vger.kernel.org>
To: Phil Lawrence <prlawrence@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 01 07:16:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MX6x3-0004Lm-3O
	for gcvg-git-2@gmane.org; Sat, 01 Aug 2009 07:16:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751521AbZHAFQC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Aug 2009 01:16:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751428AbZHAFQC
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Aug 2009 01:16:02 -0400
Received: from peff.net ([208.65.91.99]:56449 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751252AbZHAFQB (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Aug 2009 01:16:01 -0400
Received: (qmail 9867 invoked by uid 107); 1 Aug 2009 05:18:09 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Sat, 01 Aug 2009 01:18:09 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 01 Aug 2009 01:15:59 -0400
Content-Disposition: inline
In-Reply-To: <530ac78e0907312058i1fbc3685qad060d5c01f5b8ac@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124607>

On Fri, Jul 31, 2009 at 10:58:58PM -0500, Phil Lawrence wrote:

> However, there is a problem with binary files.  For example, if I
> specify "edit" in the git-rebase-todo list for one of the binary file
> commits, only one version of the binary file is presented to me in the
> working copy.  If it were a text file, I'd expect to see the standard
> conflict stuff within the one file.  I'd edit and save that one file.
> However, in the case of binary files, should I not see binary_file.a
> and binary_file.b both in the working copy, so that I can compare and
> pick a winner (or edit one of them into a winner)?
> 
> More likely, my expectations are due to my ignorance, and someone can
> point me to the "git" way of doing this.  Please?

During a merge conflict, the index stages are populated with the various
versions of the file you are looking for. The simplest way to access
them is probably:

  $ git show :1:$filename ;# the common ancestor
  $ git show :2:$filename ;# upstream version
  $ git show :3:$filename ;# version from rebasing branch

It's a bit tricky to find in the documentation, though. You have to
first realize that git-rebase is basically trying to do a merge behind
the scenes, and then find the "how to resolve conflicts" section of "git
help merge". And then realize that the usual "ours" and "theirs" stages
of 2 and 3 are reversed, since you are really merging your work onto the
upstream branch. So probably there is room to improve the documentation,
but I'm not sure of the best way.

-Peff
