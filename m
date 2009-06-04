From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH 2/2] Add 'git svn reset' to unwind 'git svn fetch'
Date: Wed, 3 Jun 2009 17:24:06 -0700
Message-ID: <20090604002406.GB8882@dcvr.yhbt.net>
References: <1243732627-82282-1-git-send-email-ben@ben.com> <1243732627-82282-2-git-send-email-ben@ben.com> <20090601174943.GA80846@kronos.home.ben.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com
To: Ben Jackson <ben@ben.com>
X-From: git-owner@vger.kernel.org Thu Jun 04 02:24:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MC0ki-0002cT-9H
	for gcvg-git-2@gmane.org; Thu, 04 Jun 2009 02:24:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753977AbZFDAYH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Jun 2009 20:24:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753489AbZFDAYF
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Jun 2009 20:24:05 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:52655 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751091AbZFDAYF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jun 2009 20:24:05 -0400
Received: from localhost (unknown [127.0.2.5])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7A0591F7D1;
	Thu,  4 Jun 2009 00:24:06 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20090601174943.GA80846@kronos.home.ben.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120669>

Ben Jackson <ben@ben.com> wrote:
> On Sat, May 30, 2009 at 06:17:07PM -0700, Ben Jackson wrote:
> > Add a command to unwind the effects of fetch by moving the rev_map
> > and refs/remotes/git-svn back to an old SVN revision.
> 
> I just realized this morning that I didn't do any special handling for
> bad revision input.  I will submit a revised patch.  In the mean time
> I would still like feedback on the concept and the docs.

Hi Ben,

Sorry for the late response, I've been distracted with other projects.
I like the overall idea of it, it would actually be useful for
developing/debugging git-svn as well :)

> Known issues:
> 
> 1.  Garbage revision input is accepted and prints several internal errors
> before bombing out.  The repo is not harmed, though.
> 
> 2.  Huge revision numbers cause git-svn to spin for quite a while because
> I used the pre-existing find_rev_before which is a linear search.

find_rev_before can certainly be improved.  I haven't noticed
performance issues with it myself, but you should be able to improve it.

> 3.  Without --parent it should probably fail for a nonexistent rev rather
> than automatically find_rev_before..

Probably best to ignore the --parent flag and just pass 1 as the second
argument to find_rev_before.  That's how SVN operations work when a
non-exact revision is specified..

-- 
Eric Wong
