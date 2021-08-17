Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B8EEC432BE
	for <git@archiver.kernel.org>; Tue, 17 Aug 2021 06:44:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 133D460FA0
	for <git@archiver.kernel.org>; Tue, 17 Aug 2021 06:44:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238222AbhHQGpZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Aug 2021 02:45:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235915AbhHQGpY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Aug 2021 02:45:24 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6162C061764
        for <git@vger.kernel.org>; Mon, 16 Aug 2021 23:44:51 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id o123so16628286qkf.12
        for <git@vger.kernel.org>; Mon, 16 Aug 2021 23:44:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9xh8bytGQpoiCexB47Dx5yDV1zGZC74ZdjqHLY0zeiA=;
        b=TyeoB8C3da/zdZs0j6OMtFm/W0en2aWal0WvW58QcsTCOsr5ZE3bRFYAtwKHNcX6YP
         m0xZOt+NTpUj//aQyJVePNhMGQGmTtrAPCEVYqSsFjHEvarR0lz5G1BGJjhpa+RlIkdy
         +XiMuNsXBnDFi7eAUq2/Pdnca7UGf7BNnSfRw6gKDahyJvmfohCyxV0lxQrN0BKErVBP
         yN1ezmxcb/wUuQL1U/Y9phvRkxA0D3bms0mdXXRvWXVEAlecD43Tm4CRje9B8az1vAm0
         NNe0OqVfHuw4ghCaBfLMmJhIhDsw/mBoGnZippJhUM91XNbyblAv5a7IQYg/axw+gzg4
         85LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9xh8bytGQpoiCexB47Dx5yDV1zGZC74ZdjqHLY0zeiA=;
        b=QfKfNhh7QZH8tUIos6Zp/ocN10CAoYYGlVXXhPPr+/jbpKWRVJqi8oSEw8uFpaLuNG
         1gjP8hdthZxVrF5FAfmcQFVFQpniroaLWDLzGGgw1SGtE8TL7MsquJ4BkVY5pnwvTASg
         b6y+Fpp9MGhaSg1Mn1PV0JVBcruOhVne2ZI52VEII6Y30amoUNcqmH6HLo5ozP+UkmLe
         zrCNrGe6MifLSqfcBiNRmEbOK/tje+azDjDGyVE+dHVC/n2lYhhGOgHx9T6iIIsuFxqC
         UVw5msR8V5xYedcgo/fPEkT/vM786JpKoMitbIl2QqNAFuSHKBELVpDctMRZSvZh8ZE2
         majw==
X-Gm-Message-State: AOAM531Frhx2AFH4rJ+LW+mXJbiYY3Lo2IU7xJfEh7Eos7BlHQGd4dUA
        5OztbU9esQLyEWRmtd6U7k4TCHlZk1o=
X-Google-Smtp-Source: ABdhPJynKi4jZ9MHCzW0jnUCofHr7iKci5+f33j7riFgpk/I1Ci1UhfexR//4ezYtx3mJonYaRGiNg==
X-Received: by 2002:a05:620a:1999:: with SMTP id bm25mr2276702qkb.329.1629182690857;
        Mon, 16 Aug 2021 23:44:50 -0700 (PDT)
Received: from carlos-mbp.lan (104-1-92-200.lightspeed.sntcca.sbcglobal.net. [104.1.92.200])
        by smtp.gmail.com with ESMTPSA id q194sm757062qke.83.2021.08.16.23.44.49
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Aug 2021 23:44:50 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: [PATCH 2/2] builtin/add: make clear edit and patch/interactive are incompatible
Date:   Mon, 16 Aug 2021 23:44:35 -0700
Message-Id: <20210817064435.97625-3-carenas@gmail.com>
X-Mailer: git-send-email 2.33.0.476.gf000ecbed9
In-Reply-To: <20210817064435.97625-1-carenas@gmail.com>
References: <20210817064435.97625-1-carenas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

c59cb03a8b (git-add: introduce --edit (to edit the diff vs. the index),
2009-04-08) add the option to add an edited patch directly to the index
interactively, but was silently ignored if any of the other interactive
options was also selected.

report the user there is a conflict instead of silently ignoring -e
and while at it remove a variable assignment which was never used.

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
 builtin/add.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/builtin/add.c b/builtin/add.c
index a15b5be220..be1920ab37 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -308,7 +308,7 @@ static int edit_patch(int argc, const char **argv, const char *prefix)
 	repo_init_revisions(the_repository, &rev, prefix);
 	rev.diffopt.context = 7;
 
-	argc = setup_revisions(argc, argv, &rev, NULL);
+	setup_revisions(argc, argv, &rev, NULL);
 	rev.diffopt.output_format = DIFF_FORMAT_PATCH;
 	rev.diffopt.use_color = 0;
 	rev.diffopt.flags.ignore_dirty_submodules = 1;
@@ -486,6 +486,8 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 			die(_("--dry-run is incompatible with --interactive/--patch"));
 		if (pathspec_from_file)
 			die(_("--pathspec-from-file is incompatible with --interactive/--patch"));
+		if (edit_interactive)
+			die(_("--edit-interactive is incompatible with --interactive/--patch"));
 		exit(interactive_add(argv + 1, prefix, patch_interactive));
 	}
 
-- 
2.33.0.476.gf000ecbed9

