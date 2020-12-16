Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74763C4361B
	for <git@archiver.kernel.org>; Wed, 16 Dec 2020 07:40:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 240A223A23
	for <git@archiver.kernel.org>; Wed, 16 Dec 2020 07:40:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725812AbgLPHkl (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Dec 2020 02:40:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725804AbgLPHkl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Dec 2020 02:40:41 -0500
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 028D1C0613D6
        for <git@vger.kernel.org>; Tue, 15 Dec 2020 23:40:01 -0800 (PST)
Received: by mail-il1-x129.google.com with SMTP id 2so21702613ilg.9
        for <git@vger.kernel.org>; Tue, 15 Dec 2020 23:40:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5C3lZKlppggXSNIm7DEmhhLgTVg9hv4L8VP00FesaEg=;
        b=AqT+rMBXyhY7QODAdvr9ss0M60cnuYkw2RDEsDTQdMY9tPW6mdP+gE+3O8N9OE5vnA
         pC6HhqUw2QH9c4YcJcF5p1gEfpvWGofy/CUh32jgKDdTghgTKpZs78IkEt9PHdxcpNMt
         GUvlr/8RQnTwyZIlqgneY/EWA/T7kDVbZfZ6GUmuWq0yTL6YzXBs2xkHKm9dr5Cgnl3S
         YuGgQNcOuXhQ7BUU79nUkcjbr5EkGZLV0J8lP59XdNXw9UglOxF3C5a9lAdlEOePc81w
         KYMg5qzjxUiKOgRjQIgcMHjVii4cjly+mtUWZhDPBUJd3XDV4CwpXphjPrqeL4ipKNhW
         G2pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=5C3lZKlppggXSNIm7DEmhhLgTVg9hv4L8VP00FesaEg=;
        b=Q45rM3xjc6kX39BzypvXJSYUqA6jKYrBu3Nbh57tx7/ATNkbqUHWTThiXNK3iBa0ng
         VKWVQLKHgqSlBfQg3rZNHUp8RgbZL+C0jeZxAtfu7GNUbRVCSRzxoUiYpY8pg+zFobfV
         uhD17nhMzfgYs6UfkuTeNL+xe6s9PkNFOIHLr6901hfctJX6GZauuBhPzZE1SBnI5ULd
         czZ2cbCj5eSD/352jKx0Qqy39qfN+PtZk94AEKdidMqT5hbsoJq2au9JTBUAeiwaPfsu
         pstyMrFwc+WuU9Pe++5oqmcSG8Wi8QN4u9gdvNXKFa0WZbV3RGd1z5RE2JWX7fc156km
         g7aw==
X-Gm-Message-State: AOAM533kaQVv8QeciAIZ8QqKfBbv0YYba1rnpfcUFlZwYaYpuyFePFBF
        pB4SwMXrcwa6EGaY4aVyPwRP3OAFVxk=
X-Google-Smtp-Source: ABdhPJxo1w0HygXzU9gvWgPwiWunuSrbsw/3cYFEzQvDKvVtyzSrujHadz4PcpQJz58F57KobaLgCQ==
X-Received: by 2002:a92:bac3:: with SMTP id t64mr41501107ill.193.1608104399860;
        Tue, 15 Dec 2020 23:39:59 -0800 (PST)
Received: from localhost.localdomain (user-12l2dpj.cable.mindspring.com. [69.81.55.51])
        by smtp.gmail.com with ESMTPSA id p17sm657669ils.45.2020.12.15.23.39.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Dec 2020 23:39:58 -0800 (PST)
Sender: Eric Sunshine <ericsunshine@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     git@vger.kernel.org
Cc:     Sangeeta <sangunb09@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH] t/perf: fix test_export() failure with BSD `sed`
Date:   Wed, 16 Dec 2020 02:39:07 -0500
Message-Id: <20201216073907.62591-1-sunshine@sunshineco.com>
X-Mailer: git-send-email 2.30.0.rc0.297.gbcca948854
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

test_perf() runs each test in its own subshell which makes it difficult
to persist variables between tests. test_export() addresses this
shortcoming by grabbing the values of specified variables after a test
runs but before the subshell exits, and writes those values to a file
which is loaded into the environment of subsequent tests.

To grab the values to be persisted, test_export() pipes the output of
the shell's builtin `set` command through `sed` which plucks them out
using a regular expression along the lines of `s/^(var1|var2)/.../p`.
Unfortunately, though, this use of alternation is not portable. For
instance, BSD-lineage `sed` (including macOS `sed`) does not support it
in the default "basic regular expression" mode (BRE). It may be possible
to enable "extended regular expression" mode (ERE) in some cases with
`sed -E`, however, `-E` is neither portable nor part of POSIX.

Fortunately, alternation is unnecessary in this case and can easily be
avoided, so replace it with a series of simple expressions such as
`s/^var1/.../p;s/^var2/.../p`.

While at it, tighten the expressions so they match the variable names
exactly rather than matching prefixes (i.e. use `s/^var1=/.../p`).

If the requirements of test_export() become more complex in the future,
then an alternative would be to replace `sed` with `perl` which supports
alternation on all platforms, however, the simple elimination of
alternation via multiple `sed` expressions suffices for the present.

Reported-by: Sangeeta <sangunb09@gmail.com>
Diagnosed-by: Philippe Blain <levraiphilippeblain@gmail.com>
Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 t/perf/perf-lib.sh | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/t/perf/perf-lib.sh b/t/perf/perf-lib.sh
index 821581a885..22d727cef8 100644
--- a/t/perf/perf-lib.sh
+++ b/t/perf/perf-lib.sh
@@ -148,13 +148,18 @@ test_run_perf_ () {
 . '"$TEST_DIRECTORY"/test-lib-functions.sh'
 test_export () {
 	[ $# != 0 ] || return 0
-	test_export_="$test_export_\\|$1"
+	test_export_="$test_export_ $1"
 	shift
 	test_export "$@"
 }
 '"$1"'
 ret=$?
-set | sed -n "s'"/'/'\\\\''/g"';s/^\\($test_export_\\)/export '"'&'"'/p" >test_vars
+needles=
+for v in $test_export_
+do
+	needles="$needles;s/^$v=/export $v=/p"
+done
+set | sed -n "s'"/'/'\\\\''/g"'$needles" >test_vars
 exit $ret' >&3 2>&4
 	eval_ret=$?
 
-- 
2.30.0.rc0.297.gbcca948854

