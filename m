Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C05EC432BE
	for <git@archiver.kernel.org>; Mon, 23 Aug 2021 11:03:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF5B661008
	for <git@archiver.kernel.org>; Mon, 23 Aug 2021 11:03:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236393AbhHWLEB (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Aug 2021 07:04:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236197AbhHWLDw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Aug 2021 07:03:52 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00F59C061757
        for <git@vger.kernel.org>; Mon, 23 Aug 2021 04:03:10 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id c8-20020a7bc008000000b002e6e462e95fso13762093wmb.2
        for <git@vger.kernel.org>; Mon, 23 Aug 2021 04:03:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nzqGiCaiokMdyrmYgdMy4AQvEQCRxhD+IjOl7CtAxDA=;
        b=WHeCFdPHZLriUK01yYsZ66AGGiaG8sfK2n3j1idmn9ESdifSC7dm1G5BMZv7SQZ1LQ
         k+58bDjlZFEzagUoK2h3OHhR+t8IILt54TOdM8G6nClfk3d5Sluz4pa+pudDqKvbeooZ
         JYoR0++SeWH4IaZLI+TmHIkW6LU7sOv/8nCcfGg9MG0TezlFvN3Ji6tIUZ34KUY2C3Uo
         daDr5iUYL/aPtYOU0oszmBeBUZwlDcc1OWi5XNhuNhiDIy+U394rGU+b1iw1ibxLrbfJ
         WVtzkLVX7B+TEzUCvAO/jj5TsYRPhRK7cVBZ1+XAycPQ8I7l2jzaTdNhkGXKA5iHTPqa
         2o6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nzqGiCaiokMdyrmYgdMy4AQvEQCRxhD+IjOl7CtAxDA=;
        b=VGIp5FPyZewJhbcTYlv/dnnL+KAHcARzffdptGDyKlltp5u8DVYKXdgKLsgAy6O1c5
         98w+Sa1U470tFwEJK54pN9LIvdwV5m+7IaAtqnXbbkkXioqVyeQPDWms5QdUH+xrtuVs
         Y2cDswnOPlCgV6AWcpevoHkKnq6j0Z+70o5cb5+JPZySIBlqYnvQWBk7E2M7absOy/G2
         wOohSrf9kj6u9gVp0ggdpEQkwxOSIphmHEkx3J1XUdrC3TeLgvk3Zyrx+qAv4S4vU7eb
         L403WXZJxgnE1ZlsgcAw/2SeXLUBOaeV+RRGmKFcPbMdCvMdUgSbOxjJdRkj6z0crO8o
         FaGA==
X-Gm-Message-State: AOAM531KemkuTdeYXUDZPEzWC+Hvo58oYftVFMRDQUQfCPJe0+ALaF7Y
        DwhutFsxMdA/yzMLpRz8h11YPM/AJBE5chQy
X-Google-Smtp-Source: ABdhPJwr/OGMTMOQyy50IK3uAv7Pff6RSaquyyJvKRcNiFF6BUhaEujUupSWDgDVrwpNe6u4WGT2Ng==
X-Received: by 2002:a7b:cf31:: with SMTP id m17mr15479947wmg.109.1629716588400;
        Mon, 23 Aug 2021 04:03:08 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l19sm13255493wmi.4.2021.08.23.04.03.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Aug 2021 04:03:07 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 4/4] bundle: show progress on "unbundle"
Date:   Mon, 23 Aug 2021 13:02:59 +0200
Message-Id: <patch-v2-4.4-e4ca8b26962-20210823T110136Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.662.g438caf9576d
In-Reply-To: <cover-v2-0.4-00000000000-20210823T110136Z-avarab@gmail.com>
References: <cover-0.4-0000000000-20210727T004015Z-avarab@gmail.com> <cover-v2-0.4-00000000000-20210823T110136Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The "unbundle" command added in 2e0afafebd8 (Add git-bundle: move
objects and references by archive, 2007-02-22) did not show progress
output, even though the underlying API learned how to show progress in
be042aff24c (Teach progress eye-candy to fetch_refs_from_bundle(),
2011-09-18).

Now we'll show "Unbundling objects" using the new --progress-title
option to "git index-pack", to go with its existing "Receiving
objects" and "Indexing objects" (which it shows when invoked with
"--stdin", and with a pack file, respectively).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/bundle.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/builtin/bundle.c b/builtin/bundle.c
index 10f6f45770a..f027cce3fef 100644
--- a/builtin/bundle.c
+++ b/builtin/bundle.c
@@ -162,7 +162,11 @@ static int cmd_bundle_unbundle(int argc, const char **argv, const char *prefix)
 	struct bundle_header header = BUNDLE_HEADER_INIT;
 	int bundle_fd = -1;
 	int ret;
+	int progress = isatty(2);
+
 	struct option options[] = {
+		OPT_BOOL(0, "progress", &progress,
+			 N_("show progress meter")),
 		OPT_END()
 	};
 	char* bundle_file;
@@ -178,6 +182,13 @@ static int cmd_bundle_unbundle(int argc, const char **argv, const char *prefix)
 	}
 	if (!startup_info->have_repository)
 		die(_("Need a repository to unbundle."));
+
+	if (progress) {
+		strvec_push(&extra_args, "-v");
+		strvec_push(&extra_args, "--progress-title");
+		strvec_push(&extra_args, _("Unbundling objects"));
+	}
+
 	ret = !!unbundle(the_repository, &header, bundle_fd, &extra_args) ||
 		list_bundle_refs(&header, argc, argv);
 	bundle_header_release(&header);
-- 
2.33.0.662.g438caf9576d

