From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 02/16] checkout: name check_linked_checkouts() more meaningfully
Date: Fri, 10 Jul 2015 20:05:32 -0400
Message-ID: <1436573146-3893-3-git-send-email-sunshine@sunshineco.com>
References: <1436573146-3893-1-git-send-email-sunshine@sunshineco.com>
Cc: Duy Nguyen <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>,
	Mark Levedahl <mlevedahl@gmail.com>,
	Mikael Magnusson <mikachu@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 11 09:03:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZDooh-0004iq-GR
	for gcvg-git-2@plane.gmane.org; Sat, 11 Jul 2015 09:03:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753327AbbGKHDO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 Jul 2015 03:03:14 -0400
Received: from mail-ig0-f179.google.com ([209.85.213.179]:33696 "EHLO
	mail-ig0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752667AbbGKHDL (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Jul 2015 03:03:11 -0400
Received: by iggp10 with SMTP id p10so48397550igg.0
        for <git@vger.kernel.org>; Sat, 11 Jul 2015 00:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=V+d9kklzPCNWYbfTSsNLRZePchSBMmMi3qvxwRA2pNg=;
        b=IhrQreIa6Z3Qa0P6vWFLWuqrJmBd/gUEkEBaYOGrOtcWRmbUnNVTQtEJtKuAXEBhRb
         M4e5MNSonfuu5AserVYuF9ec/4KyrRlL67HZH6NqU2YL2XZhFCBVYq96q1a6A+LjOarc
         6Y/DOlPQioRrTjBUS+k+Ol0AdoulSO5ORjOCUslfFkJeUMmvIWAp9wA+rH37kPz0nNxZ
         nThc75EMBRQEhL5KTRpFwDx76glVq6dp4SJjb105LgVvNWkiKjhiVz5wIiJIz8+Vljk0
         lNVdZDTV6VrTNwsC1nW+6jksYzzNqvYhpAC2G1R44yJf4dr5xhhMAI2TwvdEzZ1xJ9Sj
         aLnA==
X-Received: by 10.107.14.65 with SMTP id 62mr36430813ioo.67.1436573189750;
        Fri, 10 Jul 2015 17:06:29 -0700 (PDT)
Received: from localhost.localdomain (user-12l3cpl.cable.mindspring.com. [69.81.179.53])
        by smtp.gmail.com with ESMTPSA id g81sm7533321ioi.20.2015.07.10.17.06.28
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 10 Jul 2015 17:06:29 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.rc1.201.ga12d9f8
In-Reply-To: <1436573146-3893-1-git-send-email-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273851>

check_linked_checkouts() doesn't just "check" linked checkouts for
"something"; specifically, it aborts the operation if the branch about
to be checked out is already checked out elsewhere. Therefore, rename it
to die_if_checked_out() to give a better indication of its function.
The more meaningful name will be particularly important when this
function is later published for use by other callers.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 builtin/checkout.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 75f90a9..e75fb5e 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -910,7 +910,7 @@ done:
 	strbuf_release(&gitdir);
 }
 
-static void check_linked_checkouts(struct branch_info *new)
+static void die_if_checked_out(struct branch_info *new)
 {
 	struct strbuf path = STRBUF_INIT;
 	DIR *dir;
@@ -1152,7 +1152,7 @@ static int checkout_branch(struct checkout_opts *opts,
 		char *head_ref = resolve_refdup("HEAD", 0, sha1, &flag);
 		if (head_ref &&
 		    (!(flag & REF_ISSYMREF) || strcmp(head_ref, new->path)))
-			check_linked_checkouts(new);
+			die_if_checked_out(new);
 		free(head_ref);
 	}
 
-- 
2.5.0.rc1.201.ga12d9f8
