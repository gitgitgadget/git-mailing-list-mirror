Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3459F20136
	for <e@80x24.org>; Thu, 16 Feb 2017 11:30:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754676AbdBPLa3 (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Feb 2017 06:30:29 -0500
Received: from mail-lf0-f67.google.com ([209.85.215.67]:35944 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750982AbdBPL3t (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Feb 2017 06:29:49 -0500
Received: by mail-lf0-f67.google.com with SMTP id h65so1216278lfi.3
        for <git@vger.kernel.org>; Thu, 16 Feb 2017 03:29:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tP+L9AGkD8PHM0b013CR4W/S/1DtmkoFF6bk5BSGsds=;
        b=UAkg+S44V3ObN42ofVyAgyqXMZbSF2SBrou9YHKrJNGVdyJNuNuSNwery2WXdoka/i
         MXlTfoln0kE7BC6lpwGZhEKq9dcsnovYMsDKXwOVpTcR6T3XTkyH0SNLVPphAIpor9bX
         EfH2dJaIv7OEa+IT/t8DAA68u7WN0MvDn9fj6XkZ0YPCTvJsOeB0Z3Eq1VhvJ0d7RQi8
         es2a/4tbE4bSt9Je2d/oyWsWnW1bMyXYQIsD4yNxHrq5i1XvCUU4r/7Yl5YqQQT9R3yz
         48ND2uO8sDjGzQfpECxzL3vpAbXBg4xc2KbU0rhBSo8j0q1AZC91E7+6qTpxJ+xeR4Oj
         6reQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tP+L9AGkD8PHM0b013CR4W/S/1DtmkoFF6bk5BSGsds=;
        b=PgA34jtrw+oHz0vvitAi9ZOLLjkkL0JHHx5tDVRRzm2iGwEAMifeXcfxz1U9tK6Mop
         TQIHk1bWLgJsuce48Lm37pueGO7VZa2HHFsMNtbxaPC83QxVSMZVH4g6YrT7C0QTrfYy
         NtVKSCVk7hvH5dGz3g8nVqfKRYOvrB5MiSFCh7TDjR2oh97fNPJQub8uBj5T6d5aTwin
         Xv93gRnkT5NEXbYyNM7hHKAL9dFycvBJWYYmkXZ+1O8JUABzmc/9CNWmnOgsLuRRwR94
         vP3qtFLxHkQKRgxpuihDB8T37AObDKE8iQyJHSHPFqBI8oKSwuNgC2zAUsj3wZVD/28g
         wfrQ==
X-Gm-Message-State: AMke39lTILNAAgc6rVTiDla2EZO1e9uGbMXxjTyVPSiaHlEcQnPdoF5L+Dz2szIkAjKPJQ==
X-Received: by 10.46.14.25 with SMTP id 25mr514850ljo.55.1487244587301;
        Thu, 16 Feb 2017 03:29:47 -0800 (PST)
Received: from localhost.localdomain ([193.106.40.78])
        by smtp.gmail.com with ESMTPSA id v3sm1641430ljd.65.2017.02.16.03.29.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 Feb 2017 03:29:46 -0800 (PST)
From:   Maxim Moseychuk <franchesko.salias.hudro.pedros@gmail.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net,
        Maxim Moseychuk <franchesko.salias.hudro.pedros@gmail.com>
Subject: [PATCH 2/3] bisect_next_all: convert xsnprintf to git_psprintf
Date:   Thu, 16 Feb 2017 14:28:28 +0300
Message-Id: <20170216112829.18079-3-franchesko.salias.hudro.pedros@gmail.com>
X-Mailer: git-send-email 2.11.1
In-Reply-To: <20170216112829.18079-1-franchesko.salias.hudro.pedros@gmail.com>
References: <20170216112829.18079-1-franchesko.salias.hudro.pedros@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Git can't run bisect between 2048+ commits if use russian translation.
Reproduce "LANG=ru_RU.UTF8 git bisect start v4.9 v4.8" on linux sources.

Dummy solution: just increase buffer size but is not safe.
Size gettext string is a runtime value.

Signed-off-by: Maxim Moseychuk <franchesko.salias.hudro.pedros@gmail.com>
---
 bisect.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/bisect.c b/bisect.c
index 21bc6daa4..8670cc97a 100644
--- a/bisect.c
+++ b/bisect.c
@@ -940,7 +940,7 @@ int bisect_next_all(const char *prefix, int no_checkout)
 	struct commit_list *tried;
 	int reaches = 0, all = 0, nr, steps;
 	const unsigned char *bisect_rev;
-	char steps_msg[32];
+	char *steps_msg;
 
 	read_bisect_terms(&term_bad, &term_good);
 	if (read_bisect_refs())
@@ -990,14 +990,15 @@ int bisect_next_all(const char *prefix, int no_checkout)
 
 	nr = all - reaches - 1;
 	steps = estimate_bisect_steps(all);
-	xsnprintf(steps_msg, sizeof(steps_msg),
-		  Q_("(roughly %d step)", "(roughly %d steps)", steps),
-		  steps);
+
+	steps_msg = git_psprintf(Q_("(roughly %d step)", "(roughly %d steps)",
+		  steps), steps);
 	/* TRANSLATORS: the last %s will be replaced with
 	   "(roughly %d steps)" translation */
 	printf(Q_("Bisecting: %d revision left to test after this %s\n",
 		  "Bisecting: %d revisions left to test after this %s\n",
 		  nr), nr, steps_msg);
+	free(steps_msg);
 
 	return bisect_checkout(bisect_rev, no_checkout);
 }
-- 
2.11.1

