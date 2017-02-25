Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 885FD201A9
	for <e@80x24.org>; Sat, 25 Feb 2017 01:19:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751474AbdBYBTP (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Feb 2017 20:19:15 -0500
Received: from mail-pg0-f50.google.com ([74.125.83.50]:34703 "EHLO
        mail-pg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751291AbdBYBTO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Feb 2017 20:19:14 -0500
Received: by mail-pg0-f50.google.com with SMTP id 1so18001823pgi.1
        for <git@vger.kernel.org>; Fri, 24 Feb 2017 17:18:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=kK4ob1Ek6IMa9h1b2nhoWoNoyhN41VHjxVchBPc/xq0=;
        b=VCzubIWJeVpWP8Y/6oR3uwc9xLOWRl6od6ZvLJyzPnStjxjk2VZ4j6/0pwJVMC9kac
         h5s9gSnBP/aGKLPR+lOw+vAoXb05YrfDHTTLFvNI2xr25mOv7tE8IiCL+I7w7rbaQAUy
         cIcTPElGB7q+vWPqrGBlKGKj+JjLhD/T/b97fDyyAhwcm+UPy4yv5AMzH8vqkq1PxEs4
         ddh17bIRQuTsRfipGhtN0Ih6IN0o7NRYOt5GUyqtaU0eAEn4Cs/FeCMLpQ7WNvv6uiCH
         eApPwnqyaBtbP5fGGcGcyM0Yx0Ugn/u/ujB89LNp6OcdItp/3gn15PUZ1Sy5/FBgP+Pj
         MN/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=kK4ob1Ek6IMa9h1b2nhoWoNoyhN41VHjxVchBPc/xq0=;
        b=qOf9DLIuUui2koYMf0qzetMpt2RQ4LzbTY60Z0PFLj4tPA7Wc+FJk0SNwAZ/TJTVEJ
         USkF5mPXh5O6jKPQ4Np/HdVLwMMBM63VvcSUOHzg+4pt4Rvvns2ee3L/yAQ6c81Gv3cz
         B9ND62qSKwiiiEVtPpGS8LvgtGzJhxrTIOC/HHgz1ES7ucFbFyBPhFtJzPpLnAKDmsJe
         Ud/PqxCFGexD0skgIi+5pVOSpiGKsgCYrkHADhYWh9Tm2Nj3A71rg5yPe02pd0NW+ISh
         LRhiD2bgZU/UIemk72f/1O7tW1eMNf1nLvh68Ie268KaXv0zirSevr+fRXCA02sf8RqD
         GG9A==
X-Gm-Message-State: AMke39lcG2uaEIWRf3UHvDcnC4wt1VPJelhKjfD1bINqZ9V2RPaO4PYk5L637jOAWEQx3Ikq
X-Received: by 10.84.224.7 with SMTP id r7mr8009149plj.179.1487985522522;
        Fri, 24 Feb 2017 17:18:42 -0800 (PST)
Received: from twelve2.mtv.corp.google.com ([100.96.238.13])
        by smtp.gmail.com with ESMTPSA id 67sm17082280pfd.120.2017.02.24.17.18.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 24 Feb 2017 17:18:41 -0800 (PST)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, gitster@pobox.com,
        peff@peff.net, peartben@gmail.com, benpeart@microsoft.com
Subject: [PATCH 0/3] Test fetch-pack's ability to fetch arbitrary blobs
Date:   Fri, 24 Feb 2017 17:18:35 -0800
Message-Id: <cover.1487984670.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.11.0.483.g087da7b7c-goog
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As stated in a previous e-mail [1], I was trying to think a way to allow
Git to fetch arbitrary blobs from another Git server, and it turned out
that fetch-pack already can. However, there were some bugs with blob
reachability. This patch set fixes those bugs, and verifies (with tests)
that fetch-pack can fetch reachable blobs and cannot fetch unreachable
blobs.

These patches are (I think) worthwhile on their own, but may be of
special interest to people who need Git to tolerate missing objects in
the local repo (for example, the e-mail discussion "[RFC] Add support
for downloading blobs on demand" [2]) because a way for Git to download
missing objects natively is (I think) a prerequisite to that.

[1] <20170223230358.30050-1-jonathantanmy@google.com>
[2] <20170113155253.1644-1-benpeart@microsoft.com>

Jonathan Tan (3):
  revision: unify {tree,blob}_objects in rev_info
  revision: exclude trees/blobs given commit
  upload-pack: compute blob reachability correctly

 bisect.c                 |  2 +-
 builtin/rev-list.c       |  6 ++--
 list-objects.c           |  4 +--
 pack-bitmap-write.c      |  3 +-
 pack-bitmap.c            |  3 +-
 reachable.c              |  3 +-
 revision.c               | 18 +++++-----
 revision.h               |  3 +-
 t/t5500-fetch-pack.sh    | 30 +++++++++++++++++
 t/t6000-rev-list-misc.sh | 88 ++++++++++++++++++++++++++++++++++++++++++++++++
 upload-pack.c            | 15 +++++++++
 11 files changed, 151 insertions(+), 24 deletions(-)

-- 
2.11.0.483.g087da7b7c-goog

