Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAE5AC53210
	for <git@archiver.kernel.org>; Sun,  8 Jan 2023 15:54:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231134AbjAHPyH (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 8 Jan 2023 10:54:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjAHPyG (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Jan 2023 10:54:06 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A933262C
        for <git@vger.kernel.org>; Sun,  8 Jan 2023 07:54:03 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id g20so4459681pfb.3
        for <git@vger.kernel.org>; Sun, 08 Jan 2023 07:54:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4+Ps4SvooOpJTaHa6RZIsxHlRxpN7glVRix3bFq7oL8=;
        b=d2BWKuKcK/yCNdoxFcwxtfAAM3kRP1LHWM5Ntf1M+ZCc/6kpWrvhN3TNrWJ7nB1cUR
         ih2D++/HKv9IrGNyeSXcgLUNMUkmXjJQcpWKLOkQNDI4nDI1XIe++eOr58PmXIQ+Rx9S
         vqfizBCEQ3IOv5bvaaFEv6Z4cE8CL+M8fNvtdTueOQ2lJNGAKBBTc1H2S0BFU3ZZ8Rk3
         c1o3zM8qqMeGHhvtgOC6gG83faEzpAR68k4JaxefqBjWm2B4XpHOj5KExm1eOg9O2h/t
         0X6wuyVbnVExEfLQ+sUymfXnKmaMibt7rrdgFGWEWcr5rPQ7Jre0PKCL0pOTBQSJ8cdf
         JoDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4+Ps4SvooOpJTaHa6RZIsxHlRxpN7glVRix3bFq7oL8=;
        b=TpVYqR0LzQRl+eNA+ipoipcYQZ46wIlEisFFccIi0rAvo6mSoXKo+eBQk/pSi1P4Vp
         d4kMwjWbug+IWEKz8GwfTa+W5phZ3Q8vjk2r3A47qXu/FW+Cv9NqZmctI3fupZUB5f4G
         Xoa0ZRoPNS09nrmdvJrp1/QEgRHQwLEj4HTH8hksONIveevozYQlcghMWK4y7OeZHgeA
         F+NqFm3WWsVwyY6bKwv0ZQ/qReFAF5cNEpMFdWMVUyR157YggtwePbFRs2EtGlVHEQq4
         FCmopVakXvLIhdf6LOrZ96kmZu22rV0x6gDYVTPddAlsOt2/+zdhAsg/GHWtQq1oE1Ay
         83ww==
X-Gm-Message-State: AFqh2kqt8AcH97Amxf58WJM4lQ8M9kWgBM0oYFeP8LS3qvhR815bCxxI
        tbLNsGsqo3i2KfxQLro7yKu9fKVoE5A=
X-Google-Smtp-Source: AMrXdXvGnuaaCi8pBxXMKaqRbO7YHzDtRgykjIKFb2RdUxd3loJIh3DQxvoY+itpz4L82/BVlx7SAg==
X-Received: by 2002:a05:6a00:198c:b0:582:d44f:3948 with SMTP id d12-20020a056a00198c00b00582d44f3948mr18168547pfl.18.1673193242503;
        Sun, 08 Jan 2023 07:54:02 -0800 (PST)
Received: from localhost.localdomain (192-184-217-7.fiber.dynamic.sonic.net. [192.184.217.7])
        by smtp.gmail.com with ESMTPSA id b188-20020a62cfc5000000b00581fb8e665csm4393551pfg.67.2023.01.08.07.54.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Jan 2023 07:54:02 -0800 (PST)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     avarab@gmail.com, gitster@pobox.com,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: [PATCH v2] grep: correctly identify utf-8 characters with \{b,w} in -P
Date:   Sun,  8 Jan 2023 07:52:17 -0800
Message-Id: <20230108155217.2817-1-carenas@gmail.com>
X-Mailer: git-send-email 2.39.0.199.g555ddd67e6
In-Reply-To: <20230108062335.72114-1-carenas@gmail.com>
References: <20230108062335.72114-1-carenas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When UTF is enabled for a PCRE match, the corresponding flags are
added to the pcre2_compile() call, but PCRE2_UCP wasn't included.

This prevents extending the meaning of the character classes to
include those new valid characters and therefore result in failed
matches for expressions that rely on that extention, for ex:

  $ git grep -P '\bÆvar'

Add PCRE2_UCP so that \w will include Æ and therefore \b could
correctly match the beginning of that word.

This has an impact on performance that has been estimated to be
between 20% to 40% and that is shown through the added performance
test.

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
 grep.c                              |  2 +-
 t/perf/p7822-grep-perl-character.sh | 42 +++++++++++++++++++++++++++++
 2 files changed, 43 insertions(+), 1 deletion(-)
 create mode 100755 t/perf/p7822-grep-perl-character.sh

diff --git a/grep.c b/grep.c
index 06eed69493..1687f65b64 100644
--- a/grep.c
+++ b/grep.c
@@ -293,7 +293,7 @@ static void compile_pcre2_pattern(struct grep_pat *p, const struct grep_opt *opt
 		options |= PCRE2_CASELESS;
 	}
 	if (!opt->ignore_locale && is_utf8_locale() && !literal)
-		options |= (PCRE2_UTF | PCRE2_MATCH_INVALID_UTF);
+		options |= (PCRE2_UTF | PCRE2_UCP | PCRE2_MATCH_INVALID_UTF);
 
 #ifndef GIT_PCRE2_VERSION_10_36_OR_HIGHER
 	/* Work around https://bugs.exim.org/show_bug.cgi?id=2642 fixed in 10.36 */
diff --git a/t/perf/p7822-grep-perl-character.sh b/t/perf/p7822-grep-perl-character.sh
new file mode 100755
index 0000000000..87009c60df
--- /dev/null
+++ b/t/perf/p7822-grep-perl-character.sh
@@ -0,0 +1,42 @@
+#!/bin/sh
+
+test_description="git-grep's perl regex
+
+If GIT_PERF_GREP_THREADS is set to a list of threads (e.g. '1 4 8'
+etc.) we will test the patterns under those numbers of threads.
+"
+
+. ./perf-lib.sh
+
+test_perf_large_repo
+test_checkout_worktree
+
+if test -n "$GIT_PERF_GREP_THREADS"
+then
+	test_set_prereq PERF_GREP_ENGINES_THREADS
+fi
+
+for pattern in \
+	'\\bhow' \
+	'\\bÆvar' \
+	'\\d+ \\bÆvar' \
+	'\\bBelón\\b' \
+	'\\w{12}\\b'
+do
+	echo '$pattern' >pat
+	if ! test_have_prereq PERF_GREP_ENGINES_THREADS
+	then
+		test_perf "grep -P '$pattern'" --prereq PCRE "
+			git -P grep -f pat || :
+		"
+	else
+		for threads in $GIT_PERF_GREP_THREADS
+		do
+			test_perf "grep -P '$pattern' with $threads threads" --prereq PTHREADS,PCRE "
+				git -c grep.threads=$threads -P grep -f pat || :
+			"
+		done
+	fi
+done
+
+test_done
-- 
2.39.0.199.g555ddd67e6

