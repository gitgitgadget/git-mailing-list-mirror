Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 102C7C433F5
	for <git@archiver.kernel.org>; Mon, 15 Nov 2021 23:29:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED7AB61A40
	for <git@archiver.kernel.org>; Mon, 15 Nov 2021 23:29:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242540AbhKOXb6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Nov 2021 18:31:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352955AbhKOXSb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Nov 2021 18:18:31 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D13ACC03E03A
        for <git@vger.kernel.org>; Mon, 15 Nov 2021 14:18:44 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id a9so7356595wrr.8
        for <git@vger.kernel.org>; Mon, 15 Nov 2021 14:18:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RNIOtYWTsUz/Z16g+2GLrWWmfj1tdHXmtkxpe5o2LuM=;
        b=RJLyHMCJq7wKrMc8dQex+CaxYqgibT83pXJ5KLiedht+GyEmq8IuAx6Y5BwaRGMKF3
         Mzk+LJ8OQ7gc/5sUsteoIVLPpBYUeFZrt8kQUgA5pFdz5+EB6wlWXRT7USiN8M9XQ+iP
         HsdRwk9b1IJZxOhwvlguWkWuD3s5VgLRaV0HT4inWdbMkzfklQJbTipM618TPlnDRobU
         NA9DDpJ+aFgcIA2C/4kPpnaUadg5YgIS+rArQV6XQP3WzJ94dUjOv3QhvaUQAl29zENA
         HNAXrImi+q32w3CK5XLXyYLwDHNtCMWJT1VpthEi1gsbRpBRNKPB66TbF6XYpemgnEbZ
         C3IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RNIOtYWTsUz/Z16g+2GLrWWmfj1tdHXmtkxpe5o2LuM=;
        b=U0St8uWNOgymWjpxztxBBeQbqZ1e7qP2j4TZdr78huESbSPuGjm0F2Ml/Ccou49RTV
         3HNpX93V0PMR1vGNacadw1P4trlRJTzdIroD2u/ZxKEuS8/9yTHD8dfun6+a3AKGVmMh
         lWDqX2Onwn2EthLQmPeq1iOXzk88/fNmhxaVVqaxcYTtC17AOZRNZ88YtccTDRjtByox
         nVph6BKHUl9qpuqtiZXyU/LrDsZjcvhTqehMbNXRyv+skhuLap2v4uJq+QTK8pmzJbbo
         P+UilBEAGcZ1gT+JK1bN/35tSE20wong0qgcuPdYzbDa8jexJ+pA/qjCNAg2gpxf0owY
         4zoQ==
X-Gm-Message-State: AOAM530pwiqmYQx9C9siFzcp7sHerhO/4gE2wjkgrdfsdrLivYb4i+e6
        LP93/ZqwDUMFcS/a1ETFAqXP8qtwM+xZ5w==
X-Google-Smtp-Source: ABdhPJxdBah0BS52RzKNYzLQOeK5SI29w0XGeE0HoDJAzSlQcr6AOi+Sykgsmcmm1TenKKeTJzDwSA==
X-Received: by 2002:a5d:694a:: with SMTP id r10mr3075512wrw.170.1637014723299;
        Mon, 15 Nov 2021 14:18:43 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n184sm526812wme.2.2021.11.15.14.18.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Nov 2021 14:18:42 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Elijah Newren <newren@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [RFC PATCH 13/21] strbuf.h: use BUG(...) not die("BUG: ...")
Date:   Mon, 15 Nov 2021 23:18:23 +0100
Message-Id: <RFC-patch-13.21-5dedcee3fb0-20211115T220831Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.0.rc2.809.g11e21d44b24
In-Reply-To: <RFC-cover-00.21-00000000000-20211115T220831Z-avarab@gmail.com>
References: <RFC-cover-00.21-00000000000-20211115T220831Z-avarab@gmail.com>
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
2.34.0.rc2.809.g11e21d44b24

