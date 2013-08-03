From: Stefan Beller <stefanbeller@googlemail.com>
Subject: [PATCHv3 4/9] checkout: remove superfluous local variable
Date: Sat,  3 Aug 2013 13:51:21 +0200
Message-ID: <1375530686-2309-5-git-send-email-stefanbeller@googlemail.com>
References: <1375530686-2309-1-git-send-email-stefanbeller@googlemail.com>
Cc: Stefan Beller <stefanbeller@googlemail.com>
To: git@vger.kernel.org, gitster@pobox.com, sunshine@sunshineco.com
X-From: git-owner@vger.kernel.org Sat Aug 03 13:51:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V5aN4-0005cc-41
	for gcvg-git-2@plane.gmane.org; Sat, 03 Aug 2013 13:51:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752599Ab3HCLvS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Aug 2013 07:51:18 -0400
Received: from mail-ea0-f180.google.com ([209.85.215.180]:41786 "EHLO
	mail-ea0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752551Ab3HCLvM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Aug 2013 07:51:12 -0400
Received: by mail-ea0-f180.google.com with SMTP id h10so777080eaj.11
        for <git@vger.kernel.org>; Sat, 03 Aug 2013 04:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=pYL82a+u7l/K80mTa6TK9LsiPesAbToBrHQh4ZjXwy8=;
        b=TKs3FCbLBB9oNo4HcwskSmhz7WO/9yWo28QgRzhil76hhe6UcUj5LsjdlMPra09n6b
         G+n31km3bq8NKGaB1/A49pRx+m1j2eRAG+pgUQbB0jFynVzyVVhkm6Kur9Jvq2Eg0Voa
         7LFZCLCXQ65oXgPTtxb+gVqx0bBQ9O8zjJH7ZmnC0mlLwsYsdOSTT0v4JVq3KjKeeuzW
         p1acgtyCedFm9tkgUrZ6EjxkllLwakgt3oza5lmm1C8GpWVc4gAWdXmhDZ643+3uZ4o8
         BWu29nMtzRm0oVvd4Jr3CO98R2CaU8tnUMTI25o29mnK/FtsPKnIea7fIsWbUeVqFDBX
         CprA==
X-Received: by 10.14.221.198 with SMTP id r46mr9348922eep.18.1375530670542;
        Sat, 03 Aug 2013 04:51:10 -0700 (PDT)
Received: from localhost (ip-109-91-109-128.unitymediagroup.de. [109.91.109.128])
        by mx.google.com with ESMTPSA id e1sm7125386eev.8.2013.08.03.04.51.09
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sat, 03 Aug 2013 04:51:09 -0700 (PDT)
X-Mailer: git-send-email 1.8.4.rc0.16.g7fca822.dirty
In-Reply-To: <1375530686-2309-1-git-send-email-stefanbeller@googlemail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231583>

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
1.8.4.rc0.16.g7fca822.dirty
