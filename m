Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 270D820A17
	for <e@80x24.org>; Mon, 23 Jan 2017 20:35:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751505AbdAWUfk (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Jan 2017 15:35:40 -0500
Received: from mail-pg0-f41.google.com ([74.125.83.41]:34095 "EHLO
        mail-pg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751102AbdAWUfj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Jan 2017 15:35:39 -0500
Received: by mail-pg0-f41.google.com with SMTP id 14so47681943pgg.1
        for <git@vger.kernel.org>; Mon, 23 Jan 2017 12:35:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fZkG/QdaR2rxIyINK+QrFFJ/jWQdfe+hFkV33p/P47M=;
        b=lJdrFiFVC537ZDh2GO4zkKhT6TAg4cfETPyI7kiPHGT7GonOopwrUYAva2qZG34A5V
         85MMf55l7dK2LhHnzLiP0ati4uM648vMJtlpKu6NExDY83Ji8Ev6FlkspW7LPuyNf2mh
         MkYZaht56klP7eZd1PghugHJtErU1bERxQEB98B95dj1AABh5U56Nx1drC3SXJUdP+aQ
         eQqpvhWbe5N5nR8Ncu66l5++q30pzUgmYeJMS8lDd7DhpWy3uE6YBBgFqPIz8TmKkzza
         PZqsqsNaSIQtbOq4oZwH7TtOxtcRs/zOIEBDXrz1H5Q0ALhu+E6OHhZyR/Qd+AB94pGg
         5mVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=fZkG/QdaR2rxIyINK+QrFFJ/jWQdfe+hFkV33p/P47M=;
        b=qzIj+bnTyYBn5BTwwZ7O+k0DUU6KRD3APMYnD5I+JIJf1YLKo1EIxAFX0CJw3Dmcck
         GZFDKfFCLfbHOp+PJ0u6MED7vace0v2aui0YQ7CxKGbMNE3R0qakdkYCvh5Txz0J6utN
         X4MuYq0DxZc58ZoSfxJzCuFJuSokyvisCkGqt+kACt+CeH+69+49ywW7n86GITyM+uC+
         qmH/JLmgO91BtYtLrQDCPBHjN7udgCW0/gn98M53fUajkozhd4opMpNO3ps7rweszgff
         2/XdcXiKYJotYAz8zZP3KjG8ltWvh4NofoJf1KChjAcRmS/I56FYnFQeG0unuj0nkW9h
         r+Yw==
X-Gm-Message-State: AIkVDXILB4jBq4LYAJkh4IMWvQCJks078o6vTTekNh8ntvFY0V9RTB1vpPnXmv+MNp3FaecD
X-Received: by 10.99.95.216 with SMTP id t207mr34917625pgb.0.1485203738554;
        Mon, 23 Jan 2017 12:35:38 -0800 (PST)
Received: from roshar.mtv.corp.google.com ([100.96.238.26])
        by smtp.gmail.com with ESMTPSA id z29sm39280832pgc.7.2017.01.23.12.35.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 23 Jan 2017 12:35:37 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, sbeller@google.com,
        pclouds@gmail.com, Brandon Williams <bmwill@google.com>
Subject: [PATCH v2 01/27] commit.c: use strchrnul() to scan for one line
Date:   Mon, 23 Jan 2017 12:34:59 -0800
Message-Id: <20170123203525.185058-2-bmwill@google.com>
X-Mailer: git-send-email 2.11.0.483.g087da7b7c-goog
In-Reply-To: <20170123203525.185058-1-bmwill@google.com>
References: <20170112235354.153403-1-bmwill@google.com>
 <20170123203525.185058-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Junio C Hamano <gitster@pobox.com>

Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Brandon Williams <bmwill@google.com>
---
 commit.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/commit.c b/commit.c
index 2cf85158b..0c4ee3de4 100644
--- a/commit.c
+++ b/commit.c
@@ -415,8 +415,7 @@ int find_commit_subject(const char *commit_buffer, const char **subject)
 		p++;
 	if (*p) {
 		p = skip_blank_lines(p + 2);
-		for (eol = p; *eol && *eol != '\n'; eol++)
-			; /* do nothing */
+		eol = strchrnul(p, '\n');
 	} else
 		eol = p;
 
-- 
2.11.0.483.g087da7b7c-goog

