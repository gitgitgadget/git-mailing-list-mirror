Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIMWL_WL_MED shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 49B8A1F403
	for <e@80x24.org>; Fri, 15 Jun 2018 06:29:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933077AbeFOG3v (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Jun 2018 02:29:51 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:35005 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932452AbeFOG3t (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Jun 2018 02:29:49 -0400
Received: by mail-pl0-f67.google.com with SMTP id k1-v6so4850249plt.2
        for <git@vger.kernel.org>; Thu, 14 Jun 2018 23:29:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atlassian-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fFAoQqclM+qhca2qlO6l/+j/4TfqNfG9aWpPAxatdeg=;
        b=wwAofQDTGaD/+I7iMhD9OC1gyTM4U8HnhMJBfQADKcGBUmbMGZOxN3z0zxMajlPzTz
         hKSU5z3dEwVi4d5g++AHaDfqy6iFoWsG1soYOHjKkbcctcTaqMz/MvV8y9O27nmSgTXJ
         +0I300GJABLo7OZWFbxf67aIs5IfDg3Tz02SKzeP3InvNTJ5duHYKnAwNgiBeOyYWnxd
         RGphKIoLkcpQR6UYJnNx/Dphiirc/yscxooGpBFKCbbxUoEm4xrktsnXQJ8wsgnlAJy+
         P++JPk9n78LVWs7VtncsyEWz5HKkdelkl9IP0DtjoAp3i8tE6Es+U+djsZPDXJuF8o3d
         LjUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=fFAoQqclM+qhca2qlO6l/+j/4TfqNfG9aWpPAxatdeg=;
        b=HRIiIsCNDzF3ly5W6goCSLYIZBxT6fCsUPf3UyfLyFHhndiKZtTPot6nMHsF2tS90h
         uLrVOCtiAx0BkQG/OM1RAl72CIoq3L7znBPIv5lY/aiGbW4IpviHlG4jOcXSD4NzTW24
         v+YXruqJPgC7dhweZNuqF18R1s3Ia8A29RAOtm+AO+L+fLXvEg+C/+R6dwqB+q6fBXCu
         amsJEKQ2XOY6NZSp78cp8k2ztiq/HeTW3wPfBtm5Nw7iWhz6aFl0LVEN06Qai6LL37WC
         SU3fYZ2Z/djm2HKMqQnXnC5DW4+Pc//S7WQd/FwHQY0+WJKLs5f3luO+cyk+TI6+onwE
         fPdw==
X-Gm-Message-State: APt69E2x/FweCeH1In9urcr93yF/OzcCvXg3yXrwU2aBh/wj9AqF7+Y+
        nrIbcZqcwz451xxw8p3JLyquhdAm7Bc=
X-Google-Smtp-Source: ADUXVKIsb7Pjkbg+1fLTtuqdrYiagYj//VQE77VOpPZA97tpWdZRyN1Q14Pd23XfHkHVfFlYbPofsA==
X-Received: by 2002:a17:902:1081:: with SMTP id c1-v6mr471763pla.153.1529044188726;
        Thu, 14 Jun 2018 23:29:48 -0700 (PDT)
Received: from C02VT0RZHTDG.office.atlassian.com ([103.233.242.8])
        by smtp.gmail.com with ESMTPSA id k12-v6sm8498419pgo.31.2018.06.14.23.29.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Jun 2018 23:29:47 -0700 (PDT)
From:   istephens@atlassian.com
To:     gitster@pobox.com
Cc:     szeder.dev@gmail.com, git@vger.kernel.org, peff@peff.net,
        bturner@atlassian.com, jacob.keller@gmail.com,
        sunshine@sunshineco.com,
        Isabella Stephens <istephens@atlassian.com>
Subject: [PATCH v7 1/2] blame: prevent error if range ends past end of file
Date:   Fri, 15 Jun 2018 16:29:27 +1000
Message-Id: <20180615062928.37165-1-istephens@atlassian.com>
X-Mailer: git-send-email 2.14.3 (Apple Git-98)
In-Reply-To: <xmqqh8mnb8j2.fsf@gitster-ct.c.googlers.com>
References: <xmqqh8mnb8j2.fsf@gitster-ct.c.googlers.com>
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
 t/annotate-tests.sh           |  4 ++--
 t/t8003-blame-corner-cases.sh | 12 ++++++++----
 4 files changed, 13 insertions(+), 9 deletions(-)

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
diff --git a/t/annotate-tests.sh b/t/annotate-tests.sh
index 093832fef..6da48a2e0 100644
--- a/t/annotate-tests.sh
+++ b/t/annotate-tests.sh
@@ -320,11 +320,11 @@ test_expect_success 'blame -L ,Y (Y == nlines)' '
 
 test_expect_success 'blame -L ,Y (Y == nlines + 1)' '
 	n=$(expr $(wc -l <file) + 2) &&
-	test_must_fail $PROG -L,$n file
+	check_count -L,$n A 1 B 1 B1 1 B2 1 "A U Thor" 1 C 1 D 1 E 1
 '
 
 test_expect_success 'blame -L ,Y (Y > nlines)' '
-	test_must_fail $PROG -L,12345 file
+	check_count -L,12345 A 1 B 1 B1 1 B2 1 "A U Thor" 1 C 1 D 1 E 1
 '
 
 test_expect_success 'blame -L multiple (disjoint)' '
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

