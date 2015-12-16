From: Alex Henrie <alexhenrie24@gmail.com>
Subject: [PATCH] blame: display a more helpful error message if the file was deleted
Date: Tue, 15 Dec 2015 17:00:47 -0700
Message-ID: <1450224047-25527-1-git-send-email-alexhenrie24@gmail.com>
Cc: Alex Henrie <alexhenrie24@gmail.com>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Dec 16 01:01:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a8zWc-0007F5-51
	for gcvg-git-2@plane.gmane.org; Wed, 16 Dec 2015 01:00:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754425AbbLPAAy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Dec 2015 19:00:54 -0500
Received: from mail-pa0-f49.google.com ([209.85.220.49]:33607 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754391AbbLPAAx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Dec 2015 19:00:53 -0500
Received: by mail-pa0-f49.google.com with SMTP id ur14so13388356pab.0
        for <git@vger.kernel.org>; Tue, 15 Dec 2015 16:00:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=2CHxgoO/+G/CuRdwh0Z6h/mVmdwKpvoGN/DRI9gvSmA=;
        b=cH3PQIGnwOh6GAKsrhA5DVeI//d5M+lj1MZL2trLgfcR4iBlh43AAM5BuRtZxyAcMI
         dyngpqpv9kmdETu8jAwMLmnyfdP0AiRJ6M4PUetWa0Nlcqpnu4NVEokHBlnaJwczFrWZ
         OTUBSJROdoaE/9brUIBm0KgcR1Z/8WLH7QfZpySJbSFWqncDoFsn1Em5ERfpthaF1roN
         76tFB2I1Xo4jtetZC4b4r2oVmE7wD08D/cYD6UufqJSrqvXaisc4zR5Vm4QKVXMJnAVA
         FSoFGkPgRPTwO2M03af0c44pyXEbjy8uLLrnMjK2LVaKcoEhU3PxUd6TlCb20uTruw/0
         5pfA==
X-Received: by 10.67.1.103 with SMTP id bf7mr58679201pad.147.1450224053080;
        Tue, 15 Dec 2015 16:00:53 -0800 (PST)
Received: from alex-wolverine.bmi.utah.edu ([2001:1948:410:2:290:f5ff:feea:ac6d])
        by smtp.gmail.com with ESMTPSA id u14sm389855pfi.58.2015.12.15.16.00.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 15 Dec 2015 16:00:51 -0800 (PST)
X-Mailer: git-send-email 2.6.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282513>

`git blame 22414770 generate-cmdlist.perl` currently results in:
    fatal: cannot stat path '22414770': No such file or directory

This patch changes the error message to:
    fatal: ambiguous argument 'generate-cmdlist.perl': unknown revision
    or path not in the working tree.
    Use '--' to separate paths from revisions, like this:
    'git <command> [<revision>...] -- [<file>...]'"

That way, the user knows to rewrite the command as
`git blame 22414770 -- generate-cmdlist.perl`.

Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
---
 builtin/blame.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index 1df13cf..f070272 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -2683,8 +2683,6 @@ parse_done:
 		argv[argc - 1] = "--";
 
 		setup_work_tree();
-		if (!file_exists(path))
-			die_errno("cannot stat path '%s'", path);
 	}
 
 	revs.disable_stdin = 1;
-- 
2.6.4
