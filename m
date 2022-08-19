Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B382C28B2B
	for <git@archiver.kernel.org>; Fri, 19 Aug 2022 16:33:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353034AbiHSQdk (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Aug 2022 12:33:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353013AbiHSQaX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Aug 2022 12:30:23 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D890611BB18
        for <git@vger.kernel.org>; Fri, 19 Aug 2022 09:04:39 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id z2so6225389edc.1
        for <git@vger.kernel.org>; Fri, 19 Aug 2022 09:04:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=G3WecurfiAX9v2QnzN9OU0PPWWUXCsfqVqdSZ2A5O4E=;
        b=Dd+nXdqYy+zwtDYzueWL0e+2GOAhxKsAr76CrsbVX5x+IExbFzIsQ4IrlbifL16kSk
         P31EYOiVEiTzimai45ycdZzz++EhyaMe207jZOe/VOFmA95NGewjyZ7+lrJitUOmP3BO
         kmENy8zwFxXEI0mkvvC1X5hn0RqlN2oi4b7j7Zq1Fh6l7DeUJCaqtsdGqmwv+0q1BNWX
         gUBaktBmPKrsGbKDgcvcaTWty000qtk+d/5YPBQTLS1JcQINZv2jxZYM79axWaXUz3WM
         xBBjzhhJZER7jwHcpecCyKTXSjclCYhKvkvBkN8fWOeesnkJcgIuM24Jgkh0d4NuAkOy
         vbZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=G3WecurfiAX9v2QnzN9OU0PPWWUXCsfqVqdSZ2A5O4E=;
        b=aFt/vywhIlvg1h5S8jXDa6BATiwOvSokpdOChONGBNx6cjyf+lfmVR057zH3B8GDMP
         V9ysUshdVUmZwseEFOM9r8RWrGNqgMroYMsNdmQNfYKP8+bMC7DlgKH1fCcpukhDOKh+
         UcdpmNmGYcpogzViYqi8CFGiTdrmw/xvPVkCO/UBYaHA0lj24n1UCuqI0B+UmTGWjfxa
         1o2zwGQkOr6NFIchGSz7E0ZGMKgL3rPtpQLLoC22xphZymca6juFaFkqXrP91Psinu5Z
         H7iq7XLbx+x2pbXNfWG77f6kZ4nudsua0/F6laO5XJTOlDo7Faml8k0Wg4oVQ072Sy4l
         2jzQ==
X-Gm-Message-State: ACgBeo2bCCAQYqriYG7v7KUqH7MMlMnQq1X+WiiaYiFwmH9sBVTp5vWK
        R91Wlpfb+lWjWQUHgjhoJK2Q1t6pu6k=
X-Google-Smtp-Source: AA6agR57A1XsSwVHdZg/13N5FPgfY37Vw+hyRS8MULtmm/V83Ldi0/IF5ZbEkqSbqyEbi1tfApmizA==
X-Received: by 2002:a05:6402:34cf:b0:43d:96fd:bdfa with SMTP id w15-20020a05640234cf00b0043d96fdbdfamr6584215edc.40.1660925077797;
        Fri, 19 Aug 2022 09:04:37 -0700 (PDT)
Received: from localhost (84-236-78-250.pool.digikabel.hu. [84.236.78.250])
        by smtp.gmail.com with ESMTPSA id q3-20020a056402040300b00445e1489313sm3237507edv.94.2022.08.19.09.04.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 09:04:37 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v2 03/20] t5505-remote.sh: check the behavior without a subcommand
Date:   Fri, 19 Aug 2022 18:03:54 +0200
Message-Id: <20220819160411.1791200-4-szeder.dev@gmail.com>
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

'git remote' without a subcommand defaults to listing all remotes and
doesn't accept any arguments except the '-v|--verbose' option.

We are about to teach parse-options to handle subcommands, and update
'git remote' to make use of that new feature.  So let's add some tests
to make sure that the upcoming changes don't inadvertently change the
behavior in these cases.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 t/t5505-remote.sh | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
index 6c7370f87f..a549a21ef6 100755
--- a/t/t5505-remote.sh
+++ b/t/t5505-remote.sh
@@ -241,6 +241,26 @@ test_expect_success 'add invalid foreign_vcs remote' '
 	test_cmp expect actual
 '
 
+test_expect_success 'without subcommand' '
+	echo origin >expect &&
+	git -C test remote >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'without subcommand accepts -v' '
+	cat >expect <<-EOF &&
+	origin	$(pwd)/one (fetch)
+	origin	$(pwd)/one (push)
+	EOF
+	git -C test remote -v >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'without subcommand does not take arguments' '
+	test_expect_code 129 git -C test remote origin 2>err &&
+	grep "^error: Unknown subcommand:" err
+'
+
 cat >test/expect <<EOF
 * remote origin
   Fetch URL: $(pwd)/one
-- 
2.37.2.817.g36f84ce71d

