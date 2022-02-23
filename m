Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACC44C433F5
	for <git@archiver.kernel.org>; Wed, 23 Feb 2022 17:55:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243610AbiBWR4M (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Feb 2022 12:56:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243594AbiBWRzw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Feb 2022 12:55:52 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD9DB65EE
        for <git@vger.kernel.org>; Wed, 23 Feb 2022 09:55:24 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id o4so4155450wrf.3
        for <git@vger.kernel.org>; Wed, 23 Feb 2022 09:55:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=E/dL4dbXmnevF9IPOBnoODuzwSNqZWPE+6v50BBklS0=;
        b=K8NOgDuc2ZvOFoTU2vAhyG3KgOjPewKePXKmLNjzMDiPaS4V44U5HgrMkb3OkhIjZW
         7PWPEp1LcbI11cnAVCNJ7JHU9pxEawS3g8FAPQR3c/FaXA7Js7vpIDv1HB4MFupQLono
         CWys2yKvU1mOUK3cv5JERIN73DQqJ8jN2K5/7rZlIweb2oVp/Isbkkb+K2NkANPkArNy
         yQc8t4v0ioyCO9oUURaCqWiZCyzvxoKZi8LQJ3U/Q03lW3Zas+R1/xm8Ya+MyIk6dKGi
         drAOljU+FGnfgAPMc4mAcIE6SeKWzyzFPU3Ss0T2uRJVFMUlIUBl0Pe1Sgte/CWEqOXu
         knpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=E/dL4dbXmnevF9IPOBnoODuzwSNqZWPE+6v50BBklS0=;
        b=CE3a9yrydNTUm6S5KaYdDR2vVMTOTfnYocdNKAceD2BcQLNsmCpBx0/1RbV+zx2ivv
         0m9LP8zGLbN+HCjpiqW2oxJJETXYnEW+jYLx9MHjGHthdysP1Ay0hJQGeU4wBMMzOrQf
         oZOrtTwAynNo3XgbVs5QePsnXpMXMGrVP2InNwPMXTGL8s0B8sO5vuIVsJifg1ZaJtk9
         XQZHM3uJ9UTkC4t85BwLnz3DRXmlUgR5Np4nxfmCZuqEL3FQEieutY72GeWCP1IMBVHL
         hTV07+LLReG4F2YGCP0uh15RIDag3gIg7DEhtCdjhwMEEF6urf6Hj/Lf395B8r09S4dw
         txpw==
X-Gm-Message-State: AOAM531Oo7vN01v/uRbthUkPr66LRxNg1QPns0JHMqWZek13dlVSJSHU
        E0CAf1yLf3kKecqQNAJIozAJMi+OOEU=
X-Google-Smtp-Source: ABdhPJwoFqO9zERov9rXVZQQFjmJbRmtWB+XZVtPRjdirMmaVl1+IXGIbYum46yQQC97tfyFDgQgUw==
X-Received: by 2002:adf:f303:0:b0:1e7:aeab:ac6a with SMTP id i3-20020adff303000000b001e7aeabac6amr604105wro.40.1645638923262;
        Wed, 23 Feb 2022 09:55:23 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e20sm246424wre.90.2022.02.23.09.55.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Feb 2022 09:55:22 -0800 (PST)
Message-Id: <ec51d0a50e6e64ae37795d77f7d33204b9b71ecd.1645638911.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1159.git.1645638911.gitgitgadget@gmail.com>
References: <pull.1159.git.1645638911.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 23 Feb 2022 17:55:11 +0000
Subject: [PATCH 11/11] bundle: unbundle promisor packs
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     stolee@gmail.com, avarab@gmail.com, gitster@pobox.com,
        zhiyou.jx@alibaba-inc.com, jonathantanmy@google.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

In order to have a valid pack-file after unbundling a bundle that has
the 'filter' capability, we need to generate a .promisor file. The
bundle does not promise _where_ the objects can be found, but we can
expect that these bundles will be unbundled in repositories with
appropriate promisor remotes that can find those missing objects.

Use the 'git index-pack --promisor=<message>' option to create this
.promisor file. Add "from-bundle" as the message to help anyone diagnose
issues with these promisor packs.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 bundle.c               | 4 ++++
 t/t6020-bundle-misc.sh | 8 +++++++-
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/bundle.c b/bundle.c
index e284ef63062..3d97de40ef0 100644
--- a/bundle.c
+++ b/bundle.c
@@ -631,6 +631,10 @@ int unbundle(struct repository *r, struct bundle_header *header,
 	struct child_process ip = CHILD_PROCESS_INIT;
 	strvec_pushl(&ip.args, "index-pack", "--fix-thin", "--stdin", NULL);
 
+	/* If there is a filter, then we need to create the promisor pack. */
+	if (header->filter)
+		strvec_push(&ip.args, "--promisor=from-bundle");
+
 	if (extra_index_pack_args) {
 		strvec_pushv(&ip.args, extra_index_pack_args->v);
 		strvec_clear(extra_index_pack_args);
diff --git a/t/t6020-bundle-misc.sh b/t/t6020-bundle-misc.sh
index 39cfefafb65..344af34db1e 100755
--- a/t/t6020-bundle-misc.sh
+++ b/t/t6020-bundle-misc.sh
@@ -513,7 +513,13 @@ do
 		The bundle uses this filter: $filter
 		The bundle records a complete history.
 		EOF
-		test_cmp expect actual
+		test_cmp expect actual &&
+
+		# This creates the first pack-file in the
+		# .git/objects/pack directory. Look for a .promisor.
+		git bundle unbundle partial.bdl &&
+		ls .git/objects/pack/pack-*.promisor >promisor &&
+		test_line_count = 1 promisor
 	'
 done
 
-- 
gitgitgadget
