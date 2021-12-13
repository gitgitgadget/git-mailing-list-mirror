Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E055C433F5
	for <git@archiver.kernel.org>; Mon, 13 Dec 2021 06:32:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232251AbhLMGcF (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Dec 2021 01:32:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232227AbhLMGcC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Dec 2021 01:32:02 -0500
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4514C061751
        for <git@vger.kernel.org>; Sun, 12 Dec 2021 22:32:01 -0800 (PST)
Received: by mail-io1-xd2d.google.com with SMTP id k21so17344733ioh.4
        for <git@vger.kernel.org>; Sun, 12 Dec 2021 22:32:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qavUlmxKqwwH50whFgJkIc5I+rxBkwSULiHgjSYOAqY=;
        b=cW6iigM5TJJrfRuVslyuR/JV6mVkh5UHypOo/ukWBi8LeDfQjxUMbFIRDbCqHY4Fa/
         M0oLlfgXjKeFKnPUJAdHFLWTKGq8jRbQ4RBcgbjNZniVqZOq5iYW35d5ACzHD2tcRQzd
         iEk5Mczm6fbXreFx7Peleg266eo5FwNo4qDrtNMBxfpsMKq7nfNn45IANwAY4QExFM6Q
         9OGfbazcQ8kcO2knhR75HH4eVfLf5ski0LprUpdhFx4dkfrjRd9YMqh7s4IZlCdhmVcy
         1/GDfsfuJlV6w0vb479gsK/lJ1HV5MtpdTdP8Htv0qm9QKjfqqXE+WKF4d2xfQ6h4mAA
         i6xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=qavUlmxKqwwH50whFgJkIc5I+rxBkwSULiHgjSYOAqY=;
        b=HqIHdr/LaZZYco5n/pVfnqY+mklvQ2sI48tQN53GIxQFMPQJrQ+n7SSbzCzMkLHVWX
         +6nyaNuHYCaPjTUt8fooRlkba0AQRYcwc0wNxgMXTC1P+PqN81aK/Bkn0g2b044mVPNw
         SSs10fQ5eKT4I5xEGZmr9LyqbQSlCFEKeypyLk0KZA+72w5dB6oY8On3zqrYopB6XU0+
         CjhhkWAJ/Kg7+MtfG1a7hCaJjnZXwvp8ORV/sV9wbGLXhMgXMV1zMH0baCfuvdyjJJJP
         YnIe2Qb3a2CNP0AbeZstZUi19VZE8pII0JEf6dReYhRQ+etLnc4UgQeuGJaV2ZQqLd0H
         YuuQ==
X-Gm-Message-State: AOAM5319N627iNMnlpVrQsaM2eE0h3FeF9julWxmcLGi7NPjQDk2ag88
        nw8cgs95+51bD8+eP7HIsQP5g2l8NTQ8XQ==
X-Google-Smtp-Source: ABdhPJwf7wf+LKiUYFioQYOKJydx9e27T2NqhkjfiXzcZCgcbhAwp7ujPL0JlZf7SPioj+khAWazpw==
X-Received: by 2002:a05:6638:300a:: with SMTP id r10mr30649900jak.91.1639377121087;
        Sun, 12 Dec 2021 22:32:01 -0800 (PST)
Received: from localhost.localdomain (097-069-216-153.res.spectrum.com. [97.69.216.153])
        by smtp.gmail.com with ESMTPSA id f10sm7305408ils.13.2021.12.12.22.32.00
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 12 Dec 2021 22:32:00 -0800 (PST)
Sender: Eric Sunshine <ericsunshine@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
        Fabian Stelzer <fs@gigacodes.de>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 04/15] t/chainlint/one-liner: avoid overly intimate chainlint.sed knowledge
Date:   Mon, 13 Dec 2021 01:30:48 -0500
Message-Id: <20211213063059.19424-5-sunshine@sunshineco.com>
X-Mailer: git-send-email 2.34.1.397.gfae76fe5da
In-Reply-To: <20211213063059.19424-1-sunshine@sunshineco.com>
References: <20211213063059.19424-1-sunshine@sunshineco.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The purpose of chainlint.sed is to detect &&-chain breakage only within
subshells (one level deep); it doesn't bother checking for top-level
&&-chain breakage since the &&-chain checker built into t/test-lib.sh
should detect broken &&-chains outside of subshells by making them
magically exit with code 117.

Unfortunately, one of the chainlint.sed self-tests has overly intimate
knowledge of this particular division of responsibilities and only cares
about what chainlint.sed itself will produce, while ignoring the fact
that a more all-encompassing linter would complain about a broken
&&-chain outside the subshell. This makes it difficult to re-use the
test with a more capable chainlint implementation should one ever be
developed. Therefore, adjust the test and its "expected" output to
avoid being specific to the tunnel-vision of this one implementation.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 t/chainlint/one-liner.expect | 2 +-
 t/chainlint/one-liner.test   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/chainlint/one-liner.expect b/t/chainlint/one-liner.expect
index 237f227349..c64058f7af 100644
--- a/t/chainlint/one-liner.expect
+++ b/t/chainlint/one-liner.expect
@@ -4,6 +4,6 @@
 
 ?!SEMI?!(foo; bar) &&
 ?!SEMI?!(foo; bar) |
-?!SEMI?!(foo; bar) >baz
+?!SEMI?!(foo; bar) >baz &&
 
 (foo "bar; baz")
diff --git a/t/chainlint/one-liner.test b/t/chainlint/one-liner.test
index 69796d7505..be9858fa29 100644
--- a/t/chainlint/one-liner.test
+++ b/t/chainlint/one-liner.test
@@ -6,7 +6,7 @@
 # LINT: top-level one-liner subshell missing internal "&&" and broken &&-chain
 (foo; bar) &&
 (foo; bar) |
-(foo; bar) >baz
+(foo; bar) >baz &&
 
 # LINT: ";" in string not misinterpreted as broken &&-chain
 (foo "bar; baz")
-- 
2.34.1.397.gfae76fe5da

