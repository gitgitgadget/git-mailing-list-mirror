Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47EB5CCA473
	for <git@archiver.kernel.org>; Mon,  6 Jun 2022 19:55:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232839AbiFFTzh (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Jun 2022 15:55:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232840AbiFFTz3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Jun 2022 15:55:29 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ABE31A834
        for <git@vger.kernel.org>; Mon,  6 Jun 2022 12:55:28 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id p10so21221872wrg.12
        for <git@vger.kernel.org>; Mon, 06 Jun 2022 12:55:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=um0pHlFDlPXQvry7GVWW0ZvUYGXtnh++KQClsj3pm6s=;
        b=Nx7jZEVl4v/uN8idqeyoIySCY64piD1EV0NXU4nfdhT5P2HPZ/8yUcWxW310cdOupN
         GPcmZvl+76/0sZ/a7aP8fSczNG/w10UfHfy/b3MdJwx7qkfY6MmDvBGFjJCeDs8lDfuG
         Sw/xlQd6rHR8S7fhM+gC/AYcy+yT1WGnW4vTR0r7tc01AAHJpODjdggtLurr93dQ0U5+
         l+GfKpdaCgqmow1oLQzN0qM+10Z9T0Mq7ZHmiXuYt69WXJFzN6+ArRr5Bj/0ovNIz3WT
         nRT+lQbIueliLeQuixk94ZY8vIEMcVO9+CWbubWs0uVD/4DLBhVKdbsaYZMHcteVkF4m
         4z2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=um0pHlFDlPXQvry7GVWW0ZvUYGXtnh++KQClsj3pm6s=;
        b=aNzQhDNeovnujQ/HbyL1YbYvADyV5ZQZuWtFo6INor1Z+9z9EnUIzRzD67IEnzvf0U
         meYfeipcD1RX6hcDfTjtUZGBLB1aGcOFL88y2ED5vnfnQMxEQYtAJOyktbBrghof7d1H
         y4rMXOsww1lqzCc/hBAU8eGV00jlc8C19S3QBzOFQEjuxGkvKMxnXTlg+LGUopw8CKJx
         WlgviiBIO6sCTsEMgGvJtGmUjrOJaElEdLot0HhploukBANod3Q0Zc0Xh7r4ip1GUmVv
         jPMkoKxK/If7ri7J7kgsZhUelWGctScD55Co1NEeEX/ZQYnngPIUXKuNj6fNkCX6+uYN
         wamw==
X-Gm-Message-State: AOAM533tG5cjV7en9XTHf7GNPmoVOqSMm/Y772wQXpE4/00Gv0UKKAz0
        WSDdyT+FaxHcrhDLiB+TosTkfOrblMFOD488
X-Google-Smtp-Source: ABdhPJyor2vv/c7+5yz66pVyUrGtMFHpq/gpB184aTEgOA25lZ/LW3Z3iDT1i7PzFw060ZcYhOjOWQ==
X-Received: by 2002:a5d:47c9:0:b0:20f:e7da:6a48 with SMTP id o9-20020a5d47c9000000b0020fe7da6a48mr23932350wrc.315.1654545326651;
        Mon, 06 Jun 2022 12:55:26 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c4-20020a05600c0ac400b0039c4f53c4fdsm4685078wmr.45.2022.06.06.12.55.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jun 2022 12:55:26 -0700 (PDT)
Message-Id: <pull.1248.git.1654545325.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 06 Jun 2022 19:55:19 +0000
Subject: [PATCH 0/6] bundle URIs: design doc and initial git fetch --bundle-uri implementation
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, me@ttaylorr.com, newren@gmail.com,
        avarab@gmail.com, dyroneteng@gmail.com, Johannes.Schindelin@gmx.de,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is the first of series towards building the bundle URI feature as
discussed in previous RFCs, specifically pulled directly out of [5]:

[1]
https://lore.kernel.org/git/RFC-cover-00.13-0000000000-20210805T150534Z-avarab@gmail.com/
[2]
https://lore.kernel.org/git/cover-0.3-00000000000-20211025T211159Z-avarab@gmail.com/
[3]
https://lore.kernel.org/git/pull.1160.git.1645641063.gitgitgadget@gmail.com
[4]
https://lore.kernel.org/git/RFC-cover-v2-00.36-00000000000-20220418T165545Z-avarab@gmail.com/
[5]
https://lore.kernel.org/git/pull.1234.git.1653072042.gitgitgadget@gmail.com

The first patch details the long-term design and goals of the bundle URI
feature, including complicated features such as the bundle-uri protocol v2
verb and bundle lists with heuristics.

However, then intention is to start small with the simplest features that
allow user benefit as soon as possible. In that direction, the rest of this
series creates the ability to run 'git fetch --bundle-uri=' to skip fetching
from any remote and instead download the file at the given . Currently, that
data is expected to be a bundle, which Git will then unbundle and modify the
refs to be in the 'refs/bundle/' namespace.

Currently, the can be a literal filename, a file:// URI, or an http[s]://
URI. Tests are added for both of these cases.

As outlined in [5], the next steps after this are:

 1. Add 'git clone --bundle-uri=' to run this 'git fetch --bundle-uri=' step
    before doing a fetch negotiation with the origin remote.
 2. Allow parsing a bundle list as a config file at the given URI. The
    key-value format is unified with the protocol v2 verb (coming in (3)).
 3. Implement the protocol v2 verb, re-using the bundle list logic from (2).
    Use this to auto-discover bundle URIs during 'git clone' (behind a
    config option).
 4. Implement the 'timestamp' heuristic, allowing incremental 'git fetch'
    commands to download a bundle list from a configured URI, and only
    download bundles that are new based on the timestamp values.

As mentioned in the design document, this is not all that is possible. For
instance, Ævar's suggestion to download only the bundle headers can be used
as a second heuristic (and as an augmentation of the timestamp heuristic).

Thanks, -Stolee

Derrick Stolee (6):
  docs: document bundle URI standard
  remote-curl: add 'get' capability
  bundle-uri: create basic file-copy logic
  fetch: add --bundle-uri option
  bundle-uri: add support for http(s):// and file://
  fetch: add 'refs/bundle/' to log.excludeDecoration

 Documentation/fetch-options.txt        |   6 +
 Documentation/git-fetch.txt            |   1 +
 Documentation/gitremote-helpers.txt    |   9 +
 Documentation/technical/bundle-uri.txt | 475 +++++++++++++++++++++++++
 Makefile                               |   1 +
 builtin/fetch.c                        |  10 +
 bundle-uri.c                           | 166 +++++++++
 bundle-uri.h                           |  14 +
 remote-curl.c                          |  33 ++
 t/t5557-http-get.sh                    |  37 ++
 t/t5558-fetch-bundle-uri.sh            |  77 ++++
 transport-helper.c                     |   5 +-
 12 files changed, 833 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/technical/bundle-uri.txt
 create mode 100644 bundle-uri.c
 create mode 100644 bundle-uri.h
 create mode 100755 t/t5557-http-get.sh
 create mode 100755 t/t5558-fetch-bundle-uri.sh


base-commit: 89c6e450fe4a919ecb6fa698005a935531c732cf
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1248%2Fderrickstolee%2Fbundle-redo%2Ffetch-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1248/derrickstolee/bundle-redo/fetch-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1248
-- 
gitgitgadget
