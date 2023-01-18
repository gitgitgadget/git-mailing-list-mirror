Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B762CC32793
	for <git@archiver.kernel.org>; Wed, 18 Jan 2023 09:09:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230016AbjARJJf (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Jan 2023 04:09:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229969AbjARJIH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jan 2023 04:08:07 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B717B654C1
        for <git@vger.kernel.org>; Wed, 18 Jan 2023 00:28:05 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id v6so38332821ejg.6
        for <git@vger.kernel.org>; Wed, 18 Jan 2023 00:28:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LTFRHE4nNOj55jZmic8+esN0u8bW28+HYCRISAjIp6I=;
        b=cT0hC/7zznHaBdk1wSB1H6DCDOHLcjTR5Z0x9Zd8kUtldXAPKAX9riblsm+rOmS4OK
         cRGWWjwYfn2xGLIHxJJeiIUxCDBO2vIfttsRuHxgCP01AI0HM0AJwCxNKi6Y5itB3aCb
         qeNHM5KFu0RpYxmJ//pPYwvU2SRvU1IlwsfG2bxO80um7fy7Iiqdh39Tg4K5BG17qg33
         zpHM0Y6R+QuyAY3hxwiWj5SX7L8Kpq/Q4JNvrJlYcw/UIqYVo1BIN18N5fNW7fGV8gip
         ieEqZt0Vp7gx0jl3TszEfVFO5YdFORCkO/fhX1v6Hiy4wCzElMBAnZOFqhvY0QazbjVU
         NsIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LTFRHE4nNOj55jZmic8+esN0u8bW28+HYCRISAjIp6I=;
        b=zJo1q5lVFvTY0trGFfx91Ve+b0TogWOWqkI/3TAmOmMirA0k+IzX6FDGAzat9jkHER
         GtuZtW49TFPTFhyElb0PjUXZ8oSZl0Lg/AQMPUXqLfe/0e/evhPPtPQCYDu68fl7UdKk
         HipeTR4q6I9QKBZJFr075S6PwtvCWBucUm9S9tq2WGvaQ8ZHmSCX4wp2qBK86n+YPC9y
         KQH6Gpg+XQ+3FDheGcpcImZcifDIkB0zfn0CaCHVNMJX9DDZyVA8pwvmMGP9HjDkpwWe
         o1lvoblZNzYcZpWznG3RbKFKjgzgtrcZ2BpLY8d05XO9pN8Kbyh/0DJnVA/Ad4wk9UxH
         lOfQ==
X-Gm-Message-State: AFqh2koO1Iz5/TmTWa0cyjdnc+YH8IocCHB9/L/s4MUwhMmrY9mjpUGn
        aY7GBje36ogX7VF9dMzIVRvcS5gUnWrk6mtR
X-Google-Smtp-Source: AMrXdXuFcFZHdTaJaG0aKzqaHuTyZ85EPMiOKQ0bZ0FU1p//y/zRjvfK4Tf5o0/SZzhMWyi1SheMmw==
X-Received: by 2002:a17:907:9b06:b0:872:f259:a7ea with SMTP id kn6-20020a1709079b0600b00872f259a7eamr5961910ejc.53.1674030483091;
        Wed, 18 Jan 2023 00:28:03 -0800 (PST)
Received: from localhost.localdomain (78-67-21-133-no600.tbcn.telia.com. [78.67.21.133])
        by smtp.gmail.com with ESMTPSA id c23-20020a170906155700b007a9c3831409sm14237080ejd.137.2023.01.18.00.28.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 00:28:02 -0800 (PST)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Siddharth Asthana <siddharthasthana31@gmail.com>
Subject: [PATCH] git-cat-file.txt: fix list continuations rendering literally
Date:   Wed, 18 Jan 2023 09:27:49 +0100
Message-Id: <20230118082749.1252459-1-martin.agren@gmail.com>
X-Mailer: git-send-email 2.39.1.405.gd4c25cc71f
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

With Asciidoctor, all of the '+' introduced in a797c0ea04 ("cat-file:
add mailmap support to --batch-check option", 2022-12-20) render
literally rather than functioning as list continuations. With asciidoc,
this renders just fine. It's not too surprising that there is room for
ambiguity and surprises here, since we have lists within lists.

Simply replacing all of these '+' with empty lines makes this render
fine using both tools. Except, in the third hunk, where after this inner
'*' list ends, we want to continue with more contents of the outer list
item (`--batch-command=<format>`). We can solve any ambiguity here and
make this clear to both tools by wrapping the inner list in an open
block (using "--").

For consistency, let's wrap all three of these inner lists from
a797c0ea04 in open blocks. This also future-proofs us a little -- if we
ever gain more contents after any of those first two lists, as we did
already in a797c0ea04 for the third list, we're prepared and should
render fine with both asciidoc and Asciidoctor from the start.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 Documentation/git-cat-file.txt | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-cat-file.txt b/Documentation/git-cat-file.txt
index 830f0a2eff..411de2e27d 100644
--- a/Documentation/git-cat-file.txt
+++ b/Documentation/git-cat-file.txt
@@ -93,47 +93,52 @@ OPTIONS
 	Print object information and contents for each object provided
 	on stdin. May not be combined with any other options or arguments
 	except `--textconv`, `--filters`, or `--use-mailmap`.
-	+
++
+--
 	* When used with `--textconv` or `--filters`, the input lines
 	  must specify the path, separated by whitespace. See the section
 	  `BATCH OUTPUT` below for details.
-	+
+
 	* When used with `--use-mailmap`, for commit and tag objects, the
 	  contents part of the output shows the identities replaced using the
 	  mailmap mechanism, while the information part of the output shows
 	  the size of the object as if it actually recorded the replacement
 	  identities.
+--
 
 --batch-check::
 --batch-check=<format>::
 	Print object information for each object provided on stdin. May not be
 	combined with any other options or arguments except `--textconv`, `--filters`
 	or `--use-mailmap`.
-	+
++
+--
 	* When used with `--textconv` or `--filters`, the input lines must
 	 specify the path, separated by whitespace. See the section
 	 `BATCH OUTPUT` below for details.
-	+
+
 	* When used with `--use-mailmap`, for commit and tag objects, the
 	  printed object information shows the size of the object as if the
 	  identities recorded in it were replaced by the mailmap mechanism.
+--
 
 --batch-command::
 --batch-command=<format>::
 	Enter a command mode that reads commands and arguments from stdin. May
 	only be combined with `--buffer`, `--textconv`, `--use-mailmap` or
 	`--filters`.
-	+
++
+--
 	* When used with `--textconv` or `--filters`, the input lines must
 	  specify the path, separated by whitespace. See the section
 	  `BATCH OUTPUT` below for details.
-	+
+
 	* When used with `--use-mailmap`, for commit and tag objects, the
 	  `contents` command shows the identities replaced using the
 	  mailmap mechanism, while the `info` command shows the size
 	  of the object as if it actually recorded the replacement
 	  identities.
-
+--
 +
 `--batch-command` recognizes the following commands:
 +
-- 
2.39.0.348.g5efb778ab0

