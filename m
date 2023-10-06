Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFA9CE94134
	for <git@archiver.kernel.org>; Fri,  6 Oct 2023 22:01:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233397AbjJFWBv (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Oct 2023 18:01:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233248AbjJFWBu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Oct 2023 18:01:50 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E44C8BD
        for <git@vger.kernel.org>; Fri,  6 Oct 2023 15:01:48 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id af79cd13be357-776f84c6cc7so66319885a.2
        for <git@vger.kernel.org>; Fri, 06 Oct 2023 15:01:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1696629708; x=1697234508; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9OD7IFcUB2zj1tB8vAzCkpHwOQ3WEtGWMMjfWW6VvUo=;
        b=Wv2b0NZwfD9wUkV5gGjDdrW9/kZNTQka8MMo7WaqPHMLgGzVgVGjRbwKYvfA8dMDUt
         HH50+ZFRXxa4RZpdgd1FufCN1C5RrQbZ/9DqPvEYM1hgpV5pR/kDbppRcSbHd3gjPWQ3
         1EPhi5iF141wOXWIysOI/fiuIOfM0JQDGISgIFvq0aiRKAPWczSiBkJBBo+NiJXKPUuv
         8JePmZXdVxtfxv9sGeLycd67Mv5q2Ql86BoEntjcOK3pYPH1erI9oV/rKxFfbo1Os79K
         TjFPMpQ+xIlrnWIlFHRJ/U/yVMOHTnGbNWUStnvwW/IKjLF3gCfzCaEpB4AnzPTyfNJ3
         ZL8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696629708; x=1697234508;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9OD7IFcUB2zj1tB8vAzCkpHwOQ3WEtGWMMjfWW6VvUo=;
        b=pi/UEG9GVP+6Nqdzfnj8DoKOvVUp4uvDaZk3Fb+fXQkdAEKyOXWdKjPZDQoyK+XNUi
         /cqS0kbBJCwUEcR/+L83YBJs4Gq+BjCJHAyplX9PJ2/YMLztvIdxtwe6lv0LVDP8L6SE
         DxWjSmuofYlAuvPSfax9ZmrT7ZZQ3kB3fXhD64zIol7Nc1vVl6ft6aFbE/aNBoM4+Oh8
         y/anlNTfP/so3RJRgKApsh5VoZIZkExJyNMFgH4IoUPJ1GbMDXQE6g6wTLyU9z0KP+n8
         X9bXLu7kOOGDLeNdAwmLTAlsd4p5noUPf8KKO5XeI9Bcl8fiG1QIeUQ5VKcOuNWv1IJI
         DQnw==
X-Gm-Message-State: AOJu0Yy8K9GeZw8EOPNnzdUVsdn56S+xlygwZ6n1bdJpKttN0fFeHm7p
        38ZA10raQhc9f+wiC0nlKtgZGrRhaNp52atMJv605Q==
X-Google-Smtp-Source: AGHT+IFwGpoUhcvwpEcBRhJTPRJl5BZmgqTDgVOPjzY/OVj3By+nT5yvpXtAjLFfOaVLoGFLinx/CA==
X-Received: by 2002:a05:620a:4402:b0:76e:ef9e:9e59 with SMTP id v2-20020a05620a440200b0076eef9e9e59mr13082586qkp.4.1696629707857;
        Fri, 06 Oct 2023 15:01:47 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id k27-20020a05620a143b00b007742c6823a3sm1606351qkj.108.2023.10.06.15.01.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Oct 2023 15:01:47 -0700 (PDT)
Date:   Fri, 6 Oct 2023 18:01:39 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>,
        "Eric W. Biederman" <ebiederm@gmail.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 0/7] merge-ort: implement support for packing objects together
Message-ID: <cover.1696629697.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

(Based on the tip of 'eb/limit-bulk-checkin-to-blobs'.)

This series implements support for a new merge-tree option,
`--write-pack`, which causes any newly-written objects to be packed
together instead of being stored individually as loose.

The motivating use-case behind these changes is to better support
repositories who invoke merge-tree frequently, generating a potentially
large number of loose objects, resulting in a possible adverse effect on
performance.

The majority of the changes here are preparatory to refactor common
routines out of the bulk-checkin machinery to prepare for indexing
different types of objects whose contents can be held in-core.

Also worth noting is the relative ease this series can be adapted to
support the $NEW_HASH interop work in 'eb/hash-transition-rfc'. For more
details on the relatively small number of changes necessary to make that
work, see the log message of the second-to-last patch.

Thanks in advance for your review!

Taylor Blau (7):
  bulk-checkin: factor out `format_object_header_hash()`
  bulk-checkin: factor out `prepare_checkpoint()`
  bulk-checkin: factor out `truncate_checkpoint()`
  bulk-checkin: factor our `finalize_checkpoint()`
  bulk-checkin: introduce `index_blob_bulk_checkin_incore()`
  bulk-checkin: introduce `index_tree_bulk_checkin_incore()`
  builtin/merge-tree.c: implement support for `--write-pack`

 Documentation/git-merge-tree.txt |   4 +
 builtin/merge-tree.c             |   5 +
 bulk-checkin.c                   | 249 ++++++++++++++++++++++++++-----
 bulk-checkin.h                   |   8 +
 merge-ort.c                      |  43 ++++--
 merge-recursive.h                |   1 +
 t/t4301-merge-tree-write-tree.sh |  93 ++++++++++++
 7 files changed, 355 insertions(+), 48 deletions(-)

-- 
2.42.0.8.g7a7e1e881e.dirty
