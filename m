Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03AA9C77B73
	for <git@archiver.kernel.org>; Wed, 31 May 2023 23:12:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230479AbjEaXMu (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 31 May 2023 19:12:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230240AbjEaXMq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 May 2023 19:12:46 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BD76A0
        for <git@vger.kernel.org>; Wed, 31 May 2023 16:12:45 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-babb79a17b8so251669276.0
        for <git@vger.kernel.org>; Wed, 31 May 2023 16:12:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685574764; x=1688166764;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=fAbyktMYeUWuFx8SBNLBrbw5SHRA0C9xAPJ1GVIEFHs=;
        b=LCh4j56Ae1H8Yuumyidj253fe23iUfeT4XwE/NINtLVLuVXD8aFJAUYfbs/z/8bpXe
         i3eh/1AFz7opXm4MA9GHMQAi9MMFooNO3wCYUdaOlEJLvyoA+4QH6aBbR9oqBU7zLgcZ
         GEKyj1kSPe7quohd9gaJ908I1kCLXrBJdWR+ToVYin+6EPEuszVyCKhXd3BOhcVTgxSO
         Ai4Dr+5oRMSnyB/IqYWa2E35LkJ5i2QT93kw83z67uwdTSPW1PFY3rOqZZo6wESKnBzr
         haozooLvU0ut9eUDYWVbgDwtyVwzLOCmkEGW1Xm3ndIdQXOHbN+l3es8EvxinxRKvrk1
         rKFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685574764; x=1688166764;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fAbyktMYeUWuFx8SBNLBrbw5SHRA0C9xAPJ1GVIEFHs=;
        b=DG0d87Q0io/7MWsSTlc+DFEJZ6RKgydGdvhGKT8fEdz46VJdU+M8/AGIeAYdsorpUI
         JuDg3NVkNcg5WTlAOQYkA6K567ITv/6p1FfOQZ385eGIuQRxCUzTd3FxB1JOzUf6Sh6R
         01ld6HvDXoue8OOBxRO+E40UA3CjcUPVRzW3PNYoFJ2h5IvrA4A8NeftKlsISTLRWLdG
         aLOdAn8vwBbykmPgZU1O4rJgqQc02Jd7shZSfOcXSXfOD9l7teVYSl2oaAZ+tg7G4kQk
         ntu6AkQgyZIj/8KLEsoAvfAlsKE7mxR5NClxmKhsXyKLgcU522r3S4FL3UxO1w25uOTe
         xNZA==
X-Gm-Message-State: AC+VfDzLUjXSeiCExtpzm/S3OZwJJlXD0ip6k4ukwwvr/HBPXKSA9rrc
        hgOiZ0cD8tIyT1f57h36oaCWBpdfh3uoAZ56QqaNmBmD5FzJcxTbyqhwE1qJBGWYJqhgkr/HeiR
        EZWDXOtUBQV64adwSPW1kZXiuRXJbTJnKTYa0B3Ox6NMrCP6HpK+FAsneZ/LqCrZn6xZ8Ft7egY
        25
X-Google-Smtp-Source: ACHHUZ43anDcvjW4p0ty3tV5jghRxiF/ZKHmhm2t77sEGRT6ldaTOO15J6qHXitheI4GG45D4rELtUYvA0DpH6pHUqAY
X-Received: from jonathantanmy0.svl.corp.google.com ([2620:15c:2d3:202:2ee:ade5:9636:9867])
 (user=jonathantanmy job=sendgmr) by 2002:a25:8747:0:b0:ba9:9a4f:a40 with SMTP
 id e7-20020a258747000000b00ba99a4f0a40mr4104195ybn.13.1685574764170; Wed, 31
 May 2023 16:12:44 -0700 (PDT)
Date:   Wed, 31 May 2023 16:12:35 -0700
In-Reply-To: <cover.1685574402.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1684790529.git.jonathantanmy@google.com> <cover.1685574402.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
Message-ID: <175dc912fe4cc7f79c5106875cc9e8c30618ab7a.1685574402.git.jonathantanmy@google.com>
Subject: [PATCH v2 1/3] t4216: test changed path filters with high bit paths
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Subsequent commits will teach Git another version of changed path
filter that has different behavior with paths that contain at least
one character with its high bit set, so test the existing behavior as
a baseline.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 t/t4216-log-bloom.sh | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/t/t4216-log-bloom.sh b/t/t4216-log-bloom.sh
index fa9d32facf..2ec5b5b5e7 100755
--- a/t/t4216-log-bloom.sh
+++ b/t/t4216-log-bloom.sh
@@ -404,4 +404,38 @@ test_expect_success 'Bloom generation backfills empty commits' '
 	)
 '
 
+get_bdat_offset () {
+	perl -0777 -ne \
+		'print unpack("N", "$1") if /BDAT\0\0\0\0(....)/ or exit 1' \
+		.git/objects/info/commit-graph
+}
+
+get_first_changed_path_filter () {
+	BDAT_OFFSET=$(get_bdat_offset) &&
+	perl -0777 -ne \
+		'print unpack("H*", substr($_, '$BDAT_OFFSET' + 12, 2))' \
+		.git/objects/info/commit-graph
+}
+
+# chosen to be the same under all Unicode normalization forms
+CENT=$(printf "\xc2\xa2")
+
+test_expect_success 'set up repo with high bit path, version 1 changed-path' '
+	git init highbit1 &&
+	test_commit -C highbit1 c1 "$CENT" &&
+	git -C highbit1 commit-graph write --reachable --changed-paths
+'
+
+test_expect_success 'check value of version 1 changed-path' '
+	(cd highbit1 &&
+		printf "52a9" >expect &&
+		get_first_changed_path_filter >actual &&
+		test_cmp expect actual)
+'
+
+test_expect_success 'version 1 changed-path used when version 1 requested' '
+	(cd highbit1 &&
+		test_bloom_filters_used "-- $CENT")
+'
+
 test_done
-- 
2.41.0.rc0.172.g3f132b7071-goog

