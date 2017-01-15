Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3D0BF2079E
	for <e@80x24.org>; Sun, 15 Jan 2017 18:47:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751270AbdAOSrZ (ORCPT <rfc822;e@80x24.org>);
        Sun, 15 Jan 2017 13:47:25 -0500
Received: from mail-qk0-f195.google.com ([209.85.220.195]:33652 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751200AbdAOSrY (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 15 Jan 2017 13:47:24 -0500
Received: by mail-qk0-f195.google.com with SMTP id 11so13855611qkl.0
        for <git@vger.kernel.org>; Sun, 15 Jan 2017 10:47:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nyu-edu.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=VIrZfHzf09PMLaIxlyGHQP4N6pTKLt49AesQIvB0R5U=;
        b=qDc8WRW6DIbdBjpZh3k7bfSL1Yjfy65iiyRgtnvw5a+mSySeE/OlK7iHH2QoWbZAlk
         ldKwYGSkG4Yauk4ERkVlCHU87cEfLzNx3YkSNJUqAjNLjY6DaevvK/qZYFFU/odR29OL
         kHBs1fMZrK347roKOyyvsS8oXDnQjSCwu1xMuuhEEHwW/n75Dr/UgfxTzbLEr+tTmXkF
         KQC2wkNWGe5HuWpxn2XMx/J6QiXkOjp2ixjRDAUuNn4KqX/MzfYwDpSLsQ/IdfPv1unf
         RMSd6ytZR2bZdTJ52i1dKUlkIZxHr9o6zB8AEoR3Zc0Kfp1M0C/9ymx8FZd+SSJwlMqz
         5Rcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=VIrZfHzf09PMLaIxlyGHQP4N6pTKLt49AesQIvB0R5U=;
        b=MCvDmHX7g3Rz46b8VRsYlloFdUP1NWtHUIraspHii3NCdpxhcjAK8h59OxQV79K6fI
         3rD0RdqsjUoJMgiRLiOQem4T0V0/2VqUooKWufdyy9W7Uua+cvRF/g9tZq/Y6HsuAU2i
         kqQoUosFGcMyYbobV3VQv59jXGxYDus7bo8jFzP9U2iw7WqnXEomZQMK6sgHBTM22QGy
         gxCmStcvCSmE41EbR3uX3Hzhzub0uomrAckm8W98Hjo1qXP7XTak+5hwC3G7TOh8lrJP
         DJ27GhHFV1TJKzmrfbcDk8reM6MZDR2KDmjhZtvKxo7hZtAU6LpCf3X7IGptZxLGzBKm
         etoA==
X-Gm-Message-State: AIkVDXLgHjHTJU+P9DV1qIKyQGO5PfvOSAm0qAPC5M9IaqHd9Zjvj4BfI+Gcyku/xcGMJXrj
X-Received: by 10.55.43.99 with SMTP id r96mr30494844qkh.143.1484506043602;
        Sun, 15 Jan 2017 10:47:23 -0800 (PST)
Received: from localhost.localdomain ([2604:2000:8183:da00::3])
        by smtp.gmail.com with ESMTPSA id x40sm14362243qtx.12.2017.01.15.10.47.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 15 Jan 2017 10:47:23 -0800 (PST)
From:   santiago@nyu.edu
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, sunshine@sunshineco.com,
        walters@verbum.org, Santiago Torres <santiago@nyu.edu>
Subject: [PATCH v5 0/7] Add --format to tag verification
Date:   Sun, 15 Jan 2017 13:46:58 -0500
Message-Id: <20170115184705.10376-1-santiago@nyu.edu>
X-Mailer: git-send-email 2.11.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Santiago Torres <santiago@nyu.edu>

This is the fifth iteration of [1][2][3][4], and as a result of the
discussion in [5]. The main goal of this patch series is to bring
--format to git tag verification so that upper-layer tools can inspect
the content of a tag and make decisions based on it.

In this re-woll we:

* Squashed Peff's first patch[6] with the second patch of the series. The commit
  message may need work.

* Applied the relevant segment's of Peff's second patch[7] on the rest of the
  series

* Rebased so these patches apply to the tip of the master branch.

Thanks,
-Santiago

[1] http://public-inbox.org/git/20161007210721.20437-1-santiago@nyu.edu/
[2] http://public-inbox.org/git/20160930221806.3398-1-santiago@nyu.edu/
[3] http://public-inbox.org/git/20160922185317.349-1-santiago@nyu.edu/
[4] http://public-inbox.org/git/20160926224233.32702-1-santiago@nyu.edu/
[5] http://public-inbox.org/git/20160607195608.16643-1-santiago@nyu.edu/
[6] http://public-inbox.org/git/20161019203546.dfqmi2czcxopgj6w@sigill.intra.peff.net/
[7] http://public-inbox.org/git/20161019203943.epjxnfci7vcqg4xv@sigill.intra.peff.net/

Lukas Puehringer (4):
  gpg-interface, tag: add GPG_VERIFY_QUIET flag
  ref-filter: add function to print single ref_array_item
  tag: add format specifier to gpg_verify_tag
  builtin/tag: add --format argument for tag -v

Santiago Torres (3):
  builtin/verify-tag: add --format to verify-tag
  t/t7030-verify-tag: Add --format specifier tests
  t/t7004-tag: Add --format specifier tests

 Documentation/git-tag.txt        |  2 +-
 Documentation/git-verify-tag.txt |  2 +-
 builtin/tag.c                    | 32 ++++++++++++++++++++++----------
 builtin/verify-tag.c             | 13 +++++++++++--
 gpg-interface.h                  |  1 +
 ref-filter.c                     | 27 +++++++++++++++++++++------
 ref-filter.h                     |  7 +++++++
 t/t7004-tag.sh                   | 16 ++++++++++++++++
 t/t7030-verify-tag.sh            | 16 ++++++++++++++++
 tag.c                            | 22 +++++++++++++++-------
 tag.h                            |  4 ++--
 11 files changed, 113 insertions(+), 29 deletions(-)

-- 
2.11.0

