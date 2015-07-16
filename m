From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 12/20] worktree: make --detach mutually exclusive with -b/-B
Date: Thu, 16 Jul 2015 04:20:17 -0400
Message-ID: <1437034825-32054-13-git-send-email-sunshine@sunshineco.com>
References: <1437034825-32054-1-git-send-email-sunshine@sunshineco.com>
Cc: Junio C Hamano <gitster@pobox.com>, Duy Nguyen <pclouds@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 16 10:22:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZFeQs-0000NF-Js
	for gcvg-git-2@plane.gmane.org; Thu, 16 Jul 2015 10:22:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754265AbbGPIWI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Jul 2015 04:22:08 -0400
Received: from mail-ie0-f180.google.com ([209.85.223.180]:36399 "EHLO
	mail-ie0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754086AbbGPIU5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Jul 2015 04:20:57 -0400
Received: by ieik3 with SMTP id k3so51219586iei.3
        for <git@vger.kernel.org>; Thu, 16 Jul 2015 01:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=So+rWSB/2XXigvOeoxBi9wXr+aHpkbWNLv1R1euhckI=;
        b=xwtawLCBAaURcvYNA86v4NFjIbe1HALilfjzO9WNs+vtddmKBY3galoTG7bG53CE9C
         +JCzTh22W1tD81N+ZKO6blLTWEBufO2OhIF0mEVAGcy+NEFD4V3RO+CFX4cnOyvoKxqW
         bDoX1Er2AYeTw2abZxMeqRq7AkrDK58a9obQyiMVAMXjKPxtVue/BGZeqIbNkRGF5JFt
         9kOoYPMu80+/me6Ia1q5uxl6vCh54vEspPUJYhka97doyFqmS/yNrTndxBDKo+qWNqG1
         2rMDlnZvEOBErIhtRcgn55QVGz/DlDVNMM0iHd9DRrif5aZyYhQfFhBBSHj1unKeukUn
         B2Wg==
X-Received: by 10.107.151.75 with SMTP id z72mr10115563iod.46.1437034857418;
        Thu, 16 Jul 2015 01:20:57 -0700 (PDT)
Received: from localhost.localdomain (user-12l3cpl.cable.mindspring.com. [69.81.179.53])
        by smtp.gmail.com with ESMTPSA id j83sm4581146iod.25.2015.07.16.01.20.56
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 16 Jul 2015 01:20:57 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.rc2.378.g0af52e8
In-Reply-To: <1437034825-32054-1-git-send-email-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274022>

Be consistent with git-checkout which disallows this (not particularly
meaningful) combination.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---

No changes since v1.

 builtin/worktree.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/worktree.c b/builtin/worktree.c
index 253382a..cd06bf5 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -296,8 +296,8 @@ static int add(int ac, const char **av, const char *prefix)
 
 	memset(&opts, 0, sizeof(opts));
 	ac = parse_options(ac, av, prefix, options, worktree_usage, 0);
-	if (opts.new_branch && new_branch_force)
-		die(_("-b and -B are mutually exclusive"));
+	if (!!opts.detach + !!opts.new_branch + !!new_branch_force > 1)
+		die(_("-b, -B, and --detach are mutually exclusive"));
 	if (ac < 1 || ac > 2)
 		usage_with_options(worktree_usage, options);
 
-- 
2.5.0.rc2.378.g0af52e8
