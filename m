Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5785C433EF
	for <git@archiver.kernel.org>; Mon, 13 Dec 2021 06:32:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232340AbhLMGcZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Dec 2021 01:32:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232297AbhLMGcQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Dec 2021 01:32:16 -0500
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C314EC061D60
        for <git@vger.kernel.org>; Sun, 12 Dec 2021 22:32:09 -0800 (PST)
Received: by mail-io1-xd30.google.com with SMTP id q72so17300028iod.12
        for <git@vger.kernel.org>; Sun, 12 Dec 2021 22:32:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mmhBWxqwjpgfEcyMowsTQ3vctc/dSWgSEKmTOODaLMQ=;
        b=jqWC7ndI8zCB3gOm0ODFwzapPU/nqDq7JFKisEqPUwvkv18GeBeva+V6GwdVzBMaUB
         f41fTgmcLFvCg+YXKoY7GhB0s0mJR7CDVMVUG4BcoKHrCxpz2TTpfCZ/oHW4yGNx1lQm
         78/4FA2+fxAc2Q3CiyAz4AERp6+lP7X+HVC2CJ3r75sfFuGObbNFBCoN3jXN9YQqo1oJ
         rGBAzk2j0OvovPL02VU6SGPH4AC7TXO73na/DL9sw1aTI/0p/37RIalnSMP/o3qjhKmF
         Xo8wlhA1NmSMsMwn9wVIqhZvS9nIpFxipAqhEOb6uY1jc6Q3cvECAUGcb3NgEbf3vGuE
         19JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=mmhBWxqwjpgfEcyMowsTQ3vctc/dSWgSEKmTOODaLMQ=;
        b=kCpZwme2/XS6fygmcOsNwpdw9PzHQ24CHbcL31kYUTc+fp4M+NBF5faMGoiqEEku4k
         vjuora5GlTAJA52xPILLtkwLfL+r3RhCaUAyOeeyQHIKJdpU49kh34dugeD59+QCgVqn
         72ReEpoOnKTZ34ool2NgTaWEPHTg5GoKO1gzLsQHPQBfGwElEezF87gf8hh62PpzcyYL
         bk7WQ85pEVONNeglYeMD6eNGB4QfgvAUAYB76XeZPjqBZVzPHaQ+z2/buY2losnHC4vr
         WKItUDCvwVkfcp5WJazGGshPlFSbpNZg1/cjvdRgyNpa8WaAzaO2GEzFGgQsonBK0wxf
         l11Q==
X-Gm-Message-State: AOAM5334QmzrRSSP6FGup7qg5Tzfwv+pKS9JWm48ZUm7My0qaZAaPI8e
        sityNKmV10PB9hlJFmq3TgvjBlfb4Xim5Q==
X-Google-Smtp-Source: ABdhPJy3Pk/nzZ0WjZYRBtEE5sLf4iA9ZcbInbtFK+IaHGjg3JWqXAJdTpV+MH0qO+SBohNBFay6OQ==
X-Received: by 2002:a05:6602:14cd:: with SMTP id b13mr32581103iow.203.1639377128648;
        Sun, 12 Dec 2021 22:32:08 -0800 (PST)
Received: from localhost.localdomain (097-069-216-153.res.spectrum.com. [97.69.216.153])
        by smtp.gmail.com with ESMTPSA id f10sm7305408ils.13.2021.12.12.22.32.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 12 Dec 2021 22:32:08 -0800 (PST)
Sender: Eric Sunshine <ericsunshine@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
        Fabian Stelzer <fs@gigacodes.de>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 14/15] chainlint.sed: swallow comments consistently
Date:   Mon, 13 Dec 2021 01:30:58 -0500
Message-Id: <20211213063059.19424-15-sunshine@sunshineco.com>
X-Mailer: git-send-email 2.34.1.397.gfae76fe5da
In-Reply-To: <20211213063059.19424-1-sunshine@sunshineco.com>
References: <20211213063059.19424-1-sunshine@sunshineco.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When checking for broken a &&-chain, chainlint.sed knows that the final
statement in a subshell should not end with `&&`, so it takes care to
make a distinction between the final line which is an actual statement
and any lines which may be mere comments preceding the closing ')'. As
such, it swallows comment lines so that they do not interfere with the
&&-chain check.

However, since `sed` does not provide any sort of real recursion,
chainlint.sed only checks &&-chains in subshells one level deep; it
doesn't do any checking in deeper subshells or in `{...}` blocks within
subshells. Furthermore, on account of potential implementation
complexity, it doesn't check &&-chains within `case` arms.

