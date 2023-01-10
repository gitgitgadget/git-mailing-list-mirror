Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CBFBC46467
	for <git@archiver.kernel.org>; Tue, 10 Jan 2023 05:44:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229946AbjAJFoI (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Jan 2023 00:44:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbjAJFn6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Jan 2023 00:43:58 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28CA64086E
        for <git@vger.kernel.org>; Mon,  9 Jan 2023 21:43:54 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id fc4so25754120ejc.12
        for <git@vger.kernel.org>; Mon, 09 Jan 2023 21:43:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qhpPSlZRt+9Dk9IbtAhfUAJEh5ZEsKE012pUm8RaR+4=;
        b=hCmEgwZvWdWJ/quSxgYECFHVmdnYQ99167AOvWV5Uvvn1w6nWye44JCzn6A0Tn5V5v
         mCW4isq+UMlmzNA5TQn+csKcQkU1s0tbBtIKurZGRetCkP7Gdvc1W+OhckiAM1XaeeCo
         /Nj6V75DtXLw6LPeEoexXrBksgOe7X2r+HMxhlxDGxyNGrRGdlGkM7DVt48eAMw8vL0+
         ZHFWk3K6/FG/FhbEG1YdZLlK919ZDmPG3ZQHUh2AWNtrqH4GraZAgQI9mQ8gu+/j4Ok5
         2eQp0qEGuvgsPdRttZWf6JgaP6bOaWpN55WPjDd7mxbNuFDg9tXoodTr/yduRmbWPykX
         lKJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qhpPSlZRt+9Dk9IbtAhfUAJEh5ZEsKE012pUm8RaR+4=;
        b=8LdkyMD90rCHq1CeIwen5Z3iLUZbW9KhzQ1YyDrzW5KrZl9wHjcRvm6Prwrg6n2aUd
         8e5POlkwF2pdHMUIDzK30p8acg1doj6w+NPQDsRE5aDMWAsbPJrBNZBPD5f2UrPTtvcc
         smGItPxiFcnvzqhy3NSFykA+O46qjXNYBb1NWNhZwpT2sOG8jWPOv9SsQ0d0fW+5HgYK
         qNQZIaPu/l2Jpp3t2LmshVOkh3yS6pC9pv7n6l6vKddAYP+eSEtG7E7haITHQvUBY/0n
         KOE7IHrcy8hf9KX0q22+/Gx6IKIilVNlgGYEMlXu4LR8rC6p0L3TXejYYXIf9sTl66lJ
         s2cw==
X-Gm-Message-State: AFqh2koSmnbWrWr9Vecz7Ky68VPnjQQOnzTnhK16dfb0kzIb0l4Rx1em
        2lzbKW6cE5zxiahUewKa360ZNC0ALNhgGg==
X-Google-Smtp-Source: AMrXdXsZNeQivxAHtnp4dj6QOmmHlS2y+djDWlXP8cnVNzkMTq0m/RW7jEeCon2Y4l4BTlGpxBAQ6A==
X-Received: by 2002:a17:906:6d47:b0:7c0:c312:acaa with SMTP id a7-20020a1709066d4700b007c0c312acaamr55552133ejt.49.1673329432351;
        Mon, 09 Jan 2023 21:43:52 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id g21-20020a170906869500b0084d36fd208esm3428423ejx.18.2023.01.09.21.43.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jan 2023 21:43:51 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 02/19] bundle.c: don't leak the "args" in the "struct child_process"
Date:   Tue, 10 Jan 2023 06:43:22 +0100
Message-Id: <patch-v3-02.19-88c6b66be3c-20230110T054138Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.0.1195.gabc92c078c4
In-Reply-To: <cover-v3-00.19-00000000000-20230110T054138Z-avarab@gmail.com>
References: <cover-v2-00.20-00000000000-20221230T020341Z-avarab@gmail.com> <cover-v3-00.19-00000000000-20230110T054138Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix a leak that's been here since 7366096de9d (bundle API: change
"flags" to be "extra_index_pack_args", 2021-09-05), if can't verify
the bundle we didn't call child_process_clear() to clear the "args".

But rather than doing that let's verify the bundle before we start
preparing the process we're going to spawn, if we get an error we
don't need to push anything to the "args".

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 bundle.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/bundle.c b/bundle.c
index 4ef7256aa11..9ebb10a8f72 100644
--- a/bundle.c
+++ b/bundle.c
@@ -627,6 +627,10 @@ int unbundle(struct repository *r, struct bundle_header *header,
 	     enum verify_bundle_flags flags)
 {
 	struct child_process ip = CHILD_PROCESS_INIT;
+
+	if (verify_bundle(r, header, flags))
+		return -1;
+
 	strvec_pushl(&ip.args, "index-pack", "--fix-thin", "--stdin", NULL);
 
 	/* If there is a filter, then we need to create the promisor pack. */
@@ -638,8 +642,6 @@ int unbundle(struct repository *r, struct bundle_header *header,
 		strvec_clear(extra_index_pack_args);
 	}
 
-	if (verify_bundle(r, header, flags))
-		return -1;
 	ip.in = bundle_fd;
 	ip.no_stdout = 1;
 	ip.git_cmd = 1;
-- 
2.39.0.1195.gabc92c078c4

