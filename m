Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7E562208CD
	for <e@80x24.org>; Fri, 18 Aug 2017 18:33:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751852AbdHRSd3 (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Aug 2017 14:33:29 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:35341 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751774AbdHRSdW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Aug 2017 14:33:22 -0400
Received: by mail-lf0-f66.google.com with SMTP id w199so6742453lff.2
        for <git@vger.kernel.org>; Fri, 18 Aug 2017 11:33:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=xayjtsi2We5H9KoyqNV9aUGSvbw5RWsyfhuuQtlx0zA=;
        b=GXPTRXHTddtmQZl3878vNccq5+c/cZmQFlIiFqTkUMtQwdxfWx2Wx/3+c+SpyWhGdF
         Wl+CFw9wMjaa2uL2HDif9C9sSxI2jK6TlziMqDPvhVDGce5EhNdrwiXBAj49C7kxkLz2
         hDgGxVokj925RysT5v+pCYx7u6jxB7L6Fg42P34btJQwVAt6OJ0jLdnqQkiG444j89vX
         yCU0iDlDj2V6z0BfzZU1rt1TmE4RKS2sg46msiXzcM+vFy+ynpScjClQXp7ZrYnAedZ2
         y0W9l9ip+fJkfdTY6lq4QSbPtPhiytAFohPxaspkihpw5w9r7UiOAoWVK09cj4Yp9Rip
         8JoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:in-reply-to:references;
        bh=xayjtsi2We5H9KoyqNV9aUGSvbw5RWsyfhuuQtlx0zA=;
        b=sNxEQ+dTm/20Rh6hkxQ7I2XW2Ksjfx4ljwulhplc2dtJCKEy/fRJOZe/QWhUZcrr81
         MPYv+QIgXrzq8o58l/APpEYzakZh0Dg7U5Hez2qcNwGCtv32tIPxBi6+CFgxGbVARjYt
         q2DMtoANw+GfKLEMtGtPuQ3TzlVF00q4RuH1UkrnctqPi9X1fr3Ssl9eGPVYQTLW1bIA
         VhZuv1Qxo1rImKWnN3nYS8vozds+wjzeWZCQPldYFmOCkMnMBKYT8UgI7zINhjlrlOL8
         BKJaPKwsQwYEpjbv8xmtsZjF5uJGUxzza4gEV7rLfiAdrLEszujykOFm876EX4znkIlU
         a/1A==
X-Gm-Message-State: AHYfb5jlR+Q+Wd2ZQt3w5j0go75R2qsMN1ZblqtywIXY6/S5K5iuMhB3
        fOl+q1Zii98RLxUIPNE=
X-Received: by 10.25.215.21 with SMTP id o21mr4237198lfg.105.1503081200851;
        Fri, 18 Aug 2017 11:33:20 -0700 (PDT)
Received: from localhost.localdomain ([188.121.16.104])
        by smtp.gmail.com with ESMTPSA id r82sm813568lfd.45.2017.08.18.11.33.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Aug 2017 11:33:20 -0700 (PDT)
From:   Patryk Obara <patryk.obara@gmail.com>
To:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>
Cc:     "brian m . carlson" <sandals@crustytoothpaste.ath.cx>,
        Stefan Beller <stefanbeller@gmail.com>
Subject: [PATCH v4 3/4] commit: allocate array using object_id size
Date:   Fri, 18 Aug 2017 20:33:13 +0200
Message-Id: <d3003634866f18fee7c05f78b6e170a87f62f041.1503079879.git.patryk.obara@gmail.com>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <cover.1503079879.git.patryk.obara@gmail.com>
References: <cover.1503020338.git.patryk.obara@gmail.com>
 <cover.1503079879.git.patryk.obara@gmail.com>
In-Reply-To: <cover.1503079879.git.patryk.obara@gmail.com>
References: <cover.1503079879.git.patryk.obara@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

struct commit_graft aggregates an array of object_id's, which have
size >= GIT_MAX_RAWSZ bytes. This change prevents memory allocation
error when size of object_id is larger than GIT_SHA1_RAWSZ.

Signed-off-by: Patryk Obara <patryk.obara@gmail.com>
---
 commit.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/commit.c b/commit.c
index 1a0a9f2..436eb34 100644
--- a/commit.c
+++ b/commit.c
@@ -147,7 +147,8 @@ struct commit_graft *read_graft_line(struct strbuf *line)
 	if ((line->len + 1) % entry_size)
 		goto bad_graft_data;
 	i = (line->len + 1) / entry_size - 1;
-	graft = xmalloc(st_add(sizeof(*graft), st_mult(GIT_SHA1_RAWSZ, i)));
+	graft = xmalloc(st_add(sizeof(*graft),
+	                       st_mult(sizeof(struct object_id), i)));
 	graft->nr_parent = i;
 	if (get_oid_hex(line->buf, &graft->oid))
 		goto bad_graft_data;
-- 
2.9.5

