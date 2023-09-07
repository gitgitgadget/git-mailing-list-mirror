Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84AFCEC873F
	for <git@archiver.kernel.org>; Thu,  7 Sep 2023 15:26:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238874AbjIGPYf (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Sep 2023 11:24:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238017AbjIGPXo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Sep 2023 11:23:44 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24AF5CA
        for <git@vger.kernel.org>; Thu,  7 Sep 2023 08:23:39 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2bcb0b973a5so18768121fa.3
        for <git@vger.kernel.org>; Thu, 07 Sep 2023 08:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694100217; x=1694705017; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kycl7eo8JkvIoN6yTGIme6lpNri20fB4MA/DAHFXLMs=;
        b=XnrqjhQzf69wXyYCGcbA3+0gZylZDZ+3PFRaT1UE3rnkZQ0f/qTF9HDJT9s1pFT4GY
         LKMwhLz6/rwjvoEQYXqVFX9Yhir5OQjsYGVu8fH6ADILOR4tM/L+52Jj+3kf8KnFMHbH
         VpHTzINXWZcP6k7az7rZUcIavCN5pkmeE2yr1llp3TJlTmnFFLvRITJ7p+KE3oux2Oe5
         XAG8OmMXaOQz9H/QvgYkaW7T6/ZOa0k4CHjBRAo5gzSQTE1aIuvZC2ljnxLRuUEke3xG
         xRzkpn947mJDxI6dKYQH4yuoQY6nc0VeqtML9HgEFNZV07dggJrsGyJUfWQ/oOnQj9IY
         kaHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694100217; x=1694705017;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kycl7eo8JkvIoN6yTGIme6lpNri20fB4MA/DAHFXLMs=;
        b=Yx+TkH9n/6RfSoraotYV+G92tsTlmKP5MLjLIYug2Qho47Hc5L5EaQVlMw/xSVqBE0
         GQGREts9gRNP4d3SPgxZp+DUXe2sOOqs52/fEH/AQDfg685WvJfqziG0AgSSlnHRRNXl
         moh/EWmForLl56WcTBAhC49XG4+fYlGEy2p4JM1btvJEYGMaAfYnQOudBLamj554mKa+
         lsM3X+DZHNFPBjpWST8FN07OkG/OEftsJcCSKuGO1WL5E/ZioVBMc3OBNkgz+N1wzJnp
         TethB2IXpiML14/o+ERDIEyw6LGvZQLJ6z8728+FyTkCLeh4PWW+mrcSlO1vUMcZPRzr
         iLuA==
X-Gm-Message-State: AOJu0Yzu5iQL4UDBZXLnnfLA3tu1Pd6w4UVBlYNKY+/e0gvskFos9l+X
        bhbFm0xATqjrx88w8K60O3BGeaSnHCo=
X-Google-Smtp-Source: AGHT+IE4/yG4a1646qmymRpZ3XhM+jm6ghyxTnEE5X3OcOXzYdbsQZVHziSd1YyczqdoYsMbyxlV7g==
X-Received: by 2002:a05:600c:2285:b0:401:5443:5598 with SMTP id 5-20020a05600c228500b0040154435598mr4233433wmf.25.1694078859602;
        Thu, 07 Sep 2023 02:27:39 -0700 (PDT)
Received: from localhost.localdomain ([2001:861:3f04:7ca0:3385:ce2d:69dd:303e])
        by smtp.gmail.com with ESMTPSA id y8-20020adff148000000b00317c742ca9asm22491522wro.43.2023.09.07.02.27.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Sep 2023 02:27:38 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>,
        John Cai <johncai86@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Calvin Wan <calvinwan@google.com>, Toon Claes <toon@iotcl.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v4 07/15] replay: add an important FIXME comment about gpg signing
Date:   Thu,  7 Sep 2023 11:25:13 +0200
Message-ID: <20230907092521.733746-8-christian.couder@gmail.com>
X-Mailer: git-send-email 2.42.0.126.gcf8c984877
In-Reply-To: <20230907092521.733746-1-christian.couder@gmail.com>
References: <20230602102533.876905-1-christian.couder@gmail.com>
 <20230907092521.733746-1-christian.couder@gmail.com>
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
index 4b1e501595..47d695df93 100644
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
2.42.0.126.gcf8c984877

