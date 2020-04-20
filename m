Return-Path: <SRS0=xG8z=6E=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFD93C3815B
	for <git@archiver.kernel.org>; Mon, 20 Apr 2020 19:54:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB27E206A1
	for <git@archiver.kernel.org>; Mon, 20 Apr 2020 19:54:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iAmMbSS3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726141AbgDTTyk (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Apr 2020 15:54:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725897AbgDTTyk (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 20 Apr 2020 15:54:40 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAC99C061A0C
        for <git@vger.kernel.org>; Mon, 20 Apr 2020 12:54:39 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id q8so8982341eja.2
        for <git@vger.kernel.org>; Mon, 20 Apr 2020 12:54:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=30WsBCD0sAzrIPmvuNiZ2XPxYLrd8zNKds2mKPnKZw8=;
        b=iAmMbSS3alc4YETRTFiTjxE2apvg5eq+FNpvTy/fOJBggQ6QsMeGNShg6i/uSlPY8I
         PoCuIiXJ/SenhUH9i/ilKxuPnEa1DYOK7SvLAv5yS623uSI5lJLQf96MaP7b0sIoSD5X
         XjzGhpk9PNfwRy1z+eOSY2hDU5mINdI76o0skI6pt3T9pRfRsOJlfEgaujlwyPZCQtLN
         w9FyOvHd62WyUog4XhQiMQEV4NaCVQ8QMIteJrUI/fYXUeQSvDbzSflP45PwIvgioL+G
         FxcPsU1d2+fUV6glmd7vg4gPiITKFvPEjVFH+AOugdKOqgjhORJpIJ4Y1Q6EOyDO1nyb
         QRxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=30WsBCD0sAzrIPmvuNiZ2XPxYLrd8zNKds2mKPnKZw8=;
        b=f5A4LaHMt1pmeUecszvK8b/H8khUAnWJTqFFrZaFaZwI/yRn70sDVOP12JDmhMXyPn
         jB6najpQ+3aErZ3m+qDskH3I+0SknG051SwFwxsQUEVoAyMTEf+6c2RA9iG+NK7bvD6p
         bJDIyquWEV5okbaE+601XKv3ucZA0IN6F1VKnfQ4P2yuy0xGhX22XWQ1h0tGuxoVnkja
         EGQC2BxLHgZIUdbU7hCM4LZfkV9hHxE9QWWMXxl8OxecVKRWfEWEjlfgSa+2cOXSHkxn
         1GeQpgRHp6IFicMRy1VA9E08/mC+YxiBJ2LH1cdq7ZKFsSS9YN9n9mBZCRaNoluvrR0G
         wUZA==
X-Gm-Message-State: AGi0PuZ3MMFM2P/uJK/9Mt9brfAn1bKj57xiFUUf5mxKPfCNLe+X29ss
        Ie0xsplG+1CUuu5CO3ICjcX7ZZp8
X-Google-Smtp-Source: APiQypIaKZB7YAVC+Dh3qVvHpPLP8NuJHOJ/avCZbqszvQT0Lys/iVdHyxZloV5Hx/gJdUSCu5f3Hw==
X-Received: by 2002:a17:906:b217:: with SMTP id p23mr17111511ejz.136.1587412478457;
        Mon, 20 Apr 2020 12:54:38 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n26sm45060edo.36.2020.04.20.12.54.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 12:54:38 -0700 (PDT)
Message-Id: <pull.606.git.1587412477.gitgitgadget@gmail.com>
From:   "Hariom Verma via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 20 Apr 2020 19:54:35 +0000
Subject: [PATCH 0/2] [WIP] removed fetch_if_missing global
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Hariom Verma <hariom18599@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We are not much happy with global variable fetch_if_missing. So, in commit
6462d5eb9a ("fetch: remove fetch_if_missing=0", 2019-11-08) Jonathan Tan 
jonathantanmy@google.com [jonathantanmy@google.com] attempted to remove the
need for fetch_if_missing=0 from the fetching mechanism. After that, 
fetch_if_missing is removed from clone and promisor-remote too.

I imitated the same logic to remove fetch_if_missing from fetch-pack & 
index-pack.

I'm looking forward to remove fetch_if_missing from other places too, but I
not sure about how to handle it.

In fsck, fetch_if_missing is set to 0 in the beginning of cmd_fsck().

In rev-list, fetch_if_missing is set to 0 in parse_missing_action_value(),
and in cmd_rev_list() while parsing the command-line parameters.(almost
similar case in pack-objects)

fixes #251

Hariom Verma (2):
  fetch-pack: remove fetch_if_missing=0
  index-pack: remove fetch_if_missing=0

 builtin/fetch-pack.c |  2 --
 builtin/index-pack.c | 11 ++---------
 fetch-pack.c         |  2 +-
 3 files changed, 3 insertions(+), 12 deletions(-)


base-commit: be8661a3286c67a5d4088f4226cbd7f8b76544b0
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-606%2Fharry-hov%2Ffetch-if-missing-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-606/harry-hov/fetch-if-missing-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/606
-- 
gitgitgadget
