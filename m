From: Stefan Beller <stefanbeller@googlemail.com>
Subject: [PATCHv2 4/9] checkout: remove superfluous local variable
Date: Wed, 31 Jul 2013 18:28:32 +0200
Message-ID: <1375288117-1576-5-git-send-email-stefanbeller@googlemail.com>
References: <1375288117-1576-1-git-send-email-stefanbeller@googlemail.com>
Cc: Stefan Beller <stefanbeller@googlemail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 31 18:28:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V4ZGN-0007nF-Om
	for gcvg-git-2@plane.gmane.org; Wed, 31 Jul 2013 18:28:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759912Ab3GaQ2d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Jul 2013 12:28:33 -0400
Received: from mail-ee0-f51.google.com ([74.125.83.51]:46915 "EHLO
	mail-ee0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756874Ab3GaQ2c (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Jul 2013 12:28:32 -0400
Received: by mail-ee0-f51.google.com with SMTP id c1so459710eek.38
        for <git@vger.kernel.org>; Wed, 31 Jul 2013 09:28:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=rChBLkCF7FaUfHxjAyzTzHyNvxUtFFAXHrHxuodOIz0=;
        b=dK2hxZlZ+0PbMPzQHmU6uwEy2GAAsNxa9seeY13bdrikVn0cClRzxip4eiV6+TJn+E
         etjWzhlIF3D6nC/ZijgR7ASWETfofvEEfDxtcDM8+QGP+/mauaFu/TaCrwh1vEnQUOTu
         EdIvNiHI75sEONCsbU0uiHjQAWYEC0JhwlMM5zF1zDc17lUU7rvUzgPmikvqFgLsoOIy
         TN17jIcaepTtHwaDPvN0tAhJSaPmbpPLF6+7X8MydJigcL1yhropPEvJ1Yf5UlkJUhri
         jCoOmvxcleQnYKzwpILHoyO8/oRDZ7iUsjb7nQ8etaYGj/MwnzvUXXayltSHiCUpO2fW
         6EDQ==
X-Received: by 10.14.213.136 with SMTP id a8mr9656018eep.62.1375288111038;
        Wed, 31 Jul 2013 09:28:31 -0700 (PDT)
Received: from localhost (ip-109-91-109-128.unitymediagroup.de. [109.91.109.128])
        by mx.google.com with ESMTPSA id k3sm3694035een.16.2013.07.31.09.28.29
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 31 Jul 2013 09:28:30 -0700 (PDT)
X-Mailer: git-send-email 1.8.4.rc0.1.g8f6a3e5
In-Reply-To: <1375288117-1576-1-git-send-email-stefanbeller@googlemail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231422>

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
