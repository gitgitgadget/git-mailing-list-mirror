From: Jonas Fonseca <fonseca@diku.dk>
Subject: Re: [PATCH] When renaming config sections delete conflicting sections
Date: Wed, 17 Oct 2007 12:37:26 +0200
Message-ID: <20071017103726.GA23417@diku.dk>
References: <20071017003418.GA11013@diku.dk> <20071017005517.GJ13801@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Oct 17 12:40:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ii6KK-0008S9-Ol
	for gcvg-git-2@gmane.org; Wed, 17 Oct 2007 12:40:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757703AbXJQKkZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Oct 2007 06:40:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757639AbXJQKkZ
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Oct 2007 06:40:25 -0400
Received: from mgw1.diku.dk ([130.225.96.91]:34080 "EHLO mgw1.diku.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756741AbXJQKkY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Oct 2007 06:40:24 -0400
Received: from localhost (localhost [127.0.0.1])
	by mgw1.diku.dk (Postfix) with ESMTP id D8B19968065;
	Wed, 17 Oct 2007 12:40:22 +0200 (CEST)
X-Virus-Scanned: amavisd-new at diku.dk
Received: from mgw1.diku.dk ([127.0.0.1])
	by localhost (mgw1.diku.dk [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XQHF-3v8GZ5f; Wed, 17 Oct 2007 12:40:21 +0200 (CEST)
Received: from nhugin.diku.dk (nhugin.diku.dk [130.225.96.140])
	by mgw1.diku.dk (Postfix) with ESMTP id EC4FF7A80AA;
	Wed, 17 Oct 2007 12:37:26 +0200 (CEST)
Received: from tyr.diku.dk (tyr.diku.dk [130.225.96.226])
	by nhugin.diku.dk (Postfix) with ESMTP
	id 3BF726DF84F; Wed, 17 Oct 2007 12:37:17 +0200 (CEST)
Received: by tyr.diku.dk (Postfix, from userid 3873)
	id C9E525B8001; Wed, 17 Oct 2007 12:37:26 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20071017005517.GJ13801@spearce.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61363>

Shawn O. Pearce <spearce@spearce.org> wrote Tue, Oct 16, 2007:
> Jonas Fonseca <fonseca@diku.dk> wrote:
> > The old behavior of keeping config sections matching the new name caused
> > problems leading to warnings being emitted by git-remote when renaming
> > branches where information about tracked remote branches differed. To
> > fix this any config sections that will conflict with the new name are
> > removed from the config file. Update test to check for this.
> ...
> >  This command sequence was causing problems for me:
> > 
> > 	git checkout -b test madcoder/next
> > 	git checkout -b test2 spearce/next
> > 	git branch -M test
> 
> Ouch.  But this may cause the user to lose what they might consider
> important settings relative to the old section named branch.test.

True, but to me the meaning of -M is "I know what I am doing".

> I think in the case you mention above where you are doing a
> `branch -M` the user really does want the basic branch properties
> to be forced over (branch.$name.remote, branch.$name.merge) but
> they probably do not want other branch properties to be removed
> or deleted.  Or maybe they do.

You never know, and sure if there is an option to gracefully avoid
lossing this information that is the right approach, but I don't see how
this can be done in this situation. Besides currently only
branch.$name.mergoptions will be lost, hardly a problem.

> Its really hard to second guess the user's intent here.  I think
> its too broad to whack an entire section when renaming. [...]
>
> So we don't blindly replace multi-valued keys just because the
> user asked us to.  I don't really see a section as being that much
> different to warrant a potentially lossy behavior by default.

Because it makes sense in this situation and erroring out is a good
choice, but we are running out of git-branch options based on the letter
'm'. And to me, -m is the default for renaming branches, and -M is a
shortcut for doing a lot of other stuff with well-defined implications.

Perhaps we can enable only this "lossy behavior" only for git-branch by
adding an extra argument to git_config_rename_section? Then we can later
add a new option to git-config along the lines of --overwrite-section.

-- 
Jonas Fonseca
