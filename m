Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04063C4332F
	for <git@archiver.kernel.org>; Thu, 15 Dec 2022 09:49:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230206AbiLOJtV (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Dec 2022 04:49:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230036AbiLOJsY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Dec 2022 04:48:24 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6455654346
        for <git@vger.kernel.org>; Thu, 15 Dec 2022 01:47:59 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id c66so26251441edf.5
        for <git@vger.kernel.org>; Thu, 15 Dec 2022 01:47:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GHoa6tQ9uSFmkPS8uvYT2dfq6EvyqyL5umDCDYl2POU=;
        b=UhYlWAUtX6prQhdfIBmBZPoxZtP2R6MOL3zU9sF8vclNHqadBRHjCjB4vEpgfwl/70
         cupWzLE0FxVwFut+RCpFVfy9d6UrJ7pnAe9089Rza78uot/b1/2hTmhCBtimAfWlWaDD
         f7YWG3wFv9vNSwImm5pIxhBg9znCkExvpIlR7Te6Dj2F9ObGNgvpLt5yUAhI4eZOr2RP
         EPK4SCcNU/t4YSEf9GE1GKo8MYBxMcppKlNUAIjkA59NJjq/QYqurZ17gfXBcktmNBLu
         +BgL+F7cDeNXMs6iKhmycpoYQfUB+aShJ8gib0fsg/GX+4hlsWlRMPXP/LCQzlsyDRVl
         J2kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GHoa6tQ9uSFmkPS8uvYT2dfq6EvyqyL5umDCDYl2POU=;
        b=asBaFihRPV0Canl4N9w4Rbn7FyE6IekYcuUEspQVCjlUzEYEzOZhVuYAvX2KkQ6p7d
         fx2DEKBqW1O20SyFva36E/yZkppATFDOFDeTutlD1TcsXxAF2W354vWdjbm1buvotsM9
         UwyS0odqDWvo2b+46Q+derE235gCs/SV4ehdZHUNWWrRggV+pTWMnucetZlAq7gw82yl
         72USymv6S3sBmYTYgJVkO0KDnEDHO1LjLV4P3spVJha3iCD+G/zC1X7gIoTdahtDY6wY
         kl4+sFSrY0yYKm+L3B2CKf2Y16jIt4WbnkSqyk7cV/aZFFPjjZZB2Gr9UdoySpYrjAhV
         DigQ==
X-Gm-Message-State: ANoB5pnyihT/Vb5ohRsoxwLhCiIMGgyzb1QHEKm6iTpjo54E1+Ogl4Ci
        dib2APxbYafbeHsd86T9BdHxSSeQvt3lAA==
X-Google-Smtp-Source: AA0mqf4vO1Y5vld6dJDSTRPJnEp00aYyMa7X7x2vUm9/8rIBsj1QPFQ++mjRCY2jl+FQbFJ9VX2Sfg==
X-Received: by 2002:aa7:cb4d:0:b0:46c:7035:2f6d with SMTP id w13-20020aa7cb4d000000b0046c70352f6dmr25032407edt.38.1671097677336;
        Thu, 15 Dec 2022 01:47:57 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id i15-20020a50fd0f000000b0046b4e0fae75sm7189155eds.40.2022.12.15.01.47.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Dec 2022 01:47:56 -0800 (PST)
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
Subject: [PATCH 5/6] bisect: remove Cogito-related code
Date:   Thu, 15 Dec 2022 10:47:48 +0100
Message-Id: <patch-5.6-1b70cd79cae-20221215T094038Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.0.rc2.1048.g0e5493b8d5b
In-Reply-To: <cover-0.6-00000000000-20221215T094038Z-avarab@gmail.com>
References: <cover-0.6-00000000000-20221215T094038Z-avarab@gmail.com>
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
2.39.0.rc2.1048.g0e5493b8d5b

