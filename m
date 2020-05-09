Return-Path: <SRS0=Fs4s=6X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44FBDC28CBC
	for <git@archiver.kernel.org>; Sat,  9 May 2020 14:24:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0551421473
	for <git@archiver.kernel.org>; Sat,  9 May 2020 14:24:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f7GD+src"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727810AbgEIOYd (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 9 May 2020 10:24:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727105AbgEIOYd (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 9 May 2020 10:24:33 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C1EDC061A0C
        for <git@vger.kernel.org>; Sat,  9 May 2020 07:24:33 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id h9so5301865wrt.0
        for <git@vger.kernel.org>; Sat, 09 May 2020 07:24:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=9GLYG4ZdkMCoRL9DoJIwYxvsiKwrmbfgdtJlJZXYsO8=;
        b=f7GD+srcgXJD+TR8E/lMcEmVGesAPFQ/yeWeU0WcKiLX6id8YP5oEDLxsJbH4DTYwA
         owf/TzXrLTOZv19xdBfVNLLGiTkVMu2K1Gj46u1QDnbMlNh09mi5U8Ngq2n0LS4Umhev
         PIs8k4O2q2GOpsGwEzeMgPdpfqyzhPPUlL6OvfPvIqZuaYLKaqgoFDfqbHYY3jnfMlgW
         8isW7q2gE114H9znFWePnKTmNrY2hbkcsXKRSzyI5VBSuhcVIDQiixUQLj8B+jVApgI0
         PksPGPtiBlHHL0iPpaP23Fyh9LnQzCXU4RbnZxb1XZ6avOJD5vC2qPn3en/HkAFYMjAg
         R9iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=9GLYG4ZdkMCoRL9DoJIwYxvsiKwrmbfgdtJlJZXYsO8=;
        b=ZxSm8+JF/S7paIjrO68epD7ThA+VRgkwLKgNUN655juidU1Tg9ObXwkVM6yV+3+UG9
         UzYVaqTmShAlX5RDNxvW1Mxl0IJhrR6BHSoDBmcxT5xc9VfAxIg/51cLK6evTtL0SRSX
         97U6Je7juNgLRAoSQf321rdxdyBcUnbZRH4zgNRXLW0S7daP10rOs8qTKkA+Vc77NqNm
         68LcoUVmJK9ZCYzrxmTqnUvKZLXakwObTfcbpiMS/8hVceceYXTV2+Bx+KvfhPj+kLOB
         vXi/p4YOmWJSx4pXqHwJtM/qexJ/nd0tSJL0ChuiUNYP3MEbvc44LoK7qjfryNSiBUCa
         J3Aw==
X-Gm-Message-State: AGi0PuYGy4mcWpCwDoYWltRqraHbGnws5GAtaIjA42bAdiJm2/Qg1mXm
        WZyyHGlXOSwC80nl6iFamOMFg043
X-Google-Smtp-Source: APiQypKLn1OI0y/DjbW7y1Wyy806HdsAaX35IbNugA+I2a1bMfNmSrnZ8MQeYiwHdmE5OFasehBtNQ==
X-Received: by 2002:a5d:6284:: with SMTP id k4mr9213848wru.40.1589034271417;
        Sat, 09 May 2020 07:24:31 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o66sm7261828wma.2.2020.05.09.07.24.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 May 2020 07:24:30 -0700 (PDT)
Message-Id: <pull.626.v3.git.1589034270.gitgitgadget@gmail.com>
In-Reply-To: <pull.626.v2.git.1588758194.gitgitgadget@gmail.com>
References: <pull.626.v2.git.1588758194.gitgitgadget@gmail.com>
From:   "Son Luong Ngoc via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 09 May 2020 14:24:27 +0000
Subject: [PATCH v3 0/3] midx: apply gitconfig to midx repack
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

Son Luong Ngoc (2):
  midx: teach "git multi-pack-index repack" honor "git repack"
    configurations
  Ensured t5319 follows arith expansion guideline

 Documentation/git-multi-pack-index.txt |  3 ++
 midx.c                                 | 36 ++++++++++++---
 t/t5319-multi-pack-index.sh            | 62 ++++++++++++++++++--------
 3 files changed, 78 insertions(+), 23 deletions(-)


base-commit: b994622632154fc3b17fb40a38819ad954a5fb88
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-626%2Fsluongng%2Fsluongngoc%2Fmidx-config-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-626/sluongng/sluongngoc/midx-config-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/626

Range-diff vs v2:

 1:  21c648cc486 ! 1:  a925307d4c5 midx: apply gitconfig to midx repack
     @@ Metadata
      Author: Son Luong Ngoc <sluongng@gmail.com>
      
       ## Commit message ##
     -    midx: apply gitconfig to midx repack
     +    midx: teach "git multi-pack-index repack" honor "git repack" configurations
      
     -    Multi-Pack-Index repack is an incremental, repack solutions
     -    that allows user to consolidate multiple packfiles in a non-disruptive
     -    way. However the new packfile could be created without some of the
     -    capabilities of a packfile that is created by calling `git repack`.
     +    Previously, when the "repack" subcommand of "git multi-pack-index" command
     +    creates new packfile(s), it does not call the "git repack" command but
     +    instead directly calls the "git pack-objects" command, and the
     +    configuration variables meant for the "git repack" command, like
     +    "repack.usedaeltabaseoffset", are ignored.
      
     -    This is because with `git repack`, there are configuration that would
     -    enable different flags to be passed down to `git pack-objects` plumbing.
     +    This patch ensured "git multi-pack-index" checks the configuration
     +    variables used by "git repack" and passes the corresponding options to
     +    the underlying "git pack-objects" command.
      
     -    In this patch, I applies those flags into `git multi-pack-index repack`
     -    so that it respect the `repack.*` config series.
     -
     -    Note:
     -    - `repack.packKeptObjects` will be addressed by Derrick Stolee in
     -    the following patch
     -    - `repack.writeBitmaps` when `--batch-size=0` was NOT adopted here as it
     -    requires `--all` to be passed onto `git pack-objects`, which is very
     -    slow. I think it would be nice to have this in a future patch.
     +    Note that `repack.writeBitmaps` configuration is ignored, as the
     +    pack bitmap facility is useful only with a single packfile.
      
          Signed-off-by: Son Luong Ngoc <sluongng@gmail.com>
      
     @@ midx.c: int midx_repack(struct repository *r, const char *object_dir, size_t bat
       	struct strbuf base_name = STRBUF_INIT;
       	struct multi_pack_index *m = load_multi_pack_index(object_dir, 1);
      +	int delta_base_offset = 1;
     -+	int use_delta_islands;
     ++	int use_delta_islands = 0;
       
       	if (!m)
       		return 0;
 2:  3d7b334f5c6 = 2:  988697dd512 multi-pack-index: respect repack.packKeptObjects=false
 -:  ----------- > 3:  efeb3d7d132 Ensured t5319 follows arith expansion guideline

-- 
gitgitgadget
