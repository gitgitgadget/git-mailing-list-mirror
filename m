Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF85FC433FE
	for <git@archiver.kernel.org>; Mon,  6 Dec 2021 16:26:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358196AbhLFQ3m (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Dec 2021 11:29:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356284AbhLFQ3j (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Dec 2021 11:29:39 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAC06C061746
        for <git@vger.kernel.org>; Mon,  6 Dec 2021 08:26:10 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id az34-20020a05600c602200b0033bf8662572so274471wmb.0
        for <git@vger.kernel.org>; Mon, 06 Dec 2021 08:26:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=r8968T3naNuQ5j9UoZ5NsXC+Nitrdb9t+7Ha30Hni7M=;
        b=E0uBQNGuKesvMVimXddknHjNlUFQ62ewR9V/7njTVNfp5oVvML6Bj/APcmcZ6Jlpy8
         1fx7t3C/raAIujwuTPn4XSbc5U6kPHmm2oRucWXC+kWOvbRhcdHsNQOQfVRXe8LYyi/a
         iVXR8HEV+HBbXs8LJWgYeW898gFoIK3n72hYujr8ET0dBMRJx1inNWg/mwaJ4zqXfdfu
         VNTmO/dQMM+J4qylnL118dhw6pfMb/5x5whMC+nPzFGzt7c3M5aCF277rqqznbpR2Ld5
         y92FWTlgajTt0eoesTMNk+BZSrHzi+JbZpNZmB0XPjRqsog/7p9crl25VYV/oRPIGVzl
         qN5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=r8968T3naNuQ5j9UoZ5NsXC+Nitrdb9t+7Ha30Hni7M=;
        b=BaRuKnW2mSbyck3tThnoUYkA5J6TASF6c1iEqEV99TNLpwkPNdj8EcR1LnRyvE5CGB
         TReUjLNutgE2OfPEwYCkgJvGFncvYTjKyOCmN0RZgA6WyjIhtpVqfcKb3XBU5a0AmIAr
         VrrSbjvIa2HXO/7ayZv6TWsefO8uk98afbqL3B5JEotcwjBH3kbxEp521xaiD1rtWhKx
         pyk89/OOHeHz/vWk6fOmS8ABgMQIRXLNvWuN+tZuJchkDs0+B9lF+PzRtpjdz1jnopHx
         1fIaSI9ItiO31N58ynd74XGbqkgRTiUDc4jOUFR70+3YF6AvpzPy+zm7u9iwxSvTyI3A
         gGYQ==
X-Gm-Message-State: AOAM530yHVdngSfBsmgNqeorZ85Fjqoq0TVAMqfow3p7RMBN7qp4QkVc
        9w2dt4zUkIIIqnagRJSpamY7Nfh0XZfWYA==
X-Google-Smtp-Source: ABdhPJz5XEztUtogH1557TkUzin+1LgcsSDY0SWzhyYkgp9iGrxebfuUaBuTNhUp5Ct+FJsxoYhbng==
X-Received: by 2002:a7b:c38d:: with SMTP id s13mr40120639wmj.12.1638807969258;
        Mon, 06 Dec 2021 08:26:09 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id q26sm11740173wrc.39.2021.12.06.08.26.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Dec 2021 08:26:08 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 2/2] strbuf.h: use BUG(...) not die("BUG: ...")
Date:   Mon,  6 Dec 2021 17:25:21 +0100
Message-Id: <patch-2.2-ab89fec50c3-20211206T162442Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.1.898.g5a552c2e5f0
In-Reply-To: <cover-0.2-00000000000-20211206T162442Z-avarab@gmail.com>
References: <cover-0.2-00000000000-20211206T162442Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In 7141efab248 (strbuf: clarify assertion in strbuf_setlen(),
2011-04-27) this 'die("BUG: "' invocation was added with the rationale
that strbuf.c had existing users doing the same, but those users were
later changed to use BUG() in 033abf97fcb (Replace all die("BUG: ...")
calls by BUG() ones, 2018-05-02). Let's do the same here.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 strbuf.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/strbuf.h b/strbuf.h
index 96512f85b31..76965a17d44 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -160,7 +160,7 @@ void strbuf_grow(struct strbuf *sb, size_t amount);
 static inline void strbuf_setlen(struct strbuf *sb, size_t len)
 {
 	if (len > (sb->alloc ? sb->alloc - 1 : 0))
-		die("BUG: strbuf_setlen() beyond buffer");
+		BUG("strbuf_setlen() beyond buffer");
 	sb->len = len;
 	if (sb->buf != strbuf_slopbuf)
 		sb->buf[len] = '\0';
-- 
2.34.1.898.g5a552c2e5f0

