From: Jeff King <peff@peff.net>
Subject: Re: Insertions/Deletions summary for a contributor
Date: Thu, 29 Oct 2009 12:01:57 -0400
Message-ID: <20091029160156.GA7622@sigill.intra.peff.net>
References: <a362e8010910282344vad53b7ck1b7ae04ff3c499ed@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Laszlo Papp <djszapi@archlinux.us>
X-From: git-owner@vger.kernel.org Thu Oct 29 17:02:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N3XRu-00022o-Lt
	for gcvg-git-2@lo.gmane.org; Thu, 29 Oct 2009 17:02:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753111AbZJ2QB4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Oct 2009 12:01:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753099AbZJ2QB4
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Oct 2009 12:01:56 -0400
Received: from peff.net ([208.65.91.99]:41313 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752875AbZJ2QBz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Oct 2009 12:01:55 -0400
Received: (qmail 22577 invoked by uid 107); 29 Oct 2009 16:05:39 -0000
Received: from 65-121-75-131.dia.static.qwest.net (HELO sigill.intra.peff.net) (65.121.75.131)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Thu, 29 Oct 2009 12:05:39 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 29 Oct 2009 12:01:57 -0400
Content-Disposition: inline
In-Reply-To: <a362e8010910282344vad53b7ck1b7ae04ff3c499ed@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131606>

On Thu, Oct 29, 2009 at 07:44:40AM +0100, Laszlo Papp wrote:

> It would be nice to see summary for a contributor in insertions/deletions
> lines, changed files regard, in the life of the whole project.
> 
> So the output would be the summary of the following output lines:
> git log --author="Laszlo Papp" --pretty=tformat: --numstat
> 
> Can I deal with it, does it make sense, what do you think about it ?

Try piping the output of the command above through:

  perl -ane '
        $add{$F[2]} += $F[0];
        $del{$F[2]} += $F[1];
        END { print "$add{$_} $del{$_} $_\n" foreach sort keys(%add) }
  '

but keep in mind that such a summary is not necessarily a useful value.
Modified lines are represented as deletion and add, and you may simply
be deleting and adding the same lines over and over again. :)

A more interesting summary is to "git blame" files and count
contributor lines. This shows content by that contributor which has
survived to the current tree.

-Peff
