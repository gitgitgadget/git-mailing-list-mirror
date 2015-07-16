From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 02/20] checkout: name check_linked_checkouts() more meaningfully
Date: Thu, 16 Jul 2015 04:20:07 -0400
Message-ID: <1437034825-32054-3-git-send-email-sunshine@sunshineco.com>
References: <1437034825-32054-1-git-send-email-sunshine@sunshineco.com>
Cc: Junio C Hamano <gitster@pobox.com>, Duy Nguyen <pclouds@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 16 10:23:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZFeS6-0000uA-FX
	for gcvg-git-2@plane.gmane.org; Thu, 16 Jul 2015 10:23:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754271AbbGPIX0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Jul 2015 04:23:26 -0400
Received: from mail-ig0-f182.google.com ([209.85.213.182]:33323 "EHLO
	mail-ig0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752875AbbGPIUu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Jul 2015 04:20:50 -0400
Received: by iggp10 with SMTP id p10so8071134igg.0
        for <git@vger.kernel.org>; Thu, 16 Jul 2015 01:20:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pnLlJSe093z+YBlYKbtEbF3OeS5JmbF/+JwmirAweuM=;
        b=W1XfXxiNr4Rab13vbLFZ2JYnUmoavi0+xnwCdLKY/xqB0Paa5bBE4aUn32ZfuT5j1e
         DpkhufSFtnwKeYrZ2giTlvZVTXQPBBy6clxCvoQAKyLEZ1ZufgZ31d7g2i6K5VltFGoT
         +CjrbCEMucbjl1KaCr1NAbvsA8eZlRqNpch+mmLhfIaCojQFGAlHx9uP6JU1PC9iitrm
         U8b+eQjls3QJaoaYw8yeCFDUaH2oh7g3wkxtWzkdcdT5q4GoviZ/h/iqN+8RJ8Lzoqoo
         6YXd9xGQrkA65mNgZCKZFqnT4tHULqn0wJrxn/Y/rqD1QTvE0k0uJ9IL87fSbiJBF7TP
         J2Mg==
X-Received: by 10.107.152.81 with SMTP id a78mr11215493ioe.145.1437034849730;
        Thu, 16 Jul 2015 01:20:49 -0700 (PDT)
Received: from localhost.localdomain (user-12l3cpl.cable.mindspring.com. [69.81.179.53])
        by smtp.gmail.com with ESMTPSA id j83sm4581146iod.25.2015.07.16.01.20.48
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 16 Jul 2015 01:20:49 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.rc2.378.g0af52e8
In-Reply-To: <1437034825-32054-1-git-send-email-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274026>

check_linked_checkouts() doesn't just "check" linked checkouts for
"something"; specifically, it aborts the operation if the branch about
to be checked out is already checked out elsewhere. Therefore, rename it
to die_if_checked_out() to give a better indication of its function.
The more meaningful name will be particularly important when this
function is later published for use by other callers.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---

No changes since v1.

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
2.5.0.rc2.378.g0af52e8
