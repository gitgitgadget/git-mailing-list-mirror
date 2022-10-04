Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38F14C433FE
	for <git@archiver.kernel.org>; Tue,  4 Oct 2022 13:24:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230311AbiJDNYh (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Oct 2022 09:24:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230226AbiJDNYR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Oct 2022 09:24:17 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2392453030
        for <git@vger.kernel.org>; Tue,  4 Oct 2022 06:24:06 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id a3so9040823wrt.0
        for <git@vger.kernel.org>; Tue, 04 Oct 2022 06:24:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MI8cyFoQ3UD0aw7rYQYB+Vtav/uiv1hAE+/X9c4buR0=;
        b=fX1XgTgsSIrsMf1iW6/nBVZGcQm9Ny+8Bvosn2fW4xGvPNUAwKBbolis7FadxcA8Uv
         3+tRIaFfskmwYo5CRYAJYFr1RcttVoWA9tL2OzlBY9dXDeK/DCq+t4hf5FhDbCnv0e60
         RSuIQo2JncfCBn8J+kNM0VdWih8+cXmH2w20g3CTH8ae1LE3HFWoxKml3KkejjxxLTAu
         mgcl5Us9vA7GYFLMECADIpF7sHQWXbv+3DpfgjfSB0nJ08kDfHJsOpMGFPOV+eyCta2r
         6kW+HdxhS7+fShklng/bpEBvchOvnw/JfIjKJwfeqU7zXgrVGtgjBwQTBq55AZk2/Nxj
         3uXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MI8cyFoQ3UD0aw7rYQYB+Vtav/uiv1hAE+/X9c4buR0=;
        b=Clt2o/ltrTlY8IubMSLmMptY6y0f5m48NXpxKkYpuO8t4bZTdc+1Zoz+6K1UCYoPo+
         +z6sLj0Kr/eUz1+v4IRV4LaEcbEMTPy+EyLhWSM+DOH8+3lqHbMpojl7+vRnynrmNB7h
         xscOicmxT/cV7KFLyKEUPSJ7xryKv3AimYXUJGOMv48uUo9cXiKspyzwVA0v1c2Vj97d
         wTBKqroqGbT7jxL0m9grlERhnK9cPQrgw/VWa1rjLPXLXarhPzf26P6KqgK7tkcvs2Cc
         y7glQjcflkQ0PQCnUp5X5zu6xO/lofj3ksNJpUjER9hAoXjajGuKy7ncH4cEcsF6dH5S
         lWnw==
X-Gm-Message-State: ACrzQf3mb381Ki7U6b3tQJ5EAlIq0ipAmehmVmjFqTpdHEEqPoUdTIaJ
        mmhmZmrqkTKbfFIs0KcMgrVR/rQW6qvytQ==
X-Google-Smtp-Source: AMsMyM5sG6r9iXlwHlD4Em9cJGeWu03cie1LJ/385DMROKyKQgFWULt9OiLdRGjOIvxyKan03Hd23w==
X-Received: by 2002:adf:ec4d:0:b0:22e:3211:483a with SMTP id w13-20020adfec4d000000b0022e3211483amr9346798wrn.295.1664889844004;
        Tue, 04 Oct 2022 06:24:04 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id t187-20020a1c46c4000000b003b4a699ce8esm19666022wma.6.2022.10.04.06.24.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Oct 2022 06:24:03 -0700 (PDT)
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
Subject: [PATCH v4 10/34] doc txt & -h consistency: add "-z" to cat-file "-h"
Date:   Tue,  4 Oct 2022 15:23:24 +0200
Message-Id: <patch-v4-10.34-0e955f294cd-20221004T132211Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.rc2.935.g6b421ae1592
In-Reply-To: <cover-v4-00.34-00000000000-20221004T132211Z-avarab@gmail.com>
References: <cover-v3-00.36-00000000000-20220930T180414Z-avarab@gmail.com> <cover-v4-00.34-00000000000-20221004T132211Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix a bug in db9d67f2e9c (builtin/cat-file.c: support NUL-delimited
input with `-z`, 2022-07-22), before that change the SYNOPSIS and "-h"
output were the same, but not afterwards.

That change followed a similar earlier divergence in
473fa2df08d (Documentation: add --batch-command to cat-file synopsis,
2022-04-07). Subsequent commits will fix this sort of thing more
systematically, but let's fix this one as a one-off.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/cat-file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 989eee0bb4c..fa7bd891692 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -893,7 +893,7 @@ int cmd_cat_file(int argc, const char **argv, const char *prefix)
 		N_("git cat-file (-t | -s) [--allow-unknown-type] <object>"),
 		N_("git cat-file (--batch | --batch-check | --batch-command) [--batch-all-objects]\n"
 		   "             [--buffer] [--follow-symlinks] [--unordered]\n"
-		   "             [--textconv | --filters]"),
+		   "             [--textconv | --filters] [-z]"),
 		N_("git cat-file (--textconv | --filters)\n"
 		   "             [<rev>:<path|tree-ish> | --path=<path|tree-ish> <rev>]"),
 		NULL
-- 
2.38.0.rc2.935.g6b421ae1592

