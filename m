Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 932D5C19F2C
	for <git@archiver.kernel.org>; Tue,  2 Aug 2022 15:33:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229575AbiHBPd2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Aug 2022 11:33:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbiHBPd1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Aug 2022 11:33:27 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DC50B7EF
        for <git@vger.kernel.org>; Tue,  2 Aug 2022 08:33:25 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id v3so17442270wrp.0
        for <git@vger.kernel.org>; Tue, 02 Aug 2022 08:33:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=B/D5Y4kXHpJSPwbV6S/3HNi7pg+90Ytq1M/bfcbGxz0=;
        b=W9qmcKEpJ/x+nNMbH8aIJlOqHsTxPlu8VeLc3s7Ir9q8hO8XkSMhF2AX71DUtNyMou
         XGdVm/+/+mho1BKzGK8hONPHH5NcMZYfVHaJnMu90vbzuewrIeuXujc3ePcZ7GV030FY
         OIqF7XofO4S54edfu2U0MqpabS3BhLn6ElDXbIW+ZeTtK/m5DkS8PaIzlWnLLvA+ehSC
         gbIVpKkBXX+mXEjLNllWA3iD1Ssd5rLE9wsqda88OgjdNB1ANTCJxWZ/BQIM6BHCTBkh
         H5HQhQwqH/A81gR8zXGrycH6WN7W/z2hSYyMwWQjG4YpUdZ8u6gopppQPHAFk8xEyipm
         hzHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=B/D5Y4kXHpJSPwbV6S/3HNi7pg+90Ytq1M/bfcbGxz0=;
        b=ekeMQhBjvqVE7UGQQxqhOh1irQ/uX25yPpp8ykJ6ZjejXuEhctEnrEFnavLccDQP0J
         jY2AEM6oztZgY+OlVHrS7KK7mbn9BdQh6bc/Ixfeny6n6lZjHHkKwcaoqxuDWw+8SDiG
         QYQzv0TijxqAALjNRoupdUtfDjOzxeMcAykYcBZEax/uzhelQaxMMgaAkN37ZHwV6HMA
         1bnegVA/zae9tKbgE0QJdPUcS3TzP58SmFjuSAh+sL+7QWj139dbUe771fcI0W8FvBth
         mMAGpHcA9Mkkm7/jbgQOPVCI/MQ/BrxbdAaeAIoyoLqGgfxMgdmrVA/JKXMCqJlW3Jk6
         ++4Q==
X-Gm-Message-State: ACgBeo3GaHSQyiaMFg2Rrrlj+YcpRApDLVVCrpPxM9MSy7tXqH33QNLw
        gTX42cjwpiC+yYIyy3nPPrDWYXkHusYZ1w==
X-Google-Smtp-Source: AA6agR7vhw2uTJTGxmvz3XxhHfljo5ld68arLkP3b40HDyCyuK2B4NzWQbXY4PVWZsZhk6cXjrCuMQ==
X-Received: by 2002:a05:6000:15c3:b0:220:676e:c825 with SMTP id y3-20020a05600015c300b00220676ec825mr5123791wry.512.1659454403288;
        Tue, 02 Aug 2022 08:33:23 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id y7-20020adffa47000000b0021e9396b135sm15332531wrr.37.2022.08.02.08.33.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Aug 2022 08:33:22 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 1/6] bisect.c: add missing "goto" for release_revisions()
Date:   Tue,  2 Aug 2022 17:33:11 +0200
Message-Id: <patch-v3-1.6-12a4a20c59f-20220802T152925Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.1.1233.ge8b09efaedc
In-Reply-To: <cover-v3-0.6-00000000000-20220802T152925Z-avarab@gmail.com>
References: <cover-v2-0.6-00000000000-20220729T082919Z-avarab@gmail.com> <cover-v3-0.6-00000000000-20220802T152925Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a missing "goto cleanup", this fixes a bug in
f196c1e908d (revisions API users: use release_revisions() needing
REV_INFO_INIT, 2022-04-13).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 bisect.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bisect.c b/bisect.c
index b63669cc9d7..421470bfa59 100644
--- a/bisect.c
+++ b/bisect.c
@@ -1054,7 +1054,7 @@ enum bisect_error bisect_next_all(struct repository *r, const char *prefix)
 		 */
 		res = error_if_skipped_commits(tried, NULL);
 		if (res < 0)
-			return res;
+			goto cleanup;
 		printf(_("%s was both %s and %s\n"),
 		       oid_to_hex(current_bad_oid),
 		       term_good,
-- 
2.37.1.1233.ge8b09efaedc

