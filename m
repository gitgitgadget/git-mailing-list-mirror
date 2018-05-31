Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIMWL_WL_MED shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2AAD21F42D
	for <e@80x24.org>; Thu, 31 May 2018 05:02:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751947AbeEaFCP (ORCPT <rfc822;e@80x24.org>);
        Thu, 31 May 2018 01:02:15 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:36553 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750974AbeEaFCO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 May 2018 01:02:14 -0400
Received: by mail-pg0-f65.google.com with SMTP id m5-v6so4778758pgd.3
        for <git@vger.kernel.org>; Wed, 30 May 2018 22:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atlassian-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=aFkOQr3nR1x+4UiwuTsFlzrC5HQ+Qt8L0pB/kbRu+X8=;
        b=bxUChUeHl9rbY1hrFs2i3rHbe9QtP2UoCdzXPPDI0Zyp9Ybmf35IcSNWnwJERXA1qR
         Hunsqp+5rNaLMmKirg8WS4f1rkR50XACTCW86UNKfvp/Jby/FJ9/QAE8F8Nl/lMqvSV0
         xcwwmq8NzIrxDXdVMmjZ9Azcr+PhoVYI1fz5o7r/v1+PIU16w6kdK3U0YJM8VUOmvOEX
         uiNyHiYmI0ICWhYwni7TG++JjZ+oSdLcbv7nxHaDJcNtd+/chub5+oBZukgs0/YIkT+S
         aQAEP/i7YJrzpwDwhZgWgET3HSBhZC1hveI1LDbUfDYuw0jM0EuFlQ4U27U1n+iTQPs6
         jhcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=aFkOQr3nR1x+4UiwuTsFlzrC5HQ+Qt8L0pB/kbRu+X8=;
        b=pPbx6XPZN8AreVNL2OuGGgKdkB4gFwLDCbhCLeG0IhQjtOU4byRtAepgoN/5b4Frmo
         hh3Lw7XS//lS4oPce7vwkG/LEsHBPShw36P1EcHORqtgiD7tIwqShvgL2jKSlJ0w9Xlu
         izCHeSaKqcIikpQFLW15kQ9Fi97r+jAe+hGvMHLFLs+OWEcYqa/z1ibG/VN/rNtIFG2B
         ZVDXma/BUHdwnWpCou56ZiWAqUK/OgroYV6ZU9nUqUJY8SdteQ0SsIje96kizhTgkp4k
         Hz8JDiU4Wm9QlkAFdwAgdbpKFa17lpCNKVyR8334OygX6AYvkfzx8y2vrHHbaymLfTOy
         XUuQ==
X-Gm-Message-State: ALKqPwd0EwRdXp0LhndHV4R18zncx0YLL71rfFdzZjjjke65vaHtnwkY
        7kAeFOZ7DqGmOQlIceQddwD6h8AA4jQ=
X-Google-Smtp-Source: ADUXVKJ5Cd/IBjpIgTsfdx6iUYicwwxIwUe4VZSdQQ289r7Z/O7hTD7ViH2DprR4dv86x5+QfXMGfA==
X-Received: by 2002:a63:24c4:: with SMTP id k187-v6mr1636217pgk.434.1527742933782;
        Wed, 30 May 2018 22:02:13 -0700 (PDT)
Received: from C02VT0RZHTDG.office.atlassian.com ([103.233.242.8])
        by smtp.gmail.com with ESMTPSA id m18-v6sm47885687pgu.67.2018.05.30.22.02.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 May 2018 22:02:12 -0700 (PDT)
From:   istephens@atlassian.com
To:     git@vger.kernel.org
Cc:     szeder.dev@gmail.com, gitster@pobox.com, peff@peff.net,
        bturner@atlassian.com, jacob.keller@gmail.com,
        sunshine@sunshineco.com,
        Isabella Stephens <istephens@atlassian.com>
Subject: [PATCH v6 1/2] blame: prevent error if range ends past end of file
Date:   Thu, 31 May 2018 15:00:29 +1000
Message-Id: <20180531050030.43364-1-istephens@atlassian.com>
X-Mailer: git-send-email 2.14.3 (Apple Git-98)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Isabella Stephens <istephens@atlassian.com>

If the -L option is used to specify a line range in git blame, and the
end of the range is past the end of the file, git will fail with a fatal
error. This commit prevents such behavior - instead we display the blame
for existing lines within the specified range. Tests are amended
accordingly.

This commit also fixes two corner cases. Blaming -L n,-(n+1) now blames
the first n lines of a file rather than from n to the end of the file.
Blaming -L ,-n will be treated as -L 1,-n and blame the first line of
the file, rather than blaming the whole file.

Signed-off-by: Isabella Stephens <istephens@atlassian.com>
---
 builtin/blame.c               |  4 ++--
 line-range.c                  |  2 +-
 t/t8003-blame-corner-cases.sh | 12 ++++++++----
 3 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index 9dcb367b9..e1359b192 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -886,13 +886,13 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 				    nth_line_cb, &sb, lno, anchor,
 				    &bottom, &top, sb.path))
 			usage(blame_usage);
-		if (lno < top || ((lno || bottom) && lno < bottom))
+		if ((!lno && (top || bottom)) || lno < bottom)
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
diff --git a/line-range.c b/line-range.c
index 323399d16..232c3909e 100644
--- a/line-range.c
+++ b/line-range.c
@@ -47,7 +47,7 @@ static const char *parse_loc(const char *spec, nth_line_fn_t nth_line,
 			else if (!num)
 				*ret = begin;
 			else
-				*ret = begin + num;
+				*ret = begin + num > 0 ? begin + num : 1;
 			return term;
 		}
 		return spec;
diff --git a/t/t8003-blame-corner-cases.sh b/t/t8003-blame-corner-cases.sh
index 661f9d430..c92a47b6d 100755
--- a/t/t8003-blame-corner-cases.sh
+++ b/t/t8003-blame-corner-cases.sh
@@ -216,14 +216,18 @@ test_expect_success 'blame -L with invalid start' '
 '
 
 test_expect_success 'blame -L with invalid end' '
-	test_must_fail git blame -L1,5 tres 2>errors &&
-	test_i18ngrep "has only 2 lines" errors
+	git blame -L1,5 tres >out &&
+	test_line_count = 2 out
 '
 
 test_expect_success 'blame parses <end> part of -L' '
 	git blame -L1,1 tres >out &&
-	cat out &&
-	test $(wc -l < out) -eq 1
+	test_line_count = 1 out
+'
+
+test_expect_success 'blame -Ln,-(n+1)' '
+	git blame -L3,-4 nine_lines >out &&
+	test_line_count = 3 out
 '
 
 test_expect_success 'indent of line numbers, nine lines' '
-- 
2.14.3 (Apple Git-98)

