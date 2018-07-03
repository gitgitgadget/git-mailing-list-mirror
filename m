Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5E71A1F660
	for <e@80x24.org>; Tue,  3 Jul 2018 12:38:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753323AbeGCMit (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Jul 2018 08:38:49 -0400
Received: from thoth.sbs.de ([192.35.17.2]:39962 "EHLO thoth.sbs.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753310AbeGCMip (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Jul 2018 08:38:45 -0400
Received: from mail3.siemens.de (mail3.siemens.de [139.25.208.14])
        by thoth.sbs.de (8.15.2/8.15.2) with ESMTPS id w63CcNGd014593
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 3 Jul 2018 14:38:23 +0200
Received: from md1pvb1c.ad001.siemens.net (md1pvb1c.ad001.siemens.net [139.25.68.40])
        by mail3.siemens.de (8.15.2/8.15.2) with ESMTP id w63CcME3008580;
        Tue, 3 Jul 2018 14:38:22 +0200
From:   Henning Schild <henning.schild@siemens.com>
To:     git@vger.kernel.org
Cc:     Ben Toews <mastahyeti@gmail.com>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Henning Schild <henning.schild@siemens.com>
Subject: [PATCH 0/8] X509 (gpgsm) commit signing support
Date:   Tue,  3 Jul 2018 14:38:12 +0200
Message-Id: <cover.1530616446.git.henning.schild@siemens.com>
X-Mailer: git-send-email 2.16.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series adds support for signing commits with gpgsm.

The first two patches are cleanups of gpg-interface, while the next
four prepare for the introduction of the actual feature in patch 7.
Finally patch 8 extends the testsuite to cover the new feature.

This series can be seen as a follow up of a series that appeared under
the name "gpg-interface: Multiple signing tools" in april 2018 [1]. After
that series was not merged i decided to get my patches ready. The
original series aimed at being generic for any sort of signing tool, while
this series just introduced the X509 variant of gpg. (gpgsm)
I collected authors and reviewers of that first series and already put them
on cc.

[1] https://public-inbox.org/git/20180409204129.43537-1-mastahyeti@gmail.com/

Henning Schild (8):
  builtin/receive-pack: use check_signature from gpg-interface
  gpg-interface: make parse_gpg_output static and remove from interface
    header
  gpg-interface: add new config to select how to sign a commit
  gpg-interface: introduce an abstraction for multiple gpg formats
  t/t7510: check the validation of the new config gpg.format
  gpg-interface: do not hardcode the key string len anymore
  gpg-interface: introduce new signature format "X509" using gpgsm
  gpg-interface t: extend the existing GPG tests with GPGSM

 Documentation/config.txt   |  7 ++++
 builtin/receive-pack.c     | 17 +--------
 gpg-interface.c            | 94 ++++++++++++++++++++++++++++++++++++++--------
 gpg-interface.h            |  2 -
 t/lib-gpg.sh               |  9 ++++-
 t/lib-gpg/gpgsm-gen-key.in |  6 +++
 t/t4202-log.sh             | 66 ++++++++++++++++++++++++++++++++
 t/t5534-push-signed.sh     | 52 +++++++++++++++++++++++++
 t/t7003-filter-branch.sh   | 15 ++++++++
 t/t7030-verify-tag.sh      | 47 ++++++++++++++++++++++-
 t/t7510-signed-commit.sh   | 10 +++++
 t/t7600-merge.sh           | 31 +++++++++++++++
 12 files changed, 321 insertions(+), 35 deletions(-)
 create mode 100644 t/lib-gpg/gpgsm-gen-key.in

-- 
2.16.4

