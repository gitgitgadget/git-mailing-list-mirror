From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH v2 0/7] More aggressive tag auto-following
Date: Sat, 1 Mar 2008 00:24:22 -0500
Message-ID: <20080301052422.GY8410@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Mar 01 06:25:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JVKDm-0004jq-C7
	for gcvg-git-2@gmane.org; Sat, 01 Mar 2008 06:25:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752535AbYCAFYa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Mar 2008 00:24:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752279AbYCAFYa
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Mar 2008 00:24:30 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:48368 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751878AbYCAFY3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Mar 2008 00:24:29 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1JVKCx-0000oR-80; Sat, 01 Mar 2008 00:24:27 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 0DBF920FBAE; Sat,  1 Mar 2008 00:24:22 -0500 (EST)
Content-Disposition: inline
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75612>

This series tries to combine the annotated tag fetch into the first
connection when possible, rather than waiting and performing the
fetch on a second connection.  Without server side support this
series does the best the client can to avoid opening a second
connection to automatically follow annotated tags.

 1)   Remove unused variable in builtin-fetch find_non_local_tags
 2)   Remove unnecessary delaying of free_refs(ref_map) in builtin-fetch
 3)   Ensure tail pointer gets setup correctly when we fetch HEAD only
 4)   Allow builtin-fetch's find_non_local_tags to append onto a list
 5)   Teach upload-pack to log the received need lines to fd 3
 6)   Make git-fetch follow tags we already have objects for sooner
 7)   Teach git-fetch to grab a tag at the same time as a commit

 builtin-fetch.c      |   45 ++++++++++++------
 t/t5503-tagfollow.sh |  124 ++++++++++++++++++++++++++++++++++++++++++++++++++
 upload-pack.c        |    7 +++
 3 files changed, 161 insertions(+), 15 deletions(-)

This time it comes with tests, and passes the current tests.  :)

-- 
Shawn.
