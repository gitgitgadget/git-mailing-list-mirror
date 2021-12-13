Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE927C433EF
	for <git@archiver.kernel.org>; Mon, 13 Dec 2021 16:02:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236274AbhLMQCH (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Dec 2021 11:02:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239397AbhLMQCA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Dec 2021 11:02:00 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B7CDC0613FE
        for <git@vger.kernel.org>; Mon, 13 Dec 2021 08:02:00 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id t9so27872570wrx.7
        for <git@vger.kernel.org>; Mon, 13 Dec 2021 08:02:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=rJ3GDWKJ0GCH/2sQjyhi9Wp9eandivSrWcGSEkqQkNE=;
        b=BSiaEAvnMlAKs3V0ruJ9x+CtDbhpnuaz9RfcEwzy8RfASvLSbMOyS0+9bhtcYseH/5
         XMvRUCFA5U3n7r7ZE3o3hdp79fkHpWoqoOCRUxPJ0xJ0Un8mES91PnVYHdyXQO00mU8n
         ur6X9lIwdrqZswFGiQa+uv3hHcLeRMZkXFLN5NfP46J0NjgIYV381rsF+k4hcEheN8W1
         aOebBSbN35DO35WckQ2MqJ0KLvuqPCMD8cliWcn+kjGjkZHXu+TEdUJFIAhn9FUAuS2G
         9yste2PloUEafSxYhfL50c2lX6UxZfC9dIP8QkUBS8H1gpXPoEbDMlSJCeOnBCXC2QsO
         8yZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=rJ3GDWKJ0GCH/2sQjyhi9Wp9eandivSrWcGSEkqQkNE=;
        b=FzurAAWuohGQTKT0AZNdvITwWtfxUxyZL0rjuo/lJfSGM/NRSrWFuMCLob42TZ3pal
         tpFBQ1SL60ckhLZum6/rPpqpaXn8uCe8DrkC9VUs+wpV6uX7uXWKw/1p/BdWVzLAnf8q
         ALJWk8QNSqyE8JTC8LXk48NAhugEOUor6ozzLhTcGAyH/lfpTSXOvkjRIODMU13dw1c4
         lUBqk6tigGdcclgE3O1j7cdj8uOMaDGB2066a5fq35tID+BDxeI4lFk69gxQuRjPC8Xu
         7ThLoLbNrZocOFq3+lcdX0hUD24V7x6262QU6cR3o2n90ppaOOHNPcMASk+V549GMuKZ
         gbiA==
X-Gm-Message-State: AOAM531vawlfCDeU71xI3SjcfH85vca11YTJzwygfoexOJdzqcG71qEa
        hEqtpHwrqVUh7zo+7VesnUCT08ylzfE=
X-Google-Smtp-Source: ABdhPJzZ++xriT9ChT9Mmllk/SUifYO+7p5+FYwt5EIC9/q4C009+2i4wCtQkfv5IjMY/mP15g7Q9g==
X-Received: by 2002:a5d:6da9:: with SMTP id u9mr32928145wrs.237.1639411318827;
        Mon, 13 Dec 2021 08:01:58 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h2sm11103371wrz.23.2021.12.13.08.01.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Dec 2021 08:01:58 -0800 (PST)
Message-Id: <2939286924caa67e2cc57bf5ed4ce4287b9d571c.1639411309.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1152.v3.git.git.1639411309.gitgitgadget@gmail.com>
References: <pull.1152.v2.git.git.1639000187.gitgitgadget@gmail.com>
        <pull.1152.v3.git.git.1639411309.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 13 Dec 2021 16:01:45 +0000
Subject: [PATCH v3 07/11] reftable: fix NULL derefs in error paths
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Han-Wen Nienhuys <hanwen@google.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

Spotted by Coverity.

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 reftable/reader.c | 3 ++-
 reftable/stack.c  | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/reftable/reader.c b/reftable/reader.c
index 006709a645a..8d308d858f8 100644
--- a/reftable/reader.c
+++ b/reftable/reader.c
@@ -796,6 +796,7 @@ int reftable_reader_print_file(const char *tablename)
 	reftable_table_from_reader(&tab, r);
 	err = reftable_table_print(&tab);
 done:
-	reftable_reader_free(r);
+	if (r)
+		reftable_reader_free(r);
 	return err;
 }
diff --git a/reftable/stack.c b/reftable/stack.c
index 10dfd370e8e..eb03b6c74f6 100644
--- a/reftable/stack.c
+++ b/reftable/stack.c
@@ -707,7 +707,8 @@ done:
 	strbuf_release(&temp_tab_file_name);
 	strbuf_release(&tab_file_name);
 	strbuf_release(&next_name);
-	reftable_writer_free(wr);
+	if (wr)
+		reftable_writer_free(wr);
 	return err;
 }
 
-- 
gitgitgadget

