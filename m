Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1941AECAAD5
	for <git@archiver.kernel.org>; Mon,  5 Sep 2022 08:28:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237715AbiIEI2N (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Sep 2022 04:28:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237648AbiIEI1h (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Sep 2022 04:27:37 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D40C18E0F
        for <git@vger.kernel.org>; Mon,  5 Sep 2022 01:27:12 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id bp20so9807071wrb.9
        for <git@vger.kernel.org>; Mon, 05 Sep 2022 01:27:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=RsdXScGiM2GLyp/nNk5UPFFAJp/4+JAzbRD1r9kfUHU=;
        b=LduyxbmcU3dDHkzzhLPLfm8r03p49wIkH146iO6WMbJMLsFSWhM0DutLKGY99AWQ9w
         FxA7ZoPruFMpzD/pNgmQcYvbs68UcvOOz65WaN158MX3MduJxmZFxaqzjOmocwjFIunj
         WhP31qBknZ39Cp0NhTgDkKXZqm0ArNpZmYmVtcBZF53eXnq2EkI5S6l+ZZz4lUk0IWNS
         RkQ/w+WEB8VIvabrR4ylhqi2NMsvYQB+HoIoDhbqnj0ldG6nKYDdThDMEbRTJsjuiB/X
         qkltS27pDXxMzwca4RKy6+VtkEscbbwxQpPWulefwxeb41ag5mbOd8dQaziCzi4uSpUO
         +AGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=RsdXScGiM2GLyp/nNk5UPFFAJp/4+JAzbRD1r9kfUHU=;
        b=0wAlz5tHU1wK7BpPx/c0OS+RFTYbzQfc99agSHwmaKYl7ATdtM6lZMwtfHLDyc+6Bk
         ygtB6eiyrL69nnp/QvDcYeuVxm0T6/ZHfQ/WH9TJj4Pe8HlrLjmvSEPdJiNK3N3l0BZg
         GB30jz9qzjdyRGt5Do/wqCvA3B1K+qAyNkk49ZH0fk/8KvKXtG6QV5UB13Wl12JuKxy1
         kz3P0PhLa+HI2WaxNu4OQx++Qw26LhYuu9eZaTt3tOYMYrnmNWvOo6YRdJI5qVWWcUyR
         VC/i9XrQ8K0w2RpMceIYagHVuOhfKh21fTW+X3TB2OQvjr3tTy5B11kDbFoPkNX8/cNS
         MtSQ==
X-Gm-Message-State: ACgBeo3qTzGPenyJ2fHKY7R9qWRl/pQkR7EUHwaVSLrwDI3b3qXDTrIU
        lOHYgmOE1BT2SQZinZ/n+2acptcRHv6GTw==
X-Google-Smtp-Source: AA6agR5rs6uYQHMQZ+28Jcrp1E0bTandZ5aVPb1tI8bWBosFoV/j/HJSNI+H42qIjrxFwpyeOVH1ug==
X-Received: by 2002:a05:6000:1d99:b0:228:4727:54cb with SMTP id bk25-20020a0560001d9900b00228472754cbmr7576128wrb.694.1662366430464;
        Mon, 05 Sep 2022 01:27:10 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id i4-20020a05600c354400b003a2f6367049sm10564258wmq.48.2022.09.05.01.27.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Sep 2022 01:27:09 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Victoria Dye <vdye@github.com>,
        Taylor Blau <me@ttaylorr.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        John Cai <johncai86@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 19/34] doc txt & -h consistency: make output order consistent
Date:   Mon,  5 Sep 2022 10:26:30 +0200
Message-Id: <patch-19.34-77cf58aa9c7-20220902T092734Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.3.1425.g73df845bcb2
In-Reply-To: <cover-00.34-00000000000-20220902T092734Z-avarab@gmail.com>
References: <cover-00.34-00000000000-20220902T092734Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix cases where the SYNOPSIS and -h output was presented in a
different order.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/merge-base.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/merge-base.c b/builtin/merge-base.c
index a11f8c6e4bb..6f3941f2a49 100644
--- a/builtin/merge-base.c
+++ b/builtin/merge-base.c
@@ -31,8 +31,8 @@ static int show_merge_base(struct commit **rev, int rev_nr, int show_all)
 static const char * const merge_base_usage[] = {
 	N_("git merge-base [-a | --all] <commit> <commit>..."),
 	N_("git merge-base [-a | --all] --octopus <commit>..."),
-	N_("git merge-base --independent <commit>..."),
 	N_("git merge-base --is-ancestor <commit> <commit>"),
+	N_("git merge-base --independent <commit>..."),
 	N_("git merge-base --fork-point <ref> [<commit>]"),
 	NULL
 };
-- 
2.37.3.1425.g73df845bcb2

