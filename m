Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF4EDC433DB
	for <git@archiver.kernel.org>; Fri,  5 Feb 2021 18:27:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7075D64E75
	for <git@archiver.kernel.org>; Fri,  5 Feb 2021 18:27:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233320AbhBEQo7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Feb 2021 11:44:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233258AbhBEQkv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Feb 2021 11:40:51 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE2ADC0613D6
        for <git@vger.kernel.org>; Fri,  5 Feb 2021 10:22:32 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id w4so6747567wmi.4
        for <git@vger.kernel.org>; Fri, 05 Feb 2021 10:22:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=sy1mqPYQdP1gSSfCIRsh0/+HTNQVydC+JgS9tE/qp/M=;
        b=jBq91KfUospWWkkXlRoex8wHVsnLgctbql8sv1XMdNphUO20LPCTxD7RGqgP1p/W5h
         Ye97Le327PiW8aKrmqWTrLzevZIsBYYLLobLopqxIrByN/YG+o2zd9pcMYdmzuT8N++v
         8WhvGRJASV/pD+U91a9teS4NmLhnbaZbbpRhKbn2UrWNrm37/LcOoi/iiX1S/5euKsNW
         l9bHW2zPD0dCGiQBV1MjIWqrVBWRDxztBKQ0y7rGOiDO/X9DDAdMn2nKPDCZgTQ5SiRP
         fOootmfFm22R4m+KDkZV6PoFovQjBvoQsviMpQFgCYb8+tb++uT8fGx1RSBwt+bcI3fW
         pzig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=sy1mqPYQdP1gSSfCIRsh0/+HTNQVydC+JgS9tE/qp/M=;
        b=F2QNZrq3LiyEJBIm/flcahjH2roZ9rJCEF+/W+Ijx7WgFSO5O9Ed4EFMCgaPWdZ8nH
         a4E1EVrBVKooJ87R+rq2YBmmmMulhwxpjO5kjmzXvZL7kaUEwEQnYI2hCQ9KGEDnEfPj
         Xnbo8ySsH5irgMofjzLXga9TEEHdn2RaTPZ2ffO9Ke8CoPUywTE7WsReuJpTLoBbhFf6
         I0TFINczLUsOqGaGwaQD8mXtWWTlmTGKlPe29YQmFrjIAOAg8eKMXkYjk/UYQffF0bf+
         PBWpgalKEkKBJ8ZxMqFf5j2n/CzCp6Rchqn4ktGTo6PQ853L6wj4HlVCJ5HrNyMOQrkN
         5eWA==
X-Gm-Message-State: AOAM532QOvRgNRSY8LEGFOmtln8BwqKgsrn7ujouS0IpGibhphpR0kWM
        vOPRjm0TiFlOy1DDuwuPkBWHDc6F3TA=
X-Google-Smtp-Source: ABdhPJwDYk1Fz3gfBwBTz+a9UdYLWoa7BpKaojJOZk8yykl8S4XzzZKixWgmgrLeefGvH6zGAMun1Q==
X-Received: by 2002:a05:600c:4f56:: with SMTP id m22mr4759918wmq.49.1612549351181;
        Fri, 05 Feb 2021 10:22:31 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d3sm13642192wrp.79.2021.02.05.10.22.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Feb 2021 10:22:30 -0800 (PST)
Message-Id: <pull.858.v3.git.1612549349.gitgitgadget@gmail.com>
In-Reply-To: <pull.858.v2.git.1612282749.gitgitgadget@gmail.com>
References: <pull.858.v2.git.1612282749.gitgitgadget@gmail.com>
From:   "Thomas Ackermann via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 05 Feb 2021 18:22:23 +0000
Subject: [PATCH v3 0/6] doc: improvements for hash-function-transition
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Thomas Ackermann <th.acker@arcor.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Some asciidoc formatting errors and some minor formatting inconsistencies in
hash-function-transition.txt were fixed.

Content-wise the rationale for choosing SHA-256 was shortened a little bit
and moved to the beginning of the document. Also an incomplete sentence was
corrected.

Changes since v2:

 * Move a stray change from 1/6 back to 2/6; fix an incomplete conversion in
   2/6.
 * Rework rationale based on the comments from Junio and Brian.
 * Rebased on current master.

Changes since v1:

 * Better commit messages.

 * Details on SHA-1 weaknesses were removed from the rationale.

 * All http links to lore.kernel.org in the tree were changed to https
   links.
   
   Thanks to Ævar, Junio and Brian for their suggestions and help.

Signed-off-by: Thomas Ackermann th.acker@arcor.de

Thomas Ackermann (6):
  doc hash-function-transition: fix asciidoc output
  doc hash-function-transition: use SHA-1 and SHA-256 consistently
  doc hash-function-transition: use upper case consistently
  doc hash-function-transition: fix incomplete sentence
  doc hash-function-transition: move rationale upwards
  doc: use https links

 .../technical/hash-function-transition.txt    | 293 +++++++++---------
 t/t0021-conversion.sh                         |   4 +-
 2 files changed, 150 insertions(+), 147 deletions(-)


base-commit: 30b29f044a2b30f0667eb21559959e03eb1bd04f
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-858%2Ftacker66%2Fdoc_hash_function_transition-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-858/tacker66/doc_hash_function_transition-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/858

