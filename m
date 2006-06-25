From: Timo Hirvonen <tihirvon@gmail.com>
Subject: [PATCH] Don't xcalloc() struct diffstat_t
Date: Sun, 25 Jun 2006 14:28:19 +0300
Message-ID: <20060625142819.209f3519.tihirvon@gmail.com>
References: <20060624201843.a5b4f7b9.tihirvon@gmail.com>
	<20060624202153.1001a66c.tihirvon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: junkio@cox.net, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 25 13:28:28 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FuSmx-0006IB-LZ
	for gcvg-git@gmane.org; Sun, 25 Jun 2006 13:28:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932373AbWFYL2Z (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 25 Jun 2006 07:28:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932374AbWFYL2Z
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Jun 2006 07:28:25 -0400
Received: from nf-out-0910.google.com ([64.233.182.184]:1768 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932373AbWFYL2Y (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Jun 2006 07:28:24 -0400
Received: by nf-out-0910.google.com with SMTP id m19so461272nfc
        for <git@vger.kernel.org>; Sun, 25 Jun 2006 04:28:21 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=HRM45Hh4udKnhxcDWOtj1rL/ECOorNfKdphtKq5oz3gVyYe9TaebrRBMyyrVOrpT+wkSSKE39owj76teggYwq86yttUHtmJDvc9r5yPSoW9Iy2WMG6/jqN15/lqyhP7Ws97HOe2uaf+8lzLL4K9/qSgNB2c8+okcTn0NNl5hP2M=
Received: by 10.48.231.6 with SMTP id d6mr3989789nfh;
        Sun, 25 Jun 2006 04:28:21 -0700 (PDT)
Received: from garlic.home.net ( [82.128.229.197])
        by mx.gmail.com with ESMTP id i1sm1400115nfe.2006.06.25.04.28.20;
        Sun, 25 Jun 2006 04:28:21 -0700 (PDT)
To: Timo Hirvonen <tihirvon@gmail.com>
In-Reply-To: <20060624202153.1001a66c.tihirvon@gmail.com>
X-Mailer: Sylpheed version 2.2.6 (GTK+ 2.8.18; i686-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22614>

Signed-off-by: Timo Hirvonen <tihirvon@gmail.com>
---
 diff.c |   11 +++++------
 1 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/diff.c b/diff.c
index cc2af30..8880150 100644
--- a/diff.c
+++ b/diff.c
@@ -2062,17 +2062,16 @@ void diff_flush(struct diff_options *opt
 	}
 
 	if (output_format & DIFF_FORMAT_DIFFSTAT) {
-		struct diffstat_t *diffstat;
+		struct diffstat_t diffstat;
 
-		diffstat = xcalloc(sizeof (struct diffstat_t), 1);
-		diffstat->xm.consume = diffstat_consume;
+		memset(&diffstat, 0, sizeof(struct diffstat_t));
+		diffstat.xm.consume = diffstat_consume;
 		for (i = 0; i < q->nr; i++) {
 			struct diff_filepair *p = q->queue[i];
 			if (check_pair_status(p))
-				diff_flush_stat(p, options, diffstat);
+				diff_flush_stat(p, options, &diffstat);
 		}
-		show_stats(diffstat);
-		free(diffstat);
+		show_stats(&diffstat);
 	}
 
 	if (output_format & DIFF_FORMAT_SUMMARY) {
-- 
1.4.1.rc1.g5472-dirty
