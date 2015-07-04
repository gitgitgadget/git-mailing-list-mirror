From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 11/23] checkout: make --to unconditionally verbose
Date: Fri,  3 Jul 2015 20:17:20 -0400
Message-ID: <1435969052-540-12-git-send-email-sunshine@sunshineco.com>
References: <1435969052-540-1-git-send-email-sunshine@sunshineco.com>
Cc: Junio C Hamano <gitster@pobox.com>, Duy Nguyen <pclouds@gmail.com>,
	Mark Levedahl <mlevedahl@gmail.com>,
	Mikael Magnusson <mikachu@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 04 02:19:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZBBBS-0000fx-PJ
	for gcvg-git-2@plane.gmane.org; Sat, 04 Jul 2015 02:19:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755816AbbGDATs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Jul 2015 20:19:48 -0400
Received: from mail-ig0-f169.google.com ([209.85.213.169]:33356 "EHLO
	mail-ig0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755915AbbGDASh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Jul 2015 20:18:37 -0400
Received: by igcur8 with SMTP id ur8so153710823igc.0
        for <git@vger.kernel.org>; Fri, 03 Jul 2015 17:18:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6thK7zcVh8Gk57cK5F+OnFOxoALrOT41IMGOWmv9UdU=;
        b=sxn7DGTm0IugVPCg2VYa70z6gHHxVFOQBxVlRsTvjSxvwAK4+53lFAHkoUvFSN3Cvz
         n9zlt/DuP3QEJiPyMxwysTfA70MqpMWZenWmDtNZWKsk32+R0cJa5F/yAr8ETmago8bl
         T4Gx2hd23ujCTlP+THoeg22P8wQtUSzAGqTNOBHoZbe9JS8690CeJ1GFKHs19ojuyD2G
         mjkMJlS4e6H7+YCyJlbSBLPHZg7PscWwl23r2C5JpCsKiO2t5R8lotoQDvKw5IFbtirw
         5vQJhZFc3z4EreIHlS9AGSkJqffsG7ngSqga4jBlhmXLXZnRHj6V3GADgjBfgKe+kNVB
         ZqYA==
X-Received: by 10.50.97.33 with SMTP id dx1mr51361739igb.1.1435969116436;
        Fri, 03 Jul 2015 17:18:36 -0700 (PDT)
Received: from localhost.localdomain (user-12l3cpl.cable.mindspring.com. [69.81.179.53])
        by mx.google.com with ESMTPSA id z195sm7246110iod.33.2015.07.03.17.18.35
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 03 Jul 2015 17:18:36 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.rc1.197.g417e668
In-Reply-To: <1435969052-540-1-git-send-email-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273337>

prepare_linked_checkout() respects git-checkout's --quiet flag, however,
the plan is to relocate "git checkout --to" functionality to "git
worktree add", and git-worktree does not (yet) have a --quiet flag.
Consequently, make prepare_linked_checkout() unconditionally verbose to
ease eventual code movement to worktree.c.

(A --quiet flag can be added to git-worktree later if there is demand
for it.)

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 builtin/checkout.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 0dcdde2..86b1745 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -931,8 +931,7 @@ static int prepare_linked_checkout(const struct checkout_opts *opts)
 	strbuf_addf(&sb, "%s/commondir", sb_repo.buf);
 	write_file(sb.buf, 1, "../..\n");
 
-	if (!opts->quiet)
-		fprintf_ln(stderr, _("Enter %s (identifier %s)"), path, name);
+	fprintf_ln(stderr, _("Enter %s (identifier %s)"), path, name);
 
 	setenv("GIT_CHECKOUT_NEW_WORKTREE", "1", 1);
 	setenv(GIT_DIR_ENVIRONMENT, sb_git.buf, 1);
-- 
2.5.0.rc1.197.g417e668
