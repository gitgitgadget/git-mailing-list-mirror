Return-Path: <SRS0=Ny9l=7D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5793C433DF
	for <git@archiver.kernel.org>; Thu, 21 May 2020 10:42:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 80D47206F6
	for <git@archiver.kernel.org>; Thu, 21 May 2020 10:42:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ThC1LtwU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727844AbgEUKmW (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 May 2020 06:42:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727013AbgEUKmV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 May 2020 06:42:21 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D51F0C061A0E
        for <git@vger.kernel.org>; Thu, 21 May 2020 03:42:21 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id t8so745458pju.3
        for <git@vger.kernel.org>; Thu, 21 May 2020 03:42:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ohL3gOUtzZtABuDWMXYIktH0vDtGJXQ7sdWz14T9aSM=;
        b=ThC1LtwUJTDu0iyVNOvXc6G2beaaNzd3LbtLhIfOAbnr3yAq6fa2JgUcVNgKT+MdTa
         ShMvNNJyAzJIMNYlIkiroEGExh5Ygc6QbVATOjF5wI1VvZojAFKrZxaqcZoUsAaPEXtZ
         H19cNDyN8IZu8T2oJvVXGdMFp17zPqqMIusixLeD2BJfGWA29vjJpH1qNsEzqvGlMx+M
         g0iTzfQuI9RdijT7xwiL5JTeR9LcbncFobju5Af+laC/1w4V7CnLbQqS9A+5UVpI1YaN
         ccKKKdbPr5NwiJJ7urDtd4rAw61LBffiy2IUa2sE5XZ3ESzS8GKfdzXEMN8+gXUD13d4
         WSCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ohL3gOUtzZtABuDWMXYIktH0vDtGJXQ7sdWz14T9aSM=;
        b=L3xulBsnSEoC8ZbtyN7AT+uIMtWh4YsJM2L+9dLbgudl7gJd5LftdbGdlSSp2vHu18
         fEJL9qKTRc1sPW75d8nofux2p/wgRr4xkuNWOIDrl+MQ/mQWERQ2J+uPZbkuHENGkr0B
         ntAuTtodyYAE0Amr10PEmB+iJAd4L+omheORx1qF8OjBgfXC0iUrhJQhxxckl+0P40kd
         8oYQ5WV2KAdUz3ycNGJIgTTagByE1F2ueRAkYrTBLb9E7DSUT8BRW/58lls5VSa1V+88
         rLuMQ82xzu7w1E6y10EMOQNJACM8nqfzDDnYkSfRh7G2IY9A1JIMJW+OeHz4993doIAf
         E1vA==
X-Gm-Message-State: AOAM530AY1HuUhBPg9wcEiTPOnCxAxqFiaEdlXlYq4JquMDZh4MD9jwO
        o5z882wo+dyyUEnSx+GLM5w=
X-Google-Smtp-Source: ABdhPJyT5XI0Z6kT4QceXaOTloMw7XgXVBd9lVsmeR9fYFbkFMa2TSrKQK0LZz1VwV7bIEaFFwbW3w==
X-Received: by 2002:a17:90a:2327:: with SMTP id f36mr9791366pje.220.1590057741325;
        Thu, 21 May 2020 03:42:21 -0700 (PDT)
Received: from localhost.localdomain ([47.89.83.2])
        by smtp.gmail.com with ESMTPSA id y14sm4263893pfr.11.2020.05.21.03.42.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 May 2020 03:42:20 -0700 (PDT)
From:   Jiuyang Xie <jiuyangxie@gmail.com>
X-Google-Original-From: Jiuyang Xie <jiuyang.xjy@alibaba-inc.com>
To:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
Cc:     Jiuyang Xie <jiuyang.xjy@alibaba-inc.com>,
        Denton Liu <liu.denton@gmail.com>
Subject: [PATCH v2] doc: fix wrong 4-byte length of pkt-line message
Date:   Thu, 21 May 2020 18:41:46 +0800
Message-Id: <20200521104146.36729-1-jiuyang.xjy@alibaba-inc.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200521094454.GA577071@generichostname>
References: <20200521094454.GA577071@generichostname>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The first four bytes of the line, the pkt-len, indicates the total
length of the pkt-line in hexadecimal. Fix wrong pkt-len headers of
some pkt-line messages in `http-protocol.txt` and `pack-protocol.txt`.

Reviewd-by: Denton Liu <liu.denton@gmail.com>
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

