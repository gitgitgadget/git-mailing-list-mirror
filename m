From: Alexander Gavrilov <angavrilov@gmail.com>
Subject: [PATCH (GIT-GUI)] git-gui: Fix the search bar destruction handler.
Date: Thu, 13 Nov 2008 21:52:52 +0300
Organization: HOME
Message-ID: <200811132152.52871.angavrilov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 13 19:56:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L0hMQ-0006Kc-Ty
	for gcvg-git-2@gmane.org; Thu, 13 Nov 2008 19:56:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751066AbYKMSy4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Nov 2008 13:54:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751279AbYKMSy4
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Nov 2008 13:54:56 -0500
Received: from fk-out-0910.google.com ([209.85.128.188]:40033 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751064AbYKMSyz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Nov 2008 13:54:55 -0500
Received: by fk-out-0910.google.com with SMTP id 18so1079975fkq.5
        for <git@vger.kernel.org>; Thu, 13 Nov 2008 10:54:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:organization:to:subject
         :date:user-agent:cc:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=caHP/aoewHsx4ybuYth+q40xufoELFG1We4RDfsVWpc=;
        b=qDqo4/MexDFFb7XoAfUnlkzrB3/JGCmWD2T279lWcy7QT3jmG//W6CluDOW20YF3bv
         y1uZDluaVBha86sglfGu6pEv6yVtxkRqc/exGyvUnSVflaujOOw8xGE9jm3hH3+YqLSv
         S5XKCRS+oRKaAJzc2mN9tldX5xgT//btar8F8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:organization:to:subject:date:user-agent:cc:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :message-id;
        b=kNj6OL6MRAARJcjEKytfz6OAXURXqA5r3fvxh1IVVh/yAgX6iXrscwHu+zbhLwD3T7
         oPlNAONt9KTKxxRKAplkCQ0wNVd0H6claf+eEltsGaWh276BCWvkes0JA76SOnESIAVE
         Y5ME34HR2wyXNWdFLPby5rQ3FvNIT3jyTBgwo=
Received: by 10.181.145.6 with SMTP id x6mr22216bkn.25.1226602493487;
        Thu, 13 Nov 2008 10:54:53 -0800 (PST)
Received: from keydesk.localnet ([92.255.85.78])
        by mx.google.com with ESMTPS id 35sm5212902fkt.12.2008.11.13.10.54.51
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 13 Nov 2008 10:54:52 -0800 (PST)
User-Agent: KMail/1.10.1 (Linux/2.6.26.6-79.fc9.i686; KDE/4.1.2; i686; ; )
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100897>

Since delete_this is an ordinary function, it
should not be passed to cb; otherwise it produces
errors when blame windows are closed. Unfortunately,
it is not noticeable when blame is shown in the
master window, so I missed this bug.

Signed-off-by: Alexander Gavrilov <angavrilov@gmail.com>
---
 lib/search.tcl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/lib/search.tcl b/lib/search.tcl
index 32c8656..b371e9a 100644
--- a/lib/search.tcl
+++ b/lib/search.tcl
@@ -35,7 +35,7 @@ constructor new {i_w i_text args} {
 
 	trace add variable searchstring write [cb _incrsearch_cb]
 	
-	bind $w <Destroy> [cb delete_this]
+	bind $w <Destroy> [list delete_this $this]
 	return $this
 }
 
-- 
1.6.0.3.15.gb8d36
