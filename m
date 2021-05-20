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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14257C433ED
	for <git@archiver.kernel.org>; Thu, 20 May 2021 12:25:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E7F2161353
	for <git@archiver.kernel.org>; Thu, 20 May 2021 12:25:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234705AbhETM1G (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 May 2021 08:27:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231601AbhETM0q (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 May 2021 08:26:46 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34DBBC0438D9
        for <git@vger.kernel.org>; Thu, 20 May 2021 04:23:18 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id et19so17610029ejc.4
        for <git@vger.kernel.org>; Thu, 20 May 2021 04:23:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tlCHGDetKv+3INTN1nkBs7u/eHpRz5fS/FiQYeYL2U8=;
        b=Huj7yzF5TgLazz7405qcGc8Gp5XQ0b1omOreY9MKC9QS5evNA9WsiuN3V9rzy5NFXs
         3RfnJS/vyt9z6kNMJk5BIZqQ1vNwxK6Cg0t7eNr2E/NEM0wdTniTp0Kr5lStjRNPqLZV
         kboMpJnud2hH7C3cZYFmU0rr4oJcKepIYxXaC8Vxn4OpUIBjRdW7qOlrA9unRvzmZk8y
         0hux/n8TGfcO+4ylHhLle7UiiYpQ7bJSqPAQm5wvbDrq82g0aV0bqEWWUamZUH+nfZB0
         yf3iRL5KKTuWLd/zraDzX+n0SE73nKEa8Y7tWGc4Y01+fWpBptOyfgqdhTFbbQDbBYi9
         edBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tlCHGDetKv+3INTN1nkBs7u/eHpRz5fS/FiQYeYL2U8=;
        b=PqzCTE5zu0gBV556SALcPY2kOVuiDswSKfOyu8Bb4/e3kVljxBUG5WVG44ad4hDLsj
         NF6nBomyV6pX/fnR8LjykGwAQCXepmpac2DImBtqHBejKx6hT9YyGMNbK6h1aWbnlPm5
         Tp6IQDZXkN13xmHO+dQYvoJDERvs/MgUAb3832I/sd/0pzunGVe6EZQVqE8C+K+7ybhH
         96ShtWjozjf63in3sm9Ma7ynxqWcEYeKvZRdbGB6Pd/HDA5ISBaOZzgUXtBFCizGAAWS
         ux8hod4aoC02+IOxJYFEfdiLI5OP76JooeMs/+/HBbiHY8w079ClLi+7scBfSqlmsxK6
         U6XA==
X-Gm-Message-State: AOAM533MdvbwSx/9fa8T3i6g2dDj27PfDZ41e62F6wJM0fgZXoeR1pCn
        WMpjlO7Q2Xn0MhymC7COGV91vC+72gyLGw==
X-Google-Smtp-Source: ABdhPJwVhz4OjAx63nqiyYgC3NN+VCitYXn+JPPRcZOTZg4xfubCMzhdUi4X2H88NuldnKBMUvWoEQ==
X-Received: by 2002:a17:906:eb0c:: with SMTP id mb12mr4131788ejb.109.1621509796516;
        Thu, 20 May 2021 04:23:16 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id jy21sm1243273ejc.13.2021.05.20.04.23.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 04:23:15 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 02/17] fsck tests: add test for fsck-ing an unknown type
Date:   Thu, 20 May 2021 13:22:56 +0200
Message-Id: <patch-02.17-82b64abd25-20210520T111610Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.rc0.406.g73369325f8d
In-Reply-To: <cover-00.17-0000000000-20210520T111610Z-avarab@gmail.com>
References: <cover-0.6-00000000000-20210328T025618Z-avarab@gmail.com> <cover-00.17-0000000000-20210520T111610Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix a blindspot in the fsck tests by checking what we do when we
encounter an unknown "garbage" type produced with hash-object's
--literally option.

This behavior needs to be improved, which'll be done in subsequent
patches, but for now let's test for the current behavior.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t1450-fsck.sh | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/t/t1450-fsck.sh b/t/t1450-fsck.sh
index 1563b35f88..f36ec1e2f4 100755
--- a/t/t1450-fsck.sh
+++ b/t/t1450-fsck.sh
@@ -863,4 +863,16 @@ test_expect_success 'detect corrupt index file in fsck' '
 	test_i18ngrep "bad index file" errors
 '
 
+test_expect_success 'fsck hard errors on an invalid object type' '
+	test_create_repo garbage-type &&
+	empty_blob=$(git -C garbage-type hash-object --stdin -w -t blob </dev/null) &&
+	garbage_blob=$(git -C garbage-type hash-object --stdin -w -t garbage --literally </dev/null) &&
+	cat >err.expect <<-\EOF &&
+	fatal: invalid object type
+	EOF
+	test_must_fail git -C garbage-type fsck >out.actual 2>err.actual &&
+	test_cmp err.expect err.actual &&
+	test_must_be_empty out.actual
+'
+
 test_done
-- 
2.32.0.rc0.406.g73369325f8d

