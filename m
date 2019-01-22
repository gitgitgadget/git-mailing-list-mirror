Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 491EC1F453
	for <e@80x24.org>; Tue, 22 Jan 2019 21:46:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726678AbfAVVqH (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Jan 2019 16:46:07 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:42276 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726225AbfAVVqH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Jan 2019 16:46:07 -0500
Received: by mail-lf1-f65.google.com with SMTP id l10so32363lfh.9
        for <git@vger.kernel.org>; Tue, 22 Jan 2019 13:46:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yzxevg+l8wd1NsLpjFU9BGy/PCYgzOXb+0cR7ALkCAE=;
        b=bGg3TJ+S8puLERlvxz4nFh9qZhCBip3NbFDsDVqvK6OeVaF9jX9UBTIQ2HLd6sS4bU
         X0WMV6a7ujiU9AC4it5tx3gbY2+Mseh0vP3wVJmXxC9vIbvMsX4w6/NqalF+W3Jg5y1P
         nBum+P4R8f5/rdPzNBu5HUO0NeOP+Z3xpqPeHaYBtUYDI/G1fXz4bEYXhEIpx1DquB3g
         HH2AtfOrsse/KHuaLxH+GBfbutRbssX7FFucRsmVl+TlC2W5QIFH9mXo++0Fnr/caT+m
         A5I8zQY8Vx14gBhuaBtX35JFgpNX7xCdVc6a+SGGIURFHQdQGl1yGXSZ+nOBiyy6Yciq
         itCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yzxevg+l8wd1NsLpjFU9BGy/PCYgzOXb+0cR7ALkCAE=;
        b=Awhb0wNuxb+JXMnXm+KRXjU0+N7TLUzMjFTOlZ3OSUr3+m07eEkOEQynedwlhygAoE
         sVu4vt7gd3hjd9VvNMVHeh5QKaUHybkL14lBWmdy3Ex1Mdz69SS8Eykpfwj8/7oIFbvu
         m1j2ZABWpKicreVtWhS7wr1fr+jWrvPjqILbrIPER/wJ8CkNaxzZwqzlMUP3JXu5QGri
         LxYLHu5Bx1Z18Jtw1lGzX+bwXE2Ewgd9Agg7SSkyNeU5lDSrbcbcAMhv+0SErNvCUgqe
         LyUl+ThDNRDb7adnJRG7pnjetgsOO7Vvm0cmSHR5X2X6wrGJlsMdjMARdFXrnJ4TRzzM
         oR1A==
X-Gm-Message-State: AJcUukdr5y1/QqyImcbwo/GKVUyZCWb3H8+a1Mkp/GJw6JUzme8jhM/S
        cUQD7c39+QmOItx1VcUV1qDXlQK/
X-Google-Smtp-Source: ALg8bN5zJ0pqcqgPJ+D0P286vA/LsuI3QIfKo0eN2j1M/3MwyEOo85MXUnb8bLzShRvNq9RIgG/iTA==
X-Received: by 2002:a19:5508:: with SMTP id n8mr1796473lfe.164.1548193564730;
        Tue, 22 Jan 2019 13:46:04 -0800 (PST)
Received: from localhost.localdomain (31-211-229-121.customers.ownit.se. [31.211.229.121])
        by smtp.gmail.com with ESMTPSA id k3-v6sm188706lja.8.2019.01.22.13.46.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Jan 2019 13:46:03 -0800 (PST)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        "brian m . carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH v3 1/2] setup: free old value before setting `work_tree`
Date:   Tue, 22 Jan 2019 22:45:47 +0100
Message-Id: <5be3e4fb47f534e7b1467c1d844996bcd1121ca0.1548186510.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.20.1.98.gecbdaf0899
In-Reply-To: <cover.1548186510.git.martin.agren@gmail.com>
References: <CAN0heSq0Nb-WdhDFpdwgjUMrkJNbviAtietn=B5nJg-rDgcR_g@mail.gmail.com> <cover.1548186510.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Before assigning to `data->work_tree` in `read_worktree_config()`, free
any value we might already have picked up, so that we do not leak it.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 setup.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/setup.c b/setup.c
index 1be5037f12..bb633942bb 100644
--- a/setup.c
+++ b/setup.c
@@ -411,6 +411,7 @@ static int read_worktree_config(const char *var, const char *value, void *vdata)
 	} else if (strcmp(var, "core.worktree") == 0) {
 		if (!value)
 			return config_error_nonbool(var);
+		free(data->work_tree);
 		data->work_tree = xstrdup(value);
 	}
 	return 0;
-- 
2.20.1.98.gecbdaf0899

