Return-Path: <SRS0=Fs4s=6X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E036C47255
	for <git@archiver.kernel.org>; Sat,  9 May 2020 14:24:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D35421473
	for <git@archiver.kernel.org>; Sat,  9 May 2020 14:24:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sP9WKgqF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727940AbgEIOYe (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 9 May 2020 10:24:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727105AbgEIOYe (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 9 May 2020 10:24:34 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0253C061A0C
        for <git@vger.kernel.org>; Sat,  9 May 2020 07:24:33 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id h9so5301883wrt.0
        for <git@vger.kernel.org>; Sat, 09 May 2020 07:24:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=8jqajaVbYmMc5dDrPV/EI7TP138TInsTgrbGF0yCCFc=;
        b=sP9WKgqFeL0ex5NYX2xTBnn8p6y+ZcoGgx7Gq8jN+M5vPesHQruLN5a3C8FkIzOnE5
         vdeLtV0sp39p8xU7N00pgxC69gvGGI+f4Ue7dtlRFUso/PtlPJ3bDEwttB9nS6r/j/zq
         fAiO1GlgZl1tdG4bNwPGpD5ZQBjVoXuDizDdYJHhcQtUYl/WyHTd8q2UPzx/edm3XAn8
         hkNjFrXZGKiEwX1oN3RhStNK2lJ51hbpODYfMf6XFDngpAtJte4pCeAMnb+INQcMwNQr
         vRwe2jY1wdgZOLqttqMIykTtBZIJrLnh4c7xPjaqtLqlCqZ5bFmS8AUAc2hJ0zU3wa+C
         Kw4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=8jqajaVbYmMc5dDrPV/EI7TP138TInsTgrbGF0yCCFc=;
        b=oNiP5IUSAsYq28FCj7lN/SvMnB4yKCU/lir4xYV6oLbGf1amTDML0nmivloVyzv94N
         Rrxz/Q8YWfhgCDwv2goR2GT+yFfof0zIZDtTPEE3g9B7LSSdWNDgIondJsIm1B+qRSfd
         2RZ4h5q/iSdUclLq56OYTSIL++yloxA4GN6u0ejg55D6cCw1yRJ1WNZA7j+jw1FhjQHE
         kFDVEMv2VijWIGX5kMwGy5dUHha6kgKcGcTF+fETvzu0JN359l22gs7+2D/XV05lQzl8
         dn3EQ5GiE3R7L54DghknuFCgtCi80q+soHh89Sil47W0P5h9Vay/4/jCoXxhCPyOPQXz
         +vJg==
X-Gm-Message-State: AGi0PuY9488NVlkQuMWRj4WCxKCTGiL/7CwQKux8zPTdaiv5EcBj72iD
        XarI4Zw4jfn3YZG1c7MLI1k5Vk29
X-Google-Smtp-Source: APiQypJL/BnmjbmpNyOxnhS72ejIKbUctdd40PuSGy1qGMWYk2Vm/8gfwe9CuD+rdZK7wop+1y8Eog==
X-Received: by 2002:adf:f344:: with SMTP id e4mr8714225wrp.395.1589034272189;
        Sat, 09 May 2020 07:24:32 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 77sm8639963wrc.6.2020.05.09.07.24.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 May 2020 07:24:31 -0700 (PDT)
Message-Id: <a925307d4c57506f5236e60dc1390998e186cf26.1589034270.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.626.v3.git.1589034270.gitgitgadget@gmail.com>
References: <pull.626.v2.git.1588758194.gitgitgadget@gmail.com>
        <pull.626.v3.git.1589034270.gitgitgadget@gmail.com>
From:   "Son Luong Ngoc via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 09 May 2020 14:24:28 +0000
Subject: [PATCH v3 1/3] midx: teach "git multi-pack-index repack" honor "git
 repack" configurations
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Son Luong Ngoc <sluongng@gmail.com>,
        Son Luong Ngoc <sluongng@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Son Luong Ngoc <sluongng@gmail.com>

Previously, when the "repack" subcommand of "git multi-pack-index" command
creates new packfile(s), it does not call the "git repack" command but
instead directly calls the "git pack-objects" command, and the
configuration variables meant for the "git repack" command, like
"repack.usedaeltabaseoffset", are ignored.

This patch ensured "git multi-pack-index" checks the configuration
variables used by "git repack" and passes the corresponding options to
the underlying "git pack-objects" command.

Note that `repack.writeBitmaps` configuration is ignored, as the
pack bitmap facility is useful only with a single packfile.

Signed-off-by: Son Luong Ngoc <sluongng@gmail.com>
---
 midx.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/midx.c b/midx.c
index 9a61d3b37d9..1e76be56826 100644
--- a/midx.c
+++ b/midx.c
@@ -1369,6 +1369,8 @@ int midx_repack(struct repository *r, const char *object_dir, size_t batch_size,
 	struct child_process cmd = CHILD_PROCESS_INIT;
 	struct strbuf base_name = STRBUF_INIT;
 	struct multi_pack_index *m = load_multi_pack_index(object_dir, 1);
+	int delta_base_offset = 1;
+	int use_delta_islands = 0;
 
 	if (!m)
 		return 0;
@@ -1381,12 +1383,20 @@ int midx_repack(struct repository *r, const char *object_dir, size_t batch_size,
 	} else if (fill_included_packs_all(m, include_pack))
 		goto cleanup;
 
+	repo_config_get_bool(r, "repack.usedeltabaseoffset", &delta_base_offset);
+	repo_config_get_bool(r, "repack.usedeltaislands", &use_delta_islands);
+
 	argv_array_push(&cmd.args, "pack-objects");
 
 	strbuf_addstr(&base_name, object_dir);
 	strbuf_addstr(&base_name, "/pack/pack");
 	argv_array_push(&cmd.args, base_name.buf);
 
+	if (delta_base_offset)
+		argv_array_push(&cmd.args, "--delta-base-offset");
+	if (use_delta_islands)
+		argv_array_push(&cmd.args, "--delta-islands");
+
 	if (flags & MIDX_PROGRESS)
 		argv_array_push(&cmd.args, "--progress");
 	else
-- 
gitgitgadget

