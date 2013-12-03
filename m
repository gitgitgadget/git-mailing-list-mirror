From: John Keeping <john@keeping.me.uk>
Subject: Re: Branching workflow
Date: Tue, 3 Dec 2013 18:42:50 +0000
Message-ID: <20131203184250.GB3163@serenity.lan>
References: <CALZVapnjN_69y0+PLFA2t8b72WDK+D4BhjDRnRPxU_9iX+_NuA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Javier Domingo <javierdo1@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 03 19:43:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vnuw1-0000zV-1k
	for gcvg-git-2@plane.gmane.org; Tue, 03 Dec 2013 19:43:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753822Ab3LCSm5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Dec 2013 13:42:57 -0500
Received: from coyote.aluminati.org ([72.9.247.114]:34326 "EHLO
	coyote.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753490Ab3LCSm4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Dec 2013 13:42:56 -0500
Received: from localhost (localhost [127.0.0.1])
	by coyote.aluminati.org (Postfix) with ESMTP id 156A6606528;
	Tue,  3 Dec 2013 18:42:56 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at caracal.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -2.9
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_00=-1.9] autolearn=no
Received: from coyote.aluminati.org ([127.0.0.1])
	by localhost (coyote.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id trNXqkuAzUdM; Tue,  3 Dec 2013 18:42:55 +0000 (GMT)
Received: from serenity.lan (mink.aluminati.org [10.0.7.180])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by coyote.aluminati.org (Postfix) with ESMTPSA id AF808198050;
	Tue,  3 Dec 2013 18:42:52 +0000 (GMT)
Content-Disposition: inline
In-Reply-To: <CALZVapnjN_69y0+PLFA2t8b72WDK+D4BhjDRnRPxU_9iX+_NuA@mail.gmail.com>
User-Agent: Mutt/1.5.22 (2013-10-16)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238712>

On Tue, Dec 03, 2013 at 07:06:20PM +0100, Javier Domingo wrote:
> I have been using a very basic workflow for branching, features each
> in a branch.
> 
> My branches would be:
> - develop <= Main upstream branch
> - feature/* fix/*  <= Feature and fix branches
> - master <= Integration of the whole feature and fix branches
> 
> So I have now came up with a very difficult task. I just discovered
> that one of those branches, lest call it feature/bad, is evil and is
> making the integration branch (master) fail horribly.
> 
> In my workflow, I tend to merge develop (official updates) into my
> feature branches, and them into master.
> 
> So now I have the big problem on how to undo all changes from
> feature/fix. I have been told that one alternative workflow would be
> to revert the last merge and remerge it into master, so that I have
> always just one commit to revert if necessary (instead of the
> monstrous quantity I have now to).
> 
> The workflow proposal should be in order of importance:
> - Let me stay up-to-date with develop branch
> - Easy to revert in master
> - Have a clean history
> - Easy to follow
> 
> I think I should be capable of doing some sort of merge/rebase
> branching workflow to avoid having to do that. I have thought about
> rebasing always the feature branches, and rebasing master into all of
> them, but it seems pretty strange to me.
> 
> If anyone can give any advice, I would fully appreciate!

It sounds like you want a throwaway integration branch.  This is similar
to the workflow Junio uses with git.git's "pu" branch, which involves
rebuilding a branch by:

    * resetting it to some base ("develop" in your case)
    * merging in the required feature branches

This may not quite be what you want because it does mean that you cannot
build on the integration branch - it is intended to be rewritten often,
but it does provide a good platform for testing features and then
merging them to a stable branch once they have proved to be good.

The advantage is that you know that the integration merges are temporary
and you can test on top of that without having set the result in stone.

<shameless plug>If you are interested in such a workflow then you may
want to try my git-integration program [1] to manage integration
branches.

There is also a reimplementation in Ruby with a slightly different
feature set [2]

[1] http://johnkeeping.github.io/git-integration
[2] http://github.com/felipec/git-reintegrate
