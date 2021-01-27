Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EBAAC433DB
	for <git@archiver.kernel.org>; Wed, 27 Jan 2021 15:36:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ACA49207D0
	for <git@archiver.kernel.org>; Wed, 27 Jan 2021 15:36:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236320AbhA0Pfc (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Jan 2021 10:35:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235653AbhA0PEJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Jan 2021 10:04:09 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDF3DC06178A
        for <git@vger.kernel.org>; Wed, 27 Jan 2021 07:02:16 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id o10so3473987wmc.1
        for <git@vger.kernel.org>; Wed, 27 Jan 2021 07:02:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=TTTz9vK+8k9uuGRSm5TuJOz4k7rXG4BQKle14Lbv6Qg=;
        b=sq/QiY6u3CAIjFlbd4aKNOIvAMLFhknCUEp2CljjhgSVY6MGxWsZUskfsQNSc4zN1y
         N1R+impTuylKbWnREXT+6BPiBWaxlBwU8dbg7JhSg8uycaU6iLQ1T0pmUmndw4CgSZp+
         4VEQoORq75Wlg7dRlFHk8gqxY8CZYgdTu/V/voemIeeefd8Uxk4SnPIqK8uxjYLinQ83
         5QA+a3jL1H9bjX1JykIo9IzML6cIm6l2ihoEzNaa+BkxZJDhtJqlx5xaHkCKL7lCNbDH
         dcfi+mc0Wj680Z7ip5VeKR02NnbXerM6ytH09QoDKBqy3aU2DY1DHQKgIcBmU4ORzlge
         Z4SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=TTTz9vK+8k9uuGRSm5TuJOz4k7rXG4BQKle14Lbv6Qg=;
        b=S3gvVLeaKyaAj9sxL1i3YGRreosq9q7jRM+uisrTCP/zWAr//PzVfoWXTdZ5SZR0ed
         3G5wStoNBEIjzMX1hRYqjkFeDIIQKXiiAv4Cm2yynrSm5gjjqs+ApQw4JpYi3l9eKKrA
         gGgB/9yHhbNolDQeiAfsyx4AtoaLjkmLTIYiMzkIYzYiVuB5/60cxk/vcebmkXqqzZ9W
         T1RQ74kE7QeLIuEidJQVBJwrMpg/3cdqIHKfNwmP4G0/WnkmztY7kqHsJdlsVqJqfJG2
         +6l0vq8dUMlrYyQ5IynPCUiuiTTrrCFhGfkH2VOn0IOYhH+GK9UJL1tHWPfMwRMJ7BVw
         wjbg==
X-Gm-Message-State: AOAM532TdHd3GNA/2w5+JXYW4uAqTpw8jjL1laNhowojKYDGjhBWwCfn
        hRmEyeN4RDmKLkNs+D8y2SN/xX+Msh0=
X-Google-Smtp-Source: ABdhPJyzK+lvvoMH3vxvBdsrQZSX3hW0/TwdqDbdLwJPVwT0baLnh6GtlXbNX6JAhroC9oK6rUmgUQ==
X-Received: by 2002:a7b:c45a:: with SMTP id l26mr4577756wmi.164.1611759735291;
        Wed, 27 Jan 2021 07:02:15 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i8sm3330564wry.90.2021.01.27.07.02.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jan 2021 07:02:14 -0800 (PST)
Message-Id: <669eeec707ab92a3e5983ad12baddc2c15012d43.1611759716.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.848.v2.git.1611759716.gitgitgadget@gmail.com>
References: <pull.848.git.1611676886.gitgitgadget@gmail.com>
        <pull.848.v2.git.1611759716.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 27 Jan 2021 15:01:55 +0000
Subject: [PATCH v2 16/17] chunk-format: restore duplicate chunk checks
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     me@ttaylorr.com, gitster@pobox.com, l.s.r@web.de,
        szeder.dev@gmail.com, Chris Torek <chris.torek@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

Before refactoring into the chunk-format API, the commit-graph parsing
logic included checks for duplicate chunks. It is unlikely that we would
desire a chunk-based file format that allows duplicate chunk IDs in the
table of contents, so add duplicate checks into
read_table_of_contents().

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 chunk-format.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/chunk-format.c b/chunk-format.c
index 74501084cf8..1ee875df423 100644
--- a/chunk-format.c
+++ b/chunk-format.c
@@ -14,6 +14,7 @@ struct chunk_info {
 	chunk_write_fn write_fn;
 
 	const void *start;
+	unsigned found:1;
 };
 
 struct chunkfile {
@@ -98,6 +99,7 @@ int read_table_of_contents(struct chunkfile *cf,
 			   uint64_t toc_offset,
 			   int toc_length)
 {
+	int i;
 	uint32_t chunk_id;
 	const unsigned char *table_of_contents = mfile + toc_offset;
 
@@ -124,6 +126,14 @@ int read_table_of_contents(struct chunkfile *cf,
 			return -1;
 		}
 
+		for (i = 0; i < cf->chunks_nr; i++) {
+			if (cf->chunks[i].id == chunk_id) {
+				error(_("duplicate chunk ID %"PRIx32" found"),
+					chunk_id);
+				return -1;
+			}
+		}
+
 		cf->chunks[cf->chunks_nr].id = chunk_id;
 		cf->chunks[cf->chunks_nr].start = mfile + chunk_offset;
 		cf->chunks[cf->chunks_nr].size = next_chunk_offset - chunk_offset;
-- 
gitgitgadget

