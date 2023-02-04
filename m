Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF177C636CC
	for <git@archiver.kernel.org>; Sat,  4 Feb 2023 20:41:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230393AbjBDUlb (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 4 Feb 2023 15:41:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbjBDUla (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Feb 2023 15:41:30 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B12F22915A
        for <git@vger.kernel.org>; Sat,  4 Feb 2023 12:41:29 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id c4-20020a1c3504000000b003d9e2f72093so8280870wma.1
        for <git@vger.kernel.org>; Sat, 04 Feb 2023 12:41:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xAlR6zgAaqg7wNrJAH59E2eU6ndLy3tnH2fcLJGchOE=;
        b=HPrKaemUqIqfLfURFgc8lYj5BwOHgaeu+XNP0mTNpLszxOxUj9/zF2pWZRWb+Fwdm9
         oDbG4nz6bZPjbpzLS41s9RoAyIjvsuokV52KFIK7ux4nw94J/uethGm1yYKMzjxQ16YB
         YkLNvhNymQ/ifa6S7JA7Wf+WVg3zMG/HaMr/CVScxJzP23lApKbq1U8laUN7R/fU2P70
         huU+AuKNc+ZBxdmDY1uY5FPTe32n0NE1YIrCgzOla8AkL7HR/gbuHojoD/qWb4o8XFj6
         HtXZUvYkCf6KgiiH3V2nxp3o4GisfN89roYxk7eeyv7IWggPvQIgTLN4Z7Vv1sZmHxPW
         HKNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xAlR6zgAaqg7wNrJAH59E2eU6ndLy3tnH2fcLJGchOE=;
        b=kRUu+JsyjqZdUDMZgR/kK0pWSNwDzYsYBRLWrW1TCzF84AYgcMGefOy26dZ7IvS0F2
         kb71CZwuB93t/RgJFoDC6TVtC2N3QxQNKOMVXZfuMLUiZ7fAG8HkwTWWbtbHzuaqLaRo
         Ye82m7rHqoIpkWN5SPCAGP5KD5Q4ikschQBbn0a0SMh3ZIo5z6jTX2AG8JeefeQpgTPo
         k9sBmKlgCNsY3fUV2DZFN/hnqrZf+XF2dbEVDGDS4zqIrfzY9QsYlnGgyfEjxnN5/wgl
         R/jfAd5nSKilAJ6CwDGIHYPBzLgE+z5U8TiuBsr1FHeB/PNxRZje1RjgMdnwjlQDT0BR
         g66A==
X-Gm-Message-State: AO0yUKV0OZmZEUgWLxDf5YqpgzJm/v/P1/m5Fs1A92Wg54i3iqVG+T33
        bFXQ8ApeDEG9ELl1SUk5OdHtWRyXIQJ8/11V
X-Google-Smtp-Source: AK7set/FXdQ1DtxsOXywJqdiO6bH2zKYTqBve064X715q90/3X+OQyXu2sRlQH7en6BAEie5yWSSyw==
X-Received: by 2002:a05:600c:314a:b0:3df:ee43:860b with SMTP id h10-20020a05600c314a00b003dfee43860bmr4918288wmo.23.1675543286878;
        Sat, 04 Feb 2023 12:41:26 -0800 (PST)
Received: from localhost.localdomain (cpc93780-hari17-2-0-cust124.20-2.cable.virginm.net. [77.98.244.125])
        by smtp.gmail.com with ESMTPSA id j10-20020a05600c1c0a00b003dd1c45a7b0sm7080068wms.23.2023.02.04.12.41.26
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 04 Feb 2023 12:41:26 -0800 (PST)
From:   Kostya Farber <kostya.farber@gmail.com>
To:     git@vger.kernel.org
Cc:     Kostya Farber <kostya.farber@gmail.com>
Subject: [PATCH] t5000: modernise archive and :(glob) test
Date:   Sat,  4 Feb 2023 20:41:24 +0000
Message-Id: <20230204204124.80741-1-kostya.farber@gmail.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

To match present day coding guiding codelines let's:

- use <<-EOF, so we can indent all lines to the
  the same level for this test

- use <<\EOF to notify the reader that no interpolation
  is exepected in the body

Signed-off-by: Kostya Farber <kostya.farber@gmail.com>
---
 t/t5000-tar-tree.sh | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/t/t5000-tar-tree.sh b/t/t5000-tar-tree.sh
index d473048138..eb3214bc17 100755
--- a/t/t5000-tar-tree.sh
+++ b/t/t5000-tar-tree.sh
@@ -402,11 +402,11 @@ test_expect_success GZIP 'extract tgz file (external gzip)' '
 
 test_expect_success 'archive and :(glob)' '
 	git archive -v HEAD -- ":(glob)**/sh" >/dev/null 2>actual &&
-	cat >expect <<EOF &&
-a/
-a/bin/
-a/bin/sh
-EOF
+	cat >expect <<-\EOF &&
+	a/
+	a/bin/
+	a/bin/sh
+	EOF
 	test_cmp expect actual
 '
 
-- 
2.39.0

