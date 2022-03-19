Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DB91C433EF
	for <git@archiver.kernel.org>; Sat, 19 Mar 2022 00:24:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241675AbiCSAZW (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Mar 2022 20:25:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241664AbiCSAZN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Mar 2022 20:25:13 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D38B112F168
        for <git@vger.kernel.org>; Fri, 18 Mar 2022 17:23:43 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id t11so13722832wrm.5
        for <git@vger.kernel.org>; Fri, 18 Mar 2022 17:23:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IOAZLKZWs19OinD4D+MFEKnD1JXWZgBUnPHmz1CGcHs=;
        b=W1bayDynVFkdEyRicrXwm3nS+fPbqde31L72P6zWB2xCJ9nvGYigxJLUzb+tWIFvCL
         YGD23fqdLpwZgrt5+ZFfciSHmkbx4nULdTOeJ/u5HwkOtHxtShAq2FUNkZ+egmZIA6hP
         f08okTtvhw3JRdbv3wQKe1tq4Uz25VUN+NYpgkRZPBdSgZAbM1MNjpE8uhFqRm5PljHE
         a75e3+BsJaDh1o1PnEtjcD4tD+/47hymZdCOzdzXn+TFhwTnNakvk98F6hHTuBUWvQnr
         EfVi8GNzcLkqW1Ys60g3DGBa1bTJF2wulkpS8V451KhI0AEGQ34yVCjd7RfBHar04pEm
         rlxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IOAZLKZWs19OinD4D+MFEKnD1JXWZgBUnPHmz1CGcHs=;
        b=LfBJwlQYkEJtM81hlzypxWXAj6aLMS2l5JnjZYYGJrXrHzFd2TmjgEqyZFAteQGDzJ
         wXavYi3VliER/rYqPD7p7crVa/4wROK7rZneEoJnkL43L+/wJw2rgzFGj/DGpDh6Uygb
         HVex1XKP7TvGCaOmNh2zxUDeaEOO4lSiNOvNSHM8eMlOwe5qV7JjCvVxyvK37hBjWfDx
         KwJ3jyoSToUyfsFYA2KVRWWFSq0FcOIw8866ZMFxjKqsTGVQR4PVAMY+coFYSvsqmd8W
         mKYi8U/YbLzyyWSt9xXTFHNj0UPnIp0HzYLsefsmxejrJ6NLBXlbiKwJs2Mad+f1EjDO
         5tZA==
X-Gm-Message-State: AOAM533UW9o1JnHfw1fGuWn0mS91QWmZAsGeg2smj17Tp+dpYbgD6RmT
        3hk/LiejcsbkYNzgPPDAkuO3szb4aPEW/g==
X-Google-Smtp-Source: ABdhPJy3hghRnDDzvmdFWR1L22TFjuDjRFcGRIntTlDRUz5Q7p9NCrF2GaEBqq9ASSprt+QSO10eNQ==
X-Received: by 2002:adf:e605:0:b0:203:d5f6:86f1 with SMTP id p5-20020adfe605000000b00203d5f686f1mr9228483wrm.689.1647649421272;
        Fri, 18 Mar 2022 17:23:41 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id u25-20020a05600c211900b00389d4bdb3d2sm14865519wml.36.2022.03.18.17.23.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Mar 2022 17:23:40 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Han Xin <chiyutianyi@gmail.com>,
        Jiang Xin <worldhello.net@gmail.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Derrick Stolee <stolee@gmail.com>,
        Philip Oakley <philipoakley@iee.email>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v11 7/8] unpack-objects: refactor away unpack_non_delta_entry()
Date:   Sat, 19 Mar 2022 01:23:24 +0100
Message-Id: <patch-v11-7.8-2b403e7cd9c-20220319T001411Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1438.g8874c8eeb35
In-Reply-To: <cover-v11-0.8-00000000000-20220319T001411Z-avarab@gmail.com>
References: <cover-v10-0.6-00000000000-20220204T135538Z-avarab@gmail.com> <cover-v11-0.8-00000000000-20220319T001411Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The unpack_one() function will call either a non-trivial
unpack_delta_entry() or a trivial unpack_non_delta_entry(). Let's
inline the latter in the only caller.

Since 21666f1aae4 (convert object type handling from a string to a
number, 2007-02-26) the unpack_non_delta_entry() function has been
rather trivial, and in a preceding commit the "dry_run" condition it
was handling went away.

This is not done as an optimization, as the compiler will easily
discover that it can do the same, rather this makes a subsequent
commit easier to reason about. As it'll be handling "OBJ_BLOB" in a
special manner let's re-arrange that "case" in preparation for that
change.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/unpack-objects.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/builtin/unpack-objects.c b/builtin/unpack-objects.c
index e3d30025979..d374599d544 100644
--- a/builtin/unpack-objects.c
+++ b/builtin/unpack-objects.c
@@ -338,15 +338,6 @@ static void added_object(unsigned nr, enum object_type type,
 	}
 }
 
-static void unpack_non_delta_entry(enum object_type type, unsigned long size,
-				   unsigned nr)
-{
-	void *buf = get_data(size);
-
-	if (buf)
-		write_object(nr, type, buf, size);
-}
-
 static int resolve_against_held(unsigned nr, const struct object_id *base,
 				void *delta_data, unsigned long delta_size)
 {
@@ -479,12 +470,17 @@ static void unpack_one(unsigned nr)
 	}
 
 	switch (type) {
+	case OBJ_BLOB:
 	case OBJ_COMMIT:
 	case OBJ_TREE:
-	case OBJ_BLOB:
 	case OBJ_TAG:
-		unpack_non_delta_entry(type, size, nr);
+	{
+		void *buf = get_data(size);
+
+		if (buf)
+			write_object(nr, type, buf, size);
 		return;
+	}
 	case OBJ_REF_DELTA:
 	case OBJ_OFS_DELTA:
 		unpack_delta_entry(type, size, nr);
-- 
2.35.1.1438.g8874c8eeb35

