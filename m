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
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEABDC433B4
	for <git@archiver.kernel.org>; Mon, 10 May 2021 15:35:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9270A61409
	for <git@archiver.kernel.org>; Mon, 10 May 2021 15:35:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234596AbhEJPgb (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 May 2021 11:36:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236060AbhEJPgD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 May 2021 11:36:03 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DC6DC061760
        for <git@vger.kernel.org>; Mon, 10 May 2021 08:34:58 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id z9so23955947lfu.8
        for <git@vger.kernel.org>; Mon, 10 May 2021 08:34:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0OfjDCFK40CHYWc5u5uSaXiZBcYaZsJ1ZH5HBXLLJ+Y=;
        b=K92j7KjhcQTMKJgUJU3D3G0HfulcnygJHy9WFD//XqnL1ILZTnxreUhWWiELIFYqZH
         xszGc/IxoKgxXJw/Qlr+tc2atYxKbhMmGeqd0XDlNPQs//zC6WQWlB+EPCyBCuDJ7Yrr
         HnLU3hwX4yyDpdgTEQcKqt2JYI3pSRi0Yt48/pvYkkU3lwwqCCulHqy9t1eb3E4VqK6H
         UhslMWv7J1aFvi6omyWnEKe4g5S7Y1uEpcLjDU7IZy7Vgoh7vLvmXf4rJuVjhp0nZwO1
         ZEUH2Llisdisarx+UBDp1ejP9y2gGf7VT+eeMKkzAIllE2WxSrk36NW0tel09a2R954T
         lqIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0OfjDCFK40CHYWc5u5uSaXiZBcYaZsJ1ZH5HBXLLJ+Y=;
        b=OCwayl6XFuco87b61VPK/xQ9BfBphWJb4Mkmgy2DAra5apynm+SGWQzqMQnX5hSbV8
         VJHBlwadOst4y2i9RZ4WNWETvHRF3RfvTdUAunqwcGKaxGMTg64fdQExW+M+3hKIcflm
         WQE9rKshjGub7yZL2MbmZJEaz2lh+bVc+i/di0/U6F4d8HMXhYx9fvC4r4eTXzqrxMV6
         PD+vn2ttcJg4CHL4EMBODKPFi7xOFojdwzURt6et0AiaB8G9G6xwKdPSIsJDMKARE2ai
         dKPgXeZZGmzXvDInfRT35S7eoIn6rb+DqvVYQYxZCwyZNRUBSZS4M8N8bPI5Ij3sN3qO
         0Imw==
X-Gm-Message-State: AOAM533oMXIvybQ8SwHENLQdHwPnh/ExWvuzUV4t/aKl2CZg8I4M11MI
        ZBL/7z/sjnnYx79f7bFBaNw=
X-Google-Smtp-Source: ABdhPJxStqBC0wGLu7mSCu0pj6cEeTOZGa8516OLOwXN/6A7FDekxwo+fW9UBpdcpanVghg5utdm3A==
X-Received: by 2002:a05:6512:3f27:: with SMTP id y39mr16766026lfa.166.1620660897088;
        Mon, 10 May 2021 08:34:57 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id p8sm1525840lfe.224.2021.05.10.08.34.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 May 2021 08:34:56 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Philip Oakley <philipoakley@iee.email>,
        Elijah Newren <newren@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Alex Henrie <alexhenrie24@gmail.com>,
        git@vger.kernel.org, Sergey Organov <sorganov@gmail.com>
Subject: [PATCH 3/6] git-svn: stop passing "-m" to "git rev-list"
Date:   Mon, 10 May 2021 18:34:48 +0300
Message-Id: <20210510153451.15090-4-sorganov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210510153451.15090-1-sorganov@gmail.com>
References: <CAMMLpeR-W35Qq6a343ifrxJ=mwBc_VcXZtVrBYDpJTySNBroFw@mail.gmail.com>
 <20210510153451.15090-1-sorganov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

rev-list doesn't utilize -m. It happens to eat it silently, so this
bug went unnoticed.

Signed-off-by: Sergey Organov <sorganov@gmail.com>
---
 perl/Git/SVN.pm | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/perl/Git/SVN.pm b/perl/Git/SVN.pm
index f6f1dc03c608..35ff5a68963d 100644
--- a/perl/Git/SVN.pm
+++ b/perl/Git/SVN.pm
@@ -1636,7 +1636,7 @@ sub has_no_changes {
 	my $commit = shift;
 
 	my @revs = split / /, command_oneline(
-		qw(rev-list --parents -1 -m), $commit);
+		qw(rev-list --parents -1), $commit);
 
 	# Commits with no parents, e.g. the start of a partial branch,
 	# have changes by definition.
-- 
2.25.1

