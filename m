Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 33099211B3
	for <e@80x24.org>; Mon,  3 Dec 2018 23:37:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725996AbeLCXhp (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Dec 2018 18:37:45 -0500
Received: from mail-qt1-f202.google.com ([209.85.160.202]:45564 "EHLO
        mail-qt1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725938AbeLCXho (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Dec 2018 18:37:44 -0500
Received: by mail-qt1-f202.google.com with SMTP id w1so15015876qta.12
        for <git@vger.kernel.org>; Mon, 03 Dec 2018 15:37:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=RKCDh15FFQQl4615vJpCv81qaqHgzcJ1A6vx+oiVJrE=;
        b=Y8/wGJDUNKN0WW+XxynprrfA5dz/Ikm2IwSHQ1iNZR/LMybcyEvMZ24u6Y+QS/7hPy
         FF0+nr3xhbso5rKPQeHvsa7NInUby4MZMcaYMFWbeISJTljl3HUtFGkR3atWDhEI1BuE
         9bBb3SRNoofq3/icb32tesWCxuG+9OIXxO6i8GVt+ETDcI1w7BCjhYk8Rgbwb4GXD8pm
         Q6BkXa9SMdve3yUXO7ePNaHgyEipnGh85ZEiznGHVwrIw75EfiLu0tyHeteK7evQxmxS
         A/l+2luQ/Bnj4sv38s2o2AHGWHHIupe2cn9rcM/5dokUcvnz8cDch/x3csq7HfvJ0+ln
         nHGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=RKCDh15FFQQl4615vJpCv81qaqHgzcJ1A6vx+oiVJrE=;
        b=bv8p2UrMUOOms+pXZUkzmby/ocDuYr8RrMek2YVi9zan3fyHtooKv5R6oo0RsQuf07
         8aLSKmFpMVf4axVTj43zshQdT+ECgPH1TR5o71gGroYajqRMIYQe8CFgmrX57mLuEjVV
         Ui1sozqDy+5jpciNRKcLw3JMkriq14oJHUjw6dk7FSUTtkDn0PsLs9id5S5bmpRbqMPP
         qF+56gsg9TPh9169+EiPQgEG2Kwjq3rpWoMm3JwiJlPbULLzH7d1rN/+aCHO+ukh/42P
         0yA00BLm+FS2tLXLmJPjF8d2kRDP1fMqOmTofYtf8s79+PxA+NS/HHaxs9011WqddphP
         A81w==
X-Gm-Message-State: AA+aEWanim3OK8abQITVSq/ALTKaiuQOD+gJozcIB0D711Kl0uT+g1eg
        k+KI+gf5ociReuJYSUqVD7OToYMAOfFSz8MEaP9IyZS+Zbpp7uF2B79IMf1vOtgFoiibSMPkuJK
        UGiNPcjbDFjFryoV9iHLd2FJ+Yvftv1bPRoDGUNVJZB/TyZ3CkiSnN7PNT2hZTh7WI/UJ11LZT7
        sk
X-Google-Smtp-Source: AFSGD/Usry7JANzyQlwzHR2Mglb9hwCjEHrDUiHROYw9ey3kBYEabubmcYFrlF3PHRGScIGuvgS1T4+KERlWpTSKDeqR
X-Received: by 2002:a0c:879a:: with SMTP id 26mr13638770qvj.62.1543880263605;
 Mon, 03 Dec 2018 15:37:43 -0800 (PST)
Date:   Mon,  3 Dec 2018 15:37:33 -0800
Message-Id: <cover.1543879256.git.jonathantanmy@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.19.0.271.gfe8321ec05.dirty
Subject: [WIP RFC 0/5] Design for offloading part of packfile response to CDN
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Some of us have been working on a design to improve the scalability of
Git servers by allowing them to offload part of the packfile response to
CDNs in this way: returning HTTP(S) URIs in fetch responses in addition
to packfiles.

This can reduce the load on individual Git servers and improves
proximity (by having data served from closer to the user).

I have included here a design document (patch 2) and a rough
implementation of the server (patch 5). Currently, the implementation
only allows replacing single blobs with URIs, but the protocol
improvement is designed in such a way as to allow independent
improvement of Git server implementations.

There is a potential issue: a server which produces both the URIs and
the packfile at roughly the same time (like the implementation in this
patch set) will not have sideband access until it has concluded sending
the URIs. Among other things, this means that the server cannot send
keepalive packets until quite late in the response. One solution to this
might be to add a feature that allows the server to use a sideband
throughout the whole response - and this has other benefits too like
allowing servers to inform the client throughout the whole fetch, not
just at the end.

Jonathan Tan (5):
  Documentation: order protocol v2 sections
  Documentation: add Packfile URIs design doc
  upload-pack: refactor reading of pack-objects out
  upload-pack: refactor writing of "packfile" line
  upload-pack: send part of packfile response as uri

 Documentation/technical/packfile-uri.txt |  83 +++++++++++++
 Documentation/technical/protocol-v2.txt  |  22 ++--
 builtin/pack-objects.c                   |  48 ++++++++
 fetch-pack.c                             |   9 ++
 t/t5702-protocol-v2.sh                   |  25 ++++
 upload-pack.c                            | 150 ++++++++++++++++-------
 6 files changed, 285 insertions(+), 52 deletions(-)
 create mode 100644 Documentation/technical/packfile-uri.txt

-- 
2.19.0.271.gfe8321ec05.dirty

