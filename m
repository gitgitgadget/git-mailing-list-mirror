From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH] builtin/checkout: Fix message when switching to an existing branch
Date: Fri, 20 Aug 2010 23:11:47 +0530
Message-ID: <1282326107-2139-1-git-send-email-artagnon@gmail.com>
Cc: Tay Ray Chuan <rctay89@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Aug 20 19:44:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OmVdK-0002YI-Bn
	for gcvg-git-2@lo.gmane.org; Fri, 20 Aug 2010 19:44:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752029Ab0HTRn5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Aug 2010 13:43:57 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:42429 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751828Ab0HTRn4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Aug 2010 13:43:56 -0400
Received: by gwj17 with SMTP id 17so1347938gwj.19
        for <git@vger.kernel.org>; Fri, 20 Aug 2010 10:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=UwW5OYZW3S57e5DRzp2r/5AyCQHLZNCgsRubdKTh0YQ=;
        b=jDIA2R65gND9MPu0vT7V6LdO666v/gWFo1DJDXv+BsMjGCpwr2oLOsrttwe7TbIE2J
         GRF4uHtYuO1jaFbY8p2r/Rn8rj80QFxXLhS5J8oKsjVuvsdK+dQ+fiFcGcYg58enaTdV
         EuvQfurTLlFdEBrmYj+2um+P/rm5KFqv+KaNM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=ifpGpCqbgKygrPow5NZXMEzYW0b61tesN4hk+qGUFMCuEP41ESo8jhSkG0udiimaQe
         rkiMqA46pSYXQtSndV8aqpjbemqwqXmD0CR3KciWTCnrkmzbGyQyFCDPmF5gZVA0WMY2
         eDT0Xnd8IYc0Fio0IRjcwS3R+ZD3nWJiIGnsg=
Received: by 10.150.138.19 with SMTP id l19mr2181102ybd.123.1282326235566;
        Fri, 20 Aug 2010 10:43:55 -0700 (PDT)
Received: from localhost.localdomain ([203.110.240.41])
        by mx.google.com with ESMTPS id q31sm4093818ybk.1.2010.08.20.10.43.52
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 20 Aug 2010 10:43:54 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.2.408.g7357
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154060>

Fix "Switched to a new branch <name>" to read "Switched to branch
<name>" when <name> corresponds to an existing branch. This bug was
introduced in 02ac983 while introducing the `-B` switch.

Cc: Tay Ray Chuan <rctay89@gmail.com>
Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 builtin/checkout.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 156900d..ff5ac1e 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -545,10 +545,13 @@ static void update_refs_for_switch(struct checkout_opts *opts,
 			if (old->path && !strcmp(new->path, old->path))
 				fprintf(stderr, "Already on '%s'\n",
 					new->name);
-			else
+			else if (opts->new_branch)
 				fprintf(stderr, "Switched to%s branch '%s'\n",
 					opts->branch_exists ? " and reset" : " a new",
 					new->name);
+			else
+				fprintf(stderr, "Switched to branch '%s'\n",
+					new->name);
 		}
 		if (old->path && old->name) {
 			char log_file[PATH_MAX], ref_file[PATH_MAX];
-- 
1.7.2.2.408.g7357
