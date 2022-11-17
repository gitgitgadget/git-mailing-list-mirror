Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4438CC4332F
	for <git@archiver.kernel.org>; Thu, 17 Nov 2022 13:48:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239336AbiKQNsb (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Nov 2022 08:48:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234267AbiKQNs1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Nov 2022 08:48:27 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E4371170
        for <git@vger.kernel.org>; Thu, 17 Nov 2022 05:48:26 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id gv23so5208811ejb.3
        for <git@vger.kernel.org>; Thu, 17 Nov 2022 05:48:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GBoVgeRvMP2Jx+grqy8u/c1+w3b651JLVP4QJ8dbVg8=;
        b=QmyQ0+KxG9m/gmiktfJDNpYYt6qr+Mt/btWa2a68cIyyak25O6Sk1LY0YzrJzPPyGa
         zJoXUtrvNsXI86vf300r6Q8dOPUPQ5AeIvyEf8brPGgoO4s+M2eJXUo/dVL5CDAJy542
         ofJeUs1oWvUsvxiuRdIwZhzWyMl/ZwWgjm2H5zW3306xXg3FI0fSXJhKAuThVZtSohnt
         J8uZQzAmzWTGVJOtUxfC51WvlhMdqxSle7Rfhiph7TQ8ufivSQ6cN5HlTRJ7cg44RsH7
         OBpW+OAr2lLnY/ju5UJw5nlc8XcDE3PHzY+5K5cIEu7PWonYIY4BCvqVeS77jkfS9Bgs
         orlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GBoVgeRvMP2Jx+grqy8u/c1+w3b651JLVP4QJ8dbVg8=;
        b=24ShsKegwWpoPtHVtJ+9l1IvXDE4VDT5vq+PFMVfXIKwWIpnWqs9xos0pTMiHr/f2l
         NqzUgDksORio5LvW0zkPtWed+gQCdDD+QImd8MudgrzeAnt6xuv5jRTCLMjgrFllAeKI
         HmIgj1lKd/n4BT8MheCvxoWqmDa9j0CWsdFhgPftYoNL5iV9Qj3YY3CJCIk4fQGIY7pX
         xRz9GjB5HJruQj11NHDScoyzw+omY/pLcDwPI/uJsNk2qY1xlynVW2mz8H3TYueSnRf5
         tdj3DlS11UFPuopNVPGqDzVa7ob2lC7jsT5KzdE+MuHWJnKR1K16DuFQTZu9Bz9HFjx4
         jmeg==
X-Gm-Message-State: ANoB5pnMX2/82qN1s5KkGfmpZ61ZCO5uhF90vqaeGU1cTDLZxFa33T5C
        hI7wEGX1uprSexVeWsQpvfC9B1qMWY575w==
X-Google-Smtp-Source: AA0mqf54ZMfqzrl64K45jRCD9Pyp7pUq9ml/SH9JtYyvKGfENP9Sbf5bw3xGdME4kWPh8HyyxBeFLA==
X-Received: by 2002:a17:906:ef1:b0:78d:260d:a6e4 with SMTP id x17-20020a1709060ef100b0078d260da6e4mr2155305eji.93.1668692904306;
        Thu, 17 Nov 2022 05:48:24 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id m27-20020a170906581b00b007ad9adabcd4sm379257ejq.213.2022.11.17.05.48.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 05:48:23 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>, Teng Long <dyroneteng@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [RFC PATCH 3/4] ls-tree: fold "show_tree_data" into "cb" struct
Date:   Thu, 17 Nov 2022 14:48:16 +0100
Message-Id: <RFC-patch-3.4-28c07464b03-20221117T134528Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1473.g172bcc0511c
In-Reply-To: <RFC-cover-0.4-00000000000-20221117T134528Z-avarab@gmail.com>
References: <20221117113023.65865-1-tenglong.tl@alibaba-inc.com> <RFC-cover-0.4-00000000000-20221117T134528Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

After the the preceding two commits the only user of the
"show_tree_data" struct needed it along with the "options" member,
let's instead fold all of that into a "show_tree_data" struct that
we'll use only for that callback.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/ls-tree.c | 18 +++++-------------
 1 file changed, 5 insertions(+), 13 deletions(-)

diff --git a/builtin/ls-tree.c b/builtin/ls-tree.c
index 54f7b604cb7..da664eecfb9 100644
--- a/builtin/ls-tree.c
+++ b/builtin/ls-tree.c
@@ -53,6 +53,7 @@ struct ls_tree_options {
 };
 
 struct show_tree_data {
+	struct ls_tree_options *options;
 	unsigned mode;
 	enum object_type type;
 	const struct object_id *oid;
@@ -60,17 +61,11 @@ struct show_tree_data {
 	struct strbuf *base;
 };
 
-struct show_tree_data_cb {
-	struct ls_tree_options *options;
-	struct show_tree_data *data;
-};
-
 static size_t expand_show_tree(struct strbuf *sb, const char *start,
 			       void *context)
 {
-	struct show_tree_data_cb *wrapper = context;
-	struct ls_tree_options *options = wrapper->options;
-	struct show_tree_data *data = wrapper->data;
+	struct show_tree_data *data = context;
+	struct ls_tree_options *options = data->options;
 	const char *end;
 	const char *p;
 	unsigned int errlen;
@@ -153,17 +148,14 @@ static int show_tree_fmt(const struct object_id *oid, struct strbuf *base,
 	int recurse = 0;
 	struct strbuf sb = STRBUF_INIT;
 	enum object_type type = object_type(mode);
-	struct show_tree_data data = {
+	struct show_tree_data cb_data = {
+		.options = options,
 		.mode = mode,
 		.type = type,
 		.oid = oid,
 		.pathname = pathname,
 		.base = base,
 	};
-	struct show_tree_data_cb cb_data = {
-		.data = &data,
-		.options = options,
-	};
 
 	if (type == OBJ_TREE && show_recursive(options, base->buf, base->len, pathname))
 		recurse = READ_TREE_RECURSIVE;
-- 
2.38.0.1473.g172bcc0511c

