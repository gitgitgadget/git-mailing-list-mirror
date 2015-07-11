From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 09/16] worktree: make --detach mutually exclusive with -b/-B
Date: Fri, 10 Jul 2015 20:05:39 -0400
Message-ID: <1436573146-3893-10-git-send-email-sunshine@sunshineco.com>
References: <1436573146-3893-1-git-send-email-sunshine@sunshineco.com>
Cc: Duy Nguyen <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>,
	Mark Levedahl <mlevedahl@gmail.com>,
	Mikael Magnusson <mikachu@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 11 09:14:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZDozU-00026s-IF
	for gcvg-git-2@plane.gmane.org; Sat, 11 Jul 2015 09:14:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753121AbbGKHOY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 Jul 2015 03:14:24 -0400
Received: from mail-ig0-f170.google.com ([209.85.213.170]:34651 "EHLO
	mail-ig0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751957AbbGKHOX (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Jul 2015 03:14:23 -0400
Received: by igvi1 with SMTP id i1so4312284igv.1
        for <git@vger.kernel.org>; Sat, 11 Jul 2015 00:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=iYP+Z78PWdShXgLrn2xDrHkeiY+sj/bwsEXyC8COg5A=;
        b=FsJqrJ2TqgWg875ETLIe5OVN8jfyJTRvNs4Ak4UYPu9qzLiKNFEbHNVdreYCYTNuoZ
         Y29YX4qVLb9SZTi8odJJRerJarrAwm4G4k6F4QHjcOMbYNyz+YzAsUousl7G7cibAV92
         VIgbFIordyJCZQJ0FqTVAusEqQfLXQTMcGI3Om5cpnwahT+xPOwrYSUNDZ9QHuRBDq5d
         Ac6x90euC8KCCUy4hZGx9wt1JIWjoI13XoXqlKSCwsEkp9s8lcheWa0RaxJ8mJAiqnXY
         rrl0M/1qXLQK5CTaY3KE0/JwMUa71a667GeEJ4kkDqgdyRaUqrJbM3ZAboCyZw8MVS3e
         wlvA==
X-Received: by 10.50.17.104 with SMTP id n8mr1375682igd.21.1436573195959;
        Fri, 10 Jul 2015 17:06:35 -0700 (PDT)
Received: from localhost.localdomain (user-12l3cpl.cable.mindspring.com. [69.81.179.53])
        by smtp.gmail.com with ESMTPSA id g81sm7533321ioi.20.2015.07.10.17.06.35
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 10 Jul 2015 17:06:35 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.rc1.201.ga12d9f8
In-Reply-To: <1436573146-3893-1-git-send-email-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273858>

Be consistent with git-checkout which disallows this (not particularly
meaningful) combination.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
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
2.5.0.rc1.201.ga12d9f8
