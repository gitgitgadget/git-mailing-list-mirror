Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.8 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 680851F405
	for <e@80x24.org>; Wed, 19 Dec 2018 23:21:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729632AbeLSXVW (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Dec 2018 18:21:22 -0500
Received: from mail-qt1-f201.google.com ([209.85.160.201]:47320 "EHLO
        mail-qt1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728249AbeLSXVW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Dec 2018 18:21:22 -0500
Received: by mail-qt1-f201.google.com with SMTP id f2so25786720qtg.14
        for <git@vger.kernel.org>; Wed, 19 Dec 2018 15:21:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to;
        bh=jGw1RKELTde4tOKLVuOtN7TCBMpOiVT+0VVbsoiKGgQ=;
        b=l3GZ8zZTnJrBjlwl3SreV92aIg/85NftpkTv4friYMuWo2h1aQced8bTVqfqYX4hVP
         t2MogHJB3TIlLqRzTNiwJmEg0CnYIz/9dKn268n+7D3N2MZa3/Wy42bDCaE062IHhfVb
         473lNDHF9yVfR+eEqTKQT7dTy4sEU8HY1+punKg2qlv9SL5MLx3vt1x/JqxhW0DuVYPq
         Kt4nJCe8SSKcLPTDyuyLm5GRtfwg7pppxy7YAxedbGX3hwFnd4nbc8kd1ixmK4vYUXiN
         f4cDzXBMejFLeaFpQVd6wysl94Jr9fNwbUYgUo2lGuojFaMxZaUCq8Ur3dFhCSZFLNEs
         y3yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to;
        bh=jGw1RKELTde4tOKLVuOtN7TCBMpOiVT+0VVbsoiKGgQ=;
        b=WkK48r9qT8grdhyRO7VQeITXU5n931v5QcPRGFRAF8Rsmgf4IzjY7L+EGn5rrGSoQD
         iiM9WAebz13SE7ZbW/O7PyQ1q6YL2brAZF8lhnomcRk1bM605K0I5l4dOGWL66vGnqNg
         XSFdmSJYzQSG8Yy0Ksar73Em2afMlZlMAFrNrlHF3hJT8Cy5TQqBAMqxV72F7ab3riN3
         R/lyqszyAxqhvPEegEa28NHU7Xpq0Npt4Ap16gxK4ldqIMYZPr8V8IrLTXL4M6lXQIvL
         ihkfsFmfus9zTBcodRhzKpenl489ph+9g5gEpH2i8YvGHOtYr1iLKjz2EcJmtDzGE1no
         t5WA==
X-Gm-Message-State: AA+aEWbaREmsKQ1cnHNj0B3YP8uyAv9eo7KNu6aqVoO3Cwry4XSu5t+R
        wyDErR9bi9DTBLg/DGC/NMce56jVITpTqfrIt6Ui0LKzXllVoQFBzE+Ppu9xwuRKZ6FVnEEnOI8
        KkcHcqhaOmxzlrsGoV/U6zi4y2Lz/oy8Q/XKOf5Ra7QF1rtmR9sUFhoVRfhoUK0Y=
X-Google-Smtp-Source: AFSGD/Uqja3BmhN/bfrk/tLAMifDJ83/k4Sd1tckVj8j4YjPReh1HYUEnGQbec5sduOSPNz+WjQSP4Su+9t/JA==
X-Received: by 2002:a0c:9e60:: with SMTP id z32mr21942856qve.0.1545261681203;
 Wed, 19 Dec 2018 15:21:21 -0800 (PST)
Date:   Wed, 19 Dec 2018 15:21:17 -0800
Message-Id: <cover.1545261186.git.steadmon@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.20.0.405.gbc1bbc6f85-goog
Subject: [RFC PATCH 0/1] Expand abbreviated filters
From:   Josh Steadmon <steadmon@google.com>
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

NOTE: this patch is based on top of md/list-objects-filter-by-depth

Currently, git clients pass filter specs verbatim over the network and
to subprocesses. We support various numeric abbreviations for parameters
on these limits (via git_parse_ulong()), but other implementations may
not support the same abbreviations (or may support them differently;
e.g., should "1k" == 1000 or 1024?). It would be better to only pass
fully-expanded numbers in this case, and keep the expansion logic
completely on the client side.

This patch updates the protocol-v2 doc to specify that clients MUST
expand abbreviations in filter specifications before passing them to
other processes. It adds a new function
"expand_list_objects_filter_spec()" in list-objects-filter-options.c
that implements the expansion logic, and updates users of the
filter_spec field to instead expand the spec first.

Josh Steadmon (1):
  filter-options: Expand abbreviated numbers

 Documentation/technical/protocol-v2.txt |  5 ++++-
 builtin/clone.c                         |  6 +++++-
 builtin/fetch.c                         |  7 ++++++-
 fetch-pack.c                            | 15 ++++++++++++---
 list-objects-filter-options.c           | 20 ++++++++++++++++++--
 list-objects-filter-options.h           | 17 +++++++++++++++--
 t/t6112-rev-list-filters-objects.sh     | 17 +++++++++++++++++
 transport-helper.c                      | 13 +++++++++----
 upload-pack.c                           |  7 +++++--
 9 files changed, 91 insertions(+), 16 deletions(-)

-- 
2.20.0.405.gbc1bbc6f85-goog

