Return-Path: <SRS0=B2P3=AY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82A19C433E0
	for <git@archiver.kernel.org>; Mon, 13 Jul 2020 19:10:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6279F20758
	for <git@archiver.kernel.org>; Mon, 13 Jul 2020 19:10:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ot4gkN0t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726396AbgGMTKu (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Jul 2020 15:10:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726150AbgGMTKu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Jul 2020 15:10:50 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D96BEC061755
        for <git@vger.kernel.org>; Mon, 13 Jul 2020 12:10:49 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id y13so9781294lfe.9
        for <git@vger.kernel.org>; Mon, 13 Jul 2020 12:10:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YSSaaRPLQZmK08wu8Pt+S7vFcxLAP20YjycZ2hkq8fw=;
        b=ot4gkN0tdzdOmwyoc5xq4Hzfa3sB99FSDc8qOU5JdPkrO1qntfMH0/kKJpKBec9cTe
         LK6iYTXTcsUDo31J3aQhlhVHXBNTa5DtKwtn0huYkqGOjfYVRODjggOZZIqZ9Qbdzau0
         hQjKQP+ezqp5LIDX0LrTrvuVdxANLxN70u5szoKL9u5gqUNCDslbp12ok9k+37cotzh8
         MWhTbbBQYjL0V+69+LcQjp+VZqjVtnNPfoPrK6h9sGWh3N7H8aCkPM/jlU1CsF+2knAJ
         HqhV81s4mZMt+T8vllOJlayZw2aXGTUhU0gD+C8vdJbsf+PNz8PMV8+oyjWzm0oI6Tqo
         SLiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YSSaaRPLQZmK08wu8Pt+S7vFcxLAP20YjycZ2hkq8fw=;
        b=ZHBtQGGwDCwptNYvJ5KbbL/Dc40wRtiqJPFImh8r8oiIESvNuC1rDPaaHs5jTy/Tcc
         1PkTLoWQpp7/VxAwxo7m+mng5myY8dOT2N03AsFPDxvJP3bqaMcd/XLgPO4r8WYDfBTJ
         nXA3CZO2KGE54k0iiLZU1bBZqZe6GmHwmJWLfeBPL8n0SRGSGwiBNY/ysOBFKG6ZQDWw
         ny7qTV61+MZyGAlx/jUot0TQevmFTVN30cuOvvbD87Jj5YPWMnGqdh7msEzQu3pGI++r
         ztWVjfv6wUphLJgClXexUk6XPw2KOWMVTtkTQD1mLwxDdFPUB2uNC36imSm97BLF7xDC
         x0Ug==
X-Gm-Message-State: AOAM532ItNVnrRzaC697LFDDcj08m7GZhjv3l7sref4tBnkRqu4UoTjO
        9yjwkGSIDQ+69bNxGXgul8Xlkj3c
X-Google-Smtp-Source: ABdhPJyKasll9fn5cnPsP+U5zZasWelJ+zVUUNaMJkrJZ9Wu89hgdwdrlX2s1jgnlfgnIw2iFIgvgw==
X-Received: by 2002:a19:8b8a:: with SMTP id n132mr300391lfd.45.1594667448085;
        Mon, 13 Jul 2020 12:10:48 -0700 (PDT)
Received: from localhost.localdomain (92-33-153-30.customers.ownit.se. [92.33.153.30])
        by smtp.gmail.com with ESMTPSA id m6sm4192367ljc.134.2020.07.13.12.10.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2020 12:10:47 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Chris Torek <chris.torek@gmail.com>
Subject: [PATCH 1/2] git-diff.txt: don't mark required argument as optional
Date:   Mon, 13 Jul 2020 21:10:08 +0200
Message-Id: <77e4442ae51a968d460b2329fc39b6a5e96902b0.1594666410.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.28.0.rc0
In-Reply-To: <cover.1594666410.git.martin.agren@gmail.com>
References: <cover.1594666410.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Commit b7e10b2ca2 ("Documentation: usage for diff combined commits",
2020-06-12) modified the synopsis by adding an optional "[<commit>...]"
to

  'git diff' [<options>] <commit> <commit> [--] [<path>...]

to effectively add

  'git diff' [<options>] <commit> <commit>... <commit> [--] [<path>...]

as another valid invocation. Which makes sense.

Further down, in the description, it left the existing entry for

  'git diff' [<options>] <commit> <commit> [--] [<path>...]

intact and added a new entry on

  'git diff' [<options>] <commit> [<commit>...] <commit> [--] [<path>...]

where it says that "[t]his form is to view the results of a merge
commit" and details how "the first listed commit must be the merge
itself". But one possible instantiation of this form is `git diff
<commit> <commit>` for which the added text doesn't really apply.

Remove the brackets so that we lose this overlap between the two
descriptions. We can still use the more compact representation in the
synopsis.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 Documentation/git-diff.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-diff.txt b/Documentation/git-diff.txt
index 1018110ddc..c613e71ca4 100644
--- a/Documentation/git-diff.txt
+++ b/Documentation/git-diff.txt
@@ -69,7 +69,7 @@ files on disk.
 	one side is omitted, it will have the same effect as
 	using HEAD instead.
 
-'git diff' [<options>] <commit> [<commit>...] <commit> [--] [<path>...]::
+'git diff' [<options>] <commit> <commit>... <commit> [--] [<path>...]::
 
 	This form is to view the results of a merge commit.  The first
 	listed <commit> must be the merge itself; the remaining two or
-- 
2.28.0.rc0

