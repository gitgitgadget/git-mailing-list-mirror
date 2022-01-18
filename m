Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F461C433F5
	for <git@archiver.kernel.org>; Tue, 18 Jan 2022 15:55:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242234AbiARPzb (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Jan 2022 10:55:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235165AbiARPzb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Jan 2022 10:55:31 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02105C061574
        for <git@vger.kernel.org>; Tue, 18 Jan 2022 07:55:31 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id p18so28660917wmg.4
        for <git@vger.kernel.org>; Tue, 18 Jan 2022 07:55:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tUlrxdj2O8MtbDrIQLwq2FY13ZxVH6uG51fUu/b2Okk=;
        b=ciGJFtZnRCIhs+HwR6CTTUez9ins03JbuYwr0SBDjJxEriOD+MBqonEbJ4N4t1PMM1
         3SsQqG9vTnwQ80mP+VjEFYYzMFajtW78e/z02+Oyn8zwu6vI4KH706BXhIdiwNcZWRlC
         2k29QyNu9vPXpczO+TdHay2nF45WBX6lAmsrrgAVKF3lia1Lg024E3ljO1VF+v5+w+L5
         Xwjj4e6SGaW2hNikPixDvOFQpHzPK3IFsZJ1FamQMdYBcNuF5KcVk5K1fNMdYE+O3uuN
         8T+9OHhmYbkpxyA1SUKmJUDea1TLhIpw7JUxjkpl1YLJybOYTGSFIo17u9GezC69qP17
         74pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tUlrxdj2O8MtbDrIQLwq2FY13ZxVH6uG51fUu/b2Okk=;
        b=PwFN58i5KpI+j23ufTEYvSPrA1xUQyY3Acjq1pZbW2BL5pj0x0LT3eCPeO+fvrBi3P
         g0qWgRNrJUdEsbimLcnIXLnSZZ91lsf84pmzhRtakM6Qvl49Ol3F1aUV55SwLXXVLWgH
         WanEnRAK7AT9CHIwSjzzn3BmmnR6SHhgurtuGYWEtf6Bqi+DkPElAb0b+nXjEiYRoSKt
         XlEx/OqOP1N4KUkSUgDkGrSs9r5yFWIpAgpoh4WD1/VRGO3qLbZp6yCwrQM/HkNLSOzU
         cAc54SRykopsH2WO0NPBbqDMDRgTpfolo6Q4iRrh3B/Gq/Ru4pXxd6o46cALyZs91TTd
         L/rg==
X-Gm-Message-State: AOAM531MjLVhcFBHtj0G2lI6lPQ5O4+S8I0N0AK3YQnW0830qeZQGnhf
        U9Y7SLTR5hRUh4rdNCwP9tn4pNZoO57S5w==
X-Google-Smtp-Source: ABdhPJw8Y5AWrvZaEhALE3FrtlHQmp6B/dEXSodYtgd2vc9Ef65iNWB8aJXtWlZF6hXNEZ4BZacGdQ==
X-Received: by 2002:a5d:52cf:: with SMTP id r15mr21959022wrv.284.1642521329321;
        Tue, 18 Jan 2022 07:55:29 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id f15sm1220522wrd.45.2022.01.18.07.55.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jan 2022 07:55:28 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, J Smith <dark.panda@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v8 00/10] grep: simplify & delete "init" & "config" code
Date:   Tue, 18 Jan 2022 16:55:12 +0100
Message-Id: <cover-v8-00.10-00000000000-20220118T155211Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.0.rc1.864.g57621b115b6
In-Reply-To: <cover-v7-00.10-00000000000-20211228T004707Z-avarab@gmail.com>
References: <cover-v7-00.10-00000000000-20211228T004707Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A v8 re-roll of this series. For context and v7 see:
https://lore.kernel.org/git/cover-v7-00.10-00000000000-20211228T004707Z-avarab@gmail.com

The v7 has not been picked up yet. The ab/grep-patterntype in Junio's
tree is the v6. This v8 is rebased on "master" for a merge conflict
with the now-merged lh/use-gnu-color-in-grep.

Ævar Arnfjörð Bjarmason (10):
  grep.h: remove unused "regex_t regexp" from grep_opt
  log tests: check if grep_config() is called by "log"-like cmds
  grep tests: add missing "grep.patternType" config tests
  built-ins: trust the "prefix" from run_builtin()
  grep.c: don't pass along NULL callback value
  grep API: call grep_config() after grep_init()
  grep.h: make "grep_opt.pattern_type_option" use its enum
  grep.c: do "if (bool && memchr())" not "if (memchr() && bool)"
  grep: simplify config parsing and option parsing
  grep.[ch]: remove GREP_PATTERN_TYPE_UNSPECIFIED

 builtin/grep.c    |  27 +++++-----
 builtin/log.c     |  13 ++++-
 builtin/ls-tree.c |   2 +-
 git.c             |   1 +
 grep.c            | 126 +++++++++-------------------------------------
 grep.h            |  34 +++++++++----
 revision.c        |   4 +-
 t/t4202-log.sh    |  24 +++++++++
 t/t7810-grep.sh   |  68 +++++++++++++++++++++++++
 9 files changed, 168 insertions(+), 131 deletions(-)

