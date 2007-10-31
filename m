From: Eric Wong <normalperson@yhbt.net>
Subject: Re: Possible bug: git-svn leaves broken tree in case of error
Date: Wed, 31 Oct 2007 00:55:24 -0700
Message-ID: <20071031075524.GB7798@muzzle>
References: <1193729426.30755.32.camel@asl.dorms.spbu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Anton Korobeynikov <asl@math.spbu.ru>
X-From: git-owner@vger.kernel.org Wed Oct 31 08:55:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1In8QN-0005yz-CC
	for gcvg-git-2@gmane.org; Wed, 31 Oct 2007 08:55:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753231AbXJaHz0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Oct 2007 03:55:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752518AbXJaHz0
	(ORCPT <rfc822;git-outgoing>); Wed, 31 Oct 2007 03:55:26 -0400
Received: from hand.yhbt.net ([66.150.188.102]:44595 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753230AbXJaHzZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Oct 2007 03:55:25 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id 224587DC0FE;
	Wed, 31 Oct 2007 00:55:25 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1193729426.30755.32.camel@asl.dorms.spbu.ru>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Anton Korobeynikov <asl@math.spbu.ru> wrote:
> Hello, Everyone.
> 
> I noticed this bug several times. Consider the following conditions are
> met:
> - We're syncing from svn using git-svn :)
> - We have authors file provided
> - We have a changeset with author unlisted in the authors file.
> 
> git-svn dies due to the following code:
> sub check_author {
>         my ($author) = @_;
>         if (!defined $author || length $author == 0) {
>                 $author = '(no author)';
>         }
>         if (defined $::_authors && ! defined $::users{$author}) {
>                 die "Author: $author not defined in $::_authors file\n";
>         }
>         $author;
> }
> 
> Unfortunately it leaves repository in some middle state: git-svn itself
> thinks, that it synced with everything, but git itself doesn't "see" any
> changesets anymore. I found no way to repair tree after such situation,
> so I had to repull from scratch.
> 
> I found myself, that this should be warning (and fix in this case is
> trivial), not error (maybe some commandline switch to control behaviour,
> etc). It can be even error, but breaking tree is definitely bug in this
> case.

You should be able to change the numbers in *-maxRev back to
an old revision in .git/svn/.metadata.  Does that fix things for you
so you can resume synching again?

I'll have to investigate the die()-ing of check_authors since
that should cause git-svn to quit before the maxRev numbers
get incremented.

-- 
Eric Wong
