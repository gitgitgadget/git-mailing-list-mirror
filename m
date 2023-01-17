Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CA38C54E76
	for <git@archiver.kernel.org>; Tue, 17 Jan 2023 21:05:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229606AbjAQVFZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Jan 2023 16:05:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbjAQVDo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Jan 2023 16:03:44 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA17654131
        for <git@vger.kernel.org>; Tue, 17 Jan 2023 11:31:00 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id me17-20020a17090b17d100b0022901e51ab3so10301428pjb.2
        for <git@vger.kernel.org>; Tue, 17 Jan 2023 11:31:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/AwpMbaimP5jOFJfm+ecXOGCeTE6KwZS+RBmwLBsCxs=;
        b=p8Dye+ShCeSBqzMXNzodIqCXvKzTJFx5+5anBpfMVFBDVqZJFtTkL9UrnikYZHRGEa
         y6gYIHY/2HWYrvjFrPeW+kCKZpNP6jhNmpNVRBZnrfYnuC5m3I4s/X8OWkNlJ9KCbDTE
         vxVejLFWjgQvycL3C/ogU6HIdfJh/oC0Y/o+ZHY/FXUfDk9UKXCWwDsf9UJX4MJ4gcdt
         ab7axuh9OSUpRboHm3MMei6mwKvPusYNITz4D28riWiKz2oEFgTy8YzDv28NUn3/TnDo
         MTUkZsMFDHefA88/4wqYYljxtxK435ljOIeUMuKNOm3P58wz2bz07B1o+/8cmD9s7jlC
         /Leg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/AwpMbaimP5jOFJfm+ecXOGCeTE6KwZS+RBmwLBsCxs=;
        b=Ieg8ENVo4bxGP5z9/dJoXpdJ3puCCDr0vKLjklk0OCkhWvlGwEuWSbVKE4wx9OfQof
         +jrK14WXtONBksN9aPUU4H7ND5xeMlQY7uI+wRcb+MRD7gdfOoh0ZrmNbMs48HXXt8Yc
         yHfa8NtNUvDAPzW6hS9yipUMV6jqJXNqBsSDmuD3HmBZzW5RyK2Bggu+1GCZEzSzNj8U
         N10s5ApijDtXXdNZ7dtC5N6vXJpIvotlSJwwjwmvt3kYleOoLfSpowc2toQOa+2M2OvP
         f/+yIT7dxsYH6OSQg1FVsVrY+yqgKmYUoafUcoQUNNdTbInWKU0BvEzx9INB6ubXllC/
         Z1fQ==
X-Gm-Message-State: AFqh2kraWdDtn0j6/dJLmBENtFAtWJ4jolIzz5Vq2CPCIMsFOjAPNM5y
        Q8kngxfxug+A4Z81388pDO7GgxXHD+ZH0SuxLGvQDogt34Qlq8lNjHq/o47FkfwkcrdijhTKWSZ
        tHUz1U7nsH9EtT3gTHSGQtnnqJXaAtlnx36tlLsDCLl6dKk+qQsSNLLcG3VK32aO/VA==
X-Google-Smtp-Source: AMrXdXueTBygZUowb/ectHHNhM22LklA5GoC8jwpKnAaCaVGV2WR3N97lqZr7x6Gf16RwFOTHJnPObb16ZLknQg=
X-Received: from barleywine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3bd4])
 (user=calvinwan job=sendgmr) by 2002:a17:90b:1901:b0:226:c03e:23fc with SMTP
 id mp1-20020a17090b190100b00226c03e23fcmr430718pjb.6.1673983860220; Tue, 17
 Jan 2023 11:31:00 -0800 (PST)
Date:   Tue, 17 Jan 2023 19:30:35 +0000
In-Reply-To: <20230104215415.1083526-1-calvinwan@google.com>
Mime-Version: 1.0
References: <20230104215415.1083526-1-calvinwan@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Message-ID: <20230117193041.708692-1-calvinwan@google.com>
Subject: [PATCH v6 0/6] submodule: parallelize diff
From:   Calvin Wan <calvinwan@google.com>
To:     git@vger.kernel.org
Cc:     Calvin Wan <calvinwan@google.com>, emilyshaffer@google.com,
        avarab@gmail.com, phillip.wood123@gmail.com, chooglen@google.com,
        newren@gmail.com, jonathantanmy@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Original cover letter for context:
https://lore.kernel.org/git/20221011232604.839941-1-calvinwan@google.com/

(Quick reroll to fix leaks from v5)

Thank you again everyone for the numerous reviews! For this reroll, I
incorporated most of the feedback given, fixed a bug I found, and made
some stylistic refactors. I also added a new patch at the end that swaps
the serial implementation in is_submodule_modified for the new parallel
one. While I had patch 6 originally smushed with the previous one,
the diff came out not very reviewer friendly so it has been separated
out.

Changes since v4

(Patch 1)
The code in run-command.c that calls duplicate_output_fn has been
cleaned up and no longer passes a separate strbuf for the output. It
instead passes an offset that represents the starting point in the
original strbuf.

(Patch 5)
Moved status parsing from status_duplicate_output to status_finish. In
pp_buffer_stderr::run-command.c, output is gathered by strbuf_read_once
which reads 8192 bytes at once so a longer status message would error
out during status parsing since part of it would be cut off. Therefore,
status parsing must happen at the end of the process rather than in
duplicate_output_fn (and has subsequently been moved).

(Patch 6)
New patch swapping serial implementation in is_submodule_modified for
the new parallel one.

Calvin Wan (6):
  run-command: add duplicate_output_fn to run_processes_parallel_opts
  submodule: strbuf variable rename
  submodule: move status parsing into function
  diff-lib: refactor match_stat_with_submodule
  diff-lib: parallelize run_diff_files for submodules
  submodule: call parallel code from serial status

 Documentation/config/submodule.txt |  12 ++
 diff-lib.c                         | 104 ++++++++++--
 run-command.c                      |  16 +-
 run-command.h                      |  27 +++
 submodule.c                        | 254 ++++++++++++++++++++++-------
 submodule.h                        |   9 +
 t/helper/test-run-command.c        |  21 +++
 t/t0061-run-command.sh             |  39 +++++
 t/t4027-diff-submodule.sh          |  19 +++
 t/t7506-status-submodule.sh        |  19 +++
 10 files changed, 445 insertions(+), 75 deletions(-)

-- 
2.39.0.314.g84b9a713c41-goog

