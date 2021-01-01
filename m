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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96D49C43381
	for <git@archiver.kernel.org>; Fri,  1 Jan 2021 02:17:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C8CA20798
	for <git@archiver.kernel.org>; Fri,  1 Jan 2021 02:17:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727316AbhAACR2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 31 Dec 2020 21:17:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727302AbhAACR1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Dec 2020 21:17:27 -0500
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D094CC061757
        for <git@vger.kernel.org>; Thu, 31 Dec 2020 18:17:09 -0800 (PST)
Received: by mail-oi1-x22f.google.com with SMTP id l207so23444301oib.4
        for <git@vger.kernel.org>; Thu, 31 Dec 2020 18:17:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zaW9wKZCGtwy/iC2fRKbCAzu2OcA6opYsemf7ORMIzI=;
        b=Bp5ODBELiWBZwNsQknL0rF2XSV3L0P1ZO6d0inTiJS7eewyH1h+Ld2pdrzGlwMoths
         Vo8c5qspbuRSrv+WwTEGi7gNECu2p7E9N9J3RcqNeUcYfforlUW5X/I4142RBCpG8g0p
         616YDMKbq2Ms1R+/t4Vbv2/5eClunGDqrM1XK4juBXJKEDq8LGilBZIlNFipwr5YyarR
         rtgzceUnHfINFq3Q/VGx86nKzT9lEjHcfs7f+u/pTwCtZKoBoHAWkGvYZ56CMwxGr9KL
         3aZt0jYhtBQHQDI+xRD+aec4COdXx9a/RwY+IAb/89ha6KAa/XRW9gzd4zgazTZ3/h9R
         e2vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zaW9wKZCGtwy/iC2fRKbCAzu2OcA6opYsemf7ORMIzI=;
        b=X7eIM6VSwHoZfJbZBC/aMyeyBei5xnqjYU7S79lO3dhIPTgWn+ha6TXAd9IpSuOu71
         ZviQuYIUKI5px0wVdZJHCYNMJNboknFbTHpTofIP/OBY6jJXlPTjyReeWZUzIYZhu6+H
         skXSoZXpBDI/mbq0mih9VBE7WqY+Dd6Zj2jZUpJaxJhn4R0uOa/BxBu1ODVYF6ga6Ual
         H2KqizOCvdGHa4wHiyDY6fu9IYHcMs6vIMZ9kH0kVvr/J3n041MerFggSAJnf6Uf1rgB
         BuG8iOksmcTmkNt3JarcENOifSPW0ZxvqgZ0NtKRCwgnv24JtYL6d5JKBIMCBiGN4T7P
         NuGQ==
X-Gm-Message-State: AOAM530G9XOgxHX0Guv3FpHyEl12AcgN8UuC6klU6RRLmEKYcGWDRfn3
        TgNCQmzfVcZzGi8YJSHYOfz0GZctZykrKA==
X-Google-Smtp-Source: ABdhPJxs8tSMYiSMZG7oAC6liyNkNRLEjWLdAmBbZMwh2fkja1Jn1c47Y3KD6nPap5OoafTBPmTCQA==
X-Received: by 2002:aca:4fd6:: with SMTP id d205mr9285567oib.34.1609467429088;
        Thu, 31 Dec 2020 18:17:09 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id 65sm11514062otp.35.2020.12.31.18.17.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Dec 2020 18:17:08 -0800 (PST)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 28/47] completion: bash: improve __gitcomp description
Date:   Thu, 31 Dec 2020 20:16:03 -0600
Message-Id: <20210101021622.798041-29-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210101021622.798041-1-felipe.contreras@gmail.com>
References: <20210101021622.798041-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It does a lot more than what is stated now.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.bash | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 73c9a81405..e56f96bdd6 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -310,8 +310,7 @@ __gitcompadd ()
 	done
 }
 
-# Generates completion reply, appending a space to possible completion words,
-# if necessary.
+# Creates completion replies, reorganizing options and adding suffixes as needed.
 # It accepts 1 to 4 arguments:
 # 1: List of possible completion words.
 # 2: A prefix to be added to each possible completion word (optional).
-- 
2.30.0

