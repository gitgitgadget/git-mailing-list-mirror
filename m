From: Tim Harper <timcharper@gmail.com>
Subject: [PATCH] clarify error message when an abbreviated non-existent commit was specified
Date: Thu,  6 Aug 2009 13:53:55 -0600
Message-ID: <1249588435-23400-1-git-send-email-timcharper@gmail.com>
References: <20090806193413.GJ1033@spearce.org>
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Tim Harper <timcharper@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 06 21:54:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MZ92O-0002Tc-G1
	for gcvg-git-2@gmane.org; Thu, 06 Aug 2009 21:54:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756563AbZHFTx7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Aug 2009 15:53:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756197AbZHFTx7
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Aug 2009 15:53:59 -0400
Received: from wa-out-1112.google.com ([209.85.146.181]:59334 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755686AbZHFTx6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Aug 2009 15:53:58 -0400
Received: by wa-out-1112.google.com with SMTP id j5so236105wah.21
        for <git@vger.kernel.org>; Thu, 06 Aug 2009 12:53:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=s624BSSTEHixbI7umGEhd++eoEBY5r8eWQSxXcGuzSI=;
        b=AfK+0ZWcTU/hEycAwjDsXeI+4PflWNAV+AYVdkmVF8hzAf8qqwq03DKfN5QBHD9kE/
         xjV2ZULvLs18qHF1Ych4RhkYV8HrXxGb2EYr+6gWC18r+DNr6ujOMvoqzPrfbk3zvuca
         GaGAEwmJlXC5qXDMI57PQpNbxh7aG0MS/jtQA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=Zi26WFfn1k96lcrr1V0MyLei0r5ztiuWiotvGwqzU0bh+BvZbi0ts/S7fHfpnIghUR
         yjM66JYALUxL0ePWHGohPCPxekqyt+I3ZymAV0Ge+Euxo5VEQGCn/C/CHokRbKQewuPf
         dnt3pVC9wS2mElx7zLvPUxCa07MNIYyTP/x1E=
Received: by 10.114.204.6 with SMTP id b6mr364694wag.93.1249588439241;
        Thu, 06 Aug 2009 12:53:59 -0700 (PDT)
Received: from localhost ([66.236.74.194])
        by mx.google.com with ESMTPS id k14sm453337waf.60.2009.08.06.12.53.58
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 06 Aug 2009 12:53:58 -0700 (PDT)
X-Mailer: git-send-email 1.6.4
In-Reply-To: <20090806193413.GJ1033@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125116>

When running the command 'git branch --contains efabdfb' on a repository that doesn't yet have efabdfb, git reports: "malformed object name efabdfb". To the uninitiated, this makes little sense (as far as they are concerned, efabdfb is perfectly formed).

This commit changes the message to "malformed object name or no such commit: efabdfb"
---
 parse-options.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/parse-options.c b/parse-options.c
index 3b71fbb..95eb1c4 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -615,7 +615,7 @@ int parse_opt_with_commit(const struct option *opt, const char *arg, int unset)
 	if (!arg)
 		return -1;
 	if (get_sha1(arg, sha1))
-		return error("malformed object name %s", arg);
+		return error("malformed object name or no such commit: %s", arg);
 	commit = lookup_commit_reference(sha1);
 	if (!commit)
 		return error("no such commit %s", arg);
-- 
1.6.4
