Return-Path: <SRS0=NddV=BZ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CA2BC433E1
	for <git@archiver.kernel.org>; Sat, 15 Aug 2020 21:52:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D4FC5204FD
	for <git@archiver.kernel.org>; Sat, 15 Aug 2020 21:52:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pzJ26LIA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729140AbgHOVwj (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 15 Aug 2020 17:52:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729101AbgHOVwd (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Aug 2020 17:52:33 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AF28C025571
        for <git@vger.kernel.org>; Sat, 15 Aug 2020 09:06:24 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id i10so13023020ljn.2
        for <git@vger.kernel.org>; Sat, 15 Aug 2020 09:06:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CmZYnmqWDd0WF9xkJ9XmtO868GG39pigCVobf7SOQBg=;
        b=pzJ26LIAoNdBPvK+4jdohY0Bzbtpz+5ciWKPTkmvuusSlmWHJGN8/MtEzL/HS1iFBF
         i67KKjiVkoPcsj1f6ikXmeAcre40bLCF1gkadLkMnIC3uhGOkfcIPrUji4mttDvDzTHl
         WVP1En6EunbdyWazIE5U5LHphpl3A4KH34Y6bolFP/4cn8F0j3/RIXmIMRLw6FSZXMHH
         2bi8hyeOmv/+tStZLv8nMS3OZjBrjeE5y2cFUozz+NleQjs95fdb3WiizpUUswslMvLi
         V4EO9Y712ODegS5kyNFCGmXe8S67VCEMBEgTdtYlekBLgZkbCfqI9ZLKYN5PFWBByVX/
         XHLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CmZYnmqWDd0WF9xkJ9XmtO868GG39pigCVobf7SOQBg=;
        b=Q4qD3x5YzxDbOyxBmgau9+IDt8xtGZeQsGv6eNiezfRgUWWrD6JYhNLhpocwpR5bwz
         43PdV9l7Q8Ls9cW7qwgSCXuwLNkijlZC8PQCjN2b/jTsrctBmZzZW8be9WJMpDm5Xn02
         aqMQDWvzF16wdDVTzJxJKz7o0JEP+A6Cdh1mpnS/j13cGwbH1+WQ7lXjfH9nksAvWtzB
         r7TpafpQml52K5QZ/IXOCUWmj8qWLnDINeNeWBGeNS9jHwg8w2rqhiGm/7x4+yVhbWLX
         hwleTTXlWzdfZEFISrzJ9oCww5xVUq/bqeGM4LejuDaeVPnrsLNM4Yj5nqJyyTZ4Fg9h
         A/pg==
X-Gm-Message-State: AOAM532W5I+/+AB9Fj/7BrV7Gphe9hqW1P41LAZhne57Ub+T3hv56cmP
        FSFmh65fofMUSQ4JnRNJJtW6uXRNIgU=
X-Google-Smtp-Source: ABdhPJzhGIO4hVI5Jiy7VhNcuY4wHHHZYmnlAiUIDvQQvLJB+t+5QTw4tMci4pMDGlH8JFlqU6N+ow==
X-Received: by 2002:a2e:d1a:: with SMTP id 26mr3418161ljn.412.1597507581365;
        Sat, 15 Aug 2020 09:06:21 -0700 (PDT)
Received: from localhost.localdomain (31-211-229-121.customers.ownit.se. [31.211.229.121])
        by smtp.gmail.com with ESMTPSA id a1sm2670493lfb.10.2020.08.15.09.06.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Aug 2020 09:06:20 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Derrick Stolee <stolee@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 0/4] more SHA-256 documentation
Date:   Sat, 15 Aug 2020 18:05:58 +0200
Message-Id: <cover.1597506837.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.28.0.297.g1956fa8f8d
In-Reply-To: <cover.1597406877.git.martin.agren@gmail.com>
References: <cover.1597406877.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks brian, Stolee and Junio for your comments on the initial
submission. Changes since v1:

 * Dropped some "160-bit" I had missed.

 * Refer to the 'object-format' capability in a few spots rather than
   discussing SHA-1 vs SHA-256 repos.

 * Dropped the final patch, since Stolee has submitted a patch (series)
   for changing the implementation instead.

These could be part of bc/sha-256-doc-updates, since they are quite
similar in spirit, or go in separately, so these series don't need to
hold each other hostage. Whatever Junio and brian prefer will be fine
by me.

Martin

Martin Ågren (4):
  http-protocol.txt: document SHA-256 "want"/"have" format
  index-format.txt: document SHA-256 index format
  protocol-capabilities.txt: clarify "allow-x-sha1-in-want" re SHA-256
  shallow.txt: document SHA-256 shallow format

 Documentation/technical/http-protocol.txt     |  5 +--
 Documentation/technical/index-format.txt      | 34 ++++++++++---------
 .../technical/protocol-capabilities.txt       | 12 ++++---
 Documentation/technical/shallow.txt           |  2 +-
 4 files changed, 30 insertions(+), 23 deletions(-)

Range-diff against v1:
1:  fcb26c81be ! 1:  2e9f6b9294 http-protocol.txt: document SHA-256 "want"/"have" format
    @@ Metadata
      ## Commit message ##
         http-protocol.txt: document SHA-256 "want"/"have" format
     
    -    Document that in SHA-1 repositories, we use SHA-1 for "want"s and
    -    "have"s, and in SHA-256 repositories, we use SHA-256.
    +    Document that rather than always naming objects using SHA-1, we should
    +    use whatever has been negotiated using the object-format capability.
     
         Signed-off-by: Martin Ågren <martin.agren@gmail.com>
     
    @@ Documentation/technical/http-protocol.txt: at all in the request stream:
     -SHA-1 as its value.  Multiple SHA-1s MUST be sent by sending
     -multiple commands.
     +object name as its value.  Multiple object names MUST be sent by sending
    -+multiple commands. (An object name is a SHA-1 hash in a SHA-1 repo
    -+and a SHA-256 hash in a SHA-256 repo.)
    ++multiple commands. Object names MUST be given using the object format
    ++negotiated through the `object-format` capability (default SHA-1).
      
      The `have` list is created by popping the first 32 commits
      from `c_pending`.  Less can be supplied if `c_pending` empties.
2:  5c13a9478a ! 2:  14bd0d9362 index-format.txt: document SHA-256 index format
    @@ Metadata
      ## Commit message ##
         index-format.txt: document SHA-256 index format
     
    -    Similar to a recent commit, document that in SHA-1 repositories, we use
    -    SHA-1 and in SHA-256 repositories, we use SHA-256, then replace all
    -    other uses of "SHA-1" with something more neutral.
    +    Document that in SHA-1 repositories, we use SHA-1 and in SHA-256
    +    repositories, we use SHA-256, then replace all other uses of "SHA-1"
    +    with something more neutral. Avoid referring to "160-bit" hash values.
     
         Signed-off-by: Martin Ågren <martin.agren@gmail.com>
     
    @@ Documentation/technical/index-format.txt: Git index format
           Extension data
      
     -   - 160-bit SHA-1 over the content of the index file before this
    -+   - 160-bit hash checksum over the content of the index file before this
    -      checksum.
    +-     checksum.
    ++   - Hash checksum over the content of the index file before this checksum.
      
      == Index entry
    + 
     @@ Documentation/technical/index-format.txt: Git index format
        32-bit file size
          This is the on-disk size from stat(2), truncated to 32-bit.
      
     -  160-bit SHA-1 for the represented object
    -+  160-bit object name for the represented object
    ++  Object name for the represented object
      
        A 16-bit 'flags' field split into (high to low bits)
      
    +@@ Documentation/technical/index-format.txt: Git index format
    + 
    +   - A newline (ASCII 10); and
    + 
    +-  - 160-bit object name for the object that would result from writing
    +-    this span of index as a tree.
    ++  - Object name for the object that would result from writing this span
    ++    of index as a tree.
    + 
    +   An entry can be in an invalidated state and is represented by having
    +   a negative number in the entry_count field. In this case, there is no
    +@@ Documentation/technical/index-format.txt: Git index format
    +     stage 1 to 3 (a missing stage is represented by "0" in this field);
    +     and
    + 
    +-  - At most three 160-bit object names of the entry in stages from 1 to 3
    ++  - At most three object names of the entry in stages from 1 to 3
    +     (nothing is written for a missing stage).
    + 
    + === Split index
     @@ Documentation/technical/index-format.txt: Git index format
      
        The extension consists of:
3:  82e5c67b7c ! 3:  2e82be9e36 protocol-capabilities.txt: clarify "allow-x-sha1-in-want" re SHA-256
    @@ Metadata
      ## Commit message ##
         protocol-capabilities.txt: clarify "allow-x-sha1-in-want" re SHA-256
     
    -    Two of our extensions contain "sha1" in their names, but that's
    -    historical. The "want"s will take object names that are not necessarily
    -    SHA-1s. Make this clear, but also make it clear how there's still just
    -    one correct hash algo: These extensions don't somehow make the "want"s
    -    take object names derived using *any* hash algorithm.
    +    Two of our capabilities contain "sha1" in their names, but that's
    +    historical. Clarify that object names are still to be given using
    +    whatever object format has been negotiated using the "object-format"
    +    capability.
     
         Signed-off-by: Martin Ågren <martin.agren@gmail.com>
     
    @@ Documentation/technical/protocol-capabilities.txt: allow-tip-sha1-in-want
     -send "want" lines with SHA-1s that exist at the server but are not
     -advertised by upload-pack.
     +send "want" lines with object names that exist at the server but are not
    -+advertised by upload-pack. (Note that the name of the capability
    -+contains "sha1", but that it's more general than that: in SHA-1
    -+repositories, the "want" lines provide SHA-1 values, but in SHA-256
    -+repositories, they provide SHA-256 values.)
    ++advertised by upload-pack. For historical reasons, the name of this
    ++capability contains "sha1". Object names are always given using the
    ++object format negotiated through the 'object-format' capability.
      
      allow-reachable-sha1-in-want
      ----------------------------
    @@ Documentation/technical/protocol-capabilities.txt: allow-tip-sha1-in-want
     -send "want" lines with SHA-1s that exist at the server but are not
     -advertised by upload-pack.
     +send "want" lines with object names that exist at the server but are not
    -+advertised by upload-pack. (Same remark about "sha1" as above.)
    ++advertised by upload-pack. For historical reasons, the name of this
    ++capability contains "sha1". Object names are always given using the
    ++object format negotiated through the 'object-format' capability.
      
      push-cert=<nonce>
      -----------------
4:  bcfbdd25e5 ! 4:  8680fc1af6 shallow.txt: document SHA-256 shallow format
    @@ Metadata
      ## Commit message ##
         shallow.txt: document SHA-256 shallow format
     
    -    Similar to recent commits, document that in SHA-1 repositories, we use
    -    SHA-1 for these purposes, and in SHA-256 repositories, we use SHA-256.
    +    Similar to recent commits, document that we list object names rather
    +    than SHA-1s.
     
         Signed-off-by: Martin Ågren <martin.agren@gmail.com>
     
5:  f95e3f65e7 < -:  ---------- commit-graph-format.txt: fix "Hash Version" description
-- 
2.28.0.297.g1956fa8f8d

