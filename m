Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D0E4C54EBD
	for <git@archiver.kernel.org>; Thu, 12 Jan 2023 15:27:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233651AbjALP1p (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Jan 2023 10:27:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240385AbjALP0O (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jan 2023 10:26:14 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31C9A32E81
        for <git@vger.kernel.org>; Thu, 12 Jan 2023 07:19:23 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id cf18so39210816ejb.5
        for <git@vger.kernel.org>; Thu, 12 Jan 2023 07:19:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xcj5E7zQOZxU7olHhV+yi1f87auyKCpthVpK7AQq0vc=;
        b=Jf8/RJ0WRPR6fRAQdcQ7sbEd7BUC31tFdP+/ETqHLfduyi023X+1mC74mitSmcRp7o
         XhsG/gchpkvGg74yYQEYkABKxk7Foe/hzxxWLLs1XsGErpDTsTJU1/GCXnwz11dZn4dI
         1AMeMNRNiJGgxzZLEP4TM2F1ES5tmW1qT2lkjmnv0ZkOSo5XjU9fWnHazQJ1dU84b2m6
         thwa2/otxABuQYNwijabCNDuBx3Sw0Xq6kJUINBSm5nyNmH2QYOJLDkmJs668d5ZnP7M
         DnhhssvEXiA/6PYe3MDU2l/lbXRGEs0Wld9+U2q4W3KO0Sm7cR39YaAnyVl3Jrwg7zW+
         UTOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xcj5E7zQOZxU7olHhV+yi1f87auyKCpthVpK7AQq0vc=;
        b=AOqeiDnZuY6jgMF7X9sL7B7XrFsi8ZaaG/kLlPwDcQ6/c2TXf6fPSrXs2J6cnM71vx
         1w5WNkVsF8FCV7xZDWTjtQmDcEdqWvvD/bWxok7h9LhGlPFY184IgEmW7twRbW5cuP3h
         nizyp3Teb7o11ZFbi5HyaTuBDaQFa0dEVpGDFozDHntgHptQxyBcYer0N1LZ5Vv+9FdT
         1aS0QksJe1sb6AdJLcQn+Rxi4Osha5k6g4dq74yg04+b4no/5CDyg89xsixitM2iTwVv
         Wh7s5GsNUg5Fr0y2fta1YziqKJPt8vNnJKHA0j4taV6O/drwRE9sUZzsQzYm4jDDJFhi
         ZZPg==
X-Gm-Message-State: AFqh2kpPaXe09if354rJUXl7OUwlDvQ1dpLAtqMoKTYpvfTAjF3BZ2b+
        6Kv4JMqqOP+Etxl4WIyS5XGPjG9A9tSO8g==
X-Google-Smtp-Source: AMrXdXvibW6zUXbY9MmJxLAzy48fN3bS/DMha1KdnCd5PGYpVZJFB6pkVo4fxoNBJP3lHvwUV/Cqgw==
X-Received: by 2002:a17:906:338b:b0:84d:3d88:dff3 with SMTP id v11-20020a170906338b00b0084d3d88dff3mr14677359eja.25.1673536761342;
        Thu, 12 Jan 2023 07:19:21 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id kr12-20020a1709079a0c00b0084d44553af9sm5493291ejc.215.2023.01.12.07.19.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jan 2023 07:19:20 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 5/6] bisect: remove Cogito-related code
Date:   Thu, 12 Jan 2023 16:19:13 +0100
Message-Id: <patch-v2-5.6-1600ef41608-20230112T151651Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.0.1215.g1ba3f685d4f
In-Reply-To: <cover-v2-0.6-00000000000-20230112T151651Z-avarab@gmail.com>
References: <cover-0.6-00000000000-20221215T094038Z-avarab@gmail.com> <cover-v2-0.6-00000000000-20230112T151651Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

Once upon a time, there was this idea that Git would not actually be a
single coherent program, but rather a set of low-level programs that
users cobble together via shell scripts, or develop high-level user
interfaces for Git, or both.

Cogito was such a high-level user interface, incidentally implemented
via shell scripts that cobble together Git calls.

It did turn out relatively quickly that Git would much rather provide a
useful high-level user interface itself.

As of April 19th, 2007, Cogito was therefore discontinued (see
https://lore.kernel.org/git/20070419124648.GL4489@pasky.or.cz/).

Nevertheless, for almost 15 years after that announcement, Git carried
special code in `git bisect` to accommodate Cogito.

Since it is beyond doubt that there are no more Cogito users, let's
remove the last remnant of Cogito-accommodating code.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/bisect.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/builtin/bisect.c b/builtin/bisect.c
index 0786ebf4012..73017402671 100644
--- a/builtin/bisect.c
+++ b/builtin/bisect.c
@@ -15,7 +15,6 @@ static GIT_PATH_FUNC(git_path_bisect_expected_rev, "BISECT_EXPECTED_REV")
 static GIT_PATH_FUNC(git_path_bisect_ancestors_ok, "BISECT_ANCESTORS_OK")
 static GIT_PATH_FUNC(git_path_bisect_start, "BISECT_START")
 static GIT_PATH_FUNC(git_path_bisect_log, "BISECT_LOG")
-static GIT_PATH_FUNC(git_path_head_name, "head-name")
 static GIT_PATH_FUNC(git_path_bisect_names, "BISECT_NAMES")
 static GIT_PATH_FUNC(git_path_bisect_first_parent, "BISECT_FIRST_PARENT")
 static GIT_PATH_FUNC(git_path_bisect_run, "BISECT_RUN")
@@ -808,13 +807,6 @@ static enum bisect_error bisect_start(struct bisect_terms *terms, int argc,
 			strbuf_addstr(&start_head, oid_to_hex(&head_oid));
 		} else if (!get_oid(head, &head_oid) &&
 			   skip_prefix(head, "refs/heads/", &head)) {
-			/*
-			 * This error message should only be triggered by
-			 * cogito usage, and cogito users should understand
-			 * it relates to cg-seek.
-			 */
-			if (!is_empty_or_missing_file(git_path_head_name()))
-				return error(_("won't bisect on cg-seek'ed tree"));
 			strbuf_addstr(&start_head, head);
 		} else {
 			return error(_("bad HEAD - strange symbolic ref"));
-- 
2.39.0.1215.g1ba3f685d4f

