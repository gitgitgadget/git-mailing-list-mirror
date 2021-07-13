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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92631C11F67
	for <git@archiver.kernel.org>; Tue, 13 Jul 2021 08:05:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 778A76120A
	for <git@archiver.kernel.org>; Tue, 13 Jul 2021 08:05:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234542AbhGMIIS (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Jul 2021 04:08:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234395AbhGMIIR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Jul 2021 04:08:17 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C0B5C0613E9
        for <git@vger.kernel.org>; Tue, 13 Jul 2021 01:05:26 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id k4so22934923wrc.8
        for <git@vger.kernel.org>; Tue, 13 Jul 2021 01:05:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vDsl933Jm9Zx/ol66XKvn46x7ZjfxPczHkYhPiCA8Fo=;
        b=FvnvvB8yIwjOxJjsYUiFXGooa6QsU7IyXitFHwl+aHTxor0dvEeuMUfWAYIEYI5FVT
         JKXGVHQUQzyBvHgdf/1GbFcVUvepcyJK8a56gK0jn4ML6b7ITGDq1bVeI4TfcdrkTV6f
         EWDK2lAPyxzzLBq6lpTfVT5NmrnFr3kWs3b3ZGrSStHKh0BmFb/e9o6hFLUL/snJFPYW
         FR0FZ6YmDz/48d5DQ3WOnopo1nKi0hFrC202pmydbThFDOW2c8GU9gZKRj9RKER6tcVN
         C+DEJBS9TukV31gwf+AdYXYUc2H8S4UCS6FGcwJ1dmiKDJPc7Wm89VKMy9hvUF0sUvgS
         KJbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vDsl933Jm9Zx/ol66XKvn46x7ZjfxPczHkYhPiCA8Fo=;
        b=b+IY88JX77WPGjOtjJ+1A8e2RMbZcaq+vYnKNwNNHMhWLlZeZ0OiUPev4GG0Hkr8y0
         aay9YR90a0T+L04fcfneGTN4npT9ildpVMelM2RqwCDJKZPx9Aq0xhU+xH70IFvMOWyf
         CXL+eSpdPk98gYe714o13ZNHnf+dvLVjYlppR5Hx4l+a0xUnQPL8CkoW6ZAPxLXhu0Uv
         2e88GfTU2Jr7luKYROsJ8L+BYGt31Ni2lJDqbzPdosRdQUifUVD33z+zZJGvWEUXRmbb
         aLOJpw/G/5MhpdIzSooJ9pQg47+Y4Obd0UNsDlOB4XJme0ohNfBFdTsW8rd71ZdnRncp
         zRRA==
X-Gm-Message-State: AOAM530ja92rGHDJ2RJAMmDlsFyDDZd1u80hMDS3fI+XZ7DZ1wTCPqOc
        WxcBkFOk69ZjMCqW15DKbrXkpEA5Y6kXJA==
X-Google-Smtp-Source: ABdhPJxpbfu1GgeA9Qvy9lLA+dI3qn5enhy+EHCbLMq0O46ernxnCYAFlIcnWaq/2ws2bXZMiv8CtA==
X-Received: by 2002:a05:6000:18c:: with SMTP id p12mr4143408wrx.98.1626163524072;
        Tue, 13 Jul 2021 01:05:24 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id z11sm17156772wru.65.2021.07.13.01.05.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jul 2021 01:05:23 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 0/6] add missing __attribute__((format))
Date:   Tue, 13 Jul 2021 10:05:15 +0200
Message-Id: <cover-0.6-0000000000-20210713T080411Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0-dev
In-Reply-To: <cover-0.6-00000000000-20210710T084445Z-avarab@gmail.com>
References: <cover-0.6-00000000000-20210710T084445Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Adds missing add missing __attribute__((format)) in various places,
which improves compile-time checking.

v2: Let's drop the whole bending over backwards to do mostly/entirely
useless strftime() checking. That's gone, I added a patch at the end
with a comment for strbuf_addftime() to say why it's not there, and
also split up the advise_if_enabled() change into its own commit.

