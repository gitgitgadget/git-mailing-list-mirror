Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9F544207BD
	for <e@80x24.org>; Wed, 26 Apr 2017 17:04:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752875AbdDZREB (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Apr 2017 13:04:01 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:33720 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752838AbdDZRD4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Apr 2017 13:03:56 -0400
Received: by mail-pf0-f194.google.com with SMTP id c198so1394040pfc.0
        for <git@vger.kernel.org>; Wed, 26 Apr 2017 10:03:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=MWFCyOMUuN4RdGRky42n2cJhZMTyq4TIsxpQ2uFduOM=;
        b=osk0rF7lS+XtsOkIcN0wDARvVPK/HHtU5IXFctX1oGstHdHaWCz3Rqujm2JWOJghNG
         voAJK6vxfuvAW+ILg8TtfTfJ2EDX1L9cXwWUeE/R+BAxNsnFtQHDRXHRUkMgW8hNUURb
         AP9eejCAMORa02NE+QjvblN7w5mQpA793zCS9YXd1tZSLmIHX4p25eHP15XTf8VgvuIJ
         nOfqCGsI16l/pRLmNmJVf8RDIdquilXhM0YhFD3nxh3XaxW42XscdV9BbxQVzzQx02/v
         B/Mghh6soq0gX5aJpfw+QyWAPse/vSWB68roCtzUoeoc2bI3hCoPdn6NSBkExRfy0lF1
         i9mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=MWFCyOMUuN4RdGRky42n2cJhZMTyq4TIsxpQ2uFduOM=;
        b=SVOt6RTucpqTFoBmGoyLPXQzjNYHV0MF4ZUUsnDNeToB+PwedGvBj0S1QzCaTm8+0o
         YOGtjsImxhNgUxtFPZQSKSu0WWg7W0LgsbQlntaZ+/7AP4zGW6uDC+4JDfURKSx/Jzcx
         +HJO/3YhLD7aYlfQ1TVSknUzrue3C8KmjwgdPV7qPiP+ElGSKSxsUbumuZQg8CoPO4kM
         nFkw2QeGymJ1QACUTZaLDzijbjo+pY1J1EmiWSaI1shAABkvojNiDpAtNQZi20njeKi1
         z/HZuyB5bj47bKHQw9LHZa/3sr09T7ZP8Le5FFsoQVpnzxsfjni5gO60wt4xwxijgsF+
         sf4w==
X-Gm-Message-State: AN3rC/5ValaVrZvlJSr5lN8ikcaq7UV0dEuRa9XQZJvoJHT9cg1IRtBT
        IRWAjDqQSocJuw==
X-Received: by 10.84.176.129 with SMTP id v1mr1048982plb.192.1493226230214;
        Wed, 26 Apr 2017 10:03:50 -0700 (PDT)
Received: from Daniels-MacBook-Pro.local.net (c-76-102-227-215.hsd1.ca.comcast.net. [76.102.227.215])
        by smtp.gmail.com with ESMTPSA id q70sm1376479pgq.45.2017.04.26.10.03.48
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Wed, 26 Apr 2017 10:03:49 -0700 (PDT)
From:   Daniel Ferreira <bnmvco@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, sbeller@google.com, pclouds@gmail.com,
        mhagger@alum.mit.edu, Daniel Ferreira <bnmvco@gmail.com>
Subject: [PATCH v11 0/5] [GSoC] remove_subtree(): reimplement using iterators
Date:   Wed, 26 Apr 2017 10:03:34 -0700
Message-Id: <1493226219-33423-1-git-send-email-bnmvco@gmail.com>
X-Mailer: git-send-email 2.7.4 (Apple Git-66)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is the eleventh version of a patch series that implements the GSoC
microproject of converting a recursive call to readdir() to use
dir_iterator.

v1: https://public-inbox.org/git/CAGZ79kZwT-9mHTiOJ5CEjk2wDFkn6+NcogjX0=vjhsAh16ANYg@mail.gmail.com/T/#t
v2: https://public-inbox.org/git/CACsJy8Dxh-QPBBLfaFWPAWUsbA9GVXA7x+mXLjEvYKhk1zOpig@mail.gmail.com/T/#t
v3: https://public-inbox.org/git/CAGZ79kYtpmURSQWPumobA=e3JBFjKhWCdv_LPhKCd71ZRwMovA@mail.gmail.com/T/#t
v4: https://public-inbox.org/git/1490747533-89143-1-git-send-email-bnmvco@gmail.com/T/#e437a63e0c22c00c69b5d92977c9b438ed2b9fd3a
v5: https://public-inbox.org/git/1490844730-47634-1-git-send-email-bnmvco@gmail.com/T/#m2323f15e45de699f2e09364f40a62e17047cf453
v6: https://public-inbox.org/git/1491107726-21504-1-git-send-email-bnmvco@gmail.com/T/#t
v7: https://public-inbox.org/git/1491163388-41255-1-git-send-email-bnmvco@gmail.com/T/#t
v8: https://public-inbox.org/git/a60b2ed6-2b99-b134-05af-7c8492a6949c@alum.mit.edu/T/#t
v9: https://public-inbox.org/git/CAGZ79kaBRS0SFAvrV4mN7-mVk+8QmPKPJMD55zPQ+A14ZzYFYA@mail.gmail.com/T/#me8988b7dd4adbc4ea24946ccb24fc1cf7baf44e3
v10: https://public-inbox.org/git/xmqqk26fahjn.fsf@gitster.mtv.corp.google.com/T/#m3071006ec67457adf69578b37f55b625d0e7fed7

Travis CI build: https://travis-ci.org/theiostream/git/builds/226079792

Okay, in this version I factored in Junio's request for a test rename
to t0066, and most of Michael's suggestions from the last review. I'm
sorry for the delay on this one.

Instead of either removing the iterate root dir feature or return NULL
as its basename, I chose to get the real_path() out of the dir we are
iterating over and get the basename of that, to avoid the "/." or "/.."
issues. I think this is actually less complex than the NULL solution in
terms of code that would end up needing to be written, and I think the
root dir feature is handy to have on dir-iterator.

As for the suggestion to put strerror() on the test, I feared for the
message compatibility across platforms (since we actually check which
errno code we got). If you could give me a guarantee that this is not a
problem and you think it'd be worthy of yet another series, I'm up for
it.

As for Junio's concern for a rebase issue on the test script, the
reason for it was that the same file is used across two tests, so it
seemed unnecessary to recreate the file within each of them.

Daniel Ferreira (5):
  dir_iterator: add tests for dir_iterator API
  remove_subtree(): test removing nested directories
  dir_iterator: refactor dir_iterator_advance
  dir_iterator: rewrite state machine model
  remove_subtree(): reimplement using iterators

 Makefile                        |   1 +
 dir-iterator.c                  | 244 ++++++++++++++++++++++++++++------------
 dir-iterator.h                  |  35 ++++--
 entry.c                         |  42 +++----
 refs/files-backend.c            |  15 ++-
 t/helper/.gitignore             |   1 +
 t/helper/test-dir-iterator.c    |  53 +++++++++
 t/t0066-dir-iterator.sh         | 121 ++++++++++++++++++++
 t/t2000-checkout-cache-clash.sh |  11 ++
 9 files changed, 416 insertions(+), 107 deletions(-)
 create mode 100644 t/helper/test-dir-iterator.c
 create mode 100755 t/t0066-dir-iterator.sh

--
2.7.4 (Apple Git-66)

