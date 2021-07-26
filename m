Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6C28C432BE
	for <git@archiver.kernel.org>; Mon, 26 Jul 2021 12:46:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 97AF760F45
	for <git@archiver.kernel.org>; Mon, 26 Jul 2021 12:46:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234140AbhGZMGN (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Jul 2021 08:06:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234141AbhGZMFp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Jul 2021 08:05:45 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A0FFC061757
        for <git@vger.kernel.org>; Mon, 26 Jul 2021 05:46:14 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id l18so3258018wrv.5
        for <git@vger.kernel.org>; Mon, 26 Jul 2021 05:46:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IBRe838T933zhrncRvqTV9orWGpI0cUD1bdvXa5s5MY=;
        b=j1+0zHvaiiiZaS0jKIE2QaxA745KpbOajnjL+EGMiABMCi7Zoa0R99yZOsvKQrUwwL
         x+jQYY/KIm5ploqeC7pRvSS3a1idfx6C70KRTo3rwEqIh/YAmOrCU6D8gaOd/rbD3FHa
         fOiywFsN7npYXfSxn3o8envmO8kCTbtcsOZX10m8ImpSGV3VOLlDmQrF0toXAtPg1X3q
         R+X0gvsNuJYMXLjw9OH//9FgC3yAM5wgT+vf7vYSYuaqnysDVG7sXMlZfcxnqqi2iQSn
         3qSCehzMangDI0m2hvhfHHHPK87zxovzka8Id4n8uu5bGCluKYVplLNzQ0jzkVbEIiPW
         fODQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IBRe838T933zhrncRvqTV9orWGpI0cUD1bdvXa5s5MY=;
        b=KU9dALfpNaic0AfauWvoizhQeFaWHtrD4hkNlNlpokmuQ8D8dznSc37taRszjvGxUn
         ly86oJLv77KFq/P/DBZIL/cI6LJuQHm01/B9OiIanu6R6wQ5uB+EDl9yXZRa+vxWaoll
         SKKpPjaErIdQJTCn6jIawYYD3wGQBzeX5S1TvrtHjr5c4+JNNm97sM4n8VGzlCRNsfg1
         yshDAX/t+tnqFrl0djZDTSj+ci3XvOAXEZuSBlQ0J3CqL9Sm5GJaI47tURJaTMo6Y2ri
         J4h5OCBjgafLletBjRhKL5o4/omVlruu218NvfUfXpxQ9hXvQz56aKtubKZqK0p+XMDn
         BIHA==
X-Gm-Message-State: AOAM5309HcR5eDLEBgd03PIFvZrqUwXyEp6O1Vbz59V/CCVHg44J+Lk2
        LyqoTTWJ4qPyCQnuMt0hW0jjYmX1tM0=
X-Google-Smtp-Source: ABdhPJwLuulBm75CnRBW99DBdrWAr9BH2gCVBQPeNQ1L0ieRjLNFpeBbOptKNObd6hp0HkbGcs2oLw==
X-Received: by 2002:a5d:63d1:: with SMTP id c17mr14921062wrw.328.1627303572556;
        Mon, 26 Jul 2021 05:46:12 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id w18sm45155444wrg.68.2021.07.26.05.46.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jul 2021 05:46:12 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 0/5] add --stdin parsing API, use in pack-objects
Date:   Mon, 26 Jul 2021 14:46:05 +0200
Message-Id: <cover-0.5-00000000000-20210726T124425Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.956.g6b0c84ceda8
In-Reply-To: <cover-0.5-00000000000-20210709T105850Z-avarab@gmail.com>
References: <cover-0.5-00000000000-20210709T105850Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A trivial re-roll of v4[1] on top of
gitster/bc/rev-list-without-commit-line, which it had a conflict
with. Also includes the s/int/unsigned int/ fixup that Junio applied
on the v4 he picked up.

https://lore.kernel.org/git/cover-0.5-00000000000-20210709T105850Z-avarab@gmail.com/

Ævar Arnfjörð Bjarmason (5):
  upload-pack: run is_repository_shallow() before setup_revisions()
  revision.h: refactor "disable_stdin" and "read_from_stdin"
  revision.[ch]: add a "handle_stdin_line" API
  pack-objects.c: do stdin parsing via revision.c's API
  pack-objects.c: make use of REV_INFO_STDIN_LINE_PROCESS

 builtin/am.c           |  4 +--
 builtin/blame.c        |  2 +-
 builtin/diff-tree.c    |  2 +-
 builtin/pack-objects.c | 61 +++++++++++++++++++-----------------------
 builtin/rev-list.c     |  2 +-
 revision.c             | 39 ++++++++++++++++++++++-----
 revision.h             | 60 +++++++++++++++++++++++++++++++++++++----
 sequencer.c            |  4 +--
 8 files changed, 121 insertions(+), 53 deletions(-)

Range-diff against v4:
1:  f2cc9695306 = 1:  b0c7ec31ca9 upload-pack: run is_repository_shallow() before setup_revisions()
2:  50c3b81820b ! 2:  4e5e6620245 revision.h: refactor "disable_stdin" and "read_from_stdin"
    @@ revision.h: struct rev_info {
     +	 * option?
      	 */
     -	int read_from_stdin;
    -+	int consumed_stdin:1;
    ++	unsigned int consumed_stdin:1;
      
      	/* topo-sort */
      	enum rev_sort_order sort_order;
     @@ revision.h: struct rev_info {
    - 			date_mode_explicit:1,
      			preserve_subject:1,
    - 			encode_email_headers:1;
    + 			encode_email_headers:1,
    + 			include_header:1;
     -	unsigned int	disable_stdin:1;
    ++
      	/* --show-linear-break */
      	unsigned int	track_linear:1,
      			track_first_time:1,
3:  0339af8c39a ! 3:  e3d24bd6e8a revision.[ch]: add a "handle_stdin_line" API
    @@ revision.h: struct rev_info {
      
     @@ revision.h: struct rev_info {
      	 */
    - 	int consumed_stdin:1;
    + 	unsigned int consumed_stdin:1;
      
     +	/*
     +	 * When reading from stdin (see "stdin_handling" above) define
4:  d8080b7fd9c = 4:  4787490a90f pack-objects.c: do stdin parsing via revision.c's API
5:  32a172aa80a = 5:  a8b0976649a pack-objects.c: make use of REV_INFO_STDIN_LINE_PROCESS
-- 
2.32.0.956.g6b0c84ceda8

