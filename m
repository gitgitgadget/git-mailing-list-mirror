Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F09E71FAED
	for <e@80x24.org>; Thu, 26 Oct 2017 07:01:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751476AbdJZHBY (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Oct 2017 03:01:24 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:46813 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751228AbdJZHBX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Oct 2017 03:01:23 -0400
Received: by mail-pf0-f194.google.com with SMTP id p87so1841171pfj.3
        for <git@vger.kernel.org>; Thu, 26 Oct 2017 00:01:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atlassian-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=w1tXXNkzIA923Cdj5Cd0YAmhXCPnLJVPnOpp6D/eZlo=;
        b=B7+G4C6IJyh/pbnhOHQnETPlCZ157aOaXaoNUfzpnMH/jSgS0gnHUv5CzWgG5g9rMo
         Myc627DLUOOX8RWSTTyrzsH0QmVa9lSCBKLnstkFW3r0GDziqbSOBlgN/j1fENn8CKPH
         JYL9UFunMo/Rdn1siQ76GJFdDEEGiDSlHD7x2EdNgTiq2gdb0o6JS7T2OnpY7tzkB9PE
         Sij00uaDv+GyPMjKY40XvlxK2k6Jdejbv+PK436c0VARyvVaECQnBGzRWpPww57lOX8a
         q9PpCCkWGq6aqeXoBfieqVb1h0pfpqanwEALkEUP3m4Lxffts/FYLWAgIW4B2SV+kahs
         E4ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=w1tXXNkzIA923Cdj5Cd0YAmhXCPnLJVPnOpp6D/eZlo=;
        b=jKrndAymJALBLaUuT1b+ZsxW/zN5/YVgpJB00L6BhLMZMJbYmXlqfqKp0AmzNcpxS5
         Jebipow7NuEXzKUy9JRTeGfZC48cQdQE++OuFveYv5wiy/o6EwfqpuDBGLcXUtnx2BkM
         Nd5oI74k1qJix89aZaqJgrXbFXUNkn4WQSc9rCbbashLb4dsejTJEVyfOX8JkbDf5WFa
         l3JAjvVH8cHD48gdaBA8ldYqlRhw3kqtwZJiqpznbVIJe8pxlMihfHqF+UEJ9rdYIcVp
         khdwI/MKL5B9TkrwPC8ZtsW4ZpcjyWVVbnpT5a161uV+RRoFwg7lIBeOdt6VTPultwEO
         LGag==
X-Gm-Message-State: AMCzsaXg5fFAxqdR53Zh2P0JoaNvSHKIMXFbV9ZtGFuSUqXE3JWv8etN
        m8ZfL6TWk3+HDOnvkC2/b6Z9uQ==
X-Google-Smtp-Source: ABhQp+SFs6/oCNto2EJhgqgqyf3KcNmijELozJt0wnouNUfkFd8x8JvKpzjAkVFx5+C0yRdUUgdl2Q==
X-Received: by 10.99.112.82 with SMTP id a18mr4034464pgn.84.1509001283258;
        Thu, 26 Oct 2017 00:01:23 -0700 (PDT)
Received: from CLI-30675.office.atlassian.com ([103.233.242.9])
        by smtp.gmail.com with ESMTPSA id z86sm8280397pfk.34.2017.10.26.00.01.20
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Thu, 26 Oct 2017 00:01:22 -0700 (PDT)
From:   Isabella Stephens <istephens@atlassian.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, sunshine@sunshineco.com, peff@peff.net,
        bturner@atlassian.com, Isabella Stephens <istephens@atlassian.com>
Subject: [PATCH v2] blame: prevent error if range ends past end of file
Date:   Thu, 26 Oct 2017 18:01:08 +1100
Message-Id: <20171026070108.4185-1-istephens@atlassian.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <xmqqtvyme8pg.fsf@gitster.mtv.corp.google.com>
References: <xmqqtvyme8pg.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If the -L option is used to specify a line range in git blame, and the
end of the range is past the end of the file, at present git will fail
with a fatal error. This commit prevents such behaviour - instead the
blame is display for any existing lines within the specified range.

Signed-off-by: Isabella Stephens <istephens@atlassian.com>
---
 builtin/blame.c               | 4 ++--
 t/t8003-blame-corner-cases.sh | 5 +++--
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index 67adaef4d..b5b9db147 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -878,13 +878,13 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 				    nth_line_cb, &sb, lno, anchor,
 				    &bottom, &top, sb.path))
 			usage(blame_usage);
-		if (lno < top || ((lno || bottom) && lno < bottom))
+		if ((lno || bottom) && lno < bottom)
 			die(Q_("file %s has only %lu line",
 			       "file %s has only %lu lines",
 			       lno), path, lno);
 		if (bottom < 1)
 			bottom = 1;
-		if (top < 1)
+		if (top < 1 || lno < top)
 			top = lno;
 		bottom--;
 		range_set_append_unsafe(&ranges, bottom, top);
diff --git a/t/t8003-blame-corner-cases.sh b/t/t8003-blame-corner-cases.sh
index 661f9d430..32b3788fe 100755
--- a/t/t8003-blame-corner-cases.sh
+++ b/t/t8003-blame-corner-cases.sh
@@ -216,8 +216,9 @@ test_expect_success 'blame -L with invalid start' '
 '
 
 test_expect_success 'blame -L with invalid end' '
-	test_must_fail git blame -L1,5 tres 2>errors &&
-	test_i18ngrep "has only 2 lines" errors
+	git blame -L1,5 tres >out &&
+	cat out &&
+	test $(wc -l < out) -eq 2
 '
 
 test_expect_success 'blame parses <end> part of -L' '
-- 
2.14.1

