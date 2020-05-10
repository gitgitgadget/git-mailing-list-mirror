Return-Path: <SRS0=RpNG=6Y=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAEFEC54E8A
	for <git@archiver.kernel.org>; Sun, 10 May 2020 16:07:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B15AF208DB
	for <git@archiver.kernel.org>; Sun, 10 May 2020 16:07:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GAojF/YX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729067AbgEJQHj (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 10 May 2020 12:07:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728849AbgEJQHi (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 May 2020 12:07:38 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B554C061A0C
        for <git@vger.kernel.org>; Sun, 10 May 2020 09:07:38 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id v12so7799703wrp.12
        for <git@vger.kernel.org>; Sun, 10 May 2020 09:07:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=acVe+6SyQT3x2nmkcEeZhi6wrrlWrMNm7dCAND/Vc9A=;
        b=GAojF/YXR3CO0ra6WAVGhOyINDQ/s02sxZno6GP18rbHTcypXc0Rxs1Y/jzLjaMMly
         wKfPnb8BtLA7TC2DyP9Vu31FJeMXYWJqLtGvOaOgP2HejF/GfiYsrA6fcSNRN+IpEsU+
         eKC8CHzJ74YiqNZeceWNcZIxLD1DwOX8JoftEGxEccsnXeL1X5D1CiD3WmSwItiLV+n/
         bvjJbf2a18Gz6npy5j30w+2oah5VdW4kbdjpH87CwtkGQBz30qPVd5pucG5QBFpdajo8
         tt+xh51HNzPqvAyX4ma4YGEx0duZDqdv83MNGPsfEVV8UP0kcc304gWYhloocjYt+Cp1
         1Tgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=acVe+6SyQT3x2nmkcEeZhi6wrrlWrMNm7dCAND/Vc9A=;
        b=J9QWMrM2KtJdcXBVDQZKt/ufCSVUsxnAjxVa0558af/0Gau/i/KlKZNLPyaTFCT7vS
         LE76aKQ80v9GX0EgkdWeBHpr2K1BkX/nH18sj1a8M6ioi5jezpOcSuacYuR7FMVgk7Hy
         OQnsjWTBmmx9pp3USo6yAwdlMna2i4ymXOcmrnhY52F6jMGvXJcFZrHMNvkTGTA8jRi+
         aelPmg4i1Tag2W1OUDSEbZWeUJhCqxfT0qNsNDbXL5x0p8kj2BJ47xZ/UVx/KFzPYfxw
         yfqx3YDgmcVxeiOS0JMScKjufuT/feIPiwueBPE9WB7OVcCe/NGGq/OYJVtIQFkyT36M
         DTRg==
X-Gm-Message-State: AGi0PuY9Acoik/Td/NFdSBo8FxzPdgK8owqG5dGPMqLxwAZly3Jln4aw
        Cmdzo0qqr/kzTbrqDeqI6PGctLvN
X-Google-Smtp-Source: APiQypJQvBznBuRHLp/mjuAdj+EYS7Pol38//yRdCP4LjlC9WpHszDpagIWWKmBW3rjbnOnkyiHN8A==
X-Received: by 2002:a5d:4447:: with SMTP id x7mr13975027wrr.299.1589126856928;
        Sun, 10 May 2020 09:07:36 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u16sm13542117wrq.17.2020.05.10.09.07.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 May 2020 09:07:36 -0700 (PDT)
Message-Id: <a8f75e34e5b3f3ffba9d6a3852f77d03d3352d95.1589126855.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.626.v4.git.1589126855.gitgitgadget@gmail.com>
References: <pull.626.v3.git.1589034270.gitgitgadget@gmail.com>
        <pull.626.v4.git.1589126855.gitgitgadget@gmail.com>
From:   "Son Luong Ngoc via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 10 May 2020 16:07:33 +0000
Subject: [PATCH v4 1/2] midx: teach "git multi-pack-index repack" honor "git
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

When the "repack" subcommand of "git multi-pack-index" command
creates new packfile(s), it does not call the "git repack"
command but instead directly calls the "git pack-objects"
command, and the configuration variables meant for the "git
repack" command, like "repack.usedaeltabaseoffset", are ignored.

Check the configuration variables used by "git repack" ourselves
in "git multi-index-pack" and pass the corresponding options to
underlying "git pack-objects".

Note that `repack.writeBitmaps` configuration is ignored, as the
pack bitmap facility is useful only with a single packfile.

Signed-off-by: Son Luong Ngoc <sluongng@gmail.com>
---
 midx.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/midx.c b/midx.c
index 9a61d3b37d9..d2a43bd1a38 100644
--- a/midx.c
+++ b/midx.c
@@ -1370,6 +1370,14 @@ int midx_repack(struct repository *r, const char *object_dir, size_t batch_size,
 	struct strbuf base_name = STRBUF_INIT;
 	struct multi_pack_index *m = load_multi_pack_index(object_dir, 1);
 
+	/*
+	 * When updating the default for these configuration
+	 * variables in builtin/repack.c, these must be adjusted
+	 * to match.
+	 */
+	int delta_base_offset = 1;
+	int use_delta_islands = 0;
+
 	if (!m)
 		return 0;
 
@@ -1381,12 +1389,20 @@ int midx_repack(struct repository *r, const char *object_dir, size_t batch_size,
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

