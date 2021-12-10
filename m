Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F2C8C433EF
	for <git@archiver.kernel.org>; Fri, 10 Dec 2021 10:35:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237952AbhLJKis (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Dec 2021 05:38:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237945AbhLJKiq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Dec 2021 05:38:46 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 264D4C061A32
        for <git@vger.kernel.org>; Fri, 10 Dec 2021 02:35:12 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id y14-20020a17090a2b4e00b001a5824f4918so9112492pjc.4
        for <git@vger.kernel.org>; Fri, 10 Dec 2021 02:35:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BcmKk2B73heq1ar1uDrlaD2DbDoGXCXY2XelAwTcYbE=;
        b=YWaKEg+fciKHOvUhdpw2cxrhR7p7vWNGNuHFrD7cxzs88ycC6LhskVmt2vBrzakM3a
         4QzVVyDaGZcXmqYhemcn7Qn4DraTcXU0mZzvlhGh5o2f91weLvIg2iIhs149g4QTmtdX
         PXwFqMJeo8/FzvJ+FKGKaSxO0lARnNfYlvUDahVFhdTc1V+YD7ktq+yH6ADbwuy/6zPK
         3mJpAw15QU7zxsk4enDg3xquJK9N9/91FLpZMBQs74HM+IGQ6vHSJh9HfWl4fA0JNwsL
         hkAIGkRyZmmLQNYv1qyC//ye02Zt1bD73ctC3I0N0+PKtJi6OGrzFC8s5DqZI5qyG7g3
         zfCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BcmKk2B73heq1ar1uDrlaD2DbDoGXCXY2XelAwTcYbE=;
        b=bjdNA+yLaNt/mQlQkt4cEdZMNrQE4w/Hycfv7g0YuBnmxts9iZmjUZGVUGoPAwFRtr
         pAAc54luJvqL3ZFNU5kq5x6qt63/PhA76Fj0djsZ/SAxmgicmGm/cCg00tYqbT95LM9x
         51MAW7OoLcjohOEJOXGDzdVlyeDL+s59WDy9eWXjxfqITOdUBBcucT4PI8u1PZyzyK+B
         EbZrwRd5FBvp36aMY8OVLN1R3+JqEsYKqRlJoF77s7rJNT6ZqQTmgeke8TuW+pgobVJD
         DqA1CHM9gAPdbhFT9l8/K/OqphpY7CkAgOgzLaJsYSDuzDKdScTOLJW7h2jsdEOI7XQC
         3OEA==
X-Gm-Message-State: AOAM533hbBsrbc7iPvgZ5jLpEgTjZHHdVrLrL55jStNdPhKjobV/nwYI
        On4WWmi8aLU/pzEcAooYkR4=
X-Google-Smtp-Source: ABdhPJwuAwXlok+mMrFwYHbEmcAzQrYFuCdBg4ZnRwqRVojXOQ+bdQngf60JOSY+H9HILlFJ/iNrDA==
X-Received: by 2002:a17:902:c412:b0:141:f710:2a94 with SMTP id k18-20020a170902c41200b00141f7102a94mr75090104plk.1.1639132511704;
        Fri, 10 Dec 2021 02:35:11 -0800 (PST)
Received: from localhost.localdomain ([205.204.117.96])
        by smtp.gmail.com with ESMTPSA id 204sm2396250pgb.63.2021.12.10.02.35.09
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Dec 2021 02:35:11 -0800 (PST)
From:   Han Xin <chiyutianyi@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        Philip Oakley <philipoakley@iee.email>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Derrick Stolee <stolee@gmail.com>
Cc:     Han Xin <hanxin.hx@alibaba-inc.com>
Subject: [PATCH v5 5/6] object-file.c: make "write_object_file_flags()" to support "HASH_STREAM"
Date:   Fri, 10 Dec 2021 18:34:34 +0800
Message-Id: <20211210103435.83656-6-chiyutianyi@gmail.com>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <20211203093530.93589-1-chiyutianyi@gmail.com>
References: <20211203093530.93589-1-chiyutianyi@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han Xin <hanxin.hx@alibaba-inc.com>

We will use "write_object_file_flags()" in "unpack_non_delta_entry()" to
read the entire data contents in stream. When read in stream, we needn't
prepare "oid" before "write_loose_object()", only generate the header.

Signed-off-by: Han Xin <hanxin.hx@alibaba-inc.com>
---
 object-file.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/object-file.c b/object-file.c
index 455ab3c06e..906590dae5 100644
--- a/object-file.c
+++ b/object-file.c
@@ -2002,6 +2002,11 @@ int write_object_file_flags(const void *buf, unsigned long len,
 {
 	char hdr[MAX_HEADER_LEN];
 	int hdrlen = sizeof(hdr);
+	if (flags & HASH_STREAM) {
+		/* Generate the header */
+		hdrlen = xsnprintf(hdr, hdrlen, "%s %"PRIuMAX , type, (uintmax_t)len)+1;
+		return write_loose_object(oid, hdr, hdrlen, buf, len, 0, flags);
+	}
 
 	/* Normally if we have it in the pack then we do not bother writing
 	 * it out into .git/objects/??/?{38} file.
-- 
2.34.0

