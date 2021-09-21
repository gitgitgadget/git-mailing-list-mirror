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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7034C433F5
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 22:40:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B8A936109E
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 22:40:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232441AbhIUWmT (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Sep 2021 18:42:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232339AbhIUWmR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Sep 2021 18:42:17 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4376DC061574
        for <git@vger.kernel.org>; Tue, 21 Sep 2021 15:40:48 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id d6so1034933wrc.11
        for <git@vger.kernel.org>; Tue, 21 Sep 2021 15:40:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WMK/5xqLGLWuWgsb6dd2S+NkuHDDkfyvFyR2HMjcSbU=;
        b=YF3XtDa4Mzp3fHit9dje/5q6/eCDRk7MEnRtXkC+W3XFi3mE9hiFj/AHjfOBWz7vlr
         xPXGp7rhzdOdYeQbE5Lm5l5JDgS56sounukpscB3oZea7KMb50Lj9q/e4+1X9mh+Gi+6
         3ids1LnurP8xOXzVe7JE60wL1e5HFZ1Yj9vtC/uVhYooZWrVTK+KjwpEBd0isUx0AUqs
         0QkHIOK7U/aehyG0xgqqlGQwt/NxvsZhTvBe8lcII8z77oDZk98UpY7et67P7XpwI1N4
         w/JxVynND13s1uLdx612v3idn3LBToc5alzhi4gR1YwsFVspH8EHnSPVwNrN+bokX8oA
         1TCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WMK/5xqLGLWuWgsb6dd2S+NkuHDDkfyvFyR2HMjcSbU=;
        b=LAQFtaY1+foGE9btTekU9EC8XNm5vaUKCmQS3AzIDzKZ931JWVW/w+hIfwGgIRBlNM
         XSkFeWw8LQSxgL7cb6v1hqqOaZnnKvP/j7IbapJ8FJ1Lhr2oZrlXcZ6NcCLW2jGNbivq
         kE3y/uaN3UYmTxj4eZAm/bWjVU89MxnAhYChxNp473FpLJaUicjtjtmOMkp2TLEnaQh9
         VZn/2l3PziyUc8FA4h/4+i041nluY2VqX7axvl7Mf3rVfhM5pHvbEYNXf7F/Q4dPDmct
         I3PcfYpcZfh8YiI/uJjbn/JEjDTVhG2IqJtmGMOi30uDSL7VEbhW0k1H0Ynotz7/dWwn
         wzrw==
X-Gm-Message-State: AOAM533y2GAd9WmP9ZyArIjwIOtWJWyb5jyFSBUP7xqrZICOAk+Zun81
        j0TKlxSCiBK5Re/r4tFM3qIt00sfy/W2vQ==
X-Google-Smtp-Source: ABdhPJzlPxAQmZynUx7hxEL5/uZjFKISqWmMFWlcFUljahnYvflTJGE3JPbvdcsqiWOTIy+pfvKQOw==
X-Received: by 2002:adf:f48b:: with SMTP id l11mr37759864wro.254.1632264046562;
        Tue, 21 Sep 2021 15:40:46 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l7sm3846121wmp.48.2021.09.21.15.40.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Sep 2021 15:40:45 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Philip Oakley <philipoakley@iee.email>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 3/9] help tests: add test for --config output
Date:   Wed, 22 Sep 2021 00:40:33 +0200
Message-Id: <patch-v3-3.9-6a8965e1b5b-20210921T223223Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1098.gf02a64c1a2d
In-Reply-To: <cover-v3-0.9-00000000000-20210921T223223Z-avarab@gmail.com>
References: <cover-v2-0.5-00000000000-20210910T112545Z-avarab@gmail.com> <cover-v3-0.9-00000000000-20210921T223223Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a missing test for checking what the --config output added in
ac68a93fd2 (help: add --config to list all available config,
2018-05-26) looks like. We should not be emitting anything except
config variables and the brief usage information at the end here.

The second test regexp here might not match three-level variables in
general, as their second level could contain ".", but in this case
we're always emitting what we extract from the documentation, so it's
all strings like:

    foo.<name>.bar

If we did introduce something like variable example content here we'd
like this to break, since we'd then be likely to break the
git-completion.bash.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t0012-help.sh | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/t/t0012-help.sh b/t/t0012-help.sh
index 0525ec3ee58..63c4adb99be 100755
--- a/t/t0012-help.sh
+++ b/t/t0012-help.sh
@@ -77,6 +77,19 @@ test_expect_success 'git help -g' '
 	test_i18ngrep "^   tutorial   " help.output
 '
 
+test_expect_success 'git help -c' '
+	git help -c >help.output &&
+	cat >expect <<-\EOF &&
+
+	'\''git help config'\'' for more information
+	EOF
+	grep -v -E \
+		-e "^[^.]+\.[^.]+$" \
+		-e "^[^.]+\.[^.]+\.[^.]+$" \
+		help.output >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'generate builtin list' '
 	git --list-cmds=builtins >builtins
 '
-- 
2.33.0.1098.gf02a64c1a2d

