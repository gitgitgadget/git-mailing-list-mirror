Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDB1FC43460
	for <git@archiver.kernel.org>; Wed, 19 May 2021 11:48:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD31261353
	for <git@archiver.kernel.org>; Wed, 19 May 2021 11:48:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348143AbhESLt4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 May 2021 07:49:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243918AbhESLtz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 May 2021 07:49:55 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 018C8C06175F
        for <git@vger.kernel.org>; Wed, 19 May 2021 04:48:35 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id j10so18588766lfb.12
        for <git@vger.kernel.org>; Wed, 19 May 2021 04:48:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xMQuLbdn/hBZS2Em2/mRIDbZefrO22FcTXTis8TTzqg=;
        b=hUk0qgWCwh+iRhEOtjLeSuqvJFfQxRYUYneaW8FpC2gKZcpQTEaMiuOPnJWotJ2zcx
         aJKBtGsvm3ynLOpcy6gzMEh26jwc4yeTm+pRo+MEa9xaF+cbftSPhCxwN6c3hL7PGVom
         EprjrRV7CwntErrMBU3DFgEGnTww14y3ZcgVsH3uvOU6UJh+xu9xpFEDCSn+TW8N0qvt
         67JtzZgFOmkVAUIMugtXzVV+rQ6juvgY11ZjRbjN2ne2DVSVPK92qgxgxtNBRc4+fzKA
         nBcGlHzForfGSVp+kwgyoBiseoC3NdDpBwHfJPNGB78TQ793P+E7SSO3VwKY3Svvzrsc
         DCKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xMQuLbdn/hBZS2Em2/mRIDbZefrO22FcTXTis8TTzqg=;
        b=SkF04CnwS6CFnee2y2glJkpNLhFpJyJUNVP8bWKIki09VuuG8LhQFt4paK4/ob9d/e
         p6QdNLnAXm3alVu3kFlUxlh3ebfpEKQgjHAWym6IWrEz6xL7DcBZWD8knM4FgE40v/3Z
         lbWrkujeGSiW3phizh96jdFR73f/iIA542D8F/h2p/rgbndgItVZUMIGRqU78jwaCtEI
         F4dA9AQ3LUWZ7uv25vNKvri1f3uth+38/qUKoVcfhfE0LcdEStVpTsgX1X7ZRUJYdm85
         /9ajWL1BzazszJgaKDdDk4DQ/CWu4hugpW8RcfO1EZ44s3gUj6/cGylZCvrGAaa6I0DX
         JDxw==
X-Gm-Message-State: AOAM533fQFELPpKCmkGxdQKFYIJjS3TDbo/3Z5JaV7sJooiNL9/H3XK+
        lHQgOyC6riKA1RjafbicdbnomeRQHG8=
X-Google-Smtp-Source: ABdhPJxzhgpgZjySDTsTvA+PVSBBUxX/rC2JV1bpIrQ0/EY9yrlWibAVQzZFoBbpdeLQEh72mpazeQ==
X-Received: by 2002:ac2:5447:: with SMTP id d7mr8054548lfn.348.1621424913325;
        Wed, 19 May 2021 04:48:33 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id o2sm1846470ljp.60.2021.05.19.04.48.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 May 2021 04:48:32 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Philip Oakley <philipoakley@iee.email>,
        Elijah Newren <newren@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Alex Henrie <alexhenrie24@gmail.com>,
        git@vger.kernel.org, Sergey Organov <sorganov@gmail.com>
Subject: [PATCH v2 0/9] diff-merges: let -m imply -p
Date:   Wed, 19 May 2021 14:45:43 +0300
Message-Id: <20210519114552.4180-1-sorganov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <CAMMLpeR-W35Qq6a343ifrxJ=mwBc_VcXZtVrBYDpJTySNBroFw@mail.gmail.com>
References: <CAMMLpeR-W35Qq6a343ifrxJ=mwBc_VcXZtVrBYDpJTySNBroFw@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix long standing inconsistency between -c/--cc that do imply -p, on
one side, and -m that did not imply -p, on the other side.

Only the last patch is the actual functional change. The rest of
patches are additional tests and refactorings that are not expected to
alter existing behaviors.

After these patches

  git log -m

produces diffs without need to provide -p as well, that improves both
consistency and usability. It gets even more useful if one sets
"log.diffMerges" configuration variable to "first-parent" to force -m
produce usual diff with respect to first parent only.

These series, however, don't change behavior when specific diff format
is explicitly provided on the command-line, so that commands like

  git log -m --raw
  git log -m --stat

are not affected.

Exact historical semantics of -m is still provided by
--diff-merges=separate.

Updates in v2:

  * Fix style and typos in descriptions

Updates in v1:

  * Stop parsing distinct diff-index options beforehand, as it could
    cause unexpected behaviors. Implement different strategy to avoid
    clash of diff-index "-m" and diff-merges "-m".

  * Added tests for "git log -m --raw" and "git log -m".

Sergey Organov (9):
  t4013: test that "-m" alone has no effect in "git log"
  t4013: test "git log -m --raw"
  t4013: test "git log -m --stat"
  t4013: test "git diff-index -m"
  diff-merges: move specific diff-index "-m" handling to diff-index
  git-svn: stop passing "-m" to "git rev-list"
  stash list: stop passing "-m" to "git log"
  diff-merges: rename "combined_imply_patch" to "merges_imply_patch"
  diff-merges: let "-m" imply "-p"

 Documentation/diff-options.txt    |  8 ++--
 builtin/diff-index.c              |  9 +++++
 builtin/stash.c                   |  2 +-
 diff-merges.c                     | 36 +++++++++--------
 diff-merges.h                     |  2 +
 perl/Git/SVN.pm                   |  2 +-
 revision.h                        |  2 +-
 t/t3903-stash.sh                  |  2 +-
 t/t4013-diff-various.sh           | 23 +++++++++++
 t/t4013/diff.log_-m_--raw_master  | 61 ++++++++++++++++++++++++++++
 t/t4013/diff.log_-m_--stat_master | 66 +++++++++++++++++++++++++++++++
 11 files changed, 188 insertions(+), 25 deletions(-)
 create mode 100644 t/t4013/diff.log_-m_--raw_master
 create mode 100644 t/t4013/diff.log_-m_--stat_master

Interdiff against v1:
-- 
2.25.1

