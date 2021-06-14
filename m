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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FB7EC2B9F4
	for <git@archiver.kernel.org>; Mon, 14 Jun 2021 15:51:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 14CC961378
	for <git@archiver.kernel.org>; Mon, 14 Jun 2021 15:51:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233933AbhFNPx0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Jun 2021 11:53:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233152AbhFNPxY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Jun 2021 11:53:24 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29C6CC061574
        for <git@vger.kernel.org>; Mon, 14 Jun 2021 08:51:21 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id h22-20020a05600c3516b02901a826f84095so253075wmq.5
        for <git@vger.kernel.org>; Mon, 14 Jun 2021 08:51:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=6+FQAr3QFN14/bbpW/c2KgXaNuTk9/pA79fJdM5xfAY=;
        b=aeEHJfKLYSRrlNnd+hD9gmdn9LjZxCKiZt9hyKTLq9F4VsaoQH3i+eM++prxg9KH5P
         s26TQl9dH368Y/LLBH+6fLP+Zsm7jBJlHxGzdOzKv/dGbnSirEmUCP9p0mAtvUPxYphA
         nsEinVgmuKy26Wdk1MKg0uUDqfo7HBEoGBoFOassxkgsBzPtXuoSu6w6wnUMxqXbD5Ws
         Y2yBFzBLLLxXTM2OiBtQZl/yFSxiM8XG5EEcvoImx0lS083kfrjV1GFYMEJUtuIMtExc
         2T4xd/Z1IdEdyPFhT0IyxkGeJQg77123KMfCqWNmfKHRngHkStkea18ybFw0eXjW5ZrU
         avIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=6+FQAr3QFN14/bbpW/c2KgXaNuTk9/pA79fJdM5xfAY=;
        b=i/n2f0wIZugF+xGwpfWCfFFpyZ4Hcakt4643suHZc3e9ioj5hfDjukRvMaQSPSdAnU
         hAqn7k5KDJv+gMed9YLDXhVHOFo/OplM5Cj6YaP6Lju5I62hgOLi258Vo1QT13VD+MIo
         vUFEQgDOBgAC8i79+1mzKaguU6qxW14yQUTuFSyD6I6BG6cMa7xLqux6dLRchE5WNCsi
         wcnBbsnpXxQJXWh+D7lQK40EdUXQBRwwyOILlikE7n+G5wfPxGigbmqhuoGgiDDJKcTc
         6slDK0cP3tp3lxLJwcbpl80UmO2Ag0M9RtWokHCT4kRP6A9qaj7kBJ/FR/2RwJzU7lPf
         CHgg==
X-Gm-Message-State: AOAM532YDYGWvAa2sAqbweFpXU4w2Im9pWtfg8ugvb2w9uUOiUNC37Vm
        BlFxtxpQO/fFi9ywkWigEM0imOGIQuc=
X-Google-Smtp-Source: ABdhPJyPRNm1VcrL18a/bgbhMJlUR9JE/7pvL0Qjr4M4O8zo149h+HKWUeZ601UkuiVjmN17x9N5Pg==
X-Received: by 2002:a1c:e90d:: with SMTP id q13mr17178570wmc.163.1623685879851;
        Mon, 14 Jun 2021 08:51:19 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n10sm15447211wri.77.2021.06.14.08.51.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jun 2021 08:51:19 -0700 (PDT)
Message-Id: <4bdc0b77f6f2a379c229b221460558ea8def5ad1.1623685877.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1033.v2.git.git.1623685877.gitgitgadget@gmail.com>
References: <pull.1033.git.git.1623343712.gitgitgadget@gmail.com>
        <pull.1033.v2.git.git.1623685877.gitgitgadget@gmail.com>
From:   "Andrzej Hunt via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 14 Jun 2021 15:51:16 +0000
Subject: [PATCH v2 3/3] builtin/checkout--worker: zero-initialise struct to
 avoid MSAN complaints
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

report_result() sends a struct to the parent process, but that struct
would contain uninitialised padding bytes. Running this code under MSAN
rightly triggers a warning - but we don't particularly care about this
warning because we control the receiving code, and we therefore know
that those padding bytes won't be read on the receiving end.

We could simply suppress this warning under MSAN with the approporiate
ifdef'd attributes, but a less intrusive solution is to 0-initialise the
struct, which guarantees that the padding will also be initialised.

Interestingly, in the error-case branch, we only try to copy the first
two members of pc_item_result, by copying only PC_ITEM_RESULT_BASE_SIZE
bytes. However PC_ITEM_RESULT_BASE_SIZE is defined as
'offsetof(the_last_member)', which means that we're copying padding bytes
after the end of the second last member. We could avoid doing this by
redefining PC_ITEM_RESULT_BASE_SIZE as
'offsetof(second_last_member) + sizeof(second_last_member)', but there's
no huge benefit to doing so (and this patch silences the MSAN warning in
this scenario either way).

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
 builtin/checkout--worker.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/checkout--worker.c b/builtin/checkout--worker.c
index 289a9b8f89d0..fb9fd13b73c4 100644
--- a/builtin/checkout--worker.c
+++ b/builtin/checkout--worker.c
@@ -53,7 +53,7 @@ static void packet_to_pc_item(const char *buffer, int len,
 
 static void report_result(struct parallel_checkout_item *pc_item)
 {
-	struct pc_item_result res;
+	struct pc_item_result res = { 0 };
 	size_t size;
 
 	res.id = pc_item->id;
-- 
gitgitgadget
