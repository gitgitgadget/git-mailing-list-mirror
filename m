From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: very slow cherry-pick'ing (old-2.6-bkcvs tree)
Date: Fri, 7 Sep 2007 00:42:23 -0400
Message-ID: <20070907044223.GW18160@spearce.org>
References: <200709062351.l86NpnAK004807@agora.fsl.cs.sunysb.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Erez Zadok <ezk@cs.sunysb.edu>
X-From: git-owner@vger.kernel.org Fri Sep 07 06:42:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ITVfv-0001J1-Fv
	for gcvg-git@gmane.org; Fri, 07 Sep 2007 06:42:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751421AbXIGEm2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 7 Sep 2007 00:42:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751316AbXIGEm2
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Sep 2007 00:42:28 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:57853 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751249AbXIGEm1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Sep 2007 00:42:27 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1ITVfm-0001HW-1N; Fri, 07 Sep 2007 00:42:26 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 568AD20FBAE; Fri,  7 Sep 2007 00:42:24 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <200709062351.l86NpnAK004807@agora.fsl.cs.sunysb.edu>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57973>

Erez Zadok <ezk@cs.sunysb.edu> wrote:
> Our group maintains Unionfs on the latest -rc kernel, but we also maintain
> several backports going all the way to 2.6.9.  Once we complete the
> development and testing of a feature/fix in -latest, we cherry-pick those
> commits to older backports, and test those.  When I cherry-pick from -latest
> to my 2.6.{22,21,20,19,18} repositories, it works reasonably fast.  But when
> I cherry-pick to my 2.6.9 tree, it runs about 20 times slower!  Why?  Is
> there anything I can do to inspect what's going on and perhaps speed up the
> cherry-picking process?

I'm guessing its due to rename detection.

git-cherry-pick is implemented in terms of git-merge-recursive,
which always does rename detection when files are deleted or added.
This can take some considerable time if there's a lot of files that
have been added/deleted.

What would probably be faster would be to dump the patches in
question using git-format-patch and then apply them using git-am.
This bypasses the rename detection as it is using strictly a diff
and an apply.

-- 
Shawn.
