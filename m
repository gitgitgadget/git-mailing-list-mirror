Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBDD3C433DB
	for <git@archiver.kernel.org>; Thu, 28 Jan 2021 18:25:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8560664E22
	for <git@archiver.kernel.org>; Thu, 28 Jan 2021 18:25:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232085AbhA1SZg (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Jan 2021 13:25:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231653AbhA1SX4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Jan 2021 13:23:56 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5FC5C061573
        for <git@vger.kernel.org>; Thu, 28 Jan 2021 10:23:15 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id c127so5333070wmf.5
        for <git@vger.kernel.org>; Thu, 28 Jan 2021 10:23:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3/zj332x22+4/Qhq6k3/GQJarXN0vzGGujap2HnvvkU=;
        b=c7eYJaB3y68e8cVBfEq+pT3J4riKW7p/svU0W+erPUGmgI8B11rjZWBmGzkqT3RQ8A
         4nb5a1oT7Waac0bMWu2ZsgxMwd5jQWUiQwKHpLf00jVv1Lc2rNCai+ajXahO05TgxBMp
         oFFAvGHS5DEZD1yUWKrumuLVs/CGB3KM2VlzdHUnZtJ36BNgYA/wRGqoEMUPQwkU9Fed
         a7ONZJLcV1iNOp+Gbs9aySHpwqylUuiX18Q4S4/Iz7Ebp8l40FVDZm3ZSFQcLuZvB3XG
         YQi3TgfOUBdV6ou1a+IDkjCWG9wDV1tBjhCQpwgyxRRA3m2WzRlAq5ndRcMKWAaH/qB5
         R2TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3/zj332x22+4/Qhq6k3/GQJarXN0vzGGujap2HnvvkU=;
        b=fZ26pNCDkjLzdgSDIXV31Tp56erQjtXZ+WCNm7jXb3KZF6Llb6RhNM8PB/kB7ic6sW
         ir3KQbsFp0L3khXFdBjoEc9UBNJaCnmOjXOUkaaNOsCUtnNQNYAmKoSOnL5oFHowZ5by
         hlj4uwAyPn8eUhn6nyp1S1FcoYL67MZe7Y7iFJ/w2GXzZJaEYk/nM7tSr2boF/tIW9nS
         9eADSEN8IbuvAEZI+sGL+1azSM+WOW+o0As9YLRBG3+Mh8eTo3nqsGr7z61CogmTYTrB
         1NLic0KSEQlGzCO3Aab8PLjX+XrjTo+gh31kwkwwbRICUA0mJWfS+8yVxFcao5vwvmMj
         DbnA==
X-Gm-Message-State: AOAM530DPnENlv4Z4fVKahtn8wzgUZuP7AHX4YOumuAe4Zk+TLy8TSVb
        0P8LmLtJUKGnHmAV8aEIGPqB7GVd/dhWlA==
X-Google-Smtp-Source: ABdhPJxedPmc0zSc2nCMhK+Ll4rxyJT9/CmaBLwKBf/9S8sx/0hOWlviLLPzLqWu+0pzXx+auTu1RQ==
X-Received: by 2002:a1c:2d48:: with SMTP id t69mr502455wmt.124.1611858194385;
        Thu, 28 Jan 2021 10:23:14 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o14sm7647357wri.48.2021.01.28.10.23.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jan 2021 10:23:13 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 0/6] Makefile: add {program,xdiff,test,git}-objs & objects targets
Date:   Thu, 28 Jan 2021 19:23:04 +0100
Message-Id: <20210128182310.26787-1-avarab@gmail.com>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8
In-Reply-To: <YBCGtd9if0qtuQxx@coredump.intra.peff.net>
References: <YBCGtd9if0qtuQxx@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a replacement for a series I sent in
https://lore.kernel.org/git/20210126160708.20903-1-avarab@gmail.com/

As noted there I can just run "make git", which I'd somehow managed to
miss. So that complexity isn't needed.

But Jeff King suggested a hack to just get you to the point of
git.o. I don't need that right now, but that seems sensible, so I
implemented it.

At the start of this series I've got a patch to make "all" stop
redundantly depending on "FUZZ_OBJS", which also helps with such
"rebase -i --exec=..." use-cases.

Ævar Arnfjörð Bjarmason (6):
  Makefile: remove "all" on "$(FUZZ_OBJS)"
  Makefile: guard against TEST_OBJS in the environment
  Makefile: split up long OBJECTS line
  Makefile: sort OBJECTS assignment for subsequent change
  Makefile: split OBJECTS into OBJECTS and GIT_OBJS
  Makefile: add {program,xdiff,test,git}-objs & objects targets

 Makefile | 29 ++++++++++++++++++++---------
 1 file changed, 20 insertions(+), 9 deletions(-)

-- 
2.29.2.222.g5d2a92d10f8

