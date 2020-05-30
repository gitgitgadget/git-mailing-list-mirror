Return-Path: <SRS0=ERGy=7M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B583C433E0
	for <git@archiver.kernel.org>; Sat, 30 May 2020 20:26:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5ABA120776
	for <git@archiver.kernel.org>; Sat, 30 May 2020 20:26:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="atRZs3HZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729297AbgE3U0D (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 30 May 2020 16:26:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726211AbgE3U0C (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 May 2020 16:26:02 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6530CC03E969
        for <git@vger.kernel.org>; Sat, 30 May 2020 13:26:01 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id f5so7523074wmh.2
        for <git@vger.kernel.org>; Sat, 30 May 2020 13:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=N4rv3zxXJYjCoHuVCQInMQFmMcV4hvQQhL2K9kGwpNI=;
        b=atRZs3HZGnn4tvKihyM+aqMSv11Y1ObTgjd1uS2Bj4qL1CWF+3jqrPU2APUfO6iNdO
         ZVwGipp1SLN7nXjfokNXK7GZ6VC+V5dSnyBRKCikf1q6HI07BuB3OIQKzT65Dlo2aaS6
         UnMYpgp5lCYZjOqzKIOoDuFzyySQi1lxTzpGF3SKlvroR8sbyf2Raj020TsNovbeRn6s
         CdGSYWl4xpEcXTRp0rbZUb7uNqN6moMTsrJIbcSzgcYF4I6o2UksHezSVC0Xgm/V4l25
         Jmg8GIAQ6GNo4rpENgiWpPOesrFBDnB/KURC38oAM1jlFtpNO4+RxpaRpDNnOtJsipY6
         XqJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=N4rv3zxXJYjCoHuVCQInMQFmMcV4hvQQhL2K9kGwpNI=;
        b=JCUzgOl9QSl/5xZ+RXVp/Y3rWUmqywP0XoLo0rfbYYFxKjvXS60s6CjHlWSBViaGcm
         E8W8ivP2YxYPT/BN9hqkvMcx+TzRCzk2n/7Xa8m157Fb2Cb2N1DeWibFvEyb6pAkoAdC
         xNmKzuH3Ibhud1p9vBI+CqSqrOt2/BgLQdORVU3q3jjTwiczAg8t2CVBBgGzIKXDXeoR
         JFZhi7GPE73EulmHLcBXYXF2O8C+UmekcBcf+USrna8iNCYU14U0IqVbSBdxeX4YL9PU
         HxEue6quf3tQNv5dUAekRWUPdTqrsuuCvhh3dWi6CxdOC7Dp4QXWtMrLIpCysR3AZQLU
         sMsQ==
X-Gm-Message-State: AOAM531M5Rw+Y+ONIVHzNCKkcMYVDswLSdpe87zlEiIdsCvM6Rt6Cn2r
        BvUIxZOMKU6gTmEPITD13h2mtC0d
X-Google-Smtp-Source: ABdhPJznSIKEQcz5WMdoH6EfzV2Gb927jVB0BNSfOUrUDokRjNY9olUjGSL3Tv2HCgXqvCWThfT+Mw==
X-Received: by 2002:a1c:46c3:: with SMTP id t186mr13779195wma.36.1590870359743;
        Sat, 30 May 2020 13:25:59 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i74sm14841500wri.49.2020.05.30.13.25.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 May 2020 13:25:58 -0700 (PDT)
Message-Id: <pull.795.v3.git.git.1590870357549.gitgitgadget@gmail.com>
In-Reply-To: <pull.795.v2.git.git.1590698437607.gitgitgadget@gmail.com>
References: <pull.795.v2.git.git.1590698437607.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 30 May 2020 20:25:57 +0000
Subject: [PATCH v3] fast-import: add new --date-format=raw-permissive format
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     peff@peff.net, jrnieder@gmail.com,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

There are multiple repositories in the wild with random, invalid
timezones.  Most notably is a commit from rails.git with a timezone of
"+051800"[1].  A few searches will find other repos with that same
invalid timezone as well.  Further, Peff reports that GitHub relaxed
their fsck checks in August 2011 to accept any timezone value[2], and
there have been multiple reports to filter-repo about fast-import
crashing while trying to import their existing repositories since they
had timezone values such as "-7349423" and "-43455309"[3].

The existing check on timezone values inside fast-import may prove
useful for people who are crafting fast-import input by hand or with a
new script.  For them, the check may help them avoid accidentally
recording invalid dates.  (Note that this check is rather simplistic and
there are still several forms of invalid dates that fast-import does not
check for: dates in the future, timezone values with minutes that are
not divisible by 15, and timezone values with minutes that are 60 or
greater.)  While this simple check may have some value for those users,
other users or tools will want to import existing repositories as-is.
Provide a --date-format=raw-permissive format that will not error out on
these otherwise invalid timezones so that such existing repositories can
be imported.

