Return-Path: <SRS0=eul5=7K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C9D7C433E0
	for <git@archiver.kernel.org>; Thu, 28 May 2020 20:40:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D51BA2073B
	for <git@archiver.kernel.org>; Thu, 28 May 2020 20:40:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hDfqRn0r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407295AbgE1Ukn (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 May 2020 16:40:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407189AbgE1Ukk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 May 2020 16:40:40 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D403C08C5C6
        for <git@vger.kernel.org>; Thu, 28 May 2020 13:40:40 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id f5so549808wmh.2
        for <git@vger.kernel.org>; Thu, 28 May 2020 13:40:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=in2WxSAcPzX8/WEZIfZ+dFoaOqjX9+rn1+2+/MiES90=;
        b=hDfqRn0rQymQXryQCtfgyAWPLEr7S7QEETP5c4zuX61LFcz34VJbAj3oDkmSJJgXFn
         6yOUkSdwKEse38/jX/NyfYt3TNnaNsqY7Bb1BCLG20IQxyO/A7NkYB5t3lvTh5tVeXpq
         PA0wWSavIhgvWt+n5fapnGgrDSkkUUrjCLKjyVaFC1V1qamSyD0ZsdEK/X8ySzn7qrl3
         sD30GZqnZl/DNc4JfhLYsVbuxTRcQKxrDdSLwa2uf85Jo550kMMDEGkkaKT8TYC1k/8a
         CWWovBwHaeoAzHmY5okfKF74WhXpAnle+mmvZvlQZIhupLyBufMzaTEdh8jiyLKGkR4m
         zaPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=in2WxSAcPzX8/WEZIfZ+dFoaOqjX9+rn1+2+/MiES90=;
        b=KQt8J1/JnwIHr2Rq3K5yvxz/N2Fpv2Sy+1wTwyBE3G5cgDFMkCHXtV7LvVgc7pKrZb
         /EvDNIZPFYWZt1IkHRKDMqbyxdJsLMotQ1AigaxL3Tr0tKFos/SZRB8Cds0kY3wd7FXx
         bm/2iv8byCeOhHl97jXQBW9KdnfRa/85s8mNy9s/SAb3MOBWcwZze5rA+oEjsrmfq08x
         RQKrOH0JEnwm//vrHJLCTUu02yV1H4SjzMDB3WKtulZpwFFc7xIx4Ihiybj/8Rn0rN5C
         OYJ1Z7dL1kPZTIHF3cq8KUp04IxXFlCPKuugfRNayJKPdv3Xr2OGr1Gn5/XRiaUMqxee
         hQ8g==
X-Gm-Message-State: AOAM532O/20LUI0cXvplBBziQb2MbCLxvJ5ZrV/VQ45W42vmB4EqxwAi
        wcd/pP09t+qs5dgRNtrfdmLmgALW
X-Google-Smtp-Source: ABdhPJwWUrKspLNwkSjFSCubXuwsu+Zx5Z5ot6Hb7psNOJuuQt6BoTJFySroZtyNuIe3fjOKc1WCYg==
X-Received: by 2002:a1c:6446:: with SMTP id y67mr4611113wmb.156.1590698438675;
        Thu, 28 May 2020 13:40:38 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n23sm5749640wmc.0.2020.05.28.13.40.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2020 13:40:38 -0700 (PDT)
Message-Id: <pull.795.v2.git.git.1590698437607.gitgitgadget@gmail.com>
In-Reply-To: <pull.795.git.git.1590693313099.gitgitgadget@gmail.com>
References: <pull.795.git.git.1590693313099.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 28 May 2020 20:40:37 +0000
Subject: [PATCH v2] fast-import: add new --date-format=raw-permissive format
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
    
    Changes since v1:
    
     * Instead of just allowing such timezones outright, did it behind a
       --date-format=raw-permissive as suggested by Jonathan

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-795%2Fnewren%2Floosen-fast-import-timezone-parsing-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-795/newren/loosen-fast-import-timezone-parsing-v2
Pull-Request: https://github.com/git/git/pull/795

Range-diff vs v1:

 1:  d3a7dbc3892 ! 1:  9580aacdb21 fast-import: accept invalid timezones so we can import existing repos
     @@ Metadata
      Author: Elijah Newren <newren@gmail.com>
      
       ## Commit message ##
     -    fast-import: accept invalid timezones so we can import existing repos
     +    fast-import: add new --date-format=raw-permissive format
      
          There are multiple repositories in the wild with random, invalid
          timezones.  Most notably is a commit from rails.git with a timezone of
     -    "+051800"[1].  However, a few searches found other repos with that same
     -    invalid timezone.  Further, Peff reports that GitHub relaxed their fsck
     -    checks in August 2011 to accept any timezone value[2], and there have
     -    been multiple reports to filter-repo about fast-import crashing while
     -    trying to import their existing repositories since they had timezone
     -    values such as "-7349423" and "-43455309"[3].
     +    "+051800"[1].  A few searches will find other repos with that same
     +    invalid timezone as well.  Further, Peff reports that GitHub relaxed
     +    their fsck checks in August 2011 to accept any timezone value[2], and
     +    there have been multiple reports to filter-repo about fast-import
     +    crashing while trying to import their existing repositories since they
     +    had timezone values such as "-7349423" and "-43455309"[3].
      
     -    It is not clear what created these invalid timezones, but since git has
     -    permitted their use and worked with these repositories for years at this
     -    point, it seems pointless to make fast-import be the only thing that
     -    disallows them.  Relax the parsing to allow these timezones when using
     -    raw import format; when using --date-format=rfc2822 (which is not the
     -    default), we can continue being more strict about timezones.
     +    The existing check on timezone values inside fast-import may prove
     +    useful for people who are crafting fast-import input by hand or with a
     +    new script.  For them, the check may help them avoid accidentally
     +    recording invalid dates.  (Note that this check is rather simplistic and
     +    there are still several forms of invalid dates that fast-import does not
     +    check for: dates in the future, timezone values with minutes that are
     +    not divisible by 15, and timezone values with minutes that are 60 or
     +    greater.)  While this simple check may have some value for those users,
     +    other users or tools will want to import existing repositories as-is.
     +    Provide a --date-format=raw-permissive format that will not error out on
     +    these otherwise invalid timezones so that such existing repositories can
     +    be imported.
      
          [1] https://github.com/rails/rails/commit/4cf94979c9f4d6683c9338d694d5eb3106a4e734
          [2] https://lore.kernel.org/git/20200521195513.GA1542632@coredump.intra.peff.net/
     @@ Commit message
          Signed-off-by: Elijah Newren <newren@gmail.com>
      
       ## fast-import.c ##
     -@@ fast-import.c: static int validate_raw_date(const char *src, struct strbuf *result)
     +@@ fast-import.c: struct hash_list {
     + 
     + typedef enum {
     + 	WHENSPEC_RAW = 1,
     ++	WHENSPEC_RAW_PERMISSIVE,
     + 	WHENSPEC_RFC2822,
     + 	WHENSPEC_NOW
     + } whenspec_type;
     +@@ fast-import.c: static int parse_data(struct strbuf *sb, uintmax_t limit, uintmax_t *len_res)
     + 	return 1;
     + }
     + 
     +-static int validate_raw_date(const char *src, struct strbuf *result)
     ++static int validate_raw_date(const char *src, struct strbuf *result, int strict)
       {
       	const char *orig_src = src;
       	char *endp;
     --	unsigned long num;
     + 	unsigned long num;
     ++	int out_of_range_timezone;
       
       	errno = 0;
       
     --	num = strtoul(src, &endp, 10);
     -+	strtoul(src, &endp, 10);
     - 	/* NEEDSWORK: perhaps check for reasonable values? */
     - 	if (errno || endp == src || *endp != ' ')
     - 		return -1;
      @@ fast-import.c: static int validate_raw_date(const char *src, struct strbuf *result)
     - 	if (*src != '-' && *src != '+')
       		return -1;
       
     --	num = strtoul(src + 1, &endp, 10);
     + 	num = strtoul(src + 1, &endp, 10);
      -	if (errno || endp == src + 1 || *endp || 1400 < num)
     -+	strtoul(src + 1, &endp, 10);
     -+	if (errno || endp == src + 1 || *endp)
     ++	out_of_range_timezone = strict && (1400 < num);
     ++	if (errno || endp == src + 1 || *endp || out_of_range_timezone)
       		return -1;
       
       	strbuf_addstr(result, orig_src);
     +@@ fast-import.c: static char *parse_ident(const char *buf)
     + 
     + 	switch (whenspec) {
     + 	case WHENSPEC_RAW:
     +-		if (validate_raw_date(ltgt, &ident) < 0)
     ++		if (validate_raw_date(ltgt, &ident, 1) < 0)
     ++			die("Invalid raw date \"%s\" in ident: %s", ltgt, buf);
     ++		break;
     ++	case WHENSPEC_RAW_PERMISSIVE:
     ++		if (validate_raw_date(ltgt, &ident, 0) < 0)
     + 			die("Invalid raw date \"%s\" in ident: %s", ltgt, buf);
     + 		break;
     + 	case WHENSPEC_RFC2822:
     +@@ fast-import.c: static void option_date_format(const char *fmt)
     + {
     + 	if (!strcmp(fmt, "raw"))
     + 		whenspec = WHENSPEC_RAW;
     ++	else if (!strcmp(fmt, "raw-permissive"))
     ++		whenspec = WHENSPEC_RAW_PERMISSIVE;
     + 	else if (!strcmp(fmt, "rfc2822"))
     + 		whenspec = WHENSPEC_RFC2822;
     + 	else if (!strcmp(fmt, "now"))
      
       ## t/t9300-fast-import.sh ##
      @@ t/t9300-fast-import.sh: test_expect_success 'B: accept empty committer' '
       	test -z "$out"
       '
       
     -+test_expect_success 'B: accept invalid timezone' '
     ++test_expect_success 'B: reject invalid timezone' '
     ++	cat >input <<-INPUT_END &&
     ++	commit refs/heads/invalid-timezone
     ++	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 1234567890 +051800
     ++	data <<COMMIT
     ++	empty commit
     ++	COMMIT
     ++	INPUT_END
     ++
     ++	test_when_finished "git update-ref -d refs/heads/invalid-timezone" &&
     ++	test_must_fail git fast-import <input
     ++'
     ++
     ++test_expect_success 'B: accept invalid timezone with raw-permissive' '
      +	cat >input <<-INPUT_END &&
      +	commit refs/heads/invalid-timezone
      +	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 1234567890 +051800
     @@ t/t9300-fast-import.sh: test_expect_success 'B: accept empty committer' '
      +	test_when_finished "git update-ref -d refs/heads/invalid-timezone
      +		git gc
      +		git prune" &&
     -+	git fast-import <input &&
     ++	git fast-import --date-format=raw-permissive <input &&
      +	git cat-file -p invalid-timezone >out &&
      +	grep "1234567890 [+]051800" out
      +'


 fast-import.c          | 15 ++++++++++++---
 t/t9300-fast-import.sh | 30 ++++++++++++++++++++++++++++++
 2 files changed, 42 insertions(+), 3 deletions(-)

diff --git a/fast-import.c b/fast-import.c
index c98970274c4..74d7298bc5a 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -139,6 +139,7 @@ struct hash_list {
 
 typedef enum {
 	WHENSPEC_RAW = 1,
+	WHENSPEC_RAW_PERMISSIVE,
 	WHENSPEC_RFC2822,
 	WHENSPEC_NOW
 } whenspec_type;
@@ -1911,11 +1912,12 @@ static int parse_data(struct strbuf *sb, uintmax_t limit, uintmax_t *len_res)
 	return 1;
 }
 
-static int validate_raw_date(const char *src, struct strbuf *result)
+static int validate_raw_date(const char *src, struct strbuf *result, int strict)
 {
 	const char *orig_src = src;
 	char *endp;
 	unsigned long num;
+	int out_of_range_timezone;
 
 	errno = 0;
 
@@ -1929,7 +1931,8 @@ static int validate_raw_date(const char *src, struct strbuf *result)
 		return -1;
 
 	num = strtoul(src + 1, &endp, 10);
-	if (errno || endp == src + 1 || *endp || 1400 < num)
+	out_of_range_timezone = strict && (1400 < num);
+	if (errno || endp == src + 1 || *endp || out_of_range_timezone)
 		return -1;
 
 	strbuf_addstr(result, orig_src);
@@ -1963,7 +1966,11 @@ static char *parse_ident(const char *buf)
 
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
@@ -3258,6 +3265,8 @@ static void option_date_format(const char *fmt)
 {
 	if (!strcmp(fmt, "raw"))
 		whenspec = WHENSPEC_RAW;
+	else if (!strcmp(fmt, "raw-permissive"))
+		whenspec = WHENSPEC_RAW_PERMISSIVE;
 	else if (!strcmp(fmt, "rfc2822"))
 		whenspec = WHENSPEC_RFC2822;
 	else if (!strcmp(fmt, "now"))
diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index 768257b29e0..14e9baa22db 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -410,6 +410,36 @@ test_expect_success 'B: accept empty committer' '
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
+	test_when_finished "git update-ref -d refs/heads/invalid-timezone
+		git gc
+		git prune" &&
+	git fast-import --date-format=raw-permissive <input &&
+	git cat-file -p invalid-timezone >out &&
+	grep "1234567890 [+]051800" out
+'
+
 test_expect_success 'B: accept and fixup committer with no name' '
 	cat >input <<-INPUT_END &&
 	commit refs/heads/empty-committer-2

base-commit: 2d5e9f31ac46017895ce6a183467037d29ceb9d3
-- 
gitgitgadget
