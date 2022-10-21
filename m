Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2850C433FE
	for <git@archiver.kernel.org>; Fri, 21 Oct 2022 22:26:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbiJUW0H (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Oct 2022 18:26:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229919AbiJUW0C (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Oct 2022 18:26:02 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7442F24AE25
        for <git@vger.kernel.org>; Fri, 21 Oct 2022 15:25:54 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id 137so3476409iou.9
        for <git@vger.kernel.org>; Fri, 21 Oct 2022 15:25:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=im6pf5qn5BQrDBjTVWszBsBsCVfSJjB/xDbDqCvcY78=;
        b=2vrSwCCp13nKHLWV7VG33zvag5jUC7whjF/jZQT6Q9jAWqRkPowVg5G5VYTAGXEQkU
         +oGQ57Pnlo+NybCpJVu8SE7YZMfFJrLvO6n3AZbOcdgnFkvTvgyfcY6XB4D+WgRFaaaE
         d/aDwmJRdet4sdd0NpgNT9/WWFTakRw6q9fzi0mouTp91ArKIMqNd9zCbos15xF2GprK
         P+xFhgz/cX5e3Yh5m6zgGavduxtcOJh+bVogbQoyNa5p+RfKlkZAB6+VQmfW+uhNoCh4
         Y9iPWmpGFXBJzI+F+U94Ouew/+sY8eHjIkvmQx9fE8I40tyNyVOB8794+4HFxVmyNXkY
         6Rmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=im6pf5qn5BQrDBjTVWszBsBsCVfSJjB/xDbDqCvcY78=;
        b=jqCXQT737GwvDrmt6vdfhrMIPTAY1k5hUEevWwcgWYq9SjgfwQlC+9CljKDq/PE7t6
         2rIUdRee2UjVoMtjVMUr32gFHlwGoIi6PHyyTKY0MqbwPJRF8iaKDjbyHLiAqRBAX6CC
         VAalw0tfVj5DcuizJTJ6o+nMwa5uUeFCmrD2JHX4UFAr7z0AGtjNX9LiqdOcbcXfWXCr
         pfbIz9qQ7vqIel8R1SgdOmq6K700gV0fFvQKHqteFP5NbKIb3VJRzWeK8p21h7+0U3rD
         Yq1FFsqxp6q+lWpHOTqA1KDF6jtm5RiLArYY9UPuR0KUGHWGHkCokYO+8x57h3//mV3j
         1YMg==
X-Gm-Message-State: ACrzQf1BlaaHR1HdhlaIh0TBLvQ8OM3zCHtA8pLmr/OJwZE9u1LBmG4C
        mZk5+DLmu4mswqX0JpaiAeY13lDOSIZ90qyr
X-Google-Smtp-Source: AMsMyM76fupcJTQEUHP5IJBd10ijRjJJeGD+0qNiHG/sorh9M9RZNFo5YHqwXc6Va9Xi1US/Rp0T4Q==
X-Received: by 2002:a05:6638:12c2:b0:364:158f:7263 with SMTP id v2-20020a05663812c200b00364158f7263mr16384238jas.269.1666391153084;
        Fri, 21 Oct 2022 15:25:53 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id f4-20020a056602088400b006bb57cfcb88sm4999316ioz.44.2022.10.21.15.25.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Oct 2022 15:25:52 -0700 (PDT)
Date:   Fri, 21 Oct 2022 18:25:51 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     jacob@initialcommit.io, peff@peff.net, gitster@pobox.com,
        avarab@gmail.com
Subject: [PATCH v3 5/7] shortlog: extract `shortlog_finish_setup()`
Message-ID: <8dd69edcf8cd15c631138cb6bdc130c5da808870.1666391136.git.me@ttaylorr.com>
References: <cover.1665448437.git.me@ttaylorr.com>
 <cover.1666391136.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1666391136.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Extract a function which finishes setting up the shortlog struct for
use. The caller in `make_cover_letter()` does not care about trailer
sorting, so it isn't strictly necessary to add a call there in this
patch.

But the next patch will add additional functionality to the new
`shortlog_finish_setup()` function, which the caller in
`make_cover_letter()` will care about.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/log.c      | 1 +
 builtin/shortlog.c | 7 ++++++-
 shortlog.h         | 1 +
 3 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/builtin/log.c b/builtin/log.c
index ee19dc5d45..b4d5420217 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1334,6 +1334,7 @@ static void make_cover_letter(struct rev_info *rev, int use_separate_file,
 	log.in2 = 4;
 	log.file = rev->diffopt.file;
 	log.groups = SHORTLOG_GROUP_AUTHOR;
+	shortlog_finish_setup(&log);
 	for (i = 0; i < nr; i++)
 		shortlog_add_commit(&log, list[i]);
 
diff --git a/builtin/shortlog.c b/builtin/shortlog.c
index a52288acab..ebf2bf3d3b 100644
--- a/builtin/shortlog.c
+++ b/builtin/shortlog.c
@@ -381,6 +381,11 @@ void shortlog_init(struct shortlog *log)
 	log->format.strdup_strings = 1;
 }
 
+void shortlog_finish_setup(struct shortlog *log)
+{
+	string_list_sort(&log->trailers);
+}
+
 int cmd_shortlog(int argc, const char **argv, const char *prefix)
 {
 	struct shortlog log = { STRING_LIST_INIT_NODUP };
@@ -450,7 +455,7 @@ int cmd_shortlog(int argc, const char **argv, const char *prefix)
 
 	if (!log.groups)
 		log.groups = SHORTLOG_GROUP_AUTHOR;
-	string_list_sort(&log.trailers);
+	shortlog_finish_setup(&log);
 
 	/* assume HEAD if from a tty */
 	if (!nongit && !rev.pending.nr && isatty(0))
diff --git a/shortlog.h b/shortlog.h
index 4850a8c30f..28d04f951a 100644
--- a/shortlog.h
+++ b/shortlog.h
@@ -33,6 +33,7 @@ struct shortlog {
 };
 
 void shortlog_init(struct shortlog *log);
+void shortlog_finish_setup(struct shortlog *log);
 
 void shortlog_add_commit(struct shortlog *log, struct commit *commit);
 
-- 
2.38.0.16.g393fd4c6db

