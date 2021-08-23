Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58EEFC4338F
	for <git@archiver.kernel.org>; Mon, 23 Aug 2021 10:44:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 38A4B6137D
	for <git@archiver.kernel.org>; Mon, 23 Aug 2021 10:44:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234094AbhHWKpM (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Aug 2021 06:45:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234155AbhHWKo7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Aug 2021 06:44:59 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B7D2C061575
        for <git@vger.kernel.org>; Mon, 23 Aug 2021 03:44:15 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id f10so10225002wml.2
        for <git@vger.kernel.org>; Mon, 23 Aug 2021 03:44:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=l8tnotcMyXGogPA3nEeT+k9QRhaZX9yKXLcGeccsVfE=;
        b=NrWGqsK/1+h6d2dXSwL3ThRkzOgNM8xrL6Gj/Xe/9ABIjrBSxUh0MnNSAzVXHhJ8t6
         BfsmP0VvZd32AaFXxXH6T7NwD+5JNtEGWNMA5n+D+3Q8wDuM4896qs12HsHFMQtewGHp
         C25ffVL0B5q8m9DqgR40cG3uVcKR7G+fasJL8z4xumPN87Kqii+a/lwxQbzP2y/EHl9+
         Eow52/H17SG/6Z4MN2lwAMohpqEXq4AKwTeiIcixVb02nVeRovh+aAZhXg2c8lvZhfPi
         hv36IXy1xrXr467+rCdiF1gJt/h2/MJiz42mskkeBOXAkNTGvBp4D5ASzZtP882xBoed
         WoMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=l8tnotcMyXGogPA3nEeT+k9QRhaZX9yKXLcGeccsVfE=;
        b=BAbesxWEXhhbCms6pluEqUXJFf7TFvkmkeSBrsPdLaGUWqt5r1l8ryll85t2tY5/gQ
         sgr9ALbn43M3Fl7pEwUz+3gWOi0Izv8Hu0TmFifRqol+RxDIl5a21JmiN+kaY3OoOmrG
         5CSvhZ7rzKu6FodQT7aXIsARPFSe9Q8afJWZMEZvmPzKMRqBII8kXDewATpABsmRCZvb
         XnwlhczBUXwpCo/jAbcOZx+hxjxQ17ce7Z4CdC/PBhcmyOtBcnHx9pbZLEep2CxcNpsj
         l0YNYYtowMADQb6uOVjKzymlDx4RTrhnBYyn3sfOxAgDAmrqQj0+RHbmRe4Hc1Gnx1Z0
         sSfA==
X-Gm-Message-State: AOAM530rT7FrfhBz8Muwmh0MrmyKOKNqIpolg2iktWDmV9Ma9+T5kXc1
        8XwvOLE0RCY/n/r2LE5TkkiXTrq0UrEfOXIy
X-Google-Smtp-Source: ABdhPJzbMDeUiDcLoxV8ynmgNi0BnxnN2cmjRU8BZfzuambHBwTEVeFMREmYcv8rIHKiZipi1HcuRQ==
X-Received: by 2002:a05:600c:3b9c:: with SMTP id n28mr15073486wms.15.1629715453452;
        Mon, 23 Aug 2021 03:44:13 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id k12sm15351187wrd.75.2021.08.23.03.44.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Aug 2021 03:44:13 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Ben Boeckel <mathstuf@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 0/4] advice: remove usage of `advice_*` global variables
Date:   Mon, 23 Aug 2021 12:43:58 +0200
Message-Id: <cover-v4-0.4-00000000000-20210823T103719Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.663.gfcc3c7013a8
In-Reply-To: <RFC-cover-v3-0.4-0000000000-20210806T191231Z-avarab@gmail.com>
References: <RFC-cover-v3-0.4-0000000000-20210806T191231Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I reviewed Ben Boeckel's advice() patches in
https://lore.kernel.org/git/RFC-cover-v3-0.4-0000000000-20210806T191231Z-avarab@gmail.com
and submitted that review as an RFC. Since there's been no feedback
there from the author here's a non-RFC version.

The only change from v3 is the commit message typos/grammar fixes
pointed out by Eric Sunshine. Thanks!

Ben Boeckel (2):
  advice: add enum variants for missing advice variables
  advice: remove read uses of most global `advice_` variables

Ævar Arnfjörð Bjarmason (2):
  advice: remove use of global advice_add_embedded_repo
  advice: move advice.graftFileDeprecated squashing to commit.[ch]

 advice.c                    | 83 ++-----------------------------------
 advice.h                    | 33 +--------------
 branch.c                    |  2 +-
 builtin/add.c               | 11 ++---
 builtin/am.c                |  2 +-
 builtin/checkout.c          |  6 +--
 builtin/clone.c             |  2 +-
 builtin/commit.c            |  4 +-
 builtin/fetch.c             |  2 +-
 builtin/merge.c             |  4 +-
 builtin/push.c              | 12 +++---
 builtin/replace.c           |  2 +-
 builtin/reset.c             |  2 +-
 builtin/rm.c                |  2 +-
 builtin/submodule--helper.c |  2 +-
 commit.c                    |  4 +-
 commit.h                    |  1 +
 editor.c                    |  2 +-
 notes-merge.c               |  2 +-
 object-name.c               |  2 +-
 remote.c                    | 12 +++---
 run-command.c               |  2 +-
 sequencer.c                 |  8 ++--
 unpack-trees.c              | 18 ++++----
 wt-status.c                 |  6 +--
 25 files changed, 63 insertions(+), 163 deletions(-)

Range-diff against v3:
1:  5f934bb083b = 1:  4e977e9d5a1 advice: add enum variants for missing advice variables
2:  eefcafcf8f5 ! 2:  3869bda3b39 advice: remove read uses of most global `advice_` variables
    @@ Commit message
         This patch ports all but two uses which read the status of the global
         `advice_` variables over to the new `advice_enabled` API. We'll deal
         with advice_add_embedded_repo and advice_graft_file_deprecated
    -    seperately.
    +    separately.
     
         Signed-off-by: Ben Boeckel <mathstuf@gmail.com>
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
3:  02613d0f307 ! 3:  e1018212e40 advice: remove use of global advice_add_embedded_repo
    @@ Commit message
         advice: remove use of global advice_add_embedded_repo
     
         The external use of this variable was added in 532139940c9 (add: warn
    -    when adding an embedded repository, 2017-06-14), for the use-case it's
    -    more straightforward to track whether we've adviced in
    +    when adding an embedded repository, 2017-06-14). For the use-case it's
    +    more straightforward to track whether we've shown advice in
         check_embedded_repo() than setting the global variable.
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
4:  fe6f6328f9c = 4:  7f79fb282e5 advice: move advice.graftFileDeprecated squashing to commit.[ch]
-- 
2.33.0.663.gfcc3c7013a8

