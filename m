Return-Path: <SRS0=soZh=7Z=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84308C433DF
	for <git@archiver.kernel.org>; Fri, 12 Jun 2020 16:20:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 645B120835
	for <git@archiver.kernel.org>; Fri, 12 Jun 2020 16:20:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ti1F4BXH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726290AbgFLQUG (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Jun 2020 12:20:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726108AbgFLQUF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Jun 2020 12:20:05 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49A4BC03E96F
        for <git@vger.kernel.org>; Fri, 12 Jun 2020 09:20:05 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id k26so8824620wmi.4
        for <git@vger.kernel.org>; Fri, 12 Jun 2020 09:20:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=a9ebYNiSMpRYR1Rih8r/UVC8eIRx4koCae6AfcSFXhM=;
        b=Ti1F4BXHpD2xJtj/6DLriluQzFTKtZ/hP1h+XKtefq1CnJqmaUxNz5dAj9BA9LEe4i
         Qyqy0UxL5zO1q/DHX7/o9b+oOXB4xb374bapceb4QiGuvTQ6ziXcMcpUgzcHJAcWYh/T
         Ro6EjfnWCK2Hh3zz/eemCjkehk0GTa8wJeZRq3dk55m7qN70WF4VtyF8erxM2OpsTKoA
         mBZqz00cisC8g9WPbB8hc5rxv2fHmxDmwv6rpFU2kiPFGk3OtkFuUw73lARh7BNIhuA9
         J0oBIRpO/TE7XWHfS5eXrRhb9xpwz1BJTJKTFr8YKADu4fhyfeWKCjrxHOZ5y0rjfCTe
         /bDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=a9ebYNiSMpRYR1Rih8r/UVC8eIRx4koCae6AfcSFXhM=;
        b=aJ5y22bSt69RStnAd76QZZ/dZeohFDeWPLhqzreQP+kqs+jCQhPpanp90mVxRS122I
         tLk/4xK11li7W6T8V/ww+CwxBgVvAPULlbzAjF3FSf0Hmc40CLM3JxQDZvBfElLVdBrQ
         ZTrW+iz9tOjesr8dPUfZ/dfhjXV49Y24e5croQt4Cxqctw/GJi2ylXgjPKHr0hx7ikbx
         vI10A7TY4w05prHjhaTjUzhYpKJdp8WgVSrRhL68brqzuR08VbTb+rZkRxHYYQJFL96k
         20P7rq/tsuSp8Vw7N0QJB3JrHPhzqW6JG4K/VbJ35CEJZxNrbLHj4K+FEDpy9DE31+2L
         MzMg==
X-Gm-Message-State: AOAM530CTjT9YHXz418fYIJg823wU1z/6GYp4OT2oYXLuWeyJyssJ2w/
        6toW2VmePZVo5uLe1XZHWkpUADoS
X-Google-Smtp-Source: ABdhPJzQ6jVhlbjDkeZ9hEPPyEhLD4QjtlHb8Kuhndv0KWAN94Ef7Hl9xZy0t+peFrcp/AXPY+7u8A==
X-Received: by 2002:a7b:c249:: with SMTP id b9mr13222588wmj.143.1591978802786;
        Fri, 12 Jun 2020 09:20:02 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z9sm9262037wmi.41.2020.06.12.09.20.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2020 09:20:01 -0700 (PDT)
Message-Id: <pull.804.v4.git.git.1591978801.gitgitgadget@gmail.com>
In-Reply-To: <pull.804.v3.git.git.1591888511.gitgitgadget@gmail.com>
References: <pull.804.v3.git.git.1591888511.gitgitgadget@gmail.com>
From:   "Chris Torek via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 12 Jun 2020 16:19:57 +0000
Subject: [PATCH v4 0/3] improve git-diff documentation and A...B handling
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Chris Torek <chris.torek@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

git diff -h help is succinct, but perhaps too much so.

The symmetric-diff syntax, git diff A...B, is defined by the documentation
to compare the merge base of A and B to commit B. It does so just fine when
there is a merge base. It compares A and B directly if there is no merge
base, and it is overly forgiving of bad arguments after which it can produce
nonsensical diffs. It also behaves badly with other odd/incorrect usages,
such as git diff A...B C..D.

The first patch simply adjusts a test that will fail if the second patch is
accepted. The second patch adds special handling for the symmetric and range
diff syntax so that the option parsing works, plus a small test suite. The
third patch updates the documentation, including adding a section for
combined commits, and makes the help output more verbose (to match the
SYNOPSIS and provide common diff options like git-diff-files, for instance).

Changes since v3:

 * correct > / >= goof
 * fix test nit per Philip Oakley

Chris Torek (3):
  t/t3430: avoid undefined git diff behavior
  git diff: improve range handling
  Documentation: usage for diff combined commits

 Documentation/git-diff.txt |  20 ++++--
 builtin/diff.c             | 132 +++++++++++++++++++++++++++++++++----
 t/t3430-rebase-merges.sh   |   2 +-
 t/t4068-diff-symmetric.sh  |  91 +++++++++++++++++++++++++
 4 files changed, 226 insertions(+), 19 deletions(-)
 create mode 100755 t/t4068-diff-symmetric.sh


base-commit: 20514004ddf1a3528de8933bc32f284e175e1012
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-804%2Fchris3torek%2Fcleanup-diff-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-804/chris3torek/cleanup-diff-v4
Pull-Request: https://github.com/git/git/pull/804

Range-diff vs v3:

 1:  2ccaad645ff = 1:  2ccaad645ff t/t3430: avoid undefined git diff behavior
 2:  60aed3f9d65 ! 2:  4fa6fba33b3 git diff: improve range handling
     @@ builtin/diff.c: static int builtin_diff_files(struct rev_info *revs, int argc, c
      +			basecount++;
      +			break;		/* do mark all bases */
      +		case REV_CMD_LEFT:
     -+			if (lpos > 0)
     ++			if (lpos >= 0)
      +				usage(builtin_diff_usage);
      +			lpos = i;
      +			if (obj->flags & SYMMETRIC_LEFT) {
     @@ builtin/diff.c: static int builtin_diff_files(struct rev_info *revs, int argc, c
      +			}
      +			continue;
      +		case REV_CMD_RIGHT:
     -+			if (rpos > 0)
     ++			if (rpos >= 0)
      +				usage(builtin_diff_usage);
      +			rpos = i;
      +			continue;	/* don't mark B */
     @@ t/t4068-diff-symmetric.sh (new)
      +. ./test-lib.sh
      +
      +# build these situations:
     -+#  - normal merge with one merge base (b1...b2);
     -+#  - criss-cross merge ie 2 merge bases (b1...master);
     -+#  - disjoint subgraph (orphan branch, b3...master).
     ++#  - normal merge with one merge base (br1...b2r);
     ++#  - criss-cross merge ie 2 merge bases (br1...master);
     ++#  - disjoint subgraph (orphan branch, br3...master).
      +#
      +#     B---E   <-- master
      +#    / \ /
 3:  a7da92cd635 = 3:  d7bc9aca44b Documentation: usage for diff combined commits

-- 
gitgitgadget
