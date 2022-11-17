Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D6BDC43217
	for <git@archiver.kernel.org>; Thu, 17 Nov 2022 11:30:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239718AbiKQLax (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Nov 2022 06:30:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239668AbiKQLan (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Nov 2022 06:30:43 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2910A4509F
        for <git@vger.kernel.org>; Thu, 17 Nov 2022 03:30:42 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id k22so1497060pfd.3
        for <git@vger.kernel.org>; Thu, 17 Nov 2022 03:30:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=53njfhXcFSFE/dk0W1eUPSZJzqE9q5J/Ul2o7oNGCzM=;
        b=Ni0n3dptsu8LNH5IGRzYCXLOijhoJ9/97xC9oPdl+COzmk4X9/dkoWuOUtTTDRzrWI
         mbGT9NzFa9gp2l6Pb0FGWbjrZfRgY7z4WcdmPZNHtospNXeMMb5yWc8wx6VYD+WqmuG+
         BuChB7Mkrs1Trj4ERkEzlQobFGAXNFsNhHVGhN2mRo7cl4Fc6ul2zQ1vgs4uWkxJGHa+
         Hcvb1M/UtBqsejcX3IvD9z4yEEtNpWS3MqOK3YlR0rcXusKPHEQFCrCHNRCy8fDEGYdS
         h3NqmZpjU5QnALqDg5MtTze6kbSHfjpdPJOoCgb5bFAoIrqDNCdVNoyJYlh+Sh5CxtsI
         DfAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=53njfhXcFSFE/dk0W1eUPSZJzqE9q5J/Ul2o7oNGCzM=;
        b=pC3d7e2ubiYBLnaZS6I5iN02QsAua0SiTkNVFXy/huQhj/XAN4Zhqn5mhCwK3ZkFEp
         frYeVT7oRsRKPkF8yRHXGB5nQkgzYaeAuOdvE19vtPRb71boGF94wE02lqFCz17Kh3pW
         /yLT46SV0vVH9tlImfP5zA95GpoXrEogrLBCT7a+1ux+K+uAZr8xAM/JmrW+olyZKEWs
         aCyNFYEfEsP2qNlIEpIFv3vGBJmTvm49iWD3PKEY32w1HVR2EmV06e4u9Iis+i7obw4V
         lLawInedZ/IrdGpP4YUtj79xzi/YOUxijs8iByIPgX8QQLLmg2k6y7myGOpNnwhdewJ/
         N4kg==
X-Gm-Message-State: ANoB5plfkgq0sf/Ruem86sn2Dx/nFCX/q5zqkVuPp6uJSybTqFZytDMJ
        wek119stKWTvXMLgZIPs6de2gqhOpALePA==
X-Google-Smtp-Source: AA0mqf6ZLfsMVk8eg2IXWP/qyVu0SW27GqWL5nCDgQrkVScYIey2DksaZ7dLwrjsM9u0l66EbEWC0g==
X-Received: by 2002:a62:3084:0:b0:56d:dd2a:c494 with SMTP id w126-20020a623084000000b0056ddd2ac494mr2436276pfw.76.1668684641468;
        Thu, 17 Nov 2022 03:30:41 -0800 (PST)
Received: from localhost.localdomain ([47.246.101.60])
        by smtp.gmail.com with ESMTPSA id f7-20020a170902684700b00186c5e8b1d0sm1056117pln.149.2022.11.17.03.30.39
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Nov 2022 03:30:41 -0800 (PST)
From:   Teng Long <dyroneteng@gmail.com>
X-Google-Original-From: Teng Long <tenglong.tl@alibaba-inc.com>
To:     git@vger.kernel.org
Cc:     avarab@gmail.com, tenglong.tl@alibaba-inc.com, me@ttaylorr.com,
        Teng Long <dyroneteng@gmail.com>
Subject: [RFC PATCH 4/6] ls-tree: improving cohension in the print code
Date:   Thu, 17 Nov 2022 19:30:21 +0800
Message-Id: <20221117113023.65865-5-tenglong.tl@alibaba-inc.com>
X-Mailer: git-send-email 2.38.1.426.g770fc8806cb.dirty
In-Reply-To: <20221117113023.65865-1-tenglong.tl@alibaba-inc.com>
References: <20221117113023.65865-1-tenglong.tl@alibaba-inc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Teng Long <dyroneteng@gmail.com>

We use 'show_tree_long()' and 'show_tree_default()' to print entries
when we want the output in 'default' or 'default long' formats.

Function 'show_tree_common_default_long()' prints the "path" field as
the last part of output, the previous part which separately implements
in 'show_tree_long()' and 'show_tree_default()'.

We can package the separate implementation together by the extension of
"size_text" in struct "show_tree_data". By improving the cohesion in
these two locations, some benefits such as uniform processing of the
output can be achieved in future.

Signed-off-by: Teng Long <dyroneteng@gmail.com>
---
 builtin/ls-tree.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/builtin/ls-tree.c b/builtin/ls-tree.c
index afb65af4280..7661170f7ca 100644
--- a/builtin/ls-tree.c
+++ b/builtin/ls-tree.c
@@ -30,6 +30,7 @@ struct show_tree_data {
 	const struct object_id *oid;
 	const char *pathname;
 	struct strbuf *base;
+	char *size_text;
 };
 
 static const char * const ls_tree_usage[] = {
@@ -186,6 +187,7 @@ static int show_tree_common(struct show_tree_data *data, int *recurse,
 	data->oid = oid;
 	data->pathname = pathname;
 	data->base = base;
+	data->size_text = NULL;
 
 	if (type == OBJ_BLOB) {
 		if (ls_options & LS_TREE_ONLY)
@@ -204,6 +206,13 @@ static void show_tree_common_default_long(struct show_tree_data *data)
 {
 	int base_len = data->base->len;
 
+	if (data->size_text)
+		printf("%06o %s %s %7s\t", data->mode, type_name(data->type),
+		       find_unique_abbrev(data->oid, abbrev), data->size_text);
+	else
+		printf("%06o %s %s\t", data->mode, type_name(data->type),
+		       find_unique_abbrev(data->oid, abbrev));
+
 	strbuf_addstr(data->base, data->pathname);
 	write_name_quoted_relative(data->base->buf,
 				   chomp_prefix ? ls_tree_prefix : NULL, stdout,
@@ -223,8 +232,6 @@ static int show_tree_default(const struct object_id *oid, struct strbuf *base,
 	if (early >= 0)
 		return early;
 
-	printf("%06o %s %s\t", data.mode, type_name(data.type),
-	       find_unique_abbrev(data.oid, abbrev));
 	show_tree_common_default_long(&data);
 	return recurse;
 }
@@ -253,8 +260,7 @@ static int show_tree_long(const struct object_id *oid, struct strbuf *base,
 		xsnprintf(size_text, sizeof(size_text), "-");
 	}
 
-	printf("%06o %s %s %7s\t", data.mode, type_name(data.type),
-	       find_unique_abbrev(data.oid, abbrev), size_text);
+	data.size_text = size_text;
 	show_tree_common_default_long(&data);
 	return recurse;
 }
-- 
2.38.1.426.g770fc8806cb.dirty

