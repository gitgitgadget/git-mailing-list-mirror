From: Diwas Joshi <dj.dij123@gmail.com>
Subject: [PATCH/GSoC 3/3] Nousage message in error
Date: Thu, 24 Mar 2016 07:33:38 +0530
Message-ID: <1458785018-29232-1-git-send-email-dj.dij123@gmail.com>
Cc: Diwas Joshi <dj.dij123@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 24 03:04:02 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aiucz-0007Xv-2X
	for gcvg-git-2@plane.gmane.org; Thu, 24 Mar 2016 03:04:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752286AbcCXCD4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Mar 2016 22:03:56 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:35769 "EHLO
	mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751117AbcCXCDz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Mar 2016 22:03:55 -0400
Received: by mail-pf0-f195.google.com with SMTP id u190so5896249pfb.2
        for <git@vger.kernel.org>; Wed, 23 Mar 2016 19:03:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=m6DCp2tS+22EmDdq9RtVluT8aQXdDFhgToPEYkXjJZY=;
        b=gkBu0cSdpCPCTqJtv5zBbmSWIbAR11/zjW7pYoRFnxUMKitHArP9Z7VXAIq8faA7+y
         s+fRz15B5/kcA3mWkW5zD3H7WLall4y9LQBjA/H9r0N2/xo4f6TNjxvw3BhOfxnuaQMn
         zJ8XdV+Gy2wctU+/NMnpSezj+mak4EWy9Ypk+HFwcj4ziHzcoBd9k9deOA/4uD3MP52a
         mHfteC8rqT9Vw+q6byBiVgRvDc7NZXxqpRlVahEzhZIJ6D3EYjQRW6WASxI1cYip66Gl
         SL2Hh53HsPyub57DXUXtl9zSnL4OzQRRcVpKsflwJMr7uof/pfhvPL//hStgVShhxAjg
         rZHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=m6DCp2tS+22EmDdq9RtVluT8aQXdDFhgToPEYkXjJZY=;
        b=WFOpgFBap9njik4HVcOe7HRvduKAq5Y//b2rMcMGG9T2uSfO7XgTu3Jtop+KvutXSE
         EV/zNB+9r16kzdgkLyzLOVtFrkRXv58jsON/7uR+GLXnXXtdBkaDO9O9znnBOP2xTHb6
         BOZ9BGcJ9t1w6VYTumf0Vy/B6kfs/BjyREInWj4zO7z5qTfzrAy16QcOL1BoU/I6FPiD
         2rltu0TBMwmECX/NxXo146i+0EYmsGNT0VddT/q4lu8H+/4uG5pBkzABKfK07s1RDNW9
         mK2WwPHYjGJueD61km/ppltUu9+x+ukngIobEFc/thZrTCOMAMlPoRDpIrCXpcGxSf52
         uwDw==
X-Gm-Message-State: AD7BkJJgR1TgfpwlwP+wGyNtTqJg0jAvdFjedEp3UHr5RPia7VLizUPbIxabk7gJ1ebCeg==
X-Received: by 10.98.9.219 with SMTP id 88mr9063804pfj.0.1458785034737;
        Wed, 23 Mar 2016 19:03:54 -0700 (PDT)
Received: from localhost.localdomain ([106.77.191.30])
        by smtp.googlemail.com with ESMTPSA id ux2sm6936254pac.46.2016.03.23.19.03.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Mar 2016 19:03:54 -0700 (PDT)
X-Mailer: git-send-email 2.7.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289704>

- To show only error text instead of full usage message
- Adds exits to callback function in parse-options-cb.c instead of returning -1 which results in display of usage message.
---
 parse-options-cb.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/parse-options-cb.c b/parse-options-cb.c
index 239898d..b7321d1 100644
--- a/parse-options-cb.c
+++ b/parse-options-cb.c
@@ -85,8 +85,10 @@ int parse_opt_commits(const struct option *opt, const char *arg, int unset)
 
 	if (!arg)
 		return -1;
-	if (get_sha1(arg, sha1))
-		return error("malformed object name %s", arg);
+	if (get_sha1(arg, sha1)) {
+		error("malformed object name %s", arg);
+		exit(129);
+	}
 	commit = lookup_commit_reference(sha1);
 	if (!commit)
 		return error("no such commit %s", arg);
-- 
2.7.4