Range-diff vs v2:

 1:  f36c5dd4c1e3 ! 1:  7c78d0c1c30a doc hash-function-transition: fix asciidoc output
     @@ Documentation/technical/hash-function-transition.txt: network byte order):
       Loose object index
       ~~~~~~~~~~~~~~~~~~
      @@ Documentation/technical/hash-function-transition.txt: the following steps:
     -    they will be discarded.)
       3. convert to sha256: open a new (sha256) packfile. Read the topologically
          sorted list just generated. For each object, inflate its
     --   sha1-content, convert to sha256-content, and write it to the sha256
     +    sha1-content, convert to sha256-content, and write it to the sha256
      -   pack. Record the new sha1<->sha256 mapping entry for use in the idx.
     -+   SHA-1 content, convert to SHA-256 content, and write it to the SHA-256
     -+   pack. Record the new SHA-1<-->SHA-256 mapping entry for use in the idx.
     ++   pack. Record the new sha1<-->sha256 mapping entry for use in the idx.
       4. sort: reorder entries in the new pack to match the order of objects
          in the pack the server generated and include blobs. Write a sha256 idx
          file
 2:  681ce4129dc3 ! 2:  69ebc9a8f19a doc hash-function-transition: use SHA-1 and SHA-256 consistently
     @@ Documentation/technical/hash-function-transition.txt: repository extensions.
      -that objects referenced by the object are named using their sha256-names
      -instead of sha1-names. Because a blob object does not refer to any
      -other object, its sha1-content and sha256-content are the same.
     -+The SHA-256-content of an object is the same as its SHA-1 content, except
     ++The SHA-256 content of an object is the same as its SHA-1 content, except
      +that objects referenced by the object are named using their SHA-256 names
      +instead of SHA-1 names. Because a blob object does not refer to any
      +other object, its SHA-1 content and SHA-256 content are the same.
     @@ Documentation/technical/hash-function-transition.txt: the following steps:
      -3. convert to sha256: open a new (sha256) packfile. Read the topologically
      +3. convert to SHA-256: open a new SHA-256 packfile. Read the topologically
          sorted list just generated. For each object, inflate its
     -    SHA-1 content, convert to SHA-256 content, and write it to the SHA-256
     -    pack. Record the new SHA-1<-->SHA-256 mapping entry for use in the idx.
     +-   sha1-content, convert to sha256-content, and write it to the sha256
     +-   pack. Record the new sha1<-->sha256 mapping entry for use in the idx.
     ++   SHA-1 content, convert to SHA-256 content, and write it to the SHA-256
     ++   pack. Record the new SHA-1<-->SHA-256 mapping entry for use in the idx.
       4. sort: reorder entries in the new pack to match the order of objects
      -   in the pack the server generated and include blobs. Write a sha256 idx
      +   in the pack the server generated and include blobs. Write a SHA-256 idx
 3:  4f622fffcc5d = 3:  06b781206e4c doc hash-function-transition: use upper case consistently
 4:  58295cadffe5 = 4:  7a29f06c3f25 doc hash-function-transition: fix incomplete sentence
 5:  711a37969b6f ! 5:  ee0fa2ec1d0f doc hash-function-transition: move rationale upwards
     @@ Commit message
          Move rationale for new hash function to beginning of document
          so that it appears before the concrete move to SHA-256 is described.
      
     -    Remove details about SHA-1 weaknesses. Instead add references
     -    to the details of how the new hash function was chosen.
     +    Remove some of the details about SHA-1 weaknesses and add references
     +    to the details on how the new hash function was chosen instead.
      
          Signed-off-by: Thomas Ackermann <th.acker@arcor.de>
      
       ## Documentation/technical/hash-function-transition.txt ##
     -@@ Documentation/technical/hash-function-transition.txt: advantages:
     -   methods have a short reliable string that can be used to reliably
     -   address stored content.
     - 
     --Over time some flaws in SHA-1 have been discovered by security
     --researchers. On 23 February 2017 the SHAttered attack
     --(https://shattered.io) demonstrated a practical SHA-1 hash collision.
     -+Over time some flaws in SHA-1 have been discovered by security researchers.
     +@@ Documentation/technical/hash-function-transition.txt: researchers. On 23 February 2017 the SHAttered attack
       
       Git v2.13.0 and later subsequently moved to a hardened SHA-1
     --implementation by default, which isn't vulnerable to the SHAttered
     + implementation by default, which isn't vulnerable to the SHAttered
      -attack.
     -+implementation by default, but SHA-1 is still believed to be weak.
     ++attack, but SHA-1 is still weak.
       
      -Thus Git has in effect already migrated to a new hash that isn't SHA-1
      -and doesn't share its vulnerabilities, its new hash function just
     @@ Documentation/technical/hash-function-transition.txt: SHA-1 still possesses the
       
      +Choice of Hash
      +--------------
     ++The hash to replace the hardened SHA-1 should be stronger than SHA-1
     ++was: we would like it to be trustworthy and useful in practice for at
     ++least 10 years.
     ++
     ++Some other relevant properties:
     ++
     ++1. A 256-bit hash (long enough to match common security practice; not
     ++   excessively long to hurt performance and disk usage).
     ++
     ++2. High quality implementations should be widely available (e.g., in
     ++   OpenSSL and Apple CommonCrypto).
     ++
     ++3. The hash function's properties should match Git's needs (e.g. Git
     ++   requires collision and 2nd preimage resistance and does not require
     ++   length extension resistance).
     ++
     ++4. As a tiebreaker, the hash should be fast to compute (fortunately
     ++   many contenders are faster than SHA-1).
     ++
      +There were several contenders for a successor hash to SHA-1, including
      +SHA-256, SHA-512/256, SHA-256x16, K12, and BLAKE2bp-256.
      +
 6:  d6041b7e9e87 = 6:  c31d6e258fd0 doc: use https links

-- 
gitgitgadget
