Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1162D1F403
	for <e@80x24.org>; Wed,  6 Jun 2018 07:39:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932315AbeFFHj5 (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Jun 2018 03:39:57 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:36817 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932274AbeFFHjv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Jun 2018 03:39:51 -0400
Received: by mail-lf0-f67.google.com with SMTP id u4-v6so7575852lff.3
        for <git@vger.kernel.org>; Wed, 06 Jun 2018 00:39:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=L/2BQM1FKIBjodlNSVRAke+U2HyaX9rVQDXnjip3ICQ=;
        b=u338x1Sw/Swr0Wjg8XiAyWBtWBQv/L1D1VTgkDjJSULFZ6uFZ8BI7xo9od34/5tcBO
         XvXookHzyzTGuFXhiZs5MIXZgOBMaOsrhnakvLTBgSaE+vOL9fD6Ps6GtTwMdun/6tWi
         bDeZQNG+aGbe2ghXV5ygQahsWAmDuEA+opARDjecEORjw9/QFEPiiT2dy7letD6PDgI+
         tY+zUqVo5yZZxld7mOm45Bq8CEjPOehfs3uHd0UD5v6a8dMSCf6ubduEJzXakVJAySqB
         owMNAtS1dJyIbrDP4wt+4Rj+e3nSSYSuHSdsbCcwEwcL4BHDQH7anbiD1A8ss+AT9y1s
         MouA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=L/2BQM1FKIBjodlNSVRAke+U2HyaX9rVQDXnjip3ICQ=;
        b=KWBNuBtVpWaaAb8Mz1ANNMhkGUxKOpB+Tpu5xq/HjIEdxkL4aax6tC4QFCkC2Owq5x
         hhWdNjlYqaFrW3PMTjoe+oeDJaYzSN8CvHTyDdGeI9y47ePwQAuWEDeA4ySWdEm6u138
         utIgeh1Qu72nPqhVWPOttvujHIswYmDzGsi3+YrzH2OMaDG1Yer/9lQGtqtdm5LAFcmg
         eZt2GMR0HOdX2zbLLIpX+PazF63aK0I4ug92IXUICHgE6hfL5XNtyH2gSvfqVpiO7yW7
         tf9BhgSd0oX1IO1DTVb+66nME6OmOqt3RUn+4WHWmcCUn4MZdEkfIRo6T1tvBcW6p7v1
         i2GA==
X-Gm-Message-State: APt69E1CEL0TJznHWtXu7ycAWt9b3OZiRiGjSysEm/bxcaA7weEEwB5c
        Bvxi45NvQ6DP05qZlbddOIQ=
X-Google-Smtp-Source: ADUXVKJP9W8UEdcqdFKPsnHLUKJXnOWOkjsW7LCBgDxEs4mqhdOz/y5REpIMZqoL4fH14TpouqtB0w==
X-Received: by 2002:a19:ef11:: with SMTP id n17-v6mr1209677lfh.66.1528270790287;
        Wed, 06 Jun 2018 00:39:50 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id u3-v6sm4189048lji.4.2018.06.06.00.39.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Jun 2018 00:39:49 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     bmwill@google.com, git@vger.kernel.org, newren@gmail.com,
        ramsay@ramsayjones.plus.com
Subject: [PATCH v3 05/20] unpack-trees: avoid the_index in verify_absent()
Date:   Wed,  6 Jun 2018 09:39:18 +0200
Message-Id: <20180606073933.14755-6-pclouds@gmail.com>
X-Mailer: git-send-email 2.18.0.rc0.333.g22e6ee6cdf
In-Reply-To: <20180606073933.14755-1-pclouds@gmail.com>
References: <20180606050207.13556-1-pclouds@gmail.com>
 <20180606073933.14755-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Both functions that are updated in this commit are called by
verify_absent(), which is part of the "unpack-trees" operation that is
supposed to work on any index file specified by the caller. Thanks to
Brandon [1] [2], an implicit dependency on the_index is exposed. This
commit fixes it.

In both functions, it makes sense to use src_index to check for
exclusion because it's almost unchanged and should give us the same
outcome as if running the exclude check before the unpack.

It's "almost unchanged" because we do invalidate cache-tree and
untracked cache in the source index. But this should not affect how
exclude machinery uses the index: to see if a file is tracked, and to
read a blob from the index instead of worktree if it's marked
skip-worktree (i.e. it's not available in worktree)

[1] a0bba65b10 (dir: convert is_excluded to take an index - 2017-05-05
[2] 2c1eb10454 (dir: convert read_directory to take an index - 2017-05-05)

Helped-by: Elijah Newren <newren@gmail.com>
Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 unpack-trees.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/unpack-trees.c b/unpack-trees.c
index 5268de7af5..3ace82ca27 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -1651,7 +1651,7 @@ static int verify_clean_subdirectory(const struct cache_entry *ce,
 	memset(&d, 0, sizeof(d));
 	if (o->dir)
 		d.exclude_per_dir = o->dir->exclude_per_dir;
-	i = read_directory(&d, &the_index, pathbuf, namelen+1, NULL);
+	i = read_directory(&d, o->src_index, pathbuf, namelen+1, NULL);
 	if (i)
 		return o->gently ? -1 :
 			add_rejected_path(o, ERROR_NOT_UPTODATE_DIR, ce->name);
@@ -1693,7 +1693,7 @@ static int check_ok_to_remove(const char *name, int len, int dtype,
 		return 0;
 
 	if (o->dir &&
-	    is_excluded(o->dir, &the_index, name, &dtype))
+	    is_excluded(o->dir, o->src_index, name, &dtype))
 		/*
 		 * ce->name is explicitly excluded, so it is Ok to
 		 * overwrite it.
-- 
2.18.0.rc0.333.g22e6ee6cdf

