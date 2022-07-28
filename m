Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 628F9C04A68
	for <git@archiver.kernel.org>; Thu, 28 Jul 2022 16:47:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231570AbiG1QrE (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Jul 2022 12:47:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231382AbiG1Qq5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Jul 2022 12:46:57 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEE836FA3C
        for <git@vger.kernel.org>; Thu, 28 Jul 2022 09:46:52 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id c187-20020a1c35c4000000b003a30d88fe8eso2860476wma.2
        for <git@vger.kernel.org>; Thu, 28 Jul 2022 09:46:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=p24g4qIBywMBedM/b9ukxW96cmIgh1lwEVFg5YFxfek=;
        b=imHKWNWealS4AZ11oKo95DskQMVbLFZLg+4PLJ24JrihLEsDEdDEdO4nV1ST9d2pXr
         AwsPnboXmXsfT350k2u/Vc2xj48tZO9rfRxjDwrZt5rZUtgSPQLLHsAoDgJzhsq+SNRe
         aJGMtvTIfdumbzieDzCoSvJa/C5ivjBX5Yvy5CE9tAZ3LCWolsxhEOtnkkL7rARxDxUW
         W8rA38JSdyWnGOcFIE38fNaEClwJC1iks4hga3lr68csR7zQqWU134JWqahStY7iWmla
         zQSyCt1gPrPkJjIW/x5nI4skTtGTeYHRGNVSxOjkQ1+BygDOTqzsF1rodsg46DRhfyt0
         9wKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=p24g4qIBywMBedM/b9ukxW96cmIgh1lwEVFg5YFxfek=;
        b=vJabe7iyjXjsXi6uf69Ah1Kj1CaI+ebujgBR/WY4UcfCsF0UHhsqI/gaXQu9SpXHtG
         c32snaAteRw/tfVjf1LUTWuRNz4Md4FG3F2Y++mJYUILNwbWtVefxxZ6Po2i1AEjNtb7
         3I9HnimiwKL9fKZ/sXtrSd8Pskthqh/gSwh8oZAFLCOTcWF3BoBBPqEpfKxiEdaXQV9u
         d7SYN9psLD8ApSJJ+f3eZ0Aus/ahKFPqp7QtmLsGRHdB4FoaQEIKgLPGCck3GkUFZ5KJ
         P0NPK3DyCo3ZTkTXNwpy4967jHZPcWTJadhecrFt/089IdCv5Vm6jSHmwUXnJSpueq7q
         mn+g==
X-Gm-Message-State: AJIora8KNO12vWf++9tPNt7b1JTkzLC3Roq07B5Tq+Nn2KZDTHrq1s68
        0a2O2F5p8nhJNhZ4u52e9hOODUF4PEUHPQ==
X-Google-Smtp-Source: AGRyM1sFDVhQ529Z31knKxTu4ee6ol4hPObbmKDWc9nwBy+cU52Wa4jEkkxYNartfISK+3L6uoYHHg==
X-Received: by 2002:a05:600c:12d5:b0:3a3:5183:fedc with SMTP id v21-20020a05600c12d500b003a35183fedcmr189157wmd.47.1659026810636;
        Thu, 28 Jul 2022 09:46:50 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id j3-20020a5d6043000000b0021efc75914esm1495403wrt.79.2022.07.28.09.46.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jul 2022 09:46:50 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>,
        Teng Long <dyroneteng@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v6 0/9] docs: create & use "(user|developer) interfaces" categories
Date:   Thu, 28 Jul 2022 18:46:39 +0200
Message-Id: <cover-v6-0.9-00000000000-20220728T164243Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.1.1197.g7ed548b7807
In-Reply-To: <cover-v5-0.9-00000000000-20220721T160721Z-avarab@gmail.com>
References: <cover-v5-0.9-00000000000-20220721T160721Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

See the v5 for a general overview:
https://lore.kernel.org/git/cover-v5-0.9-00000000000-20220721T160721Z-avarab@gmail.com/

This trivial v6 fixes a grammar error in a commit message pointed-out
by Eric Sunshine, thanks Eric!

