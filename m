From: Eric Wong <normalperson@yhbt.net>
Subject: Re: git-svn problem with v1.6.5
Date: Wed, 11 Nov 2009 20:34:13 +0000
Message-ID: <20091111203413.GA9648@dcvr.yhbt.net>
References: <4AF9E7FE.3060701@obry.net> <32541b130911101428t50038cfcsf37e3ea9edb26f64@mail.gmail.com> <4AFA91BB.7050402@obry.net> <32541b130911111141n7b029b1ep68656d2eb39be3c7@mail.gmail.com> <4AFB1756.7090708@obry.net> <20091111202201.GA10351@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Avery Pennarun <apenwarr@gmail.com>, adambrewster@gmail.com,
	git list <git@vger.kernel.org>
To: Pascal Obry <pascal@obry.net>
X-From: git-owner@vger.kernel.org Wed Nov 11 21:34:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N8Jtb-0005fn-8h
	for gcvg-git-2@lo.gmane.org; Wed, 11 Nov 2009 21:34:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758843AbZKKUeL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Nov 2009 15:34:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758844AbZKKUeJ
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Nov 2009 15:34:09 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:46535 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758843AbZKKUeI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Nov 2009 15:34:08 -0500
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by dcvr.yhbt.net (Postfix) with ESMTPSA id 330721F605;
	Wed, 11 Nov 2009 20:34:14 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20091111202201.GA10351@dcvr.yhbt.net>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132697>

Eric Wong <normalperson@yhbt.net> wrote:
> Pascal Obry <pascal@obry.net> wrote:
> > I do not see something under .git/refs/* (only empty directories).
> >
> > The project has been imported using something like this:
> >
> >  $ git svn clone --prefix=svn/ svn+ssh://server/path \
> > 	--revision=580:HEAD \
> > 	--trunk=trunk/project \
> > 	--tags=tags/project \
> > 	--branches=branches/project \
> > 	--branches="branches/global/*/project" project
> 
> It looks like you didn't use any of the weird[1] options that make it
> unsafe to clobber the rev_maps.  Can you try removing all the .rev_map.*
> files in $GIT_DIR/svn and running "git svn fetch" to rebuild them?
> 
> [1] --no-metadata, --use-svm-props

Also, any chance you have multiple refs with "trunk" in the basename?

 git rev-parse --symbolic --all | grep '/trunk'

It could be a backwards compatibility issue with git svn looking
in multiple places for trunk.

With Adam's commit, it'll try $GIT_DIR/svn/refs/remotes/trunk/* first
Then it'll try $GIT_DIR/svn/trunk/* as a fallback.

-- 
Eric Wong
