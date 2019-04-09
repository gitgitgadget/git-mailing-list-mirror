Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BA30420248
	for <e@80x24.org>; Tue,  9 Apr 2019 08:16:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726463AbfDIIQW (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Apr 2019 04:16:22 -0400
Received: from mail-ot1-f49.google.com ([209.85.210.49]:46767 "EHLO
        mail-ot1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726062AbfDIIQW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Apr 2019 04:16:22 -0400
Received: by mail-ot1-f49.google.com with SMTP id s24so9574846otk.13
        for <git@vger.kernel.org>; Tue, 09 Apr 2019 01:16:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=qdaU+no/mqOWg86eW6pWsTfjtHeOcRq0yJ5j7CYyBsU=;
        b=Tzle9dMzxxmclXfVuj8IpKOIZmXm9+WOB6qFBRI9amMQY7Iqr73/hoSCYD9LjXVbyP
         AJRpCsRCVCQWypNe2f/9wMP4hG1wVuu1hMdVscWMME21M66k/xUNXPfXhX1oyb26gsfS
         w62+YXGmfCYIaM7pvBlPgFUwrbK9GU+5Og/j0xCP+sPFQAHg31DEaFrJXwA/jTwD1WZo
         9/X7Dhkvkf4dT5QEOErVZZB4K8kKlyy4ulQvUGDsqwTjH+q6WXe2Wq8k8hqfEdFlgTfo
         ASm8wki1FUyLfxBxxJIFyjobCBY1YFc+EqRcNyHx4jaQmbfwWA1gUFFw+LpQVXXidssv
         Q3kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=qdaU+no/mqOWg86eW6pWsTfjtHeOcRq0yJ5j7CYyBsU=;
        b=k+xMHY+kxkjVqW61Ys7N4bjTY/k6D9lWEiJjyK2psXxrx9h/XlzK5x4jwChdM+EeL6
         MpXtRVUubKRLZqRwOxun+SYnVu4O/85f+InkOVosVQHIHFhWpuRYhKyt/gYNluJXW5zS
         XrPifNS6wEGo8kbUxJNTzyG+uxcGR6UYa5jSOtO10rzVvLbuLWXBFGROJqqV/6B0YtKu
         8ARSRkiaFo9QXY3rj4/xeVu9PG04HyPbHvOZ+PzVwhlvK7OMKmEG7vKBx8o4rDtXDQqz
         C3LArNUz3SJFfZEC/eqeE4Qy8J87cVuWiBqye4IgpfzwCq+UaEJL3UsiVGAeYvdM+889
         NJAw==
X-Gm-Message-State: APjAAAX7f+eQ9ntrQCdyM2rNGNFitFL/Y+afWqCGT3LuHVaPqTjSbmwH
        VeNF09o8ozXhxN0JPjV/om+9zOJDe6FgVM15DB0=
X-Google-Smtp-Source: APXvYqysXxNT/qaNJr/4SWZclGy/8kVdoepelj9STbD7w0RKGDgOIplA1idlpL7ZfduiHEyTOkEUlhqnVpTRHnj8E88=
X-Received: by 2002:a9d:745a:: with SMTP id p26mr22977459otk.136.1554797781735;
 Tue, 09 Apr 2019 01:16:21 -0700 (PDT)
MIME-Version: 1.0
From:   Kapil Jain <jkapil.cs@gmail.com>
Date:   Tue, 9 Apr 2019 13:46:10 +0530
Message-ID: <CAMknYEMQ6K7j2M1CSv9uCF8aDQK6+PmTJi-XgFNy+McE9f7OsQ@mail.gmail.com>
Subject: [GSoC] [RFC] stashing unmerged index entries
To:     Thomas Gummerer <t.gummerer@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Duy Nguyen <pclouds@gmail.com>, me@ttaylorr.com,
        git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Reference: https://git.github.io/SoC-2019-Ideas/#teach-git-stash-to-handle-unmerged-index-entries

"When the index is unmerged, git stash refuses to do anything. That is
unnecessary, though, as it could easily craft e.g. an octopus merge of
the various stages. A subsequent git stash apply can detect that
octopus and re-generate the unmerged index."

according to it we take the unmerged entries (caused by conflicted
merge) in index from all stages, and do an octopus merge. how does
this solve the problem, i mean where do those entries go after octopus
merge ? a conflicted merge is still there, do we store the merge
separately ?