Range-diff against v7:
 1:  b62e6b6162a =  1:  010a2066656 grep.h: remove unused "regex_t regexp" from grep_opt
 2:  0edcdb50afd =  2:  e4981fa3417 log tests: check if grep_config() is called by "log"-like cmds
 3:  e1b4b5b77e0 =  3:  59092169e55 grep tests: add missing "grep.patternType" config tests
 4:  6d91a765fd7 =  4:  331c9019a0e built-ins: trust the "prefix" from run_builtin()
 5:  844b4727ca3 =  5:  25dd327b653 grep.c: don't pass along NULL callback value
 6:  d9cf9bf5e37 !  6:  3c559ad006a grep API: call grep_config() after grep_init()
    @@ grep.c: static void std_output(struct grep_opt *opt, const void *buf, size_t siz
     -	.pattern_type_option = GREP_PATTERN_TYPE_UNSPECIFIED,
     -	.colors = {
     -		[GREP_COLOR_CONTEXT] = "",
    --		[GREP_COLOR_FILENAME] = "",
    +-		[GREP_COLOR_FILENAME] = GIT_COLOR_MAGENTA,
     -		[GREP_COLOR_FUNCTION] = "",
    --		[GREP_COLOR_LINENO] = "",
    --		[GREP_COLOR_COLUMNNO] = "",
    +-		[GREP_COLOR_LINENO] = GIT_COLOR_GREEN,
    +-		[GREP_COLOR_COLUMNNO] = GIT_COLOR_GREEN,
     -		[GREP_COLOR_MATCH_CONTEXT] = GIT_COLOR_BOLD_RED,
     -		[GREP_COLOR_MATCH_SELECTED] = GIT_COLOR_BOLD_RED,
     -		[GREP_COLOR_SELECTED] = "",
    @@ grep.h: struct grep_opt {
     +	.pattern_type_option = GREP_PATTERN_TYPE_UNSPECIFIED, \
     +	.colors = { \
     +		[GREP_COLOR_CONTEXT] = "", \
    -+		[GREP_COLOR_FILENAME] = "", \
    ++		[GREP_COLOR_FILENAME] = GIT_COLOR_MAGENTA, \
     +		[GREP_COLOR_FUNCTION] = "", \
    -+		[GREP_COLOR_LINENO] = "", \
    -+		[GREP_COLOR_COLUMNNO] = "", \
    ++		[GREP_COLOR_LINENO] = GIT_COLOR_GREEN, \
    ++		[GREP_COLOR_COLUMNNO] = GIT_COLOR_GREEN, \
     +		[GREP_COLOR_MATCH_CONTEXT] = GIT_COLOR_BOLD_RED, \
     +		[GREP_COLOR_MATCH_SELECTED] = GIT_COLOR_BOLD_RED, \
     +		[GREP_COLOR_SELECTED] = "", \
 7:  57ecc5c0d65 =  7:  daf873899c1 grep.h: make "grep_opt.pattern_type_option" use its enum
 8:  7dbeafde26b =  8:  62650a78ea9 grep.c: do "if (bool && memchr())" not "if (memchr() && bool)"
 9:  c6ca39b4554 !  9:  c211bb0c69d grep: simplify config parsing and option parsing
    @@ grep.h: struct grep_opt {
      	int word_regexp;
     -	int fixed;
      	int all_match;
    - #define GREP_BINARY_DEFAULT	0
    - #define GREP_BINARY_NOMATCH	1
    + 	int no_body_match;
    + 	int body_hit;
     @@ grep.h: struct grep_opt {
      	int allow_textconv;
      	int extended;
10:  b764c09d2b7 ! 10:  b52a0c11fa9 grep.[ch]: remove GREP_PATTERN_TYPE_UNSPECIFIED
    @@ grep.h: struct grep_opt {
     -	.pattern_type_option = GREP_PATTERN_TYPE_UNSPECIFIED, \
      	.colors = { \
      		[GREP_COLOR_CONTEXT] = "", \
    - 		[GREP_COLOR_FILENAME] = "", \
    + 		[GREP_COLOR_FILENAME] = GIT_COLOR_MAGENTA, \
-- 
2.35.0.rc1.864.g57621b115b6

