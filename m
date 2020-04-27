Return-Path: <SRS0=mOGp=6L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C6CEC54FD0
	for <git@archiver.kernel.org>; Mon, 27 Apr 2020 14:22:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E7EF6206B9
	for <git@archiver.kernel.org>; Mon, 27 Apr 2020 14:22:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I46Ziqv8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728058AbgD0OW6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Apr 2020 10:22:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727073AbgD0OW5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Apr 2020 10:22:57 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 666E8C0610D5
        for <git@vger.kernel.org>; Mon, 27 Apr 2020 07:22:57 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id t9so7587157pjw.0
        for <git@vger.kernel.org>; Mon, 27 Apr 2020 07:22:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=j1L11PcE6Ew+R56eB2hiiV0LfYWd5vVO/ImVb8TcPHg=;
        b=I46Ziqv82I79/B/e38H99sMl3G7iF5pQfDPv2QLK+9JW8H4vvuKvyDYjrDTexYvHbX
         EWqI012338fhg08HIN5DRDSBB2VZYerBzuhYMom9Awg3JhR/v+JlaSFunOeOv3rmMjMd
         UNZcinIwhk4NWrObhudNkbjnjgCyC1LuMVZW6ISbjzNrGWEvk3jB8V69e7sgWQgFxRyo
         LTaQs5B1gQO9WcjrPz6iyoBckWKaAo4gVZaUVShepmYvHPHAJxgh5ZmldMLaCo1gp0/z
         kV5VZHsHFGaMQrFNqSUNF5bkSaJEPxdQ4BBlBU7+0oG6+p/sE8O/KDyhZQz16Ym8/M9Z
         /M7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=j1L11PcE6Ew+R56eB2hiiV0LfYWd5vVO/ImVb8TcPHg=;
        b=s/SZcOp1aQqbfDwomv7Qv2IeTqfgseHcy2xHXIxkX8sDSQemO5ZeqtxvOSaq60JsUk
         cIheBwMDdK3U6fFXAy5fVSDe9979Tqq4WK9Iwj/KunC6uzmGf6bIK9NPZJAG2cAhI7yM
         GwXQgvOCJYuZMioD5Tzh5x42vUOc3ARbnpbe93z28NoeT2gZy21/K22zj058lBmv3TWi
         NOk6wfyffFhZ4TsP1e5D7Qx3xNMhOWk1QUvdcIlT/0RIyhYcbaEaBJa9oPaebYhnvqQZ
         d9DVlQLJmniWnzJRfK+mkGcUftxEwsqewNXcKA0NHzvc+SQgjPy6UMiA99BZlZOEKBfF
         6Qtw==
X-Gm-Message-State: AGi0PuY7wkvd6aPCU8P0l/aEhWlTXa436nAj550i9fABuFk6C8EOY92J
        qWik9tYb9ek5pAqgHPLy19jr+Hv2
X-Google-Smtp-Source: APiQypI/7Ocl7e1w1kO5zPmMkZ6/DMh+UEKc8828Wp6U6T0oUR/jnrWHbqsdh/fhuEjYg1tvapt2Jg==
X-Received: by 2002:a17:902:8305:: with SMTP id bd5mr22387410plb.114.1587997376809;
        Mon, 27 Apr 2020 07:22:56 -0700 (PDT)
Received: from localhost.localdomain ([2402:800:6374:bf12:8518:c5e6:e4cc:3967])
        by smtp.gmail.com with ESMTPSA id c1sm12589602pfc.94.2020.04.27.07.22.54
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Apr 2020 07:22:56 -0700 (PDT)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>, Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: [PATCH v3 3/4] graph.c: limit linkage of internal variable
Date:   Mon, 27 Apr 2020 21:22:36 +0700
Message-Id: <4e7580e1d1d844d0ed65e419fc039008740c4b7b.1587996766.git.congdanhqx@gmail.com>
X-Mailer: git-send-email 2.26.2.526.g744177e7f7
In-Reply-To: <cover.1587996765.git.congdanhqx@gmail.com>
References: <cover.1587648870.git.congdanhqx@gmail.com> <cover.1587996765.git.congdanhqx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
---
 graph.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/graph.c b/graph.c
index 4fb25ad464..4cd9915075 100644
--- a/graph.c
+++ b/graph.c
@@ -1055,7 +1055,7 @@ static void graph_output_commit_line(struct git_graph *graph, struct graph_line
 		graph_update_state(graph, GRAPH_COLLAPSING);
 }
 
-const char merge_chars[] = {'/', '|', '\\'};
+static const char merge_chars[] = {'/', '|', '\\'};
 
 static void graph_output_post_merge_line(struct git_graph *graph, struct graph_line *line)
 {
-- 
2.26.2.526.g744177e7f7

