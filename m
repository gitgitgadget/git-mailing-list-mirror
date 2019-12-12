Return-Path: <SRS0=AaZj=2C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17580C43603
	for <git@archiver.kernel.org>; Thu, 12 Dec 2019 00:48:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2CC62173E
	for <git@archiver.kernel.org>; Thu, 12 Dec 2019 00:48:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LAgagrbw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727335AbfLLAsr (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Dec 2019 19:48:47 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:40562 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727224AbfLLAsq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Dec 2019 19:48:46 -0500
Received: by mail-pj1-f67.google.com with SMTP id s35so268844pjb.7
        for <git@vger.kernel.org>; Wed, 11 Dec 2019 16:48:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ToDz/RzpRtmQdwwBwLYXcI8ndIjo5fQMP2ZhH3kOLwU=;
        b=LAgagrbw6AbvgVzH5T4CfucpMZcvZQcmCRuAQDNk+ynODe6GWXr/qYPIyY50N0cS5B
         KGlUyTr7BN+vkjHdCz1fzKA8L4P007/AJqY8DarGLEVwhTRMQOCj3/qh/0TtJqX6xKm8
         7R/3hL192n5V9FV/zn09umRU1MHrRnwJU2vWugevXqteZ+NnnJpUBo+MnbOiOCVFFQI7
         08ezqAx2UyU/t90UKwBdggGAm2OgAxJe5H2UN2HQJUlMmPvNrAW/ZAYIWBxpIjeAjzTH
         yj6N+V7hrK72PzZuZ4WNcGck8qr5sxAs3lDP5unb3zDBhj9ihOIqvK13+LBIJJ2f/keR
         73XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ToDz/RzpRtmQdwwBwLYXcI8ndIjo5fQMP2ZhH3kOLwU=;
        b=hY5he8vffDN6prdXV4CIvKlXIIcxuAanGLLDYzySoN2bJXzT7vY/mCW1jsamJhGuoJ
         Ia3UtZFzrlq3258ttkEfVDkStXjPajpzU4K1xhEtPBmCTk4w+OzoDzlldibH7ni8CrdI
         aSmrtxTHR2Y8otmytJ6XdrtrnepPv38xoVHLP7H1ljc6llz1FPR3SDbztEpgDEkkXwPM
         /B6H6TVk82GwvtZkCmTnUo0sI9Ys1apr+pQAWvZQfst5s1/xxhPXHx3AYxAnkLGoqi09
         M7aAtLgpyNZLzd/xaqXcJFSAJh5xND/u6L3PTfMnEeUSHTAoXaX7+Jpgwt4prG6FHALz
         XH4w==
X-Gm-Message-State: APjAAAXbpaXgAXFmMro9+FNv1YLjlvPm7NSiWbe/4jER0PCIuXTHRe0l
        hw7wUcQNAxNbWE7oY/my3BaTPw/z
X-Google-Smtp-Source: APXvYqzO0zFPU9hMq6/L3XWm1ykNcg8LN0Q7bfT2P1AcWyyT552/F1K0fyRWld6jTVhD6YZl0gIlaQ==
X-Received: by 2002:a17:902:6b8c:: with SMTP id p12mr6221051plk.296.1576111725722;
        Wed, 11 Dec 2019 16:48:45 -0800 (PST)
Received: from generichostname ([204.14.239.53])
        by smtp.gmail.com with ESMTPSA id d2sm3534846pjo.32.2019.12.11.16.48.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2019 16:48:45 -0800 (PST)
Date:   Wed, 11 Dec 2019 16:49:47 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Elijah Newren <newren@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Philip Oakley <philipoakley@iee.email>
Subject: [PATCH 1/2] config/format.txt: clarify behavior of multiple
 format.notes
Message-ID: <af0991b2d7cd77fc077b31d4d67a556bcbd235fe.1576111643.git.liu.denton@gmail.com>
References: <cover.1576111643.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1576111643.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In 8164c961e1 (format-patch: use --notes behavior for format.notes,
2019-12-09), we slightly tweaked the behavior of having multiple
`format.notes` configuration variables. We did not update the
documentation to reflect this, however.

Explictly state the behavior of having multiple `format.notes`
configuration variables so users are clear on what to expect.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 Documentation/config/format.txt | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/Documentation/config/format.txt b/Documentation/config/format.txt
index 414a5a8a9d..3d708b0aec 100644
--- a/Documentation/config/format.txt
+++ b/Documentation/config/format.txt
@@ -99,4 +99,20 @@ If one wishes to use the ref `ref/notes/true`, please use that literal
 instead.
 +
 This configuration can be specified multiple times in order to allow
-multiple notes refs to be included.
+multiple notes refs to be included. In that case, it will behave
+similarly to multiple `--[no-]notes[=]` options passed in. That is, a
+value of `true` will show the default notes, a value of `<ref>` will
+also show notes from that notes ref and a value of `false` will negate
+previous configurations and not show notes.
++
+For example,
++
+------------
+[format]
+	notes = true
+	notes = foo
+	notes = false
+	notes = bar
+------------
++
+will only show notes from `refs/notes/bar`.
-- 
2.24.0.627.geba02921db

