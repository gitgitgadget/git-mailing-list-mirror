Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B935DC433FE
	for <git@archiver.kernel.org>; Fri, 21 Oct 2022 09:44:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230257AbiJUJo5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Oct 2022 05:44:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230311AbiJUJop (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Oct 2022 05:44:45 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0D952F03B
        for <git@vger.kernel.org>; Fri, 21 Oct 2022 02:44:44 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id bp11so3654792wrb.9
        for <git@vger.kernel.org>; Fri, 21 Oct 2022 02:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZAzJucFnMRyeHs/Ut9E5MxeuHuJxknekfU9e1yq0us4=;
        b=cmzF5MhTDKyNZ6LfWDg1c8OoZi1Z009qtstVlZVPLNxs2jcQigtG2JZH96IirxTxO4
         UR/5LdZS5WUDvpUEn2vbnyYQbJyS7r9n4sancdKuOfRFlWXimS+xm70mwrX9Lxzlqt9P
         iK0g2ZL9SQZPIEbMtCywyKNr3RyCpfk6rXZSmOuDw2um4cPrXRoN8xEfJfiqE4pNvUzT
         qz5Ef/b1jKtV7gP2vT346+xDlMYkySlatd2zinsWBRtQWvFhuJoQnN5oO0C8ABuYcrDq
         ovWJFkhVdfRnslHoT7/Y+NUeK8VuQHAGelFFw7eONkYxuAb8EKNxy764TdDiMytBUhXI
         XhUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZAzJucFnMRyeHs/Ut9E5MxeuHuJxknekfU9e1yq0us4=;
        b=ue27wqlCcpT9lnNzwDhx/f+NHnGYh99rF0ecVC24jLSPperUZsx7Wc9G6/0H8RBq/p
         7m01YZfAGcjRENDgkvzaqJLqonpfsnZPZx7kdghbLSHRuAngFiirS+GdZQsMcqze9PrR
         k76iTOFuW0a8TnfZLtlyUAA7cVb+WTtyzJWvv2Zr5Yub2AyK5BkyHZAurbGy9TTSpjHc
         K4XbpwUwjMzvqWUAXiQKCpNgMX69TaCuXLeYtb3k/+ujTAOubMZoLeXUazV6/D/qijSJ
         kwgSrpiA+WDnVJHtVeJzBCv5asUM6yBD5SK+wgk6oxWwMNTZJLQQnBqI1XkvzjoAI7H0
         mbFg==
X-Gm-Message-State: ACrzQf0oPGckuUfaxR5MHdHrQmr3gs3oVBznuG93+gVm9Dg5MCqVhk6y
        Hl/iFEGZb+F2RC5Q6bvn+PaZ+coPbmPK5g==
X-Google-Smtp-Source: AMsMyM5TuB5oH7RfVza7x3HPwGMMKVkdJkpN1Z8Nkaweevg/R9u29aIy9PHdiWy8fiVWXKsSDsDW3w==
X-Received: by 2002:adf:c601:0:b0:230:7cfa:b3fe with SMTP id n1-20020adfc601000000b002307cfab3femr11619984wrg.344.1666345482695;
        Fri, 21 Oct 2022 02:44:42 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id u6-20020adfeb46000000b002258235bda3sm18277768wrn.61.2022.10.21.02.44.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Oct 2022 02:44:41 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Victoria Dye <vdye@github.com>,
        Eric Sunshine <ericsunshine@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 1/9] cmake: don't copy chainlint.pl to build directory
Date:   Fri, 21 Oct 2022 11:44:14 +0200
Message-Id: <patch-1.9-16c99177e6d-20221021T091013Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1205.gcea0601d673
In-Reply-To: <cover-0.9-00000000000-20221021T091013Z-avarab@gmail.com>
References: <cover-0.9-00000000000-20221021T091013Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When [1] made this copy of "chainlint.sed" the script was invoked in
the test-lib.sh as:

	[...] sed -f "$GIT_BUILD_DIR/t/chainlint.sed" [...]

But when [2] replaced "chainlint.sed" with a "chainlint.pl" it also
replaced that "$GIT_BUILD_DIR" with "$TEST_DIRECTORY", invoking it as:

	"$PERL_PATH" "$TEST_DIRECTORY/chainlint.pl" "$0"

So this line could have been deleted in [2] but wasn't. Let's do that
now.

1. 7f5397a07c6 (cmake: support for testing git when building out of
   the source tree, 2020-06-26)
2. 23a14f30166 (test-lib: replace chainlint.sed with chainlint.pl,
   2022-09-01)

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 contrib/buildsystems/CMakeLists.txt | 1 -
 1 file changed, 1 deletion(-)

diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
index 787738e6fa3..fd0c6ef4971 100644
--- a/contrib/buildsystems/CMakeLists.txt
+++ b/contrib/buildsystems/CMakeLists.txt
@@ -1083,7 +1083,6 @@ if(NOT ${CMAKE_BINARY_DIR}/CMakeCache.txt STREQUAL ${CACHE_PATH})
 		"string(REPLACE \"\${GIT_BUILD_DIR_REPL}\" \"GIT_BUILD_DIR=\\\"$TEST_DIRECTORY/../${BUILD_DIR_RELATIVE}\\\"\" content \"\${content}\")\n"
 		"file(WRITE ${CMAKE_SOURCE_DIR}/t/test-lib.sh \${content})")
 	#misc copies
-	file(COPY ${CMAKE_SOURCE_DIR}/t/chainlint.pl DESTINATION ${CMAKE_BINARY_DIR}/t/)
 	file(COPY ${CMAKE_SOURCE_DIR}/po/is.po DESTINATION ${CMAKE_BINARY_DIR}/po/)
 	file(COPY ${CMAKE_SOURCE_DIR}/mergetools/tkdiff DESTINATION ${CMAKE_BINARY_DIR}/mergetools/)
 	file(COPY ${CMAKE_SOURCE_DIR}/contrib/completion/git-prompt.sh DESTINATION ${CMAKE_BINARY_DIR}/contrib/completion/)
-- 
2.38.0.1205.gcea0601d673

