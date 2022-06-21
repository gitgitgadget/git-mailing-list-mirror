Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6075C433EF
	for <git@archiver.kernel.org>; Tue, 21 Jun 2022 22:34:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354518AbiFUWej (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Jun 2022 18:34:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354458AbiFUWea (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Jun 2022 18:34:30 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0266264E7
        for <git@vger.kernel.org>; Tue, 21 Jun 2022 15:34:29 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id j24so139334wrb.11
        for <git@vger.kernel.org>; Tue, 21 Jun 2022 15:34:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9//ZlFMmjfMIyIvC7PJURM/esIx9UV2n4rjrfxybLXs=;
        b=VIcvx0vgCAH/NOCWdmB/fM18UEiA4DhMSq4eBCnOkAOSLjt1IM0kLulPXXu8MclAWK
         3MsJoPsvRiimnUMzI+Yp2Meb+fK7eaWhTRS66L7/GLlpqp40WUtvorOpvecLE3lYs/qy
         SaNhIT/gcv+cIot99Y69mF0h6cHlDEjiUOFczCt/ntDtSN3oczZtQj28/UueWuxLyrSD
         MlzkLw7Imv/fwJXf2k27yE1JJGMDGnA+6h2FMp29t+S9RJ09CDeYF2u3st/tICAEK5Xz
         E0l/4GvGuaaU1Z+L5V1jd6ZZER1Qiz4mI/n3CcQ85sGD9Qxhmvkiwuc85A49d31Gk1EW
         EXag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9//ZlFMmjfMIyIvC7PJURM/esIx9UV2n4rjrfxybLXs=;
        b=Tn/TkZWUiIpVVQWdSYPZtzEvHLB7XHKoCVmUO9N16qKNeoSda7rvTZZbntcPrcU6H4
         TiNAYkageJeHzzzq0lobWLTFASeaYCGjgKZcOkbFiAK+T8oH34uNSbjaI8d4xt6jS3+5
         PZ+vd+GbATIXNDL7TPXKpfFUaxrNgCNRRCn/9byQZ5biP1qHE0bBEK4Pzp0OyzB1/UQS
         iqsn7pswi8YUoFkZkmQ9IrVQ8jnD8aKfBiMCyp19s/Z7ioU/HlERxscBBSM6FejsmSRM
         loEf8n6ysWrIRlXil42lHD+W1NSt7L79bVo6izn4BPQs4WbN+YwyD2jFhV55LWtNc+1f
         DnjA==
X-Gm-Message-State: AJIora+dpYNLmCLPzq2WJ0863wRDqtTGPUOrL6rT4F2pf9EFCQ9HkBtE
        Vp00ogPfZOSkE/wssIXhMYFUz7uILokyLw==
X-Google-Smtp-Source: AGRyM1uUeapbazbKU6bEWqDoRbUEq2BH2Xo726W/9tVKl7iWivCQPEZ8CZ1g2Nn++WI/TmwVBeAMbw==
X-Received: by 2002:a5d:49cf:0:b0:21b:818a:a09b with SMTP id t15-20020a5d49cf000000b0021b818aa09bmr212917wrs.676.1655850867192;
        Tue, 21 Jun 2022 15:34:27 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id y5-20020a7bcd85000000b0039c7c4a542csm19000299wmj.47.2022.06.21.15.34.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jun 2022 15:34:26 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        rsbecker@nexbridge.com,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 02/10] fetch tests: use named, not positional parameters
Date:   Wed, 22 Jun 2022 00:34:14 +0200
Message-Id: <patch-02.10-88bde1a82a6-20220621T222854Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.1.1239.gfba91521d90
In-Reply-To: <cover-00.10-00000000000-20220621T222854Z-avarab@gmail.com>
References: <xmqqa6a5g0m3.fsf@gitster.g> <cover-00.10-00000000000-20220621T222854Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Use the named parameters we've already unpacked from "$@" rather than
the positional paremeters. There's no functional changes here.

This changes code that dates back to the initial introduction of the
function in 737c5a9cde7 (fetch: make --prune configurable,
2013-07-13), although e.g. e249ce0ccdb (fetch tests: add scaffolding
for the new fetch.pruneTags, 2018-02-09) added many more parameters.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t5510-fetch.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index d784a761ba0..37e12de2475 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -868,7 +868,7 @@ test_configured_prune_type () {
 		cmdline="$new_cmdline"
 	fi
 
-	test_expect_success "$mode prune fetch.prune=$1 remote.origin.prune=$2 fetch.pruneTags=$3 remote.origin.pruneTags=$4${7:+ $7}; branch:$5 tag:$6" '
+	test_expect_success "$mode prune fetch.prune=$fetch_prune remote.origin.prune=$remote_origin_prune fetch.pruneTags=$fetch_prune_tags remote.origin.pruneTags=$remote_origin_prune_tags${cmdline:+ $cmdline}; branch:$expected_branch tag:$expected_tag" '
 		# make sure a newbranch is there in . and also in one
 		git branch -f newbranch &&
 		git tag -f newtag &&
-- 
2.36.1.1239.gfba91521d90

