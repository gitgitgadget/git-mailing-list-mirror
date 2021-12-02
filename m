Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A171FC433EF
	for <git@archiver.kernel.org>; Thu,  2 Dec 2021 22:32:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238803AbhLBWfa (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Dec 2021 17:35:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231240AbhLBWfa (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Dec 2021 17:35:30 -0500
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 430CCC06174A
        for <git@vger.kernel.org>; Thu,  2 Dec 2021 14:32:07 -0800 (PST)
Received: by mail-il1-x133.google.com with SMTP id i9so941938ilu.1
        for <git@vger.kernel.org>; Thu, 02 Dec 2021 14:32:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1EM7ljFaNPl8Yh4jJEKkNZLiEa6tgRC6U4QrJ/A9z7E=;
        b=kkq1xWzGCFV5J5buCXk85d8cec9rRIS/y6VimbYvdqrAWX5KloFOQ6Hy4wlgsK0NxW
         oJ0e99aasFFQp3jDBwLTIs/l/cRkyQEi4dAcH2qv6zBTRlZ277cHl4xDilbw2PCH6KJk
         ijWNm2yXfJVjVq6LDrYNFb5HQ0RusgsJ5GHVzTLHMpbgmo+0xjdakkUeOzvOHC09UETs
         Iw6j057xsarAkbgD6ZQZ7LMGd9qKDMvufWLuZtygeiSUJ2p5wgSwX2HfDh93eWgTgHQf
         0kSaR2Er0LOb+1w8xfYqnNVS4uesdaQpVvSTHAaYk8aTIw4ms72QwIunKaBQWoYcrInv
         aU/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=1EM7ljFaNPl8Yh4jJEKkNZLiEa6tgRC6U4QrJ/A9z7E=;
        b=D1g9C+vkkyslHSOYcUj6hlplq0ylLlggiWLtOqEQa0auTOmc0zt/YlbO75lisOSQSD
         9+Zp/8QfNA8nUkKLc9JLYxh8Epa1JvG5r8BiftgpNcEcVBP3kS2IhjVfHCsiW6T2umUO
         hhTJMmG5NznvNIjtMiYH2Y0OHW8srco5hr1dwQWUxRbmAow3mNg2IWqjjrxyWINShlQ8
         txQE1REn8VmNjiIfG/RRrBBA+veVPzDOy2ZcNN8bq7Ok/9WteDEx3Ylu8oyCtmYRfmSe
         VQLanNdpdugyQuYTQd3ncaNhKJoyNslVVv5nmG2yD+UGel6WmkC/V4j8V1m0HX7A8Nu0
         daow==
X-Gm-Message-State: AOAM53351dQHn9vnRm+2GIgSP8jq7PkWsNbQTg6bBgF7oY1dVYgKWm32
        QNg7FyWIPZQfScml7uS4w8plhcLuLE34SA==
X-Google-Smtp-Source: ABdhPJz8kesyUuwBEzEduX9FqYz9fYR8Y9mgZf9D5+vz5chhb1A2E9V0hzUL/UYOICgdsOc9lfgADQ==
X-Received: by 2002:a05:6e02:1c02:: with SMTP id l2mr18719176ilh.0.1638484326271;
        Thu, 02 Dec 2021 14:32:06 -0800 (PST)
Received: from localhost.localdomain (097-069-216-153.res.spectrum.com. [97.69.216.153])
        by smtp.gmail.com with ESMTPSA id y21sm524811ioj.41.2021.12.02.14.32.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Dec 2021 14:32:05 -0800 (PST)
Sender: Eric Sunshine <ericsunshine@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Randall Becker <rsbecker@nexbridge.com>,
        Baruch Burstein <bmburstein@gmail.com>,
        Fabian Stelzer <fs@gigacodes.de>,
        Philip Oakley <philipoakley@iee.email>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2] CodingGuidelines: document which output goes to stdout vs. stderr
Date:   Thu,  2 Dec 2021 17:31:10 -0500
Message-Id: <20211202223110.22062-1-sunshine@sunshineco.com>
X-Mailer: git-send-email 2.34.1.173.g76aa8bc2d0
In-Reply-To: <20211201053214.2902-1-sunshine@sunshineco.com>
References: <20211201053214.2902-1-sunshine@sunshineco.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It has long been practice on this project for a command to emit its
primary output to stdout so that it can be captured to a file or sent
down a pipe, and to emit "chatty" messages (such as those reporting
progress) to stderr so that they don't interfere with the primary
output. However, this practice is not necessarily universal; another
common practice is to send only error messages to stderr, and all other
messages to stdout. Therefore, help newcomers out by documenting how
stdout and stderr are used on this project.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---

Changes since v1[*]:

* tone down the commit message (peff)

* replace "command" in the patch body with "Git command" in a few places
  to make it more clear that the new "Program Output" section is
  providing guidelines for how Git commands should behave, as opposed
  to, say, how stdout/stderr should be used in test scripts (fabian)

No interdiff/range-diff since they are too noisy in this case, and the
patch is short enough to easily re-read in its entirety.

[*]: https://lore.kernel.org/git/20211201053214.2902-1-sunshine@sunshineco.com/

 Documentation/CodingGuidelines | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
index 711cb9171e..0e27b5395d 100644
--- a/Documentation/CodingGuidelines
+++ b/Documentation/CodingGuidelines
@@ -499,6 +499,33 @@ For Python scripts:
  - Where required libraries do not restrict us to Python 2, we try to
    also be compatible with Python 3.1 and later.
 
+
+Program Output
+
+ We make a distinction between a Git command's primary output and
+ output which is merely chatty feedback (for instance, status
+ messages, running transcript, or progress display), as well as error
+ messages. Roughly speaking, a Git command's primary output is that
+ which one might want to capture to a file or send down a pipe; its
+ chatty output should not interfere with these use-cases.
+
+ As such, primary output should be sent to the standard output stream
+ (stdout), and chatty output should be sent to the standard error
+ stream (stderr). Examples of commands which produce primary output
+ include `git log`, `git show`, and `git branch --list` which generate
+ output on the stdout stream.
+
+ Not all Git commands have primary output; this is often true of
+ commands whose main function is to perform an action. Some action
+ commands are silent, whereas others are chatty. An example of a
+ chatty action commands is `git clone` with its "Cloning into
+ '<path>'..." and "Checking connectivity..." status messages which it
+ sends to the stderr stream.
+
+ Error messages from Git commands should always be sent to the stderr
+ stream.
+
+
 Error Messages
 
  - Do not end error messages with a full stop.
-- 
2.34.1.173.g76aa8bc2d0

