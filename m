From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] gitweb: Do not show 'patch' link in 'commit' view for
 merges
Date: Thu, 1 Oct 2009 03:55:40 -0400
Message-ID: <20091001075540.GA13436@coredump.intra.peff.net>
References: <20090930201953.22301.73887.stgit@localhost.localdomain>
 <20091001031140.GA30094@coredump.intra.peff.net>
 <200910010936.24789.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 01 09:56:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MtGWW-0002Gw-GJ
	for gcvg-git-2@lo.gmane.org; Thu, 01 Oct 2009 09:56:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755709AbZJAHzp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Oct 2009 03:55:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755697AbZJAHzo
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Oct 2009 03:55:44 -0400
Received: from peff.net ([208.65.91.99]:43119 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755653AbZJAHzo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Oct 2009 03:55:44 -0400
Received: (qmail 13772 invoked by uid 107); 1 Oct 2009 07:59:12 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Thu, 01 Oct 2009 03:59:12 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 01 Oct 2009 03:55:40 -0400
Content-Disposition: inline
In-Reply-To: <200910010936.24789.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129379>

On Thu, Oct 01, 2009 at 09:36:23AM +0200, Jakub Narebski wrote:

> From the point of view of code, 'patch' view is handled by git_patch()
> subroutine, which in turn calls git_commitdiff(-format => 'patch', -single=> 1);
> git_commitdiff checks if 'patch' view is enabled feature, and then 
> composes and calls the following command (I have skipped --git-dir=...):
> 
>   git format-patch --encoding=utf8 --stdout -1 --root <commit-id>
> 
> And git-format-patch produces no output for merge commit.  Then 
> git_commitdiff dumps output of git-format-patch

Ah, OK, I see the code path you are talking about now. My first thought
was "shouldn't it be handling the merge case?" but that really doesn't
make any sense. The "patch" view is just about something that can be
given to "git am", and it doesn't understand merges anyway. And the
"commitdiff" and "html" formats already handle it appropriately.

So I think your patch is the right thing to do. Thanks for the
explanation.

-Peff
