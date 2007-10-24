From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: best git practices, was Re: Git User's Survey 2007 unfinished
	summary continued
Date: Wed, 24 Oct 2007 15:20:58 -0400
Message-ID: <20071024192058.GF29830@fieldses.org>
References: <Pine.LNX.4.64.0710212308540.25221@racer.site> <471C586A.9030900@op5.se> <Pine.LNX.4.64.0710221156540.25221@racer.site> <471C9B13.9080603@op5.se> <Pine.LNX.4.64.0710221445170.25221@racer.site> <471CB443.9070606@op5.se> <8fe92b430710221635x752c561ejcee14e2526010cc9@mail.gmail.com> <92320AA3-6D23-4967-818D-F7FA3962E88D@zib.de> <Pine.LNX.4.64.0710231155321.25221@racer.site> <90325C2E-9AF4-40FB-9EFB-70B6D0174409@zib.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jakub Narebski <jnareb@gmail.com>,
	Andreas Ericsson <ae@op5.se>,
	Federico Mena Quintero <federico@novell.com>,
	git@vger.kernel.org
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Wed Oct 24 21:21:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IklnB-0000qE-9g
	for gcvg-git-2@gmane.org; Wed, 24 Oct 2007 21:21:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753617AbXJXTVK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Oct 2007 15:21:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753708AbXJXTVJ
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Oct 2007 15:21:09 -0400
Received: from mail.fieldses.org ([66.93.2.214]:42093 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753599AbXJXTVH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Oct 2007 15:21:07 -0400
Received: from bfields by fieldses.org with local (Exim 4.68)
	(envelope-from <bfields@fieldses.org>)
	id 1Iklmk-00005h-90; Wed, 24 Oct 2007 15:20:58 -0400
Content-Disposition: inline
In-Reply-To: <90325C2E-9AF4-40FB-9EFB-70B6D0174409@zib.de>
User-Agent: Mutt/1.5.16 (2007-06-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62227>

On Wed, Oct 24, 2007 at 08:48:54PM +0200, Steffen Prohaska wrote:
> The central shared repo is called project-shared.git and contains,
> for example, the following branches:
>    master
>    next
>    work/topicA
>    work/topicB
>    ...
>
>
> Developers clone the repo and check out the branches they are
> interested in. For example a developer may want to track next
> and work on topicB:
>
>    git clone ssh://central.example.com/project-shared.git project
>    cd project
>    git checkout -b next origin/next
>    git checkout -b work/topicB origin/work/topicB
>
> This is sufficient. No adding of remotes is needed. Neither
> is a private repository on a server required. After cloning,
> developers have all they need.
>
> Later work/topicB has new commits and should be pushed:
>
>    git push origin
>
> The default behaviour of push is fine. Only matching branches
> are pushed.
>
> _But_, origin is a shared repository. Therefore branches may
> have advanced and git push may report
>
> error: remote 'refs/heads/next' is not a strict subset of local ref 
> 'refs/heads/next'. maybe you are not up-to-date and need to pull first?
>
> So here's the problem. The developer didn't do anything wrong.
> But git complaints with an error. Git also recommends to run
> pull, so the developer runs "git pull". But this doesn't help,
> because it's only updating work/topicB and "git push" will
> complain with the very same error.
>
> What you need to do is
>
>    git checkout <local-branch>
>    git pull
>    git checkout <local-branch2>
>    git pull
>    ...
>
> for every local branch.

Or just

	git push origin work/topicB

since that's all you really wanted to push anyway.

> The problem described can only happen with a shared repository.
> In a workflow that pulls from read-only repos and pushes to a
> private repo that is read-only for others, such a problem cannot
> happen. Because in a non-shared repository the branches cannot
> be advanced by others. But in a shared repository they can.

Actually I push to my public repo from multiple working repositories
(because usually I work on my laptop, but sometimes I do work from a
different machine), so the above can still happen.

--b.
