From: Eric Wong <normalperson@yhbt.net>
Subject: Re: git svn pointing at svn branch instead of trunk?
Date: Sat, 22 Aug 2009 13:46:27 -0700
Message-ID: <20090822204627.GA22484@dcvr.yhbt.net>
References: <2729632a0908221140p532a3c29k90af7b4cbd25d65e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: skillzero@gmail.com
X-From: git-owner@vger.kernel.org Sat Aug 22 22:46:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MexTw-0008Et-9v
	for gcvg-git-2@lo.gmane.org; Sat, 22 Aug 2009 22:46:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753922AbZHVUq1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Aug 2009 16:46:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753379AbZHVUq1
	(ORCPT <rfc822;git-outgoing>); Sat, 22 Aug 2009 16:46:27 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:60708 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752433AbZHVUq1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Aug 2009 16:46:27 -0400
Received: from localhost (user-118bg0q.cable.mindspring.com [66.133.192.26])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by dcvr.yhbt.net (Postfix) with ESMTPSA id 100DB1F5F3;
	Sat, 22 Aug 2009 20:46:29 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <2729632a0908221140p532a3c29k90af7b4cbd25d65e@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126820>

skillzero@gmail.com wrote:
> When I used git svn to clone a repository, it ended up pointing master
> at a tag in svn instead of trunk. For example, git svn info shows the
> URL for the tag instead of trunk. git log master also shows the most
> recent commit is the creation of that tag in svn, but then the next
> commit is the most recent commit to trunk. It's like it's mixing
> things from the tag with things from trunk. The most recent commit in
> svn was to create the tag that master is now pointing to in case that
> matters.

Hi,

So you have something like this?

----------trunk
              \
               \-> tag

It looks like it's mixed but that's because trunk is an ancestor of your
tag, so the majority of commits (see git-svn-id:) look like they're from
trunk except the latest git-svn-id: which should have the URL of the tag
in it.  So in short, everything here is OK.

> Is there something in the svn repository that might cause this? What's
> the correct way to reset what git svn thinks master should point to?
> And how should I get rid of the commit on master that created the tag
> without messing up git svn (e.g. can I just git reset or will that
> confuse git svn later?).

I changed this recently in b186a261b1f7ec1fbda8c5f6d84595f3a7716d92
git svn used to always pick the newest change in the entire SVN repo
to point master to, now it'll attempt to find "trunk" to be master.

You can git reset anything on your master without affecting git svn.

If you have commits on master, just cherry pick them to a new branch
that's based off trunk and then reset master to be that new branch.

-- 
Eric Wong
