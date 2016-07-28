Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C63151F858
	for <e@80x24.org>; Thu, 28 Jul 2016 16:03:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759044AbcG1QDJ (ORCPT <rfc822;e@80x24.org>);
	Thu, 28 Jul 2016 12:03:09 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35922 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759032AbcG1QDH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jul 2016 12:03:07 -0400
Received: by mail-wm0-f67.google.com with SMTP id x83so11813688wma.3
        for <git@vger.kernel.org>; Thu, 28 Jul 2016 09:03:05 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=XlIeVAt6Q9eoJEpTB7kbpkDeotAK5TDHzzccp3PzwAw=;
        b=VFtlWgH1AsWNtGdOQCBo6NDak2zoNZRPy5ft/29kFllOzGyBYCPlc6reYHqv56A516
         GGvz38si4fqQVXALNwnv18R49YxMayHXpkisHVDo0GDlwKBxCuUYe4/IVofpIUbGBMMy
         CXOBSExBRz/gAfaX743yxmXs5x5yGB1yTN5sewEL0djC+89KzFK9ABQd8vaDiAfmawu0
         W6LHuww74Li5wPzxnXabJOAcySvG9IxZBCjW9DxhsQKloukZE9ZbceSHP66ARd1qRaf1
         g5iZwYVJynEfM2JSencZl0PBbu22eDlpt0nno0bO365P/VjRknSoJ7p5LjkCu61JQOTZ
         8Ygw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=XlIeVAt6Q9eoJEpTB7kbpkDeotAK5TDHzzccp3PzwAw=;
        b=k0IaI4ik7YTS+gWGpn5JpdiDoqnhaqeIhJB7tYC2uBII5Yq/yFmY9Smh6T6GkfAkGc
         z2kpei+wPxX0O6BAmZ5EWEQdWRvTQwCKdRGc5Tw19RnqBHJH+QPs+WZJczzpME2wgfKS
         6qF3AM26UBGWW7nqU5J8Eyw30/gewcxN6nIprkCZealDwa0vfj3aOcYCMabDcAD58RWd
         U9DPDY6oahnxy3WpsB59JX4Qcu4ftx63Xo/XlN2Qwk9I+XsS66GTKq+PeEwCHLXdj6KS
         KCBObHdU/bqiR9tMxSsIrtAbzkpse8ZNlgbRhbzmvP/ipyz8Wwg84pNlrOHkUbP07zLI
         0OSA==
X-Gm-Message-State: AEkoousjK9j4t4wxnEKSbMTn3/lDZS0CCYtiGosSWAicOz1wnUeDeeThl6P7PHNzkkJDAA==
X-Received: by 10.194.102.72 with SMTP id fm8mr34441037wjb.50.1469721785204;
        Thu, 28 Jul 2016 09:03:05 -0700 (PDT)
Received: from localhost.localdomain (p54A20961.dip0.t-ipconnect.de. [84.162.9.97])
        by smtp.gmail.com with ESMTPSA id ka6sm12118232wjb.38.2016.07.28.09.03.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Jul 2016 09:03:03 -0700 (PDT)
From:	Robin Ruede <r.ruede@gmail.com>
To:	git@vger.kernel.org
Cc:	Robin Ruede <r.ruede@gmail.com>
Subject: [PATCH/RFC 1/7] list-objects: add sparse-prefix option to rev_info
Date:	Thu, 28 Jul 2016 18:02:20 +0200
Message-Id: <20160728160226.24018-2-r.ruede@gmail.com>
X-Mailer: git-send-email 2.9.2.472.g105ab30
In-Reply-To: <20160728160226.24018-1-r.ruede@gmail.com>
References: <20160728160226.24018-1-r.ruede@gmail.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

this skips all blob objects who's path does not begin with the specified
prefix

Signed-off-by: Robin Ruede <r.ruede@gmail.com>
---
 list-objects.c | 4 +++-
 revision.c     | 4 ++++
 revision.h     | 1 +
 3 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/list-objects.c b/list-objects.c
index f3ca6aa..91a6091 100644
--- a/list-objects.c
+++ b/list-objects.c
@@ -28,7 +28,9 @@ static void process_blob(struct rev_info *revs,
 
 	pathlen = path->len;
 	strbuf_addstr(path, name);
-	show(obj, path->buf, cb_data);
+	if (!revs->sparse_prefix || starts_with(path->buf, revs->sparse_prefix + 1)) {
+		show(obj, path->buf, cb_data);
+	}
 	strbuf_setlen(path, pathlen);
 }
 
diff --git a/revision.c b/revision.c
index edba5b7..a36a796 100644
--- a/revision.c
+++ b/revision.c
@@ -1664,6 +1664,10 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 	} else if ((argcount = parse_long_opt("skip", argv, &optarg))) {
 		revs->skip_count = atoi(optarg);
 		return argcount;
+	} else if ((argcount = parse_long_opt("sparse-prefix", argv, &optarg))) {
+		if(optarg[0] != '/') return error(N_("sparse prefix must start with /"));
+		revs->sparse_prefix = optarg;
+		return argcount;
 	} else if ((*arg == '-') && isdigit(arg[1])) {
 		/* accept -<digit>, like traditional "head" */
 		if (strtol_i(arg + 1, 10, &revs->max_count) < 0 ||
diff --git a/revision.h b/revision.h
index 9fac1a6..2c7c5f2 100644
--- a/revision.h
+++ b/revision.h
@@ -113,6 +113,7 @@ struct rev_info {
 			ancestry_path:1,
 			first_parent_only:1,
 			line_level_traverse:1;
+	const char *sparse_prefix;
 
 	/* Diff flags */
 	unsigned int	diff:1,
-- 
2.9.1.283.g3ca5b4c.dirty

