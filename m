Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3F80C433F5
	for <git@archiver.kernel.org>; Tue,  4 Oct 2022 13:26:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230251AbiJDN0k (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Oct 2022 09:26:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230315AbiJDNZn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Oct 2022 09:25:43 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B809FA46C
        for <git@vger.kernel.org>; Tue,  4 Oct 2022 06:24:43 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id bk15so21300070wrb.13
        for <git@vger.kernel.org>; Tue, 04 Oct 2022 06:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r13vzno36kJTvTi7UwPMIkr+evmD1/fo6RlGyjwzASs=;
        b=CuA5/XLrLqBwDxzNdfQtGGhpfCcFZNIQithh6i7cdRVFDHsr9QmPGuiIJi0H9GZWOn
         n0X8XmKpl+DGmbb75YSVzlhnza+XJh6bN28LAC7hvVXis/9PHgwysxeJ3cj2YQgXevag
         RMx4rhzWEwXc8qs4/XidLk74Yl6cSOedFWEjdNyHKpt/Du6Y62TOOyrSZmD0EnfAQak0
         ksbfiTiA04U+pQI63pFyrKkgqWNjXUE9w6rF4Wieqq8iC5JeVVTNRvWCBLWnsyLCbnaq
         kxBHKiu0AdAnc7KKrufTNNxv7znjcZh16N1bqPTSpUCiK3gk7qyvD6kCXAqW3Sduu6Mu
         37eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r13vzno36kJTvTi7UwPMIkr+evmD1/fo6RlGyjwzASs=;
        b=hFLstCO05x69OBQd0+eGNcKymTm3piQM2Tp561WeySJSwaatMxI9O/otW1LojFU/92
         pWOtrKHI1vczO6y1SPeks3SL5Tm1VpcPKYdWDFFWvDdi7v84mSEarmk+mLNJBOCqxOgX
         /46tOQrfYGTSlEJI8Z6s8WyRyhSp2WoyzdIp9WDvP8IyTs/V5eJv9fnzNFGI0hJxqCmk
         4772B33Ofsl5Sb+tRbKv3qJ6UprLx8ccTtf2XOASFi6hJvM2ty6+RTMvNgNxeZllPcOC
         h62eWYVuuY3wRNwuPWu6ZH84q8rzDNUfHKm851JmJgd3bv4y1kkVUpI3VFYzAy65tTvT
         cHzQ==
X-Gm-Message-State: ACrzQf0/d0ErFnFpXxBvvE1EpeInx1yRoDQZ8QmKk/BLXpvVDoIYoUON
        XZUtDA3LaPKHrsSZbbSWr0KoA4jqKDzMng==
X-Google-Smtp-Source: AMsMyM4u83ph97DR5E6OsNd9L0SXQgevP452H5WiK9QWtJdZ4egxYYEuBWkdR2NWr8rUeRw9htI8OA==
X-Received: by 2002:a05:6000:2a3:b0:226:dff3:b031 with SMTP id l3-20020a05600002a300b00226dff3b031mr16341508wry.495.1664889867321;
        Tue, 04 Oct 2022 06:24:27 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id t187-20020a1c46c4000000b003b4a699ce8esm19666022wma.6.2022.10.04.06.24.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Oct 2022 06:24:26 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Victoria Dye <vdye@github.com>,
        Taylor Blau <me@ttaylorr.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        John Cai <johncai86@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 28/34] doc txt & -h consistency: make "diff-tree" consistent
Date:   Tue,  4 Oct 2022 15:23:42 +0200
Message-Id: <patch-v4-28.34-dd7d2f0b167-20221004T132211Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.rc2.935.g6b421ae1592
In-Reply-To: <cover-v4-00.34-00000000000-20221004T132211Z-avarab@gmail.com>
References: <cover-v3-00.36-00000000000-20220930T180414Z-avarab@gmail.com> <cover-v4-00.34-00000000000-20221004T132211Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Make the "diff-tree -h" output consistent with the *.txt version.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/diff-tree.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/builtin/diff-tree.c b/builtin/diff-tree.c
index 23f58702fa0..85e8c81e594 100644
--- a/builtin/diff-tree.c
+++ b/builtin/diff-tree.c
@@ -83,8 +83,9 @@ static int diff_tree_stdin(char *line)
 }
 
 static const char diff_tree_usage[] =
-"git diff-tree [--stdin] [-m] [-c | --cc] [-s] [-v] [--pretty] [-t] [-r] [--root] "
-"[<common-diff-options>] <tree-ish> [<tree-ish>] [<path>...]\n"
+"git diff-tree [--stdin] [-m] [-s] [-v] [--no-commit-id] [--pretty]\n"
+"              [-t] [-r] [-c | --cc] [--combined-all-paths] [--root] [--merge-base]\n"
+"              [<common-diff-options>] <tree-ish> [<tree-ish>] [<path>...]\n"
 "\n"
 "  -r            diff recursively\n"
 "  -c            show combined diff for merge commits\n"
-- 
2.38.0.rc2.935.g6b421ae1592

