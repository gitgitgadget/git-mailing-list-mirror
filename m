Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F338BC433EF
	for <git@archiver.kernel.org>; Tue, 29 Mar 2022 13:56:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237616AbiC2N63 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Mar 2022 09:58:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237618AbiC2N6K (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Mar 2022 09:58:10 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 687732261D7
        for <git@vger.kernel.org>; Tue, 29 Mar 2022 06:56:27 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id r23so20836582edb.0
        for <git@vger.kernel.org>; Tue, 29 Mar 2022 06:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hruYv5+WyjMiT/86Z+ARfp7aF0DLBAtnNmWREdl/4vA=;
        b=EG0L3JyG1C5V6j3A0eu3A+aiBn+F6iP1olXXQ0Mxs49fnM4KzsamtD9V2zuudT0pP4
         5u0QBqXXzlEBiVFqZtfCUTfZgN2J88k0JXUwyUtUxeiat/xYIsV8YxKeN0jrIfh3Kd5T
         P2fVmngCBM5uYFCZCw+rzO4qLmZWNen2cylgcHmkUvMhwS2Or5ARKvu03NPSQ7SvBqkf
         hTcQDxV8VPOa50ufvt8KmJhOKQoUHc1KfMHTSQGltJk/T56Qg2bPQO3dKtn8ZPa+ZXp+
         yY/OX57FcsRYh3KIW8B9GKO/k70Dvz7z/aZUobEyzPmvM40zPlLZYLb0VQY6NAEJMXgQ
         HDoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hruYv5+WyjMiT/86Z+ARfp7aF0DLBAtnNmWREdl/4vA=;
        b=gSftPVSPL/T2a+hkBaoQUpCri3+PJP0S3Kq5CFtt7iKhlXON4OpF+InzvMKd8UR41k
         SuBl+ANRGU7/mqsUkSNY26o86wfTxR2/dnXJdsycWfYr3foKU6R0hPLYN98fMITLxqiW
         thk1mf95xOtuqovEk3bLn0/bAR43OVi5bHlohc5ALj5erwwYhYnAregRpm9bPHLjXEHH
         f7vZe4ngsH38cqctyvtVrPTWBTKlBfY9xZgTtrUtdxix7ePI+t5GqE57Ad0vrDINqIhY
         Szajfh+8m7yossT6rbMgzig3DZfkdvXHlEL2O57V9ZL+2i6Ekppot+FZ5dNHlxxZFQ8v
         680g==
X-Gm-Message-State: AOAM530RbCBZj7gcu3fx5ZF70+n3V/6wwSbSN/WZtdGd2NkM9A7hhdAi
        Kmtq31mnG3kEutPmZrKI94DRL8JG89qXxw==
X-Google-Smtp-Source: ABdhPJyIepZnTIwbHgGNYLY1SiY85AdHdlP8A9/YE7Sl82vV/Z10vyDUIjbZObIARg5lUzZxqV8s3A==
X-Received: by 2002:a05:6402:51cf:b0:419:63e2:2b96 with SMTP id r15-20020a05640251cf00b0041963e22b96mr4742125edd.336.1648562185776;
        Tue, 29 Mar 2022 06:56:25 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id ds5-20020a170907724500b006df8f39dadesm7006601ejc.218.2022.03.29.06.56.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Mar 2022 06:56:25 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Han Xin <chiyutianyi@gmail.com>,
        Jiang Xin <worldhello.net@gmail.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Derrick Stolee <stolee@gmail.com>,
        Philip Oakley <philipoakley@iee.email>,
        Neeraj Singh <neerajsi@microsoft.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v12 7/8] unpack-objects: refactor away unpack_non_delta_entry()
Date:   Tue, 29 Mar 2022 15:56:12 +0200
Message-Id: <patch-v12-7.8-11f7aa026b4-20220329T135446Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1548.g36973b18e52
In-Reply-To: <cover-v12-0.8-00000000000-20220329T135446Z-avarab@gmail.com>
References: <cover-v11-0.8-00000000000-20220319T001411Z-avarab@gmail.com> <cover-v12-0.8-00000000000-20220329T135446Z-avarab@gmail.com>
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
2.35.1.1548.g36973b18e52

