From: Eric Wong <normalperson@yhbt.net>
Subject: Re: git-svn problem with v1.6.5
Date: Wed, 11 Nov 2009 12:22:01 -0800
Message-ID: <20091111202201.GA10351@dcvr.yhbt.net>
References: <4AF9E7FE.3060701@obry.net> <32541b130911101428t50038cfcsf37e3ea9edb26f64@mail.gmail.com> <4AFA91BB.7050402@obry.net> <32541b130911111141n7b029b1ep68656d2eb39be3c7@mail.gmail.com> <4AFB1756.7090708@obry.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Avery Pennarun <apenwarr@gmail.com>, adambrewster@gmail.com,
	git list <git@vger.kernel.org>
To: Pascal Obry <pascal@obry.net>
X-From: git-owner@vger.kernel.org Wed Nov 11 21:22:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N8Jhg-00088f-68
	for gcvg-git-2@lo.gmane.org; Wed, 11 Nov 2009 21:22:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757497AbZKKUV5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Nov 2009 15:21:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757315AbZKKUV5
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Nov 2009 15:21:57 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:51794 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757261AbZKKUV4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Nov 2009 15:21:56 -0500
Received: from localhost (unknown [127.0.2.5])
	by dcvr.yhbt.net (Postfix) with ESMTP id 403B31F605;
	Wed, 11 Nov 2009 20:22:02 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <4AFB1756.7090708@obry.net>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132696>

Pascal Obry <pascal@obry.net> wrote:
> Avery,
>
>> Well, that's bad news.  Does "git log --all --parents | grep
>> d2cf08bb67e4b7da33a250127aab784f1f2f58d3" reveal any places that refer
>> to it?
>
> No.

Weird...

>> It sounds a bit like your git-svn thinks something maps on to that
>> commit id, but a previous 'git gc' or something has thrown it away.
>> However, that doesn't explain why earlier git versions don't have this
>> problem.
>
> Maybe, but that would be a quite annoying bug!

>> If you retrieve the latest version of git and then git revert the
>> above commit, does that fix the problem, at least?
>
> I cannot, this does not revert cleanly and I don't know how to properly  
> resolve this conflict. I'm no Perl expert!
>
> But reverting using the version just before fixes this problem.

That should rule out filesystem corruption...

>> Is it possible you have some weird branches outside of the
>> refs/remotes tree (either in .git itself, or in .git/refs/*) that you
>> forgot about, and which the new version of git-svn is finding somehow?
>
> I do not see something under .git/refs/* (only empty directories).
>
> The project has been imported using something like this:
>
>  $ git svn clone --prefix=svn/ svn+ssh://server/path \
> 	--revision=580:HEAD \
> 	--trunk=trunk/project \
> 	--tags=tags/project \
> 	--branches=branches/project \
> 	--branches="branches/global/*/project" project

It looks like you didn't use any of the weird[1] options that make it
unsafe to clobber the rev_maps.  Can you try removing all the .rev_map.*
files in $GIT_DIR/svn and running "git svn fetch" to rebuild them?

[1] --no-metadata, --use-svm-props
-- 
Eric Wong
