Return-Path: <SRS0=WTnS=CW=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3557BC43461
	for <git@archiver.kernel.org>; Sun, 13 Sep 2020 14:54:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E4EA92151B
	for <git@archiver.kernel.org>; Sun, 13 Sep 2020 14:54:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XknmPdFp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725942AbgIMOyd (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 13 Sep 2020 10:54:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725928AbgIMOy2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 13 Sep 2020 10:54:28 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D123C06174A
        for <git@vger.kernel.org>; Sun, 13 Sep 2020 07:54:28 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id o16so4165890pjr.2
        for <git@vger.kernel.org>; Sun, 13 Sep 2020 07:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FkkzCxMcWasApdOAGZ+9XFUsNK47+G+4fKcccP4MpnU=;
        b=XknmPdFpo6H5ijvNLS3Fyxma1YjTD5UKafQnUVzfEo7VpeubOGPoDVqZLNtQ83ZRrl
         DQMXOR0Hye2hW/UMqLqoUXPif13awChu+/BDJZkdllgnJBXl2Ytl3sVzvh3XXDY7URdU
         HguawsXgf05Vz1Jm2PHc14WXyvTHDJ5TGtC2uvibr4zctia9hkwHxvLFn3NtGDPF1WTc
         jrJFYmGS5kztWvAHeZanmoplEsV+5D2JP4Dw0ZB8ixakKO13g7RU/HS7oq9x4ClLEiro
         VlfJhqlzMJYNfH5wevy+tgV0F2IcxqlJJ4ucvj2fT6tV3Aj6s04ZGpPL+s6DIjAkfkY6
         2eEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FkkzCxMcWasApdOAGZ+9XFUsNK47+G+4fKcccP4MpnU=;
        b=J23T6l09wrKPqbJF3cWDsEgyjUi31RpdlCwkn6m3rlI2+mGmJSHT5fhSGfPbBbZ6I+
         qE//swGebY8O3bq0TUnCWe/qJRIDYQuVwlg5zftL6MtEElkJ7YDx3v08hxKCe25i20mw
         iyztwjlJXToHIVRSUcgCB8q3gnLQlWtVYyvrshnB1b4ZnGIUN8I8wo6a+JaoDGcxuXI8
         qDAeqF1CiCkbLX0zSu6OXRequ/feS7SP7HS6zg2HO4FzcbbkBpwe1ZK57HbTQKuRO9OA
         qpeAbwSDLt9IZZm+VL6PXvjJ2jyvcx0nUhHEQC5tiLom7PnuhvD1cEwF1R7cWiMmh42X
         3yOA==
X-Gm-Message-State: AOAM533HroBi9GMiR1z4tuyhWH99WnVOguJZD2/Fz9QYRTMBExDsvO26
        sBKL46XxPlXfef5QCm55Nyaelro2lh/UckYPo1Y=
X-Google-Smtp-Source: ABdhPJzZFcalFJbEoflXdmlNY7/lgNuhj0plafY/vpy8qq52qxpvT8VT/G1UCUpylUNQf+Qf4z6uFQ==
X-Received: by 2002:a17:90b:2388:: with SMTP id mr8mr9921116pjb.161.1600008866819;
        Sun, 13 Sep 2020 07:54:26 -0700 (PDT)
Received: from localhost.localdomain ([66.115.146.77])
        by smtp.gmail.com with ESMTPSA id z1sm2774650pfj.113.2020.09.13.07.54.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 13 Sep 2020 07:54:25 -0700 (PDT)
From:   Srinidhi Kaushik <shrinidhi.kaushik@gmail.com>
To:     git@vger.kernel.org
Cc:     Srinidhi Kaushik <shrinidhi.kaushik@gmail.com>
Subject: [PATCH v3 0/7] push: add "--[no-]force-if-includes"
Date:   Sun, 13 Sep 2020 20:24:06 +0530
Message-Id: <20200913145413.18351-1-shrinidhi.kaushik@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200912150459.8282-1-shrinidhi.kaushik@gmail.com>
References: <20200912150459.8282-1-shrinidhi.kaushik@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a new option: "--force-if-includes" to `git-push` where forced
updates are allowed only if the tip of the remote-tracking ref has
been integrated locally, by verifying if the tip of the remote-tracking
ref -- on which a local branch has based on -- is reachable from at
least one of the "reflog" entries of the branch about to be updated
by force on the remote.

This option can also be used with `--force-with-lease` with setups
where the remote-tracking refs of the repository are implicitly
updated in the background to help prevent unintended remote
overwrites.

If a local branch is based on a remote ref for a rewrite, and if that
remote-tracking ref is updated by a push from another repository after
it has been checked out locally, force updating that branch to remote
with `--force-with-lease[=<refname>[:expect]]` without specifying the
"<refname>" or "<expect>" values, can cause the update that happened
in-between the checkout and forced push to be lost.

Changes since v2:
  * Removed configuration option for setting "--force-if-includes"
    with "--force-with-lease".
  * Broke up the patch into smaller commits.

base-commit: 54e85e7af1ac9e9a92888060d6811ae767fea1bc

Srinidhi Kaushik (7):
  remote: add reflog check for "force-if-includes"
  transport: add flag for "--[no-]force-if-includes"
  send-pack: check ref status for "force-if-includes"
  transport-helper: update ref status for "force-if-includes"
  builtin/push: add option "--[no-]force-if-includes"
  doc: add reference for "--[no-]force-if-includes"
  t: add tests for "force-if-includes"

 Documentation/config/advice.txt   |   9 +-
 Documentation/git-push.txt        |  19 ++++
 advice.c                          |   3 +
 advice.h                          |   2 +
 builtin/push.c                    |  20 +++-
 builtin/send-pack.c               |   5 +
 remote.c                          | 135 +++++++++++++++++++++++--
 remote.h                          |  14 ++-
 send-pack.c                       |   1 +
 t/t5533-push-cas.sh               |  26 +++++
 t/t5549-push-force-if-includes.sh | 161 ++++++++++++++++++++++++++++++
 transport-helper.c                |   5 +
 transport.c                       |  18 +++-
 transport.h                       |  12 ++-
 14 files changed, 411 insertions(+), 19 deletions(-)
 create mode 100755 t/t5549-push-force-if-includes.sh

--
2.28.0
