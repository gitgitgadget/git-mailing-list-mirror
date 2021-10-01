Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46A53C4332F
	for <git@archiver.kernel.org>; Fri,  1 Oct 2021 14:29:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 307AF61A3A
	for <git@archiver.kernel.org>; Fri,  1 Oct 2021 14:29:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354546AbhJAObS (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Oct 2021 10:31:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354530AbhJAObO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Oct 2021 10:31:14 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E454C06177E
        for <git@vger.kernel.org>; Fri,  1 Oct 2021 07:29:29 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id s24so7374990wmh.4
        for <git@vger.kernel.org>; Fri, 01 Oct 2021 07:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lHY5PtXvHtbXEolf7Y6c6ISS7WXIbrQnH4QNAbaWY7E=;
        b=ofokyW5AXwU65EtWclYUyb6CyfNPq7zgAdrj3OP9U/tY5UFbzf2pkCMNTQ+451w0Z/
         mhV0vligFNppxTrd0TZsIdWOizzWFYjSNPFQtJm/up/ILgFu6YG2X0OLiaGtNn1z4Atk
         kurKDinoLQRBcI3dpnQT6FpVXzdSgGJB8baORVOLZ4T6JWQYmcM56al475yfAWhspYwt
         jrfuaXCI+JpMlG2KbAvWJS93ZKcIji4fUvVyZG7iBeWUXmm1CEH9DDi5DRriEH431/bZ
         DVafqdoOuFbQrjVYwveay4dMxR3jgyhRBjUD2IKNBOTjLVtPIhrqGECqUD8/BDe0JRP+
         2k8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lHY5PtXvHtbXEolf7Y6c6ISS7WXIbrQnH4QNAbaWY7E=;
        b=IxYLQJOxxxMMyTsqfZN1lq76+NuQId3In9NycEp/aCggs9vpPr5qK0LZdkiRNftnXk
         8TBwfAfH4kbik90oS1NKoZximBHjgXNBnW7qt7+As7CZBu7Ma3eEeX2PCsh1HPCbTt6f
         429PBt7KlXKYAO+JKqfxl462tdmaS5VcEVQ/mttT/I9kpp3dKKAU1t8H71v2zPtm2WBL
         1qqes+//A8oph7YVX7E5iozIEDImne7gm1lUYT5hT90ZCYRy2iDKYxPHmrAEBqM6TOr3
         RKm0gnuqGl0c/PXnqhaEiXzEDvksI9iJkbrCaMq95z5ACvRP64BV3sQjeSa42od+atyX
         vKIQ==
X-Gm-Message-State: AOAM532fB/K71gnY58w0UOYScpjcAq1WYtxZFfqJtbkqThrPPd27prcn
        x4h8v/J0Y/Xo3n7nfxn6TIklfC2hKtDzjw==
X-Google-Smtp-Source: ABdhPJyirRoN/ZfjzK28Ikp1+49sJ4sUKlRvdyqfj9FWw9z8mQWWrMYrMm5tGHrjHnr0POi3paL0YQ==
X-Received: by 2002:a7b:c102:: with SMTP id w2mr4916717wmi.112.1633098567986;
        Fri, 01 Oct 2021 07:29:27 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id 189sm9042069wmz.27.2021.10.01.07.29.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Oct 2021 07:29:27 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Thomas Rast <tr@thomasrast.ch>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 08/11] commit-graph: stop using optname()
Date:   Fri,  1 Oct 2021 16:29:14 +0200
Message-Id: <patch-v2-08.11-58683b3d89d-20211001T142631Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1374.gc8f4fa74caf
In-Reply-To: <cover-v2-00.11-00000000000-20211001T142631Z-avarab@gmail.com>
References: <cover-00.10-00000000000-20210928T130905Z-avarab@gmail.com> <cover-v2-00.11-00000000000-20211001T142631Z-avarab@gmail.com>
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

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/commit-graph.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
index 0386f5c7755..36552db89fe 100644
--- a/builtin/commit-graph.c
+++ b/builtin/commit-graph.c
@@ -172,8 +172,7 @@ static int write_option_max_new_filters(const struct option *opt,
 		const char *s;
 		*to = strtol(arg, (char **)&s, 10);
 		if (*s)
-			return error(_("%s expects a numerical value"),
-				     optname(opt, opt->flags));
+			return error(_("option `max-new-filters' expects a numerical value"));
 	}
 	return 0;
 }
-- 
2.33.0.1374.gc8f4fa74caf

