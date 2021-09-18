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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0B14C433F5
	for <git@archiver.kernel.org>; Sat, 18 Sep 2021 13:49:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8595561368
	for <git@archiver.kernel.org>; Sat, 18 Sep 2021 13:49:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237853AbhIRNvF (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 18 Sep 2021 09:51:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237615AbhIRNvF (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Sep 2021 09:51:05 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 651FAC061574
        for <git@vger.kernel.org>; Sat, 18 Sep 2021 06:49:41 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id c8-20020a7bc008000000b002e6e462e95fso12091451wmb.2
        for <git@vger.kernel.org>; Sat, 18 Sep 2021 06:49:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=KdxOJyRC8jIGOcUwf033kqY1zKu7y6LeQAXcMpFz74o=;
        b=XZgE5Jdyg+whJsSPNnG7chqumHwApcE+4UvS2/wf9DaPzK0RAeQDiUGADkNMDuyB2K
         h1k/FgCp7pbzlpTJ8q+jcDxXprJlmktovhfXkraDvcDpFluK2oOV2M3xROlOf9kpH1vK
         dFbI0aJVON+iYZWrXQmwlHd412DuOV5bMm7DJhvW6dfuKkgOAJbFTbmrvdE/BB5vjMvP
         IcwSOVjrmvMMh5QQ8/7qJaT3FmcSIvpcoYtKgJcFhAgoBW/sSw4Jz9XUH+vHSoVcgduF
         exEkoHYnYvGWUFS04fDs0E2t65oS0TUTwAy8VBrdkiTTCrLZT8PH8o43ZsxvX/PkkdWy
         B5AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=KdxOJyRC8jIGOcUwf033kqY1zKu7y6LeQAXcMpFz74o=;
        b=W/agYstxPWp84tZ0DoeMokC0aV+mIpaHXDVsBnbaJ3Jo8ukdMUxC3L+nq/6zL5vF0Y
         qiSVCBQxKQCKsG8QNjJVY3tA9E0gHrJGjfdXjKrr85Qjqt7oa4dPny9RsAP6yLbqhte+
         O8BDECe2pASiOi0PJJ44pJpU7tz84S18n/By2Po3poov3RVndFEW4CwJbvKpjfq9ngsR
         47ZO/7n88oKXkGXydkyr4RbQzzb1f+CDqoBSa/wQ9coPobjn25/9nHQ51mI57MIvsPIt
         +MKd1EJ2S+ehPR20Dt6QhAjDKqJjCeXzUSCsK282ijzfpWchvt0s7qcNiRqaqMIcRc1F
         P4KQ==
X-Gm-Message-State: AOAM5326u1v+omJQ6++jhXMh78NB10b73xqRCafIYsZyWAFrZ7Z3Bfjk
        tpmhMrhttSqmajp8MueAD31h4yV9hbA=
X-Google-Smtp-Source: ABdhPJw66FoyXPzcMlbPrUVQspkdEdgdTlAW8UTgsPdwvdngf/vfp3NjMmAMBPa4rJ3509DIQ+YkYg==
X-Received: by 2002:a05:600c:245:: with SMTP id 5mr20566946wmj.53.1631972980073;
        Sat, 18 Sep 2021 06:49:40 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k4sm9435609wmj.30.2021.09.18.06.49.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Sep 2021 06:49:39 -0700 (PDT)
Message-Id: <6d54bc264e2f9ce519f32c0673167a00bab55573.1631972978.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1092.git.git.1631972978.gitgitgadget@gmail.com>
References: <pull.1092.git.git.1631972978.gitgitgadget@gmail.com>
From:   "Andrzej Hunt via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 18 Sep 2021 13:49:37 +0000
Subject: [PATCH 1/2] log: UNLEAK rev to silence a large number of leaks
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Carlo Arenas <carenas@gmail.com>, Andrzej Hunt <andrzej@ahunt.org>,
        Andrzej Hunt <ajrhunt@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Andrzej Hunt <ajrhunt@google.com>

cmd_show puts a lot of data into rev, and doesn't clean it up before
returning. That's reasonable - we use most if not all of rev up until
cmd_show is finished - there's not much value in doing a proper cleanup.
Therefore we take the easy way out and UNLEAK rev.

The UNLEAK has to be performed early on, as cmd_show might return via
cmd_log_walk() in the next few lines, or it might continue to the
no-walk implementation below.

This patch silences the following leaks which were found when running
t0000 against LSAN:

Direct leak of 41 byte(s) in 1 object(s) allocated from:
    #0 0x486834 in strdup /home/abuild/rpmbuild/BUILD/llvm-11.0.0.src/build/../projects/compiler-rt/lib/asan/asan_interceptors.cpp:452:3
    #1 0x9ab168 in xstrdup /home/ahunt/oss-fuzz/git/wrapper.c:29:14
    #2 0x83cced in add_object_array_with_path /home/ahunt/oss-fuzz/git/object.c:349:17
    #3 0x8f4f5a in add_pending_object_with_path /home/ahunt/oss-fuzz/git/revision.c:329:2
    #4 0x8eb2b6 in handle_revision_arg_1 /home/ahunt/oss-fuzz/git/revision.c:2082:2
    #5 0x8eadad in handle_revision_arg /home/ahunt/oss-fuzz/git/revision.c:2089:12
    #6 0x8eea99 in setup_revisions /home/ahunt/oss-fuzz/git/revision.c:2756:7
    #7 0x59c024 in cmd_log_init_finish /home/ahunt/oss-fuzz/git/builtin/log.c:206:9
    #8 0x5998d8 in cmd_log_init /home/ahunt/oss-fuzz/git/builtin/log.c:275:2
    #9 0x599f9b in cmd_show /home/ahunt/oss-fuzz/git/builtin/log.c:641:2
    #10 0x4cd92d in run_builtin /home/ahunt/oss-fuzz/git/git.c:453:11
    #11 0x4cb5fa in handle_builtin /home/ahunt/oss-fuzz/git/git.c:704:3
    #12 0x4ccf57 in run_argv /home/ahunt/oss-fuzz/git/git.c:771:4
    #13 0x4caf49 in cmd_main /home/ahunt/oss-fuzz/git/git.c:902:19
    #14 0x69ce3e in main /home/ahunt/oss-fuzz/git/common-main.c:52:11
    #15 0x7f7c56197349 in __libc_start_main (/lib64/libc.so.6+0x24349)

Direct leak of 32 byte(s) in 1 object(s) allocated from:
    #0 0x49a9d2 in calloc /home/abuild/rpmbuild/BUILD/llvm-11.0.0.src/build/../projects/compiler-rt/lib/asan/asan_malloc_linux.cpp:154:3
    #1 0x9ab4c2 in xcalloc /home/ahunt/oss-fuzz/git/wrapper.c:140:8
    #2 0x59c269 in cmd_log_init_finish /home/ahunt/oss-fuzz/git/builtin/log.c:233:18
    #3 0x5998d8 in cmd_log_init /home/ahunt/oss-fuzz/git/builtin/log.c:275:2
    #4 0x599f9b in cmd_show /home/ahunt/oss-fuzz/git/builtin/log.c:641:2
    #5 0x4cd92d in run_builtin /home/ahunt/oss-fuzz/git/git.c:453:11
    #6 0x4cb5fa in handle_builtin /home/ahunt/oss-fuzz/git/git.c:704:3
    #7 0x4ccf57 in run_argv /home/ahunt/oss-fuzz/git/git.c:771:4
    #8 0x4caf49 in cmd_main /home/ahunt/oss-fuzz/git/git.c:902:19
    #9 0x69ce3e in main /home/ahunt/oss-fuzz/git/common-main.c:52:11
    #10 0x7f7c56197349 in __libc_start_main (/lib64/libc.so.6+0x24349)

Indirect leak of 41 byte(s) in 1 object(s) allocated from:
    #0 0x486834 in strdup /home/abuild/rpmbuild/BUILD/llvm-11.0.0.src/build/../projects/compiler-rt/lib/asan/asan_interceptors.cpp:452:3
    #1 0x9ab168 in xstrdup /home/ahunt/oss-fuzz/git/wrapper.c:29:14
    #2 0x8f5e30 in add_rev_cmdline /home/ahunt/oss-fuzz/git/revision.c:1482:23
    #3 0x8eb26d in handle_revision_arg_1 /home/ahunt/oss-fuzz/git/revision.c:2081:2
    #4 0x8eadad in handle_revision_arg /home/ahunt/oss-fuzz/git/revision.c:2089:12
    #5 0x8eea99 in setup_revisions /home/ahunt/oss-fuzz/git/revision.c:2756:7
    #6 0x59c024 in cmd_log_init_finish /home/ahunt/oss-fuzz/git/builtin/log.c:206:9
    #7 0x5998d8 in cmd_log_init /home/ahunt/oss-fuzz/git/builtin/log.c:275:2
    #8 0x599f9b in cmd_show /home/ahunt/oss-fuzz/git/builtin/log.c:641:2
    #9 0x4cd92d in run_builtin /home/ahunt/oss-fuzz/git/git.c:453:11
    #10 0x4cb5fa in handle_builtin /home/ahunt/oss-fuzz/git/git.c:704:3
    #11 0x4ccf57 in run_argv /home/ahunt/oss-fuzz/git/git.c:771:4
    #12 0x4caf49 in cmd_main /home/ahunt/oss-fuzz/git/git.c:902:19
    #13 0x69ce3e in main /home/ahunt/oss-fuzz/git/common-main.c:52:11
    #14 0x7fc4b3f06349 in __libc_start_main (/lib64/libc.so.6+0x24349)

Signed-off-by: Andrzej Hunt <andrzej@ahunt.org>
---
 builtin/log.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/builtin/log.c b/builtin/log.c
index f75d87e8d7f..6faaddf17a6 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -644,6 +644,7 @@ int cmd_show(int argc, const char **argv, const char *prefix)
 	opt.def = "HEAD";
 	opt.tweak = show_setup_revisions_tweak;
 	cmd_log_init(argc, argv, prefix, &rev, &opt);
+	UNLEAK(rev);
 
 	if (!rev.no_walk)
 		return cmd_log_walk(&rev);
-- 
gitgitgadget

