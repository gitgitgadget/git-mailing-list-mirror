Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51595C433EF
	for <git@archiver.kernel.org>; Thu, 21 Oct 2021 03:39:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 240A561186
	for <git@archiver.kernel.org>; Thu, 21 Oct 2021 03:39:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230299AbhJUDmC (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Oct 2021 23:42:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230020AbhJUDmB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Oct 2021 23:42:01 -0400
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62C3AC06161C
        for <git@vger.kernel.org>; Wed, 20 Oct 2021 20:39:46 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id k3so24379750ilu.2
        for <git@vger.kernel.org>; Wed, 20 Oct 2021 20:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding;
        bh=aG5SgCr/Rpv0z4ZM54E4ejjXEp2pLai7D0Ay++FS9cs=;
        b=d47ifSPJONC6VjnRMehGo/gTVpwyT0OIrqowZpA2ycsBqd7Io3HuKuUiRwzt9BGuL8
         i2LrU6FsVW+QQSGtzCTQc3resRg1aV24z6A9HpPDgl8dUiQT+3+CzxTz74fwaW43g2iM
         IT0ZMVJyC4xAufe384frdrgUDAQ525w3lkNyokTnwbZzeQh8DT+1jBN3UxxF1NjsXyof
         oMCxvqkoX0rjNZ5PeQptvlgyM41ihHgPNKfn5NG8ew2xOPAS/8WLj9pycdCHMTpjqy/C
         tSg4MEv5FIUCUUfbD3JAoH59DLNi2OZFEQ/lxq/DhFY6/pjdAL6tXvy3lI1oR4C+MAR5
         KHdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding;
        bh=aG5SgCr/Rpv0z4ZM54E4ejjXEp2pLai7D0Ay++FS9cs=;
        b=w5No4nF77QiumLYe3gcx78SRdmwd67ykvYLGkryk6kJY7rn0dbMGTQdkfKEUvT/SiF
         b0kosGw4n5bdILpsEaBgClVw7jYzO9PWQv51Lm82p9nXv+8w0006Evq/oUIYhk3VBFdd
         CRNBT9e0BczTJQqEHJF0pdI3N4b4rjYUo+RdgbBmJ5gfqxgPZvtL14pR7W/lMha1Riqh
         3w2dwXuW1v4RzYQ8jTeVr1iaOlmkYt4EXSiReTbJF7+3DQuwm3mmgsJotPF4W4vTfTLq
         uVFLQCB0oV9ajucLNd5NfAVbCuyYb6yy5sABWAsBShTZ6ckgNnSdL2BPT4AMs+WLETF7
         Jsew==
X-Gm-Message-State: AOAM533pCT2t1MxHg0Il0p7+LzGF4LZiyyCPX6QGnXltpC9T4uzdg+4V
        TuWw1+G2MGqrUiFJwpYovEpaltL+G+iOYw==
X-Google-Smtp-Source: ABdhPJxVBeuvWFHhwAkoY/bcU60gbZI06znQVzoIhbO/RH0nhZ+fz+s2ZnSZbd9zWWZIRsgROK2kkw==
X-Received: by 2002:a05:6e02:5c4:: with SMTP id l4mr2064608ils.56.1634787585539;
        Wed, 20 Oct 2021 20:39:45 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id g13sm1999638ilc.54.2021.10.20.20.39.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Oct 2021 20:39:45 -0700 (PDT)
Date:   Wed, 20 Oct 2021 23:39:44 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     avarab@gmail.com, dstolee@microsoft.com, peff@peff.net
Subject: [PATCH 00/11] midx: clean up t5319 under 'SANITIZE=leak'
Message-ID: <cover.1634787555.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here is a topic that Ævar got me interested when he mentioned that t5319 is
leaky[1].

This is the result of trying to get t5319 to pass when compiling with
SANITIZE=leak. About 50% of the fixes are in the MIDX code, another 40% are in
the pack-bitmap code, and the remaining 10% are sort of random.

I tried to separate these out based on their respective areas. The last 10% are
all from leaking memory in the rev_info structure, which I punted on for now by
just UNLEAK()-ing it. That's all done in the last patch. If we choose to take
that last patch, then t5319 passes even under SANITIZE=leak builds. But it's a
little gross, so I'm happy to leave it out if others would prefer.

This is based on tb/fix-midx-rename-while-mapped, with a back-merge of
js/windows-ci-path-fix in order to appease CI. It also contains a little bit of
overlap with a patch[2] from Ævar in another series, which he and I discovered
independently. I cherry-picked his patch, since I haven't seen much action on
that series lately.

[1]: https://lore.kernel.org/git/87wnmph73b.fsf@evledraar.gmail.com/
[2]: https://lore.kernel.org/git/patch-v3-08.10-e0a3510dd88-20211013T222329Z-avarab@gmail.com/

Taylor Blau (10):
  midx.c: clean up chunkfile after reading the MIDX
  midx.c: don't leak MIDX from verify_midx_file
  t/helper/test-read-midx.c: free MIDX within read_midx_file()
  builtin/pack-objects.c: don't leak memory via arguments
  builtin/repack.c: avoid leaking child arguments
  builtin/multi-pack-index.c: don't leak concatenated options
  pack-bitmap.c: avoid leaking via midx_bitmap_filename()
  pack-bitmap.c: don't leak type-level bitmaps
  pack-bitmap.c: more aggressively free in free_bitmap_index()
  t5319: UNLEAK() the remaining leaks

Ævar Arnfjörð Bjarmason (1):
  pack-bitmap-write.c: don't return without stop_progress()

 builtin/log.c               |  1 +
 builtin/multi-pack-index.c  |  4 ++++
 builtin/pack-objects.c      | 12 ++++++++----
 builtin/repack.c            | 35 ++++++++++++++++++++++++-----------
 builtin/rev-list.c          |  2 ++
 midx.c                      |  7 +++++--
 pack-bitmap-write.c         |  8 +++++---
 pack-bitmap.c               | 18 ++++++++++++++++--
 t/helper/test-read-midx.c   |  3 ++-
 t/t5319-multi-pack-index.sh |  1 +
 10 files changed, 68 insertions(+), 23 deletions(-)

-- 
2.33.0.96.g73915697e6
