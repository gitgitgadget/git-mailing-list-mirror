Return-Path: <SRS0=1y/A=EO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7231C5517A
	for <git@archiver.kernel.org>; Sun,  8 Nov 2020 21:41:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 685D420656
	for <git@archiver.kernel.org>; Sun,  8 Nov 2020 21:41:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sJJTMMf0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728993AbgKHVlm (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 8 Nov 2020 16:41:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728988AbgKHVll (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Nov 2020 16:41:41 -0500
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C62CC0613CF
        for <git@vger.kernel.org>; Sun,  8 Nov 2020 13:41:39 -0800 (PST)
Received: by mail-lj1-x241.google.com with SMTP id y25so6929279lja.9
        for <git@vger.kernel.org>; Sun, 08 Nov 2020 13:41:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aHcsrQOjyxalvTXb9m1BbfDO9M4EesfLZ7DuqUJHTMU=;
        b=sJJTMMf0L0BQcXVyyhC/h13WGT+xkyqSOsxW2xkUl4daeayge703gvIQe8vPNCfAdv
         TmI5cO3lOJVwZukYTiKbj1tuNEg0o3aGvarm3AxD23KC4S27QFnxVm2WkV78YgMfVE2q
         V7sTKCUcSYnL5/u3u2/XBysgZVM9YmKmpfk6Q5/H+zj9DDzF7iLWcgflALO7CiPN2u2+
         G4Fp61Ate0TAS1YaW1KMZMSCamf0GbuZYxGmxmz3463ao9NQK6uaHBPzeaIiljGhEuAB
         T968eKBws5/8/Gf7/24KvwdJbeyKoXRQUu7qiuFNKg9VjVDAsW8LauOfNVOysBCLQ1u3
         KESg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aHcsrQOjyxalvTXb9m1BbfDO9M4EesfLZ7DuqUJHTMU=;
        b=FGdFUYqS3Zj1zN6oZh02zwpMGPdV5OJrzsPcwRP0hTWolgaipRGolYGunn4mDnXeRa
         ktWVJZZjrLGAlfvTF/pkfKRmrSOX2UX3nTrKGJB0KCFM2oB3oHzBtUA0g5qbCyJhL64a
         39BaeNqeM8xukNURnDaaid1QFaPrWq6nYMOExnOtuz31/98u871MtAW0RDoEklrmiJ42
         IGJXPDJlSH68r7uRqaL5X2CUnYHg/JJU505XNep+cSQsqR+fsSVI5FvsWAt1ByKopBXZ
         uqUyix38hd9DcOY4vEp8ShNDhoTE+0SsHOBinxnaRnrTEgpg8c+0mJmUJNetd8OI4WuD
         7pYA==
X-Gm-Message-State: AOAM5327Uqr3YvUaJdOs+DXD4FHeRCKbGZIs1jy4itoUrR4gUz/F0/UC
        u0x0dLWSpTAJEi7PL5FAIAk=
X-Google-Smtp-Source: ABdhPJyqbmDBXL1RB96JRpoPQx4TuAWd2oTk3goRwN8+zewCa0OtCq4/HPMWg/bOu8J1Nyb+dmWNWg==
X-Received: by 2002:a2e:a171:: with SMTP id u17mr4645374ljl.188.1604871697938;
        Sun, 08 Nov 2020 13:41:37 -0800 (PST)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id k21sm1937392ljb.43.2020.11.08.13.41.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2020 13:41:37 -0800 (PST)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Philip Oakley <philipoakley@iee.email>,
        git@vger.kernel.org, Sergey Organov <sorganov@gmail.com>
Subject: [PATCH v1 19/27] diff-merges: get rid of now empty diff_merges_init_revs()
Date:   Mon,  9 Nov 2020 00:38:30 +0300
Message-Id: <20201108213838.4880-20-sorganov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201108213838.4880-1-sorganov@gmail.com>
References: <20201101193330.24775-1-sorganov@gmail.com>
 <20201108213838.4880-1-sorganov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

After getting rid of 'ignore_merges' field, the diff_merges_init_revs()
function became empty. Get rid of it.

Signed-off-by: Sergey Organov <sorganov@gmail.com>
---
 diff-merges.c | 3 ---
 diff-merges.h | 2 --
 revision.c    | 1 -
 3 files changed, 6 deletions(-)

diff --git a/diff-merges.c b/diff-merges.c
index 19cdad1aa4a1..29818abcc00e 100644
--- a/diff-merges.c
+++ b/diff-merges.c
@@ -19,9 +19,6 @@ static void set_dense_combined(struct rev_info *revs) {
  * Public functions. They are in the order they are called.
  */
 
-void diff_merges_init_revs(struct rev_info *revs) {
-}
-
 int diff_merges_parse_opts(struct rev_info *revs, const char **argv) {
 	int argcount;
 	const char *optarg;
diff --git a/diff-merges.h b/diff-merges.h
index ae1cc8ef9410..9c69b8f3bd69 100644
--- a/diff-merges.h
+++ b/diff-merges.h
@@ -3,8 +3,6 @@
 
 struct rev_info;
 
-void diff_merges_init_revs(struct rev_info *revs);
-
 int diff_merges_parse_opts(struct rev_info *revs, const char **argv);
 
 void diff_merges_suppress(struct rev_info *revs);
diff --git a/revision.c b/revision.c
index 5a0e3d6ad542..46645ca0b6df 100644
--- a/revision.c
+++ b/revision.c
@@ -1814,7 +1814,6 @@ void repo_init_revisions(struct repository *r,
 
 	revs->repo = r;
 	revs->abbrev = DEFAULT_ABBREV;
-	diff_merges_init_revs(revs);
 	revs->simplify_history = 1;
 	revs->pruning.repo = r;
 	revs->pruning.flags.recursive = 1;
-- 
2.25.1

