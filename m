From: Stefan Beller <stefanbeller@googlemail.com>
Subject: [PATCH 4/4] repack: add unpack-unreachable
Date: Wed,  7 Aug 2013 16:00:49 +0200
Message-ID: <1375884049-14961-5-git-send-email-stefanbeller@googlemail.com>
References: <CACsJy8A-xo97MC-vBmqCrvvSDMWKd_MxnRrTBSeSqcQ1HifzJA@mail.gmail.com>
 <1375884049-14961-1-git-send-email-stefanbeller@googlemail.com>
Cc: Stefan Beller <stefanbeller@googlemail.com>
To: pclouds@gmail.com, iveqy@iveqy.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 07 16:01:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V74J0-0003tU-3R
	for gcvg-git-2@plane.gmane.org; Wed, 07 Aug 2013 16:01:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757519Ab3HGOBa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Aug 2013 10:01:30 -0400
Received: from mail-ee0-f44.google.com ([74.125.83.44]:32943 "EHLO
	mail-ee0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757497Ab3HGOBJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Aug 2013 10:01:09 -0400
Received: by mail-ee0-f44.google.com with SMTP id b47so869674eek.17
        for <git@vger.kernel.org>; Wed, 07 Aug 2013 07:01:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=k0rNvjCs8l+lbCN3xzG3o3YIPDq5GYtMumOMf4yqM9Q=;
        b=S/bIL7bCxTLmbH+EuA76JwXDxgPTOJkCABab2TJ2h8eYCz7mkiVphQdRJ3Yl6BWmBe
         7sqv78eKtcg1gkEMAe1VPqYsIeqft/krHiwGITnFAXLyFLq9vHSl91/GMSnwdU0TVIr7
         YhsUi5semdxuZ3yvwf4YRboagk2Z/OKaqTEp9U+jeAuMnEH1Bev0Jh9Exl9uDiU7uZFy
         7rwWjiFFL++0tQ+p7DioThzv+Go7EVgScvz5dpj5y4h4k/co4FTsd0YwbrLCiaexnX3b
         Ina09v+vtb3w708x0D9yRPkhiY+8jp73NyVTtDR27nvx4UKT92IkcP7Mb0ehxyVE/SWg
         a83g==
X-Received: by 10.14.37.4 with SMTP id x4mr3169165eea.16.1375884063794;
        Wed, 07 Aug 2013 07:01:03 -0700 (PDT)
Received: from localhost (eduroam-69-67.uni-paderborn.de. [131.234.69.67])
        by mx.google.com with ESMTPSA id t6sm9877257eel.12.2013.08.07.07.01.02
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 07 Aug 2013 07:01:03 -0700 (PDT)
X-Mailer: git-send-email 1.8.4.rc1.25.g2793d0a
In-Reply-To: <1375884049-14961-1-git-send-email-stefanbeller@googlemail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231827>

---
 builtin/pack-objects.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 0bd8f3b..0fe01fc 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -2795,6 +2795,9 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 		OPT_BOOL('q', NULL, &quiet, "be quiet"),
 		OPT_BOOL('l', NULL, &local,
 			 "pass --local to git-pack-objects"),
+		{ OPTION_CALLBACK, 0, "unpack-unreachable", NULL, N_("time"),
+		  N_("unpack unreachable objects newer than <time>"),
+		  PARSE_OPT_OPTARG, option_parse_unpack_unreachable },
 		{ OPTION_ARGUMENT, 0, "window", NULL, "n",
 		 "size of the window used for delta compression", 0 },
 		{ OPTION_ARGUMENT, 0, "window-memory", NULL, "n",
-- 
1.8.4.rc1.25.g2793d0a
