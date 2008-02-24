From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH 0/6] git-name-rev -d and git-describe improvements
Date: Sun, 24 Feb 2008 03:07:14 -0500
Message-ID: <20080224080714.GH8410@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Feb 24 09:08:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JTBuM-0004Lv-3E
	for gcvg-git-2@gmane.org; Sun, 24 Feb 2008 09:08:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750915AbYBXIHV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Feb 2008 03:07:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750938AbYBXIHU
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Feb 2008 03:07:20 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:42945 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750914AbYBXIHT (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Feb 2008 03:07:19 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1JTBtD-0001f3-O6; Sun, 24 Feb 2008 03:07:15 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id EAA7020FBAE; Sun, 24 Feb 2008 03:07:14 -0500 (EST)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74906>

This series of 6 patches improves performance for both describe and
`show-ref -d` on repositories with a lot of tags, and finally ends
with the display of the current tag for detached HEAD in the bash
prompt rather than the abbreviated SHA-1.

The `show-ref -d` improvements should help both gitk and gitweb
performance as it reduces the total number of lstats necessary
(we were doing an extra unnecessary lstat on each packed ref).

The `describe --exact-match` flag is useful in scripts, as shown
by the final patch in the series.

  1) Protect peel_ref fallback case from NULL parse_object result
  2) Optimize peel_ref for the current ref of a for_each_ref callback
  3) Teach git-describe to use peeled ref information when scanning tags
  4) Avoid accessing non-tag refs in git-describe unless --all is requested
  5) Teach git-describe --exact-match to avoid expensive tag searches
  6) Use git-describe --exact-match in bash prompt on detached HEAD

 Documentation/git-describe.txt         |    5 ++++
 builtin-describe.c                     |   35 ++++++++++++++++++++++++-------
 contrib/completion/git-completion.bash |    5 +++-
 refs.c                                 |   27 +++++++++++++++++++-----
 4 files changed, 57 insertions(+), 15 deletions(-)

-- 
Shawn.
