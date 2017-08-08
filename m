Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 02E5420899
	for <e@80x24.org>; Tue,  8 Aug 2017 19:33:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752175AbdHHTcs (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Aug 2017 15:32:48 -0400
Received: from mail-pg0-f42.google.com ([74.125.83.42]:33333 "EHLO
        mail-pg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752149AbdHHTcq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Aug 2017 15:32:46 -0400
Received: by mail-pg0-f42.google.com with SMTP id u5so18690499pgn.0
        for <git@vger.kernel.org>; Tue, 08 Aug 2017 12:32:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=LIFCVmqBMzGvfMEuNanya+56xsxHx7IodOYMSFnvlcA=;
        b=nmKmzphq8o6B8hyy4bJMrYEvW/77LKk6ZxaS1kqdz0scdNc2AQu+Wuah51nsbbf1HH
         jAQ6fPOlrkhW+ydXxtl535TUEYE4tHnn7XpPXNofAknmV5XchvgbvewOv0YmpB5LjgPO
         xnGVatDvo4cGJ8BA9c5pLRhQ3WFgBECh0o6U7IkDBP7Ihr6A30HJltdHQikSmev9XT4r
         4gZ+cGp63u50UwuPmHg6Y18p+7JnOzuO23aYSNcNdh4h3BaDdy6k6ROSMaWPJyscrGuM
         IDPXRdCY86G988gMV+rJoUojMdODblG+vo5zwVGXU60cD1lQh6CeIs/FXAoZ245EQrEw
         inkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=LIFCVmqBMzGvfMEuNanya+56xsxHx7IodOYMSFnvlcA=;
        b=rYPfb7SGnC9S2DQHjdF4bqr8q139d+/RR8E0d5LNJMvvaQm0Ahi1CiGFnRPepOE5/z
         ZwGInLUNXqlw9L/hzKtHqvEubInqhAqf/AMqCePw6EW4GsNXHgU9/s+MshVFqo2OxVNs
         fmfP5gOlUMV+3CM1w01wK4MAScrxpYhOQVRYKYAATuW97MIBbtx4FZxIN7VHlEcZwzfw
         69VPxeRP+7ftrkB90j9pH/EFyDV4BRps4wScd9nq7kUlXkEIHFw1RKKzKhv2agdsdbw8
         FVa1eNwoSmLMEjyVCi00HX8UPV4bVmyj6cTel/hvfW8IcqipkZhvM8yCIhPRsfHMrC2I
         u4yw==
X-Gm-Message-State: AHYfb5jPBJUOvMpk8CNcDjFry9CzIFdaq3XgoJ27Iki/BWV0D05cdUyt
        QOS2knN/46yuo8cUjsErSw==
X-Received: by 10.98.21.71 with SMTP id 68mr5651386pfv.199.1502220765704;
        Tue, 08 Aug 2017 12:32:45 -0700 (PDT)
Received: from twelve2.svl.corp.google.com ([100.96.218.24])
        by smtp.gmail.com with ESMTPSA id k186sm4332547pfc.173.2017.08.08.12.32.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 08 Aug 2017 12:32:43 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Subject: [RFC PATCH 00/10] An attempt to move packfile funcs to its own file
Date:   Tue,  8 Aug 2017 12:32:30 -0700
Message-Id: <cover.1502220307.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.14.0.434.g98096fd7a8-goog
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

While investigating annotating packfiles and loose objects to support
connectivity checks in partial clones [1], I decided to make the effort
to separate packfile-related code from sha1_file.c into its own file, to
make it easier to both code such changes and review them. Here is the
beginning of those efforts.

Is this something worth doing, and if yes, is this in the right
direction?

[1] https://public-inbox.org/git/20170804145113.5ceafafa@twelve2.svl.corp.google.com/

Jonathan Tan (10):
  pack: move pack name-related functions
  pack: move static state variables
  pack: move pack_report()
  pack: move open_pack_index(), parse_pack_index()
  pack: move release_pack_memory()
  pack: move pack-closing functions
  pack: move use_pack()
  pack: move unuse_pack()
  pack: move add_packed_git()
  pack: move install_packed_git()

 Makefile                 |   1 +
 builtin/am.c             |   1 +
 builtin/clone.c          |   1 +
 builtin/count-objects.c  |   1 +
 builtin/fetch.c          |   1 +
 builtin/merge.c          |   1 +
 builtin/pack-redundant.c |   1 +
 cache.h                  |  45 ----
 connected.c              |   1 +
 git-compat-util.h        |   2 -
 pack.c                   | 669 +++++++++++++++++++++++++++++++++++++++++++++++
 pack.h                   |  51 ++++
 sha1_file.c              | 667 ----------------------------------------------
 sha1_name.c              |   1 +
 streaming.c              |   1 +
 15 files changed, 730 insertions(+), 714 deletions(-)
 create mode 100644 pack.c

-- 
2.14.0.434.g98096fd7a8-goog

