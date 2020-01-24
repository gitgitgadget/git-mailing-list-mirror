Return-Path: <SRS0=Vx3J=3N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF942C47409
	for <git@archiver.kernel.org>; Fri, 24 Jan 2020 03:35:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B21A622522
	for <git@archiver.kernel.org>; Fri, 24 Jan 2020 03:35:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ebn5IyPN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729793AbgAXDfU (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Jan 2020 22:35:20 -0500
Received: from mail-pg1-f202.google.com ([209.85.215.202]:42296 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728655AbgAXDfT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Jan 2020 22:35:19 -0500
Received: by mail-pg1-f202.google.com with SMTP id 193so578720pgh.9
        for <git@vger.kernel.org>; Thu, 23 Jan 2020 19:35:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=cm9Ej2IpaMY/kksamirIQxVIpZbyhSncLIDt6Y94kwM=;
        b=ebn5IyPNao5YfU/pX9lgLVA7pIwbn83+ZmsiBa3mI5CfrLBoUG13Qmn2NvPRRWdNJ5
         vD3jvJXflRQs4OqNnx7JBkLq2bnN9SLVzuETAgvG7p5pTI4pfFzHdd0skbAT8c1wBHvn
         0lUHIXX2wbb3/PR59Ke32jnkxgA/3licm+WbXE3Iky1NDA/7oPrQvRaPR9135dxZk6Wi
         7MmblE4fdUraVJmWtcNTbNWN2q7+xjA2NBih3z+tUlYF7E8TlLh/14QpolOD5j995ZvP
         qD+PbZtRjDuWk8vj3urZzguPQlaLtbkPYy6HjryzXswySZVoi14iK81b3VEWlyEAyIrd
         ftqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=cm9Ej2IpaMY/kksamirIQxVIpZbyhSncLIDt6Y94kwM=;
        b=b4oYG/nu/KD7Qe05fiVuM3WMU04t9K1mqmdw/UyT9/w40M7RgbP51iGGZNpb0jNepS
         ggsBikjKXnJmRclomEgO5ILc/ZsmJGU8Ub4o2jiWxmevjuoZw80WMJMfU9iyX7ucQczA
         ASOkMr5mSzyKpv/pzvpjw8eCJamA89qw3qmd9770XZLLtD3+Vc340AJ4YjQXBr9arLIr
         pNGpPpOwS/1w87BtOvJlRqUt/vZYGXIlfmULQoZukWSXdR82Z8I9CM5zaQ7kp1PHvTts
         Wur+qRQPLh93ETqlmISyqut2CZxGjEdzQrLBVbzkJhU7VTCv+IjObng0I1C2q69wv4cp
         yzLQ==
X-Gm-Message-State: APjAAAU2mv7uIVsanLuZznJ7BgjSQMU/It3xXV+Gi939JAy5vL7QiTHl
        Ac0kCiclRnMgv7bD+dJfNtsIuBwKvg0mZeLDRzNv/GHJt0wYKjwmlt14prYArkiAP5UAkHMAdw/
        ovSYMp3S5nhIT4Z7fbr6TVQGwHOywpjz8H3WYLAFNlW/5vxUM4b4RZ9xLOis0D0sNtOdem9MXTQ
        ==
X-Google-Smtp-Source: APXvYqxGZT8od+swx6/oFC+Ts8TL2VdKywKujp6/NYMC8xNASy/t1xTjrrm26kjwep3eSSmQyxiNi3pYdKfB/Ingkd4=
X-Received: by 2002:a63:cb47:: with SMTP id m7mr1762445pgi.309.1579836919114;
 Thu, 23 Jan 2020 19:35:19 -0800 (PST)
Date:   Thu, 23 Jan 2020 19:34:25 -0800
In-Reply-To: <20200124033436.81097-1-emilyshaffer@google.com>
Message-Id: <20200124033436.81097-5-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20200124033436.81097-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
Subject: [PATCH v5 04/15] help: add shell-path to --build-options
From:   emilyshaffer@google.com
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Emily Shaffer <emilyshaffer@google.com>

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
index 156a6cdea3..d3f941824f 100644
--- a/help.c
+++ b/help.c
@@ -642,6 +642,7 @@ void get_version_info(struct strbuf *buf, int show_build_options)
 			strbuf_addstr(buf, "no commit associated with this build\n");
 		strbuf_addf(buf, "sizeof-long: %d\n", (int)sizeof(long));
 		strbuf_addf(buf, "sizeof-size_t: %d\n", (int)sizeof(size_t));
+		strbuf_addf(buf, "shell-path: %s\n", SHELL_PATH);
 		/* NEEDSWORK: also save and output GIT-BUILD_OPTIONS? */
 	}
 }
-- 
2.25.0.341.g760bfbb309-goog

