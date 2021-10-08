Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 636B8C433EF
	for <git@archiver.kernel.org>; Fri,  8 Oct 2021 19:08:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4435460F6E
	for <git@archiver.kernel.org>; Fri,  8 Oct 2021 19:08:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231245AbhJHTK3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Oct 2021 15:10:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240735AbhJHTJv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Oct 2021 15:09:51 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 051FEC061762
        for <git@vger.kernel.org>; Fri,  8 Oct 2021 12:07:56 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id t8so32840785wri.1
        for <git@vger.kernel.org>; Fri, 08 Oct 2021 12:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=U8dOdTE9nNOYUNqKEZTLE7TmDBsKiaDIsTgRa0y3DOY=;
        b=lcGRT59hAQIi8Glj2Uy+utJkoptV92p2tl8uLUd/uI7lM2CInO4JHCM9zdWpUywuWM
         KK5icKVsZaJJnhVgmwbRulTKOAMPZ6pe3q9UirLStJMMHvCYhw77RZKEqmRfw4jQZUi4
         eguNw+JprPDhCWDBIO0h25Qd6ZLtFfju88Bti5t+PlXC38bDYnibulGizth9LkaF9XqB
         3hbN4weeT0+TA54KKvvw5TftnnR0spNMIpgtbbFE3ZHOX9ad7Z3cusjdikBxh3ja3CDp
         +fpaTfDP5n4MuiMHRNLZ5EXFf+N8YcNjqRcCXrIjo90ObDZUa6xrgB3ggWmO1zoOZ1bq
         xa9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=U8dOdTE9nNOYUNqKEZTLE7TmDBsKiaDIsTgRa0y3DOY=;
        b=3z861aws/w2EAl4z/OA9nTUOYeP7u4tuB4qZ1oCn1Kx1ATkzPZ3cpG2sqfU/QgLTCB
         QMuZgywWr3N7pAXBzxUmdEPJ//fwwAubBrh9KRsOqGMjrgz7lbS2ePuf4MswayZz5eAg
         D7vkvR7LGQ59RR71dcD3K2OwIbxMtkdm4QEFuTiLUYg7qBPo/tHwGjVeVTARX/TDtIiD
         GMITPWr7zgI0Ce0YV1ldCeVm1wKjC7oDc/AddH0CF7SJV2zF/HI2bpSsmCG0X/CubWoR
         y08TvbfvHuP4glH68LowUKwEBAgchv+eaJdVzojrhRcguSeu+pH/bRjbIZks8caCDyzo
         URCA==
X-Gm-Message-State: AOAM53080/5VfYW8EF+dP4YEVtRvTX+XSNgfj+sl15TD68a/Rx6CmIZj
        eSUNazt5TZzdLDPCTABhWmoxGkORigTq1Q==
X-Google-Smtp-Source: ABdhPJxRZgVPQkIS2NpVPAgxVfUy1eHjLINfvDFBuhMYSoR5Uce24fV20VRVaFiIyHtD4XRUSNpbLg==
X-Received: by 2002:a1c:ac03:: with SMTP id v3mr5217558wme.13.1633720074322;
        Fri, 08 Oct 2021 12:07:54 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id x17sm169882wrc.51.2021.10.08.12.07.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Oct 2021 12:07:53 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Thomas Rast <tr@thomasrast.ch>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 07/10] commit-graph: stop using optname()
Date:   Fri,  8 Oct 2021 21:07:43 +0200
Message-Id: <patch-v3-07.10-67a9b38f66c-20211008T190536Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1446.g6af949f83bd
In-Reply-To: <cover-v3-00.10-00000000000-20211008T190536Z-avarab@gmail.com>
References: <cover-v2-00.11-00000000000-20211001T142631Z-avarab@gmail.com> <cover-v3-00.10-00000000000-20211008T190536Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stop using optname() in builtin/commit-graph.c to emit an error with
the --max-new-filters option. This changes code added in 809e0327f57
(builtin/commit-graph.c: introduce '--max-new-filters=<n>',
2020-09-18).

See 9440b831ad5 (parse-options: replace opterror() with optname(),
2018-11-10) for why using optname() like this is considered bad,
i.e. it's assembling human-readable output piecemeal, and the "option
`X'" at the start can't be translated.

It didn't matter in this case, but this code was also buggy in its use
of "opt->flags" to optname(), that function expects flags, but not
*those* flags.

Let's pass "max-new-filters" to the new error because the option name
isn't translatable, and because we can re-use a translation added in
f7e68a08780 (parse-options: check empty value in OPT_INTEGER and
OPT_ABBREV, 2019-05-29).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/commit-graph.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
index 3c3de3a156f..ab8e5cd59af 100644
--- a/builtin/commit-graph.c
+++ b/builtin/commit-graph.c
@@ -172,8 +172,8 @@ static int write_option_max_new_filters(const struct option *opt,
 		const char *s;
 		*to = strtol(arg, (char **)&s, 10);
 		if (*s)
-			return error(_("%s expects a numerical value"),
-				     optname(opt, opt->flags));
+			return error(_("option `%s' expects a numerical value"),
+				     "max-new-filters");
 	}
 	return 0;
 }
-- 
2.33.0.1446.g6af949f83bd

