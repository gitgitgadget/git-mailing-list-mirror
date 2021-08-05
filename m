Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5206C4338F
	for <git@archiver.kernel.org>; Thu,  5 Aug 2021 15:07:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C141160EE5
	for <git@archiver.kernel.org>; Thu,  5 Aug 2021 15:07:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241789AbhHEPHx (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 Aug 2021 11:07:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231450AbhHEPHv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Aug 2021 11:07:51 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90938C061765
        for <git@vger.kernel.org>; Thu,  5 Aug 2021 08:07:37 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id j2so6977963wrx.9
        for <git@vger.kernel.org>; Thu, 05 Aug 2021 08:07:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XaNPxVoNvxAwsq4fL34b4D8lbx+LOhARP2kW8jAYMQ0=;
        b=s25tVMZX6I/5xwYXltn9RCOn9GQbHx5FTqJGtxtaRYd+yY3RRn/ZtTrXjDdnrF+hyd
         hw6ZjFdumRW7wE6jqp53RKRNcQb2wCif+VphZbJV8Jg8dUqpSB/zdVyD9JGmsc6rS+jF
         rjVs+/jXqVkdlRCBrFyG0DaR1OEmGVAYhOm3t+8GPszCVKCTmVlPH3b6uZ7GEgwPsxx4
         4KXwPYM1AwwYxe1z767a43j4bhTup2WAXOW0OltLOhWYjx71Lz38X5IdxkHTnHrYPygG
         IDvPyKA9ZGXsEhpkLlhksVF3L1wlWR5hAz26L2oyLKEKBPWDnV/03tF/S7CnN2TyR/RX
         6OTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XaNPxVoNvxAwsq4fL34b4D8lbx+LOhARP2kW8jAYMQ0=;
        b=F2S+kArAoryM9YLcKlNALTSrnguOhLGapdKOBQgdgEmpCtoTXLAm5kpHIWYDaW/KIX
         67Tz+yg4HjqtBV16Zg6XSQnzsppbLeZB0AKe3GV2Im5d/APujvKC2oauDyIC05ZdeCia
         0Ml/JCGZTy6Ptd6vArNGWGyhIdHjXZ/0avcrRgx1TADu0XszbywKZFPpbM+0ZDCUxwXS
         N0zntZl0Rw+xeNS8b7PIxuv3pXPxa3ETVdl6GCBqNvTjl8sqXj4Yq4fdarQrRQ3D0A+U
         3nRL8OqXh9E63lfDmMKXGCsWHnYwr7WSRfLSjwmucWTk0Pi0lAWQhmqRgHdD+yOzTWlh
         9YSQ==
X-Gm-Message-State: AOAM530IV20O1YJaIjADM4s3GXzW35Y5DjDhG2u27HLOyM1J8zks/lpH
        g/6CXXbBcRQJLc5Q8LbXV8l8FTfHyfGfaA==
X-Google-Smtp-Source: ABdhPJze2Qwu49A7q1WL3v5COaBa0/+PD/bPSqWKM/GlQfOFnUdIVAIhhi0jZtSGAlZybhFopoZufg==
X-Received: by 2002:adf:fe85:: with SMTP id l5mr5754614wrr.213.1628176055759;
        Thu, 05 Aug 2021 08:07:35 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id w4sm6856340wrm.24.2021.08.05.08.07.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Aug 2021 08:07:35 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Patrick Steinhardt <ps@pks.im>,
        Christian Couder <christian.couder@gmail.com>,
        Albert Cui <albertqcui@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [RFC PATCH 00/13] Add bundle-uri: resumably clones, static "dumb" CDN etc.
Date:   Thu,  5 Aug 2021 17:07:16 +0200
Message-Id: <RFC-cover-00.13-0000000000-20210805T150534Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.rc0.646.g585563e77f
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We're in the 2.33.0 rc cycle, and I'd hoped to have some more prep
work for this integrated already, but for now here's something
interesting I've been working on for early commentary/feedback.

This adds the the ability to protocol v2 for servers to optimistically
pre-seed supporting clients with one or more bundles via a new
"bundle-uri" protocol extension.

Right now only "clone" supports this, but it's a rather easy change on
top to add incremental "fetch" support as well.

The elevator pitch for this feature is (I guess it's a long elevator
ride..);

 * Allows for offloading most/all of a PACK "fetch" to "dumb" CDN's
   that *don't* have very close coordination with the server running
   "git-upload-pack" (unlike packfile-uri, more on that below).

   I.e. distributing an up-to-date-enough bundle via something like
   Debian's FTP mirror system, or a best-effort occasionally updated
   CDN.

   Should the bundle(s) be outdated, corrupt or whatever the client
   gracefully recovers by either ignoring the bad data, or catching up
   via negotiation with whatever data it did get.

   Server operators should be confident in using bundle URIs, even if
   the CDN they're pointing to is flaky, out of date, or even
   sometimes outright broken or unreachable. The client will recover
   in all those cases.

 * Makes performant git infrastructure more accessible, i.e. this
   feature helps the last with an up-to-date repack with up-to-date
   bitmaps when talking to a network-local git server, but a lot of
   users have more option for scaling or distributing things via dumb
   CDNs than a server that can run "git-upload-pack".

 * You can even bootstrap a clone of a remote server that doesn't
   support bundle-uri with a local or remote bundle with the
   "transfer.injectBundleURI" config.

 * Trivial path to resumable clones. Note that that's "resumable" in
   the sense that curl(1) will resume a partially downloaded bundle,
   we don't resume whatever state index-pack was in when the
   connection was broken.

   I have a POC of this working locally, it's just a matter of
   invoking curl(1) with "--continue-at -".

   The hindrance for resumably clones is now just the UI for git-clone
   (i.e. stashing the partial data somewhere), not protocol
   limitations.

This goes on top of the outstanding series I have for serve.c API
cleanup & fixes at
https://lore.kernel.org/git/cover-v4-00.10-00000000000-20210805T011823Z-avarab@gmail.com

I also needed to grab one patch from my "bundle unbundle progress"
series:
https://lore.kernel.org/git/cover-0.4-0000000000-20210727T004015Z-avarab@gmail.com/

Something like this approach had been suggested before in late 2011 by
Jeff King, see:
https://lore.kernel.org/git/20111110074330.GA27925@sigill.intra.peff.net/;
There's significant differences in the approach, mainly due to
protocol v2 not existing at the time. I wrote most of this before
finding/seeing Jeff's earlier patches.

For a demo of how this works head over to 12/13:
https://lore.kernel.org/git/RFC-patch-12.13-8dc5613e87-20210805T150534Z-avarab@gmail.com

In 13/13 there's a design doc discussing the approach, and major
differences with the existing packfile-uri mechanism:
https://lore.kernel.org/git/RFC-patch-13.13-1e657ed27a-20210805T150534Z-avarab@gmail.com

This can also be grabbed from the "avar/bundle-uri-client-clone"
branch of https://github.com/avar/git/

Ævar Arnfjörð Bjarmason (13):
  serve: add command to advertise bundle URIs
  bundle-uri client: add "bundle-uri" parsing + tests
  connect.c: refactor sending of agent & object-format
  bundle-uri client: add minimal NOOP client
  bundle-uri client: add "git ls-remote-bundle-uri"
  bundle-uri client: add transfer.injectBundleURI support
  bundle-uri client: add boolean transfer.bundleURI setting
  bundle.h: make "fd" version of read_bundle_header() public
  fetch-pack: add a deref_without_lazy_fetch_extended()
  fetch-pack: move --keep=* option filling to a function
  index-pack: add --progress-title option
  bundle-uri client: support for bundle-uri with "clone"
  bundle-uri docs: add design notes

 Documentation/config/transfer.txt          |  26 ++
 Documentation/git-index-pack.txt           |   6 +
 Documentation/git-ls-remote-bundle-uri.txt |  63 +++
 Documentation/git-ls-remote.txt            |   1 +
 Documentation/technical/bundle-uri.txt     | 119 ++++++
 Documentation/technical/protocol-v2.txt    | 145 +++++++
 Makefile                                   |   3 +
 builtin.h                                  |   1 +
 builtin/clone.c                            |   7 +
 builtin/index-pack.c                       |   6 +
 builtin/ls-remote-bundle-uri.c             |  90 +++++
 bundle-uri.c                               | 151 ++++++++
 bundle-uri.h                               |  30 ++
 bundle.c                                   |   8 +-
 bundle.h                                   |   2 +
 command-list.txt                           |   1 +
 connect.c                                  |  80 +++-
 fetch-pack.c                               | 304 ++++++++++++++-
 fetch-pack.h                               |   6 +
 git.c                                      |   1 +
 remote.h                                   |   4 +
 serve.c                                    |   6 +
 t/helper/test-bundle-uri.c                 |  80 ++++
 t/helper/test-tool.c                       |   1 +
 t/helper/test-tool.h                       |   1 +
 t/lib-t5730-protocol-v2-bundle-uri.sh      | 425 +++++++++++++++++++++
 t/t5701-git-serve.sh                       | 124 +++++-
 t/t5730-protocol-v2-bundle-uri-file.sh     |  36 ++
 t/t5731-protocol-v2-bundle-uri-git.sh      |  17 +
 t/t5732-protocol-v2-bundle-uri-http.sh     |  17 +
 t/t5750-bundle-uri-parse.sh                |  98 +++++
 transport-helper.c                         |  13 +
 transport-internal.h                       |   7 +
 transport.c                                | 120 ++++++
 transport.h                                |  22 ++
 35 files changed, 1988 insertions(+), 33 deletions(-)
 create mode 100644 Documentation/git-ls-remote-bundle-uri.txt
 create mode 100644 Documentation/technical/bundle-uri.txt
 create mode 100644 builtin/ls-remote-bundle-uri.c
 create mode 100644 bundle-uri.c
 create mode 100644 bundle-uri.h
 create mode 100644 t/helper/test-bundle-uri.c
 create mode 100644 t/lib-t5730-protocol-v2-bundle-uri.sh
 create mode 100755 t/t5730-protocol-v2-bundle-uri-file.sh
 create mode 100755 t/t5731-protocol-v2-bundle-uri-git.sh
 create mode 100755 t/t5732-protocol-v2-bundle-uri-http.sh
 create mode 100755 t/t5750-bundle-uri-parse.sh

-- 
2.33.0.rc0.646.g585563e77f

