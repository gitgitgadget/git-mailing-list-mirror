Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37404C433F5
	for <git@archiver.kernel.org>; Wed, 25 May 2022 11:27:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242710AbiEYL1K (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 May 2022 07:27:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241640AbiEYL0b (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 May 2022 07:26:31 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D8289CCB3
        for <git@vger.kernel.org>; Wed, 25 May 2022 04:26:30 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id t6so29700102wra.4
        for <git@vger.kernel.org>; Wed, 25 May 2022 04:26:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5yuROgEvmiIt3r9eyKwY1S6EFwAQ3Q9h0lPKz+dW5Ko=;
        b=m6WAYu6Vr/MNkxpLaQ8lZbr7VMBUPrfRJu/K41bDMNOMvTQoclDihIiob+yAPtRIrt
         UXTu7q70i9rxlSk2V/kDYakd3795oC31SHDmnx3Zb+9mQxILXOT7JR8mmhXJsI1npwIt
         lAJXvPqb5YG6nFvHLIp7uy569wS+6/J720x560TbAqN9MC2ZDZjzuVxsaeUgCgz/77eF
         5bZ/8c7loIiBbYW6tPdzDjyZR432DkHkHw3hc1Hx/eoIRbkkT9OS9E4GVL7VigbDhBy4
         rj9bC1o2X/R7vHCxA1jhBEG5eKxLcwkePu/hg+C5/gFL4tr+Nex8fLwPyBf8vsNPAx59
         2L0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5yuROgEvmiIt3r9eyKwY1S6EFwAQ3Q9h0lPKz+dW5Ko=;
        b=oe614ZxmmHWDb/+PxPzzAXJGk0i+Ujd/IEMcIpBJwz3d0wtFkO9brZk2VSERoMvX9I
         PbwrA5AG+89FiAAWaEohq3xl4qOg7C5C2aF6J9tNr0olfSjQW/coWbEt6lRxNsv82mP7
         qvskESsDDiUXw5RbCfPR8vFXyMSMICCTKbcMvJbkTpVkFA0pyTDnr4ROPIHSBuAgJtqy
         ItgY95+CAU7YeHgeio63yh+9Y4zFdsAe//8JTI0uV0q0mlGvMJhHTpMuDUTtJnfHcwE0
         oZsY8kwvapWmxNkG19Vkx2Iv4v4GSnwSji5Gv2iLPioBLD/49P/1yKjJ/+UArPieoVHf
         gLAQ==
X-Gm-Message-State: AOAM530tuQx+ZGD4bjflESApLQnpuCEsdzWT9knwdqbeJxSUukB9715U
        CPGYpOmSxb2cwvtlHpQM7/oxaZHSEpucyg==
X-Google-Smtp-Source: ABdhPJytpfHrFFSk3HPMKsSWi4rMQ8pLR/iTzXgZlj/EhaHLJCXzef2rZXc0rxkbN/1nRA2J2raBjA==
X-Received: by 2002:a5d:69d1:0:b0:20d:db1:3dd6 with SMTP id s17-20020a5d69d1000000b0020d0db13dd6mr25897171wrw.294.1653477988689;
        Wed, 25 May 2022 04:26:28 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id z13-20020adfd0cd000000b0020d0dfcd10asm1851095wrh.65.2022.05.25.04.26.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 May 2022 04:26:28 -0700 (PDT)
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
Subject: [PATCH v6 09/14] ci(github): skip "skip" tests in --github-workflow-markup
Date:   Wed, 25 May 2022 13:25:58 +0200
Message-Id: <patch-v6-09.14-03d7b54d68b-20220525T100743Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.1.1045.gf356b5617dd
In-Reply-To: <cover-v6-00.14-00000000000-20220525T100743Z-avarab@gmail.com>
References: <RFC-cover-v5-00.10-00000000000-20220421T183001Z-avarab@gmail.com> <cover-v6-00.14-00000000000-20220525T100743Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As in the preceding commit's change to "ok" tests omit the "skip"
tests in the --github-workflow-markup. Before this we'd emit this for
e.g. t0026-eol-config.sh:

	$ rm -rf test-results; ./t0026-eol-config.sh --verbose-log -x --github-workflow-markup; echo; cat test-results/*markup
	ok 1 - setup
	ok 2 - eol=lf puts LFs in normalized file
	ok 3 - eol=crlf puts CRLFs in normalized file
	ok 4 - autocrlf=true overrides eol=lf
	ok 5 - autocrlf=true overrides unset eol
	ok 6 # skip eol native is crlf (missing NATIVE_CRLF)
	# passed all 6 test(s)
	1..6

	::group::skip: t0026.6 eol native is crlf

	        rm -rf native_eol && mkdir native_eol &&
	        (
	                cd native_eol &&
	                printf "*.txt text
	" >.gitattributes &&
	                printf "one
	two
	three
	" >filedos.txt &&
	                printf "one
	two
	three
	" >fileunix.txt &&
	                git init &&
	                git config core.autocrlf false &&
	                git config core.eol native &&
	                git add filedos.txt fileunix.txt &&
	                git commit -m "first" &&
	                rm file*.txt &&
	                git reset --hard HEAD &&
	                has_cr filedos.txt &&
	                has_cr fileunix.txt
	        )

	::endgroup::

Now we'll instead emit this, i.e. an empty *.markup file:

	$ rm -rf test-results; ./t0026-eol-config.sh --verbose-log -x --github-workflow-markup; echo; cat test-results/*markup
	ok 1 - setup
	ok 2 - eol=lf puts LFs in normalized file
	ok 3 - eol=crlf puts CRLFs in normalized file
	ok 4 - autocrlf=true overrides eol=lf
	ok 5 - autocrlf=true overrides unset eol
	ok 6 # skip eol native is crlf (missing NATIVE_CRLF)
	# passed all 6 test(s)
	1..6

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/test-lib-github-workflow-markup.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/test-lib-github-workflow-markup.sh b/t/test-lib-github-workflow-markup.sh
index 1ef0fd5ba87..bad3ebafdb7 100644
--- a/t/test-lib-github-workflow-markup.sh
+++ b/t/test-lib-github-workflow-markup.sh
@@ -40,8 +40,8 @@ finalize_test_case_output () {
 	fixed)
 		echo >>$github_markup_output "::notice::fixed: $this_test.$test_count $1"
 		;;
-	ok)
-		# Exit without printing the "ok" tests
+	ok|skip)
+		# Exit without printing the "ok" or "skip" tests
 		return
 		;;
 	esac
-- 
2.36.1.1045.gf356b5617dd

