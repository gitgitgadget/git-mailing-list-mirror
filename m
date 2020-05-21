Return-Path: <SRS0=Ny9l=7D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEE38C433E0
	for <git@archiver.kernel.org>; Thu, 21 May 2020 07:56:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B40492065F
	for <git@archiver.kernel.org>; Thu, 21 May 2020 07:56:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KFeIUsfe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728487AbgEUH4v (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 May 2020 03:56:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728485AbgEUH4v (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 May 2020 03:56:51 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75924C061A0E
        for <git@vger.kernel.org>; Thu, 21 May 2020 00:56:51 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id y198so2967812pfb.4
        for <git@vger.kernel.org>; Thu, 21 May 2020 00:56:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9fVVnH5h2MpThakG5zQ7whjxBxlNxECNjgqd20/LrW8=;
        b=KFeIUsfePzPdaNwbne0uDU4AO9Xoh61MpBpFHxkvmJXgVLQpQFzAFu8QQbXi17j7jF
         YyVzVtszZSKupf4EHWTxSbYWh+ZLeBz/hj5FjnFszRh5wfCfaRR4xgOG9j/0c0avbghV
         NQfWpfxUEyXm2GTUrJbIFirCShS0U9GEH2qEdEOws5sq8E0t8er15h2qzTmch0uraLuE
         HGvVq1SF214n73wYGRWQcQxf5delk0JHs6p76YhGIk3Qm26DLqP3Elkku5ZkG+IXUOfw
         Aho7foBh6hXk4KN1vOw0khE2wp/rpshwTUPiDiNyaqav0/Q3yUoeAJDk6zwF/LsPlnTP
         sBcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9fVVnH5h2MpThakG5zQ7whjxBxlNxECNjgqd20/LrW8=;
        b=NmcJhPd4b8RfjPihUUh5n53ZsIH2G/Ff7dNtGe6BdVl7UKA7/lLNjwzsLcLYFDy/Hl
         dkT5g3so8eXYVFiAWiAeKABawB43Qw111UoqVc/X8Y7jczZlgpLrBxrMp+e3l1PT1u8C
         WAAcftIxEl8qS3rDQBB0i4eo9GzhRlmuu9b2PP8Z1WeAxyz55NmdGO4EN6XckZsLGwFD
         jQPs7h09JsX97pTP3+M+BQ3p323CbkckH8CSb9nQoGDayOye7Oi/pNIMXI1FreDCcrZd
         Mo5CYWBCoW/Pt1ZybdsIJm/mtUcX0UBysGbxyvcWgjh54vi6u0R+xc+ItvlEkTAArOm4
         eJfQ==
X-Gm-Message-State: AOAM530zNIg0rtfn2CZR01jg9JjUv8QQFXBXriQO+ZEZ0pjXflk10BtN
        7klDLILCO6jLY3GyZhMm1u4=
X-Google-Smtp-Source: ABdhPJxxWgXHo5021iRcE8vmWZjYppdUFseNt0tlz6KFBdT/utceCEe78QSRd9b1/ll4DecRm0b4vQ==
X-Received: by 2002:a63:cd51:: with SMTP id a17mr6908690pgj.99.1590047810957;
        Thu, 21 May 2020 00:56:50 -0700 (PDT)
Received: from localhost.localdomain ([47.89.83.2])
        by smtp.gmail.com with ESMTPSA id q4sm4146446pfu.42.2020.05.21.00.56.49
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 May 2020 00:56:50 -0700 (PDT)
From:   Jiuyang Xie <jiuyangxie@gmail.com>
X-Google-Original-From: Jiuyang Xie <jiuyang.xjy@alibaba-inc.com>
To:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
Cc:     Jiuyang Xie <jiuyang.xjy@alibaba-inc.com>
Subject: [PATCH] doc: fix wrong 4-byte length of pkt-line message
Date:   Thu, 21 May 2020 15:56:43 +0800
Message-Id: <20200521075643.35286-1-jiuyang.xjy@alibaba-inc.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The first four bytes of the line, the pkt-len, indicates the total
length of the pkt-line in hexadecimal.  Fixed wrong pkt-len headers of
some pkt-line messages in `http-protocol.txt` and `pack-protocol.txt`.

Signed-off-by: Jiuyang Xie <jiuyang.xjy@alibaba-inc.com>
---
 Documentation/technical/http-protocol.txt | 2 +-
 Documentation/technical/pack-protocol.txt | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/technical/http-protocol.txt b/Documentation/technical/http-protocol.txt
index 9c5b6f0fac..51a79e63de 100644
--- a/Documentation/technical/http-protocol.txt
+++ b/Documentation/technical/http-protocol.txt
@@ -216,7 +216,7 @@ smart server reply:
    S: 001e# service=git-upload-pack\n
    S: 0000
    S: 004895dcfa3633004da0049d3d0fa03f80589cbcaf31 refs/heads/maint\0multi_ack\n
-   S: 0042d049f6c27a2244e12041955e262a404c7faba355 refs/heads/master\n
+   S: 003fd049f6c27a2244e12041955e262a404c7faba355 refs/heads/master\n
    S: 003c2cb58b79488a98d2721cea644875a8dd0026b115 refs/tags/v1.0\n
    S: 003fa3c2e2402b99163d1d59756e5f207ae21cccba4c refs/tags/v1.0^{}\n
    S: 0000
diff --git a/Documentation/technical/pack-protocol.txt b/Documentation/technical/pack-protocol.txt
index d5ce4eea8a..a4573d12ce 100644
--- a/Documentation/technical/pack-protocol.txt
+++ b/Documentation/technical/pack-protocol.txt
@@ -96,7 +96,7 @@ Basically what the Git client is doing to connect to an 'upload-pack'
 process on the server side over the Git protocol is this:
 
    $ echo -e -n \
-     "0039git-upload-pack /schacon/gitbook.git\0host=example.com\0" |
+     "003agit-upload-pack /schacon/gitbook.git\0host=example.com\0" |
      nc -v example.com 9418
 
 
@@ -171,9 +171,9 @@ with a version number (if "version=1" is sent as an Extra Parameter),
 and a listing of each reference it has (all branches and tags) along
 with the object name that each reference currently points to.
 
-   $ echo -e -n "0044git-upload-pack /schacon/gitbook.git\0host=example.com\0\0version=1\0" |
+   $ echo -e -n "0045git-upload-pack /schacon/gitbook.git\0host=example.com\0\0version=1\0" |
       nc -v example.com 9418
-   000aversion 1
+   000eversion 1
    00887217a7c7e582c46cec22a130adf4b9d7d950fba0 HEAD\0multi_ack thin-pack
 		side-band side-band-64k ofs-delta shallow no-progress include-tag
    00441d3fcd5ced445d1abc402225c0b8a1299641f497 refs/heads/integration
-- 
2.25.0

