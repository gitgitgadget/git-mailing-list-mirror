From: Andy Parkins <andyparkins@gmail.com>
Subject: [PATCH] post-receive-email: fix accidental removal of a trailing space in signature line
Date: Mon, 21 Apr 2008 14:44:44 +0100
Message-ID: <200804211444.44810.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 21 15:46:25 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JnwLJ-0005GV-Uq
	for gcvg-git-2@gmane.org; Mon, 21 Apr 2008 15:46:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758120AbYDUNoy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Apr 2008 09:44:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757145AbYDUNoy
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Apr 2008 09:44:54 -0400
Received: from rn-out-0910.google.com ([64.233.170.184]:13191 "EHLO
	rn-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757994AbYDUNox (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Apr 2008 09:44:53 -0400
Received: by rn-out-0910.google.com with SMTP id e11so315924rng.17
        for <git@vger.kernel.org>; Mon, 21 Apr 2008 06:44:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:date:subject:to:x-tuid:x-uid:x-length:mime-version:content-transfer-encoding:content-disposition:message-id;
        bh=Jxp5U3oL0ZCpA2VN0pCcaWznGN65mK21kPC5KWXpLdQ=;
        b=x2v0AmvjcGImGaofNx0ZM+V6/bzJSCh2qUqJxIMd8WFpTROBF/YC2nu+i6GzTAtHaKKqCLWVsUd8RjrTQ9tbbOpMn5hk7nS7hzKerQB2jHIsqA5g5gAOtDoEQqQpROfHimxt6EWy4W/sjyWwVgy/zys2LkRE2qp3IiC1mBAAnWE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:date:subject:to:x-tuid:x-uid:x-length:mime-version:content-transfer-encoding:content-disposition:message-id;
        b=Ey+246VaX0fSFvW8tLs7ObQVBZv/xJSvK7JJPrdbSg6ip9TyyZa0VHtA0yMpNplhDJ5EAkZqg/94fuJMzPUhk3ei/4NTsDazHFmEMQsZikAh7yQViT8+SGM+vjl1IGW4mUoSB1YMS/mv3hNnTgNyD6iJk3oPGnc7yzb0jWCRhqQ=
Received: by 10.114.184.9 with SMTP id h9mr5830331waf.151.1208785490908;
        Mon, 21 Apr 2008 06:44:50 -0700 (PDT)
Received: from dvr.360vision.com ( [194.70.53.227])
        by mx.google.com with ESMTPS id i19sm15248376wxd.33.2008.04.21.06.44.48
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 21 Apr 2008 06:44:49 -0700 (PDT)
X-TUID: 482bc995793ab018
X-UID: 7
X-Length: 1266
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80025>

post-receive-email adds a signature to the end of emails in
generate_email_footer().  The signature was separated from the main email
body using the standard string "-- ". (see rfc3676)

In revision a6080a0a44d5, Junio's "war on whitespace" removed the trailing
whitespace from "-- ", leaving it as "--", which is not a correct
signature separator.

This patch restores the missing space, but does it in a way that will
not set off the trailing whitespace alarms.

Signed-off-by: Andy Parkins <andyparkins@gmail.com>
---
 contrib/hooks/post-receive-email |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/contrib/hooks/post-receive-email b/contrib/hooks/post-receive-email
index 62a740c..4136895 100644
--- a/contrib/hooks/post-receive-email
+++ b/contrib/hooks/post-receive-email
@@ -202,11 +202,12 @@ generate_email_header()
 
 generate_email_footer()
 {
+	SPACE=" "
 	cat <<-EOF
 
 
 	hooks/post-receive
-	--
+	--${SPACE}
 	$projectdesc
 	EOF
 }
-- 
1.5.5.29.g7134
