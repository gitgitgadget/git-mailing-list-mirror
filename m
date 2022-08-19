Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ED8FC32771
	for <git@archiver.kernel.org>; Fri, 19 Aug 2022 16:32:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353009AbiHSQcn (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Aug 2022 12:32:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353026AbiHSQaY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Aug 2022 12:30:24 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54B3D11B4FF
        for <git@vger.kernel.org>; Fri, 19 Aug 2022 09:04:37 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id a22so6200432edj.5
        for <git@vger.kernel.org>; Fri, 19 Aug 2022 09:04:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=cqA9SEcLtRKpsZOxTvEUaYqiTJf0VIUtiXd0AU7ytbo=;
        b=MIt0axL8XlquNkpiY6BJwhyEGRJbfAnLd/7klxe6mQbz7oHIfKOStQusrAF//DQSkl
         My5XCpwJbAg3YFAEFUQ7TaeqISADt4gazpWjFSjfcFhZ/1xNIoCdTk0kjsdV+g2x4gN5
         xUlxrRQjYhqrJ9YRrPKUQqgRUlEPjs2PSS3MafeWBZXSL4WJMGw2rL9TGhMaOovkVS+B
         af4A44jg1s16tpO5m7BIqy5AlpVr/zFPK4BU7BIYA+0SAZ1gnPm+3mI5bCe6sFM4NLX3
         Mq4+uJGURR5c+LZ2PHXR2twPQmQQLI/hnexYXXN3F2FjbpxUvrTnmGlBNRvKvaDuErPa
         bhKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=cqA9SEcLtRKpsZOxTvEUaYqiTJf0VIUtiXd0AU7ytbo=;
        b=vvvjeL/SShnwIY6Jh8h1aMjcjpeXqIHHs9th+mqzAryJBp/Ibe0r1OGOFSuaOQERTR
         B96xIPNhP/WxD9/nyZnJpohoEiKX7y8+w0Plwpi27va0FkpL0YIL8NV3y+zwurkzp990
         Fju5bxrWbue8u2mwtqkNZlbQMRZPMIy4I0YovdimcFA+KLZ+AAMzO9zlJ39R/TU3GOPe
         OzVQf42dwImw5VqJA6iXJwfnDIn2Q1eWVoRzgJEUn75qpHFxNp/Ayf0kX9YVivT5O+9y
         ZbSWpMsPOmuQtp4QqgjBYVHznA9TSW8C37ov/jp6PxFokhmQSYpcDAxuCEWbz7agYyjH
         DLPw==
X-Gm-Message-State: ACgBeo1RCYH5bvKoQv3f/flEXkrLL805RDXdmlAiUf+BvxxwtSQOUqPS
        izRwqZbr19BVum8lrO2v6ZworFG1DEo=
X-Google-Smtp-Source: AA6agR5ctC3+lQ7yltG+Vpmdgoy2k47KKixgKxkm8fylGQiBz9yUQXtp2UmZ2h8112ZkbV00SwflNw==
X-Received: by 2002:a05:6402:5c9:b0:446:fb0:56bb with SMTP id n9-20020a05640205c900b004460fb056bbmr6545733edx.173.1660925075866;
        Fri, 19 Aug 2022 09:04:35 -0700 (PDT)
Received: from localhost (84-236-78-250.pool.digikabel.hu. [84.236.78.250])
        by smtp.gmail.com with ESMTPSA id c23-20020a056402101700b00445b3cab975sm3258217edu.56.2022.08.19.09.04.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 09:04:35 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v2 02/20] t3301-notes.sh: check that default operation mode doesn't take arguments
Date:   Fri, 19 Aug 2022 18:03:53 +0200
Message-Id: <20220819160411.1791200-3-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.37.2.817.g36f84ce71d
In-Reply-To: <20220819160411.1791200-1-szeder.dev@gmail.com>
References: <20220725123857.2773963-1-szeder.dev@gmail.com>
 <20220819160411.1791200-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

'git notes' without a subcommand defaults to listing all notes and
doesn't accept any arguments.

We are about to teach parse-options to handle subcommands, and update
'git notes' to make use of that new feature.  So let's add a test to
make sure that the upcoming changes don't inadvertenly change the
behavior in this corner case.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 t/t3301-notes.sh | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/t/t3301-notes.sh b/t/t3301-notes.sh
index d742be8840..3288aaec7d 100755
--- a/t/t3301-notes.sh
+++ b/t/t3301-notes.sh
@@ -505,6 +505,11 @@ test_expect_success 'list notes with "git notes"' '
 	test_cmp expect actual
 '
 
+test_expect_success '"git notes" without subcommand does not take arguments' '
+	test_expect_code 129 git notes HEAD^^ 2>err &&
+	grep "^error: unknown subcommand" err
+'
+
 test_expect_success 'list specific note with "git notes list <object>"' '
 	git rev-parse refs/notes/commits:$commit_3 >expect &&
 	git notes list HEAD^^ >actual &&
-- 
2.37.2.817.g36f84ce71d

