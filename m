Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3A44C433E6
	for <git@archiver.kernel.org>; Mon, 15 Feb 2021 16:20:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8969760202
	for <git@archiver.kernel.org>; Mon, 15 Feb 2021 16:20:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230414AbhBOQTV (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Feb 2021 11:19:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231772AbhBOPrj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Feb 2021 10:47:39 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0281C0611C2
        for <git@vger.kernel.org>; Mon, 15 Feb 2021 07:45:03 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id r21so9432134wrr.9
        for <git@vger.kernel.org>; Mon, 15 Feb 2021 07:45:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xELFGzr85WPrp4s8GynaZFTK8kPVvV+00lqXNibE1/4=;
        b=qw9br27w5eaiHHK8ZynvHkgeCq1iOiONjUDM7gy71kInMTjyuKfVMQUQyk8r4CDKoU
         HJJhv9oF385y3ObPCac34C5rLWhyJJglNwoGB99y5/2Ti+9p1jDoaiE42OUa2Tog9xM3
         xRJ42fozRD1EgyILy1t/kMiUmgWYNsSkDC1NuazIowDF5HsjI1Uhs0yfnVNM9OGZAYLh
         oBcAdfY+H2rzEQxCZ9I1mZGMQKG4woVVDtY5DA3nT55K2aM/5f0zlLjkE8Bd4lEW7Jiy
         BtXshbBuY4bVDUQmYT9pjNLroiSionin8QRfvVZtoijmc0z++bN7RZ6T/DXVnZ4Z3LYk
         VMnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xELFGzr85WPrp4s8GynaZFTK8kPVvV+00lqXNibE1/4=;
        b=QyRFmudNXeSz6bLBOwDZbKsraYnpszAnz0P2l3CagPZlb66KVlUt1VEEbqlOiGTqEk
         HSmqH1ClQ9glkYht33tYM/y4tbDbjDJjWhT88BFoRNwLBnb357aHejDM2VEz7Ict8L3Q
         d3QllJdRnAt41vnJmBY5WTaurBFejopELuMQPcxUagM3q11/r78JIH4jnkUwQ+QN7bNR
         zHzEDAFDCVzJGJOq83BmJOtjAukRObjo+X4DAB/+WmfI2uysFavSY+XR6BZqiiN/aTCA
         2vuuFr7LWA5R4ilTQhWrCUlSMIm22UmiZawTwhgyQ05rrCEyQT/6LE8ITHOOzBrTq1zN
         mrAA==
X-Gm-Message-State: AOAM531y9VhQVnvN5FbPPBgZol11nR6YWKi5vf8OeOryhoKLp2LPUgrz
        eiteMsCaN/zmDCDC5/guIrby9WqVl2jCQQ==
X-Google-Smtp-Source: ABdhPJwDsoHkM92r76+xfdpzYbh5VtCSfvBVHWPXYn/1+HdUWIqfMvpGY3v1Yj8Z38ql/6fSHa6I2w==
X-Received: by 2002:a5d:49d2:: with SMTP id t18mr19406561wrs.224.1613403902168;
        Mon, 15 Feb 2021 07:45:02 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id f17sm23562757wrx.57.2021.02.15.07.45.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Feb 2021 07:45:01 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
        Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Adam Spiers <git@adamspiers.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Chris Torek <chris.torek@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 19/27] gitattributes doc: document multi-line userdiff patterns
Date:   Mon, 15 Feb 2021 16:44:19 +0100
Message-Id: <20210215154427.32693-20-avarab@gmail.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7
In-Reply-To: <20210215005236.11313-1-avarab@gmail.com>
References: <20210215005236.11313-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Document the multi-line userdiff patterns and how their matching and
the negation syntax works.

