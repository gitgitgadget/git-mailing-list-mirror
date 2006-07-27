From: "Michael S. Tsirkin" <mst@mellanox.co.il>
Subject: [PATCH] mailinfo: accept >From in message header
Date: Thu, 27 Jul 2006 17:03:43 +0300
Message-ID: <20060727140343.GS9411@mellanox.co.il>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Thu Jul 27 16:02:30 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G66RY-0004QO-5w
	for gcvg-git@gmane.org; Thu, 27 Jul 2006 16:02:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751129AbWG0OCZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 27 Jul 2006 10:02:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751311AbWG0OCZ
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Jul 2006 10:02:25 -0400
Received: from mxl145v67.mxlogic.net ([208.65.145.67]:64132 "EHLO
	p02c11o144.mxlogic.net") by vger.kernel.org with ESMTP
	id S1751129AbWG0OCY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Jul 2006 10:02:24 -0400
Received: from unknown [194.90.237.34] (EHLO mtlexch01.mtl.com)
	by p02c11o144.mxlogic.net (mxl_mta-3.0.0-12)
	with ESMTP id 077c8c44.2040757168.44443.00-005.p02c11o144.mxlogic.net (envelope-from <mst@mellanox.co.il>);
	Thu, 27 Jul 2006 08:02:24 -0600 (MDT)
Received: from mellanox.co.il ([10.4.4.6]) by mtlexch01.mtl.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Thu, 27 Jul 2006 17:08:03 +0300
Received: by mellanox.co.il (sSMTP sendmail emulation); Thu, 27 Jul 2006 17:03:43 +0300
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-OriginalArrivalTime: 27 Jul 2006 14:08:03.0890 (UTC) FILETIME=[1394F120:01C6B186]
X-Spam: [F=0.0100000000; S=0.010(2006062901)]
X-MAIL-FROM: <mst@mellanox.co.il>
X-SOURCE-IP: [194.90.237.34]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24289>

Hi!
Mail I get sometimes has multiple From lines, like this:

>From Majordomo@vger.kernel.org  Thu Jul 27 16:39:36 2006
>From mtsirkin  Thu Jul 27 16:39:36 2006
Received: from yok.mtl.com [10.0.8.11]
....

which confuses git-mailinfo since that does not recognize >From
as a valid header line. The following patch makes git-applymbox
work for me:

---

Recognize >From XXX as a valid header line.

Signed-off-by: Michael S. Tsirkin <mst@mellanox.co.il>

diff --git a/builtin-mailinfo.c b/builtin-mailinfo.c
index ac53f76..2b6e9fa 100644
--- a/builtin-mailinfo.c
+++ b/builtin-mailinfo.c
@@ -446,7 +446,7 @@ static int read_one_header_line(char *li
 			break;
 	}
 	/* Count mbox From headers as headers */
-	if (!ofs && !memcmp(line, "From ", 5))
+	if (!ofs && (!memcmp(line, "From ", 5) || !memcmp(line, ">From ", 6)))
 		ofs = 1;
 	return ofs;
 }

-- 
MST
