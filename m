From: Shawn Pearce <spearce@spearce.org>
Subject: Re: Why is there a --binary option needed for git-apply?
Date: Tue, 5 Sep 2006 23:38:03 -0400
Message-ID: <20060906033803.GA30598@spearce.org>
References: <874pvmxikq.wl%cworth@cworth.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 06 12:07:56 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GKuJw-0007n1-E4
	for gcvg-git@gmane.org; Wed, 06 Sep 2006 12:07:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750755AbWIFKHp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 6 Sep 2006 06:07:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750770AbWIFKHp
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Sep 2006 06:07:45 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:28621 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S1750755AbWIFKHn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Sep 2006 06:07:43 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1GKuJi-00062H-Vw; Wed, 06 Sep 2006 06:07:35 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 5896E212693; Tue,  5 Sep 2006 23:38:03 -0400 (EDT)
To: Carl Worth <cworth@cworth.org>
Content-Disposition: inline
In-Reply-To: <874pvmxikq.wl%cworth@cworth.org>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26512>

Carl Worth <cworth@cworth.org> wrote:
> Shawn Pearce was kind enough to direct me to the --binary option for
> git-apply which solved my problem. But that left me wondering why
> git-apply requires this extra command-line option to do its
> job. Shouldn't git-apply simply apply the patch it is given?
> 
> If there is some reason for git-apply to only apply binary patches
> when under the duress of --binary, then at the very least it could use
> a better error message explaining the situation.

I see no reason why git-apply shouldn't always have --binary enabled.
If the patch contains full pre-image/post-image blob IDs and we have
an exact match against the pre-image and we have the post-image
in our tree it should just apply even if the user didn't supply
--binary.  If the patch contains a binary delta and we have an
exact match against the pre-image it should also just apply.

But if there's a binary hunk and we lack the full pre/post image blob
IDs, we lack the post image and there's no detla, or the pre-image
doesn't exactly match then we should obviously still abort with a
reasonable error message as there's no sane course of action to take.

-- 
Shawn.
