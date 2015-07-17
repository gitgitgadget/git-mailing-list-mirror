From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v3 02/22] checkout: name check_linked_checkouts() more meaningfully
Date: Fri, 17 Jul 2015 18:59:57 -0400
Message-ID: <1437174017-81687-3-git-send-email-sunshine@sunshineco.com>
References: <1437174017-81687-1-git-send-email-sunshine@sunshineco.com>
Cc: Junio C Hamano <gitster@pobox.com>, Duy Nguyen <pclouds@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 18 01:01:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZGEdD-0002J0-6W
	for gcvg-git-2@plane.gmane.org; Sat, 18 Jul 2015 01:01:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753767AbbGQXBQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Jul 2015 19:01:16 -0400
Received: from mail-ig0-f177.google.com ([209.85.213.177]:32943 "EHLO
	mail-ig0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753719AbbGQXBO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Jul 2015 19:01:14 -0400
Received: by igbpg9 with SMTP id pg9so5819769igb.0
        for <git@vger.kernel.org>; Fri, 17 Jul 2015 16:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kYZfSE2E1daSpZZeV07TFSvmtGaaAmTK8SbGGWNK+Rk=;
        b=HLVgIYbupwLUdUzsaSOt9YdZy3kIm3QpTE07GjXMMLnwF3W1Ch59fA7GDnTQas0jWN
         i7epADNLfVygfF5/B3DR3fUuzHaTkOlxMESmIpX0LUrfSGm/lDL+ma1glU3qSA/WKNnJ
         c7EFuha+VWVvVZITvDQ+tALUsvA2xg8VJUwaua+IoT8XCGz0rO+qBSpcph7BMnKDOdZ4
         y5O/EDHF0TY3vAvUxYeyzMUgvWZDTByXVemnLTLApeFqTRo44Obhm940Mm2EwaZx+u9x
         i7yosPcVlC5z/Kj3uyUMeNi7lmi3R1yd5BJf/nQUtWUVw8Eqnzr4s7yJkRAffjEjlrv8
         9MBA==
X-Received: by 10.107.150.141 with SMTP id y135mr19904277iod.38.1437174074053;
        Fri, 17 Jul 2015 16:01:14 -0700 (PDT)
Received: from localhost.localdomain (user-12l3cpl.cable.mindspring.com. [69.81.179.53])
        by smtp.gmail.com with ESMTPSA id 140sm8414824ion.16.2015.07.17.16.01.12
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 17 Jul 2015 16:01:13 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.rc2.378.g0af52e8
In-Reply-To: <1437174017-81687-1-git-send-email-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274130>

check_linked_checkouts() doesn't just "check" linked checkouts for
"something"; specifically, it aborts the operation if the branch about
to be checked out is already checked out elsewhere. Therefore, rename it
to die_if_checked_out() to give a better indication of its function.
The more meaningful name will be particularly important when this
function is later published for use by other callers.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---

No changes since v2.

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
