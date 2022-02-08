Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACEA7C41535
	for <git@archiver.kernel.org>; Tue,  8 Feb 2022 13:15:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350382AbiBHNOu (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Feb 2022 08:14:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350274AbiBHMPF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Feb 2022 07:15:05 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71F5DC03FEC0
        for <git@vger.kernel.org>; Tue,  8 Feb 2022 04:15:04 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id h14-20020a17090a130e00b001b88991a305so1883446pja.3
        for <git@vger.kernel.org>; Tue, 08 Feb 2022 04:15:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=l0j9MvNlEHYd7VY03t/yyjO2xfuAHL72IRIFUia1XG0=;
        b=aH6vVi6bhw0+NwaOVJDCgiNWJikervLORjq/+p28TZsrrXEyqT6VV6T8gGdz5iz3gL
         JXsiUkpQmRPZAJPD74R4vBneV2dR/U/1D3sJ0uHMNNNc0D0zy6qiHINzzIPOG2Az6qqa
         YwM07DsM5CovHQN5+1SA5s35vxQhZtHcc/pIo57/JSgHXvj0jXHIwbZ7TWcH4HpSSyy4
         EcFHrbq9FsDvyTXB8T70FPFBAgFysKK+uqaLHA5YzxggtX4lJjsNzawiHPxhOgx6BxBT
         S7OMI2J7jEVbJy4wWFVPcvEaDgMOqd2lNetpiep2GAVaTKCTqJQou832/sZ+WRhAlya2
         HsXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=l0j9MvNlEHYd7VY03t/yyjO2xfuAHL72IRIFUia1XG0=;
        b=DzIj6P4R4xF4FHNrZzM22Kx3gm2Qz8yiEAKoi3xsNp4I6WyiGU6Wr/YZc6YrQ8lyRY
         kpSzDF/AFYIyyl985RGb1oxx/5ob5wOcl0GW6fDPEOAvxtOviZNOOMycwUc2XAvQCPm3
         TE0MgBuVgYsKKZD+tb5rTLOgKENWeALIt+vIHVvqHVjnZEYcs38LUKe5t2l4nLVLEtte
         J2PugjuuSE+3qmLlXzMPHe7jSflIC8bD2Ibd86Q4pXVVaf10PBKdHtnaVTPKpW952cHB
         +gfKBiOeIcUpgMnXVJBpecL6JOGmdngTmFSS+rosFdwAbwR4uTMnprLZdEaiVZUpsCf6
         J82A==
X-Gm-Message-State: AOAM530MDI097lPTqrbjUP1vtXqkxVuWrrdaocv4Kt7YLcJotZJKvnSF
        44CEDuJ+fsvhP6PNA/ovSsY=
X-Google-Smtp-Source: ABdhPJzyYP5RrXYdXD7KpJIF57NiQRsbhNnjeyOrhXz54fdwxIuQrZ4fvOKhc2ROjSt1galc8pWh0w==
X-Received: by 2002:a17:90b:1d88:: with SMTP id pf8mr1032629pjb.162.1644322503968;
        Tue, 08 Feb 2022 04:15:03 -0800 (PST)
Received: from code-infra-dev-cbj.ea134 ([140.205.70.44])
        by smtp.gmail.com with ESMTPSA id t3sm16973344pfg.28.2022.02.08.04.15.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Feb 2022 04:15:03 -0800 (PST)
From:   Teng Long <dyroneteng@gmail.com>
To:     dyroneteng@gmail.com
Cc:     Johannes.Schindelin@gmx.de, avarab@gmail.com, congdanhqx@gmail.com,
        git@vger.kernel.org, gitster@pobox.com, martin.agren@gmail.com,
        peff@peff.net, tenglong.tl@alibaba-inc.com
Subject: [PATCH v11 07/13] ls-tree: fix "--name-only" and "--long" combined use bug
Date:   Tue,  8 Feb 2022 20:14:32 +0800
Message-Id: <b22c2dc49ea3aa0ed7d0df367eddc84e931e9e21.1644319434.git.dyroneteng@gmail.com>
X-Mailer: git-send-email 2.34.1.403.gb35f2687cf.dirty
In-Reply-To: <cover.1644319434.git.dyroneteng@gmail.com>
References: <cover.1644319434.git.dyroneteng@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If we execute "git ls-tree" with combined "--name-only" and "--long"
, only the pathname will be printed, the size is omitted (the original
discoverer was Peff in [1]).

This commit fix this issue by using `OPT_CMDMODE()` instead to make both
of them mutually exclusive.

[1] https://public-inbox.org/git/YZK0MKCYAJmG+pSU@coredump.intra.peff.net/

Signed-off-by: Teng Long <dyroneteng@gmail.com>
---
 builtin/ls-tree.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/builtin/ls-tree.c b/builtin/ls-tree.c
index 9c57a36c8c..32147e75e6 100644
--- a/builtin/ls-tree.c
+++ b/builtin/ls-tree.c
@@ -120,12 +120,12 @@ int cmd_ls_tree(int argc, const char **argv, const char *prefix)
 			LS_SHOW_TREES),
 		OPT_SET_INT('z', NULL, &line_termination,
 			    N_("terminate entries with NUL byte"), 0),
-		OPT_BIT('l', "long", &ls_options, N_("include object size"),
-			LS_SHOW_SIZE),
-		OPT_BIT(0, "name-only", &ls_options, N_("list only filenames"),
-			LS_NAME_ONLY),
-		OPT_BIT(0, "name-status", &ls_options, N_("list only filenames"),
-			LS_NAME_ONLY),
+		OPT_CMDMODE('l', "long", &ls_options, N_("include object size"),
+			    LS_SHOW_SIZE),
+		OPT_CMDMODE(0, "name-only", &ls_options, N_("list only filenames"),
+			    LS_NAME_ONLY),
+		OPT_CMDMODE(0, "name-status", &ls_options, N_("list only filenames"),
+			    LS_NAME_ONLY),
 		OPT_SET_INT(0, "full-name", &chomp_prefix,
 			    N_("use full path names"), 0),
 		OPT_BOOL(0, "full-tree", &full_tree,
-- 
2.34.1.403.gb35f2687cf.dirty

