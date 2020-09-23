Return-Path: <SRS0=8LOk=DA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9477EC2D0A8
	for <git@archiver.kernel.org>; Wed, 23 Sep 2020 09:38:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3AB3F23600
	for <git@archiver.kernel.org>; Wed, 23 Sep 2020 09:38:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k4BYFtEt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726242AbgIWJiz (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Sep 2020 05:38:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726102AbgIWJiz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Sep 2020 05:38:55 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 776F5C0613CE
        for <git@vger.kernel.org>; Wed, 23 Sep 2020 02:38:55 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id f18so14690803pfa.10
        for <git@vger.kernel.org>; Wed, 23 Sep 2020 02:38:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7SBEmb3FTZy0xH77d7QVRnFSAZ5uIRSvmGDAZV5hBg0=;
        b=k4BYFtEtKyj6DuShgT0pan6Q4SmBKr0npcXFGi1oM4RcGt1NWMpQlBAC/4fqVTyYOc
         4daid6MlZAMveWBD3DJcA2+bKfIXiSaAXR08gBz9gpCAuVL1ukfFjX8rN/7Z2tlyUqPy
         RCcJdUPRrSw3G2FpBVly8dqwFQqB0va1Os4FbINbSR9mN02KqqfLX+W+2+9te4OP/0Ou
         4Dw4hr/lcSWlgloPOIcDtcoiNNcHSqYa2CQdav36XQ7wMmW8udyYCMM+va3LvK+hUYy2
         YmrT7ekJrh+yKxS4fJgxqbCCTds2OB18dqj49oueQO4KAcOOdIZ1BH/1iPLxHW9rlA0s
         5jmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7SBEmb3FTZy0xH77d7QVRnFSAZ5uIRSvmGDAZV5hBg0=;
        b=RzK0VhvpdiBuCJ3kMkDU38lrCoFjI4lvwCxWU+sqY9qK0kPkzeK5fCP/Wr3WldmJZT
         a9CoFfeyjnGs7rpFlF5PNwxFFAIOF9UYj1JpD7rlxqJgobMnNlDtzSjUtc4E8jLByX13
         d4Lr8ah9wMOsnl67JDSd1Jio445yX9THDUJL5NhQ4H+frdiixvKUMYeQ06tlXjXHVc9m
         MlyrYOJnwKGwHStkiQ+25K68wiVnWXgXaVQWuMwnWZ8MdfKkz96q5N1GGik8dwNCR2g7
         Ku2trqXvogQO+m2Y5rcPrFCDrPGFjMceoP3Ec4pNhlPR2G9n5I4brvIivqQhC0ZDIddl
         hTRA==
X-Gm-Message-State: AOAM530auT0LSmMDObq9xJ8csUEiMkbu3QPdTsNZh9YFxT0y4KiFx66a
        xvJM5aE/qJDibQMYaQ6JKQw+pSBcFeU=
X-Google-Smtp-Source: ABdhPJzqiGLrp6x2Did1uC0/6mMl7JaOveUo1Pxpk5X+UOwlKc1gLgkubhvLn8nQbbDGnzsXMXFYuQ==
X-Received: by 2002:a63:1620:: with SMTP id w32mr6997676pgl.73.1600853934651;
        Wed, 23 Sep 2020 02:38:54 -0700 (PDT)
Received: from archbookpro.hsd1.ca.comcast.net ([2601:647:4201:c540::414c])
        by smtp.gmail.com with ESMTPSA id gm17sm4564464pjb.46.2020.09.23.02.38.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2020 02:38:53 -0700 (PDT)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     "brian m . carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Taylor Blau <me@ttaylorr.com>,
        Junio C Hamano <gitster@pobox.com>,
        Chris Torek <chris.torek@gmail.com>,
        Andreas Schwab <schwab@linux-m68k.org>
Subject: [PATCH v2 0/3] sample hooks: become hash agnostic
Date:   Wed, 23 Sep 2020 02:38:42 -0700
Message-Id: <cover.1600853895.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.28.0.760.g8d73e04208
In-Reply-To: <cover.1600427894.git.liu.denton@gmail.com>
References: <cover.1600427894.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There are currently two hooks that have hardcoded 40 zeros as the null
OID and, thus, are not hash-agnostic. Rewrite these to get the zero OID using

	git hash-object --stdin </dev/null | tr '[0-9a-f]' '0'

so that the zero OID is hash-agnostic.

This was initially done by introducing `git rev-parse --null-oid` to get the
zero OID but that seems like overkill. From a cursory search of Github, the
only instances of the zero OID being used come from clones of the git.git
repository (tests and sample hooks). Since we don't want to introduce an option
that no one will use, don't go this route and just do the easiest thing.

If in the future, someone decides that `git rev-parse --zero-oid` is useful,
they can also adjust these hooks accordingly.

Changes since v1:

* Don't implement `git rev-parse --null-oid`

Denton Liu (3):
  hooks--pre-push.sample: modernize script
  hooks--pre-push.sample: use hash-agnostic zero OID
  hooks--update.sample: use hash-agnostic zero OID

 templates/hooks--pre-push.sample | 18 +++++++++---------
 templates/hooks--update.sample   |  2 +-
 2 files changed, 10 insertions(+), 10 deletions(-)

Range-diff against v1:
1:  ed1ade7328 < -:  ---------- hooks--pre-push.sample: prefer $() for command substitution
2:  004f2e4c92 < -:  ---------- builtin/rev-parse: learn --null-oid
3:  9d6c2951ab < -:  ---------- hooks--pre-push.sample: use hash-agnostic null OID
-:  ---------- > 1:  95dd0b19ba hooks--pre-push.sample: modernize script
-:  ---------- > 2:  afb460d9fd hooks--pre-push.sample: use hash-agnostic zero OID
4:  42d2829889 ! 3:  784135549f hooks--update.sample: use hash-agnostic null OID
    @@ Metadata
     Author: Denton Liu <liu.denton@gmail.com>
     
      ## Commit message ##
    -    hooks--update.sample: use hash-agnostic null OID
    +    hooks--update.sample: use hash-agnostic zero OID
     
    -    The update sample hook has the null OID hardcoded as 40 zeros. However,
    +    The update sample hook has the zero OID hardcoded as 40 zeros. However,
         with the introduction of SHA-256 support, this assumption no longer
         holds true. Replace the hardcoded $z40 with a call to
    -    `git rev-parse --null-oid` so the sample hook becomes hash-agnostic.
    +
    +            git hash-object --stdin </dev/null | tr '[0-9a-f]' '0'
    +
    +    so the sample hook becomes hash-agnostic.
     
      ## templates/hooks--update.sample ##
     @@ templates/hooks--update.sample: esac
    @@ templates/hooks--update.sample: esac
      # --- Check types
      # if $newrev is 0000...0000, it's a commit to delete a ref.
     -zero="0000000000000000000000000000000000000000"
    -+zero="$(git rev-list --null-oid)"
    ++zero=$(git hash-object --stdin </dev/null | tr '[0-9a-f]' '0')
      if [ "$newrev" = "$zero" ]; then
      	newrev_type=delete
      else
-- 
2.28.0.760.g8d73e04208

