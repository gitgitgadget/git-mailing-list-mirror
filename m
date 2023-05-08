Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51B7CC77B7F
	for <git@archiver.kernel.org>; Mon,  8 May 2023 21:59:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233720AbjEHV7o (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 May 2023 17:59:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233109AbjEHV7m (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 May 2023 17:59:42 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C51ED114
        for <git@vger.kernel.org>; Mon,  8 May 2023 14:59:41 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id 3f1490d57ef6-b9d881ad689so6728478276.2
        for <git@vger.kernel.org>; Mon, 08 May 2023 14:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1683583181; x=1686175181;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2XJSnchhc7wnSxAMUa0oIXxb3LWzh6aRyBK6Fnwjpsk=;
        b=evQz5xpL/68f7SJQ4rb5Vca9XBqH2NShpYLkGARpUCJ3mYrSNKsJET4aPfH7dIHn0g
         XAvOqWIh5hjK42BfJX1fylFbErd16AHCMWHUt+fETILZbQZDupixHthp+nns/FAJRu48
         2poKaeFIkHRHUYy9AS0Jsyp6RkXNGU4eNFZBPUfTUTxHVauPlvVItlgeIwsHtuNjF0/m
         VGRg9PczZftYSytpf0ylCaaS7l2V+rQosQrP6mhgFAHUaoXN1qy4qLKr4Ow+scuTKHj7
         F6kcI4UrIeUEmvjKmvPFSCyoT/doqkwMqF86zeo3kxID40E1UlU24xSoVBKSgbsCt+1U
         5DGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683583181; x=1686175181;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2XJSnchhc7wnSxAMUa0oIXxb3LWzh6aRyBK6Fnwjpsk=;
        b=XISjIQBCXwLcPVrSqUv3tR4EqUNv2Kf9QbmF9RysVVYpiUhxs845T2ye0f5o8KQki2
         LAIZSuON5Fzm/wTHaI4/Qd6AHCjUJJnHQye+i0w5eVRZM+C6hbswZF90jrDm9qU5IvZ1
         kVG2tjCawLzXKCOM2u/fMNAmK9bdEpfriPuODhWCDNkWMMY/lI0n0NBSxP9mriKt5uko
         aA0PSlhTI8lKErhyCCW6mpwKN5C481F85AOmiEA2hISjfN1KqmFckBO45jgv3eS0Zc5I
         sDE3MkXDYPNURuBKXiChW1tR+V9aL/5oGKMKq2vVta321GdYj5bxkB935DY0pidQBRl/
         irJw==
X-Gm-Message-State: AC+VfDx7rMgZz5RQV4TLUDrrXE2gHBYhEcxkrDGW8630KIkSogctomuS
        2+8cnXF/HaSM5dVfAMpJ4ASxr/A6etxzPBbSx470dA==
X-Google-Smtp-Source: ACHHUZ5dW9r0kiTTwanBSlyce/IGFQXC3hRJBnaQJUkMcgJIWeMV/jXw2O7CcDVklyfqy646BepwTw==
X-Received: by 2002:a25:a50a:0:b0:ba2:5c80:4ec8 with SMTP id h10-20020a25a50a000000b00ba25c804ec8mr9331789ybi.38.1683583180800;
        Mon, 08 May 2023 14:59:40 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id s81-20020a254554000000b00b9ba6a3b675sm2645232yba.50.2023.05.08.14.59.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 May 2023 14:59:40 -0700 (PDT)
Date:   Mon, 8 May 2023 17:59:38 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        Derrick Stolee <derrickstolee@github.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 00/15] refs: implement skip lists for packed backend
Message-ID: <cover.1683581621.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series implements the concept of a skip list for the packed refs
backend. In situations where the caller has many references they want to
exclude, the packed-refs iterator maintains a list of (start, end)
tuples of regions to jump over (i.e. if `iter->pos == start`, jump
forward to `end`).

This series implements that concept, and uses it to power a couple of
new things:

  - `git for-each-ref --exclude`, which allows callers to specify
    prefixes they wish to discard.

    In a synthetic example, the naive implementation improved runtime
    from ~820ms to enumerate all references and discard unwanted ones,
    down to ~106ms with `--exclude`. By the end of the series, this time
    drops to under ~5ms.

  - `git receive-pack` uses the new skip-list machinery to avoid
    visiting references hidden via a hideRefs rule.

  - `git upload-pack` has an analogous optimization as above (though it
    can't kick in quite as often for reasons described in that patch).

The series is laid out as follows:

  - The first five patches are preparatory (various refs.c and
    ref-filter cleanup).
  - The sixth patch provides a naive implementation of `--exclude`.
  - The next four patches prepare for and implement skip lists in the
    packed-refs backend.
  - The last five patches apply the optimization in `upload-pack` and
    `receive-pack`.

The series is ordered so that any prefix of sections list above could be
queued independently. Thanks in advance for your review.

Jeff King (5):
  refs.c: rename `ref_filter`
  ref-filter.h: provide `REF_FILTER_INIT`
  ref-filter: clear reachable list pointers after freeing
  ref-filter: add ref_filter_clear()
  ref-filter.c: parameterize match functions over patterns

Taylor Blau (10):
  builtin/for-each-ref.c: add `--exclude` option
  refs: plumb `exclude_patterns` argument throughout
  refs/packed-backend.c: refactor `find_reference_location()`
  refs/packed-backend.c: implement skip lists to avoid excluded
    pattern(s)
  refs/packed-backend.c: add trace2 counters for skip list
  revision.h: store hidden refs in a `strvec`
  refs/packed-backend.c: ignore complicated hidden refs rules
  refs.h: let `for_each_namespaced_ref()` take excluded patterns
  upload-pack.c: avoid enumerating hidden refs where possible
  builtin/receive-pack.c: avoid enumerating hidden references

 Documentation/git-for-each-ref.txt |   6 +
 builtin/branch.c                   |   4 +-
 builtin/for-each-ref.c             |   8 +-
 builtin/receive-pack.c             |   7 +-
 builtin/tag.c                      |   4 +-
 http-backend.c                     |   2 +-
 ls-refs.c                          |   8 +-
 ref-filter.c                       |  61 ++++++--
 ref-filter.h                       |  12 ++
 refs.c                             |  61 ++++----
 refs.h                             |  15 +-
 refs/debug.c                       |   5 +-
 refs/files-backend.c               |   5 +-
 refs/packed-backend.c              | 222 ++++++++++++++++++++++++++---
 refs/refs-internal.h               |   7 +-
 revision.c                         |   4 +-
 revision.h                         |   5 +-
 t/helper/test-reach.c              |   2 +-
 t/helper/test-ref-store.c          |  10 ++
 t/t1419-exclude-refs.sh            | 131 +++++++++++++++++
 t/t6300-for-each-ref.sh            |  35 +++++
 trace2.h                           |   2 +
 trace2/tr2_ctr.c                   |   5 +
 upload-pack.c                      |  43 ++++--
 24 files changed, 559 insertions(+), 105 deletions(-)
 create mode 100755 t/t1419-exclude-refs.sh

-- 
2.40.1.477.g956c797dfc
