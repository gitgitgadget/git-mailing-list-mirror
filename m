From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Git performance problems with many tags
Date: Mon, 26 Mar 2007 02:07:31 -0400
Message-ID: <20070326060731.GF13247@spearce.org>
References: <20070326045341.GE10545@ws35.commsecure.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Tim Allen <tim@commsecure.com.au>
X-From: git-owner@vger.kernel.org Mon Mar 26 08:07:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HViMp-0000lp-40
	for gcvg-git@gmane.org; Mon, 26 Mar 2007 08:07:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933611AbXCZGHg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 26 Mar 2007 02:07:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933613AbXCZGHg
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Mar 2007 02:07:36 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:44067 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933611AbXCZGHf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Mar 2007 02:07:35 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HViMe-0000lS-RM; Mon, 26 Mar 2007 02:07:32 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id D905820FBAE; Mon, 26 Mar 2007 02:07:31 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20070326045341.GE10545@ws35.commsecure.com.au>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43115>

Tim Allen <tim@commsecure.com.au> wrote:
> However, operations like 'git-fetch' take much, much longer in our
> repository than in the kernel repository: a git-fetch that pulls no
> updates in the kernel repository takes 1.7s, while our repository
> (fetching from one repository to a clone on the same local disk) takes
> about 20 seconds. After some experimentation, we discovered that
> deleting all the 5557 imported CVS tags made things fast again.

Yes.  git-fetch in the current stable versions is a Bourne shell
script.  Its not very fast as it loops through the refs (tags)
that the two ends have.

There is work in under development (and being tested) that improves
this by converting some of the critical parts to C.

> (Interestingly, "git-fetch --no-tags" was not appreciably quicker, while
> the tags were still around)

Yes, because that swtich didn't bypass that section of the fetch code
where the slowdown is occuring.

> Does git have known scalability problems with large numbers of tags?

Yup.

> Is
> there anything we can do to mitigate this slowdown, apart from just not
> using git's tag feature at all?

Upgrade to the upcoming 1.5.1 release.  Junio recently tagged
1.5.1-rc1.  You can get it by cloning git.git and building the
'master' branch.  It is quite stable.  I would encourage you to
give it a try.

-- 
Shawn.
