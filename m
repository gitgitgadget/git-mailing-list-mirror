Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53858C433EF
	for <git@archiver.kernel.org>; Wed, 25 May 2022 11:27:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242695AbiEYL1Y (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 May 2022 07:27:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242752AbiEYL1J (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 May 2022 07:27:09 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 844379D06A
        for <git@vger.kernel.org>; Wed, 25 May 2022 04:26:35 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id f2so29728298wrc.0
        for <git@vger.kernel.org>; Wed, 25 May 2022 04:26:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=thZVf6MKYkaJJgdigsPgYcmUAKUx/udFInC3x63gneg=;
        b=gBLDpvvoqXDcY6W17Zh3PJAYm1vfFpLFY/x1/lGfRJAJvnn8RzZtRMfmxD6J3/JA9K
         sMvjDuXg/zRtrPncpi9bWxN0K+DbXH05Q68C5zrd3+Vi+APJi/w1emUfU/pmJYY5L1SM
         WrCkHyZL+wYtCoyH3c0a1f7zKgfiy4IyaAYxyeNXhOP0oRmKM5GT10ckPlIXw5ydFqFA
         4m0Qt0DSeUURLGkHKyAFIqf0ZmlmdyIj9KBuyz+9v/2E+5B0PF8TksskvCTxSPn3f+R6
         ejAAAGxkdJ9DIxtko/NI5iPgiBANb7GuSqNvS2pAwsscWw16ZSNuugqS390gSe9U6Udi
         AiIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=thZVf6MKYkaJJgdigsPgYcmUAKUx/udFInC3x63gneg=;
        b=GYOvcfgAtB0UgDEFs41vdIVY4IuYw8Qgg9HI907PMjzh5+DMDglluXm9PY81goRRob
         mEBMz+Dkh3dFzhWnO8XlOmLl+XaC+HZKvvh/kXcri2F/2b3bdPG63NPwgwABHN7Iln/x
         D+KC7ISwhWqG2aqDVMLvJ3UPxvLJPewS6dshk3W5Qa2QTJJtuaXGXsgf35f71oSJrO4Y
         dOWZ6qvqIVkkfUH6z6kanbgUZf14xHpO99Y1EbF6S4tcmATmMLH9I8KKMDz+x77I5kQu
         fWsSRUmn0BZ04IFwLUJYDtU+M4FhLq3uEoyKZSO/VhcOgNerZ2Co1NzKEnw+nmarVkB5
         ZYQg==
X-Gm-Message-State: AOAM531leiFKmbVgXbUK9bzGEJApnLxyioNuuylIrsSxXww0N0G6o6O/
        Qfo3ite6NXu75yXJ8hZDgwZIGu+8+iQCfQ==
X-Google-Smtp-Source: ABdhPJyndS8VZAbJKorR9DSpWnTao0qzL6Ycz1uVV8MjTVfK/4q92Y61UyaNPB0JpdMFU7pfsJ35zw==
X-Received: by 2002:a5d:620f:0:b0:20c:c1ba:cf8e with SMTP id y15-20020a5d620f000000b0020cc1bacf8emr26188881wru.426.1653477993756;
        Wed, 25 May 2022 04:26:33 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id z13-20020adfd0cd000000b0020d0dfcd10asm1851095wrh.65.2022.05.25.04.26.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 May 2022 04:26:33 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Victoria Dye <vdye@github.com>,
        Matheus Tavares <matheus.bernardino@usp.br>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v6 14/14] CI: make the --github-workflow-markup "github" output the default
Date:   Wed, 25 May 2022 13:26:03 +0200
Message-Id: <patch-v6-14.14-0b02b186c87-20220525T100743Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.1.1045.gf356b5617dd
In-Reply-To: <cover-v6-00.14-00000000000-20220525T100743Z-avarab@gmail.com>
References: <RFC-cover-v5-00.10-00000000000-20220421T183001Z-avarab@gmail.com> <cover-v6-00.14-00000000000-20220525T100743Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As noted in the preceding commit there's outstanding issues with this
output target over the "raw" one, but let's flip the default so that
the end-state of this series matches that of [1]. If we'd like we can
now easily revert back.

My ci/config/print-test-failures-output-type on my "ci-config" branch
is currently the following script, which allows for naming branches
with _CI_OUT_{GITHUB,RAW} suffixes to force a given output type:

	#!/bin/sh

	set -ex

	ref=$1
	shift
	echo "ref: $ref" >&2
	echo "arguments: $@" >&2

	case "$ref" in
	*_CI_OUT_GITHUB)
		echo github
		;;
	*_CI_OUT_RAW)
		echo raw
		;;
	esac

1. https://lore.kernel.org/git/pull.1117.v3.git.1653171536.gitgitgadget@gmail.com/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 .github/workflows/main.yml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
index 4195f37c1ba..39675cbdd60 100644
--- a/.github/workflows/main.yml
+++ b/.github/workflows/main.yml
@@ -26,7 +26,7 @@ jobs:
       - id: print-test-failures-output-type
         name: check what output type ci/print-test-failures.sh uses
         run: |
-          type_default=raw
+          type_default=github
           type=$type_default
 
           if test -x config-repo/ci/config/print-test-failures-output-type
-- 
2.36.1.1045.gf356b5617dd

