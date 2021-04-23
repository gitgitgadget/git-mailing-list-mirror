Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 173BFC433B4
	for <git@archiver.kernel.org>; Fri, 23 Apr 2021 16:27:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B2481611C1
	for <git@archiver.kernel.org>; Fri, 23 Apr 2021 16:27:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230283AbhDWQ2E (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Apr 2021 12:28:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbhDWQ2E (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Apr 2021 12:28:04 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E52BC061574
        for <git@vger.kernel.org>; Fri, 23 Apr 2021 09:27:27 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id s7so48879190wru.6
        for <git@vger.kernel.org>; Fri, 23 Apr 2021 09:27:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=EATLUm96VzFBYyWbsazuHsL0Mu5i1UQY26TbUQ5u8to=;
        b=JoWEzjp42YaMp7lCQpp36KxaAtTub5bq+B2uPIFRNT4ojAylh7f5Y8DoBultM0mSc/
         u17PyVSrd+LtXP0zhZ2I6PR4BCMAXybhB6l5JkOqUxpGoKY9iEpvHC97Xp3iokSpq01O
         c9/BqnXBzTwrKPBeURAXtfSpLRWYeaDWAmmJuuD/kLTVVyQeX2+Jw2Mq3DW0+zhlvIRH
         /hX/FfnmMR8YWu3jLRmj6226kbhjtVPuZNQKgsofBlQ3BQzYgO3qGzLPsxcpejq6iiHX
         KMjvpRJPsefUVG+BuWaJ5f2okhUvGC48j9vN6y7ADf993M7vrcWU6ck7dP14RH0OTw7Z
         Q7pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=EATLUm96VzFBYyWbsazuHsL0Mu5i1UQY26TbUQ5u8to=;
        b=JRPyXMvUMLYJibr4X7KnfA4mNq/OAcOEddrnkVAC1t826JWkCWWVAQ1c4CXemFNQGr
         JA76UiiK/rDo1W8JuF61mzULhne3MVPcoBDWtagiIpTk6hg2COehu96E5nndSGV31Azh
         +cSvmMkDlQ89s4p5cXK30gT3YaG2pEFYsQLRfSyfzpB0u1nszOG2kPTu6d0gcUU/9iPe
         F159XLRZuQbUAeLtZX57PFRWTBMiCskC+eIvpaZw3aryqTIF/soHqBhC1cJuSoxiIfD0
         jvYDmO9S8FVVo3WOsj5JFuP1/GDJ9dUT/HOgT7pkkmnMVxOr13zlmaJ58kZlmg0Hrl/7
         XiSA==
X-Gm-Message-State: AOAM531d+kgT8Exm5l1qv8l3Tu2F1rFQsv0qEFEvxwymGZM/wY5MJixU
        Skg32uXrKK3Xp2Pi9muk/WmEkSyk3Is=
X-Google-Smtp-Source: ABdhPJw3mTVEz/adIX+NmDJTM6pdszaB/aQO8U45BfSY2To/9p62XtTczuCam4XzBKK1cBwO9ESTqA==
X-Received: by 2002:adf:dd0d:: with SMTP id a13mr3888373wrm.416.1619195246413;
        Fri, 23 Apr 2021 09:27:26 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d133sm8671676wmf.9.2021.04.23.09.27.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Apr 2021 09:27:26 -0700 (PDT)
Message-Id: <pull.939.git.1619195245606.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 23 Apr 2021 16:27:25 +0000
Subject: [PATCH] [GSOC] pretty: provide human date format
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Junio C Hamano <gitster@pobox.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        ZheNing Hu <adlternative@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: ZheNing Hu <adlternative@gmail.com>

Add the placeholders %ah and %ch to format author date and committer
date, like --date=human does, which provides more humanity date output.

Signed-off-by: ZheNing Hu <adlternative@gmail.com>
---
    [GSOC] pretty: provide human date format
    
    Reasons for making this patch: --date=human has no corresponding
    --pretty option.
    
    Although --date=human with --pretty="%(a|c)d" can achieve the same
    effect with --pretty="%(a|c)h", but it can be noticed that most time
    formats implement the corresponding option of --pretty, such as
    --date=iso8601 can be replaced by --pretty=%(a|c)i, so add
    "--pretty=%(a|c)h" seems to be a very reasonable thing.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-939%2Fadlternative%2Fpretty_human-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-939/adlternative/pretty_human-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/939

 Documentation/pretty-formats.txt | 2 ++
 pretty.c                         | 3 +++
 t/t4205-log-pretty-formats.sh    | 6 ++++++
 3 files changed, 11 insertions(+)

diff --git a/Documentation/pretty-formats.txt b/Documentation/pretty-formats.txt
index 45133066e412..9cdcdb8bb414 100644
--- a/Documentation/pretty-formats.txt
+++ b/Documentation/pretty-formats.txt
@@ -190,6 +190,7 @@ The placeholders are:
 '%ai':: author date, ISO 8601-like format
 '%aI':: author date, strict ISO 8601 format
 '%as':: author date, short format (`YYYY-MM-DD`)
+'%ah':: author date, human style
 '%cn':: committer name
 '%cN':: committer name (respecting .mailmap, see
 	linkgit:git-shortlog[1] or linkgit:git-blame[1])
@@ -206,6 +207,7 @@ The placeholders are:
 '%ci':: committer date, ISO 8601-like format
 '%cI':: committer date, strict ISO 8601 format
 '%cs':: committer date, short format (`YYYY-MM-DD`)
+'%ch':: committer date, human style
 '%d':: ref names, like the --decorate option of linkgit:git-log[1]
 '%D':: ref names without the " (", ")" wrapping.
 '%(describe[:options])':: human-readable name, like
diff --git a/pretty.c b/pretty.c
index e5b33ba034bd..b1ecd039cef2 100644
--- a/pretty.c
+++ b/pretty.c
@@ -745,6 +745,9 @@ static size_t format_person_part(struct strbuf *sb, char part,
 	case 'I':	/* date, ISO 8601 strict */
 		strbuf_addstr(sb, show_ident_date(&s, DATE_MODE(ISO8601_STRICT)));
 		return placeholder_len;
+	case 'h':	/* date, human */
+		strbuf_addstr(sb, show_ident_date(&s, DATE_MODE(HUMAN)));
+		return placeholder_len;
 	case 's':
 		strbuf_addstr(sb, show_ident_date(&s, DATE_MODE(SHORT)));
 		return placeholder_len;
diff --git a/t/t4205-log-pretty-formats.sh b/t/t4205-log-pretty-formats.sh
index cabdf7d57a00..d4d75b0b350e 100755
--- a/t/t4205-log-pretty-formats.sh
+++ b/t/t4205-log-pretty-formats.sh
@@ -539,6 +539,12 @@ test_expect_success 'short date' '
 	test_cmp expected actual
 '
 
+test_expect_success 'human date' '
+	git log --format=%ad%n%cd --date=human >expected &&
+	git log --format=%ah%n%ch >actual &&
+	test_cmp expected actual
+'
+
 # get new digests (with no abbreviations)
 test_expect_success 'set up log decoration tests' '
 	head1=$(git rev-parse --verify HEAD~0) &&

base-commit: b0c09ab8796fb736efa432b8e817334f3e5ee75a
-- 
gitgitgadget
