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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55306C433E6
	for <git@archiver.kernel.org>; Tue,  2 Feb 2021 16:24:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1486B64F70
	for <git@archiver.kernel.org>; Tue,  2 Feb 2021 16:24:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236359AbhBBQYk (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Feb 2021 11:24:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236212AbhBBQWW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Feb 2021 11:22:22 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E901C061786
        for <git@vger.kernel.org>; Tue,  2 Feb 2021 08:19:13 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id y187so2814645wmd.3
        for <git@vger.kernel.org>; Tue, 02 Feb 2021 08:19:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=PTtO3F37N27V8igbRHNjxyuYuFOYRq+n1pwFFHKWYsI=;
        b=Lp8j8civOaZddM/NQQX/HM6uZ9wMRfxkI4hiYkKFv8LQxZhgb0aLbR4w8Lzc1qRTzl
         8cI4qC5uv2UWm1K/RflkFILV+92Py/Z6TS9EGyelErmuYEmVDucPbJeHIL2qCfOPOtnK
         ZbHLBfsEu5WlGyGBI25gH1TrDWOVM21bdgr5Il2FwDEH42WszUBZEC2baDcNPvtvq5Gp
         ux/OgypcgFd7CahOPHIQSLHJkgqx15j0s5PH7DPmGYgjcIXwEji28vRU075WKatlMkdf
         EZxOqr+Ra3VT8m0URHkfvXXgcMuJAXMxjyq+Ox38BSLlxKXHjgdctmiWeEECD/rELrHU
         jn6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=PTtO3F37N27V8igbRHNjxyuYuFOYRq+n1pwFFHKWYsI=;
        b=cAOfZPTK9YaF0RK1GR2oRGBJm3cghkX7JkFOPUSnMf80iP9Al+c4T1IxCCghJCtBwU
         azPZzfmjOUBHXYOSTJiD4lHzVXst/MejQ4gMJsBuN+1UqfygQUU3C2a43iCj0O81Jh0C
         m94pUCjHY6+OWvlOYhX8HyVMSjRII8uvO6yWR4Ky88BOuFv878Xn+3IOZ3KNeXEasreL
         rSZCCJA6z98om0rXUjFCt+XPtX0cjGG7GGtBqSdsC3lPGds9oHv/1/1FdPgqfVURGrSm
         JHUOaPuSs/M+wpGzD7pLB0C2psuo2TZWCdQtAbcfOCLqSuRrk/MapC8tYC3VWR4bcgVc
         JN8A==
X-Gm-Message-State: AOAM533aJMLED4QNtXYxd4fiGcskJcGA69/ptfzAIv0s8F5GAsDmBu1w
        g2TiWiIyB9cm4FpsPqmAD+Nd4rhZDSs=
X-Google-Smtp-Source: ABdhPJxo8swsnYmHoAgMIzOmdi0Y5QQcbtM00sy+9aIAZIdjxlZ1SpT4S0Vp1bUnZqxpQEdajkZddg==
X-Received: by 2002:a1c:9609:: with SMTP id y9mr4344845wmd.75.1612282751595;
        Tue, 02 Feb 2021 08:19:11 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l14sm32020843wrq.87.2021.02.02.08.19.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Feb 2021 08:19:10 -0800 (PST)
Message-Id: <pull.858.v2.git.1612282749.gitgitgadget@gmail.com>
In-Reply-To: <pull.858.git.1612093734.gitgitgadget@gmail.com>
References: <pull.858.git.1612093734.gitgitgadget@gmail.com>
From:   "Thomas Ackermann via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 02 Feb 2021 16:19:03 +0000
Subject: [PATCH v2 0/6] doc: improvements for hash-function-transition
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Thomas Ackermann <th.acker@arcor.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Some asciidoc formatting errors and some minor formatting inconsistencies in
hash-function-transition.txt were fixed.

Content-wise the rationale for choosing SHA-256 was shortened and moved to
the beginning of the document and an incomplete sentence was corrected.

Changes since v1:

 * Better commit messages.
 * Details on SHA-1 weaknesses were removed from the rationale.
 * All http links to lore.kernel.org in the tree were changed to https
   links.

Thanks to Ævar for his suggestions and help.

Signed-off-by: Thomas Ackermann th.acker@arcor.de

Thomas Ackermann (6):
  doc hash-function-transition: fix asciidoc output
  doc hash-function-transition: use SHA-1 and SHA-256 consistently
  doc hash-function-transition: use upper case consistently
  doc hash-function-transition: fix incomplete sentence
  doc hash-function-transition: move rationale upwards
  doc: use https links

 .../technical/hash-function-transition.txt    | 279 ++++++++----------
 t/t0021-conversion.sh                         |   4 +-
 2 files changed, 132 insertions(+), 151 deletions(-)


base-commit: e6362826a0409539642a5738db61827e5978e2e4
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-858%2Ftacker66%2Fdoc_hash_function_transition-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-858/tacker66/doc_hash_function_transition-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/858

Range-diff vs v1:

 1:  3efe3392e9d ! 1:  f36c5dd4c1e doc hash-function-transition: fix asciidoc output
     @@ Metadata
       ## Commit message ##
          doc hash-function-transition: fix asciidoc output
      
     -    fix asciidoc output for lists, special characters and verbatim text while retaining the readabilty of the original text file
     +    Asciidoc requires lists to start with an empty line and uses
     +    different characters for indentation levels ("-", "*", "**", ...).
     +    For special symbols like a dash "--" has to be used and there is
     +    no double arrow "<->", so a left and right arrow "<-->" has to be
     +    combined for that. Lastly for verbatim output a newline followed
     +    by an indentation has to be used.
     +
     +    Fix asciidoc output for lists, special characters and verbatim
     +    text while retaining the readabilty of the original text file.
      
          Signed-off-by: Thomas Ackermann <th.acker@arcor.de>
      
 2:  62ca087d4eb ! 2:  681ce4129dc doc hash-function-transition: use SHA-1 and SHA-256 consistently
     @@ Metadata
       ## Commit message ##
          doc hash-function-transition: use SHA-1 and SHA-256 consistently
      
     -    use SHA-1 and SHA-256 instead of sha1 and sha256  when referring to the hash type
     +    Use SHA-1 and SHA-256 instead of sha1 and sha256  when referring
     +    to the hash type.
      
          Signed-off-by: Thomas Ackermann <th.acker@arcor.de>
      
 3:  37e3fd6aaa0 ! 3:  4f622fffcc5 doc hash-function-transition: use upper case consistently
     @@ Metadata
       ## Commit message ##
          doc hash-function-transition: use upper case consistently
      
     -    use upper case consistently in Document History
     +    Use upper case consistently in Document History.
      
          Signed-off-by: Thomas Ackermann <th.acker@arcor.de>
      
 6:  302c7b8dce0 = 4:  58295cadffe doc hash-function-transition: fix incomplete sentence
 5:  2cdb0f8e2ed ! 5:  711a37969b6 doc hash-function-transition: move rationale upwards
     @@ Metadata
       ## Commit message ##
          doc hash-function-transition: move rationale upwards
      
     -    move rationale for new hash function to beginning of document
     +    Move rationale for new hash function to beginning of document
     +    so that it appears before the concrete move to SHA-256 is described.
      
     -    rationale now appears before the concrete move to SHA-256 is described
     +    Remove details about SHA-1 weaknesses. Instead add references
     +    to the details of how the new hash function was chosen.
      
          Signed-off-by: Thomas Ackermann <th.acker@arcor.de>
      
     @@ Documentation/technical/hash-function-transition.txt: advantages:
       
      -Over time some flaws in SHA-1 have been discovered by security
      -researchers. On 23 February 2017 the SHAttered attack
     +-(https://shattered.io) demonstrated a practical SHA-1 hash collision.
      +Over time some flaws in SHA-1 have been discovered by security researchers.
     -+In early 2005, around the time that Git was written, Xiaoyun Wang,
     -+Yiqun Lisa Yin, and Hongbo Yu announced an attack finding SHA-1
     -+collisions in 2^69 operations. In August they published details.
     -+Luckily, no practical demonstrations of a collision in full SHA-1 were
     -+published until 10 years later: on 23 February 2017 the SHAttered attack
     - (https://shattered.io) demonstrated a practical SHA-1 hash collision.
       
       Git v2.13.0 and later subsequently moved to a hardened SHA-1
      -implementation by default, which isn't vulnerable to the SHAttered
      -attack.
     -+implementation by default that mitigates the SHAttered attack, but
     -+SHA-1 is still believed to be weak.
     ++implementation by default, but SHA-1 is still believed to be weak.
       
     - Thus Git has in effect already migrated to a new hash that isn't SHA-1
     - and doesn't share its vulnerabilities, its new hash function just
     +-Thus Git has in effect already migrated to a new hash that isn't SHA-1
     +-and doesn't share its vulnerabilities, its new hash function just
     +-happens to produce exactly the same output for all known inputs,
     +-except two PDFs published by the SHAttered researchers, and the new
     +-implementation (written by those researchers) claims to detect future
     +-cryptanalytic collision attacks.
     +-
     +-Regardless, it's considered prudent to move past any variant of SHA-1
     ++Thus it's considered prudent to move past any variant of SHA-1
     + to a new hash. There's no guarantee that future attacks on SHA-1 won't
     + be published in the future, and those attacks may not have viable
     + mitigations.
      @@ Documentation/technical/hash-function-transition.txt: SHA-1 still possesses the other properties such as fast object lookup
       and safe error checking, but other hash functions are equally suitable
       that are believed to be cryptographically secure.
       
      +Choice of Hash
      +--------------
     -+The hash to replace the hardened SHA-1 should be stronger than SHA-1
     -+was: we would like it to be trustworthy and useful in practice for at
     -+least 10 years.
     -+
     -+Some other relevant properties:
     -+
     -+1. A 256-bit hash (long enough to match common security practice; not
     -+   excessively long to hurt performance and disk usage).
     -+
     -+2. High quality implementations should be widely available (e.g., in
     -+   OpenSSL and Apple CommonCrypto).
     -+
     -+3. The hash function's properties should match Git's needs (e.g. Git
     -+   requires collision and 2nd preimage resistance and does not require
     -+   length extension resistance).
     ++There were several contenders for a successor hash to SHA-1, including
     ++SHA-256, SHA-512/256, SHA-256x16, K12, and BLAKE2bp-256.
      +
     -+4. As a tiebreaker, the hash should be fast to compute (fortunately
     -+   many contenders are faster than SHA-1).
     ++In late 2018 the project picked SHA-256 as its successor hash.
      +
     -+We choose SHA-256.
     ++See 0ed8d8da374 (doc hash-function-transition: pick SHA-256 as
     ++NewHash, 2018-08-04) and numerous mailing list threads at the time,
     ++particularly the one starting at
     ++https://lore.kernel.org/git/20180609224913.GC38834@genre.crustytoothpaste.net/
     ++for more information.
      +
       Goals
       -----
 4:  d4abf1cf78e ! 6:  d6041b7e9e8 doc hash-function-transition: use https links consistently
     @@ Metadata
      Author: Thomas Ackermann <th.acker@arcor.de>
      
       ## Commit message ##
     -    doc hash-function-transition: use https links consistently
     +    doc: use https links
      
     -    use only https links in References
     +    Use only https links for lore.kernel.org.
      
          Signed-off-by: Thomas Ackermann <th.acker@arcor.de>
      
       ## Documentation/technical/hash-function-transition.txt ##
     +@@ Documentation/technical/hash-function-transition.txt: Document History
     + bmwill@google.com, jonathantanmy@google.com, jrnieder@gmail.com,
     + sbeller@google.com
     + 
     +-* Initial version sent to http://lore.kernel.org/git/20170304011251.GA26789@aiede.mtv.corp.google.com
     ++* Initial version sent to https://lore.kernel.org/git/20170304011251.GA26789@aiede.mtv.corp.google.com
     + 
     + 2017-03-03 jrnieder@gmail.com
     + Incorporated suggestions from jonathantanmy and sbeller:
      @@ Documentation/technical/hash-function-transition.txt: Later history:
       
       References:
     @@ Documentation/technical/hash-function-transition.txt: Later history:
      + [3] https://lore.kernel.org/git/20170306084353.nrns455dvkdsfgo5@sigill.intra.peff.net/
      + [4] https://lore.kernel.org/git/20170304224936.rqqtkdvfjgyezsht@genre.crustytoothpaste.net
        [5] https://lore.kernel.org/git/CAJo=hJtoX9=AyLHHpUJS7fueV9ciZ_MNpnEPHUz8Whui6g9F0A@mail.gmail.com/
     +
     + ## t/t0021-conversion.sh ##
     +@@ t/t0021-conversion.sh: filter_git () {
     + # Compare two files and ensure that `clean` and `smudge` respectively are
     + # called at least once if specified in the `expect` file. The actual
     + # invocation count is not relevant because their number can vary.
     +-# c.f. http://lore.kernel.org/git/xmqqshv18i8i.fsf@gitster.mtv.corp.google.com/
     ++# c.f. https://lore.kernel.org/git/xmqqshv18i8i.fsf@gitster.mtv.corp.google.com/
     + test_cmp_count () {
     + 	expect=$1
     + 	actual=$2
     +@@ t/t0021-conversion.sh: test_cmp_count () {
     + 
     + # Compare two files but exclude all `clean` invocations because Git can
     + # call `clean` zero or more times.
     +-# c.f. http://lore.kernel.org/git/xmqqshv18i8i.fsf@gitster.mtv.corp.google.com/
     ++# c.f. https://lore.kernel.org/git/xmqqshv18i8i.fsf@gitster.mtv.corp.google.com/
     + test_cmp_exclude_clean () {
     + 	expect=$1
     + 	actual=$2

-- 
gitgitgadget
