From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v3 2/7] attr.c: replace home_config_paths() with xdg_config_home()
Date: Wed,  6 May 2015 16:00:59 +0800
Message-ID: <1430899264-18447-1-git-send-email-pyokagan@gmail.com>
References: <20150421040627.GA5415@yoshi.chippynet.com>
Cc: Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 06 10:02:05 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YpuHM-0007s7-Rx
	for gcvg-git-2@plane.gmane.org; Wed, 06 May 2015 10:02:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751489AbbEFIB7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 May 2015 04:01:59 -0400
Received: from mail-pa0-f52.google.com ([209.85.220.52]:35436 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751078AbbEFIB7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 May 2015 04:01:59 -0400
Received: by pabtp1 with SMTP id tp1so2442962pab.2
        for <git@vger.kernel.org>; Wed, 06 May 2015 01:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9ZZB6O7OknPPMmi7e3knBBcF4V1qpBEzV82UhvH3Lco=;
        b=RXTOyte6UsIMvdFO2xprjNHE1F1agFcG1xfdtHtpB549ASJ/suqhH5EfNVJOO+JfFP
         yYqm/KPv6+qg517msRrzo7OKgclxygu8UIz2Um+f5o0auD5CVOF0THS5guHLzSsmdnyE
         FF1aLAwraInYEVmvj3E8b8mEzyxcNZgIH5ZTgEKv3MmHCrl0+sajb0KBI3SChaYks40d
         Ir0rVIcGRBNneb1QMbOLJ1HoaL3B3nk5AVngq3LnYIWZcCyynJB5ZqFeqEPu2/K1EPwV
         FjHKkI4zHTjh9fUCfeorznInkLYCLFk5JfKp+VxQj2udbP+tchMetdnfPVfCLa0/SbYl
         hR8A==
X-Received: by 10.68.224.10 with SMTP id qy10mr59850232pbc.23.1430899317913;
        Wed, 06 May 2015 01:01:57 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id cy5sm1074571pdb.85.2015.05.06.01.01.55
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 06 May 2015 01:01:56 -0700 (PDT)
X-Mailer: git-send-email 2.1.4
In-Reply-To: <20150421040627.GA5415@yoshi.chippynet.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268456>

Since only the xdg attributes file path is required, simplify the code
by using xdg_config_home() instead of home_config_paths().

Signed-off-by: Paul Tan <pyokagan@gmail.com>
---

Re-sending the patch series. There are no changes.

 attr.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/attr.c b/attr.c
index 1f9eebd..868dce3 100644
--- a/attr.c
+++ b/attr.c
@@ -488,7 +488,6 @@ static int git_attr_system(void)
 static void bootstrap_attr_stack(void)
 {
 	struct attr_stack *elem;
-	char *xdg_attributes_file;
 
 	if (attr_stack)
 		return;
@@ -507,10 +506,8 @@ static void bootstrap_attr_stack(void)
 		}
 	}
 
-	if (!git_attributes_file) {
-		home_config_paths(NULL, &xdg_attributes_file, "attributes");
-		git_attributes_file = xdg_attributes_file;
-	}
+	if (!git_attributes_file)
+		git_attributes_file = xdg_config_home("attributes");
 	if (git_attributes_file) {
 		elem = read_attr_from_file(git_attributes_file, 1);
 		if (elem) {
-- 
2.1.4
