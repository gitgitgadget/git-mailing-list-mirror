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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 745DDC433E0
	for <git@archiver.kernel.org>; Thu, 21 May 2020 11:33:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 399DD2072C
	for <git@archiver.kernel.org>; Thu, 21 May 2020 11:33:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ibnIVxTm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729000AbgEULdd (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 May 2020 07:33:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728348AbgEULdc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 May 2020 07:33:32 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 762C2C061A0E
        for <git@vger.kernel.org>; Thu, 21 May 2020 04:33:32 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id m7so2722833plt.5
        for <git@vger.kernel.org>; Thu, 21 May 2020 04:33:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Z0A7xge/3cfhtEhyaWu8u1oCDS3WiAll0HQWRg2gQdU=;
        b=ibnIVxTmDnhV32EmkS7q4XbJ9SNerbbmVqyY1uUfWFnI41kwJFvY0pRIy9zEdi3/MK
         UwBB2OfL04kT8PtCvah74rTWE1jMv8nKLS5y6l/VgJI7PZhiCPsbNZaQQ3meFwi/kul8
         9BbB7GDXY41kmjojmvjp9VNMvHBZzNwxn5OWE4FPEfRd4O8sGW/BBT2EMjGu4twjXPRP
         6LzZ7LBf1Uc3ijraFVc7fL8Vx40GxJa+wglxLqPAA8uwqwJ+4Zq5EtC7ijkmf7wpOh1m
         7DZOqFQYTS//W6+mNTgoT78ThZCXbWfYG/7+5msFZfmAi1F7nUDur22ZW0zCzrpU/pnR
         cq0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Z0A7xge/3cfhtEhyaWu8u1oCDS3WiAll0HQWRg2gQdU=;
        b=f6RRVWf0Hf5qimQoB9uFDOm/xnC5TfkuugjDXo3VRQAyZRek/IqhqjbdfSkm2f35Tv
         HUCjqQtAGPuJFmnfEmvXriUDja5YeZ23+Zg3ynwj0RGKaJg0A7H6atlBzDSrOR3pm3pn
         QxCBo8FcZVpiHerYCRxebgpWSaz4vs+XCb337xEGynumgVQYew2o+OjzLQdYa9Jq1uJv
         ApdniWLJGT0Jue87nH6SqXiwpdv84iPu4Wo0tMPzOWn7FyOQ9zpVNah7tQM/F4LR3fFi
         kuItif0TSpCqaL75l+HV5AENZCXZqPZM8jnYb/0LPfEOcWg9J42QT98gI7b3WTdLnyzY
         75eA==
X-Gm-Message-State: AOAM5336ecWHPt5gQzfHW3nPL8bb1VVQWXSN0vAz1h9zayvtnv1GAj7d
        zbdxtrXW1xVIcVbh62nP5qw=
X-Google-Smtp-Source: ABdhPJzqCuaZxojiFLmYuvsQWx5Ztdc4dANTbU3yNMFbp/gtwuAxk/CjMi4xuJkxfrnKFiAzJrgiig==
X-Received: by 2002:a17:902:207:: with SMTP id 7mr8993176plc.331.1590060811353;
        Thu, 21 May 2020 04:33:31 -0700 (PDT)
Received: from localhost.localdomain ([47.89.83.2])
        by smtp.gmail.com with ESMTPSA id q7sm3852720pgs.13.2020.05.21.04.33.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 May 2020 04:33:30 -0700 (PDT)
From:   Jiuyang Xie <jiuyangxie@gmail.com>
X-Google-Original-From: Jiuyang Xie <jiuyang.xjy@alibaba-inc.com>
To:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
Cc:     Jiuyang Xie <jiuyang.xjy@alibaba-inc.com>,
        Denton Liu <liu.denton@gmail.com>
Subject: [PATCH v3] doc: fix wrong 4-byte length of pkt-line message
Date:   Thu, 21 May 2020 19:32:38 +0800
Message-Id: <20200521113238.37160-1-jiuyang.xjy@alibaba-inc.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200521112125.GA581643@generichostname>
References: <20200521112125.GA581643@generichostname>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The first four bytes of the line, the pkt-len, indicates the total
length of the pkt-line in hexadecimal. Fix wrong pkt-len headers of
some pkt-line messages in `http-protocol.txt` and `pack-protocol.txt`.

Reviewed-by: Denton Liu <liu.denton@gmail.com>
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

