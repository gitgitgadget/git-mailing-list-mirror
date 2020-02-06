Return-Path: <SRS0=KD4O=32=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFDF7C35247
	for <git@archiver.kernel.org>; Thu,  6 Feb 2020 00:41:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C02DC214AF
	for <git@archiver.kernel.org>; Thu,  6 Feb 2020 00:41:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cFfJehmE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727550AbgBFAl3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Feb 2020 19:41:29 -0500
Received: from mail-pf1-f202.google.com ([209.85.210.202]:36687 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727496AbgBFAl2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Feb 2020 19:41:28 -0500
Received: by mail-pf1-f202.google.com with SMTP id 6so2689368pfv.3
        for <git@vger.kernel.org>; Wed, 05 Feb 2020 16:41:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=LQKyEVtppS6PEntYcg7p2r4j5sdNP7kaZlvApuidwPQ=;
        b=cFfJehmEBXAo01ocNZjmwvXQV5jMil/FA7IsCOzqeOWX7YwiR+GnJGOKJCQydoFtB6
         ACAu870XZOqQlrPbzhBAEzo2Jb683OhYhmGcyWikP78sAYx8+Q26B/IjL4TbPZdERhIf
         nwFFPRh/J9KvEdp8PZVmI+Nm0KJ18S6FR39wvM0V5q4uO8CwbfE58Cy7ZeG8bkTeXj4u
         IzC0Pn0BIo+4w6sgC9jaH7JednCsfYXR7aWXrTClcwJw3kI4Y9WOIuMm0RCKqLw1NP5R
         6DqpSty1KWPkcdx31mwSWfwbHMItByBTt9kCASgHxqd1ZsbgXbshnvTusElSXCZ4pSZ0
         Qi/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=LQKyEVtppS6PEntYcg7p2r4j5sdNP7kaZlvApuidwPQ=;
        b=Pi1C3X2l4d3X5Ur5DkeKIuEgqmWsXAhRKMtxwUMjPs4Hl0dIhtk75roWov69/Yl/D4
         eUfhYE/7mDT9kZmUz6DDUo21YePyjGuIF4EusuwIviyTuIQjG/To2e2MWj8NBbygrD0x
         FcHYrnBpRT1nhxvfh63/Vw0Cl0QaaESJ7/yk0YJK/ViZhwBDUbcOLLlCGg50yhDt1Zpt
         1ikAfDTc3YH9/ZlX4kQ3vR8tWD6iPoQWq+raAd/L7kJpgTSjOcyKaB6L9oJ9dawf8kvB
         J2+tBBZVUK2qOWcw3JMJAGMeq6oY5eLF6+SqV72uDj40BoZr+VTu2T5dNLUAFAdvT6cf
         pF/Q==
X-Gm-Message-State: APjAAAVfDgTVvx8MyPOds2jhmkRNYTvRzyXwZw9loMV+6nTxDapzo8ov
        9uVYw9BJuYkUTIXYguz4VSN1yBRXYJDiwwC7o2Pz1Tm6JVXuPi6zbZHbBbzUMdAuiGzFmqxTfms
        9V++6FJ5bvoMoUzVhMh24Q5DsUbBJ0FZy7yhc2isRxgTWpq5CsSTQ8VD49BLP1I1UGdbuK8kG3w
        ==
X-Google-Smtp-Source: APXvYqzNM+hqNXj1scCvuzUFB0izXQvGYmuJkwDfSgZUfAQJyMFxR7TG2WspP6IDx9yMYb9AP8F5JT/bUcujcapgoY8=
X-Received: by 2002:a63:e64d:: with SMTP id p13mr645333pgj.121.1580949686415;
 Wed, 05 Feb 2020 16:41:26 -0800 (PST)
Date:   Wed,  5 Feb 2020 16:40:55 -0800
In-Reply-To: <20200206004108.261317-1-emilyshaffer@google.com>
Message-Id: <20200206004108.261317-3-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20200206004108.261317-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
Subject: [PATCH v6 02/15] help: add shell-path to --build-options
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
2.25.0.341.g760bfbb309-goog

