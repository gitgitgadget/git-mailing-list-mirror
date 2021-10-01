Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D65DBC433FE
	for <git@archiver.kernel.org>; Fri,  1 Oct 2021 01:38:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B37CC61A3F
	for <git@archiver.kernel.org>; Fri,  1 Oct 2021 01:38:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351525AbhJABjv (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Sep 2021 21:39:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351504AbhJABjt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Sep 2021 21:39:49 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B733DC06176C
        for <git@vger.kernel.org>; Thu, 30 Sep 2021 18:38:05 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id oj16so2172087pjb.1
        for <git@vger.kernel.org>; Thu, 30 Sep 2021 18:38:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SNW2ej/H3VgPZ6xKYgawhJacH5CfJ+5f+J+z1+S9TZg=;
        b=ZNHSCzyGreIn7uG7ekLMHlBrQDv9SuobnXmlK8dr5A9UzZQpO25WGFTqBPq4SU30XN
         vVfyxFQk+8iVSQeyeFDJLCCD1NJ/YLrYmjJD/a2MAKPWAVy5oquymq+S2TQAn0FYcnvi
         cugAp5vx4VUHt0uoWrVPTU8dgMfPnwW20QcSzxbqhIaJ4bODoCTpG6hSKuqG50Zrv5xI
         vWubU5rXRw15nRaN2Yk6lfjB1oTQt7tycHBSKCCMZKlkAU6NT+clP8uP28tVrHL4TMIO
         PUjmH7Xl8WLFbk+zSsULwefNlMxkjaBj5mDfIw7vEOfD7fBQ/fNFu8DHdkEvcMB1zRj1
         f9JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SNW2ej/H3VgPZ6xKYgawhJacH5CfJ+5f+J+z1+S9TZg=;
        b=USZb3XRxa/T0lkEXbLsePqbbK2sLkoBYm0+5+thbIZwZ9P16V0bm898YHpkk9C1ytp
         Wn05SYIKoijXu/OWfEtHiL9VcbYGz18eiANZbhnwiM8tX0bwCNszOl4wSRbBM0dhBHO0
         d7i5DcpZARSVFN3YNVvbmpXevTO4FaDqgTLbJ+rLsZsj2ecYqdgVinl8l0iw67+iciQR
         Q7dmUnig7l1m2NSrDnpEmNHoM2rkSdceQ0bcRN6NLE7QBtH1qsnMyneV4XRT3WdpQgTD
         37rC51+KZRVvRJoqqgUR4v8Y29VCZGVfHZPyGK5wNOxJfkoPpos2kZ2QLJdiGy92oHti
         eMeQ==
X-Gm-Message-State: AOAM530Dqzivxk9kRXbG/V0EAjmeAyL5kSLceZnh1ktgHOQjIR3ThOfM
        X1VLw7fZLMI8fmaYLimbSG0HPXvN0FA=
X-Google-Smtp-Source: ABdhPJyS1hJxG03A5UdKo7QADnB6nqgLP5zmjsvDYTGiuwx4733iSlzY3+WFiEhD+12fpIBQgaF4vg==
X-Received: by 2002:a17:903:32cc:b0:13c:a76c:4918 with SMTP id i12-20020a17090332cc00b0013ca76c4918mr7184828plr.50.1633052284977;
        Thu, 30 Sep 2021 18:38:04 -0700 (PDT)
Received: from sarawiggum.fas.fa.disney.com ([198.187.190.10])
        by smtp.gmail.com with ESMTPSA id c25sm4268199pfn.159.2021.09.30.18.38.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Sep 2021 18:38:04 -0700 (PDT)
From:   David Aguilar <davvid@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH v7 3/4] difftool: remove an unnecessary call to strbuf_release()
Date:   Thu, 30 Sep 2021 18:37:55 -0700
Message-Id: <20211001013756.37586-4-davvid@gmail.com>
X-Mailer: git-send-email 2.33.0.886.g5b6dfe5e5c
In-Reply-To: <20211001013756.37586-1-davvid@gmail.com>
References: <20211001013756.37586-1-davvid@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The `buf` strbuf is reused again later in the same function, so there
is no benefit to calling strbuf_release(). The subsequent usage is
already using strbuf_reset() to reset the buffer, so releasing it
early is only going to lead to a wasteful reallocation.

Remove the early call to strbuf_release(). The same strbuf is already
cleaned up in the "finish:" section so nothing is leaked, either.

Signed-off-by: David Aguilar <davvid@gmail.com>
---
 builtin/difftool.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/builtin/difftool.c b/builtin/difftool.c
index f3cd1e5b53..437474fea0 100644
--- a/builtin/difftool.c
+++ b/builtin/difftool.c
@@ -568,8 +568,6 @@ static int run_dir_diff(const char *extcmd, int symlinks, const char *prefix,
 		write_standin_files(entry, &ldir, ldir_len, &rdir, rdir_len);
 	}
 
-	strbuf_release(&buf);
-
 	strbuf_setlen(&ldir, ldir_len);
 	helper_argv[1] = ldir.buf;
 	strbuf_setlen(&rdir, rdir_len);
-- 
2.33.0.886.g5b6dfe5e5c

