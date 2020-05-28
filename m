Return-Path: <SRS0=eul5=7K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E36FC433DF
	for <git@archiver.kernel.org>; Thu, 28 May 2020 19:15:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3CD442072D
	for <git@archiver.kernel.org>; Thu, 28 May 2020 19:15:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rhez3awM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406204AbgE1TPR (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 May 2020 15:15:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406126AbgE1TPQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 May 2020 15:15:16 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B797CC08C5C6
        for <git@vger.kernel.org>; Thu, 28 May 2020 12:15:15 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id f5so201257wmh.2
        for <git@vger.kernel.org>; Thu, 28 May 2020 12:15:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=QD+wIwRoXiGW7liaWgtIO7g8EEzzKs6KZuh4+m+bggg=;
        b=Rhez3awMJgrAY9cLLlWCUnUTqbWgFPBi/T3g+wNXda097bKN7E+2pH3+oeGaBxxvXf
         4psW/d7ISqWu1gkyyGZOB8D/3Y0Eanj6R9HG30vedIkMJM6PKmJAFZWPJsS76hDYhrgU
         AtaKtukqUlA8JQR+V2/cDqxGrh/HwInMlExCeTTyFWquQzIh9Y5D+cwQ7KMIwwRKoXxT
         Z8gvHKNOmbRPzG+8EFERXBtWQ8V/Sk6Moa+RmSerRb4zc/etZtUsL6Q5qx5JIHAcATAm
         mz0golYkXiWSLMOZFbjqHejFiLEv06ERESyeG9HIW070qtghIFyD0q/HbZPZZYCaf83Q
         uLpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=QD+wIwRoXiGW7liaWgtIO7g8EEzzKs6KZuh4+m+bggg=;
        b=FprpTa6NK8HMpqWaUEDXZRcbTd6DOcmC1358HG+ZDHV58aM9OcqaS/WNB8KULJRHSz
         RqOEUbIs/Mspzwchj4mW7pTs+QDoJjiprKehg0pyfkawWQFbcFLeLRKJRqPKoa8+0LLV
         /B0tFfANksJHle1JXX4BxiJk1pK3W7HriMf7GedXrxw+2X1j92BDEoiZ/p41fjobMBce
         qZs9z2vpAp94YpCpKYVgLDwrX4lZvci7f7tTzUKTL5GH37Jw933OBH8xGwEYK3ND6Vtn
         KUjkhyyt0SQ1Zwrbm1H8qD/DpgS/aV3JkBxQnzl39BaN/icAZAaVSY6Wi/HbO/BA1Cm8
         NaFA==
X-Gm-Message-State: AOAM532/QJcQBft2TlhHP/dFre+FJaLZm+GVM3PRwXW1NqvyCJUHE8L+
        6h1gGx+uzuew4Y+7qD5qP1ELKQh4
X-Google-Smtp-Source: ABdhPJy0/oGFlOUFyJ4H7l3BLGa2UzhkgjROjeTeA7xzA8Qj3F8DYnpMDsu11jv16tXoK+i01n/Vbg==
X-Received: by 2002:a05:600c:2256:: with SMTP id a22mr4661608wmm.18.1590693314149;
        Thu, 28 May 2020 12:15:14 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 23sm7006052wmg.10.2020.05.28.12.15.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2020 12:15:13 -0700 (PDT)
Message-Id: <pull.795.git.git.1590693313099.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 28 May 2020 19:15:12 +0000
Subject: [PATCH] fast-import: accept invalid timezones so we can import
 existing repos
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     peff@peff.net, Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

There are multiple repositories in the wild with random, invalid
timezones.  Most notably is a commit from rails.git with a timezone of
"+051800"[1].  However, a few searches found other repos with that same
invalid timezone.  Further, Peff reports that GitHub relaxed their fsck
checks in August 2011 to accept any timezone value[2], and there have
been multiple reports to filter-repo about fast-import crashing while
trying to import their existing repositories since they had timezone
values such as "-7349423" and "-43455309"[3].

It is not clear what created these invalid timezones, but since git has
permitted their use and worked with these repositories for years at this
point, it seems pointless to make fast-import be the only thing that
disallows them.  Relax the parsing to allow these timezones when using
raw import format; when using --date-format=rfc2822 (which is not the
default), we can continue being more strict about timezones.

[1] https://github.com/rails/rails/commit/4cf94979c9f4d6683c9338d694d5eb3106a4e734
[2] https://lore.kernel.org/git/20200521195513.GA1542632@coredump.intra.peff.net/
[3] https://github.com/newren/git-filter-repo/issues/88

Signed-off-by: Elijah Newren <newren@gmail.com>
---
    fast-import: accept invalid timezones so we can import existing repos
    
    Note: this is not a fix for a regression, so you can ignore it for 2.27;
    it can sit in pu.
    
    Peff leaned towards normalizing these timezones in fast-export[1], but
    (A) it's not clear what "valid" timezone we should randomly pick and
    regardless of what we pick, it seems it'll be wrong for most cases, (B)
    it would provide yet another way that "git fast-export --all | git
    fast-import" would not preserve the original history, as users sometimes
    expect[2], and (C) that'd prevent users from passing a special callback
    to filter-repo to fix up these values[3].
    
    Since I'm not a fan of picking a random value to reassign these to (in
    either fast-export or fast-import), I went the route of relaxing the
    requirements in fast-import, similar to what Peff reports GitHub did
    about 9 years ago in their incoming fsck checks.
    
    [1] 
    https://lore.kernel.org/git/20200521195513.GA1542632@coredump.intra.peff.net/
    [2] 
    https://lore.kernel.org/git/CABPp-BFLJ48BZ97Y9mr4i3q7HMqjq18cXMgSYdxqD1cMzH8Spg@mail.gmail.com/
    [3] Example: 
    https://github.com/newren/git-filter-repo/issues/88#issuecomment-629706776

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-795%2Fnewren%2Floosen-fast-import-timezone-parsing-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-795/newren/loosen-fast-import-timezone-parsing-v1
Pull-Request: https://github.com/git/git/pull/795

 fast-import.c          |  7 +++----
 t/t9300-fast-import.sh | 17 +++++++++++++++++
 2 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/fast-import.c b/fast-import.c
index c98970274c4..4a3c193007d 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -1915,11 +1915,10 @@ static int validate_raw_date(const char *src, struct strbuf *result)
 {
 	const char *orig_src = src;
 	char *endp;
-	unsigned long num;
 
 	errno = 0;
 
-	num = strtoul(src, &endp, 10);
+	strtoul(src, &endp, 10);
 	/* NEEDSWORK: perhaps check for reasonable values? */
 	if (errno || endp == src || *endp != ' ')
 		return -1;
@@ -1928,8 +1927,8 @@ static int validate_raw_date(const char *src, struct strbuf *result)
 	if (*src != '-' && *src != '+')
 		return -1;
 
-	num = strtoul(src + 1, &endp, 10);
-	if (errno || endp == src + 1 || *endp || 1400 < num)
+	strtoul(src + 1, &endp, 10);
+	if (errno || endp == src + 1 || *endp)
 		return -1;
 
 	strbuf_addstr(result, orig_src);
diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index 768257b29e0..0e798e68476 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -410,6 +410,23 @@ test_expect_success 'B: accept empty committer' '
 	test -z "$out"
 '
 
+test_expect_success 'B: accept invalid timezone' '
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
+	git fast-import <input &&
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
