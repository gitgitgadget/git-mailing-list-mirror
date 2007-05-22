From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] Prevent megablobs from gunking up git packs
Date: Tue, 22 May 2007 02:30:50 -0400
Message-ID: <20070522063050.GD11636@spearce.org>
References: <46528A48.9050903@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
To: Dana How <danahow@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 22 08:31:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HqNte-0005mz-NU
	for gcvg-git@gmane.org; Tue, 22 May 2007 08:31:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757410AbXEVGaz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 22 May 2007 02:30:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756965AbXEVGaz
	(ORCPT <rfc822;git-outgoing>); Tue, 22 May 2007 02:30:55 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:39034 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756824AbXEVGay (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 May 2007 02:30:54 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HqNtT-0001Nu-CP; Tue, 22 May 2007 02:30:51 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 6389520FBAE; Tue, 22 May 2007 02:30:50 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <46528A48.9050903@gmail.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48076>

Dana How <danahow@gmail.com> wrote:
...
> 7 packfiles of 12.5GB total (--window=0 and --depth=0 were
> used due to runtime limits).  When using these packfiles,
...
> Repacking the entire repository with a max-blob-size of 256KB
> resulted in a single 13.1MB packfile,  as well as 2853 loose
> objects totaling 15.4GB compressed and 100.08GB uncompressed,
> 11 files per objects/xx directory on average.  All was created
> in half the runtime of the previous yet with standard
> --window=10 and --depth=50 parameters.  The data in the
> packfile was 270MB uncompressed in 35976 blobs.  Operations
> such as "git-log --pretty=oneline" were about 30X faster
> on a cold cache and 2 to 3X faster otherwise.  Process sizes
> remained reasonable.

Can you give me details about your system?  Is this a 64 bit binary?
What is your core.packedGitWindowSize and core.packedGitLimit set to?

It sounds like the packed version was almost 3 GiB smaller, but
was slower because we were mmap'ing far too much data at startup
and that was making your OS page in things that you didn't really
need to have.

Mind trying git-log with a smaller core.packedGitWindow{Size,Limit}?
Perhaps its just as simple as our defaults are far far too high for
your workload...

-- 
Shawn.
