Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB313C43334
	for <git@archiver.kernel.org>; Mon, 25 Jul 2022 12:39:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235158AbiGYMjR (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Jul 2022 08:39:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234945AbiGYMjJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Jul 2022 08:39:09 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00A58BC98
        for <git@vger.kernel.org>; Mon, 25 Jul 2022 05:39:07 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id l23so20349745ejr.5
        for <git@vger.kernel.org>; Mon, 25 Jul 2022 05:39:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=znF1FkXzYDeBnNlH3METubqmjWeYDqmADq07GFlUx3I=;
        b=FYyqxFwkdywBjhXwUyd1pvf0yrbMwZzcEGgqM8tW2dCJ1Il8jhHzaV0377htQgivO6
         b3t3h2uDw3zsvIzXAM/lLBiiBFUXvC/CY9BSKAJ3NdFu+cmEmQjaj53ZIMokKlf81LMG
         8wBzpvpRNkYZZS7Gyzjx7OIwRgMqaMEbzw9b5pKUCDOTTDJRwQv/7DYt3T2sHNPQux87
         EAmEqCTbc1Le8CsIQ7NMl2RjC6R1lBdWm5tsam/gpgBX8yFEONYcSg4gbenMplMp2rD9
         3j1+eDtKkdpMtA53ARipaiEBSSMAwNM8JB2HfKiGuXYjdelcr0igMhkMqhCBuTa27jTK
         DQ2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=znF1FkXzYDeBnNlH3METubqmjWeYDqmADq07GFlUx3I=;
        b=JyJpffo76FsREvYB8MucjCSezadO1sRaIcM3u3LDpDrXEAGqNr+BdBn56MPSaCwRT7
         /Fa3PViN4Fd5adMNxyVdQD2V1kmbri8LjH3lUyqwrHq5hB7QNamIgZo5S1hasY0vCeu9
         bW8Dzh8gcET5nQbNgKh65RJCLalRxf3hFocplxGpZW/CAMSmTnwWc/omFGomgVieFaNW
         Rr7HU7b1UQw0hpv14KRLUTMHKJAbVrcb38PnNKX8NqZ6CSZbXxUi9vjqKTLcpF2f02l1
         UYe+SbNWYuE8J4uCEizkEevsOQz6XE9OuZC6zKvvh9aWPdj2YT208np6JSluQNvGTrSI
         USJA==
X-Gm-Message-State: AJIora++VGw3NDFp7hhNCRgFCngCdNSbULyQckvJmu49k+wsZhGSVwIZ
        eFQKUgen4cXQ9D2VFE0w8UejMJq65Fs=
X-Google-Smtp-Source: AGRyM1tZwalalb587shzDM2bQax6MytnC5sm5bPq/KEVnWfIR21mp6Kn2fTe5F3VFQnXIsWqoWYKJg==
X-Received: by 2002:a17:907:1b1c:b0:72f:9aac:ee41 with SMTP id mp28-20020a1709071b1c00b0072f9aacee41mr9947354ejc.56.1658752746509;
        Mon, 25 Jul 2022 05:39:06 -0700 (PDT)
Received: from localhost (94-21-23-94.pool.digikabel.hu. [94.21.23.94])
        by smtp.gmail.com with ESMTPSA id l22-20020a170906795600b006feb875503fsm5260111ejo.78.2022.07.25.05.39.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 05:39:06 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 02/20] t3301-notes.sh: check that default operation mode doesn't take arguments
Date:   Mon, 25 Jul 2022 14:38:39 +0200
Message-Id: <20220725123857.2773963-3-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.37.1.633.g6a0fa73e39
In-Reply-To: <20220725123857.2773963-1-szeder.dev@gmail.com>
References: <20220725123857.2773963-1-szeder.dev@gmail.com>
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
2.37.1.633.g6a0fa73e39

