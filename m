X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [RFC] Submodules in GIT
Date: Tue, 28 Nov 2006 10:44:34 -0500
Message-ID: <20061128154434.GD28337@spearce.org>
References: <20061121223130.GA24909@nan92-1-81-57-214-146.fbx.proxad.net> <200611281029.11918.andyparkins@gmail.com> <ekh45n$rfc$1@sea.gmane.org> <200611281335.38728.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Tue, 28 Nov 2006 15:45:33 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <200611281335.38728.andyparkins@gmail.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32540>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gp58V-000318-BQ for gcvg-git@gmane.org; Tue, 28 Nov
 2006 16:44:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1758691AbWK1Poi (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 28 Nov 2006
 10:44:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758693AbWK1Poi
 (ORCPT <rfc822;git-outgoing>); Tue, 28 Nov 2006 10:44:38 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:6020 "EHLO
 corvette.plexpod.net") by vger.kernel.org with ESMTP id S1758691AbWK1Poh
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 28 Nov 2006 10:44:37 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173]
 helo=asimov.home.spearce.org) by corvette.plexpod.net with esmtpa (Exim 4.52)
 id 1Gp58I-0002do-3x; Tue, 28 Nov 2006 10:44:30 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000) id
 502BF20FB7F; Tue, 28 Nov 2006 10:44:34 -0500 (EST)
To: Andy Parkins <andyparkins@gmail.com>
Sender: git-owner@vger.kernel.org

Andy Parkins <andyparkins@gmail.com> wrote:
> I think I've talked myself into the position where it definitely has to be 
> HEAD being tracked in the submodules; anything else is a disaster waiting to 
> happen because commit doesn't check in your current tree.

Yes, but not only that, HEAD is the only thing that fits with the
rest of the git repository/index/working directory model.

Lets review...

What's HEAD?  Its the commit which matches the index state as
closely as possible, with the only differences being the changes in
progress that are being prepared for the next commit (whose parent
will be HEAD).  If the index and working directory are both clean
(no changes) then its also the current content of this directory,
right?

What's the index?  Its what you are about to commit.

What's the working directory?  Its the current content, which may
also be partially checked out or dirty.

So HEAD in a submodule is the current content of that submodule.
Therefore any update-index call on a submodule should load HEAD
(totally ignoring whatever branch it refers to) into the supermodule
index.

-- 
