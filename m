Return-Path: <SRS0=4z2X=6U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1182C28CBC
	for <git@archiver.kernel.org>; Wed,  6 May 2020 09:43:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BDB3D2082E
	for <git@archiver.kernel.org>; Wed,  6 May 2020 09:43:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aVaJSnGn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729066AbgEFJnR (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 May 2020 05:43:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728306AbgEFJnR (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 6 May 2020 05:43:17 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD569C061A0F
        for <git@vger.kernel.org>; Wed,  6 May 2020 02:43:16 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id y3so1409476wrt.1
        for <git@vger.kernel.org>; Wed, 06 May 2020 02:43:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=GW/wMDsCp/Y6+BZ/MVT3cQvJq8oMTYZtXqAAdWUgn9A=;
        b=aVaJSnGn2Y6jl+Qa6SYoj4RLxTzr6Jx4bMXlg6rwNgsxevJNpC0qPwnFrZ/tIv0rv3
         QeX6f633752ABO+BHR9et4IuetlWGutdKkpMo+Ioq60wJCc0KfkHY3+JA6csHgRYR9my
         uyb90+mU+5mQzoAWpKQ/U4zbSy+aouRPeA0X2hOHZKGkLX+bK9XCH0+Ba9Eobr5s9t/X
         giHWNxwl0i2yBd3iEgFXU+t9SWVb4T7F0fShYYA3c/e5UbEEtSXHKLCP4y9dwTzQurf7
         q9eroKPnKHVuDE/ajm7ra8ThgoK6X8dAQlRZURXrebTgGuqs5mfOQXe0YxtLPFlnNic0
         1c6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=GW/wMDsCp/Y6+BZ/MVT3cQvJq8oMTYZtXqAAdWUgn9A=;
        b=L4wL2iH92rrqB90l5hLAIAIzyZswmzWRgnbLzq9Yu/4h0QHJKkHjcAiGPo7rro9a6J
         5cZAq4IW5kCQKPyQwTEt70n6s/j/RnRXPOR329W6zh6Wle153rba3T5S4tX/Qxaj7PCD
         zdqCt9qSw6KNjqhSlEx2/7riylrxFXVBCLTUG82mLu9MYz6T6PIh/p/nifLXgddk9P0V
         99r5uQMz6RqCcIVaUURZES8QYfZwHv8FYvS/WeQv8xHNcS18hd4HHrPwZU3IbaMUsljK
         hIK/dL27fEH6hV8+UPfzP3McnM/VbzaS4zLzUi4DwDiSkvIhfTVvdRJQqlahM812NgyH
         RU2w==
X-Gm-Message-State: AGi0PuZbPwkMBNO6iVTo4WetD5C8uBlX+1snUMaa9eCeWpq8qQM9xs0R
        c83R4ygPa4ykrrgZdO/h7o/pH+xc
X-Google-Smtp-Source: APiQypKBWYhEPtvVztIQHpkInUqONgsbacnIePWUOgJu/kduJsN6H3r8XfKgYxpYavq/5htefo7dLQ==
X-Received: by 2002:adf:b1c9:: with SMTP id r9mr9264840wra.271.1588758195196;
        Wed, 06 May 2020 02:43:15 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 1sm2229964wmi.0.2020.05.06.02.43.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2020 02:43:14 -0700 (PDT)
Message-Id: <pull.626.v2.git.1588758194.gitgitgadget@gmail.com>
In-Reply-To: <pull.626.git.1588684003766.gitgitgadget@gmail.com>
References: <pull.626.git.1588684003766.gitgitgadget@gmail.com>
From:   "Son Luong Ngoc via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 06 May 2020 09:43:12 +0000
Subject: [PATCH v2 0/2] midx: apply gitconfig to midx repack
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Son Luong Ngoc <sluongng@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Midx repack has largely been used in Microsoft Scalar on the client side to
optimize the repository multiple packs state. However when I tried to apply
this onto the server-side, I realized that there are certain features that
were lacking compare to git repack. Most of these features are highly
desirable on the server-side to create the most optimized pack possible.

One of the example is delta_base_offset, comparing an midx repack
with/without delta_base_offset, we can observe significant size differences.

> du objects/pack/*pack
14536   objects/pack/pack-08a017b424534c88191addda1aa5dd6f24bf7a29.pack
9435280 objects/pack/pack-8829c53ad1dca02e7311f8e5b404962ab242e8f1.pack

Latest 2.26.2 (without delta_base_offset)
> git multi-pack-index write
> git multi-pack-index repack
> git multi-pack-index expire
> du objects/pack/*pack
9446096 objects/pack/pack-366c75e2c2f987b9836d3bf0bf5e4a54b6975036.pack

With delta_base_offset
> git version
git version 2.26.2.672.g232c24e857.dirty
> git multi-pack-index write
> git multi-pack-index repack
> git multi-pack-index expire
> du objects/pack/*pack
9152512 objects/pack/pack-3bc8c1ec496ab95d26875f8367ff6807081e9e7d.pack

In this patch, I intentionally leaving out repack.writeBitmaps as I see that
it might need some update on pack-objects to improve the performance

Derrick Stolee following patch with address repack. packKeptObjects support.

Derrick Stolee (1):
  multi-pack-index: respect repack.packKeptObjects=false

Son Luong Ngoc (1):
  midx: apply gitconfig to midx repack

 Documentation/git-multi-pack-index.txt |  3 +++
 midx.c                                 | 36 ++++++++++++++++++++++----
 t/t5319-multi-pack-index.sh            | 26 +++++++++++++++++++
 3 files changed, 60 insertions(+), 5 deletions(-)


base-commit: b34789c0b0d3b137f0bb516b417bd8d75e0cb306
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-626%2Fsluongng%2Fsluongngoc%2Fmidx-config-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-626/sluongng/sluongngoc/midx-config-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/626

Range-diff vs v1:

 1:  215c882a503 ! 1:  21c648cc486 midx: apply gitconfig to midx repack
     @@ Commit message
          In this patch, I applies those flags into `git multi-pack-index repack`
          so that it respect the `repack.*` config series.
      
     -    Note: I left out `repack.packKeptObjects` intentionally as I dont think
     -    its relevant to midx repack use case.
     +    Note:
     +    - `repack.packKeptObjects` will be addressed by Derrick Stolee in
     +    the following patch
     +    - `repack.writeBitmaps` when `--batch-size=0` was NOT adopted here as it
     +    requires `--all` to be passed onto `git pack-objects`, which is very
     +    slow. I think it would be nice to have this in a future patch.
      
          Signed-off-by: Son Luong Ngoc <sluongng@gmail.com>
      
       ## midx.c ##
     -@@ midx.c: static int fill_included_packs_batch(struct repository *r,
     - 	return 0;
     - }
     +@@ midx.c: int midx_repack(struct repository *r, const char *object_dir, size_t batch_size,
     + 	struct child_process cmd = CHILD_PROCESS_INIT;
     + 	struct strbuf base_name = STRBUF_INIT;
     + 	struct multi_pack_index *m = load_multi_pack_index(object_dir, 1);
     ++	int delta_base_offset = 1;
     ++	int use_delta_islands;
       
     -+static int delta_base_offset = 1;
     -+static int write_bitmaps = -1;
     -+static int use_delta_islands;
     -+
     - int midx_repack(struct repository *r, const char *object_dir, size_t batch_size, unsigned flags)
     - {
     - 	int result = 0;
     + 	if (!m)
     + 		return 0;
      @@ midx.c: int midx_repack(struct repository *r, const char *object_dir, size_t batch_size,
       	} else if (fill_included_packs_all(m, include_pack))
       		goto cleanup;
       
     -+  git_config_get_bool("repack.usedeltabaseoffset", &delta_base_offset);
     -+  git_config_get_bool("repack.writebitmaps", &write_bitmaps);
     -+  git_config_get_bool("repack.usedeltaislands", &use_delta_islands);
     ++	repo_config_get_bool(r, "repack.usedeltabaseoffset", &delta_base_offset);
     ++	repo_config_get_bool(r, "repack.usedeltaislands", &use_delta_islands);
      +
       	argv_array_push(&cmd.args, "pack-objects");
       
     @@ midx.c: int midx_repack(struct repository *r, const char *object_dir, size_t bat
      +		argv_array_push(&cmd.args, "--delta-base-offset");
      +	if (use_delta_islands)
      +		argv_array_push(&cmd.args, "--delta-islands");
     -+	if (write_bitmaps > 0)
     -+		argv_array_push(&cmd.args, "--write-bitmap-index");
     -+	else if (write_bitmaps < 0)
     -+		argv_array_push(&cmd.args, "--write-bitmap-index-quiet");
      +
       	if (flags & MIDX_PROGRESS)
       		argv_array_push(&cmd.args, "--progress");
 -:  ----------- > 2:  3d7b334f5c6 multi-pack-index: respect repack.packKeptObjects=false

-- 
gitgitgadget
