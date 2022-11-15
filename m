Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F196C4332F
	for <git@archiver.kernel.org>; Tue, 15 Nov 2022 18:53:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231213AbiKOSxY (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Nov 2022 13:53:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230216AbiKOSxW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Nov 2022 13:53:22 -0500
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29C1A266D
        for <git@vger.kernel.org>; Tue, 15 Nov 2022 10:53:20 -0800 (PST)
Received: by mail-io1-xd2d.google.com with SMTP id d123so11375178iof.7
        for <git@vger.kernel.org>; Tue, 15 Nov 2022 10:53:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rSPFsp+Y8f8Dlva2DZo395caFHAffbpUsKeFlq7dz+Q=;
        b=lhw20iQK7KMplAyXvIkC7v9jTiwJLrI0Enl/XCS8TnfJOxFUcfBZiMd4N2JvxkUYHI
         igFVpKeUZK7bPDiRHzNk0JVm1nvXXMLD9S6eYa0nb9BZyoN008eZTgJVzetkJbOFa22/
         dadCTBhv2Gxu4YflLtM4buD4SYd/IHs2oZw3sxJVq7ngUc4A+k7ZnlwVsz0MGaxCub+I
         pHK0wvTp6mPIVEiDoaI/amJTZwSMdfCHgZAlizgLfJrtK6UKxq5oO54kDcuXZSPoLJL+
         YAHA9qX0TBc+MKVCmk6sp7uzeVGQ+ShCD8FG+T26kQ7k3mqgVLgcCsPNmsVrJgfqP/Su
         /gWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rSPFsp+Y8f8Dlva2DZo395caFHAffbpUsKeFlq7dz+Q=;
        b=dvoRk2ioPPXxQh5Dp+TjW3irerf5Z/Z/J2rAIbbgnHJjT3dRWk4KgJCXMguAtf5llQ
         Q2z836T9gSxaJ1KDcXyQ1+4lDOzBp/CkCiOc/lJWPju65NTb7dPPIxdI/kogy1Nf+xz7
         cBsUwUMpIzdiz5AndbnOfEGddBQZr3IybI5pjSPghhDADV5HUSc9SMWZoRZUcHE1nsY4
         VbJhfwOY6NIROPsdevm1P4/kEVh2WZc9/Wlw04CW7VfachxRufFgznsA19mhoJY2i+Hi
         c3qFkCUFvVeTdwCwRL+9ST6ifpdVvAgtWyNfPPn4ARmSOhA26UrXhE21m7hahXuVL7ie
         fm9g==
X-Gm-Message-State: ANoB5pmy2LV7isc2QtS19BI8Rpu9F05wSyNvzpCSnorCcQtxNzOa5uhD
        Z39ohH0jPLiTEIkTPxQvcTSqLdDtwuzr8Q==
X-Google-Smtp-Source: AA0mqf5ZkDeskrRrOwOOH3z5MTDd6SEBgSJDfyo2vWghqWcGl2ZY+xE0/RBUW0Ofcubj+mHQb2I8Ww==
X-Received: by 2002:a5d:9b19:0:b0:6c1:dfd6:abd9 with SMTP id y25-20020a5d9b19000000b006c1dfd6abd9mr8287308ion.0.1668538399370;
        Tue, 15 Nov 2022 10:53:19 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 8-20020a020a08000000b0037477c3d04asm4741948jaw.130.2022.11.15.10.53.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 10:53:18 -0800 (PST)
Date:   Tue, 15 Nov 2022 13:53:17 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org, git-security@googlegroups.com
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Ronan Pigott <ronan@rjp.ie>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
Subject: [PATCH] builtin/gc.c: fix use-after-free in maintenance_unregister()
Message-ID: <2cbead254b77cb02d219bca8f628dc4362c045b0.1668538355.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

While trying to fix a move based on an uninitialized value (along with a
declaration after the first statement), be0fd57228
(maintenance --unregister: fix uninit'd data use &
-Wdeclaration-after-statement, 2022-11-15) unintentionally introduced a
use-after-free.

The problem arises when `maintenance_unregister()` sees a non-NULL
`config_file` string and thus tries to call
git_configset_get_value_multi() to lookup the corresponding values.

We store the result off, and then call git_configset_clear(), which
frees the pointer that we just stored. We then try to read that
now-freed pointer a few lines below, and there we have our
use-after-free:

    $ ./t7900-maintenance.sh -vxi --run=23 --valgrind
    [...]
    + git maintenance unregister --config-file ./other
    ==3048727== Invalid read of size 8
    ==3048727==    at 0x1869CA: maintenance_unregister (gc.c:1590)
    ==3048727==    by 0x188F42: cmd_maintenance (gc.c:2651)
    ==3048727==    by 0x128C62: run_builtin (git.c:466)
    ==3048727==    by 0x12907E: handle_builtin (git.c:721)
    ==3048727==    by 0x1292EC: run_argv (git.c:788)
    ==3048727==    by 0x12988E: cmd_main (git.c:926)
    ==3048727==    by 0x21ED39: main (common-main.c:57)
    ==3048727==  Address 0x4b38bc8 is 24 bytes inside a block of size 64 free'd
    ==3048727==    at 0x484617B: free (vg_replace_malloc.c:872)
    ==3048727==    by 0x2D207E: free_individual_entries (hashmap.c:188)
    ==3048727==    by 0x2D2153: hashmap_clear_ (hashmap.c:207)
    ==3048727==    by 0x270B5C: git_configset_clear (config.c:2375)
    ==3048727==    by 0x1869AC: maintenance_unregister (gc.c:1585)
    ==3048727==    by 0x188F42: cmd_maintenance (gc.c:2651)
    ==3048727==    by 0x128C62: run_builtin (git.c:466)
    ==3048727==    by 0x12907E: handle_builtin (git.c:721)
    ==3048727==    by 0x1292EC: run_argv (git.c:788)
    ==3048727==    by 0x12988E: cmd_main (git.c:926)
    ==3048727==    by 0x21ED39: main (common-main.c:57)
    [...]

Resolve this via a partial-revert of be0fd57228. The config_set struct
now gets a zero initialization, which makes free()-ing it a noop even
without calling git_configset_init(). When we do initialize it to a
non-zero value, it is only free()'d after our last read of `list`.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
I am disappointed in myself for finding this only after I pushed out a
hotfix to 'next' and rebuild the downstream branches.

This should be a minimal fix on top of Ævar's patch to get 'next'
building again.

 builtin/gc.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index d87cf84041..38882a1e35 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -1543,6 +1543,7 @@ static int maintenance_unregister(int argc, const char **argv, const char *prefi
 	int found = 0;
 	struct string_list_item *item;
 	const struct string_list *list;
+	struct config_set cs = { { 0 } };

 	argc = parse_options(argc, argv, prefix, options,
 			     builtin_maintenance_unregister_usage, 0);
@@ -1551,12 +1552,9 @@ static int maintenance_unregister(int argc, const char **argv, const char *prefi
 				   options);

 	if (config_file) {
-		struct config_set cs;
-
 		git_configset_init(&cs);
 		git_configset_add_file(&cs, config_file);
 		list = git_configset_get_value_multi(&cs, key);
-		git_configset_clear(&cs);
 	} else {
 		list = git_config_get_value_multi(key);
 	}
@@ -1592,6 +1590,7 @@ static int maintenance_unregister(int argc, const char **argv, const char *prefi
 		die(_("repository '%s' is not registered"), maintpath);
 	}

+	git_configset_clear(&cs);
 	free(maintpath);
 	return 0;
 }
--
2.38.0.16.g393fd4c6db
