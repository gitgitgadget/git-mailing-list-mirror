Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1F9681F6DC
	for <e@80x24.org>; Wed, 25 Jan 2017 12:51:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751690AbdAYMv4 (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Jan 2017 07:51:56 -0500
Received: from mail-pf0-f194.google.com ([209.85.192.194]:35383 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751685AbdAYMvz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Jan 2017 07:51:55 -0500
Received: by mail-pf0-f194.google.com with SMTP id f144so14366117pfa.2
        for <git@vger.kernel.org>; Wed, 25 Jan 2017 04:51:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pls2ZMwauM4D0vOxvoAQH515smXoNJrZTkMX6nZ88ME=;
        b=Q8dhBjB4FSS/hqCo+Q0EZ85+tvcsx50zREnErzfS3sZvUkn20pq8uIrHXV5fO1RX4I
         dVo2/fNLfTgrmMTCdNoVzdLWcL0IRMTVYCtF3u2xqv7XYEtMwoYTwdNo+O1+D0gOB7YO
         cuO/5kB3ZuiFj04Rgq5FFGC77jz/groQwbLG+0+LwnhuHO0csG3m1GWG9J1jexFb6kq9
         BSCMRhBxFlCq6TQr35hZlpBToCzv+y+EUKxRbYCYgkb1MnibFg7eWd5DSJUvSrt1jLhH
         iZNzZoZewV0IlTk+iPU8JxG0NnuhvN0CfXE0pQfiHmVyhiRELLR4WB+263Tbyk56wC29
         JlUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pls2ZMwauM4D0vOxvoAQH515smXoNJrZTkMX6nZ88ME=;
        b=LOuykES6PzyswPoi4I+EHdqgVB5HTqD2yL62IV3wDrIFTwn1olNFtMHWQOqFEXor1J
         9w5QH8TY5HbXdv2RIbWkExArMa7j9BUzusaMVhn+1OZimsAT/0/iVthc+mO8cbgJaIs8
         Ep0sJuQzyRdaMJmpe4zIdhtBpJgvWYUbPtHsuDOlq/1dw19sDSh14dioVc6q0YWkNDRi
         3F0kgXcA8DARWyXrZhthqbFZmUQPotJRIeFLkUjNpmttouZxBs4/85MbNJ1vqesY0CzR
         c7p54JwQ0rP3WtaF/pJc+6bEf4oj0T80VUmS8TIVrc5uPl3CHxOtthXIZ3zSlhgFut1g
         0ctg==
X-Gm-Message-State: AIkVDXKS/+0cGNGUDEmBlzShc6s56Eis/PU0YEC7Xy3D8reVowoGYLGvWF2HCS9sYrWuEg==
X-Received: by 10.98.201.135 with SMTP id l7mr46200126pfk.67.1485348700477;
        Wed, 25 Jan 2017 04:51:40 -0800 (PST)
Received: from ash ([115.72.179.24])
        by smtp.gmail.com with ESMTPSA id u82sm1154144pfd.7.2017.01.25.04.51.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Jan 2017 04:51:39 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Wed, 25 Jan 2017 19:51:35 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, jacob.keller@gmail.com,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 4/5] revision.c: refactor ref selection handler after --exclude
Date:   Wed, 25 Jan 2017 19:50:53 +0700
Message-Id: <20170125125054.7422-5-pclouds@gmail.com>
X-Mailer: git-send-email 2.11.0.157.gd943d85
In-Reply-To: <20170125125054.7422-1-pclouds@gmail.com>
References: <20170121140806.tjs6wad3x4srdv3q@sigill.intra.peff.net>
 <20170125125054.7422-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Behavior change: "--exclude --blah --remotes" will not exclude remote
branches any more. Only "--exclude --remotes" does.

This is because --exclude is going to have a new friend --decorate-reflog
who haves the same way. When you allow a distant --remotes to complement
a previous option, things get complicated. In

    --exclude .. --decorate-reflog ... --remotes

Does it mean decorate remote reflogs, or does it mean exclude remotes
from the selected revisions?

Granted, there may be valid use cases for such a combination (e.g.
"decorate all reflogs except remote ones") but I feel option order is
not a good fit to express them.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 revision.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/revision.c b/revision.c
index cda2606c66..45cffcab44 100644
--- a/revision.c
+++ b/revision.c
@@ -2152,10 +2152,24 @@ static int handle_refs_pseudo_opt(const char *submodule,
 		return 0;
 	}
 
-	clear_ref_exclusion(&revs->ref_excludes);
 	return 1;
 }
 
+static int handle_revision_pseudo_opt(const char *, struct rev_info *, int, const char **, int *);
+
+static int handle_revision_pseudo_opt_after_exclude(const char *submodule,
+						    struct rev_info *revs,
+						    int argc, const char **argv,
+						    int *flags)
+{
+	int ret;
+
+	ret = handle_revision_pseudo_opt(submodule, revs, argc, argv, flags);
+	clear_ref_exclusion(&revs->ref_excludes);
+	revs->handle_pseudo_opt = NULL;
+	return ret;
+}
+
 static int handle_revision_pseudo_opt(const char *submodule,
 				struct rev_info *revs,
 				int argc, const char **argv, int *flags)
@@ -2184,6 +2198,7 @@ static int handle_revision_pseudo_opt(const char *submodule,
 		revs->bisect = 1;
 	} else if ((argcount = parse_long_opt("exclude", argv, &optarg))) {
 		add_ref_exclusion(&revs->ref_excludes, optarg);
+		revs->handle_pseudo_opt = handle_revision_pseudo_opt_after_exclude;
 		return argcount;
 	} else if (!strcmp(arg, "--reflog")) {
 		add_reflogs_to_pending(revs, *flags);
-- 
2.11.0.157.gd943d85

