From: Shawn Pearce <spearce@spearce.org>
Subject: [PATCH 1/5] Correct force_write bug in refs.c
Date: Fri, 19 May 2006 05:15:28 -0400
Message-ID: <20060519091528.GI22257@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 19 11:15:35 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fh154-00085s-7k
	for gcvg-git@gmane.org; Fri, 19 May 2006 11:15:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751231AbWESJPb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 19 May 2006 05:15:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751258AbWESJPb
	(ORCPT <rfc822;git-outgoing>); Fri, 19 May 2006 05:15:31 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:15819 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S1751231AbWESJPb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 May 2006 05:15:31 -0400
Received: from cpe-72-226-60-173.nycap.res.rr.com ([72.226.60.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1Fh14w-0005h3-Oz; Fri, 19 May 2006 05:15:26 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 0CA72212691; Fri, 19 May 2006 05:15:28 -0400 (EDT)
To: Junio Hamano <junkio@cox.net>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20338>

My earlier attempt at forcing a write for non-existant refs worked;
it forced a write for pretty much all refs.  This corrects the
condition to only force a write for refs which don't exist yet.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>

---

 refs.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

5ee16115982c52fa9b8fa15c14b234608a8b935d
diff --git a/refs.c b/refs.c
index d3ddc82..eeb1196 100644
--- a/refs.c
+++ b/refs.c
@@ -305,7 +305,7 @@ static struct ref_lock* lock_ref_sha1_ba
 	lock->ref_file = strdup(path);
 	lock->lock_file = strdup(mkpath("%s.lock", lock->ref_file));
 	lock->log_file = strdup(git_path("logs/%s", lock->ref_file + plen));
-	lock->force_write = !lstat(lock->ref_file, &st) || errno == ENOENT;
+	lock->force_write = lstat(lock->ref_file, &st) && errno == ENOENT;
 
 	if (safe_create_leading_directories(lock->lock_file))
 		die("unable to create directory for %s", lock->lock_file);
-- 
1.3.2.g7278
