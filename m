Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80102C4167B
	for <git@archiver.kernel.org>; Sun,  6 Dec 2020 04:10:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5AB3223104
	for <git@archiver.kernel.org>; Sun,  6 Dec 2020 04:10:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726508AbgLFEIb (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 5 Dec 2020 23:08:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726210AbgLFEI2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Dec 2020 23:08:28 -0500
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4422C0613D4
        for <git@vger.kernel.org>; Sat,  5 Dec 2020 20:07:41 -0800 (PST)
Received: by mail-lj1-x244.google.com with SMTP id r18so11272611ljc.2
        for <git@vger.kernel.org>; Sat, 05 Dec 2020 20:07:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=Uk6xQWnJzXIsmhJvsm/JkujDVCw+vRh88TZXc8xY8sA=;
        b=lB6ZQXQ9d3QomtCap9uCTqls+tUA7N2RoP8O6ClUtlf4GPgrnRJ2Sbj6XLwXrQvwa0
         1wgaJf5gb+OSDUvbp4OXu7TCvsnFs1p0fUzSsghJ+/OnCHIkG19BqdE8bdJPnGx3+4hy
         NwF6VUXAWzfE/0pAiJ9vJ3HO4lzCA07bLKld9kFm+VIkLQ2l3mdu+thz7amnUn3BZ5Uo
         PgdGb3kVw/tqZuvrVuhuf3kO8mLrRvr/jm0w/U11ExKPSYVdgtvBQgKCh6iMDUIEFpTf
         czWh3+kzeGmrSuHx0En8FtzQkiYuvl3dfLyqNxLztsc/xJrgbmO1qtNXoMrm98YwlxxZ
         ykYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Uk6xQWnJzXIsmhJvsm/JkujDVCw+vRh88TZXc8xY8sA=;
        b=Y7SD3D2RfSPu2PiAMqprWiXty62yB3SR7aINFeKkILWoizcCXOtN/MqITtqKAsJ+TW
         Dw5YRB1AWb3mDKmduBxKiHjKqOvj6gllWO1cvmZR8+ji66l0S3MzBBt/1eSDV0aDsU1f
         F9AhduLnWEzoyMUIeSILvKLa7+WwGU8s1STWES8ahjN2nhfwzNjn1KI6q6bK09EyYij9
         YAtOFbnlxf5rC5uGA/DlONPUn1j4wk7moEB61MUSQ86jUXAtxxIuy1fHq/A6z+cpfd3z
         T9KLiL5ZK2+ObrmWctx3MSJB0q/Wq1uhX6jUxpC895YM+8uGsPQ7R/RD8EmsJtA8kRsB
         LnFg==
X-Gm-Message-State: AOAM531jZBTvRmhRXKi4tb9jyu+67Y27Ht2JBtLo9SrZCGGqrs1EdfSX
        5gWM37LFUbmD3KxQXWbZIn/jKqct0XQ=
X-Google-Smtp-Source: ABdhPJwuC9H46jEQm/24gOHak4mDxSJ2rMU5xXVILFpfV5pPqUMWYC4anqZlDX+qMZ55kF5YwP9aJw==
X-Received: by 2002:a5d:4f0e:: with SMTP id c14mr12348782wru.422.1607223278631;
        Sat, 05 Dec 2020 18:54:38 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q4sm8715244wmc.2.2020.12.05.18.54.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Dec 2020 18:54:37 -0800 (PST)
Message-Id: <pull.929.git.git.1607223276.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 06 Dec 2020 02:54:29 +0000
Subject: [PATCH 0/7] diffcore-rename improvements
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch series include 4 small code cleanups, 1 small bug fix (or perhaps
just a UI improvement -- it's a very minor issue either way), and 2
performance improvements. The first 6 patches are relatively easy to review,
while the last one...is a bit more involved (but provided the biggest
performance boost).

These patches came out of the merge-ort work, and are related, but there is
no dependency between any of the series.

Elijah Newren (7):
  diffcore-rename: avoid usage of global in too_many_rename_candidates()
  diffcore-rename: remove unnecessary if-clause
  diffcore-rename: rename num_create to num_targets
  diffcore-rename: change a few comments to use 'add' instead of
    'create'
  diffcore-rename: reduce jumpiness in progress counters
  diffcore-rename: simplify and accelerate register_rename_src()
  Accelerate rename_dst setup

 diffcore-rename.c | 225 ++++++++++++++++++++--------------------------
 1 file changed, 96 insertions(+), 129 deletions(-)


base-commit: 3a0b884caba2752da0af626fb2de7d597c844e8b
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-929%2Fnewren%2Fdiffcore-rename-improvements-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-929/newren/diffcore-rename-improvements-v1
Pull-Request: https://github.com/git/git/pull/929
-- 
gitgitgadget
