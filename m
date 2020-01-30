Return-Path: <SRS0=gonI=3T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE5B2C2D0DB
	for <git@archiver.kernel.org>; Thu, 30 Jan 2020 20:33:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E69F20708
	for <git@archiver.kernel.org>; Thu, 30 Jan 2020 20:33:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp-br.20150623.gappssmtp.com header.i=@usp-br.20150623.gappssmtp.com header.b="gMcw6zdo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727775AbgA3Udd (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jan 2020 15:33:33 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:46471 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726514AbgA3Udd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jan 2020 15:33:33 -0500
Received: by mail-qk1-f195.google.com with SMTP id g195so4267118qke.13
        for <git@vger.kernel.org>; Thu, 30 Jan 2020 12:33:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bCiHX3i0ze8uxpSTqlorZAcd0L4sog7vYgQY125mN2E=;
        b=gMcw6zdoRM9REVQm+g97TKH+6qKXP82ec1axuvctO7xJcugko6Jlgqgo5cWwizjf1E
         32smiUM4o2gStUqqNBG7iqzwjFiJpTWZm/B32tp0wTRuFkpXDgS1ZAf+buq8Z+5XR6Rj
         ktR3Lq/kQF7qOe5xNF9Jye1Ac+K/jgDtP6uBJdOWr0zh4pZ/4HHz5IWUG86yX3oGBvga
         mjqkn6d00vMM5WmqaBP32idUqHhgDxDAuYFbWs8mpIoVI9LOe2eJfYIozjVQHmNAUi3K
         B1rtaXgzYviY3Q4X56/Of2x99nIM3LugSC3lWusf6sS2W4hxXdKWfdXXuD5sr4zxR14F
         jYuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bCiHX3i0ze8uxpSTqlorZAcd0L4sog7vYgQY125mN2E=;
        b=lJVGx1EAywsDLK5aGy0wMfuOoE/2GAezMePb5pWrZRx4lNXoZue7FzuNUgj9qULYFN
         Nafk6nkCVzuUc0ITI+1s+Pr2zvX+HKLlRv3dRXl6ViNJEXXfjXX3ztaMacHcVcZ9vmnb
         PpzTcBp3msfm0x4ksUkorUMsYEnYmO4QfChvjlJvIYTFC9ofEZwQ2KPCRoh8brp1XETv
         i/PhswB09dqrcxKk9LFwqliZ+lV+k6u7BT+DsDydZZ8s0M5PpFQaf2iVFb6EwuHSCTVG
         kFNcr4/SKh+QOGoEyTSIZwWF6P/RbSpTdtwmS56w7VMlDSICSQULW3bM+1EAiKyv68Q1
         xBoA==
X-Gm-Message-State: APjAAAUinbSnxbDxpj+fTHx8tKx7T05gVWo7tZsV/w71wmathRe5aSSg
        W+mxF4NpJGdb/T7pIaRcyRVvQbcAdCw=
X-Google-Smtp-Source: APXvYqzpLx7iOef7cgd0uOUhcXojDDWIDat/YlvUxQKvoWGUo77FoI4aumWzpXGfEUiQk7kU4utiHQ==
X-Received: by 2002:a05:620a:1108:: with SMTP id o8mr6884459qkk.118.1580416410278;
        Thu, 30 Jan 2020 12:33:30 -0800 (PST)
Received: from mango.semfio.usp.br ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id o12sm3436514qke.79.2020.01.30.12.33.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jan 2020 12:33:29 -0800 (PST)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/7] diff: make diff_populate_filespec() honor its repo argument
Date:   Thu, 30 Jan 2020 17:32:17 -0300
Message-Id: <5a31c7b9e3239f2b7e4841dcc85cbf9cddf545ed.1580413221.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <cover.1580413221.git.matheus.bernardino@usp.br>
References: <cover.1580413221.git.matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

diff_populate_filespec() takes a struct repository argument but it
doesn't get passed down to read_object_file().

Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
---
 diff.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/diff.c b/diff.c
index 8e2914c031..0f333c27d6 100644
--- a/diff.c
+++ b/diff.c
@@ -4024,7 +4024,7 @@ int diff_populate_filespec(struct repository *r,
 				return 0;
 			}
 		}
-		s->data = read_object_file(&s->oid, &type, &s->size);
+		s->data = repo_read_object_file(r, &s->oid, &type, &s->size);
 		if (!s->data)
 			die("unable to read %s", oid_to_hex(&s->oid));
 		s->should_free = 1;
-- 
2.25.0

