Return-Path: <SRS0=PG55=2K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF6E3C2D0C8
	for <git@archiver.kernel.org>; Fri, 20 Dec 2019 18:54:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 886B3206D8
	for <git@archiver.kernel.org>; Fri, 20 Dec 2019 18:54:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XtTdyKSt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727471AbfLTSyB (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Dec 2019 13:54:01 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:35766 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727404AbfLTSyA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Dec 2019 13:54:00 -0500
Received: by mail-wm1-f68.google.com with SMTP id p17so10287123wmb.0
        for <git@vger.kernel.org>; Fri, 20 Dec 2019 10:53:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=f3UwA+PZfDZtpgHX+o3IAZwzVToNn3PbEPAIVEQaBww=;
        b=XtTdyKStb/a6FOwhZPLqDoqbK7737iriJsEH2e0C+YsY/xt4Cc+wdxOAfYTrWyC0vI
         B/wNiWe2SZr4CBb39g9yfdvHA3RSzTJosS6dFXSqm2YjOr/HM+ogE8oTNkkv30c1R0E+
         3YIMY1vez8ylwZJ6RKx877V36DSH3DQGIOh5OByXNPQYmUTGLixB520wX2q2/OwevoVH
         j0umpjFqzpCWQsN4ZKyNVEm5nccUYTiZuroFDPxCn5ip0gBPEu1/hDijNaE/0kZqhQvv
         kNOWtXjhMs5tVoqKaObsr4AVnF/WowISyBisOMrwZVYQhbpuUjMYP2/RFZOKg9FW1ymE
         RcLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=f3UwA+PZfDZtpgHX+o3IAZwzVToNn3PbEPAIVEQaBww=;
        b=TK03gZpKgOEFfa6aSyeiNW6W1jt7TJ1dwL+u4ZDLWISJNJw3k/2npySpDB9IUkq9Cn
         84nk4EKp770NXP/4LNYX3nubaLd3qp49hlJXdoqiCJtlKW/XOTwnwABrpPIo6IVDecGh
         VnJid8/cnpftIz2vOxFFomCq2d8KRC91goJuUmZZZJS9zoaPyVfvAp3oFCqu0ungYDjo
         e1kN7qxOjk3erEqMshyDRJ2an6rq5h+5y6FmihHcpeNVAtBmf3mfrhDMbg+Wa7pOP0jh
         qhRE1bvnphIXS09LAIddVK4Hwsb3PZXaf156SgzvU97SuJiqOfgLOFRHTjVR0SXDeO+J
         n4Hg==
X-Gm-Message-State: APjAAAV64zgZqRQPltfoSLkiV6QVKDC1VfAzJo2goUZTTZSmd+wG78sz
        +VRi4+nOaZ9xaIL5itbj4t6MhLEW
X-Google-Smtp-Source: APXvYqy0ysB7rv0egDKk4HPyRZ78c7YBLRfZqZTjX6scNTZv8H8jOq+LPxlMRRcnWaHpjj0Okh7XPg==
X-Received: by 2002:a7b:c10f:: with SMTP id w15mr17269471wmi.69.1576868038701;
        Fri, 20 Dec 2019 10:53:58 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p7sm10477982wmp.31.2019.12.20.10.53.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Dec 2019 10:53:58 -0800 (PST)
Message-Id: <c64984e146e509a743c9adc7b61bf7b274103cf9.1576868036.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.680.git.git.1576868036.gitgitgadget@gmail.com>
References: <pull.680.git.git.1576868036.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 20 Dec 2019 18:53:56 +0000
Subject: [PATCH 2/2] rebase: fix saving of --signoff state for am-based
 rebases
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de, plroskin@gmail.com,
        Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

This was an error introduced in the conversion from shell in commit
21853626eac5 ("built-in rebase: call `git am` directly", 2019-01-18),
which was noticed by a random browsing of the code.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin/rebase.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index ddf33bc9d4..e354ec84bb 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -706,7 +706,7 @@ static int rebase_write_basic_state(struct rebase_options *opts)
 		write_file(state_dir_path("gpg_sign_opt", opts), "%s",
 			   opts->gpg_sign_opt);
 	if (opts->signoff)
-		write_file(state_dir_path("strategy", opts), "--signoff");
+		write_file(state_dir_path("signoff", opts), "--signoff");
 
 	return 0;
 }
-- 
gitgitgadget
