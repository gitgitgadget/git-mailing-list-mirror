Return-Path: <SRS0=i2G4=DF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25AECC2D0A8
	for <git@archiver.kernel.org>; Mon, 28 Sep 2020 11:40:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BEC03206FC
	for <git@archiver.kernel.org>; Mon, 28 Sep 2020 11:40:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VTYcZYo+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726688AbgI1Lkc (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Sep 2020 07:40:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726564AbgI1Lk3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Sep 2020 07:40:29 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CE68C0613CE
        for <git@vger.kernel.org>; Mon, 28 Sep 2020 04:40:29 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id g4so947773wrs.5
        for <git@vger.kernel.org>; Mon, 28 Sep 2020 04:40:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=+8Ej/DqoKo+E9vWFylRy7no+EM2nNrFwKMCKgczsKMo=;
        b=VTYcZYo+m8kg4Ig0wJUPO5TDO5YabuKKfYgYadZBO/+mzHTv2Fox3ATW/YW0hzTWhG
         6+xtiZG/QR9Meb7uJuy8orwcU/Cc6cGJHTPcIMq67+vZxWCeebPDCpTrXK5U6efIcDAw
         5O+IN9wt895YQUkDNjS9inkJsR9AiplBqN1PGEabRAk6WZSnSjuBqwuVLHsGgAmLIG48
         aI6zjltSCPTnZYKerphBE50Zs1Fx4g8WJs+ZCLsjU6uhbiNYTv5kj4Uioek06EY1d/4V
         QuKPZtDFntHbDD2ypYOIxELLRwW0wIEq+IVQRxpivbUwRUeBvFnTc187LJLJv31v5ila
         sr+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=+8Ej/DqoKo+E9vWFylRy7no+EM2nNrFwKMCKgczsKMo=;
        b=NTv1KbOzqDFKXjQmmNXfO2N8o55DY9IeBl7YdI7nASN4FN+vkLfJRSUCx87tROyGbh
         KaK5Xe7aNFBC9dSt2Dg+MABgVWlWFPFBsiKo0NsDam0FyyPUpqwYWwdtsEb1njhofEGe
         iZLxAjVBgst4i09tibLvWYQyVOn1aaIpw3V8SC89Ag21yVSImDLLvoQgNocKyGeLnfiS
         BZweE9NzfZ7ZLB+WzWKM5PTIWa0Lu2F+yeyLmt5Ku0YtuxXbCnZFuEPfjjGOTt70E9ff
         uNDZK3ROus3FJ+LddUCiCjdwjpKYIcRkLx+X+7Jl2WwkQb544RDDz4Rw5K9cNRh5Ttfe
         9/rw==
X-Gm-Message-State: AOAM533ViYU5ksRgScs8kR6iAlHyphpMQLTWuDNLlfyYN/HZMPAuT03W
        h/hVX1Peo8S6oS7sIA5Ls9aXFp25qmg=
X-Google-Smtp-Source: ABdhPJxDWpyWsREOXL9dThzkzmJ0SuapzvS20sPmHvgTlA3ip4v4+vz1METe0WvuQtXKDc2YrY9dBA==
X-Received: by 2002:a05:6000:7:: with SMTP id h7mr1355472wrx.16.1601293227960;
        Mon, 28 Sep 2020 04:40:27 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n66sm908129wmb.35.2020.09.28.04.40.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2020 04:40:27 -0700 (PDT)
Message-Id: <61baea106115277fb0c39d3b2a79770306f5a465.1601293224.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.710.v2.git.git.1601293224.gitgitgadget@gmail.com>
References: <pull.710.git.git.1581688196706.gitgitgadget@gmail.com>
        <pull.710.v2.git.git.1601293224.gitgitgadget@gmail.com>
From:   "Nikita Leonov via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 28 Sep 2020 11:40:24 +0000
Subject: [PATCH v2 3/3] docs: make notes regarding credential line reading
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Nikita Leonov <nykyta.leonov@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Nikita Leonov <nykyta.leonov@gmail.com>

This commit adds notes to git-credential.txt and to gitcredentials.txt
specifying that 'LF' and 'CR/LF' endings are treated the same.

Signed-off-by: Nikita Leonov <nykyta.leonov@gmail.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Documentation/git-credential.txt | 4 +++-
 Documentation/gitcredentials.txt | 2 ++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-credential.txt b/Documentation/git-credential.txt
index 31c81c4c02..9cf25126f2 100644
--- a/Documentation/git-credential.txt
+++ b/Documentation/git-credential.txt
@@ -114,7 +114,9 @@ The key may contain any bytes except `=`, newline, or NUL. The value may
 contain any bytes except newline or NUL.
 
 In both cases, all bytes are treated as-is (i.e., there is no quoting,
-and one cannot transmit a value with newline or NUL in it). The list of
+and one cannot transmit a value with newline or NUL in it). Note that
+Git will treat a carriage return before the final newline as part of
+line ending, and not part of the data. The list of
 attributes is terminated by a blank line or end-of-file.
 
 Git understands the following attributes:
diff --git a/Documentation/gitcredentials.txt b/Documentation/gitcredentials.txt
index 758bf39ba3..184079eaa4 100644
--- a/Documentation/gitcredentials.txt
+++ b/Documentation/gitcredentials.txt
@@ -141,6 +141,8 @@ entry for `https://example.com/bar/baz.git` (in addition to matching the config
 entry for `https://example.com`) but will not match a config entry for
 `https://example.com/bar`.
 
+Note that Git will treat a carriage return before the final newline as part
+of line ending, and not part of the data.
 
 CONFIGURATION OPTIONS
 ---------------------
-- 
gitgitgadget
