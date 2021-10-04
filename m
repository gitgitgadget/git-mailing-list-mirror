Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F1C2C433F5
	for <git@archiver.kernel.org>; Mon,  4 Oct 2021 01:43:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3CA0E61100
	for <git@archiver.kernel.org>; Mon,  4 Oct 2021 01:43:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232112AbhJDBon (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 3 Oct 2021 21:44:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232056AbhJDBom (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Oct 2021 21:44:42 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BE8EC061781
        for <git@vger.kernel.org>; Sun,  3 Oct 2021 18:42:54 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id j10-20020a1c230a000000b0030d523b6693so7442969wmj.2
        for <git@vger.kernel.org>; Sun, 03 Oct 2021 18:42:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=T88Vi+5dNA7CttVtU/plvyyAmMtKkZ8PiWA7fF9+C1Y=;
        b=OVcA4zpSB36/NW33OzTJ/4pScJ0tq/rxWW2Gk9H35TzYh5OmjFifLJ4RGTSHu5Pqt3
         EiregBhOugUc3QKt17WUfA+GoG64wOO82Yk9RynJyskaNzV58mXYc5LeMS/lqnUBIvLl
         5ZYXsyFulWuKkhUWzDw88FO7rsmhmIlZgVaSpHRfpU9u8bE8oPd3/9Vz5m0mW9GauR5n
         JNiPnHgtX/eeZNgh/B6K1kIiSQFfzz+ZXHr5+EqpGVQfDeJrT3RtCtT+38c21+m8L7F0
         pr3wgrwG1JB7D97F2omlxuZqBXRRRcY1qCXptM2uwYKgO5chzc5Mu+UJslZhrfJxN8Yk
         5afA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=T88Vi+5dNA7CttVtU/plvyyAmMtKkZ8PiWA7fF9+C1Y=;
        b=VnU8UImLMv9IwS+HZsbqxBdnKFqEvkhcIv/M2G0OjcVawsU8SqV65b02DjlyH4vVzi
         mZfxAp5Gvh0cNGjHr5auABLBmYTE3Ld/FKrN+yDKoL8hz//iKJ/FzzYCd25PbAQl7Xov
         ZW1pgBrq/k4SFTqg3kzaG855aC0tvptEb+5vmPuWtNprsGNll9BRLcaFZdT4QsNRGaK2
         y0mv7aA7+5oPug/mqd6H/bOPyWkYtBpyWYrLEbi5IxAg+wUJW4tV7SugNC8V2Rj8GucP
         z8GdwAShqR/FAA71/pjOLDvwEClgCgGCBJ6deF3ifRaTv3rBYD6D9NJES5vyGv1OiUDQ
         2PPw==
X-Gm-Message-State: AOAM532Bd9pMjh4Ml+ZMnWmhC9ktMYbqaccZoQyucqSez2X1dHRxSOU2
        TX3DkytftFZUjJjWEACoRPYT3XMVGhR1yQ==
X-Google-Smtp-Source: ABdhPJyW43NOyeSrNtT5OT5A1QGjMdxNGi5YG/6n/tH/jXlW3DYbAT9C4cxhmrenpWccNceZnz9uTA==
X-Received: by 2002:a1c:1dcb:: with SMTP id d194mr12697980wmd.161.1633311772474;
        Sun, 03 Oct 2021 18:42:52 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id e14sm3308193wrw.33.2021.10.03.18.42.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Oct 2021 18:42:51 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 1/2] object-name tests: tighten up advise() output test
Date:   Mon,  4 Oct 2021 03:42:48 +0200
Message-Id: <patch-1.2-7085f951a12-20211004T013611Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1404.g7bcfc82b295
In-Reply-To: <cover-0.2-00000000000-20211004T013611Z-avarab@gmail.com>
References: <cover-0.2-00000000000-20211004T013611Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change tests added in 1ffa26c4614 (get_short_sha1: list ambiguous
objects on error, 2016-09-26) to only care about the OIDs that are
listed, which is what the test is trying to check for.

This isn't needed by the subsequent commit, which won't change any of
the output, but a mere tightening of the tests assertions to more
closely match what we really want to test for here.

Now if the advise() message itself were change the phrasing around the
list of OIDs we won't have this test break. We're assuming that such
output won't have a need to indent anything except the OIDs.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t1512-rev-parse-disambiguation.sh | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/t/t1512-rev-parse-disambiguation.sh b/t/t1512-rev-parse-disambiguation.sh
index 7891a6becf3..d3a2d9188c7 100755
--- a/t/t1512-rev-parse-disambiguation.sh
+++ b/t/t1512-rev-parse-disambiguation.sh
@@ -334,16 +334,16 @@ test_expect_success 'ambiguity errors are not repeated (peel)' '
 
 test_expect_success 'ambiguity hints' '
 	test_must_fail git rev-parse 000000000 2>stderr &&
-	grep ^hint: stderr >hints &&
-	# 16 candidates, plus one intro line
-	test_line_count = 17 hints
+	grep "^hint:   " stderr >hints &&
+	# 16 candidates, minus surrounding prose
+	test_line_count = 16 hints
 '
 
 test_expect_success 'ambiguity hints respect type' '
 	test_must_fail git rev-parse 000000000^{commit} 2>stderr &&
-	grep ^hint: stderr >hints &&
-	# 5 commits, 1 tag (which is a committish), plus intro line
-	test_line_count = 7 hints
+	grep "^hint:   " stderr >hints &&
+	# 5 commits, 1 tag (which is a committish), minus surrounding prose
+	test_line_count = 6 hints
 '
 
 test_expect_success 'failed type-selector still shows hint' '
@@ -352,8 +352,8 @@ test_expect_success 'failed type-selector still shows hint' '
 	echo 851 | git hash-object --stdin -w &&
 	echo 872 | git hash-object --stdin -w &&
 	test_must_fail git rev-parse ee3d^{commit} 2>stderr &&
-	grep ^hint: stderr >hints &&
-	test_line_count = 3 hints
+	grep "^hint:   " stderr >hints &&
+	test_line_count = 2 hints
 '
 
 test_expect_success 'core.disambiguate config can prefer types' '
-- 
2.33.0.1404.g7bcfc82b295

