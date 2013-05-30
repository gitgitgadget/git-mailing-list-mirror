From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 1/4] read-cache: fix wrong 'the_index' usage
Date: Thu, 30 May 2013 08:56:18 -0500
Message-ID: <1369922181-31016-2-git-send-email-felipe.contreras@gmail.com>
References: <1369922181-31016-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 30 15:58:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ui3Mv-0007A8-LO
	for gcvg-git-2@plane.gmane.org; Thu, 30 May 2013 15:58:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932149Ab3E3N6M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 May 2013 09:58:12 -0400
Received: from mail-gh0-f182.google.com ([209.85.160.182]:33878 "EHLO
	mail-gh0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755832Ab3E3N6K (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 May 2013 09:58:10 -0400
Received: by mail-gh0-f182.google.com with SMTP id z15so4576ghb.13
        for <git@vger.kernel.org>; Thu, 30 May 2013 06:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=o7Sitlz6Aqt1E35GNYlnVZG7H7o1BBo32lEFUIt0Uc4=;
        b=jR4BY3rsvs/TqP6lep+s1WrDlVHJyrFHtrjiCocf6Sy9PFz6YFK6YukrYraWbVGOsv
         mLp3+jlKcfwPkS8Svw1EarnrfqUrH3l3KSxFuZAlq0zvvvFRMi0gRZyKDFXQW7tbhR7A
         tZfFiS2HV6+FFLD1GQHewB7yqdGVTSIj/mgA5A/mTtFQdxQx4/uI5M6N5EW1rCn9s9is
         hxtmPRJQ8RMPpoBN3lzuA2eKmtiXJGOywuyJIxOMEq13XZN8uU8obZCgADvIzurNVl3Y
         lPBjpqswPeoj9t9RVkqEoC6uGrSYto09XaHxtyB/JWSTDqdAkwZP82oJo25uS8vhXsVh
         FoTg==
X-Received: by 10.236.51.103 with SMTP id a67mr3815825yhc.79.1369922290119;
        Thu, 30 May 2013 06:58:10 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id f30sm52034415yhi.21.2013.05.30.06.58.07
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 30 May 2013 06:58:08 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc3.312.g47657de
In-Reply-To: <1369922181-31016-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225997>

We are dealing with the 'istate' index, not 'the_index'.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 read-cache.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/read-cache.c b/read-cache.c
index 04ed561..5253ec5 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -626,7 +626,7 @@ int add_to_index(struct index_state *istate, const char *path, struct stat *st,
 			if (*ptr == '/') {
 				struct cache_entry *foundce;
 				++ptr;
-				foundce = index_name_exists(&the_index, ce->name, ptr - ce->name, ignore_case);
+				foundce = index_name_exists(istate, ce->name, ptr - ce->name, ignore_case);
 				if (foundce) {
 					memcpy((void *)startPtr, foundce->name + (startPtr - ce->name), ptr - startPtr);
 					startPtr = ptr;
-- 
1.8.3.rc3.312.g47657de
