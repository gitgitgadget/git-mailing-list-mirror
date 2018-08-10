Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D629F1F404
	for <e@80x24.org>; Fri, 10 Aug 2018 22:49:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727182AbeHKBVf (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Aug 2018 21:21:35 -0400
Received: from mail-oi0-f74.google.com ([209.85.218.74]:52268 "EHLO
        mail-oi0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727032AbeHKBVf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Aug 2018 21:21:35 -0400
Received: by mail-oi0-f74.google.com with SMTP id w185-v6so10701556oig.19
        for <git@vger.kernel.org>; Fri, 10 Aug 2018 15:49:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=s3Okxem6fjDx4kaZ8GYR7ng3jdK7gRs5jdlMxkB3Nkg=;
        b=TOJ+8Z6UqNkNXUHe85uf2TY/P114Pgkhvxp6vcqtae5qA26cHtqOXy+yX/fereNJau
         t9KIBYjPASAQf/ekk+ZETcQfUlWPvCHP2eLLd2Y7IroFvLRWTkguCD6BQmZviKMxDbPF
         IzT6dg7AveFwuDTMgaGqKpAyYAbcNhREODKQ3NZ0vQVnQKmJS9LDFJZx7TkM5xvjWjFg
         cPQOsUxc73pqy9JIER8SOej34IvgdaWSmrC36a5XeSDZkHoQ7FN3y5LOH91mb+4Ms8Wj
         8LSsoE1xiM0UsqYMVbkxghNhYx8tEDdTeCzocxkdNKkD5Fgjp2HSbUfGqxg2irfKDB5k
         YPHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=s3Okxem6fjDx4kaZ8GYR7ng3jdK7gRs5jdlMxkB3Nkg=;
        b=nOjXzR4WF+zSOWTzXGNk1Hq/KWe+Ybm8CZ0UIg4l7KFC5DAdZEWV1vcUnNPCFYxuHD
         bF7OJX2BhXN7zUDMlC54vLofeUvTwiyOq0Bf7bioMBhj3otKiw5Fd5NJOt30Ha1blUjn
         xp+XUyYlgwg2yy7cx0fPmvNUw4GD4D1oAxzny4CyYlnu2t+q+Ub9w4sz9IBq7DfkwdU4
         GlJuNRZi3x7ZYz68IzjEnEYDZHQCvwJ/wWcOvrVQ3/Ss10HbxQpMvUqqPlZljzeEYEAN
         AMBp99bpuQCtKn4XbbZ0kZYsBL4m3oEWCIfr4hxwQ0UlL0yjpbkOuQNHsgFBdfP+b9MT
         MQUg==
X-Gm-Message-State: AOUpUlHVccb1Zl+Z0rm2pd3ls21VkQIpgcL1I5m5Sg/5aeuWprYTXsIA
        ENz5SoibsAovjQIFQd0dSrY3DY9R8r6z
X-Google-Smtp-Source: AA+uWPw0jLU5+Vfpjw/aEwMwVY/Y+7b/7/vI7qYk9i3xoTo4txNYaYwQExf2JVikiNpdi1Yi4UZqVbqDh88f
X-Received: by 2002:aca:f346:: with SMTP id r67-v6mr5084907oih.34.1533941382865;
 Fri, 10 Aug 2018 15:49:42 -0700 (PDT)
Date:   Fri, 10 Aug 2018 15:49:22 -0700
In-Reply-To: <20180810224923.143625-1-sbeller@google.com>
Message-Id: <20180810224923.143625-4-sbeller@google.com>
Mime-Version: 1.0
References: <20180810224923.143625-1-sbeller@google.com>
X-Mailer: git-send-email 2.18.0.865.gffc8e1a3cd6-goog
Subject: [PATCH 3/4] range-diff: make use of different output indicators
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, Johannes.Schindelin@gmx.de,
        Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This change itself only changes the internal communication and should
have no visible effect to the user. We instruct the diff code that produces
the inner diffs to use X, Y, Z instead of the usual markers for new, old
and context lines

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 range-diff.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/range-diff.c b/range-diff.c
index b6b9abac266..6e4192c8e79 100644
--- a/range-diff.c
+++ b/range-diff.c
@@ -38,6 +38,9 @@ static int read_patches(const char *range, struct string_list *list)
 
 	argv_array_pushl(&cp.args, "log", "--no-color", "-p", "--no-merges",
 			"--reverse", "--date-order", "--decorate=no",
+			"--output-indicator-new=X",
+			"--output-indicator-old=Y",
+			"--output-indicator-context=Z",
 			"--no-abbrev-commit", range,
 			NULL);
 	cp.out = -1;
@@ -108,8 +111,18 @@ static int read_patches(const char *range, struct string_list *list)
 			 * we are not interested.
 			 */
 			continue;
-		else
+		else if (line.buf[0] == 'X') {
+			strbuf_addch(&buf, '+');
+			strbuf_add(&buf, line.buf + 1, line.len - 1);
+		} else if (line.buf[0] == 'Y') {
+			strbuf_addch(&buf, '-');
+			strbuf_add(&buf, line.buf + 1, line.len - 1);
+		} else if (line.buf[0] == 'Z') {
+			strbuf_addch(&buf, ' ');
+			strbuf_add(&buf, line.buf + 1, line.len - 1);
+		} else {
 			strbuf_addbuf(&buf, &line);
+		}
 
 		strbuf_addch(&buf, '\n');
 		util->diffsize++;
-- 
2.18.0.865.gffc8e1a3cd6-goog

