Return-Path: <SRS0=RpNG=6Y=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2FF8C38A2A
	for <git@archiver.kernel.org>; Sun, 10 May 2020 16:07:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B1F420735
	for <git@archiver.kernel.org>; Sun, 10 May 2020 16:07:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oizQAc9P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728990AbgEJQHi (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 10 May 2020 12:07:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728849AbgEJQHh (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 May 2020 12:07:37 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B4CAC061A0C
        for <git@vger.kernel.org>; Sun, 10 May 2020 09:07:37 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id w19so1411035wmc.1
        for <git@vger.kernel.org>; Sun, 10 May 2020 09:07:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=oqQtTLKRB+Bx3PWCsJuqj2IDi/vlaXx+5kykG/4JsXo=;
        b=oizQAc9PdpSCmGVBcE2qLCbaXJpYMStUHYWb/vFQE6sQAjJ/jfuV7AFycBg/VVZ7zo
         5+xs8rtVobfQTwbR80ylY1yc5I3S8MrVxZ0lJLzT0XSHiEEeNbPVotGJnVrqqhRBoWtM
         ZIwrMDkTiAW/XzG5F1gHNO1QoHHdaFjYfL6Vw9CvijLSu5jood9n8CXbHDgBVBSBGP0S
         mTKUVdBxWIPLNpNv17Ejc6ORANOwMVxPFH9bXiWdcHi+qz+IwHhkMDgZK3x0vBX+JeaB
         YRZWVX778dFtX436ISBT74n4ix80+H4MOAeyn8M2C0CmtzTvOFdPCAQ56hCDcEPWblmL
         XhQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=oqQtTLKRB+Bx3PWCsJuqj2IDi/vlaXx+5kykG/4JsXo=;
        b=i9FuRO1+ZkRDkPgcJc/NiDMRopQrklUIZxl9v75WEWNz8zJUwKt1q/R9Y+Pun75N6y
         dWeqmrJEDVpTFONZPN3IPhuOutCswSVzY0mSIfEE8O7NOIRLMIxgYqp9y7iSjN/e5FV+
         FNnYsbZNw7i3KnPyPXW5i28H/lDsy+jlbGPChnpLN5fFAeehIE9m0ZvZnN2tArtQZnFd
         7pMtowZVdSnidaKbtFE8bvCZzBRnnkk+K9bV1BJCIOl+HG7sTvp6xj7Bgf7QmcKwPxlE
         JaYQ8jmGAumb1KKHfioH5ydFcDrUroH1KloIbvlh6Euyr/sfB+iQbEPv6XxYJ4g1KS3o
         vcXQ==
X-Gm-Message-State: AGi0PuYAAuoqGgR6tGhrCZ7stAxx6kyw/QXxnxuaNzoRtDsiLww7b/P8
        aIuwHYYggftBqnVtOUB8ckmgkU8Q
X-Google-Smtp-Source: APiQypJ8YyO4aJIVJMcigU4u8frgGnmFy2vanjlpcQpRUrFg/U34wkTBhyzMLskCjSx2A+Ijj6DwPA==
X-Received: by 2002:a05:600c:2219:: with SMTP id z25mr648801wml.128.1589126856072;
        Sun, 10 May 2020 09:07:36 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v16sm22675660wml.30.2020.05.10.09.07.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 May 2020 09:07:35 -0700 (PDT)
Message-Id: <pull.626.v4.git.1589126855.gitgitgadget@gmail.com>
In-Reply-To: <pull.626.v3.git.1589034270.gitgitgadget@gmail.com>
References: <pull.626.v3.git.1589034270.gitgitgadget@gmail.com>
From:   "Son Luong Ngoc via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 10 May 2020 16:07:32 +0000
Subject: [PATCH v4 0/2] midx: apply gitconfig to midx repack
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

Note that repack.writeBitmaps configuration is ignored, as the pack bitmap
facility is useful only with a single packfile.

Derrick Stolee's following patch will address repack.packKeptObjects 
support.

Derrick Stolee (1):
  multi-pack-index: respect repack.packKeptObjects=false

Son Luong Ngoc (1):
  midx: teach "git multi-pack-index repack" honor "git repack"
    configurations

 Documentation/git-multi-pack-index.txt |  3 ++
 midx.c                                 | 42 +++++++++++++++++++++++---
 t/t5319-multi-pack-index.sh            | 27 +++++++++++++++++
 3 files changed, 67 insertions(+), 5 deletions(-)


base-commit: b994622632154fc3b17fb40a38819ad954a5fb88
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-626%2Fsluongng%2Fsluongngoc%2Fmidx-config-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-626/sluongng/sluongngoc/midx-config-v4
Pull-Request: https://github.com/gitgitgadget/git/pull/626

Range-diff vs v3:

 1:  a925307d4c5 ! 1:  a8f75e34e5b midx: teach "git multi-pack-index repack" honor "git repack" configurations
     @@ Metadata
       ## Commit message ##
          midx: teach "git multi-pack-index repack" honor "git repack" configurations
      
     -    Previously, when the "repack" subcommand of "git multi-pack-index" command
     -    creates new packfile(s), it does not call the "git repack" command but
     -    instead directly calls the "git pack-objects" command, and the
     -    configuration variables meant for the "git repack" command, like
     -    "repack.usedaeltabaseoffset", are ignored.
     +    When the "repack" subcommand of "git multi-pack-index" command
     +    creates new packfile(s), it does not call the "git repack"
     +    command but instead directly calls the "git pack-objects"
     +    command, and the configuration variables meant for the "git
     +    repack" command, like "repack.usedaeltabaseoffset", are ignored.
      
     -    This patch ensured "git multi-pack-index" checks the configuration
     -    variables used by "git repack" and passes the corresponding options to
     -    the underlying "git pack-objects" command.
     +    Check the configuration variables used by "git repack" ourselves
     +    in "git multi-index-pack" and pass the corresponding options to
     +    underlying "git pack-objects".
      
          Note that `repack.writeBitmaps` configuration is ignored, as the
          pack bitmap facility is useful only with a single packfile.
     @@ Commit message
      
       ## midx.c ##
      @@ midx.c: int midx_repack(struct repository *r, const char *object_dir, size_t batch_size,
     - 	struct child_process cmd = CHILD_PROCESS_INIT;
       	struct strbuf base_name = STRBUF_INIT;
       	struct multi_pack_index *m = load_multi_pack_index(object_dir, 1);
     + 
     ++	/*
     ++	 * When updating the default for these configuration
     ++	 * variables in builtin/repack.c, these must be adjusted
     ++	 * to match.
     ++	 */
      +	int delta_base_offset = 1;
      +	int use_delta_islands = 0;
     - 
     ++
       	if (!m)
       		return 0;
     + 
      @@ midx.c: int midx_repack(struct repository *r, const char *object_dir, size_t batch_size,
       	} else if (fill_included_packs_all(m, include_pack))
       		goto cleanup;
 2:  988697dd512 ! 2:  192fc785382 multi-pack-index: respect repack.packKeptObjects=false
     @@ t/t5319-multi-pack-index.sh: test_expect_success 'repack with minimum size does
      +		ls .git/objects/pack/*idx >idx-list &&
      +		test_line_count = 5 idx-list &&
      +		ls .git/objects/pack/*.pack | sed "s/\.pack/.keep/" >keep-list &&
     ++		test_line_count = 5 keep-list &&
      +		for keep in $(cat keep-list)
      +		do
      +			touch $keep || return 1
     @@ t/t5319-multi-pack-index.sh: test_expect_success 'repack with minimum size does
      +		test_line_count = 5 idx-list &&
      +		test-tool read-midx .git/objects | grep idx >midx-list &&
      +		test_line_count = 5 midx-list &&
     -+		THIRD_SMALLEST_SIZE=$(test-tool path-utils file-size .git/objects/pack/*pack | sort -n | head -n 3 | tail -n 1) &&
     -+		BATCH_SIZE=$(($THIRD_SMALLEST_SIZE + 1)) &&
     ++		THIRD_SMALLEST_SIZE=$(test-tool path-utils file-size .git/objects/pack/*pack | sort -n | sed -n 3p) &&
     ++		BATCH_SIZE=$((THIRD_SMALLEST_SIZE + 1)) &&
      +		git multi-pack-index repack --batch-size=$BATCH_SIZE &&
      +		ls .git/objects/pack/*idx >idx-list &&
      +		test_line_count = 5 idx-list &&
 3:  efeb3d7d132 < -:  ----------- Ensured t5319 follows arith expansion guideline

-- 
gitgitgadget
