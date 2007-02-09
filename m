From: "Michael S. Tsirkin" <mst@mellanox.co.il>
Subject: Re: [PATCH] qgit4: Add a header and set the font family appropriately to the log message
Date: Fri, 9 Feb 2007 11:19:23 +0200
Message-ID: <20070209091923.GT6560@mellanox.co.il>
References: <7vk5ysw6a3.fsf@assigned-by-dhcp.cox.net>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri Feb 09 10:19:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HFRuF-0005h8-QB
	for gcvg-git@gmane.org; Fri, 09 Feb 2007 10:19:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946243AbXBIJS4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 9 Feb 2007 04:18:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946245AbXBIJS4
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Feb 2007 04:18:56 -0500
Received: from p02c11o142.mxlogic.net ([208.65.145.65]:52692 "EHLO
	p02c11o142.mxlogic.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1946243AbXBIJSy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Feb 2007 04:18:54 -0500
Received: from unknown [194.90.237.34] (EHLO mtlexch01.mtl.com)
	by p02c11o142.mxlogic.net (mxl_mta-4.0.2-2)
	with ESMTP id e7c3cc54.2415795120.23168.00-008.p02c11o142.mxlogic.net (envelope-from <mst@mellanox.co.il>);
	Fri, 09 Feb 2007 02:18:54 -0700 (MST)
Received: from mellanox.co.il ([10.4.4.6]) by mtlexch01.mtl.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Fri, 9 Feb 2007 11:21:03 +0200
Received: by mellanox.co.il (sSMTP sendmail emulation); Fri,  9 Feb 2007 11:16:47 +0200
Content-Disposition: inline
In-Reply-To: <7vk5ysw6a3.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.11
X-OriginalArrivalTime: 09 Feb 2007 09:21:03.0580 (UTC) FILETIME=[9EDAE9C0:01C74C2B]
X-TM-AS-Product-Ver: SMEX-7.0.0.1526-3.6.1039-14986.003
X-TM-AS-Result: No--18.503800-4.000000-31
X-Spam: [F=0.0100000000; S=0.010(2007010901)]
X-MAIL-FROM: <mst@mellanox.co.il>
X-SOURCE-IP: [194.90.237.34]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39168>

> Quoting Junio C Hamano <junkio@cox.net>:
> Subject: Re: [PATCH] qgit4: Add a header and set the font family appropriately to the log message
> 
> "Shawn O. Pearce" <spearce@spearce.org> writes:
> 
> > In case you did not already know, --numbered is a wonderful option
> > to git-format-patch.  It automatically numbers the commits by placing
> > a sequence into the subject header (e.g. [PATCH 1/3]), making it
> > easier for everyone to know how many patches are in your series.
> 
> This came up before, but when you have more than 9 in your
> series, we _could_ do [PATCH 01/12] ... [PATCH 12/12] to line
> them up in e-mail client of the recipients better.  Currently I
> think we do [PATCH 1/12] ... [PATCH 12/12].

Like this (lightly tested)?

Signed-off-by: Michael S. Tsirkin <mst@mellanox.co.il>

---

diff --git a/log-tree.c b/log-tree.c
index 85acd66..6f6aa5a 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -102,6 +102,14 @@ static int append_signoff(char *buf, int buf_sz, int at, const char *signoff)
 	return at;
 }
 
+static int get_width(unsigned nr)
+{
+	int i;
+        for (i = 1; nr > 10; ++i)
+		nr = nr / 10;
+	return i;
+}
+
 void show_log(struct rev_info *opt, const char *sep)
 {
 	static char this_header[16384];
@@ -155,8 +163,8 @@ void show_log(struct rev_info *opt, const char *sep)
 		if (opt->total > 0) {
 			static char buffer[64];
 			snprintf(buffer, sizeof(buffer),
-					"Subject: [PATCH %d/%d] ",
-					opt->nr, opt->total);
+					"Subject: [PATCH %0*d/%d] ",
+					get_width(opt->total), opt->nr, opt->total);
 			subject = buffer;
 		} else if (opt->total == 0)
 			subject = "Subject: [PATCH] ";
-- 
MST
