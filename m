From: Eric Wong <normalperson@yhbt.net>
Subject: Re: Malformed network data
Date: Wed, 11 Feb 2009 02:23:29 -0800
Message-ID: <20090211102329.GA10762@dcvr.yhbt.net>
References: <6a7129610902060729ta73d8d6leb4dc64ce2bb7fe3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Josh Sharpe <josh.m.sharpe@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 11 11:25:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXCH4-0004tL-40
	for gcvg-git-2@gmane.org; Wed, 11 Feb 2009 11:24:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754441AbZBKKXa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Feb 2009 05:23:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752432AbZBKKXa
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Feb 2009 05:23:30 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:50977 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752086AbZBKKX3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Feb 2009 05:23:29 -0500
Received: from localhost (unknown [127.0.2.5])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4A0CA1F798;
	Wed, 11 Feb 2009 10:23:29 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <6a7129610902060729ta73d8d6leb4dc64ce2bb7fe3@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109399>

Josh Sharpe <josh.m.sharpe@gmail.com> wrote:
> I was originally using ubuntu's package of git and git-svn (1.5.6.3)
> and had the following Malformed Network Data error occuring at the
> same spot.
> 
> I've since built svn and git so that I'm using the latest versions of
> each svn: 1.5.5 and git: 1.6.1.2.390.gba743
> 
> With the latest version I got a new error during the initial clone
> followed by the original error.
> 
> One thing to note that I thought was odd.  The clone starts at ~r977
> and proceeded through about ~r1100 before starting over at r1 and
> running all the way up to the code you see below (r1116)

Hi,

This could be the way branching/tagging is done with the repo.
git-svn does not handle non-standard branching/tagging practices
very well.

> Following parent with do_switch
> Filesystem has no item: File not found: revision 1036, path
> '/branches/current_demo/sample_data/email_templates.yml' at
> /usr/local/libexec/git-core/git-svn line 3288

Hmm.. this is new. Is email_templates.yml an empty file by any chance?
If it's an empty file, can you try pulling the latest from
git://git.bogomips.org/git-svn and see if that fixes at least this for
you?  There was a bug that slipped in recently with trying to handle
empty files better to workaround a bug in SVN.

> $ cd community_service/
> $ git svn fetch
> 
> Found possible branch point: svn+ssh://.../community_service/trunk =>
> svn+ssh://.../community_service/branches/current_demo, 1118
> Found branch parent: (current_demo) ab725a6c32905b6d007fcd8fd4723058d9487706
> Index mismatch: e8075b5d0694a738392d84016922eca87db65dcd !=
> 44b21b4a4fa70455621da3ac159cdf42c8c59987
> rereading ab725a6c32905b6d007fcd8fd4723058d9487706
> Following parent with do_switch
> Malformed network data: Malformed network data at
> /usr/local/libexec/git-core/git-svn line 3288

The malformed network data error has not been consistently reproducible
for me.  I've seen it occasionally on overloaded servers, but it always
goes away when I restarted git-svn or tried to reproduce it.  I'm
guessing it is FD mangling and/or refcount mismanagement in the SVN perl
libraries (which don't seem to be able to handle multiple connections to
a server well at all).

-- 
Eric Wong
