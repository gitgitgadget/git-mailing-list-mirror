From: Stefan Beller <stefanbeller@googlemail.com>
Subject: [PATCH 3/4] checkout: remove superfluous local variable
Date: Mon, 29 Jul 2013 21:49:57 +0200
Message-ID: <1375127398-31904-4-git-send-email-stefanbeller@googlemail.com>
References: <1375127398-31904-1-git-send-email-stefanbeller@googlemail.com>
Cc: Stefan Beller <stefanbeller@googlemail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 29 21:50:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V3tSL-0001Dj-K8
	for gcvg-git-2@plane.gmane.org; Mon, 29 Jul 2013 21:50:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753966Ab3G2Tt5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Jul 2013 15:49:57 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:50848 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753801Ab3G2Ttz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Jul 2013 15:49:55 -0400
Received: by mail-we0-f174.google.com with SMTP id q54so4422367wes.33
        for <git@vger.kernel.org>; Mon, 29 Jul 2013 12:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=rChBLkCF7FaUfHxjAyzTzHyNvxUtFFAXHrHxuodOIz0=;
        b=cEB57SAm0DNrgD10Ohc7UkmUwyXqBa/WOCNwUcL5bF/er4Euiutetku9iPg8ozqn4u
         8sbJaPFpuvpPMespDErRK2otqZuO21TOQJJAdRXki72AntL7SZrmqIAq7J9F55X6vUbJ
         kN3pNyXqZhWs+Q7KQhEEgoYykugNtoDsf+wlKmTBseETDRAwag4zCvAonanezG7Fr6NP
         TyTB+ArBTxb/Wzi0O3KLJswxkl+RS4/ZZ+MXL2+ESSi1xeDHbYTt9brmqNDHQn1eCzQb
         NLw2CtRZeGiVuP5Wo5qJOpSlRN1399QKr+9NSUpcV+V7pvYmMXVoWFYHiL5mA2wcpRZ8
         zdCw==
X-Received: by 10.194.9.101 with SMTP id y5mr44208651wja.86.1375127393399;
        Mon, 29 Jul 2013 12:49:53 -0700 (PDT)
Received: from localhost (ip-109-91-109-128.unitymediagroup.de. [109.91.109.128])
        by mx.google.com with ESMTPSA id li9sm24844700wic.2.2013.07.29.12.49.51
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 29 Jul 2013 12:49:52 -0700 (PDT)
X-Mailer: git-send-email 1.8.4.rc0.1.g8f6a3e5
In-Reply-To: <1375127398-31904-1-git-send-email-stefanbeller@googlemail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231326>

Signed-off-by: Stefan Beller <stefanbeller@googlemail.com>
---
 builtin/checkout.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 8b48f4a..ed39cec 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -228,8 +228,6 @@ static int checkout_paths(const struct checkout_opts *opts,
 	int flag;
 	struct commit *head;
 	int errs = 0;
-	int stage = opts->writeout_stage;
-	int merge = opts->merge;
 	int newfd;
 	struct lock_file *lock_file;
 
@@ -327,8 +325,8 @@ static int checkout_paths(const struct checkout_opts *opts,
 				continue;
 			if (opts->force) {
 				warning(_("path '%s' is unmerged"), ce->name);
-			} else if (stage) {
-				errs |= check_stage(stage, ce, pos);
+			} else if (opts->writeout_stage) {
+				errs |= check_stage(opts->writeout_stage, ce, pos);
 			} else if (opts->merge) {
 				errs |= check_stages((1<<2) | (1<<3), ce, pos);
 			} else {
@@ -352,9 +350,9 @@ static int checkout_paths(const struct checkout_opts *opts,
 				errs |= checkout_entry(ce, &state, NULL);
 				continue;
 			}
-			if (stage)
-				errs |= checkout_stage(stage, ce, pos, &state);
-			else if (merge)
+			if (opts->writeout_stage)
+				errs |= checkout_stage(opts->writeout_stage, ce, pos, &state);
+			else if (opts->merge)
 				errs |= checkout_merged(pos, &state);
 			pos = skip_same_name(ce, pos) - 1;
 		}
-- 
1.8.4.rc0.1.g8f6a3e5
