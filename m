Return-Path: <SRS0=FGj8=74=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29A05C433DF
	for <git@archiver.kernel.org>; Mon, 15 Jun 2020 11:53:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF71C20707
	for <git@archiver.kernel.org>; Mon, 15 Jun 2020 11:53:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BPquSzZN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729663AbgFOLxa (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Jun 2020 07:53:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728285AbgFOLx3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Jun 2020 07:53:29 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C3FEC061A0E
        for <git@vger.kernel.org>; Mon, 15 Jun 2020 04:53:29 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id c14so15316750qka.11
        for <git@vger.kernel.org>; Mon, 15 Jun 2020 04:53:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nogi5JCohjSdOjXPdovFfv35FLQhk4cco33IDbqgadQ=;
        b=BPquSzZN1PnTbyiJbRBk9tasQF9EEw1QSIWH+ZJZYzpnZYXsOaRwO71QoZfVmLiJ4R
         m7vTjlz2NpfWo4eMSEgBsnnvPaLc71wUDOq0hjd2lzUS1QB7j5ff84L1xoGgYRja3lBh
         +78KkHnZrnixTZPg0x5/bvygMswyJ07caQJ7oX9J4IrvkpIgom88S/e0pooXiQRgRcnv
         XciKqBJH8gaNtxN/PK831N2DZtSnQkfq+oIBjRMeSSxhtX44vkYC800FuqMbhPc5YQfL
         OKi8tIRRehD9lBHgGUPhrcbUe7oocYBi2YMcaMzwaQIeqzoHOj7p4a4D9iwqg6SZKTsU
         XiYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nogi5JCohjSdOjXPdovFfv35FLQhk4cco33IDbqgadQ=;
        b=OcBdyFWdYaOPrwIiw+QRb2CHqImM5npzk6hRvX+P/gXrGKgpDSnWaVnyiPUQAyap30
         Bptq+8KRxc6h2l9cjOaObGZIp7bAL+bVUW58GlwluBD5gzl3FB5DoK35CB1NRaU6omSO
         IN+uwbmFG2TRBn4IpcfxRmYvxAfk/0hS8DKFs+KkI6X6k5NbTz+b9oKuUwiM4ADaINwt
         qlSHpAMyh5rXXAbXvSdPEMPfasIWRhdJrh+9IKStIl5QcDvso8uAP5925JclqlzbtRk8
         QMH/K32jf0W/bUVUpkCT3htRJxJjzJewjiYqrezFq2EHjPum39ZUawAYPC8G9Jm1fvf5
         +5Tg==
X-Gm-Message-State: AOAM531P6XYsKepNagJxiVpJeRU5QK0kfJxqcg1UaermJ7C2E4Rh+uma
        YIJFUIhT0F6XEZPN1PgyU1YJZCP3n30=
X-Google-Smtp-Source: ABdhPJxJJKJKZwESZNGvhgPIL3YW5WIJTYi1By8Ez2HNFu5a1W+/4YksVJzIzjKWktppCai8eM9Kbg==
X-Received: by 2002:a37:4682:: with SMTP id t124mr15489097qka.378.1592222007980;
        Mon, 15 Jun 2020 04:53:27 -0700 (PDT)
Received: from archbookpro.localdomain (CPE18593399858a-CM185933998587.cpe.net.cable.rogers.com. [174.112.65.113])
        by smtp.gmail.com with ESMTPSA id f43sm12543781qte.58.2020.06.15.04.53.26
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2020 04:53:26 -0700 (PDT)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Subject: [PATCH 0/3] branch and t3200 cleanup
Date:   Mon, 15 Jun 2020 07:53:17 -0400
Message-Id: <cover.1592221875.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.27.0.132.g321788e831
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I was looking through some old patches that I had sitting around. In one
set of these, I implemented `git branch --set-remote-to` but I
ultimately decided that the idea was stupid. However, these patches are
salvageable so I'll send them in.

Denton Liu (3):
  t3200: rename "expected" to "expect"
  t3200: test for specific errors
  branch: don't mix --edit-description

 builtin/branch.c  |  2 +-
 t/t3200-branch.sh | 67 ++++++++++++++++++++++++++++++-----------------
 2 files changed, 44 insertions(+), 25 deletions(-)

-- 
2.27.0.132.g321788e831

