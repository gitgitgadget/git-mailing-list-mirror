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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A391FC48BDF
	for <git@archiver.kernel.org>; Fri, 18 Jun 2021 18:25:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8BEE6611AC
	for <git@archiver.kernel.org>; Fri, 18 Jun 2021 18:25:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236298AbhFRS1y (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Jun 2021 14:27:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235630AbhFRS1t (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Jun 2021 14:27:49 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DE4BC0617A6
        for <git@vger.kernel.org>; Fri, 18 Jun 2021 11:25:39 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id o17-20020a9d76510000b02903eabfc221a9so10636968otl.0
        for <git@vger.kernel.org>; Fri, 18 Jun 2021 11:25:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0ggTZ1zBKFUmWxybCpPm5msiXL3W9D+UYilIBVeyoDQ=;
        b=GOySLJhGisa+WBFixNMgttyFKQmo31C7U+u7/9G8gvUZzSs0ADUduNqXzKMqK6OO/k
         odSD/yUxL8a/3pU7Xvkmd05Qaa3IEZwLKgrAlzNiN6qwvVI4lKZozhdF3KhEik9oqouB
         CuQmx8S4HpgLhRfHCgPBkfsx8k7japttxRJmjyJwJjCczkcZSMgI0EuY8SZpqVItgMJ/
         V+ER8s6M7q6X4QdaUMXLsiR5K613citAusllKx/BWgLgio6qXavp1bCz4+8e+2N09850
         z66T6Lmm0V/s28L5usllhTvb5ZjsqBantMzGIhdZA/EU4JTGZH5T7rxDAeLEXjCQkFx+
         xztw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0ggTZ1zBKFUmWxybCpPm5msiXL3W9D+UYilIBVeyoDQ=;
        b=WEJ7JVlL+cvwAV9+6UgsrYc9BBCzT6RUYZE0NxGkmhGZKBYbOkfmlZF2OJSDUm9UKl
         48gnH+r0Opixj7vuXnXtk7RhPU3AcKw17/OXwMylFHsbUjET8iSQunKc+r6d6xjqqGL2
         A9JWy2bIQSv24Jla0rgHBis2twM3s3NppRlCUiS/smmeMjxJ3OM+jgCOJiniQyxyFVuI
         Zlio/NBxKFkCJ6Zcp1xTdug0Tm699agXC6dBTDZ3fR8CVaIjCtxagpYVYPzJmYvPq5ml
         3ZlGu1J780m78yVxpvn6sxHCp5zFgQcmQ0H5VomVCk9p8oljrTCA6ME+gc5LeuNPPPS0
         jXCQ==
X-Gm-Message-State: AOAM531ZGcMe1d2Ykf01vGXEjSweFfi9n1bGeTKjkjef0sAKeu1GPTjw
        XsXanw/HTD6ePJy45m9JLG5Tf8CeI3pRpA==
X-Google-Smtp-Source: ABdhPJwtEkepI0PU8DpL2Ho42cTS5Uq0tcgsgNaDgI+e/KVRlp24LOsJ9w0Omp4OllBWvhYapIEiRQ==
X-Received: by 2002:a05:6830:1f51:: with SMTP id u17mr10598743oth.25.1624040738649;
        Fri, 18 Jun 2021 11:25:38 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id o6sm1180430ote.81.2021.06.18.11.25.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jun 2021 11:25:38 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 10/45] test: completion: switch __gitcomp_nl prefix test
Date:   Fri, 18 Jun 2021 13:24:43 -0500
Message-Id: <20210618182518.697912-11-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210618182518.697912-1-felipe.contreras@gmail.com>
References: <20210618182518.697912-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

By default COMP_WORDBREAKS includes =, so it's not realistic to test for
a prefix that almost never will be there.

No functional changes.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 t/t9902-completion.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index bffe1b0928..d21dca4abd 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -568,9 +568,9 @@ test_expect_success '__gitcomp_nl - trailing space' '
 '
 
 test_expect_success '__gitcomp_nl - prefix' '
-	test_gitcomp_nl "--fixup=m" "$refs" "--fixup=" "m" <<-EOF
-	--fixup=main Z
-	--fixup=maint Z
+	test_gitcomp_nl "branch.m" "$refs" "branch." "m" <<-EOF
+	branch.main Z
+	branch.maint Z
 	EOF
 '
 
-- 
2.32.0