[1] https://github.com/rails/rails/commit/4cf94979c9f4d6683c9338d694d5eb3106a4e734
[2] https://lore.kernel.org/git/20200521195513.GA1542632@coredump.intra.peff.net/
[3] https://github.com/newren/git-filter-repo/issues/88

Signed-off-by: Elijah Newren <newren@gmail.com>
---
    fast-import: accept invalid timezones so we can import existing repos
    
    Changes since v2:
    
     * Add documentation
     * Note the fact that the "strict" method really isn't all that strict
       with some NEEDSWORK comments
     * Check for parsed as unsigned before checking that value range makes
       sense
     * Simplify the testcase as suggested by Peff, leaving it to stick out a
       bit like a sore thumb from the rest of the tests in the same file
       (#leftoverbits)

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-795%2Fnewren%2Floosen-fast-import-timezone-parsing-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-795/newren/loosen-fast-import-timezone-parsing-v3
Pull-Request: https://github.com/git/git/pull/795

Range-diff vs v2:

 1:  9580aacdb21 ! 1:  48326d16dbd fast-import: add new --date-format=raw-permissive format
     @@ Commit message
      
          Signed-off-by: Elijah Newren <newren@gmail.com>
      
     + ## Documentation/git-fast-import.txt ##
     +@@ Documentation/git-fast-import.txt: by users who are located in the same location and time zone.  In this
     + case a reasonable offset from UTC could be assumed.
     + +
     + Unlike the `rfc2822` format, this format is very strict.  Any
     +-variation in formatting will cause fast-import to reject the value.
     ++variation in formatting will cause fast-import to reject the value,
     ++and some sanity checks on the numeric values may also be performed.
     ++
     ++`raw-permissive`::
     ++	This is the same as `raw` except that no sanity checks on
     ++	the numeric epoch and local offset are performed.  This can
     ++	be useful when trying to filter or import an existing history
     ++	with e.g. bogus timezone values.
     + 
     + `rfc2822`::
     + 	This is the standard email format as described by RFC 2822.
     +
       ## fast-import.c ##
      @@ fast-import.c: struct hash_list {
       
     @@ fast-import.c: static int parse_data(struct strbuf *sb, uintmax_t limit, uintmax
       {
       	const char *orig_src = src;
       	char *endp;
     - 	unsigned long num;
     -+	int out_of_range_timezone;
     - 
     +@@ fast-import.c: static int validate_raw_date(const char *src, struct strbuf *result)
       	errno = 0;
       
     + 	num = strtoul(src, &endp, 10);
     +-	/* NEEDSWORK: perhaps check for reasonable values? */
     ++	/*
     ++	 * NEEDSWORK: perhaps check for reasonable values? For example, we
     ++	 *            could error on values representing times more than a
     ++	 *            day in the future.
     ++	 */
     + 	if (errno || endp == src || *endp != ' ')
     + 		return -1;
     + 
      @@ fast-import.c: static int validate_raw_date(const char *src, struct strbuf *result)
       		return -1;
       
       	num = strtoul(src + 1, &endp, 10);
      -	if (errno || endp == src + 1 || *endp || 1400 < num)
     -+	out_of_range_timezone = strict && (1400 < num);
     -+	if (errno || endp == src + 1 || *endp || out_of_range_timezone)
     ++	/*
     ++	 * NEEDSWORK: check for brokenness other than num > 1400, such as
     ++	 *            (num % 100) >= 60, or ((num % 100) % 15) != 0 ?
     ++	 */
     ++	if (errno || endp == src + 1 || *endp || /* did not parse */
     ++	    (strict && (1400 < num))             /* parsed a broken timezone */
     ++	   )
       		return -1;
       
       	strbuf_addstr(result, orig_src);
     @@ t/t9300-fast-import.sh: test_expect_success 'B: accept empty committer' '
      +	COMMIT
      +	INPUT_END
      +
     -+	test_when_finished "git update-ref -d refs/heads/invalid-timezone
     -+		git gc
     -+		git prune" &&
     -+	git fast-import --date-format=raw-permissive <input &&
     -+	git cat-file -p invalid-timezone >out &&
     ++	git init invalid-timezone &&
     ++	git -C invalid-timezone fast-import --date-format=raw-permissive <input &&
     ++	git -C invalid-timezone cat-file -p invalid-timezone >out &&
      +	grep "1234567890 [+]051800" out
      +'
      +


 Documentation/git-fast-import.txt |  9 ++++++++-
 fast-import.c                     | 25 +++++++++++++++++++++----
 t/t9300-fast-import.sh            | 28 ++++++++++++++++++++++++++++
 3 files changed, 57 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-fast-import.txt b/Documentation/git-fast-import.txt
index 77c6b3d0019..7d9aad2a7e1 100644
--- a/Documentation/git-fast-import.txt
+++ b/Documentation/git-fast-import.txt
@@ -293,7 +293,14 @@ by users who are located in the same location and time zone.  In this
 case a reasonable offset from UTC could be assumed.
 +
 Unlike the `rfc2822` format, this format is very strict.  Any
-variation in formatting will cause fast-import to reject the value.
+variation in formatting will cause fast-import to reject the value,
+and some sanity checks on the numeric values may also be performed.
+
+`raw-permissive`::
+	This is the same as `raw` except that no sanity checks on
+	the numeric epoch and local offset are performed.  This can
+	be useful when trying to filter or import an existing history
+	with e.g. bogus timezone values.
 
 `rfc2822`::
 	This is the standard email format as described by RFC 2822.
diff --git a/fast-import.c b/fast-import.c
index c98970274c4..0dfa14dc8c3 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -139,6 +139,7 @@ struct hash_list {
 
 typedef enum {
 	WHENSPEC_RAW = 1,
+	WHENSPEC_RAW_PERMISSIVE,
 	WHENSPEC_RFC2822,
 	WHENSPEC_NOW
 } whenspec_type;
@@ -1911,7 +1912,7 @@ static int parse_data(struct strbuf *sb, uintmax_t limit, uintmax_t *len_res)
 	return 1;
 }
 
-static int validate_raw_date(const char *src, struct strbuf *result)
+static int validate_raw_date(const char *src, struct strbuf *result, int strict)
 {
 	const char *orig_src = src;
 	char *endp;
@@ -1920,7 +1921,11 @@ static int validate_raw_date(const char *src, struct strbuf *result)
 	errno = 0;
 
 	num = strtoul(src, &endp, 10);
-	/* NEEDSWORK: perhaps check for reasonable values? */
+	/*
+	 * NEEDSWORK: perhaps check for reasonable values? For example, we
+	 *            could error on values representing times more than a
+	 *            day in the future.
+	 */
 	if (errno || endp == src || *endp != ' ')
 		return -1;
 
@@ -1929,7 +1934,13 @@ static int validate_raw_date(const char *src, struct strbuf *result)
 		return -1;
 
 	num = strtoul(src + 1, &endp, 10);
-	if (errno || endp == src + 1 || *endp || 1400 < num)
+	/*
+	 * NEEDSWORK: check for brokenness other than num > 1400, such as
+	 *            (num % 100) >= 60, or ((num % 100) % 15) != 0 ?
+	 */
+	if (errno || endp == src + 1 || *endp || /* did not parse */
+	    (strict && (1400 < num))             /* parsed a broken timezone */
+	   )
 		return -1;
 
 	strbuf_addstr(result, orig_src);
@@ -1963,7 +1974,11 @@ static char *parse_ident(const char *buf)
 
 	switch (whenspec) {
 	case WHENSPEC_RAW:
-		if (validate_raw_date(ltgt, &ident) < 0)
+		if (validate_raw_date(ltgt, &ident, 1) < 0)
+			die("Invalid raw date \"%s\" in ident: %s", ltgt, buf);
+		break;
+	case WHENSPEC_RAW_PERMISSIVE:
+		if (validate_raw_date(ltgt, &ident, 0) < 0)
 			die("Invalid raw date \"%s\" in ident: %s", ltgt, buf);
 		break;
 	case WHENSPEC_RFC2822:
@@ -3258,6 +3273,8 @@ static void option_date_format(const char *fmt)
 {
 	if (!strcmp(fmt, "raw"))
 		whenspec = WHENSPEC_RAW;
+	else if (!strcmp(fmt, "raw-permissive"))
+		whenspec = WHENSPEC_RAW_PERMISSIVE;
 	else if (!strcmp(fmt, "rfc2822"))
 		whenspec = WHENSPEC_RFC2822;
 	else if (!strcmp(fmt, "now"))
diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index 768257b29e0..e151df81c06 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -410,6 +410,34 @@ test_expect_success 'B: accept empty committer' '
 	test -z "$out"
 '
 
+test_expect_success 'B: reject invalid timezone' '
+	cat >input <<-INPUT_END &&
+	commit refs/heads/invalid-timezone
+	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 1234567890 +051800
+	data <<COMMIT
+	empty commit
+	COMMIT
+	INPUT_END
+
+	test_when_finished "git update-ref -d refs/heads/invalid-timezone" &&
+	test_must_fail git fast-import <input
+'
+
+test_expect_success 'B: accept invalid timezone with raw-permissive' '
+	cat >input <<-INPUT_END &&
+	commit refs/heads/invalid-timezone
+	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 1234567890 +051800
+	data <<COMMIT
+	empty commit
+	COMMIT
+	INPUT_END
+
+	git init invalid-timezone &&
+	git -C invalid-timezone fast-import --date-format=raw-permissive <input &&
+	git -C invalid-timezone cat-file -p invalid-timezone >out &&
+	grep "1234567890 [+]051800" out
+'
+
 test_expect_success 'B: accept and fixup committer with no name' '
 	cat >input <<-INPUT_END &&
 	commit refs/heads/empty-committer-2

base-commit: 2d5e9f31ac46017895ce6a183467037d29ceb9d3
-- 
gitgitgadget
