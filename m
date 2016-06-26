Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 23F9F20179
	for <e@80x24.org>; Sun, 26 Jun 2016 17:16:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751927AbcFZRQb (ORCPT <rfc822;e@80x24.org>);
	Sun, 26 Jun 2016 13:16:31 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:33667 "EHLO
	mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751265AbcFZRQ0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Jun 2016 13:16:26 -0400
Received: by mail-lf0-f67.google.com with SMTP id l188so26607908lfe.0
        for <git@vger.kernel.org>; Sun, 26 Jun 2016 10:16:25 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=memczJwdYAGcaImyX0caevOdDTxM2fOVSl73dhAoKig=;
        b=fsev648eUWdE4dAbqlq5CZMlHSPKGBnrkMmtJS5q01Zc+s0wws25maNEfml6pioD/E
         VNhv73Sn7xT/iIaJBheM8cZTSYI13Kn0+fKtdUnMJb+UnadogKctqNnwYyJJ2BpdKP1u
         AH1f3ukskrkIXLCNb22KvhP7Lue1x2NPUXSyRhAa3ypT5ovUabDH7bMlvUwLXn2TsQ7C
         /m/2ZcCwlJNGopl8eYX0ePVPPU/WPwEik0Mp0IqsZJO/f5KXR1IHeO8yLrFMAcCotded
         qH9VlQZvocwZL0T2uHkiQl4Y+yvn5zdIwSnS0aNmxDIGi+JXQGj6CW1SY+ByjdmHa6or
         oxRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=memczJwdYAGcaImyX0caevOdDTxM2fOVSl73dhAoKig=;
        b=IMG+NRTPe/QA94LEbizjRxS7ZsigyESoujs7gHQTQLRYleYEdlzLcG7/VCJO0G6AzM
         7ML+0OepRLP7Hhc8QEMVvDgDhaqj8R+kfMKlze7iUafb6oX3HpJLHEYhVVaN9jF3/Xzi
         u5tUA7CZpJxI54ajaaj+DFdL0OiKZclG9gHb3TlPGqElNMibnEG4G+dWH3BRw1L166sL
         eNrX2c+lKKgjWCVDobiJaqF29bK/jJJ6Oie2JgryXCy8xfL5GTg1Y7kzffJ0RhAlUZf/
         OLQhKbmmLaPtsedMcK2tXCCpcJCw3PMOnH44kVkeaHPGhBkAk1fqG1oerP3hX1QX/gaO
         wW2Q==
X-Gm-Message-State: ALyK8tLBLVPF27SJJYHBo750baJzh/lShSPA84QETR2w4JKi1+13RxoHG1D1FlamyEhxXw==
X-Received: by 10.46.0.32 with SMTP id 32mr4142836lja.40.1466961384983;
        Sun, 26 Jun 2016 10:16:24 -0700 (PDT)
Received: from duynguyen.does.not.exist (10.219.241.83.in-addr.dgcsystems.net. [83.241.219.10])
        by smtp.gmail.com with ESMTPSA id 76sm2624773lfu.26.2016.06.26.10.16.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 26 Jun 2016 10:16:24 -0700 (PDT)
From:	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To:	git@vger.kernel.org
Cc:	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 2/3] diff.c: separate "prefix" from RELATIVE_NAME (aka --relative)
Date:	Sun, 26 Jun 2016 19:16:15 +0200
Message-Id: <20160626171616.27948-3-pclouds@gmail.com>
X-Mailer: git-send-email 2.8.2.531.gd073806
In-Reply-To: <20160626171616.27948-1-pclouds@gmail.com>
References: <20160626171616.27948-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

So far "prefix" and "prefix_length" in struct diff_options are tied to
RELATIVE_NAME flag, making it tricky to add new features that need the
prefix.

This change essentially follows the foot steps in cd676a5 (diff
--relative: output paths as relative to the current subdirectory -
2008-02-12) and makes sure that the prefix stripping/filtering only
happens when RELATIVE_NAME flag is set. The stripping is much simpler
because all stripping now goes through strip_prefix(). So the patch is
mostly about filtering.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 diff.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/diff.c b/diff.c
index b4949a2..bd5d190 100644
--- a/diff.c
+++ b/diff.c
@@ -3153,7 +3153,7 @@ static void strip_prefix(struct diff_options *opt,
 {
 	int prefix_length = opt->prefix_length;
 
-	if (!prefix_length)
+	if (!prefix_length || !DIFF_OPT_TST(opt, RELATIVE_NAME))
 		return;
 
 	/* Strip the prefix but do not molest /dev/null and absolute paths */
@@ -3335,8 +3335,6 @@ void diff_setup_done(struct diff_options *options)
 	if (DIFF_OPT_TST(options, FIND_COPIES_HARDER))
 		options->detect_rename = DIFF_DETECT_COPY;
 
-	if (!DIFF_OPT_TST(options, RELATIVE_NAME))
-		options->prefix = NULL;
 	if (options->prefix)
 		options->prefix_length = strlen(options->prefix);
 	else
@@ -4976,7 +4974,8 @@ void diff_addremove(struct diff_options *options,
 		addremove = (addremove == '+' ? '-' :
 			     addremove == '-' ? '+' : addremove);
 
-	if (options->prefix &&
+	if (DIFF_OPT_TST(options, RELATIVE_NAME) &&
+	    options->prefix &&
 	    strncmp(concatpath, options->prefix, options->prefix_length))
 		return;
 
@@ -5021,7 +5020,8 @@ void diff_change(struct diff_options *options,
 			new_dirty_submodule = tmp;
 	}
 
-	if (options->prefix &&
+	if (DIFF_OPT_TST(options, RELATIVE_NAME) &&
+	    options->prefix &&
 	    strncmp(concatpath, options->prefix, options->prefix_length))
 		return;
 
@@ -5048,7 +5048,8 @@ struct diff_filepair *diff_unmerge(struct diff_options *options, const char *pat
 	struct diff_filepair *pair;
 	struct diff_filespec *one, *two;
 
-	if (options->prefix &&
+	if (DIFF_OPT_TST(options, RELATIVE_NAME) &&
+	    options->prefix &&
 	    strncmp(path, options->prefix, options->prefix_length))
 		return NULL;
 
-- 
2.8.2.531.gd073806

