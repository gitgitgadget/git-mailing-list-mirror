Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 260CAC433F5
	for <git@archiver.kernel.org>; Tue,  4 Oct 2022 13:26:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230226AbiJDN0Q (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Oct 2022 09:26:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230358AbiJDNZA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Oct 2022 09:25:00 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 800C154C91
        for <git@vger.kernel.org>; Tue,  4 Oct 2022 06:24:29 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id b4so14351700wrs.1
        for <git@vger.kernel.org>; Tue, 04 Oct 2022 06:24:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i210SOhaDvWGHMShiJSBmj6ZM/qSrNmLAX5e/fE427k=;
        b=nlwrJQx5t7l6lXOuzIzxkJ/280cgYFMnI2iBBNtIW7b88A9rq8BcHhkvFWjUWkVxpw
         HS0KpmdyKCxvCC6lrrmu/lq6pnnVPqZFm1ZL0zZJZrEY0qTXQQZK2n1ATlWdqi6LnLz7
         Cb1qqlhSN5jHsQbFbKpC6BSccrL+rRDzHYlWF3oDN/gB9zdF+Psnyd9MRk5b+E7tiSPG
         PWabMKlJ1ujPBgGdrGdRQu4A+eHi6qI3E6QOxPTvtnUlN7gJ8f684d/CwxpM2FzFd1cz
         QkCNV++1HWV9Kw8sNYkD15AUbnkw5v9Waye2v72JoIL8KrIkxpI7x8ERjxy9/rXZXP3m
         xfqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i210SOhaDvWGHMShiJSBmj6ZM/qSrNmLAX5e/fE427k=;
        b=THRVXSABKnEW6DtP4+3+b+cNDy4BGVqSDa5J4XDRDT5EnxtG8mkUxo/S4G+g5raexT
         +z0HVL8FU+AEzEQZ81Mc6ToPa/hEHiq70wb4STro+OP5G3NsGuauNBZs5za5O0+SrAMY
         p6EUMh22SuaeN2iRM3nBvqsuyQBC06Me9qpyNiFTMKYvEjHBIWd9uyMrEvDvq/peEFS3
         9WJ8+eDL1UPXzTJXi40Q79WgpEE30F3BlD/bw7sLMP6P789g9cc6H89LJUYE+GJjbuHj
         XyWTsfyKbhw+qui4VRP4lGBjxmgS7Icep2OxuqKHwWfgxx6nQK1H2rmF4Oehfl9TiHNA
         ZoHg==
X-Gm-Message-State: ACrzQf2w1G7n49/wQpTutOihUV0nfatJJ+vd6uqvwf8fChcTmeY9GGxK
        pmqqPufV/7T+nvqroQeslKeJMEfFB3kFyw==
X-Google-Smtp-Source: AMsMyM4ikfpg1Hxx3ImwRAsUacherBuLHVD8H4PDZN6CY84NagxNtEhF9S+wg3CoghdSpRllD6jzZw==
X-Received: by 2002:a05:6000:1a8d:b0:22a:44e9:831e with SMTP id f13-20020a0560001a8d00b0022a44e9831emr16787384wry.575.1664889868487;
        Tue, 04 Oct 2022 06:24:28 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id t187-20020a1c46c4000000b003b4a699ce8esm19666022wma.6.2022.10.04.06.24.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Oct 2022 06:24:27 -0700 (PDT)
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
Subject: [PATCH v4 29/34] doc txt & -h consistency: make "commit" consistent
Date:   Tue,  4 Oct 2022 15:23:43 +0200
Message-Id: <patch-v4-29.34-3c8154151f3-20221004T132211Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.rc2.935.g6b421ae1592
In-Reply-To: <cover-v4-00.34-00000000000-20221004T132211Z-avarab@gmail.com>
References: <cover-v3-00.36-00000000000-20220930T180414Z-avarab@gmail.com> <cover-v4-00.34-00000000000-20221004T132211Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Make the "-h" output of "git commit" consistent with the *.txt version
by exhaustively listing the options that it takes.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/commit.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 21ad4ccbf87..64f420bcbf6 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -40,7 +40,14 @@
 #include "pretty.h"
 
 static const char * const builtin_commit_usage[] = {
-	N_("git commit [<options>] [--] <pathspec>..."),
+	N_("git commit [-a | --interactive | --patch] [-s] [-v] [-u<mode>] [--amend]\n"
+	   "           [--dry-run] [(-c | -C | --squash) <commit> | --fixup [(amend|reword):]<commit>)]\n"
+	   "           [-F <file> | -m <msg>] [--reset-author] [--allow-empty]\n"
+	   "           [--allow-empty-message] [--no-verify] [-e] [--author=<author>]\n"
+	   "           [--date=<date>] [--cleanup=<mode>] [--[no-]status]\n"
+	   "           [-i | -o] [--pathspec-from-file=<file> [--pathspec-file-nul]]\n"
+	   "           [(--trailer <token>[(=|:)<value>])...] [-S[<keyid>]]\n"
+	   "           [--] [<pathspec>...]"),
 	NULL
 };
 
-- 
2.38.0.rc2.935.g6b421ae1592

