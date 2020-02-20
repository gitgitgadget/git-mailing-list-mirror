Return-Path: <SRS0=QcP8=4I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B42EC5ACC4
	for <git@archiver.kernel.org>; Thu, 20 Feb 2020 01:59:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0080521D56
	for <git@archiver.kernel.org>; Thu, 20 Feb 2020 01:59:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Q1MX+Blk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727721AbgBTB7M (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Feb 2020 20:59:12 -0500
Received: from mail-pl1-f201.google.com ([209.85.214.201]:46375 "EHLO
        mail-pl1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727686AbgBTB7L (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Feb 2020 20:59:11 -0500
Received: by mail-pl1-f201.google.com with SMTP id t17so1314619plr.13
        for <git@vger.kernel.org>; Wed, 19 Feb 2020 17:59:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=cX0wSw+SUUTI4SBcSf/co+qSodXsGSCbZOly9kNlUfg=;
        b=Q1MX+BlkqltVVWuK+fZhbifnJlF5ERWRii38zRO6QGzQ5k+1J5n73hP4XLWSttLlwT
         6P8CJov5DBEeTQAz0M2vcrpq5zqsNeW6H98Xl2zB+CsWUBcWX2mcrBgUUCTAq5aF57jM
         f9zg0xRX//94vQVXOriFdDHZ3HKyoj8awJ19RyAQFANu0rZ8OTsY7mgi1PpDrkPBNM3i
         i5bUeuzoItiAO3fhJq4r7D16CCUAqjhY1I1p8tBgFNcVvPJnY8H+evzKgF3+YG7XLBaY
         MLi0puHIfmdLTS5L5FrRet3UjsSbTvOpxo88nTzDsP9cIy/g8G84+N/m/B909Xg9JbYK
         Ap8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=cX0wSw+SUUTI4SBcSf/co+qSodXsGSCbZOly9kNlUfg=;
        b=KWLx2Hmn8NeU9AmAmq/4mDBCJafm/b6k7ZE3TJui8FmslaXRlHamkVw+x58zzuIes+
         8zB/Jat4OiRbaahvgHyHsrBhL2F+Q+PfoLjG0PKRGoxdZW+yrZAnWYH4cjZC8TV9u048
         oOiAemvhsvgfUxfE0LjYqCJvUfed3z8IvpoRVE37fJaMNM8/Rqn43YRYnk4x39NDWZjK
         OxQ0AZsAHUDaxZ7KLOVTlWqAL0aNlID3S5vLX/pF7GOnKgNw638HSOfa/Qa9PyeTqcXM
         ZltGHJuPgBgUuQJEiC1JwB0AeEG9ZxH767rptqpQcaoMK2KDHnsOI+uSKnNwdRacNRM4
         GJ8Q==
X-Gm-Message-State: APjAAAVJ8CV9acR04kO3Jf4dgHUrcNRnUSrA7Zudk+iejDeCMYpiWVOV
        aWE2sC5gOLXUwziyAcZiFUclBAY1ULDq+Sp8MUCPlMpQG4uOjLpS+xbUaqHgpS/3gJnOaQ8EdH7
        YAc7zcX3LUkWsmFlLEJV47rHwE2C2VVcUFf+9rlXgF8rCJnq0pDxHpzmNDwJ1ik4YfEBnlG2kYw
        ==
X-Google-Smtp-Source: APXvYqxAnrirPr1iRDEYill5WY4t44S0YwVh4GGmyuOMT16mBQnVOss2jo5BMA3GJPyoVuMj37S6b9n9srCcX7XzdHA=
X-Received: by 2002:a63:4a58:: with SMTP id j24mr30839972pgl.166.1582163951179;
 Wed, 19 Feb 2020 17:59:11 -0800 (PST)
Date:   Wed, 19 Feb 2020 17:58:45 -0800
In-Reply-To: <20200220015858.181086-1-emilyshaffer@google.com>
Message-Id: <20200220015858.181086-3-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20200220015858.181086-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.25.0.265.gbab2e86ba0-goog
Subject: [PATCH v8 02/15] help: add shell-path to --build-options
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It may be useful to know which shell Git was built to try to point to,
in the event that shell-based Git commands are failing. $SHELL_PATH is
set during the build and used to launch the manpage viewer, as well as
by git-compat-util.h, and it's used during tests. 'git version
--build-options' is encouraged for use in bug reports, so it makes sense
to include this information there.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
---
 help.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/help.c b/help.c
index a21487db77..190722fb0a 100644
--- a/help.c
+++ b/help.c
@@ -654,6 +654,7 @@ int cmd_version(int argc, const char **argv, const char *prefix)
 			printf("no commit associated with this build\n");
 		printf("sizeof-long: %d\n", (int)sizeof(long));
 		printf("sizeof-size_t: %d\n", (int)sizeof(size_t));
+		printf("shell-path: %s\n", SHELL_PATH);
 		/* NEEDSWORK: also save and output GIT-BUILD_OPTIONS? */
 	}
 	return 0;
-- 
2.25.0.265.gbab2e86ba0-goog

