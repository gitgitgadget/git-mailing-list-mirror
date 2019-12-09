Return-Path: <SRS0=90au=Z7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E5B8C47409
	for <git@archiver.kernel.org>; Mon,  9 Dec 2019 11:53:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6FE62080D
	for <git@archiver.kernel.org>; Mon,  9 Dec 2019 11:53:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b+++/GdJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727643AbfLILxM (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Dec 2019 06:53:12 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:36421 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727613AbfLILxK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Dec 2019 06:53:10 -0500
Received: by mail-wm1-f65.google.com with SMTP id p17so14604210wma.1
        for <git@vger.kernel.org>; Mon, 09 Dec 2019 03:53:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ntQIdsWuGW1GM27W+NVe76XWcYgjKNaO6G8Cw8nRNoE=;
        b=b+++/GdJXCVeIky8LNE0rP0zlaFLClYMp4zi7Mz+ixxeC0zAhiEJgueeJU76A1EaoN
         yp25z7NtYfHfYdXWroIeQ55N0c9EyJYCwUxhSMVl4ei3v390saO8BQuOaBzf89y5A7vK
         TDa3TXsj0vE2ooUzWbjHy6g8e5VPBewONSpb7SApp2ALA30IWigMbXH+JwkyrZpsoTd3
         xJgsuAQEGtU5/2EKN2iJglObw02E7e8qzcdUYv4MKC7EHx2rqgyEMhYnVVzp1XeBx8eV
         sENSipb13FHueL9YSriUWLy9kOceo4W+SzaqJonLup/q/5nn+bTT5pd74ZwtQN4amapw
         /7xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ntQIdsWuGW1GM27W+NVe76XWcYgjKNaO6G8Cw8nRNoE=;
        b=HsOfprUsOF17a2kHQirN1nkc2AbtKP3DhZS18xl6XQMGOgoHTF1zrTChFKhcXCBKw4
         5KSB0v34KB/pcJGVIzarVXfoF03/1W6XmaPAnWUIXgDsBq97kv0FLceOMn8asVBIoVld
         M1vnFjDDWwJRtnWvQMWLmP9MGh7jbTfsnFCgv2ioAtKrAWHRSWcIAD0k3MOWszwOUA5R
         4aqeeST2TXGx7uSfGKVQl2pMc4xa2mhGykz56K71F/caVfim+HybMbU1nizF3AGBSj+i
         m5N2xSntPWWDNx6PvDX2XNQsCPe2Ea62OPaBZOYKHI7fBOkswkM8T18Mgj5kpHzPRlTS
         RbJg==
X-Gm-Message-State: APjAAAVO05iwlThC3kCyp0wxv9XlTrdzKOPHZn6KSf3MXbIoQbzNLbr+
        u3vzuUN8r1/lYbhVgFd8otg=
X-Google-Smtp-Source: APXvYqy8xsPByZKzQP7ZvL1fIc8RdJWxKwEYFj3tR/gVbXQZwgUuTXjvXLpTq1VyS8WjmycEs+zupQ==
X-Received: by 2002:a05:600c:2254:: with SMTP id a20mr24656878wmm.97.1575892388660;
        Mon, 09 Dec 2019 03:53:08 -0800 (PST)
Received: from localhost.localdomain (x4db55b9c.dyn.telefonica.de. [77.181.91.156])
        by smtp.gmail.com with ESMTPSA id k8sm27239621wrl.3.2019.12.09.03.53.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 09 Dec 2019 03:53:08 -0800 (PST)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v3 05/14] name-rev: use sizeof(*ptr) instead of sizeof(type) in allocation
Date:   Mon,  9 Dec 2019 12:52:49 +0100
Message-Id: <20191209115258.9281-6-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.24.0.801.g241c134b8d
In-Reply-To: <20191209115258.9281-1-szeder.dev@gmail.com>
References: <20191112103821.30265-1-szeder.dev@gmail.com>
 <20191209115258.9281-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 builtin/name-rev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/name-rev.c b/builtin/name-rev.c
index e40f51c2b4..7e003c2702 100644
--- a/builtin/name-rev.c
+++ b/builtin/name-rev.c
@@ -102,7 +102,7 @@ static void name_rev(struct commit *commit,
 	}
 
 	if (name == NULL) {
-		name = xmalloc(sizeof(rev_name));
+		name = xmalloc(sizeof(*name));
 		set_commit_rev_name(commit, name);
 		goto copy_data;
 	} else if (is_better_name(name, taggerdate, distance, from_tag)) {
-- 
2.24.0.801.g241c134b8d

