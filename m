Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C43A1C433DB
	for <git@archiver.kernel.org>; Sat, 23 Jan 2021 13:02:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9950F22CB2
	for <git@archiver.kernel.org>; Sat, 23 Jan 2021 13:02:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725946AbhAWNCt (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 23 Jan 2021 08:02:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725891AbhAWNCa (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Jan 2021 08:02:30 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5A31C0617A7
        for <git@vger.kernel.org>; Sat, 23 Jan 2021 05:01:12 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id 190so6601152wmz.0
        for <git@vger.kernel.org>; Sat, 23 Jan 2021 05:01:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DeRamRegfWW2znduNnuo/vfYxA2obKx8NDdD3WMIqUo=;
        b=UoJ3gtw9uNgrDqS6X/w4zAQkHPFXkOzfnigmkpEeFXgxRvo74wpwlGs2H7QWtQsYwI
         17+OsaL67xBlLdm0i6XKipI57QymW3oMITQV9BlJepcLxi9QxRYxnJ8h5aa3OEkPKYq3
         N67iFHnGZRo5ZcM8oDmABZs5xRZnCrci13hVSqtd8yBnq1y5GkFCfeOVUWe1y9SJLDBn
         LN9iYcpIIrdqgBqDZhg88tFyPY5meJY5Q82rzhl8h9V5e4321y5UEtBEDeouZBN3yeK5
         1ACo64JEt3WcpsewMB4DLT7/Eubh1Ui+sAp9iY/PWdTVXEoIbiHUazHLXLQoDiIvIh9P
         MIZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DeRamRegfWW2znduNnuo/vfYxA2obKx8NDdD3WMIqUo=;
        b=YICtd6NEmsjytkGqu3ciIJw25B8Z29vLPw4K/OMEXYBpZrl+Ua8pmj/HO9AMer8sas
         bDMO/OrkzXJ+ckuF6VRLjsPmj+1lmpZ+RFruD2piFpwBTait8qAEBhoLsZxlt522QGv4
         GiQ3Uwe9m1IplXS6iaCsCz4468o7u+S1fA3FTizqOv8aNSmlJpIaZhv5ZQR7tB3+C3yN
         myvEvhDhlzz1/uixGFCESVuKfP/BGM2x0xxJjHTlKkPR6C6Zk8VOpQgINWxaycNarPHX
         aTtz4oAA2bBaDNeezMY8Qp7jIp96sT/cdTK36ik98Khwk649S/jz4pQTp9bGmP/jCwIt
         UFIQ==
X-Gm-Message-State: AOAM533ghljmETr/3JqZWsqjDtOm9X9v1vD0n+jDX0bhD8doj8vTq5iJ
        2HAZUTBUExpEYM85k3ZRIvtC4STbDIzK9w==
X-Google-Smtp-Source: ABdhPJyhEUoTjp3QXfTd7dnPyyv2EVXpLZfamMymI54rCIJnxWh7jRvxktOu8cKHTG94uxpNtAtKZA==
X-Received: by 2002:a1c:5941:: with SMTP id n62mr57065wmb.63.1611406871509;
        Sat, 23 Jan 2021 05:01:11 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c7sm16750319wro.16.2021.01.23.05.01.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Jan 2021 05:01:10 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Denton Liu <liu.denton@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 08/10] upload-pack tests: avoid a non-zero "grep" exit status
Date:   Sat, 23 Jan 2021 14:00:44 +0100
Message-Id: <20210123130046.21975-9-avarab@gmail.com>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8
In-Reply-To: <87sg6s6lrs.fsf@evledraar.gmail.com>
References: <87sg6s6lrs.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Continue changing a test that 763b47bafa (t5703: stop losing return
codes of git commands, 2019-11-27) already refactored.

This was originally added as part of a series to add support for
running under bash's "set -o pipefail", under that mode this test will
fail because sometimes there's no commits in the "objs" output.

It's easier to fix that than exempt these tests under a hypothetical
"set -o pipefail" test mode. It looks like we probably won't have
that, but once we've dug this code up let's refactor it[2] so we don't
hide a potential pipe failure.

1. https://lore.kernel.org/git/xmqqzh18o8o6.fsf@gitster.c.googlers.com/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t5703-upload-pack-ref-in-want.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/t/t5703-upload-pack-ref-in-want.sh b/t/t5703-upload-pack-ref-in-want.sh
index eab966985b..5d825b1781 100755
--- a/t/t5703-upload-pack-ref-in-want.sh
+++ b/t/t5703-upload-pack-ref-in-want.sh
@@ -16,7 +16,8 @@ get_actual_commits () {
 	test-tool pkt-line unpack-sideband <out >o.pack &&
 	git index-pack o.pack &&
 	git verify-pack -v o.idx >objs &&
-	grep commit objs | cut -d" " -f1 | sort >actual_commits
+	sed -n -e 's/\([0-9a-f][0-9a-f]*\) commit .*/\1/p' objs >objs.sed &&
+	sort >actual_commits <objs.sed
 }
 
 check_output () {
-- 
2.29.2.222.g5d2a92d10f8

