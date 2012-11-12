From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 4/4] remote-hg: avoid bad refs
Date: Mon, 12 Nov 2012 18:41:08 +0100
Message-ID: <1352742068-15346-5-git-send-email-felipe.contreras@gmail.com>
References: <1352742068-15346-1-git-send-email-felipe.contreras@gmail.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 12 18:41:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TXy1D-0004ZI-RG
	for gcvg-git-2@plane.gmane.org; Mon, 12 Nov 2012 18:41:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753915Ab2KLRlk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Nov 2012 12:41:40 -0500
Received: from mail-bk0-f46.google.com ([209.85.214.46]:36570 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753795Ab2KLRli (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Nov 2012 12:41:38 -0500
Received: by mail-bk0-f46.google.com with SMTP id q16so197208bkw.19
        for <git@vger.kernel.org>; Mon, 12 Nov 2012 09:41:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=FDvIyzHlV9Cquwl28PM6XOUkCjtLaeRHhFQKpFMxkgE=;
        b=KIfKpULdQW154kLKp9YimZxtYmGqzWWhKd/zLc241RiPPFLZ63EegSXk6aceoZYIT9
         mqw20b6p+lknrgyWQhrSC3OzfxyCvlmejaYc4AfZITcMx5JjN7XQQsuGtH7R+3H6NV63
         OGv3GZPR5QknQfif2LBf2BMZtLjdsGiCv6oAqu/WL6GEulIuX3xDwaNY14BwaujmNE89
         9vpyQD6YzGElhOG0r6JNCvJmF3Ki8QcHglNqfpRtHZF8ja6HvxGoMGyyQvSv0MLI1wUM
         A/gDdimWADh3jBGANKIT3oiC66siZUEtPuOmtXDWE2Z/jhzmgFka+zTm7IvYRfC1l3lc
         2O6A==
Received: by 10.204.9.138 with SMTP id l10mr7259886bkl.80.1352742097676;
        Mon, 12 Nov 2012 09:41:37 -0800 (PST)
Received: from localhost (ip-109-43-0-114.web.vodafone.de. [109.43.0.114])
        by mx.google.com with ESMTPS id 9sm3868563bkq.13.2012.11.12.09.41.35
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 12 Nov 2012 09:41:36 -0800 (PST)
X-Mailer: git-send-email 1.8.0
In-Reply-To: <1352742068-15346-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209495>

Turns out fast-export throws bad 'reset' commands because of a behavior
in transport-helper that is not even needed.

Either way, better to ignore them, otherwise the user will get warnings
when we OK them.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/git-remote-hg | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/contrib/remote-helpers/git-remote-hg b/contrib/remote-helpers/git-remote-hg
index 3cdc1e2..48f8f5d 100755
--- a/contrib/remote-helpers/git-remote-hg
+++ b/contrib/remote-helpers/git-remote-hg
@@ -704,6 +704,9 @@ def do_export(parser):
         elif ref.startswith('refs/tags/'):
             tag = ref[len('refs/tags/'):]
             parser.repo.tag([tag], node, None, True, None, {})
+        else:
+            # transport-helper/fast-export bugs
+            continue
         print "ok %s" % ref
 
     print
-- 
1.8.0