Due to an oversight, it also doesn't swallow comments inside deep
subshells, `{...}` blocks, or `case` statements, which makes its output
inconsistent (swallowing comments in some cases but not others).
Unfortunately, this inconsistency seeps into the chainlint self-test
"expect" files, which potentially makes it difficult to reuse the
self-tests should a more capable chainlint ever be developed. Therefore,
teach chainlint.sed to consistently swallow comments in all cases.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 t/chainlint.sed                            | 21 +++++++++++++++++++--
 t/chainlint/block-comment.expect           |  6 ++++++
 t/chainlint/block-comment.test             |  8 ++++++++
 t/chainlint/case-comment.expect            |  8 ++++++++
 t/chainlint/case-comment.test              | 11 +++++++++++
 t/chainlint/nested-subshell-comment.expect |  2 --
 6 files changed, 52 insertions(+), 4 deletions(-)
 create mode 100644 t/chainlint/block-comment.expect
 create mode 100644 t/chainlint/block-comment.test
 create mode 100644 t/chainlint/case-comment.expect
 create mode 100644 t/chainlint/case-comment.test

diff --git a/t/chainlint.sed b/t/chainlint.sed
index 0e575c0c62..b1505ef2cd 100644
--- a/t/chainlint.sed
+++ b/t/chainlint.sed
@@ -294,6 +294,12 @@ bfolded
 x
 s/?!HERE?!/<</g
 n
+:cascom
+/^[ 	]*#/{
+	N
+	s/.*\n//
+	bcascom
+}
 /^[ 	]*esac/bslurp
 bcase
 
@@ -322,10 +328,15 @@ x
 :nstslrp
 s/?!HERE?!/<</g
 n
+:nstcom
+# comment -- not closing ")" if in comment
+/^[ 	]*#/{
+	N
+	s/.*\n//
+	bnstcom
+}
 # closing ")" on own line -- stop nested slurp
 /^[ 	]*)/bnstcl
-# comment -- not closing ")" if in comment
-/^[ 	]*#/bnstcnt
 # "$((...))" -- arithmetic expansion; not closing ")"
 /\$(([^)][^)]*))[^)]*$/bnstcnt
 # "$(...)" -- command substitution; not closing ")"
@@ -345,6 +356,12 @@ bchkchn
 x
 s/?!HERE?!/<</g
 n
+:blkcom
+/^[ 	]*#/{
+	N
+	s/.*\n//
+	bblkcom
+}
 # closing "}" -- stop block slurp
 /}/bchkchn
 bblock
diff --git a/t/chainlint/block-comment.expect b/t/chainlint/block-comment.expect
new file mode 100644
index 0000000000..d10b2eeaf2
--- /dev/null
+++ b/t/chainlint/block-comment.expect
@@ -0,0 +1,6 @@
+(
+	{
+		echo a &&
+		echo b
+	}
+)
diff --git a/t/chainlint/block-comment.test b/t/chainlint/block-comment.test
new file mode 100644
index 0000000000..df2beea888
--- /dev/null
+++ b/t/chainlint/block-comment.test
@@ -0,0 +1,8 @@
+(
+	{
+		# show a
+		echo a &&
+		# show b
+		echo b
+	}
+)
diff --git a/t/chainlint/case-comment.expect b/t/chainlint/case-comment.expect
new file mode 100644
index 0000000000..1e4b054bda
--- /dev/null
+++ b/t/chainlint/case-comment.expect
@@ -0,0 +1,8 @@
+(
+	case "$x" in
+	x) foo ;;
+	*)
+		bar
+		;;
+	esac
+)
diff --git a/t/chainlint/case-comment.test b/t/chainlint/case-comment.test
new file mode 100644
index 0000000000..641c157b98
--- /dev/null
+++ b/t/chainlint/case-comment.test
@@ -0,0 +1,11 @@
+(
+	case "$x" in
+	# found foo
+	x) foo ;;
+	# found other
+	*)
+		# treat it as bar
+		bar
+		;;
+	esac
+)
diff --git a/t/chainlint/nested-subshell-comment.expect b/t/chainlint/nested-subshell-comment.expect
index 9138cf386d..be4b27a305 100644
--- a/t/chainlint/nested-subshell-comment.expect
+++ b/t/chainlint/nested-subshell-comment.expect
@@ -2,8 +2,6 @@
 	foo &&
 	(
 		bar &&
-		# bottles wobble while fiddles gobble
-		# minor numbers of cows (or do they?)
 		baz &&
 		snaff
 	) ?!AMP?!
-- 
2.34.1.397.gfae76fe5da

