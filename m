From: Miguel Torroja <miguel.torroja@gmail.com>
Subject: [PATCH] p4: Retrieve the right revision of the UTF-16 file
Date: Wed, 27 May 2015 22:31:58 +0000
Message-ID: <1432765918-7352-1-git-send-email-miguel.torroja@gmail.com>
Cc: Miguel Torroja <miguel.torroja@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 27 22:32:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yxhzv-0004uB-3F
	for gcvg-git-2@plane.gmane.org; Wed, 27 May 2015 22:32:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751619AbbE0UcP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 May 2015 16:32:15 -0400
Received: from mail-pa0-f53.google.com ([209.85.220.53]:33580 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751445AbbE0UcO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 May 2015 16:32:14 -0400
Received: by padbw4 with SMTP id bw4so6011197pad.0
        for <git@vger.kernel.org>; Wed, 27 May 2015 13:32:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id;
        bh=bfFL16fM1j/3krojluDOpvs5fc5DcIXlXMUW1xnztVU=;
        b=dDYkjQUVia/MBJZShlVt5r84BWaqwSJ3ZlTxot/EfKyewNbiYIMr8fmN9YJ9EGxNcf
         +lSZ0kVg+ENlJOjiuSbL8Oaggy1CFqky/Un3FVhQoKUKIrBU2BUtm7BMiWohB/L3+4Fk
         HBKbUN+PmVOqA5w+xI8+UdkP4kCBttNE3pvP/IjxAU1/QQ8mkq2dVhK5lywQw4BAuJAl
         Ah5dGdhbpYejJiZgp/oBp+7cKLM03opT24lnRQrP5OqNimAk9vgSguf364JQTlJsnTh5
         qUkISagClpSDG7gmORvnXnYXDHB52avyX1NELY+VcSb5Nl7QfZ2mWJSi5alAnOG4YpNq
         gckw==
X-Received: by 10.68.233.71 with SMTP id tu7mr61959232pbc.14.1432758733920;
        Wed, 27 May 2015 13:32:13 -0700 (PDT)
Received: from localhost.localdomain (212.44.20.129.ip.redstone-isp.net. [212.44.20.129])
        by mx.google.com with ESMTPSA id t6sm25909pbs.92.2015.05.27.13.32.10
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 May 2015 13:32:12 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270084>

Fixing bug with UTF-16 files when they are retreived by git-p4.
It was always getting the tip version of the file and the history of the
file was lost.
---
 git-p4.py |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git-p4.py b/git-p4.py
index cdfa2df..be2c7da 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -2098,7 +2098,7 @@ class P4Sync(Command, P4UserMap):
             # them back too.  This is not needed to the cygwin windows version,
             # just the native "NT" type.
             #
-            text = p4_read_pipe(['print', '-q', '-o', '-', file['depotFile']])
+            text = p4_read_pipe(['print', '-q', '-o', '-', "%s@%s" % (file['depotFile'], file['change']) ])
             if p4_version_string().find("/NT") >= 0:
                 text = text.replace("\r\n", "\n")
             contents = [ text ]
-- 
1.7.10.4
