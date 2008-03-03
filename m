From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH v3 0/8] Optimized tag autofollowing in git-fetch
Date: Sun, 2 Mar 2008 21:34:20 -0500
Message-ID: <20080303023419.GE8410@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 03 03:35:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JW0WB-0001QR-L7
	for gcvg-git-2@gmane.org; Mon, 03 Mar 2008 03:35:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753344AbYCCCe1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Mar 2008 21:34:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752894AbYCCCe1
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Mar 2008 21:34:27 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:59096 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752715AbYCCCe0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Mar 2008 21:34:26 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1JW0VJ-0002Ka-7P; Sun, 02 Mar 2008 21:34:13 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id E62C220FBAE; Sun,  2 Mar 2008 21:34:20 -0500 (EST)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75869>

Here's version 3 of the more aggressive tag following for git-fetch.

  1)  Remove unused variable in builtin-fetch find_non_local_tags
  2)  Remove unnecessary delaying of free_refs(ref_map) in builtin-fetch
  3)  Ensure tail pointer gets setup correctly when we fetch HEAD only
  4)  Allow builtin-fetch's find_non_local_tags to append onto a list
  5)  Free the path_lists used to find non-local tags in git-fetch
  6)  Teach upload-pack to log the received need lines to an fd
  7)  Make git-fetch follow tags we already have objects for sooner
  8)  Teach git-fetch to grab a tag at the same time as a commit

 builtin-fetch.c      |   49 +++++++++++++------
 t/t5503-tagfollow.sh |  124 ++++++++++++++++++++++++++++++++++++++++++++++++++
 upload-pack.c        |    9 ++++
 3 files changed, 166 insertions(+), 16 deletions(-)

Changes since the last (v2) round:

  "Free the path_lists used to find non-local tags in git-fetch"

    This patch was added to the series to avoid memory corruption
    errors that were only showing up on Linux.  My earlier testing
    only on Mac OS X failed to show any symptoms of the corruption.
    Junio noticed it on Linux and asked me to revisit the series.

  "Teach upload-pack to log the received need lines to an fd"

    At Daniel's suggestion the GIT_DEBUG_SEND_PACK environment
    variable takes the value of the fd we log onto.  This mirrors
    how GIT_TRACE works.

-- 
Shawn.
