Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIMWL_WL_MED shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 33B991F42D
	for <e@80x24.org>; Thu, 26 Apr 2018 07:47:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754051AbeDZHrK (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Apr 2018 03:47:10 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:40407 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753007AbeDZHrH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Apr 2018 03:47:07 -0400
Received: by mail-pf0-f193.google.com with SMTP id f189so8491302pfa.7
        for <git@vger.kernel.org>; Thu, 26 Apr 2018 00:47:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atlassian-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/QPSHJoe11A+6N7iAmSn3XlN0xvwzZ2sMot6RCfPjoc=;
        b=oDc6xBzpPNKK95LLQ98ZjfeC3rwPZfPvwDiw0s4VLfbGbfRJnB/axEgdFim1ncy0M6
         vIic/LY4ullEr9RWerYwmVUI/EOdr0mIBXBqPEwi8yd2CJtgA4IMciyvCBhdz96VbNzq
         nFuJIPZXuECbreeC/e+8nSbOhpLfHS3I1kcdq4b1GdP3Lw/2cDx/wHxdwS7UMrMg+Q2Z
         F4fub73/A1NvWuPFpz++mmH8n/fC4+ldi4waHutU3BtbuWqWULQXXhqsNzjgk5Kq8SAI
         sO8OeRz5ewrLlQRtZGsP2RwFx4PYf2K4bAdZB7EnPxJYzSJjkxDPbYbUCPFtsdWR8rA4
         JdCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/QPSHJoe11A+6N7iAmSn3XlN0xvwzZ2sMot6RCfPjoc=;
        b=N5TlvWXLutkKZVTplN64jEoBjZyl2T5RBw+27jLtawthfWtxYMp+Jne063sPVidEww
         O4hu836YqdhqRfgYUq7jq/3QQS8Gz/TzOVUHLZ2l0m51oGu1N/SRzt9EDa0s4WNjB2CN
         H9SY3GArAAfApDm7yBA1bRkgYi+xI1QbjWVTvo5GR6DxL3IyymPdwrGK2BQoyYAGYxwD
         z3G8waCoTGnwgv2TuvKDRiQrd3ZDoLxYYmd021ftmMKfsLwVctKCERwR37T/HCWoo3FY
         iKHZZQJZTwrYrNJllhsMkZhL76dJKEKB9A6BhFS0sC0aSwYihU2ETvwnd5WamBvRjCIt
         Tnsg==
X-Gm-Message-State: ALQs6tB1FNWs1TibyCbzL289T3bpl4CmYcDcESNqVlnfuVW/u1OfaOg9
        OflJ9XDJMqy2Q9w3Vlf7u7MMwA==
X-Google-Smtp-Source: AB8JxZrc3X2g2CGxHKngYU2roOSqcYiGBcZ6SbRYciwopl+Cp6aTOJ1J7lGaH5zJNZTbJNpzeHxAtw==
X-Received: by 2002:a17:902:bf0a:: with SMTP id bi10-v6mr284098plb.235.1524728827341;
        Thu, 26 Apr 2018 00:47:07 -0700 (PDT)
Received: from C02VT0RZHTDG.office.atlassian.com ([103.233.242.8])
        by smtp.gmail.com with ESMTPSA id e10sm31007774pfn.67.2018.04.26.00.47.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Apr 2018 00:47:06 -0700 (PDT)
From:   istephens@atlassian.com
To:     sunshine@sunshineco.com
Cc:     szeder.dev@gmail.com, gitster@pobox.com, git@vger.kernel.org,
        peff@peff.net, bturner@atlassian.com, jacob.keller@gmail.com,
        Isabella Stephens <istephens@atlassian.com>
Subject: [PATCH v4 1/2] blame: prevent error if range ends past end of file
Date:   Thu, 26 Apr 2018 17:45:01 +1000
Message-Id: <20180426074502.78318-2-istephens@atlassian.com>
X-Mailer: git-send-email 2.14.3 (Apple Git-98)
In-Reply-To: <20180426074502.78318-1-istephens@atlassian.com>
References: <CAPig+cSH-y7ChDE_LW55M_wB=KhD7uJHXX=OvZ=1ri5KfYQ5Sg@mail.gmail.com>
 <20180426074502.78318-1-istephens@atlassian.com>
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
Blaming -L ,-n will complain of an empty range, rather than blaming the
whole file.

Signed-off-by: Isabella Stephens <istephens@atlassian.com>
---
 Documentation/git-blame.txt   | 10 ++++++++++
 builtin/blame.c               |  6 ++++--
 line-range.c                  |  2 +-
 t/t8003-blame-corner-cases.sh | 17 +++++++++++++----
 4 files changed, 28 insertions(+), 7 deletions(-)

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
index 9dcb367b9..1204ab142 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -886,13 +886,15 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 				    nth_line_cb, &sb, lno, anchor,
 				    &bottom, &top, sb.path))
 			usage(blame_usage);
-		if (lno < top || ((lno || bottom) && lno < bottom))
+		if (!bottom && top < 0)
+			die("-L invalid empty range");
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
index 323399d16..023aee1f5 100644
--- a/line-range.c
+++ b/line-range.c
@@ -47,7 +47,7 @@ static const char *parse_loc(const char *spec, nth_line_fn_t nth_line,
 			else if (!num)
 				*ret = begin;
 			else
-				*ret = begin + num;
+				*ret = begin + num ? begin + num : -1;
 			return term;
 		}
 		return spec;
diff --git a/t/t8003-blame-corner-cases.sh b/t/t8003-blame-corner-cases.sh
index 661f9d430..4a0c51658 100755
--- a/t/t8003-blame-corner-cases.sh
+++ b/t/t8003-blame-corner-cases.sh
@@ -216,14 +216,23 @@ test_expect_success 'blame -L with invalid start' '
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
+'
+
+test_expect_success 'blame -L,-n' '
+	test_must_fail git blame -L,-1 tres 2>errors &&
+	test_i18ngrep "-L invalid empty range"
 '
 
 test_expect_success 'indent of line numbers, nine lines' '
-- 
2.14.3 (Apple Git-98)

