Return-Path: <SRS0=PYw/=CU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE2ADC43461
	for <git@archiver.kernel.org>; Fri, 11 Sep 2020 08:00:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 88DCD221E3
	for <git@archiver.kernel.org>; Fri, 11 Sep 2020 08:00:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fdvNqIfF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725768AbgIKIAW (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Sep 2020 04:00:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725550AbgIKIAV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Sep 2020 04:00:21 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C67BAC061573
        for <git@vger.kernel.org>; Fri, 11 Sep 2020 01:00:20 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id l9so3850032wme.3
        for <git@vger.kernel.org>; Fri, 11 Sep 2020 01:00:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:mime-version:content-transfer-encoding
         :fcc:to;
        bh=9Djnx1zUv7HFSEuyEfR0zRvanZG6kR3LMBZeZNKNqaw=;
        b=fdvNqIfFbpLNmI7qEbb8k8sHk5aDToHxzoGN0QGFqiVt35PZD36ZfhzbRCjAUMrps/
         pWVmay+/D0dVXdp/xE8Tl0/yV+C0okaUt6lcOHnzFGz9V8Z6RzA9URLVjaVJ8rGnVUcQ
         r+w1+Lo21NRSNOs4HN1x5N3z6A60m24HUupN6aAUV2N37140dSnQ0j6M2xP8I7/oPS21
         r/AJH0bub/1IQ183hO+Y+LlUJUeAYbltR0yUkbT5nBwAqyzt5Wyh+L9Q3xFDYnbqDG5h
         7SuazuSvoDWPl7gq2AtPsAv31uc8IquEVITpY2o2up5FDapWKyqPR9Vvm89ozLTxCHoV
         DIeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to;
        bh=9Djnx1zUv7HFSEuyEfR0zRvanZG6kR3LMBZeZNKNqaw=;
        b=JFRzFD/wpr1wphJ/NbS/cBrtVv8YCciItwH/ABGy2/Utu1UyXQ9w8hszSedlsv/FnL
         4wWcgx6s8JX1bI3EtXLXPa1XCV6EmQ0fLJ+2lBakBydD2QI/JGi9mxjtmIW4fj+9nfh+
         70QuDpiO7bZALqRlxxFzIj1Z/acRa3cmgq4d80LuO0yDyVSKFXgzW+gMfzUcMaWW43qm
         aTAhofKldiJ89F+AOgDqvkrNG0jRb3nrRl52BNJnhifAeAHuomj2eTiUwWEQQKnzrL1n
         oT4vMlZdYXXSJoSrMVrBZsAR11WnDx18nr+RET7CRAoiGAgTLJLBeOZvDgaoDDkTgiyd
         mcoA==
X-Gm-Message-State: AOAM532PFyTEMkooUX9Etej7lLnHcV2gcQcUtn81Cye1ZExTn49CS7A8
        AeesyEr2+gaLRwGAWEX5T/UFDYklWZk=
X-Google-Smtp-Source: ABdhPJzy1SPXEI0CuXr0eCa9U4llMse8n21z963PgdMIfLYJX/IkFsStFHy4icpLQ5h9bKvcd5L8uw==
X-Received: by 2002:a7b:c111:: with SMTP id w17mr867112wmi.109.1599811219267;
        Fri, 11 Sep 2020 01:00:19 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 11sm2754330wmi.14.2020.09.11.01.00.18
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2020 01:00:18 -0700 (PDT)
Message-Id: <pull.834.git.git.1599811217.gitgitgadget@gmail.com>
From:   "Lukas Pupka-Lipinski via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 11 Sep 2020 08:00:15 +0000
Subject: [PATCH 0/2] GitSVN: Multi line support of ignore-path, include-paths and skiping of
 empty commits
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

[PATCH]v3 GitSVN: Multi line support of ignore-path, include-paths and
skiping of empty commits

I used the ignore-paths option to ignore a lot of stuff I don’t need. The
ignore pattern works well, but it could and up in empty commits. So just the
message without any modifications / changes. The patch below skip a commit
if all changes are ignored by the ignore-paths option. In order to use this
feature I includes the option to read configuration for ignore-path,
include-paths in several lines. So that the user is not limited by the max.
char. per line definition. In Addition this patch includes the optimizations
which are mansion from your side.

Regarding the subrouties comments i oriented by this example: 
https://www.perlmonks.org/?node_id=29905 

Changes in v3:

 * Changed the code format (spaces etc.)
 * Wrap reg-expression by (?:<expression1>|<expression2>)
 * Removed useless variable init
 * Removed useless check.

Lukas (2):
  svn: added: Multi line support for ignore-paths
  sv: added: Skip commit if all files are ignored

 perl/Git/SVN.pm         | 21 +++++++++++++++++++++
 perl/Git/SVN/Fetcher.pm | 42 ++++++++++++++++++++++++++++++++++++-----
 perl/Git/SVN/Ra.pm      |  2 ++
 3 files changed, 60 insertions(+), 5 deletions(-)


base-commit: 274b9cc25322d9ee79aa8e6d4e86f0ffe5ced925
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-834%2Flukaspupkalipinski%2Fmaster-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-834/lukaspupkalipinski/master-v1
Pull-Request: https://github.com/git/git/pull/834
-- 
gitgitgadget
