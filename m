Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4418CD80C2
	for <git@archiver.kernel.org>; Tue, 10 Oct 2023 12:39:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231962AbjJJMjc (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Oct 2023 08:39:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231932AbjJJMj0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Oct 2023 08:39:26 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51970C9
        for <git@vger.kernel.org>; Tue, 10 Oct 2023 05:39:15 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-40537481094so52062935e9.0
        for <git@vger.kernel.org>; Tue, 10 Oct 2023 05:39:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696941553; x=1697546353; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n1KT/RpPiB3ydvZP59FagJ5XhQe3osyIlL68u32k3a8=;
        b=evMZ41TtMz1FvAvW/PxLt9tEDbj/ltCLAYSnxJpcU7iqWr6H3B/tcmAsXmkpE3WDBx
         HmfajyIgMzWqu8D2JWMDmM9m+rbX12vMBWYZKHNKw+V7L2wKKH3VPkgEb/OCUWZY/NXV
         MzvTGtM57PsCO9PC4mYTg7wa09Wx4bB8BGbk58puroNVHqaJxD6zX9lASr9D8dkMzCod
         KNNfiDBFszeAZ2w1EbYl9GDalP5/FFkpW2BlP+hcL4+e8Qcu0OgEmhJRpN/kMWNh+p4/
         S5IlF7e1LaCTpFXXyVPk+u9UwcGCUOkvh5PUB30sfBrSBPb2zG5DA8BWTORvtAYrCe+n
         11gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696941553; x=1697546353;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n1KT/RpPiB3ydvZP59FagJ5XhQe3osyIlL68u32k3a8=;
        b=gtFKGfDJCEP3AFryMOVq/5rxTKG6gHeTcetH7TFTbgikG4rpiNaDr4Rd7tBusZ1Utu
         aVTceOKa4MsJXmv6PLoCkdG7+UitO2v8PfW6/2suLig/LaCbSuHGB6ARqfa/pvSRbKLI
         fToGcsZ9F6KFN5QN9DEFcEnGc7/oLmpGZv1OCLJ8L0h3eYFn2y5bHTWiTcHy07N1R1hx
         PR9M+BD3OKRufZO0HtcEIOCI3vrXo7FSxgvt5rxN+vLwgmZ8UX+rMdYOt1EJ+5jK+whI
         0Xmm/5paLtUKktFbjUEdat6AlWpcYsGUK6kQj/AS20eEIVLWH5IVRF5BFnZ9RrxRJjBx
         E0sQ==
X-Gm-Message-State: AOJu0YxRTE7z3pjMq8UII26PJVd9cMjijqOu2XNdqTUZ7L8EuMKlwN1u
        mBkKO/vFOQPU/bhJzoT4hhZtEHbKISuEkw==
X-Google-Smtp-Source: AGHT+IF3j8gcKWnmpThZItYkMZ3lUOBoBN55pva8la+EgmEHMDvFLAGT2NZeWSbsm4jU+TcoLM0aJg==
X-Received: by 2002:a7b:cd0a:0:b0:405:3dbc:8821 with SMTP id f10-20020a7bcd0a000000b004053dbc8821mr15417880wmj.22.1696941553241;
        Tue, 10 Oct 2023 05:39:13 -0700 (PDT)
Received: from localhost.localdomain ([2001:861:3f04:7ca0:516d:299b:cbff:be05])
        by smtp.gmail.com with ESMTPSA id p15-20020a7bcc8f000000b003fee6e170f9sm14071689wma.45.2023.10.10.05.39.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 05:39:12 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>,
        John Cai <johncai86@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Calvin Wan <calvinwan@google.com>, Toon Claes <toon@iotcl.com>,
        Dragan Simic <dsimic@manjaro.org>,
        Linus Arver <linusa@google.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v5 07/14] replay: add an important FIXME comment about gpg signing
Date:   Tue, 10 Oct 2023 14:38:40 +0200
Message-ID: <20231010123847.2777056-8-christian.couder@gmail.com>
X-Mailer: git-send-email 2.42.0.339.g663cbc8ab1
In-Reply-To: <20231010123847.2777056-1-christian.couder@gmail.com>
References: <20230907092521.733746-1-christian.couder@gmail.com>
 <20231010123847.2777056-1-christian.couder@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

We want to be able to handle signed commits in some way in the future,
but we are not ready to do it now. So for the time being let's just add
a FIXME comment to remind us about it.

These are different ways we could handle them:

  - in case of a cli user and if there was an interactive mode, we could
    perhaps ask if the user wants to sign again
  - we could add an option to just fail if there are signed commits

Co-authored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Elijah Newren <newren@gmail.com>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/replay.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/replay.c b/builtin/replay.c
index 5bab89857f..dbadf3b9b4 100644
--- a/builtin/replay.c
+++ b/builtin/replay.c
@@ -62,7 +62,7 @@ static struct commit *create_commit(struct tree *tree,
 	struct object *obj;
 	struct commit_list *parents = NULL;
 	char *author;
-	char *sign_commit = NULL;
+	char *sign_commit = NULL; /* FIXME: cli users might want to sign again */
 	struct commit_extra_header *extra;
 	struct strbuf msg = STRBUF_INIT;
 	const char *out_enc = get_commit_output_encoding();
-- 
2.42.0.339.g663cbc8ab1