These patterns have been supported since f258475a6e (Per-path
attribute based hunk header selection., 2007-07-06), and have had
their current semantics ever since 3d8dccd74a (diff: fix "multiple
regexp" semantics to find hunk header comment, 2008-09-20).

But we had no documentation for them, let's fix that, and also add
tests showing how some of the things being discussed here work.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/gitattributes.txt | 33 +++++++++++++++++++---
 t/t4018/custom.sh               | 50 +++++++++++++++++++++++++++++++++
 t/t4018/perl.sh                 | 16 +++++++++++
 3 files changed, 95 insertions(+), 4 deletions(-)

diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
index 62c1147ba9..b51d2c86e0 100644
--- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -794,12 +794,37 @@ backslashes; the pattern above picks a line that begins with a
 backslash, and zero or more occurrences of `sub` followed by
 `section` followed by open brace, to the end of line.
 
-There are built-in patterns shipped as part of git itself. A more
-advanced version of the `tex` pattern discussed above is one of them.
+Multiple patterns can be supplied by listing them one per line
+separated by `\n`. They will be matched one at a time from left to
+right. Do not supply a trailing "\n" for the last pattern. E.g.:
+
+------------------------
+[diff "perl"]
+	xfuncname = "!^=head\n^[^ ]+.*"
+------------------------
+
+Patterns in in a list of multiple that begin with "!" are negated. A
+matching negated pattern will cause the matched line to be
+skipped. Use it to skip a later pattern that would otherwise match. It
+is an error if one or more negated patterns aren't followed by a
+non-negated pattern.
+
+To match a literal "!" at the start of a line, use some other regex
+construct that will match a literal "!" without "!" being the first
+character on that line, such as "[!]".
+
+If the pattern contains a `$1` capture it will be used instead of the
+entire matching line (`$0`) to display the hunk header. This can be
+used e.g. to strip whitespace from the beginning of the line, or to
+only display the function name as part of a longer function
+definition.
+
+There are built-in patterns shipped as part of git itself, see the
+full listing below.
 
 For built-in patterns, you do not need `diff.<lang>.xfuncname` in your
-configuration file as discussed above, but if present, it will
-override a built-in pattern.
+configuration file. If present, it will override a built-in pattern,
+as shown in the `diff.perl.xfuncname` example above.
 
 Nevertheless, you need to enable built-in patterns via .gitattributes`
 for the pattern to take effect.
diff --git a/t/t4018/custom.sh b/t/t4018/custom.sh
index 72d38dad68..30df13d8b2 100755
--- a/t/t4018/custom.sh
+++ b/t/t4018/custom.sh
@@ -111,3 +111,53 @@ ChangeMe
 
 baz
 EOF_TEST
+
+test_expect_success 'custom: setup negation syntax, ! is magic' '
+	git config diff.custom.xfuncname "!negation
+line"
+'
+
+test_diff_funcname 'custom: negation syntax, ! is magic' \
+	8<<\EOF_HUNK 9<<\EOF_TEST
+line
+EOF_HUNK
+line
+!negation
+
+ChangeMe
+
+baz
+EOF_TEST
+
+test_expect_success 'custom: setup negation syntax, use [!] to override ! magic' '
+	git config diff.custom.xfuncname "[!]negation
+line"
+'
+
+test_diff_funcname 'custom: negation syntax, use [!] to override ! magic' \
+	8<<\EOF_HUNK 9<<\EOF_TEST
+!negation
+EOF_HUNK
+line
+!negation
+
+ChangeMe
+
+baz
+EOF_TEST
+
+test_expect_success 'custom: setup captures in multiple patterns' '
+	git config diff.custom.xfuncname "!^=head
+^format ([^ ]+)
+^sub ([^;]+)"
+'
+
+test_diff_funcname 'custom: captures in multiple patterns' \
+	8<<\EOF_HUNK 9<<\EOF_TEST
+foo
+EOF_HUNK
+sub foo;
+=head1
+ChangeMe
+
+EOF_TEST
diff --git a/t/t4018/perl.sh b/t/t4018/perl.sh
index ac8fff7417..2952483a2c 100755
--- a/t/t4018/perl.sh
+++ b/t/t4018/perl.sh
@@ -76,3 +76,19 @@ sub RIGHT
 	print "ChangeMe\n";
 }
 EOF_TEST
+
+
+test_expect_success 'custom: setup config overrides built-in patterns' '
+	git config diff.perl.xfuncname "!^=head
+^[^ ]+.*"
+'
+
+test_diff_funcname 'custom: config overrides built-in patterns' \
+	8<<\EOF_HUNK 9<<\EOF_TEST
+sub foo;
+EOF_HUNK
+sub foo;
+=head1
+ChangeMe
+
+EOF_TEST
-- 
2.30.0.284.gd98b1dd5eaa7

