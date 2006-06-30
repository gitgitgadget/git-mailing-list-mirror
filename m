From: fork0@t-online.de (Alex Riesen)
Subject: [PATCH 2/4] make filepairs detachable
Date: Fri, 30 Jun 2006 02:27:36 +0200
Message-ID: <20060630002736.GB22618@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri Jun 30 02:27:51 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fw6rK-0002Bd-CL
	for gcvg-git@gmane.org; Fri, 30 Jun 2006 02:27:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964815AbWF3A1m (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 29 Jun 2006 20:27:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964811AbWF3A1m
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Jun 2006 20:27:42 -0400
Received: from mailout07.sul.t-online.com ([194.25.134.83]:12417 "EHLO
	mailout07.sul.t-online.com") by vger.kernel.org with ESMTP
	id S964821AbWF3A1k (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Jun 2006 20:27:40 -0400
Received: from fwd28.aul.t-online.de 
	by mailout07.sul.t-online.com with smtp 
	id 1Fw6rA-0000gi-00; Fri, 30 Jun 2006 02:27:36 +0200
Received: from tigra.home (EwsK6UZHwe1cO6h3ykc33GskTEDxm+hnqxmFTRoiYoK0fme9j11JZl@[84.160.88.232]) by fwd28.sul.t-online.de
	with esmtp id 1Fw6rA-1EWGnY0; Fri, 30 Jun 2006 02:27:36 +0200
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 2DC9C277B5;
	Fri, 30 Jun 2006 02:27:36 +0200 (CEST)
Received: from raa by steel.home with local (Exim 4.42 #1 (Debian))
	id 1Fw6rA-0007gW-5R; Fri, 30 Jun 2006 02:27:36 +0200
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
X-ID: EwsK6UZHwe1cO6h3ykc33GskTEDxm+hnqxmFTRoiYoK0fme9j11JZl
X-TOI-MSGID: 48e3651b-c534-401d-9253-a485323551ae
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22931>

Actually, just make sure diff_flush does not crash for diff queue
entries which were cleared.

---
 diff.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/diff.c b/diff.c
index 5a71489..b3480f6 100644
--- a/diff.c
+++ b/diff.c
@@ -2281,6 +2281,8 @@ void diff_flush(struct diff_options *opt
 	}
 	for (i = 0; i < q->nr; i++) {
 		struct diff_filepair *p = q->queue[i];
+		if (!p)
+			continue;
 		flush_one_pair(p, diff_output_format, options, diffstat);
 	}
 
@@ -2290,6 +2292,8 @@ void diff_flush(struct diff_options *opt
 	}
 
 	for (i = 0; i < q->nr; i++) {
+		if (!q->queue[i])
+		    continue;
 		if (diffstat && options->summary)
 			diff_summary(q->queue[i]);
 		diff_free_filepair(q->queue[i]);
-- 
1.4.1.rc1.g17dc
