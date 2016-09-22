Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3FF231F4F8
	for <e@80x24.org>; Thu, 22 Sep 2016 18:53:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965709AbcIVSx3 (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Sep 2016 14:53:29 -0400
Received: from mail-qk0-f193.google.com ([209.85.220.193]:34351 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934752AbcIVSxY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Sep 2016 14:53:24 -0400
Received: by mail-qk0-f193.google.com with SMTP id b204so5745415qkc.1
        for <git@vger.kernel.org>; Thu, 22 Sep 2016 11:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nyu-edu.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=7YSWfeV8tNUftR/V8/0DYMDalFN+eIcwI08XWsBujwM=;
        b=Ez9j17Ub27T/xzcdvMSyW6BXhgvw3DX1KSrJWuO+x6X5IwxMJjq6KgPLrE4K8YbtRQ
         GgRl+S+ENBRNZte2ZQyZRem6ITcKfit7g6ceppdRxt02QNQ7r65ort2ky7+K6RZKNzh/
         cK7w+iQEQgayvFvfBpac1tuN7kx4Ewh+nHDKTgIH4KlfUx3Z/bNhXai3JHB4q6WgU5tk
         3f1eIlXvnJFrnRTIVJgxYlZgER32JY2XpMAyVJDcLOwczF6N/zQ7+y1oaN5nK3ur2YhF
         tzFB2QSMXwCDv04uobrI0cLSlqL7oF4PdqD/5R8r7oU1M8bmtl5s7GXdNuU/CoeVFiob
         wCtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=7YSWfeV8tNUftR/V8/0DYMDalFN+eIcwI08XWsBujwM=;
        b=VscpyKzJAuLivrVE87wvKHnXugCPE9W9AWRQG/ovI9W6hsvCE9FA5o4DSwxXX4ts1g
         KpjOsWMoTLmXuMGVPZ4ZoZB1Sm04eXm8d7bOuv4vqNaevRn1og4wtMu/OQjeXezzMKfK
         AEVZKJIVWy4TFz+0lmwlmr5N6D/AO2hcvYIVipcneLdV2tulCMsDb533EQb6h3xGVjUO
         g02By9N4+vj+pW7kzIFL5rYHPYN5rVIugia2MwOcqTcG3oK3YW3BOBiuT+SqTX57cpFl
         cEOAgu2iagv2gFlMFDLmrjhA+ceO+B3IHBaLxPbjEGH3PHWWmKETIxeJK9NrADXQUwql
         5L4A==
X-Gm-Message-State: AA6/9RmSC48Tud2IfYpmu2fQmkNsU/GtHhbZfCdujyMJa5Z+uC4em/Y11ukWwrHXVWkLZQaP
X-Received: by 10.55.16.139 with SMTP id 11mr3637939qkq.226.1474570403188;
        Thu, 22 Sep 2016 11:53:23 -0700 (PDT)
Received: from LykOS.nyu.edu (NYUFWA-WLESSAUTHCLIENTS-19.NATPOOL.NYU.EDU. [216.165.95.8])
        by smtp.gmail.com with ESMTPSA id m87sm1675117qkl.21.2016.09.22.11.53.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Sep 2016 11:53:22 -0700 (PDT)
From:   santiago@nyu.edu
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, sunshine@sunshineco.com,
        walters@verbum.org, Santiago Torres <santiago@nyu.edu>
Subject: [RFC/PATCH 0/6]  Add --format to tag verification
Date:   Thu, 22 Sep 2016 14:53:11 -0400
Message-Id: <20160922185317.349-1-santiago@nyu.edu>
X-Mailer: git-send-email 2.10.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Santiago Torres <santiago@nyu.edu>

Hello everyone,

This is a followup on [1]. There we discussed what would be the best way
to provide automated scripts with mechanisms to inspect the contents of
a tag upon verification.

We struggled a little bit with how to make this fit the current git
codebase in the best way. Specifically, we are not sure if adding the
GPG_QUIET flags and/or exposing the primitives to allocate individual
git_ref_item's would be the best way forward.

This applies on the current HEAD as well as v 2.9.10.

Thanks!
-Santiago.

P.S. Gmane seems to be broken for git after it was rebooted. Should we ping
them about it?

[1] http://lists-archives.com/git/869122-verify-tag-add-check-name-flag.html

Lukas P (4):
  gpg-interface: add GPG_VERIFY_QUIET flag
  ref-filter: Expose wrappers for ref_item functions
  tag: add format specifier to gpg_verify_tag
  builtin/tag: add --format argument for tag -v

Santiago Torres (2):
  builtin/tag: move format specifier to global var
  builtin/verify-tag: Add --format to verify-tag

 builtin/tag.c        | 33 +++++++++++++++++++++------------
 builtin/verify-tag.c | 17 ++++++++++++++---
 gpg-interface.c      |  3 +++
 gpg-interface.h      |  1 +
 ref-filter.c         | 20 ++++++++++++++++++++
 ref-filter.h         | 10 ++++++++++
 tag.c                | 14 ++++++++++++--
 tag.h                |  4 ++--
 8 files changed, 83 insertions(+), 19 deletions(-)

-- 
2.10.0