Ævar Arnfjörð Bjarmason (9):
  help.c: BUG() out if "help --guides" can't remove "git" prefixes
  git help doc: use "<doc>" instead of "<guide>"
  git docs: add a category for user-facing file, repo and command UX
  git docs: add a category for file formats, protocols and interfaces
  docs: move commit-graph format docs to man section 5
  docs: move protocol-related docs to man section 5
  docs: move pack format docs to man section 5
  docs: move http-protocol docs to man section 5
  docs: move multi-pack-index docs to man section 5

 Documentation/Makefile                        | 26 +++++-----
 Documentation/config/lsrefs.txt               |  2 +-
 Documentation/config/pack.txt                 |  2 +-
 Documentation/config/protocol.txt             |  2 +-
 Documentation/git-bundle.txt                  | 13 +++--
 Documentation/git-commit-graph.txt            |  5 ++
 Documentation/git-help.txt                    | 27 ++++++++--
 Documentation/git-multi-pack-index.txt        |  6 +--
 Documentation/git-upload-pack.txt             |  7 ++-
 Documentation/git.txt                         | 17 +++++++
 ...bundle-format.txt => gitformat-bundle.txt} | 44 ++++++++++++++---
 .../chunk-format.txt => gitformat-chunk.txt}  | 29 ++++++++---
 ...-format.txt => gitformat-commit-graph.txt} | 49 +++++++++++++------
 .../index-format.txt => gitformat-index.txt}  | 22 ++++++++-
 ...dex.txt => gitformat-multi-pack-index.txt} | 20 +++++++-
 ...uft-packs.txt => gitformat-pack-cruft.txt} | 22 ++++++++-
 .../pack-format.txt => gitformat-pack.txt}    | 39 +++++++++++++--
 ...ure-format.txt => gitformat-signature.txt} | 21 ++++++--
 ...ities.txt => gitprotocol-capabilities.txt} | 28 ++++++++---
 ...ocol-common.txt => gitprotocol-common.txt} | 23 ++++++++-
 ...http-protocol.txt => gitprotocol-http.txt} | 35 ++++++++++---
 ...pack-protocol.txt => gitprotocol-pack.txt} | 28 ++++++++---
 .../protocol-v2.txt => gitprotocol-v2.txt}    | 27 +++++++---
 .../howto/recover-corrupted-object-harder.txt |  2 +-
 Documentation/lint-man-section-order.perl     |  3 ++
 Documentation/technical/api-simple-ipc.txt    |  2 +-
 .../technical/hash-function-transition.txt    |  2 +-
 .../long-running-process-protocol.txt         |  2 +-
 Documentation/technical/packfile-uri.txt      |  2 +-
 Documentation/technical/partial-clone.txt     |  2 +-
 Documentation/user-manual.txt                 |  2 +-
 Makefile                                      |  1 +
 builtin/help.c                                | 20 +++++++-
 cache.h                                       |  3 +-
 command-list.txt                              | 38 +++++++++++---
 help.c                                        | 34 ++++++++++++-
 help.h                                        |  2 +
 pack-revindex.h                               |  2 +-
 refspec.h                                     |  2 +-
 t/t0012-help.sh                               | 14 +++++-
 t/t5551-http-fetch-smart.sh                   |  4 +-
 41 files changed, 508 insertions(+), 123 deletions(-)
 rename Documentation/{technical/bundle-format.txt => gitformat-bundle.txt} (79%)
 rename Documentation/{technical/chunk-format.txt => gitformat-chunk.txt} (89%)
 rename Documentation/{technical/commit-graph-format.txt => gitformat-commit-graph.txt} (87%)
 rename Documentation/{technical/index-format.txt => gitformat-index.txt} (98%)
 rename Documentation/{technical/multi-pack-index.txt => gitformat-multi-pack-index.txt} (94%)
 rename Documentation/{technical/cruft-packs.txt => gitformat-pack-cruft.txt} (96%)
 rename Documentation/{technical/pack-format.txt => gitformat-pack.txt} (95%)
 rename Documentation/{technical/signature-format.txt => gitformat-signature.txt} (96%)
 rename Documentation/{technical/protocol-capabilities.txt => gitprotocol-capabilities.txt} (96%)
 rename Documentation/{technical/protocol-common.txt => gitprotocol-common.txt} (89%)
 rename Documentation/{technical/http-protocol.txt => gitprotocol-http.txt} (97%)
 rename Documentation/{technical/pack-protocol.txt => gitprotocol-pack.txt} (98%)
 rename Documentation/{technical/protocol-v2.txt => gitprotocol-v2.txt} (97%)

Range-diff against v5:
 1:  b0bb29bb131 =  1:  f3588319057 help.c: BUG() out if "help --guides" can't remove "git" prefixes
 2:  2ec00f81552 =  2:  80322d44ea5 git help doc: use "<doc>" instead of "<guide>"
 3:  31be7d01c50 =  3:  0d22eb645bd git docs: add a category for user-facing file, repo and command UX
 4:  a7310898866 !  4:  c25f8ec9bf5 git docs: add a category for file formats, protocols and interfaces
    @@ Commit message
         Create a new "File formats, protocols and other developer interfaces"
         section in the main "git help git" manual page and start moving the
         documentation that now lives in "Documentation/technical/*.git" over
    -    to it. This compliments the newly added and adjacent "Repository,
    +    to it. This complements the newly added and adjacent "Repository,
         command and file interfaces" section.
     
         This makes the technical documentation more accessible and
 5:  62f9020a72d =  5:  466dbd2a993 docs: move commit-graph format docs to man section 5
 6:  019ec8cf73c =  6:  9a551b2d53a docs: move protocol-related docs to man section 5
 7:  5b081e6637a =  7:  92be18b95d9 docs: move pack format docs to man section 5
 8:  8f8214addfd =  8:  a8a883ebf85 docs: move http-protocol docs to man section 5
 9:  19601ac36a2 =  9:  ecfda8c6770 docs: move multi-pack-index docs to man section 5
-- 
2.37.1.1197.g7ed548b7807

