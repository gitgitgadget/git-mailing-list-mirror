From: Sam Vilain <sam@vilain.net>
Subject: Re: Efficiency and correctness patches for git-svn mergeinfo
 support
Date: Mon, 21 Dec 2009 10:07:20 +1300
Message-ID: <1261343240.20752.20.camel@denix>
References: <1261240435-8948-1-git-send-email-sam@vilain.net>
	 <6b2f9b1d0912191415n560a5a58xbe6390b1fcade854@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>
To: Andrew Myrick <amyrick@gmail.com>
X-From: git-owner@vger.kernel.org Sun Dec 20 22:07:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NMT02-0004fo-E6
	for gcvg-git-2@lo.gmane.org; Sun, 20 Dec 2009 22:07:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753985AbZLTVHc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Dec 2009 16:07:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753745AbZLTVHb
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Dec 2009 16:07:31 -0500
Received: from watts.utsl.gen.nz ([202.78.240.73]:57845 "EHLO mail.utsl.gen.nz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753838AbZLTVHa (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Dec 2009 16:07:30 -0500
Received: by mail.utsl.gen.nz (Postfix, from userid 1004)
	id CC05521C41D; Mon, 21 Dec 2009 10:07:26 +1300 (NZDT)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on
	mail.musashi.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=5.0 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.2.5
Received: from [192.168.69.234] (203-97-235-49.cable.telstraclear.net [203.97.235.49])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.utsl.gen.nz (Postfix) with ESMTPSA id 1200621C3F6;
	Mon, 21 Dec 2009 10:07:21 +1300 (NZDT)
In-Reply-To: <6b2f9b1d0912191415n560a5a58xbe6390b1fcade854@mail.gmail.com>
X-Mailer: Evolution 2.28.0 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135535>

On Sat, 2009-12-19 at 14:15 -0800, Andrew Myrick wrote:
> I tried cloning from a fairly recent revision that I knew was after
> our switchover to svn 1.5, and I received a number of these errors:
> 
>    Couldn't find revmap for [branch]
>    Exiting subroutine via next at /Users/adm/libexec/git-core/git-svn line 2983.
>    Exiting subroutine via next at /Users/adm/libexec/git-core/git-svn line 2983.
>    Exiting subroutine via next at /Users/adm/libexec/git-core/git-svn line 2983.
> 
> I'm not sure if this is expected, since I didn't clone from the whole
> repo, but it did cause a lot of spew.  I'm starting a fresh clone now,
> but it takes a few days to get through the whole repository.  I'm
> fairly new to git, so I would welcome any tips on how I can test this
> more quickly.

Whoops, no, not expected, I'll post a minor correction.  That means that
the branch which was merged in does not have git-svn metadata; ie, it's
not being tracked explicitly.  If people are doing merging of things
which aren't roots of branches you would expect this.  SVN, like
Perforce, supports a confusing amount of flexibility in its merge
tracking.  If [branch] is a real branch, then you'll want to see why it
doesn't have metadata yet.  Is it really a sub-tree of a real branch?
You could fetch it independently using a separate git-svn remote, or you
could ignore the warning; it should be relatively self-evident what
happened from the merge message and the contents of the changeset.

Note if your repository was significantly re-organized at any point, it
will pay to treat each section of history as a separate import project,
and stitch the results together afterwards using grafts and
filter-branch.

This version should be *significantly* faster than the old one.  ie, it
should not take a minute per commit while importing the heavily
merged-into integration branch.  Possibly a few seconds at most.

Sam
