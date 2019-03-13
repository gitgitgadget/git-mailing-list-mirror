Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.8 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 343DD20248
	for <e@80x24.org>; Wed, 13 Mar 2019 23:33:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726787AbfCMXdd (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Mar 2019 19:33:33 -0400
Received: from mail-oi1-f201.google.com ([209.85.167.201]:42633 "EHLO
        mail-oi1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726629AbfCMXdd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Mar 2019 19:33:33 -0400
Received: by mail-oi1-f201.google.com with SMTP id q82so1568365oia.9
        for <git@vger.kernel.org>; Wed, 13 Mar 2019 16:33:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to;
        bh=U5H5sIhEM80LfJVe7mWZ5GJKb5ZxbxCrrXdbXb4NRH8=;
        b=rTb0erJamVZsT4eFBYLT6IMC5kndlrGrgn9t7BplaksJ+yzzzXkxjg7J0ryR8SQgnD
         kSBuHXOrG6CfJV+221zt+Gl5vxjognYUWjU15QwroWb2R5yyPT6XppABocplrp0+p7TX
         aA0S5qjCd8UDjQz1jniS2LFPpT9defa8z8W7L7Aj1Q+gy2RLrd3huISw7qo+EolyswCQ
         2wHKgUQ3wWC2JRRyMZkta0gtcp6CMzybwqMjityXBxavgNA+K3WapSbxXG8gI3SDl3zR
         gJWh85IoK+PLleMeFLIPfHy4yJnoERt9H4406aVsaNZJYWKkQcVLdQdoqFz3GLj6BN84
         JpxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to;
        bh=U5H5sIhEM80LfJVe7mWZ5GJKb5ZxbxCrrXdbXb4NRH8=;
        b=sOkk9eboJy8k9Dhjwx0jbBAkBj1nSbG4Eeur7vMPcT4Um8f6LRXg+glp5VZgQD8yiu
         lsVI3n8vzEaQxKxdlf0vIdStOowj2MGzMxSTFqfvQH2V9+Ld3vDikTpyYThBpXAYyOoW
         Vla0G0KfRxJNKsps+TOO+zt87MZetTq2deM4BvW3CvKtoPPN3m13O8zcIMeaBnsjuqtT
         hOiPL796l4sDIqszuw0oEl0U/UXw5hAGEKPdbd/FxdbnsGWbe5kgxojqdl66wXG/dKyA
         EGo4h/P/gPp1nvdeLKF6Ww9MnDlTMt/rQHSBPmKrWMUEltBf6B26iNI2AjOaI0Jpj0Lj
         FOcQ==
X-Gm-Message-State: APjAAAU5ck8il+nyg9hLN/I9kqoWBPJiq9nvADmZaoZr/moOd4AWYn9n
        jwek4Ov+dMIksbwJpzYh65El62AP/9lwedVJ7PHLg9HPGdpeb/trCRlA9seMy3Eb7jx/vyfFobZ
        cbhaL57EAP49qmp+mf/JCneBOUPe33eWFLbB3afXP6Qg7cMoUHRSqCUcznAQ95m8=
X-Google-Smtp-Source: APXvYqx7MsA1lLCYfSmB6QXDLxYRt8CUagFZ2UFKKig0OePrdd7ujpoXZgTsUJGhIBSIv1X1YX6a+mqku1100Q==
X-Received: by 2002:a9d:6c58:: with SMTP id g24mr25415674otq.10.1552520012796;
 Wed, 13 Mar 2019 16:33:32 -0700 (PDT)
Date:   Wed, 13 Mar 2019 16:33:27 -0700
Message-Id: <cover.1552519463.git.steadmon@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.21.0.360.g471c308f928-goog
Subject: [PATCH 0/2] Randomize / timestamp trace2 targets
From:   Josh Steadmon <steadmon@google.com>
To:     git@vger.kernel.org, git@jeffhostetler.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Persistently enabling trace2 output is difficult because it requires
specifying a full filename. This series teaches tr2_dst_get_trace_fd()
to randomize filenames when a directory or filename prefix are given as
targets in the GIT_TR2_* envvars. It also allows expansion of a
timestamp template string into the current UTC timestamp.

Josh Steadmon (2):
  date: make get_time() public
  trace2: randomize/timestamp trace2 targets

 Documentation/technical/api-trace2.txt | 10 +++
 cache.h                                |  1 +
 date.c                                 |  2 +-
 t/t0210-trace2-normal.sh               | 93 ++++++++++++++++++++++++++
 trace2/tr2_dst.c                       | 86 +++++++++++++++++++++++-
 5 files changed, 189 insertions(+), 3 deletions(-)

-- 
2.21.0.360.g471c308f928-goog

