From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Consistent terminology: cached/staged/index
Date: Tue, 1 Mar 2011 04:29:03 -0600
Message-ID: <20110301102903.GA31176@elie>
References: <AANLkTi=9OWqz66Ab6O9tc4eYSrhZZ1YC_+ta9sutAn30@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Alexei Sholik <alcosholik@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	David <bouncingcats@gmail.com>, Jeff King <peff@peff.net>,
	Drew Northup <drew.northup@maine.edu>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Piotr Krukowiecki <piotr.krukowiecki.news@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 01 11:29:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PuMpV-0006oA-Ml
	for gcvg-git-2@lo.gmane.org; Tue, 01 Mar 2011 11:29:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756168Ab1CAK3Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Mar 2011 05:29:16 -0500
Received: from mail-qw0-f46.google.com ([209.85.216.46]:46313 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756146Ab1CAK3P (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Mar 2011 05:29:15 -0500
Received: by qwd7 with SMTP id 7so3538957qwd.19
        for <git@vger.kernel.org>; Tue, 01 Mar 2011 02:29:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=co6t4SnT1WF+4yu3x0ZrJ/7GPYWbMWEdhshik26WyS0=;
        b=VWy5gG/ajy9o/HZrSFDex2swjsYD6hUWDvbJgdbEEgAbLCECtyFL1dts44TVsP2x5k
         WaSrwMtOgEbA336r8FbD0GeM0bsRX6rdPUY2nc614BCevluKldjJxeOK20QRix40TbWw
         q6dMXYUkPuVDtuCoh0u3m9581Lj0Fyx0MLrs0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=CcCuQ+1rx/BbQFkL0QWx8Z5X/hv4ygf9EzKDgldDPe8M2bZBJjSs90QncivKMuGuvQ
         lUuf99syCGn7XespTRFMusMI+029BQxZ42tUdNnQRaBK0ifSxTvk9TS1jphUmPMEFjbr
         MZV9+p4ctypCAfuOUcuiUDaFHrsYbp/AqG9bg=
Received: by 10.224.175.78 with SMTP id w14mr947377qaz.96.1298975354977;
        Tue, 01 Mar 2011 02:29:14 -0800 (PST)
Received: from elie (adsl-76-206-235-173.dsl.chcgil.sbcglobal.net [76.206.235.173])
        by mx.google.com with ESMTPS id nb15sm3923538qcb.38.2011.03.01.02.29.10
        (version=SSLv3 cipher=OTHER);
        Tue, 01 Mar 2011 02:29:13 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <AANLkTi=9OWqz66Ab6O9tc4eYSrhZZ1YC_+ta9sutAn30@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168208>

Hi again,

Piotr Krukowiecki wrote:

> is there a plan for using one term

To summarize: everyone knows what the staging area is, no one seems to
know what the index is, and the --cached options are confusing.

We need a new description (terminology, or better yet, story) for
"git's view of the work tree", since just saying "the index! the
index!" without a myth behind it confuses people.

Various commands take --cached (porcelain):

. git diff --cached	- view staged changes relative to the named tree.
. git grep --cached	- search in the staging area instead of the worktree.
. git rm --cached	- only remove from the index.

(plumbing):

. git apply --cached	- apply a patch without touching the worktree.
. git ls-files --cached	- list paths that will have content in the next commit.

It would be reasonable to introduce a synonym --index-only.  That can
be confusing if you don't view the staging area as representing git's
deluded idea of what's in the work tree, though.  For the same reason
and some others, --no-worktree / --ignore-worktree wouldn't work so
well (e.g., "git ls-files --no-worktree" would be terribly confusing).
So, um, we're stuck?

Various commands take --index or related options (porcelain):

. git filter-branch --index-filter	- let hook tweak index before commit
. git stash apply --index	- revive the stashed index changes, too
. git stash save --keep-index	- do not stash changes already added to index

(toys):

. git grep --no-index	- just act as a better "grep"; do not look for .git
. git diff --no-index	- just act as a better "diff"; do not look for .git

(plumbing):

. git apply --index	- next commit will have the patch applied, too
. git checkout-index --index	- update stat() cache while at it
. git read-tree --index-output	- write output to a different index file
. git update-index --index-info	- apply changes in ls-tree or ls-files format
. GIT_INDEX_FILE	- where information about the worktree goes

It would be possible to introduce synonyms along the lines of
GIT_STAGING_AREA_FILE, keeping in mind that they also affect the
merging process (and some of them also affect the stat() cache), if
that seems like the right thing to do.
