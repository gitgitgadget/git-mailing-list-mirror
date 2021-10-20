Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C36FC433F5
	for <git@archiver.kernel.org>; Wed, 20 Oct 2021 13:24:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 088FA61260
	for <git@archiver.kernel.org>; Wed, 20 Oct 2021 13:24:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230219AbhJTN04 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Oct 2021 09:26:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230217AbhJTN0z (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Oct 2021 09:26:55 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B695CC06161C
        for <git@vger.kernel.org>; Wed, 20 Oct 2021 06:24:40 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id p21so18939303wmq.1
        for <git@vger.kernel.org>; Wed, 20 Oct 2021 06:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yl3X+PE3+xtQnWXPjZcY4GyUJZDkWPUgFvJFZJdcDQM=;
        b=HRXOBxeflW5JyR3ISF3MA+jWD4sMoC9p0jIOlrWd+237WpmuQ+R6lfL9k89Ze+9xZw
         TdHMf0VSJXRmUM/5oTfvdX4yQR2gyf8uD7HmHWzXd+Whur2qFtlYlO2kR93Q/mHJUk/e
         w0Zsg4McSiMFlck02CBSA1o8SPBCa2wMkq+S2NJ03th7kt+dAd2so9LN+HDMNl4vcvc7
         +HmXGRbQnb3e5lc9fZp2pzjj7upg1HnUrY0PZQe31Hy+ug3VqJ8Il3cUYIEdPqOZ1Iqd
         XqhD+s2t7MUAZm8fEUutf60i5AQ+O/Qup9achn5ENekGVsyO4A21vq0vNOok0mJMAu1D
         rihw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yl3X+PE3+xtQnWXPjZcY4GyUJZDkWPUgFvJFZJdcDQM=;
        b=6YLMOjAFU+bEUbOEpoTjSnFPT/LtVQ3fw4ONrD6AjoSUN/jv9wZ0FI5cBHr1w5MFbP
         XnxZ8K7Roy7MFGdXP5eMgACKh0I4U8+/aTN0RYJ0rS8IaJTd1p+GnLZZ55qndPYyJXHO
         fHhjiatmDb7QnhDLy9dvpWCWVbT7BsI7nnm4CLnWly9d1zP5U52w2l1vS0bu2UQiu8M0
         kXX4kBAffK/qB1RthDOacBp8xYfpmSoTsz1H4xehDu0eSYDY+Aea0S7Gvsy+SwXzXGNt
         Lvwps+07olDlX7xH7ej1Obki+kO34usgy+OQ06guqftba8oqOp0Du3gPEiezSrvo5gPs
         5GOw==
X-Gm-Message-State: AOAM531sR9O6wxBHu9xLFDlyQ6jjxJwqIjTpGnyaONGFS0xHsb8glycv
        x7BEuddAlMw8OWNG/QQk2VchJi+casT3IA==
X-Google-Smtp-Source: ABdhPJygoV3hEF3qfQ56+/Hbmkai8nPPRinwXc8ShMgrALsWvnt25V8E0yrPyXccGcflQQRbHHbynQ==
X-Received: by 2002:adf:d1cb:: with SMTP id b11mr52066178wrd.418.1634736278848;
        Wed, 20 Oct 2021 06:24:38 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id k17sm5933351wmj.0.2021.10.20.06.24.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Oct 2021 06:24:38 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [RFC PATCH v2 0/4] for-each-ref: delay parsing of --sort=<atom> options + linux-leaks fixes
Date:   Wed, 20 Oct 2021 15:24:32 +0200
Message-Id: <RFC-cover-v2-0.4-00000000000-20211020T131627Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.1.1338.g20da966911a
In-Reply-To: <211020.864k9boo0f.gmgdl@evledraar.gmail.com>
References: <211020.864k9boo0f.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As noted in <211020.864k9boo0f.gmgdl@evledraar.gmail.com> the upthread
patch breaks the linux-leaks job, since simple invocations of "git
tag" start leaking memory: https://github.com/git/git/runs/3934925278

I tried to structure this as somethnig that could be merged or queued
up separately, but the semantic conflict in "branch.c" was difficult,
as Junio's patch changes how those variables are managed.

Junio C Hamano (1):
  for-each-ref: delay parsing of --sort=<atom> options

Ævar Arnfjörð Bjarmason (3):
  tag: use a "goto cleanup" pattern, leak less memory
  ref-filter API user: add and use a ref_sorting_release()
  branch: use ref_sorting_release()

 builtin/branch.c        | 24 ++++++++++++-----------
 builtin/for-each-ref.c  | 10 +++++-----
 builtin/ls-remote.c     | 13 ++++++++-----
 builtin/tag.c           | 42 ++++++++++++++++++++++-------------------
 ref-filter.c            | 40 ++++++++++++++++++++++++++++++---------
 ref-filter.h            | 30 ++++++++++++-----------------
 t/t3200-branch.sh       | 12 +++++++++++-
 t/t6300-for-each-ref.sh |  5 +++++
 8 files changed, 108 insertions(+), 68 deletions(-)

Range-diff against v1:
-:  ----------- > 1:  fc776c3f1cd tag: use a "goto cleanup" pattern, leak less memory
-:  ----------- > 2:  0ae71c19ab7 ref-filter API user: add and use a ref_sorting_release()
1:  21a1f4d3b08 ! 3:  7abbbe4468c for-each-ref: delay parsing of --sort=<atom> options
    @@ builtin/ls-remote.c: int cmd_ls_remote(int argc, const char **argv, const char *
     -	if (sorting)
     +	if (sorting_options.nr) {
     +		struct ref_sorting *sorting;
    -+		UNLEAK(sorting);
     +
     +		sorting = ref_sorting_options(&sorting_options);
      		ref_array_sort(sorting, &ref_array);
    ++		ref_sorting_release(sorting);
     +	}
      
      	for (i = 0; i < ref_array.nr; i++) {
    @@ ref-filter.c: void parse_ref_sorting(struct ref_sorting **sorting_tail, const ch
     +	return sorting;
      }
      
    - int parse_opt_merge_filter(const struct option *opt, const char *arg, int unset)
    + void ref_sorting_release(struct ref_sorting *sorting)
     
      ## ref-filter.h ##
     @@
    @@ ref-filter.h: int format_ref_array_item(struct ref_array_item *info,
     -struct ref_sorting *ref_default_sorting(void);
     +/*  Convert list of sort options into ref_sorting */
     +struct ref_sorting *ref_sorting_options(struct string_list *);
    + /* Release a "struct ref_sorting" */
    + void ref_sorting_release(struct ref_sorting *);
      /*  Function to parse --merged and --no-merged options */
    - int parse_opt_merge_filter(const struct option *opt, const char *arg, int unset);
    - /*  Get the current HEAD's description */
     
      ## t/t3200-branch.sh ##
     @@ t/t3200-branch.sh: test_expect_success 'invalid sort parameter in configuration' '
-:  ----------- > 4:  f7d87aea384 branch: use ref_sorting_release()
-- 
2.33.1.1338.g20da966911a

