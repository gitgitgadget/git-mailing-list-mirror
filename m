From: Shawn Pearce <spearce@spearce.org>
Subject: [RFC 0/5] Log history of a ref
Date: Wed, 17 May 2006 05:54:17 -0400
Message-ID: <20060517095417.GA28529@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Wed May 17 11:54:29 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FgIjY-0004H3-RY
	for gcvg-git@gmane.org; Wed, 17 May 2006 11:54:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750762AbWEQJyV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 17 May 2006 05:54:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750780AbWEQJyV
	(ORCPT <rfc822;git-outgoing>); Wed, 17 May 2006 05:54:21 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:48592 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S1750762AbWEQJyU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 May 2006 05:54:20 -0400
Received: from cpe-72-226-60-173.nycap.res.rr.com ([72.226.60.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1FgIjQ-0000ty-E2
	for git@vger.kernel.org; Wed, 17 May 2006 05:54:16 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 6E4DA212667; Wed, 17 May 2006 05:54:17 -0400 (EDT)
To: git@vger.kernel.org
Content-Disposition: inline
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20178>

The following 5 [RFC] patches from me are all related to logging
changes made to a ref.  These patches contain the same basic idea
as the two patches I floated earlier this week.  Log files reside
in .git/logs<ref> and logging is enabled either by creating the
log file or by setting 'core.logAllRefUpdates' to true.

Summary is:

 * [RFC 1/5] Remove unnecessary local in get_ref_sha1.

	A minor code cleanup.

 * [RFC 2/5] Improve abstraction of ref lock/write.

	A major reorg of the write_ref_sha1 APIs.  This reorg allows
	all internal code to use the same logic for updating any ref,
	which makes it much easier to hook logging in.
	
 * [RFC 3/5] Convert update-ref to use ref_lock API.

 	Modify update-ref to use the reorg'd write_ref_sha1 API.

 * [RFC 4/5] Log ref updates to logs/refs/<ref>

	Add logging of refs.  This is the pretty much my latest
	logging patch but cleaned up and built on the above.

 * [RFC 5/5] Support 'master@2 hours ago' syntax

	Extend the SHA1 syntax to search the log for the SHA1 which
	was valid at the given point in time.

I still need to fix the receive-pack code to log ref changes prior
to running the update hook.  I'll probably look at that later this
week.  I also need to edit the ~20 sites which call 'git-update-ref'
to make use of the new "-m <reason>" flag.

-- 
Shawn.
