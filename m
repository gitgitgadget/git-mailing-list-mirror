Return-Path: <SRS0=9X1Y=5T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2068FC2BA17
	for <git@archiver.kernel.org>; Fri,  3 Apr 2020 10:28:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E83C72073B
	for <git@archiver.kernel.org>; Fri,  3 Apr 2020 10:28:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NsPDG2ZX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390577AbgDCK2i (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Apr 2020 06:28:38 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:42216 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727774AbgDCK2i (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Apr 2020 06:28:38 -0400
Received: by mail-pl1-f195.google.com with SMTP id e1so2536582plt.9
        for <git@vger.kernel.org>; Fri, 03 Apr 2020 03:28:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ONtu0eJ4Cx3U0vY50kjQSwSUjXpng4JZjD4zZdgCI1M=;
        b=NsPDG2ZXIXZm8tWob7vJ8VKdOm3oLhg/f3Ha7z3pWHRhnMqEE9CnaSBSjje0txF3zh
         deJm6TvN3O80VmetPOKQDnGce8HgOjLzexVL1YoZEyyS4FkevYXfpqUaqurtYxbm+WsV
         gKF6vK8SLBUvT3xfTHvpAHie4EdaXHYESd/N1QW5RIsJerZVT9iCs6j4kD3EBW9qB6zO
         /XVRC2mrdKLWa0n6e3v1VrvDNld5Yj5TKTzP6t/C1oaq4/OqY8lVCCnUxkugSlwkG28u
         /Ftaliv2RutE9TbIOSrklFVSxtncjqeBYJQa+3Q0oJ+neKAs3tGQ2fRwUKeGQOzv5MQr
         46mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ONtu0eJ4Cx3U0vY50kjQSwSUjXpng4JZjD4zZdgCI1M=;
        b=PPlNmEyPv2ATnAR9lARRJmpXjzASbmVQ6qQbCzDpfazenhTHiF5BfFHO0k1R76uVBg
         FerZ1ZZr6S/V/a/tt/uLHkv5tf55N/D3jrhz3l2SZUcMp8yFfmlAGrkXaUSuHBsYhjCt
         /QJDHEmKcLkUHF8+1/fZy1eZOp/5ztLagIA8OS9BurOQn63t+OcIrDHbBkhF98WFgmsU
         sMCCw1uyOtCliOWMMmCwZEggevUydaYxKVfHoIW4dusAgJnY6UbVBwqg6r8/gjuwxtFi
         CjBJwZU+zOiswAXDa/nc4D1ydcp1v0Ow+cuEXFnu/dRRwo8H1+Gi0cfANUWA9OZsqziR
         lETA==
X-Gm-Message-State: AGi0PubKkp0mIcKpp2dbybrqM9DeC/JX/iW77vaH1uBDJS4vfXTeJpL4
        O4cwIUV3Q2B37DbO78yxOLABTkL6
X-Google-Smtp-Source: APiQypII7EmsU8b/6ReIDqJa/aRCe9IIjK7WnDt4PGz9xrG3qnlNER1flen1ubBVfdF14d70Z0wjWQ==
X-Received: by 2002:a17:90a:10c1:: with SMTP id b1mr9131239pje.142.1585909716960;
        Fri, 03 Apr 2020 03:28:36 -0700 (PDT)
Received: from localhost.localdomain ([2402:800:6375:207b:be21:746a:7a56:9d4d])
        by smtp.gmail.com with ESMTPSA id c21sm4958126pgn.84.2020.04.03.03.28.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 Apr 2020 03:28:36 -0700 (PDT)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
Subject: [PATCH v3 3/6] Documentation: document am --no-gpg-sign
Date:   Fri,  3 Apr 2020 17:28:04 +0700
Message-Id: <340374fb68e6b442c2ab4ceb50c49ae0471fd240.1585909453.git.congdanhqx@gmail.com>
X-Mailer: git-send-email 2.26.0.334.g6536db25bb
In-Reply-To: <cover.1585909453.git.congdanhqx@gmail.com>
References: <20200331064456.GA15850@danh.dev> <cover.1585909453.git.congdanhqx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
---
 Documentation/git-am.txt | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-am.txt b/Documentation/git-am.txt
index ab5754e05d..38c0852139 100644
--- a/Documentation/git-am.txt
+++ b/Documentation/git-am.txt
@@ -148,9 +148,12 @@ default.   You can use `--no-utf8` to override this.
 
 -S[<keyid>]::
 --gpg-sign[=<keyid>]::
+--no-gpg-sign::
 	GPG-sign commits. The `keyid` argument is optional and
 	defaults to the committer identity; if specified, it must be
-	stuck to the option without a space.
+	stuck to the option without a space. `--no-gpg-sign` is useful to
+	countermand both `commit.gpgSign` configuration variable, and
+	earlier `--gpg-sign`.
 
 --continue::
 -r::
-- 
2.26.0.334.g6536db25bb

