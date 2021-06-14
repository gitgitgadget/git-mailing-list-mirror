Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F9DCC2B9F4
	for <git@archiver.kernel.org>; Mon, 14 Jun 2021 15:51:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3AD4761352
	for <git@archiver.kernel.org>; Mon, 14 Jun 2021 15:51:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233671AbhFNPxY (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Jun 2021 11:53:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233035AbhFNPxX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Jun 2021 11:53:23 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 213C6C061574
        for <git@vger.kernel.org>; Mon, 14 Jun 2021 08:51:20 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id c5so15061773wrq.9
        for <git@vger.kernel.org>; Mon, 14 Jun 2021 08:51:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=1p2WaOD2ZwdKN14UkGwljtf/BsFG3qoPm4eI4vsEllA=;
        b=mWi4j73X/gkDpHQzwP+QuV3cVBD8MDgyjo/BGEBCH6cIj7wN5L9WCwnEPwHbOLPc7H
         CRxLPsHmjYel2voDl2c9xIH9P4O/9dR6L25kdjJAi4DVdn8UOdDfEwAYrgTDlTS01ZbT
         NYl2t2UPKcxPA5B3wRMt8YzjNRpbRqb1oug7mXb2pMkM9OkgswpSd5f+mXEZ6u8U++Ve
         ZS2idy/jzu7xtT4xyhwwWkbF85mtS1sy84UuwxFAHVnvM90LWLKVzrs0osRoq0rqUtvj
         3EG4FNnujtKdbcaZP/W8J8R/lQs8vgUeHWsc2mP3L0Osrbq+EAM1q9iliUijbPhpg6+O
         yP2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=1p2WaOD2ZwdKN14UkGwljtf/BsFG3qoPm4eI4vsEllA=;
        b=LVEXxf5Qn+F3ZUNf8BzukkVx11BE62HCcndvieIesCFrDDnqxnvgLsbJOaxQSoyjZp
         xVUTMQbU02SD5ZNBDnwl67aAAf6/9FRVLMjTP0dNIEbwnOFkJr3p275NuVzevawE5ypR
         IZih6YuE5J2WBlV0wSrz+a21TJZWyDHKkG90wvWh+0B8Fno26VE/hm2MKnD783FY8GWL
         aSBLWdGrJUe2w/PAcEH0HpKA3Z6U9s6CfazWL8+ONkpelu/9BmKryJpsfJAOjn7mQAoC
         IaH0gTE+8OPGRfUUDz+k2fWVw6A3Bj0YHjpJX8KjPwhDbkIhF02zVSmaXMFLixtEAL3z
         gQSQ==
X-Gm-Message-State: AOAM530TdSbMnur7LQl2XaKglQtFsJUhXgsrU5KEW3Yn0GlztMJ9gwYm
        KA8hYHCRmogJ4nFWeDhvShlnMx6IlSo=
X-Google-Smtp-Source: ABdhPJzI1kbxBY4bQSyBpCjPADbw4BJVwMcUs1YuLPeslwlUT+D0am0hTGUYET5N04MJLj1tXQ2LCg==
X-Received: by 2002:a5d:4f08:: with SMTP id c8mr19527783wru.197.1623685878790;
        Mon, 14 Jun 2021 08:51:18 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p12sm18702756wme.43.2021.06.14.08.51.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jun 2021 08:51:18 -0700 (PDT)
Message-Id: <7659d4bf13c27ed0b1b793a19959b469063b85ec.1623685877.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1033.v2.git.git.1623685877.gitgitgadget@gmail.com>
References: <pull.1033.git.git.1623343712.gitgitgadget@gmail.com>
        <pull.1033.v2.git.git.1623685877.gitgitgadget@gmail.com>
From:   "Andrzej Hunt via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 14 Jun 2021 15:51:14 +0000
Subject: [PATCH v2 1/3] bulk-checkin: make buffer reuse more obvious and safer
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Chris Torek <chris.torek@gmail.com>, Jeff King <peff@peff.net>,
        Andrzej Hunt <andrzej@ahunt.org>,
        Andrzej Hunt <ajrhunt@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Andrzej Hunt <ajrhunt@google.com>

ibuf can be reused for multiple iterations of the loop. Specifically:
deflate() overwrites s.avail_in to show how much of the input buffer
has not been processed yet - and sometimes leaves 'avail_in > 0', in
which case ibuf will be processed again during the loop's subsequent
iteration.

But if we declare ibuf within the loop, then (in theory) we get a new
(and uninitialised) buffer for every iteration. In practice, my compiler
seems to resue the same buffer - meaning that this code does work - but
it doesn't seem safe to rely on this behaviour. MSAN correctly catches
this issue - as soon as we hit the 's.avail_in > 0' condition, we end up
reading from what seems to be uninitialised memory.

Therefore, we move ibuf out of the loop, making this reuse safe.

See MSAN output from t1050-large below - the interesting part is the
ibuf creation at the end, although there's a lot of indirection before
we reach the read from unitialised memory:

==11294==WARNING: MemorySanitizer: use-of-uninitialized-value
    #0 0x7f75db58fb1c in crc32_little crc32.c:283:9
    #1 0x7f75db58d5b3 in crc32_z crc32.c:220:20
    #2 0x7f75db59668c in crc32 crc32.c:242:12
    #3 0x8c94f8 in hashwrite csum-file.c:101:15
    #4 0x825faf in stream_to_pack bulk-checkin.c:154:5
    #5 0x82467b in deflate_to_pack bulk-checkin.c:225:8
    #6 0x823ff1 in index_bulk_checkin bulk-checkin.c:264:15
    #7 0xa7cff2 in index_stream object-file.c:2234:9
    #8 0xa7bff7 in index_fd object-file.c:2256:9
    #9 0xa7d22d in index_path object-file.c:2274:7
    #10 0xb3c8c9 in add_to_index read-cache.c:802:7
    #11 0xb3e039 in add_file_to_index read-cache.c:835:9
    #12 0x4a99c3 in add_files add.c:458:7
    #13 0x4a7276 in cmd_add add.c:670:18
    #14 0x4a1e76 in run_builtin git.c:461:11
    #15 0x49e1e7 in handle_builtin git.c:714:3
    #16 0x4a0c08 in run_argv git.c:781:4
    #17 0x49d5a8 in cmd_main git.c:912:19
    #18 0x7974da in main common-main.c:52:11
    #19 0x7f75da66f349 in __libc_start_main (/lib64/libc.so.6+0x24349)
    #20 0x421bd9 in _start start.S:120

  Uninitialized value was stored to memory at
    #0 0x7f75db58fa6b in crc32_little crc32.c:283:9
    #1 0x7f75db58d5b3 in crc32_z crc32.c:220:20
    #2 0x7f75db59668c in crc32 crc32.c:242:12
    #3 0x8c94f8 in hashwrite csum-file.c:101:15
    #4 0x825faf in stream_to_pack bulk-checkin.c:154:5
    #5 0x82467b in deflate_to_pack bulk-checkin.c:225:8
    #6 0x823ff1 in index_bulk_checkin bulk-checkin.c:264:15
    #7 0xa7cff2 in index_stream object-file.c:2234:9
    #8 0xa7bff7 in index_fd object-file.c:2256:9
    #9 0xa7d22d in index_path object-file.c:2274:7
    #10 0xb3c8c9 in add_to_index read-cache.c:802:7
    #11 0xb3e039 in add_file_to_index read-cache.c:835:9
    #12 0x4a99c3 in add_files add.c:458:7
    #13 0x4a7276 in cmd_add add.c:670:18
    #14 0x4a1e76 in run_builtin git.c:461:11
    #15 0x49e1e7 in handle_builtin git.c:714:3
    #16 0x4a0c08 in run_argv git.c:781:4
    #17 0x49d5a8 in cmd_main git.c:912:19
    #18 0x7974da in main common-main.c:52:11
    #19 0x7f75da66f349 in __libc_start_main (/lib64/libc.so.6+0x24349)

  Uninitialized value was stored to memory at
    #0 0x447eb9 in __msan_memcpy msan_interceptors.cpp:1558:3
    #1 0x7f75db5c2011 in flush_pending deflate.c:746:5
    #2 0x7f75db5cafa0 in deflate_stored deflate.c:1815:9
    #3 0x7f75db5bb7d2 in deflate deflate.c:1005:34
    #4 0xd80b7f in git_deflate zlib.c:244:12
    #5 0x825dff in stream_to_pack bulk-checkin.c:140:12
    #6 0x82467b in deflate_to_pack bulk-checkin.c:225:8
    #7 0x823ff1 in index_bulk_checkin bulk-checkin.c:264:15
    #8 0xa7cff2 in index_stream object-file.c:2234:9
    #9 0xa7bff7 in index_fd object-file.c:2256:9
    #10 0xa7d22d in index_path object-file.c:2274:7
    #11 0xb3c8c9 in add_to_index read-cache.c:802:7
    #12 0xb3e039 in add_file_to_index read-cache.c:835:9
    #13 0x4a99c3 in add_files add.c:458:7
    #14 0x4a7276 in cmd_add add.c:670:18
    #15 0x4a1e76 in run_builtin git.c:461:11
    #16 0x49e1e7 in handle_builtin git.c:714:3
    #17 0x4a0c08 in run_argv git.c:781:4
    #18 0x49d5a8 in cmd_main git.c:912:19
    #19 0x7974da in main common-main.c:52:11

  Uninitialized value was stored to memory at
    #0 0x447eb9 in __msan_memcpy msan_interceptors.cpp:1558:3
    #1 0x7f75db644241 in _tr_stored_block trees.c:873:5
    #2 0x7f75db5cad7c in deflate_stored deflate.c:1813:9
    #3 0x7f75db5bb7d2 in deflate deflate.c:1005:34
    #4 0xd80b7f in git_deflate zlib.c:244:12
    #5 0x825dff in stream_to_pack bulk-checkin.c:140:12
    #6 0x82467b in deflate_to_pack bulk-checkin.c:225:8
    #7 0x823ff1 in index_bulk_checkin bulk-checkin.c:264:15
    #8 0xa7cff2 in index_stream object-file.c:2234:9
    #9 0xa7bff7 in index_fd object-file.c:2256:9
    #10 0xa7d22d in index_path object-file.c:2274:7
    #11 0xb3c8c9 in add_to_index read-cache.c:802:7
    #12 0xb3e039 in add_file_to_index read-cache.c:835:9
    #13 0x4a99c3 in add_files add.c:458:7
    #14 0x4a7276 in cmd_add add.c:670:18
    #15 0x4a1e76 in run_builtin git.c:461:11
    #16 0x49e1e7 in handle_builtin git.c:714:3
    #17 0x4a0c08 in run_argv git.c:781:4
    #18 0x49d5a8 in cmd_main git.c:912:19
    #19 0x7974da in main common-main.c:52:11

  Uninitialized value was stored to memory at
    #0 0x447eb9 in __msan_memcpy msan_interceptors.cpp:1558:3
    #1 0x7f75db5c8fcf in deflate_stored deflate.c:1783:9
    #2 0x7f75db5bb7d2 in deflate deflate.c:1005:34
    #3 0xd80b7f in git_deflate zlib.c:244:12
    #4 0x825dff in stream_to_pack bulk-checkin.c:140:12
    #5 0x82467b in deflate_to_pack bulk-checkin.c:225:8
    #6 0x823ff1 in index_bulk_checkin bulk-checkin.c:264:15
    #7 0xa7cff2 in index_stream object-file.c:2234:9
    #8 0xa7bff7 in index_fd object-file.c:2256:9
    #9 0xa7d22d in index_path object-file.c:2274:7
    #10 0xb3c8c9 in add_to_index read-cache.c:802:7
    #11 0xb3e039 in add_file_to_index read-cache.c:835:9
    #12 0x4a99c3 in add_files add.c:458:7
    #13 0x4a7276 in cmd_add add.c:670:18
    #14 0x4a1e76 in run_builtin git.c:461:11
    #15 0x49e1e7 in handle_builtin git.c:714:3
    #16 0x4a0c08 in run_argv git.c:781:4
    #17 0x49d5a8 in cmd_main git.c:912:19
    #18 0x7974da in main common-main.c:52:11
    #19 0x7f75da66f349 in __libc_start_main (/lib64/libc.so.6+0x24349)

  Uninitialized value was stored to memory at
    #0 0x447eb9 in __msan_memcpy msan_interceptors.cpp:1558:3
    #1 0x7f75db5ea545 in read_buf deflate.c:1181:5
    #2 0x7f75db5c97f7 in deflate_stored deflate.c:1791:9
    #3 0x7f75db5bb7d2 in deflate deflate.c:1005:34
    #4 0xd80b7f in git_deflate zlib.c:244:12
    #5 0x825dff in stream_to_pack bulk-checkin.c:140:12
    #6 0x82467b in deflate_to_pack bulk-checkin.c:225:8
    #7 0x823ff1 in index_bulk_checkin bulk-checkin.c:264:15
    #8 0xa7cff2 in index_stream object-file.c:2234:9
    #9 0xa7bff7 in index_fd object-file.c:2256:9
    #10 0xa7d22d in index_path object-file.c:2274:7
    #11 0xb3c8c9 in add_to_index read-cache.c:802:7
    #12 0xb3e039 in add_file_to_index read-cache.c:835:9
    #13 0x4a99c3 in add_files add.c:458:7
    #14 0x4a7276 in cmd_add add.c:670:18
    #15 0x4a1e76 in run_builtin git.c:461:11
    #16 0x49e1e7 in handle_builtin git.c:714:3
    #17 0x4a0c08 in run_argv git.c:781:4
    #18 0x49d5a8 in cmd_main git.c:912:19
    #19 0x7974da in main common-main.c:52:11

  Uninitialized value was created by an allocation of 'ibuf' in the stack frame of function 'stream_to_pack'
    #0 0x825710 in stream_to_pack bulk-checkin.c:101

SUMMARY: MemorySanitizer: use-of-uninitialized-value crc32.c:283:9 in crc32_little
Exiting

Signed-off-by: Andrzej Hunt <andrzej@ahunt.org>
---
 bulk-checkin.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/bulk-checkin.c b/bulk-checkin.c
index 127312acd1ed..b023d9959aae 100644
--- a/bulk-checkin.c
+++ b/bulk-checkin.c
@@ -100,6 +100,7 @@ static int stream_to_pack(struct bulk_checkin_state *state,
 			  const char *path, unsigned flags)
 {
 	git_zstream s;
+	unsigned char ibuf[16384];
 	unsigned char obuf[16384];
 	unsigned hdrlen;
 	int status = Z_OK;
@@ -113,8 +114,6 @@ static int stream_to_pack(struct bulk_checkin_state *state,
 	s.avail_out = sizeof(obuf) - hdrlen;
 
 	while (status != Z_STREAM_END) {
-		unsigned char ibuf[16384];
-
 		if (size && !s.avail_in) {
 			ssize_t rsize = size < sizeof(ibuf) ? size : sizeof(ibuf);
 			ssize_t read_result = read_in_full(fd, ibuf, rsize);
-- 
gitgitgadget

