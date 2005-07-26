From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] git-cvsimport-script: parse multidigit revisions
Date: Tue, 26 Jul 2005 15:01:00 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0507261451240.19309@g5.osdl.org>
References: <20050712213531.GA10936@pc117b.liacs.nl> <20050713011818.GM9915@kiste.smurf.noris.de>
 <Pine.LNX.4.58.0507251544300.6074@g5.osdl.org> <20050725234257.GC5680@kiste.smurf.noris.de>
 <Pine.LNX.4.58.0507251922310.6074@g5.osdl.org> <Pine.LNX.4.58.0507252028220.6074@g5.osdl.org>
 <42E6AF1C.9050606@cobite.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Matthias Urlichs <smurf@smurf.noris.de>,
	Sven Verdoolaege <skimo@liacs.nl>,
	Git Mailing List <git@vger.kernel.org>,
	David Mansfield <cvsps@dm.cobite.com>
X-From: git-owner@vger.kernel.org Wed Jul 27 00:05:27 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DxXXs-0002uV-Of
	for gcvg-git@gmane.org; Wed, 27 Jul 2005 00:05:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262074AbVGZWEe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Jul 2005 18:04:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262170AbVGZWEd
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Jul 2005 18:04:33 -0400
Received: from smtp.osdl.org ([65.172.181.4]:195 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262074AbVGZWDT (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 26 Jul 2005 18:03:19 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j6QM11jA022514
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 26 Jul 2005 15:01:02 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j6QM103q016170;
	Tue, 26 Jul 2005 15:01:01 -0700
To: David Mansfield <david@cobite.com>
In-Reply-To: <42E6AF1C.9050606@cobite.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.113 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


Ahh, the cobite.com address worked ;)

David, as you may or may not be aware, the dm.cobite.com address was 
bouncing at least as of yesterday.

On Tue, 26 Jul 2005, David Mansfield wrote:
> 
> It 'smells' wierd to have to revisions in the same patchset at all, but
> I suppose you've all been through that before.

It seems to be just a result of how BK ends up having this internal notion
of a "delta", and one commit can contain multiple deltas to the same file.
That's really just some BK internal implementation issue showing through -
the deltas really aren't even individually accessible, it's just that BK
has this two-stage commit thing where you first commit the individual file
changes (the "delta") and then you do the _real_ commit which gathers them
all up.

Normally you don't even see this at all, since the tools basically hide 
this, but especially if you script things you'll see the difference.

In fact, in many ways the usage model when scripting ends up being a bit
like the git two-phase "git-update-cache" + "git commit" approach,
although for totally different reasons. But unlike git, you can actually
tell how somebody did several updates on the same file, and it seems to
show through in the bkcvs archives.

I bet that it wasn't even intentional, and that it's really just a result
of the bkcvs thing really just being pretty much a raw SCCS->RCS
translation (with the addition of the "changeset" notion at a higher
level).

So normally you'd not like to see this unless you use the --bkcvs flag,
but I suspect that with a big fuzz-factor and repeated commit messages you
can see it even with a perfectly normal CVS tree - if only because cvsps
might collapse two separate commits that shouldn't really be collapsed.

			Linus
