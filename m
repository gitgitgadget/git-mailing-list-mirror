From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH v2] fast-import: Document the effect of "merge" with no "from" in a commit
Date: Sun, 23 Mar 2008 01:00:28 -0400
Message-ID: <20080323050028.GI8410@spearce.org>
References: <F6F70627-FAE7-43F1-BECC-E70A4A561982@orakel.ntnu.no> <20080318034321.GK8410@spearce.org> <F4486D8E-3256-4FA7-89A7-3EC7E7D64162@orakel.ntnu.no> <20080319020625.GA3535@spearce.org> <9A41E5AD-2305-457B-A214-7A11A1B559F6@orakel.ntnu.no> <20080320034031.GX8410@spearce.org> <6FC571BB-D304-4D25-B1F2-1E03BD5438F8@orakel.ntnu.no> <FB8C4A1F-3DC1-4D7B-910B-5F721F39B244@orakel.ntnu.no> <BDCF3EE6-0813-40B1-96D8-CCBADCCDAEA6@orakel.ntnu.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: James Westby <jw+debian@jameswestby.net>,
	Ian Clatworthy <ian.clatworthy@internode.on.net>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Git Mailing List <git@vger.kernel.org>
To: Eyvind Bernhardsen <eyvind-git@orakel.ntnu.no>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 23 06:01:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JdIKt-0007ep-Dv
	for gcvg-git-2@gmane.org; Sun, 23 Mar 2008 06:01:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751342AbYCWFAn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Mar 2008 01:00:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751394AbYCWFAn
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Mar 2008 01:00:43 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:55613 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750851AbYCWFAl (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Mar 2008 01:00:41 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1JdIJp-0003qr-Nj; Sun, 23 Mar 2008 01:00:29 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 7975520FBAE; Sun, 23 Mar 2008 01:00:28 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <BDCF3EE6-0813-40B1-96D8-CCBADCCDAEA6@orakel.ntnu.no>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77866>

Eyvind Bernhardsen <eyvind-git@orakel.ntnu.no> wrote:
> The fast-import documentation currently does not document the behaviour
> of "merge" when there is no "from" in a commit.  This patch adds a
> description of what happens: the commit is created with a parent, but
> no files.  This behaviour is equivalent to "from" followed by
> "filedeleteall".
> 
> Signed-off-by: Eyvind Bernhardsen <eyvind-git@orakel.ntnu.no>

Thanks.  This change does clarify the documentation.

Acked-by: Shawn O. Pearce <spearce@spearce.org>


> diff --git a/Documentation/git-fast-import.txt b/Documentation/git- 
> fast-import.txt
> index 96f6767..c29a4f8 100644
> --- a/Documentation/git-fast-import.txt
> +++ b/Documentation/git-fast-import.txt
> @@ -385,6 +385,9 @@ new commit.
>  Omitting the `from` command in the first commit of a new branch
>  will cause fast-import to create that commit with no ancestor. This
>  tends to be desired only for the initial commit of a project.
> +If the frontend creates all files from scratch when making a new
> +branch, a `merge` command may be used instead of `from` to start
> +the commit with an empty tree.
>  Omitting the `from` command on existing branches is usually desired,
>  as the current commit on that branch is automatically assumed to
>  be the first ancestor of the new commit.
> @@ -427,13 +430,15 @@ existing value of the branch.
> 
>  `merge`
>  ^^^^^^^
> -Includes one additional ancestor commit, and makes the current
> -commit a merge commit.  An unlimited number of `merge` commands per
> +Includes one additional ancestor commit.  If the `from` command is
> +omitted when creating a new branch, the first `merge` commit will be
> +the first ancestor of the current commit, and the branch will start
> +out with no files.  An unlimited number of `merge` commands per
>  commit are permitted by fast-import, thereby establishing an n-way  
> merge.
>  However Git's other tools never create commits with more than 15
>  additional ancestors (forming a 16-way merge).  For this reason
>  it is suggested that frontends do not use more than 15 `merge`
> -commands per commit.
> +commands per commit; 16, if starting a new, empty branch.
> 
>  Here `<committish>` is any of the commit specification expressions
>  also accepted by `from` (see above).
> -- 
> 1.5.5.rc0.9.g6e103
> 

-- 
Shawn.
