From: Stefan Beller <stefanbeller@googlemail.com>
Subject: [PATCH] cherry-pick: do not segfault without arguments.
Date: Fri,  4 Oct 2013 16:09:12 +0200
Message-ID: <1380895752-5286-1-git-send-email-stefanbeller@googlemail.com>
Cc: Stefan Beller <stefanbeller@googlemail.com>
To: hiroshige88@gmail.com, gitster@pobox.com, jrnieder@gmail.com,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 04 16:09:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VS64A-0004Mc-2D
	for gcvg-git-2@plane.gmane.org; Fri, 04 Oct 2013 16:09:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754105Ab3JDOJJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Oct 2013 10:09:09 -0400
Received: from mail-ee0-f42.google.com ([74.125.83.42]:58197 "EHLO
	mail-ee0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753531Ab3JDOJI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Oct 2013 10:09:08 -0400
Received: by mail-ee0-f42.google.com with SMTP id b45so1842737eek.29
        for <git@vger.kernel.org>; Fri, 04 Oct 2013 07:09:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=92ei3zIQsPMnFaq6vcwLmohz1HZ43yHLYOBhJ/z8BBg=;
        b=Gzg2V+54BjkCubXZPkscf1c0ZBIR+ut50IhUDISx/T72zOzA2NIJrFllp2/eT1q7eR
         BB36DWRQHus4ruZCUmSWX9Pxt8hN9oBShNP4NCGsvip8YzfFI7hlgJxTdOa2RCyD+NcC
         Qkq2p+5PfOY8kjWni0G4jivNuKqIf22DTCr869GRGEGbb1NIpwAZzzfuFVr0U8PObT4d
         4oUZGlVB6A+qRNV4t3nEEsMpV963lqBLyGqb1mMcFHckTWnIX63hTZIRyWTxwUWCaeY1
         YtBcD2xVDWWP8CFfp6nMF3y9oC2hELFSu/k4R7dqx02Z7gZ2drUi4gIiIVkTwEpXvldz
         y0iw==
X-Received: by 10.14.107.68 with SMTP id n44mr22359212eeg.26.1380895746914;
        Fri, 04 Oct 2013 07:09:06 -0700 (PDT)
Received: from localhost (ip-109-91-109-128.unitymediagroup.de. [109.91.109.128])
        by mx.google.com with ESMTPSA id n48sm28486304eeg.17.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 04 Oct 2013 07:09:06 -0700 (PDT)
X-Mailer: git-send-email 1.8.4.1.469.gb38b9db
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235712>

Commit 182d7dc46b (2013-09-05, cherry-pick: allow "-" as abbreviation of
'@{-1}') accesses the first argument without checking whether it exists.

Signed-off-by: Stefan Beller <stefanbeller@googlemail.com>
---
 builtin/revert.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/revert.c b/builtin/revert.c
index 52c35e7..f81a48c 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -202,7 +202,7 @@ int cmd_cherry_pick(int argc, const char **argv, const char *prefix)
 	memset(&opts, 0, sizeof(opts));
 	opts.action = REPLAY_PICK;
 	git_config(git_default_config, NULL);
-	if (!strcmp(argv[1], "-"))
+	if (argc > 1 && !strcmp(argv[1], "-"))
 		argv[1] = "@{-1}";
 	parse_args(argc, argv, &opts);
 	res = sequencer_pick_revisions(&opts);
-- 
1.8.4.1.469.gb38b9db
