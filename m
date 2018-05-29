Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIMWL_WL_MED shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4DE211F42D
	for <e@80x24.org>; Tue, 29 May 2018 05:31:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751591AbeE2Fbn (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 May 2018 01:31:43 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:40533 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750880AbeE2Fbl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 May 2018 01:31:41 -0400
Received: by mail-pl0-f68.google.com with SMTP id t12-v6so8275889plo.7
        for <git@vger.kernel.org>; Mon, 28 May 2018 22:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atlassian-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=yn5ehFnZ4zRLhAWEqaqHNX4UN8X7odpoK2wyvb/rkMY=;
        b=Mpy1pPBI8WV1YLuPNfAGiw9G8moZoz6IpTvsphs8+X6ExaLnzszw4orXNPF/omomfe
         Zy1alhV9Fk0NqFoZhrUVusDy6XbbeUIqhBjvOuTa85h/3Mb+oDjb6buKO1zQAbCv0iS9
         OwIIieT9uJx44N5FMruG3uGDPyReHVkKcs/jsQb0gu2Tm+h5XA8YNFzwn4FwCsG36AQk
         epFyd6PJ1TbOOY2vQuUnQ/JNw2p1C0PQ5/GUNQPJ8lTTw/4Lua0lH3JJswa8vfis20uk
         tFRzTvRO53g1kADwV5OR5mYorABrvkpWuYSEheWyWwVEqx9iaaT4V42zBtgJnkueKkS+
         fTQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=yn5ehFnZ4zRLhAWEqaqHNX4UN8X7odpoK2wyvb/rkMY=;
        b=ugxcipoL/s9l5ooHfOGlTD1GBlC++I8E5INQPjKQ+8iV1HMa6nMQOJQy/5y/O4RFOM
         X6FZJz+09KORrW6X4Bya2zzO8Aw7Fb1+9qNcbJ7QJ0vGImECR2bn8Oe3aOobA5M0r2vV
         mrlOBhOSP/ucYRY7hsgPvZlViPGDyDbW9A92PuIfwjYno0pVNOPiT1+AgytsoASN1aR6
         02uv3ZSE6fx9TtbM5iteXVIH4BRmoCVBMMio0aSebg0t2rM+Utqpt3u6peu+26yZQMj5
         d4NRpC9i+MmZ3f1cV12jhr7DKgoERwqMBXRusq0L3dHJzGyng2HGxxRRhGtmbIgDtz8G
         TVIQ==
X-Gm-Message-State: ALKqPwcVHQckELlGOeIGfODoTzAkadp6gey0RZmJT8yjMkrHnM/mfh0b
        lat+l0h68Ao5eNvQW1t8dT05jw==
X-Google-Smtp-Source: AB8JxZr8H/MoPL43gRuGktGy713RvvZIHLIricD6VT9ZdV2/UeS5ZodvebPD9iEyd6TpxQqRK18y+g==
X-Received: by 2002:a17:902:9a98:: with SMTP id w24-v6mr16642936plp.9.1527571900896;
        Mon, 28 May 2018 22:31:40 -0700 (PDT)
Received: from C02VT0RZHTDG.office.atlassian.com ([103.233.242.8])
        by smtp.gmail.com with ESMTPSA id 23-v6sm80866291pfs.147.2018.05.28.22.31.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 May 2018 22:31:40 -0700 (PDT)
From:   istephens@atlassian.com
To:     gitster@pobox.com
Cc:     szeder.dev@gmail.com, git@vger.kernel.org, peff@peff.net,
        bturner@atlassian.com, jacob.keller@gmail.com,
        Isabella Stephens <istephens@atlassian.com>
Subject: [PATCH] blame: prevent error if range ends past end of file
Date:   Tue, 29 May 2018 15:30:36 +1000
Message-Id: <20180529053037.38015-2-istephens@atlassian.com>
X-Mailer: git-send-email 2.14.3 (Apple Git-98)
In-Reply-To: <20180529053037.38015-1-istephens@atlassian.com>
References: <xmqqzi1iwz7l.fsf@gitster-ct.c.googlers.com>
 <20180529053037.38015-1-istephens@atlassian.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Isabella Stephens <istephens@atlassian.com>

If the -L option is used to specify a line range in git blame, and the
end of the range is past the end of the file, git will fail with a fatal
error. This commit prevents such behavior - instead we display the blame
for existing lines within the specified range. Tests and documentation
are ammended accordingly.

This commit also fixes two corner cases. Blaming -L n,-(n+1) now blames
the first n lines of a file rather than from n to the end of the file.
Blaming -L ,-n will be treated as -L 1,-n and blame the first line of
the file, rather than blaming the whole file.

Signed-off-by: Isabella Stephens <istephens@atlassian.com>
---
 Documentation/git-blame.txt   | 10 ++++++++++
 builtin/blame.c               |  4 ++--
 line-range.c                  |  2 +-
 t/t8003-blame-corner-cases.sh | 12 ++++++++----
 4 files changed, 21 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-blame.txt b/Documentation/git-blame.txt
index 16323eb80..8cb81f57a 100644
--- a/Documentation/git-blame.txt
+++ b/Documentation/git-blame.txt
@@ -152,6 +152,16 @@ Also you can use a regular expression to specify the line range:
 
 which limits the annotation to the body of the `hello` subroutine.
 
+A range that begins or ends outside the bounds of the file will
+blame the relevant lines. For example:
+
+	git blame -L 10,-20 foo
+	git blame -L 10,+20 foo
+
+will respectively blame the first 10 and last 11 lines of a
+20 line file. However, blaming a line range that is entirely
+outside the bounds of the file will fail.
+
 When you are not interested in changes older than version
 v2.6.18, or changes older than 3 weeks, you can use revision
 range specifiers  similar to 'git rev-list':
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

