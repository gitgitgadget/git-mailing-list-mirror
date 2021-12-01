Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8223C433F5
	for <git@archiver.kernel.org>; Wed,  1 Dec 2021 05:33:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232977AbhLAFgo (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Dec 2021 00:36:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229971AbhLAFgm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Dec 2021 00:36:42 -0500
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D3A1C061574
        for <git@vger.kernel.org>; Tue, 30 Nov 2021 21:33:22 -0800 (PST)
Received: by mail-il1-x12d.google.com with SMTP id e8so23901704ilu.9
        for <git@vger.kernel.org>; Tue, 30 Nov 2021 21:33:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0tzh3U+E6nA4gcVhInkWVwPf7dfeCLdf/Rm4ayZxHyA=;
        b=V3SIewx7s/DrOqms7ezgKUx2mraXN+30jtQ++0td+NB382+gbefekO4l5FBZmPtMiu
         5tPkPEQmk6/vFPq06mx88O/URtwQb2mDk1uUU5x75Y567J/Z2T9tp0giC8u+PRaQEkbn
         h57evd36jXoZYKpF7nZ09FEug56od9OSwGta5wL4CdKuSs5Sj7msU5xc15WQFO1xQlgh
         PUpstY3sLEMlqMFnS9jxUti3G0xnnGpi/fSFAeUKLS+xICq7cRZbyxq2jFsSdX3N5os8
         92dZAxazmAMsLJ8ygJGWWDT2A8Ryv4YzD30RbgQMzjasLamTii8fyIHmmSy+XxEuO17G
         F0zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=0tzh3U+E6nA4gcVhInkWVwPf7dfeCLdf/Rm4ayZxHyA=;
        b=ACBrawSSembhCkis122DvhY1D1KlhPZPwStucSf6xJBPheu1gtfFnXzLgOy9AaglEC
         HM9Og9OlcA8TTBviU3qILKFibYqx6QEevE+FYPGL4edIBTdLua4W7X+ykQemBANCSVqT
         bNCTvu9na0AAnSvX/OG6CvzhqDkWkpvVhzfvoLJakcYVI41Vy4/IFmTwkGgaEHYLmhOC
         9zXwt266dCM9wyHIeMGLhdbCsxxWwf/R3S+NBY2SiN/w7DImEdXnCKvg5Je+1FvkjYLi
         b0HBIRzqBN+3zzC+FqyWees+dUPGQFPcibPAH5nh5M6/knBlhcsfwx2LLIJSt1H0AUO8
         V+sQ==
X-Gm-Message-State: AOAM530W1wA5pPsxQXpJiPtMz5ZjMDy5hsJsqu54DsBzEKtDyawgcb5F
        u1MEM4FEwhEbiYndvQwt3brrrNns8yhQDg==
X-Google-Smtp-Source: ABdhPJwBkCxIdcOTdTffGl/j74RsbIF723BteQa5+eFSkV51y7XIRSFO7N8LXKrMQ7N6spyDTGJovA==
X-Received: by 2002:a05:6e02:1d88:: with SMTP id h8mr6102190ila.138.1638336801250;
        Tue, 30 Nov 2021 21:33:21 -0800 (PST)
Received: from localhost.localdomain (097-069-216-153.res.spectrum.com. [97.69.216.153])
        by smtp.gmail.com with ESMTPSA id p7sm8461065ils.4.2021.11.30.21.33.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Nov 2021 21:33:20 -0800 (PST)
Sender: Eric Sunshine <ericsunshine@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Randall Becker <rsbecker@nexbridge.com>,
        Baruch Burstein <bmburstein@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH] CodingGuidelines: document which output goes to stdout vs. stderr
Date:   Wed,  1 Dec 2021 00:32:14 -0500
Message-Id: <20211201053214.2902-1-sunshine@sunshineco.com>
X-Mailer: git-send-email 2.34.1.75.gabe6bb3905
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It has long been practice in this project for a command to emit its
primary output to stdout so that it can be captured to a file or sent
down a pipe, and to emit "chatty" messages (such as those reporting
progress) to stderr so that they don't interfere with the primary
output. However, this idiomatic Unix practice is not necessarily
universally understood and may be at odds with other schools of thought,
such as the somewhat common one that only error messages should go to
stderr, and all other messages to stdout. Let's help newcomers by
documenting how stdout and stderr are used on this project.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 Documentation/CodingGuidelines | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
index 711cb9171e..44dd178dc9 100644
--- a/Documentation/CodingGuidelines
+++ b/Documentation/CodingGuidelines
@@ -499,6 +499,32 @@ For Python scripts:
  - Where required libraries do not restrict us to Python 2, we try to
    also be compatible with Python 3.1 and later.
 
+
+Program Output
+
+ We make a distinction between a command's primary output and output
+ which is merely chatty feedback (for instance, status messages,
+ running transcript, or progress display), as well as error messages.
+ Roughly speaking, a command's primary output is that which one might
+ want to capture to a file or send down a pipe; its chatty output
+ should not interfere with those use-cases.
+
+ As such, primary output should be sent to the standard output stream
+ (stdout), and chatty output should be sent to the standard error
+ stream (stderr). Examples of commands which produce primary output
+ include `git log`, `git show`, and `git branch --list` which generate
+ output on the stdout stream.
+
+ Not all commands have primary output; this is often true of commands
+ whose main function is to perform an action. Some action commands are
+ silent, whereas others are chatty. An example of a chatty action
+ commands is `git clone` with its "Cloning into '<path>'..." and
+ "Checking connectivity..." status messages which it sends to the
+ stderr stream.
+
+ Error messages are always sent to the stderr stream.
+
+
 Error Messages
 
  - Do not end error messages with a full stop.
-- 
2.34.1.75.gabe6bb3905

