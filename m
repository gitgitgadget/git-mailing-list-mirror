Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 251A8C433ED
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 08:50:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D811861177
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 08:50:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231370AbhDIIu1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Apr 2021 04:50:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229673AbhDIIuZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Apr 2021 04:50:25 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00B42C061760
        for <git@vger.kernel.org>; Fri,  9 Apr 2021 01:50:13 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a7so7452350eju.1
        for <git@vger.kernel.org>; Fri, 09 Apr 2021 01:50:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/YMWH66z7XKrYnP2WkxP0vtnHc7CYK+X5/MfNWU5LZ0=;
        b=Zhp+/IXfqwhHKVwrEU9mZE05MogAa752QrDbMrzYoHkD4lZBn0N+8WZZmlgaPLN1eq
         4CDdmvZCT/L8PdjDFQ0P0U+oJOzQgar+A5F4VKRoQa87ZPiL07JPvNoxfy6dUmiDI7CW
         I/F06D7rkUjKVzNKd3K8hsHDKDh1mtEw000XKOqy1e45Xwh/CrphHXJtL3XmTlih28tg
         gfVnYNRj6SVVwCUJf4isQkbmo3qGROX2L7rKz3RYaQhAEVruKBdF3Ii0FReqEqFO4N2n
         zC3XTaVK6NI5huG0VM+RDAa0zvQRWKb3i3qps2XPnWf9eR8Nlu2TtaaDoIjJaycX7uXt
         Om9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/YMWH66z7XKrYnP2WkxP0vtnHc7CYK+X5/MfNWU5LZ0=;
        b=JtnGY04Iun7+FbWZ6qej9J+L5zinLGj1Zt0eNDb0ih9oy+iyHlsVrFXZtsA/Tax0za
         w0IbDIJXR9C1rBxnz4cf78RHPwDT72UGile87P/KqyMFfQT7ZOngUcM6QgObn2Qu+Wra
         0JvNcoeP2o3yI+ebVPJqVIz/PDUksYW8QkaZjThR0jnNNqwx6c+62NYaBGs6TuA/bqtY
         QJeS+AnOy7mq0q3z4TpVALEM8y4J7ZmcuhqBcQMaO3NvcTWSEk2XCmMDoL05TAfISRu+
         BLT8zXEcMc0KySwzfD4SwtECIbCr77obaezDlqGLpFStqnsEcvINI2wIkF+Kh8ILeWCi
         0Axg==
X-Gm-Message-State: AOAM5315miaJ65ShFuA1LITDAfOE1daKpSo01eYaFRR0KCyge0Oq+o59
        +zvVkaW8bpgAeEBFFF+gKCP2SSFdFRvW8w==
X-Google-Smtp-Source: ABdhPJygY8VgeWVPrj2AZk0g4VjuJRYPVSOsi7VWPdTy4IOyuB+CAtf7l7Pe6M3x3rq23vfx6AbQ0Q==
X-Received: by 2002:a17:906:1fd7:: with SMTP id e23mr5283268ejt.528.1617958211518;
        Fri, 09 Apr 2021 01:50:11 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id m29sm883601ejl.61.2021.04.09.01.50.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Apr 2021 01:50:11 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 0/7] object.c: add and use "is expected" utility function + object_as_type() use
Date:   Fri,  9 Apr 2021 10:49:55 +0200
Message-Id: <cover-0.7-0000000000-20210409T083436Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.592.gdf54ba9003
In-Reply-To: <cover-0.6-0000000000-20210409T082935Z-avarab@gmail.com>
References: <cover-0.6-0000000000-20210409T082935Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This goes on top of [1] and is part of a split-up [2] into more
digestable pieces.

As in [2] we reduce duplication of "object %s is a %s not a %s" in
various places by moving those messages/errors/dies to using a utility
function.

For the more meaty "don't misreport objects" change I'm planning to
submit on top of this I'm then refactoring object_as_type() to not
take a "quiet" argument. This wasn't strictly needed, but makes things
simpler.

As it turned out we had various parts of the codebase (ab)using
object_as_type() just to check if something was of a given type,
anything that deals with parsed objects can/should just use obj->type
== OBJ_{COMMIT,TREE,BLOB,TAG} instead. This leaves object_as_type() as
a low-level function for use in the object API itself.

1. http://lore.kernel.org/git/cover-0.6-0000000000-20210409T082935Z-avarab@gmail.com
2. https://lore.kernel.org/git/cover-00.11-00000000000-20210328T021238Z-avarab@gmail.com/

Ævar Arnfjörð Bjarmason (7):
  tree.c: fix misindentation in parse_tree_gently()
  object.c: add a utility function for "expected type X, got Y"
  object.c: add and use oid_is_type_or_die_msg() function
  commit-graph: use obj->type, not object_as_type()
  commit.c: don't use deref_tag() -> object_as_type()
  object.c: normalize brace style in object_as_type()
  object.c: remove "quiet" parameter from object_as_type()

 blob.c                 |  2 +-
 builtin/commit-graph.c |  2 +-
 builtin/fsck.c         |  2 +-
 builtin/index-pack.c   |  9 +++-----
 combine-diff.c         |  3 +--
 commit.c               | 28 ++++++++++++++---------
 merge-recursive.c      |  5 ++++-
 object.c               | 51 ++++++++++++++++++++++++++++++++++--------
 object.h               | 10 ++++++++-
 refs.c                 |  2 +-
 t/helper/test-reach.c  |  2 +-
 tag.c                  |  2 +-
 tree.c                 | 15 +++++++------
 13 files changed, 90 insertions(+), 43 deletions(-)

-- 
2.31.1.592.gdf54ba9003

