Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A161DC433F5
	for <git@archiver.kernel.org>; Fri, 20 May 2022 19:01:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346113AbiETTBs (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 May 2022 15:01:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236624AbiETTBq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 May 2022 15:01:46 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B79C140861
        for <git@vger.kernel.org>; Fri, 20 May 2022 12:01:45 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id 11so5549594qtp.9
        for <git@vger.kernel.org>; Fri, 20 May 2022 12:01:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=EObPkzA6cK/ajNaNGQiQxHDaDELO4yuvO4mQCyn3yY0=;
        b=q4ysbx5TEom1YShGnab0/f+KWGlUWCR1NYYM2rGfhnZS3m2zidODRS7DQQQ5j9MOz2
         Azt7fBA2CafPbEeTxnzPOdu9o5FjiwOQZlgWQlt7GZvyWIUMX6D6m5rCh4AurXPX5Owa
         XEUdeaDIczcVtap5isSPzRzeRSufdbe9aHtD7LFkljy1F0JDH4YuXyUbZbg/6/K25UpT
         4c2wEE2T2k6nhfBgAmWqk7A7HhrGHnumSBt50BAWSD09TYl+VFQ0fbivg3eut2uBJQrs
         BgowW6x4LFsD+mTJPesEquaK3SltGeamtweh+H8sXFDjJC4qjdAD9j430kOQfJaAlmlJ
         RSaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=EObPkzA6cK/ajNaNGQiQxHDaDELO4yuvO4mQCyn3yY0=;
        b=7l7vLbm/HvR313jzN6+xRgZcJjrWYCkqO4aAKDd4aoBORn6w6sGX2zJ7YCCEy+YgBI
         wYpKlr7yBRrVLJwuZFHo8bIjTMfmhlBOabX/yEYZWBXvOFmjOoiPX3y71IdeK24MpVnu
         +9ds4eljX91mIyXPr+b/UnWaX+OxNzdyK2IGHDQy4QNHCHkI8h+jOu3cdzgqnvfnTroy
         nacJoN5cZRCRHxaYhS1HzjeIHQMZ0qTFWY6Bb5p8u+F8Q+kyGCpym6VKIhnI+Q038ehm
         9NjabszoOtonVjOw6yARulR7pbyU6TSkfuDdDw5OPxUjLbdt6DbCHf8eXdGG2YfK8q70
         hXfQ==
X-Gm-Message-State: AOAM5325pmbUK+VhBq1YkA6+CaTlC4w+ogxemJofXTrAQyNbarEweVkH
        JmM9XKD9t2/UpLj/25F4JtNlmsgLszsNskHx
X-Google-Smtp-Source: ABdhPJzP9bqUvXfSQ/vLbrl0UBiVaOcOjB/Wa+9zTa+0LsBVoDeVo8WbnxVWPd7vjwdt3MrpUhuMdg==
X-Received: by 2002:a05:622a:1753:b0:2f3:cb4f:e58d with SMTP id l19-20020a05622a175300b002f3cb4fe58dmr8980810qtk.603.1653073303919;
        Fri, 20 May 2022 12:01:43 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id ew6-20020a05622a514600b002f39b99f69esm156177qtb.56.2022.05.20.12.01.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 May 2022 12:01:43 -0700 (PDT)
Date:   Fri, 20 May 2022 15:01:41 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     vdye@github.com, gitster@pobox.com
Subject: [PATCH 0/3] repack: handle --keep-pack, --max-pack-size for
 geometric repacks
Message-ID: <cover.1653073280.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series fixes two issues that Victoria and I noticed while working on an
unrelated issue yesterday.

  - The first patch comes from Victoria's earlier submission[1], and addresses
    an issue where packs specified as kept via the `--keep-pack` option could
    potentially be removed (without rewriting their objects) during a
    `--geometric` repack.

    The first patch is Victoria's alone, with some minor fixups applied from my
    review in [2]. It's included in this series since it's related, and avoids
    any conflicts when merging.

  - The latter two patches are mine, and address an issue where specifying a
    `--max-pack-size` value during a `--geometric` repack could result in object
    loss because of a false positive in our "did we write a pack with this
    name?" check (which can occur when the list of packs we wrote isn't sorted).

    The first of these two patches demonstrates the issue (done in a separate
    patch, since the scenario is quite involved), and the second patch fixes the
    bug.

Thanks in advance for your review.

[1]: https://lore.kernel.org/git/pull.1235.git.1653064572170.gitgitgadget@gmail.com/
[2]: https://lore.kernel.org/git/YofJLv8+x5J7yPmf@nand.local/

Taylor Blau (2):
  t7703: demonstrate object corruption with pack.packSizeLimit
  builtin/repack.c: ensure that `names` is sorted

Victoria Dye (1):
  repack: respect --keep-pack with geometric repack

 builtin/repack.c            | 49 ++++++++++++++++++------
 t/t7703-repack-geometric.sh | 75 +++++++++++++++++++++++++++++++++++++
 2 files changed, 112 insertions(+), 12 deletions(-)

-- 
2.36.1.94.gb0d54bedca
