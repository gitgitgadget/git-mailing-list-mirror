Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A05CC48BD1
	for <git@archiver.kernel.org>; Thu, 10 Jun 2021 16:48:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6FED2613E9
	for <git@archiver.kernel.org>; Thu, 10 Jun 2021 16:48:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231344AbhFJQus (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Jun 2021 12:50:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231153AbhFJQur (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Jun 2021 12:50:47 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85571C061574
        for <git@vger.kernel.org>; Thu, 10 Jun 2021 09:48:38 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id r9so3071537wrz.10
        for <git@vger.kernel.org>; Thu, 10 Jun 2021 09:48:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=0C61dNR6ircxPdXSiPMiObTCeF4BY3Ug/buQdhFJhVg=;
        b=DrrXdO8KSsU9An/vwL+TXDk+2CbyYebA6R+Y1P+M0Igqq8+YnM+Vmto6MvI8DPYu+z
         5RjN0lEpGc6cb3g2s3kJrQMgJkvBYOheOJpqYNWZIWbyQyI1DRyGclJhqJHz3/M1Y6F9
         hKAZjfDhyhB9Lq2+upl/FF22JhEQhM2rUPqUzBXT0QxfZPMDxFcxmHYhc6wM6xSaOHMb
         4BTntMkahCZxm3lph20WHq3uuZ8frZXPFtm/7W1tSkpvpBSJqfKIm373992CpaKca+TX
         j0aX8/uXqVu/oyzLJoTdgqcBb4j3hRTRyTdBgyN0zi9GhSN2fZVK2ddzSnmS/PaUrXU1
         L/5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=0C61dNR6ircxPdXSiPMiObTCeF4BY3Ug/buQdhFJhVg=;
        b=G+GxIIid6Uh5tt/qQXOjz4eJmDSVEvJuHQntWfiZwBEsNDrSqUkzxvz/U2NjP5cy7n
         RlbKyCz5P5SSNOfqbtrCPlIGBpelxTK7HWx3aUK15VGM4hibsJ5p2E3H4WklWeFuAXS1
         NKO/cXmKMPsEgKIALOJt3tB9fJEwiAPOW6H7jjjAksGVo2cgoucqcZ8WP742bUZy+5gA
         111hOhbkDbMgY3BJmoSDC6smt2Df8kG5ZEeojiMGsBiumKgH+5abdMBpKKdem9wSI+EJ
         ar38x98qh97EU4gHnt9wv6s6m6fOUHdqOBw8xMlkNJlVnP8bRGlPi1DQoGlOyz3YkROy
         HO4Q==
X-Gm-Message-State: AOAM532oGNwv1YSNXopAvHoQ/r+RBALE/ST7YwgXamPhyjJmpWH/hRJy
        oWg+YtcKYmPOcWJWcCcUM/sJWusRbuE=
X-Google-Smtp-Source: ABdhPJyJDgRfwRxR8wfDhV5BjnaTiHlJdwim+XySlVED4ZhBd0y3YaLhFd0ryJtt9t5ZN4aBMEx4Ig==
X-Received: by 2002:a5d:444e:: with SMTP id x14mr6788145wrr.200.1623343715853;
        Thu, 10 Jun 2021 09:48:35 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m23sm11881795wml.27.2021.06.10.09.48.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jun 2021 09:48:35 -0700 (PDT)
Message-Id: <cd1e1f6985c77d21ec869e53dc5eb79673caf491.1623343713.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1033.git.git.1623343712.gitgitgadget@gmail.com>
References: <pull.1033.git.git.1623343712.gitgitgadget@gmail.com>
From:   "Andrzej Hunt via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 10 Jun 2021 16:48:32 +0000
Subject: [PATCH 3/3] builtin/checkout--worker: memset struct to avoid MSAN
 complaints
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Andrzej Hunt <andrzej@ahunt.org>, Andrzej Hunt <ajrhunt@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Andrzej Hunt <ajrhunt@google.com>

report_result() sends a struct to the parent process, but that struct
contains unintialised padding bytes. Running this code under MSAN
rightly triggers a warning - but we also don't care about this warning
because we control the receiving code, and we therefore know that those
padding bytes won't be read on the receiving end. Therefore we add a
memset to convince MSAN that this memory is safe to read - but only
when building with MSAN to avoid this cost in normal usage.

Interestingly, in the error-case branch, we only try to copy the first
two members of pc_item_result, by copying only PC_ITEM_RESULT_BASE_SIZE
bytes. However PC_ITEM_RESULT_BASE_SIZE is defined as
'offsetof(the_last_member)', which means that we're copying padding bytes
after the end of the second last member. We could avoid doing this by
redefining PC_ITEM_RESULT_BASE_SIZE as
'offsetof(second_last_member) + sizeof(second_last_member)', but there's
no huge benefit to doing so (and our memset hack silences the MSAN
warning in this scenario either way).

MSAN output from t2080 (partially interleaved due to the
parallel work :) ):

Uninitialized bytes in __interceptor_write at offset 12 inside [0x7fff37d83408, 160)
==23279==WARNING: MemorySanitizer: use-of-uninitialized-value
Uninitialized bytes in __interceptor_write at offset 12 inside [0x7ffdb8a07ec8, 160)
==23280==WARNING: MemorySanitizer: use-of-uninitialized-value
    #0 0xd5ac28 in xwrite /home/ahunt/git/git/wrapper.c:256:8
    #1 0xd5b327 in write_in_full /home/ahunt/git/git/wrapper.c:311:21
    #2 0xb0a8c4 in do_packet_write /home/ahunt/git/git/pkt-line.c:221:6
    #3 0xb0a5fd in packet_write /home/ahunt/git/git/pkt-line.c:242:6
    #4 0x4f7441 in report_result /home/ahunt/git/git/builtin/checkout--worker.c:69:2
    #5 0x4f6be6 in worker_loop /home/ahunt/git/git/builtin/checkout--worker.c:100:3
    #6 0x4f68d3 in cmd_checkout__worker /home/ahunt/git/git/builtin/checkout--worker.c:143:2
    #7 0x4a1e76 in run_builtin /home/ahunt/git/git/git.c:461:11
    #8 0x49e1e7 in handle_builtin /home/ahunt/git/git/git.c:714:3
    #9 0x4a0c08 in run_argv /home/ahunt/git/git/git.c:781:4
    #10 0x49d5a8 in cmd_main /home/ahunt/git/git/git.c:912:19
    #11 0x7974da in main /home/ahunt/git/git/common-main.c:52:11
    #12 0x7f8778114349 in __libc_start_main (/lib64/libc.so.6+0x24349)
    #13 0x421bd9 in _start /home/abuild/rpmbuild/BUILD/glibc-2.26/csu/../sysdeps/x86_64/start.S:120

  Uninitialized value was created by an allocation of 'res' in the stack frame of function 'report_result'
    #0 0x4f72c0 in report_result /home/ahunt/git/git/builtin/checkout--worker.c:55

SUMMARY: MemorySanitizer: use-of-uninitialized-value /home/ahunt/git/git/wrapper.c:256:8 in xwrite
Exiting
    #0 0xd5ac28 in xwrite /home/ahunt/git/git/wrapper.c:256:8
    #1 0xd5b327 in write_in_full /home/ahunt/git/git/wrapper.c:311:21
    #2 0xb0a8c4 in do_packet_write /home/ahunt/git/git/pkt-line.c:221:6
    #3 0xb0a5fd in packet_write /home/ahunt/git/git/pkt-line.c:242:6
    #4 0x4f7441 in report_result /home/ahunt/git/git/builtin/checkout--worker.c:69:2
    #5 0x4f6be6 in worker_loop /home/ahunt/git/git/builtin/checkout--worker.c:100:3
    #6 0x4f68d3 in cmd_checkout__worker /home/ahunt/git/git/builtin/checkout--worker.c:143:2
    #7 0x4a1e76 in run_builtin /home/ahunt/git/git/git.c:461:11
    #8 0x49e1e7 in handle_builtin /home/ahunt/git/git/git.c:714:3
    #9 0x4a0c08 in run_argv /home/ahunt/git/git/git.c:781:4
    #10 0x49d5a8 in cmd_main /home/ahunt/git/git/git.c:912:19
    #11 0x7974da in main /home/ahunt/git/git/common-main.c:52:11
    #12 0x7f2749a0e349 in __libc_start_main (/lib64/libc.so.6+0x24349)
    #13 0x421bd9 in _start /home/abuild/rpmbuild/BUILD/glibc-2.26/csu/../sysdeps/x86_64/start.S:120

  Uninitialized value was created by an allocation of 'res' in the stack frame of function 'report_result'
    #0 0x4f72c0 in report_result /home/ahunt/git/git/builtin/checkout--worker.c:55

SUMMARY: MemorySanitizer: use-of-uninitialized-value /home/ahunt/git/git/wrapper.c:256:8 in xwrite

Signed-off-by: Andrzej Hunt <andrzej@ahunt.org>
---
 builtin/checkout--worker.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/builtin/checkout--worker.c b/builtin/checkout--worker.c
index 289a9b8f89d0..02fa5285988f 100644
--- a/builtin/checkout--worker.c
+++ b/builtin/checkout--worker.c
@@ -56,6 +56,17 @@ static void report_result(struct parallel_checkout_item *pc_item)
 	struct pc_item_result res;
 	size_t size;
 
+#if defined(__has_feature)
+#  if __has_feature(memory_sanitizer)
+	// MSAN workaround: res contains padding bytes, which will remain
+	// permanently unintialised. Later, we read all of res in order to send
+	// it to the parent process - and MSAN (rightly) complains that we're
+	// reading those unintialised padding bytes. By memset'ing res we
+	// guarantee that there are no uninitialised bytes.
+	memset(&res, 0, sizeof(res));
+#endif
+#endif
+
 	res.id = pc_item->id;
 	res.status = pc_item->status;
 
-- 
gitgitgadget