I also removed the other cases of adding attribute checking to
compat/*. I can't easily test those, and I don't know if there's
potential bad interactions with git-compat-util.h.

Ævar Arnfjörð Bjarmason (6):
  *.c static functions: don't forward-declare __attribute__
  sequencer.c: move static function to avoid forward decl
  *.c static functions: add missing __attribute__((format))
  *.h: add a few missing  __attribute__((format))
  advice.h: add missing __attribute__((format)) & fix usage
  strbuf.h: add a comment about "missing" strftime() checking

 add-patch.c                                   |  1 +
 advice.h                                      |  1 +
 builtin/am.c                                  |  1 +
 builtin/bisect--helper.c                      |  2 +
 builtin/index-pack.c                          |  4 +-
 builtin/receive-pack.c                        |  5 +--
 cache.h                                       |  1 +
 commit-graph.c                                |  1 +
 .../osxkeychain/git-credential-osxkeychain.c  |  1 +
 .../wincred/git-credential-wincred.c          |  1 +
 gettext.c                                     |  1 +
 imap-send.c                                   |  3 ++
 mailmap.c                                     |  1 +
 merge-ort.c                                   |  1 +
 merge-recursive.c                             |  1 +
 midx.c                                        |  1 +
 quote.h                                       |  1 +
 ref-filter.c                                  |  1 +
 sequencer.c                                   | 43 +++++++++----------
 server-info.c                                 |  1 +
 strbuf.h                                      |  7 +++
 t/helper/test-advise.c                        |  2 +-
 worktree.c                                    |  1 +
 23 files changed, 53 insertions(+), 29 deletions(-)

Range-diff against v1:
1:  a855bfceb2 = 1:  a855bfceb2 *.c static functions: don't forward-declare __attribute__
2:  9c1492b006 = 2:  9c1492b006 sequencer.c: move static function to avoid forward decl
3:  bc3fee3b7a ! 3:  e2e039f481 *.c static functions: add missing __attribute__((format))
    @@ commit-graph.c: int write_commit_graph(struct object_directory *odb,
      {
      	va_list ap;
     
    - ## compat/mingw.c ##
    -@@ compat/mingw.c: static int read_yes_no_answer(void)
    - 	return -1;
    - }
    - 
    -+__attribute__((format (printf, 1, 2)))
    - static int ask_yes_no_if_possible(const char *format, ...)
    - {
    - 	char question[4096];
    -
    - ## compat/winansi.c ##
    -@@ compat/winansi.c: static void winansi_exit(void)
    - 	CloseHandle(hthread);
    - }
    - 
    -+__attribute__((format (printf, 1, 2)))
    - static void die_lasterr(const char *fmt, ...)
    - {
    - 	va_list params;
    -
      ## contrib/credential/osxkeychain/git-credential-osxkeychain.c ##
     @@ contrib/credential/osxkeychain/git-credential-osxkeychain.c: static char *username;
      static char *password;
4:  3bf8637c16 ! 4:  fd70d512b4 *.h: add a few missing  __attribute__((format))
    @@ Metadata
      ## Commit message ##
         *.h: add a few missing  __attribute__((format))
     
    -    Add missing format attributes to those function that were missing
    -    them.
    -
    -    In the case of advice_enabled() this revealed a trivial issue
    -    introduced in b3b18d16213 (advice: revamp advise API, 2020-03-02). We
    -    treated the argv[1] as a format string, but did not intend to do
    -    so. Let's use "%s" and pass argv[1] as an argument instead.
    -
    -    For strbuf_addftime() let's add a strftime() format checker. Our
    -    function understands the non-portable %z and %Z, see
    -    c3fbf81a853 (strbuf: let strbuf_addftime handle %z and %Z itself,
    -    2017-06-15).
    -
    -    That might be an issue in theory, but in practice we have existing
    -    codepath that supplies a fixed string to strbuf_addftime(). We're
    -    unlikely to run into the "%z" and "%Z" case at all, since it's used by
    -    date.c and passed via e.g. "git log --date=<format>".
    -
    -    In fact, we had no in-tree user of strbuf_addftime() with an inline
    -    fixed format string at all. A subsequent commit will tweak an existing
    -    one to use the format checking.
    +    Add missing format attributes to API functions that take printf
    +    arguments.
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
    - ## advice.h ##
    -@@ advice.h: int advice_enabled(enum advice_type type);
    - /**
    -  * Checks the visibility of the advice before printing.
    -  */
    -+__attribute__((format (printf, 2, 3)))
    - void advise_if_enabled(enum advice_type type, const char *advice, ...);
    - 
    - int error_resolve_conflict(const char *me);
    -
      ## cache.h ##
     @@ cache.h: enum get_oid_result {
      };
    @@ cache.h: enum get_oid_result {
      int repo_get_oid_commit(struct repository *r, const char *str, struct object_id *oid);
      int repo_get_oid_committish(struct repository *r, const char *str, struct object_id *oid);
     
    - ## compat/win32/syslog.h ##
    -@@
    - #define LOG_DAEMON  (3<<3)
    - 
    - void openlog(const char *ident, int logopt, int facility);
    -+__attribute__((format (printf, 2, 3)))
    - void syslog(int priority, const char *fmt, ...);
    - 
    - #endif /* SYSLOG_H */
    -
      ## quote.h ##
     @@ quote.h: struct strbuf;
      
    @@ strbuf.h: static inline void strbuf_insertstr(struct strbuf *sb, size_t pos,
      void strbuf_insertf(struct strbuf *sb, size_t pos, const char *fmt, ...);
      
      /**
    -@@ strbuf.h: void strbuf_vaddf(struct strbuf *sb, const char *fmt, va_list ap);
    -  * `suppress_tz_name`, when set, expands %Z internally to the empty
    -  * string rather than passing it to `strftime`.
    -  */
    -+__attribute__((format (strftime, 2, 0)))
    - void strbuf_addftime(struct strbuf *sb, const char *fmt,
    - 		    const struct tm *tm, int tz_offset,
    - 		    int suppress_tz_name);
    -
    - ## t/helper/test-advise.c ##
    -@@ t/helper/test-advise.c: int cmd__advise_if_enabled(int argc, const char **argv)
    - 	 * selected here and in t0018 where this command is being
    - 	 * executed.
    - 	 */
    --	advise_if_enabled(ADVICE_NESTED_TAG, argv[1]);
    -+	advise_if_enabled(ADVICE_NESTED_TAG, "%s", argv[1]);
    - 
    - 	return 0;
    - }
5:  daca344a16 < -:  ---------- bugreport.c: tweak cmd_bugreport() to use __attribute__((printf))
6:  365c5cf50b < -:  ---------- git-compat-util.h: add __attribute__((printf)) to git_*printf*
-:  ---------- > 5:  a001e851d2 advice.h: add missing __attribute__((format)) & fix usage
-:  ---------- > 6:  fe66e06754 strbuf.h: add a comment about "missing" strftime() checking
-- 
2.32.0-dev

