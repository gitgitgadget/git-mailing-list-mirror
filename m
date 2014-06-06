From: Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 09/20] git-rebase--interactive.sh: avoid "test <cond> -a/-o <cond>"
Date: Fri,  6 Jun 2014 07:55:52 -0700
Message-ID: <1402066563-28519-10-git-send-email-gitter.spiros@gmail.com>
References: <1402066563-28519-1-git-send-email-gitter.spiros@gmail.com>
Cc: jrnieder@gmail.com, Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 06 16:57:07 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WsvZm-0002Aq-JD
	for gcvg-git-2@plane.gmane.org; Fri, 06 Jun 2014 16:57:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752212AbaFFO44 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jun 2014 10:56:56 -0400
Received: from mail-pb0-f51.google.com ([209.85.160.51]:58007 "EHLO
	mail-pb0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752087AbaFFO4Q (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jun 2014 10:56:16 -0400
Received: by mail-pb0-f51.google.com with SMTP id ma3so2587330pbc.10
        for <git@vger.kernel.org>; Fri, 06 Jun 2014 07:56:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=aX2QtAj1/oMYB7gQY51T+DAKYijyOCligQZDqzvAhL4=;
        b=fpdf2EGiB/j39wHbXI+IaCC+sxuDkpEUU0xlnT159jvDO2v4JDJD491BgLY8xkuSmy
         3x9N2LUN+P+C0+SH9vDRDI7nSgEJX/0Bptrdsj1WonIF6FTvW10eBOEKU7v+l6qAAL41
         aK5ScWwOXnZeWzr7IsvNiElw8O2JBWYPtWZvZLt5P1EC/nvE6woavfOyyCMgofHxyTS6
         MntGiOC0kRE21TIa2LveF90gwLGEF3NtVwNNb68pVonB39vs1kgj0IN35t7qS/6bJR3n
         eNAJmLzfluY+q7WmtEh4pzcBslzpTfo0v6gMhGr9otrS5IPyK1K5wg8iIbX/1FmQyCSJ
         ENeA==
X-Received: by 10.68.171.229 with SMTP id ax5mr1604286pbc.125.1402066576189;
        Fri, 06 Jun 2014 07:56:16 -0700 (PDT)
Received: from devzero2000ubu.nephoscale.com (140.195.207.67.nephoscale.net. [67.207.195.140])
        by mx.google.com with ESMTPSA id pu5sm36850769pbb.4.2014.06.06.07.56.15
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 06 Jun 2014 07:56:15 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1402066563-28519-1-git-send-email-gitter.spiros@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250938>

The construct is error-prone; "test" being built-in in most modern
shells, the reason to avoid "test <cond> && test <cond>" spawning
one extra process by using a single "test <cond> -a <cond>" no
longer exists.

Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
---
 git-rebase--interactive.sh |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 6ec9d3c..797571f 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -1013,7 +1013,7 @@ then
 	git rev-list $revisions |
 	while read rev
 	do
-		if test -f "$rewritten"/$rev -a "$(sane_grep "$rev" "$state_dir"/not-cherry-picks)" = ""
+		if test -f "$rewritten"/$rev && test "$(sane_grep "$rev" "$state_dir"/not-cherry-picks)" = ""
 		then
 			# Use -f2 because if rev-list is telling us this commit is
 			# not worthwhile, we don't want to track its multiple heads,
-- 
1.7.10.4
