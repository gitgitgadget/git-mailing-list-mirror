Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DAF0C7EE26
	for <git@archiver.kernel.org>; Tue, 23 May 2023 19:28:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238281AbjEWT24 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 May 2023 15:28:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbjEWT2z (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 May 2023 15:28:55 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC5BF12B
        for <git@vger.kernel.org>; Tue, 23 May 2023 12:28:49 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id d2e1a72fcca58-64d42024c99so81147b3a.1
        for <git@vger.kernel.org>; Tue, 23 May 2023 12:28:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684870129; x=1687462129;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=I3jziN/9m1ZQAORiaVBfXmZk1ya7O2IkJ3CZ3RubPbI=;
        b=ajd6VQUjJoSwTyhoOeKv2cKmjCal03uWrTgFY9ue2gnpZb1b/5Ry/oo96+gHApab46
         1hE81+EUga09bKdtIQ2W425PruAJm+9cPIfVQrRq7Gx4O4Xfz4yJrvyO5fAzj9CMjRme
         fLeZ57iedMUVP6tEu81RXV6/o8hkRLYicCfKTgTUyn6vS08VhfF9fF1OE5BWxj8sTjfe
         +N51fAS9F8dG2EQ/mfzEMJvwWfUJC5zm63Pv7VZQ8TBff7plQgDq+xn3v40EtsTrQXhD
         FhqGIH+ha3dgY6vDWQQarRNQnxT2zHm/nzqoFZVcMHbO2p12/vuHEUAH3uJN0rECMQHl
         2CGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684870129; x=1687462129;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I3jziN/9m1ZQAORiaVBfXmZk1ya7O2IkJ3CZ3RubPbI=;
        b=Q26LRC0R6SChr41qplYHocMJqGf2csGFM6vXbgeFck/gD5+mbn5argdMbc7XlRPsxC
         Y8yb4b+Z3ztwOLAdyk3WSW305eiGoXAs+OwvpcmrTznqsO8bGLghht0zfscEDbfbV3lA
         9LOxmplc1S4GDD5b9JjON5qY05QBpwqqDJC2T7bgnyXIJe1AZjaK+CXrOo6nw2Sms9fl
         lB/dRseuFnYV8Fc/fFD7vV7+GMYnPI8Q9N/TMuGFRlJ8xDt7UD25/0dHNg2X15WqlFlH
         GIo+ZmxchUPDO4M88qu/8wy/rlfqltBmfZowHMJY9ovvtkh5GnfNVOXtoDOraQVaO4WH
         iu9A==
X-Gm-Message-State: AC+VfDzGo31gj5pmSzhgpltAvTv6Oap6Px6yDtRsDpc/lrogjwB/RNQv
        caWli/XZvpRxOAJPRKnv9dsP85YDemdjHsBsv9OeGxI/93ozs1CGB1+ag2yARB5o1ASWEHbdZxs
        ggnM4h6I9z2WR79K9K2SjA7WrqDjrhjG8jSoTPnI+K3uwCav25xKSpOWkoUzf+LFQng==
X-Google-Smtp-Source: ACHHUZ47BH4TgnZ9QIvHrgo1P4tWRMe2FvY/WDJyqRXpd/XzriuZlyXMOdgS6DfQvXm/VRO/CQtPZtyTJhl/jXE=
X-Received: from barleywine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3bd4])
 (user=calvinwan job=sendgmr) by 2002:a05:6a00:14d0:b0:641:31b1:e787 with SMTP
 id w16-20020a056a0014d000b0064131b1e787mr55631pfu.5.1684870129040; Tue, 23
 May 2023 12:28:49 -0700 (PDT)
Date:   Tue, 23 May 2023 19:27:48 +0000
In-Reply-To: <20230516170932.1358685-1-calvinwan@google.com>
Mime-Version: 1.0
References: <20230516170932.1358685-1-calvinwan@google.com>
X-Mailer: git-send-email 2.40.1.698.g37aff9b760-goog
Message-ID: <20230523192749.1270992-1-calvinwan@google.com>
Subject: [PATCH v2 0/7] git-compat-util cleanups
From:   Calvin Wan <calvinwan@google.com>
To:     git@vger.kernel.org
Cc:     Calvin Wan <calvinwan@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Changes since v1:
 - rebased onto 8afb38ac80f6
 - add a patch to split up sane-ctype macros into a separate file
   rather than into common.h as suggested by Junio
===

This series focuses on cleaning up and reducing the scope of
git-compat-util.h by moving headers to their respective files and
separating out functionality from git-compat-util.h to a new file,
common.h. I go into more detail in patch 4 as to why I believe this
separation is useful. 

By the end of this series, git-compat-util.h includes common.h which
includes wrapper.h, and usage.h. Since virtually every file includes
git-compat-util.h and the large majority of files use functions defined
in common.h, wrapper.h, and usage.h, I believe it makes sense that those
are also automatically included with git-compat-util.h.

While this series does not intend to draw clearer boundaries for
common.h, I am open to ideas for how it can be cleaned up more and if
there is a better name for the file. 

Calvin Wan (7):
  strbuf.h: move declarations for strbuf.c functions from
    git-compat-util.h
  wrapper.h: move declarations for wrapper.c functions from
    git-compat-util.h
  sane-ctype.h: move sane-ctype macros from git-compat-util.h
  common.h: move non-compat specific macros and functions from
    git-compat-util.h
  usage.h: move declarations for usage.c functions from
    git-compat-util.h
  treewide: remove unnecessary includes for wrapper.h
  common: move alloc macros to common.h

 add-patch.c                        |   1 -
 alias.c                            |   1 -
 alloc.h                            |  75 ----
 apply.c                            |   2 -
 archive-tar.c                      |   1 -
 archive.c                          |   1 -
 attr.c                             |   1 -
 builtin/am.c                       |   1 -
 builtin/bisect.c                   |   1 -
 builtin/blame.c                    |   1 -
 builtin/branch.c                   |   1 -
 builtin/bugreport.c                |   1 -
 builtin/cat-file.c                 |   1 -
 builtin/checkout--worker.c         |   1 -
 builtin/clone.c                    |   1 -
 builtin/config.c                   |   2 -
 builtin/credential-cache--daemon.c |   1 -
 builtin/credential-cache.c         |   1 -
 builtin/difftool.c                 |   1 -
 builtin/fast-import.c              |   1 -
 builtin/fetch-pack.c               |   1 -
 builtin/fmt-merge-msg.c            |   1 -
 builtin/fsmonitor--daemon.c        |   1 -
 builtin/gc.c                       |   1 -
 builtin/get-tar-commit-id.c        |   1 -
 builtin/grep.c                     |   1 -
 builtin/index-pack.c               |   2 -
 builtin/init-db.c                  |   1 -
 builtin/log.c                      |   1 -
 builtin/merge.c                    |   2 -
 builtin/mktree.c                   |   1 -
 builtin/mv.c                       |   1 -
 builtin/name-rev.c                 |   1 -
 builtin/pack-objects.c             |   2 -
 builtin/rebase.c                   |   1 -
 builtin/receive-pack.c             |   1 -
 builtin/repack.c                   |   1 -
 builtin/rerere.c                   |   1 -
 builtin/rev-parse.c                |   1 -
 builtin/revert.c                   |   1 -
 builtin/rm.c                       |   1 -
 builtin/submodule--helper.c        |   1 -
 builtin/symbolic-ref.c             |   1 +
 builtin/unpack-file.c              |   1 -
 builtin/unpack-objects.c           |   1 +
 builtin/worktree.c                 |   1 -
 bulk-checkin.c                     |   2 -
 cache-tree.c                       |   1 -
 chunk-format.c                     |   1 -
 combine-diff.c                     |   1 -
 commit-graph.c                     |   1 -
 commit-reach.c                     |   1 -
 common.h                           | 486 +++++++++++++++++++++
 compat/terminal.c                  |   1 -
 config.c                           |   2 -
 convert.c                          |   1 -
 copy.c                             |   1 -
 csum-file.c                        |   1 -
 daemon.c                           |   2 -
 delta-islands.c                    |   1 -
 diff.c                             |   2 -
 diffcore-rename.c                  |   1 -
 dir-iterator.c                     |   1 -
 dir.c                              |   2 -
 editor.c                           |   1 -
 entry.c                            |   1 -
 environment.c                      |   1 -
 ewah/bitmap.c                      |   1 -
 ewah/ewah_bitmap.c                 |   1 -
 fetch-pack.c                       |   2 -
 fmt-merge-msg.c                    |   1 -
 fsck.c                             |   1 -
 git-compat-util.h                  | 664 +----------------------------
 gpg-interface.c                    |   1 -
 grep.c                             |   1 -
 help.c                             |   1 -
 http-backend.c                     |   2 -
 imap-send.c                        |   1 -
 line-log.c                         |   1 -
 list-objects-filter-options.c      |   1 -
 list-objects-filter.c              |   1 -
 merge-ll.c                         |   1 -
 merge-recursive.c                  |   1 -
 midx.c                             |   1 -
 notes-merge.c                      |   1 -
 object-file.c                      |   2 -
 oid-array.c                        |   1 -
 oidtree.c                          |   1 -
 pack-bitmap-write.c                |   1 -
 pack-bitmap.c                      |   1 -
 pack-objects.c                     |   1 -
 pack-write.c                       |   1 -
 packfile.c                         |   2 -
 parallel-checkout.c                |   2 -
 path.c                             |   1 -
 pkt-line.c                         |   1 -
 pretty.c                           |   1 -
 prio-queue.c                       |   1 -
 quote.c                            |   1 -
 read-cache.c                       |   2 -
 rebase-interactive.c               |   1 -
 ref-filter.c                       |   1 -
 reflog-walk.c                      |   1 -
 refs.c                             |   2 -
 refspec.c                          |   1 -
 remote-curl.c                      |   1 -
 remote.c                           |   1 -
 rerere.c                           |   2 -
 revision.c                         |   1 -
 sane-ctype.h                       |  69 +++
 send-pack.c                        |   1 -
 sequencer.c                        |   2 -
 server-info.c                      |   2 -
 setup.c                            |   1 -
 shallow.c                          |   2 -
 sigchain.c                         |   1 -
 sparse-index.c                     |   1 -
 split-index.c                      |   1 -
 strbuf.c                           |   2 -
 strbuf.h                           |  32 ++
 streaming.c                        |   1 -
 string-list.c                      |   1 -
 strvec.c                           |   1 -
 submodule-config.c                 |   1 -
 submodule.c                        |   1 -
 t/helper/test-delta.c              |   1 -
 t/helper/test-fsmonitor-client.c   |   1 -
 t/helper/test-reach.c              |   1 -
 t/helper/test-read-cache.c         |   1 -
 tag.c                              |   1 -
 tempfile.c                         |   1 -
 trace.c                            |   1 -
 trace2/tr2_tls.c                   |   1 -
 trailer.c                          |   1 -
 transport-helper.c                 |   1 -
 transport.c                        |   2 -
 tree-walk.c                        |   1 -
 upload-pack.c                      |   1 -
 usage.c                            |   1 -
 usage.h                            |  60 +++
 userdiff.c                         |   1 -
 versioncmp.c                       |   1 +
 worktree.c                         |   2 -
 wrapper.c                          |   1 -
 wrapper.h                          | 111 +++++
 write-or-die.c                     |   1 -
 146 files changed, 764 insertions(+), 896 deletions(-)
 create mode 100644 common.h
 create mode 100644 sane-ctype.h
 create mode 100644 usage.h

Range-diff against v1:
1:  c3f998df91 ! 1:  a2b7a28e6e strbuf.h: move declarations for strbuf.c functions from git-compat-util.h
    @@ Commit message
         boundaries of the strbuf library, this commit focuses on first splitting
         out headers from git-compat-util.h.
     
    + ## builtin/symbolic-ref.c ##
    +@@
    + #include "gettext.h"
    + #include "refs.h"
    + #include "parse-options.h"
    ++#include "strbuf.h"
    + 
    + static const char * const git_symbolic_ref_usage[] = {
    + 	N_("git symbolic-ref [-m <reason>] <name> <ref>"),
    +
    + ## builtin/unpack-objects.c ##
    +@@
    + #include "blob.h"
    + #include "commit.h"
    + #include "replace-object.h"
    ++#include "strbuf.h"
    + #include "tag.h"
    + #include "tree.h"
    + #include "tree-walk.h"
    +
      ## git-compat-util.h ##
     @@ git-compat-util.h: void set_warn_routine(report_fn routine);
      report_fn get_warn_routine(void);
    @@ strbuf.h: char *xstrvfmt(const char *fmt, va_list ap);
     +}
     +
      #endif /* STRBUF_H */
    +
    + ## versioncmp.c ##
    +@@
    + #include "git-compat-util.h"
    + #include "config.h"
    ++#include "strbuf.h"
    + #include "string-list.h"
    + #include "versioncmp.h"
    + 
2:  71176763ff ! 2:  b12fb0e2ff wrapper.h: move declarations for wrapper.c functions from git-compat-util.h
    @@ Commit message
     
      ## git-compat-util.h ##
     @@ git-compat-util.h: static inline int git_has_dir_sep(const char *path)
    + 
      #include "compat/bswap.h"
      
    - #include "wildmatch.h"
    --
     -struct strbuf;
     +#include "wrapper.h"
      
-:  ---------- > 3:  016f671836 sane-ctype.h: move sane-ctype macros from git-compat-util.h
3:  6c905444cd ! 4:  244650e5c9 common.h: move non-compat specific macros and functions from git-compat-util.h
    @@ common.h (new)
     +	return (size_t) len;
     +}
     +
    -+/* in ctype.c, for kwset users */
    -+extern const unsigned char tolower_trans_tbl[256];
    -+
    -+/* Sane ctype - no locale, and works with signed chars */
    -+#undef isascii
    -+#undef isspace
    -+#undef isdigit
    -+#undef isalpha
    -+#undef isalnum
    -+#undef isprint
    -+#undef islower
    -+#undef isupper
    -+#undef tolower
    -+#undef toupper
    -+#undef iscntrl
    -+#undef ispunct
    -+#undef isxdigit
    -+
    -+extern const unsigned char sane_ctype[256];
    -+extern const signed char hexval_table[256];
    -+#define GIT_SPACE 0x01
    -+#define GIT_DIGIT 0x02
    -+#define GIT_ALPHA 0x04
    -+#define GIT_GLOB_SPECIAL 0x08
    -+#define GIT_REGEX_SPECIAL 0x10
    -+#define GIT_PATHSPEC_MAGIC 0x20
    -+#define GIT_CNTRL 0x40
    -+#define GIT_PUNCT 0x80
    -+#define sane_istest(x,mask) ((sane_ctype[(unsigned char)(x)] & (mask)) != 0)
    -+#define isascii(x) (((x) & ~0x7f) == 0)
    -+#define isspace(x) sane_istest(x,GIT_SPACE)
    -+#define isdigit(x) sane_istest(x,GIT_DIGIT)
    -+#define isalpha(x) sane_istest(x,GIT_ALPHA)
    -+#define isalnum(x) sane_istest(x,GIT_ALPHA | GIT_DIGIT)
    -+#define isprint(x) ((x) >= 0x20 && (x) <= 0x7e)
    -+#define islower(x) sane_iscase(x, 1)
    -+#define isupper(x) sane_iscase(x, 0)
    -+#define is_glob_special(x) sane_istest(x,GIT_GLOB_SPECIAL)
    -+#define is_regex_special(x) sane_istest(x,GIT_GLOB_SPECIAL | GIT_REGEX_SPECIAL)
    -+#define iscntrl(x) (sane_istest(x,GIT_CNTRL))
    -+#define ispunct(x) sane_istest(x, GIT_PUNCT | GIT_REGEX_SPECIAL | \
    -+		GIT_GLOB_SPECIAL | GIT_PATHSPEC_MAGIC)
    -+#define isxdigit(x) (hexval_table[(unsigned char)(x)] != -1)
    -+#define tolower(x) sane_case((unsigned char)(x), 0x20)
    -+#define toupper(x) sane_case((unsigned char)(x), 0)
    -+#define is_pathspec_magic(x) sane_istest(x,GIT_PATHSPEC_MAGIC)
    -+
    -+static inline int sane_case(int x, int high)
    -+{
    -+	if (sane_istest(x, GIT_ALPHA))
    -+		x = (x & ~0x20) | high;
    -+	return x;
    -+}
    -+
    -+static inline int sane_iscase(int x, int is_lower)
    -+{
    -+	if (!sane_istest(x, GIT_ALPHA))
    -+		return 0;
    -+
    -+	if (is_lower)
    -+		return (x & 0x20) != 0;
    -+	else
    -+		return (x & 0x20) == 0;
    -+}
    -+
     +/*
     + * Like skip_prefix, but compare case-insensitively. Note that the comparison
     + * is done via tolower(), so it is strictly ASCII (no multi-byte characters or
    @@ git-compat-util.h: static inline int cast_size_t_to_int(size_t a)
      #define HOST_NAME_MAX 256
      #endif
      
    --/* in ctype.c, for kwset users */
    --extern const unsigned char tolower_trans_tbl[256];
    --
    --/* Sane ctype - no locale, and works with signed chars */
    --#undef isascii
    --#undef isspace
    --#undef isdigit
    --#undef isalpha
    --#undef isalnum
    --#undef isprint
    --#undef islower
    --#undef isupper
    --#undef tolower
    --#undef toupper
    --#undef iscntrl
    --#undef ispunct
    --#undef isxdigit
    --
    --extern const unsigned char sane_ctype[256];
    --extern const signed char hexval_table[256];
    --#define GIT_SPACE 0x01
    --#define GIT_DIGIT 0x02
    --#define GIT_ALPHA 0x04
    --#define GIT_GLOB_SPECIAL 0x08
    --#define GIT_REGEX_SPECIAL 0x10
    --#define GIT_PATHSPEC_MAGIC 0x20
    --#define GIT_CNTRL 0x40
    --#define GIT_PUNCT 0x80
    --#define sane_istest(x,mask) ((sane_ctype[(unsigned char)(x)] & (mask)) != 0)
    --#define isascii(x) (((x) & ~0x7f) == 0)
    --#define isspace(x) sane_istest(x,GIT_SPACE)
    --#define isdigit(x) sane_istest(x,GIT_DIGIT)
    --#define isalpha(x) sane_istest(x,GIT_ALPHA)
    --#define isalnum(x) sane_istest(x,GIT_ALPHA | GIT_DIGIT)
    --#define isprint(x) ((x) >= 0x20 && (x) <= 0x7e)
    --#define islower(x) sane_iscase(x, 1)
    --#define isupper(x) sane_iscase(x, 0)
    --#define is_glob_special(x) sane_istest(x,GIT_GLOB_SPECIAL)
    --#define is_regex_special(x) sane_istest(x,GIT_GLOB_SPECIAL | GIT_REGEX_SPECIAL)
    --#define iscntrl(x) (sane_istest(x,GIT_CNTRL))
    --#define ispunct(x) sane_istest(x, GIT_PUNCT | GIT_REGEX_SPECIAL | \
    --		GIT_GLOB_SPECIAL | GIT_PATHSPEC_MAGIC)
    --#define isxdigit(x) (hexval_table[(unsigned char)(x)] != -1)
    --#define tolower(x) sane_case((unsigned char)(x), 0x20)
    --#define toupper(x) sane_case((unsigned char)(x), 0)
    --#define is_pathspec_magic(x) sane_istest(x,GIT_PATHSPEC_MAGIC)
    --
    --static inline int sane_case(int x, int high)
    --{
    --	if (sane_istest(x, GIT_ALPHA))
    --		x = (x & ~0x20) | high;
    --	return x;
    --}
    --
    --static inline int sane_iscase(int x, int is_lower)
    --{
    --	if (!sane_istest(x, GIT_ALPHA))
    --		return 0;
    --
    --	if (is_lower)
    --		return (x & 0x20) != 0;
    --	else
    --		return (x & 0x20) == 0;
    --}
    --
    + #include "sane-ctype.h"
    + 
     -/*
     - * Like skip_prefix, but compare case-insensitively. Note that the comparison
     - * is done via tolower(), so it is strictly ASCII (no multi-byte characters or
4:  280a7492ec ! 5:  91a1253ee6 usage.h: move declarations for usage.c functions from git-compat-util.h
    @@ common.h
     
      ## git-compat-util.h ##
     @@ git-compat-util.h: static inline int git_has_dir_sep(const char *path)
    + 
      #include "compat/bswap.h"
      
    - #include "wildmatch.h"
     -#include "wrapper.h"
     -
     -/* General helper functions */
    @@ git-compat-util.h: static inline int git_has_dir_sep(const char *path)
     -int error_errno(const char *err, ...) __attribute__((format (printf, 1, 2)));
     -void warning(const char *err, ...) __attribute__((format (printf, 1, 2)));
     -void warning_errno(const char *err, ...) __attribute__((format (printf, 1, 2)));
    - 
    +-
      #ifndef NO_OPENSSL
      #ifdef APPLE_COMMON_CRYPTO
    + #include "compat/apple-common-crypto.h"
     @@ git-compat-util.h: void warning_errno(const char *err, ...) __attribute__((format (printf, 1, 2)));
      #include <openssl/rand.h>
      #endif
5:  9b29a77a90 ! 6:  c9850a7c18 treewide: remove unnecessary includes for wrapper.h
    @@ Commit message
     
      ## apply.c ##
     @@
    - #include "apply.h"
    - #include "entry.h"
    - #include "setup.h"
    + #include "symlinks.h"
    + #include "wildmatch.h"
    + #include "ws.h"
     -#include "wrapper.h"
      
      struct gitdiff_data {
    @@ apply.c
     
      ## builtin/am.c ##
     @@
    - #include "pager.h"
    + #include "path.h"
      #include "repository.h"
      #include "pretty.h"
     -#include "wrapper.h"
    @@ builtin/clone.c
     
      ## builtin/config.c ##
     @@
    - #include "quote.h"
      #include "setup.h"
    + #include "strbuf.h"
      #include "worktree.h"
     -#include "wrapper.h"
      
    @@ builtin/config.c
     
      ## builtin/credential-cache.c ##
     @@
    - #include "builtin.h"
    - #include "gettext.h"
      #include "parse-options.h"
    + #include "path.h"
    + #include "strbuf.h"
     -#include "wrapper.h"
      #include "write-or-die.h"
      
    @@ builtin/gc.c
     
      ## builtin/get-tar-commit-id.c ##
     @@
    + #include "commit.h"
      #include "tar.h"
    - #include "builtin.h"
      #include "quote.h"
     -#include "wrapper.h"
      
    @@ builtin/index-pack.c
     
      ## builtin/init-db.c ##
     @@
    - #include "parse-options.h"
    + #include "path.h"
      #include "setup.h"
    - #include "worktree.h"
    + #include "strbuf.h"
     -#include "wrapper.h"
      
    - #ifndef DEFAULT_GIT_TEMPLATE_DIR
    - #define DEFAULT_GIT_TEMPLATE_DIR "/usr/share/git-core/templates"
    + static int guess_repository_type(const char *git_dir)
    + {
     
      ## builtin/merge.c ##
     @@
    @@ builtin/receive-pack.c
     
      ## builtin/rerere.c ##
     @@
    - #include "parse-options.h"
    + #include "repository.h"
      #include "string-list.h"
      #include "rerere.h"
     -#include "wrapper.h"
    @@ builtin/unpack-file.c
     @@
      #include "hex.h"
      #include "object-name.h"
    - #include "object-store.h"
    + #include "object-store-ll.h"
     -#include "wrapper.h"
      
      static char *create_temp_file(struct object_id *oid)
    @@ bulk-checkin.c
     @@
      #include "packfile.h"
      #include "object-file.h"
    - #include "object-store.h"
    + #include "object-store-ll.h"
     -#include "wrapper.h"
      
      static int odb_transaction_nesting;
    @@ combine-diff.c
     
      ## commit-graph.c ##
     @@
    - #include "json-writer.h"
      #include "trace2.h"
    + #include "tree.h"
      #include "chunk-format.h"
     -#include "wrapper.h"
      
    @@ compat/terminal.c
     
      ## config.c ##
     @@
    - #include "setup.h"
    - #include "trace2.h"
    + #include "wildmatch.h"
      #include "worktree.h"
    + #include "ws.h"
     -#include "wrapper.h"
      #include "write-or-die.h"
      
    @@ convert.c
     @@
      #include "trace.h"
      #include "utf8.h"
    - #include "ll-merge.h"
    + #include "merge-ll.h"
     -#include "wrapper.h"
      
      /*
    @@ convert.c
     
      ## copy.c ##
     @@
    - #include "cache.h"
    + #include "git-compat-util.h"
    + #include "copy.h"
    + #include "path.h"
     -#include "wrapper.h"
      
      int copy_fd(int ifd, int ofd)
    @@ copy.c
     
      ## csum-file.c ##
     @@
    - #include "git-compat-util.h"
      #include "progress.h"
      #include "csum-file.h"
    + #include "hash.h"
     -#include "wrapper.h"
      
      static void verify_buffer_or_die(struct hashfile *f,
    @@ daemon.c
     
      ## diff.c ##
     @@
    - #include "object-name.h"
      #include "setup.h"
      #include "strmap.h"
    + #include "ws.h"
     -#include "wrapper.h"
      
      #ifdef NO_FAST_WORKING_DIRECTORY
    @@ diff.c
     
      ## dir.c ##
     @@
    - #include "setup.h"
    - #include "submodule-config.h"
    + #include "symlinks.h"
      #include "trace2.h"
    + #include "tree.h"
     -#include "wrapper.h"
      
      /*
    @@ gpg-interface.c
      #include "tempfile.h"
      #include "alias.h"
     -#include "wrapper.h"
    + #include "environment.h"
      
      static int git_gpg_config(const char *, const char *, void *);
    - 
     
      ## grep.c ##
     @@
    @@ grep.c
     
      ## http-backend.c ##
     @@
    - #include "object-store.h"
    + #include "object-store-ll.h"
      #include "protocol.h"
      #include "date.h"
     -#include "wrapper.h"
    @@ http-backend.c
     
      ## imap-send.c ##
     @@
    - #include "run-command.h"
      #include "parse-options.h"
      #include "setup.h"
    + #include "strbuf.h"
     -#include "wrapper.h"
      #if defined(NO_OPENSSL) && !defined(HAVE_OPENSSL_CSPRNG)
      typedef void *SSL;
      #endif
     
    - ## ll-merge.c ##
    + ## merge-ll.c ##
     @@
    - #include "run-command.h"
    - #include "ll-merge.h"
    + #include "merge-ll.h"
      #include "quote.h"
    + #include "strbuf.h"
     -#include "wrapper.h"
      
      struct ll_merge_driver;
    @@ object-file.c
     
      ## pack-write.c ##
     @@
    - #include "oidmap.h"
    - #include "pack-objects.h"
      #include "pack-revindex.h"
    + #include "path.h"
    + #include "strbuf.h"
     -#include "wrapper.h"
      
      void reset_pack_idx_option(struct pack_idx_option *opts)
    @@ packfile.c
     
      ## parallel-checkout.c ##
     @@
    - #include "streaming.h"
    + #include "symlinks.h"
      #include "thread-utils.h"
      #include "trace2.h"
     -#include "wrapper.h"
    @@ parallel-checkout.c
     
      ## path.c ##
     @@
    - #include "object-store.h"
    + #include "object-store-ll.h"
      #include "lockfile.h"
      #include "exec-cmd.h"
     -#include "wrapper.h"
    @@ rebase-interactive.c
     
      ## refs.c ##
     @@
    - #include "sigchain.h"
      #include "date.h"
      #include "commit.h"
    + #include "wildmatch.h"
     -#include "wrapper.h"
      
      /*
    @@ refs.c
     
      ## rerere.c ##
     @@
    - #include "object-store.h"
    + #include "object-store-ll.h"
      #include "hash-lookup.h"
      #include "strmap.h"
     -#include "wrapper.h"
    @@ sequencer.c
     
      ## server-info.c ##
     @@
    - #include "object-file.h"
    - #include "object-store.h"
    + #include "object-store-ll.h"
    + #include "server-info.h"
      #include "strbuf.h"
     -#include "wrapper.h"
      
    @@ server-info.c
     
      ## setup.c ##
     @@
    - #include "promisor-remote.h"
      #include "quote.h"
      #include "trace2.h"
    + #include "worktree.h"
     -#include "wrapper.h"
      
      static int inside_git_dir = -1;
    @@ setup.c
     
      ## shallow.c ##
     @@
    - #include "commit-reach.h"
      #include "shallow.h"
    + #include "statinfo.h"
      #include "trace.h"
     -#include "wrapper.h"
      
    @@ strbuf.c
     
      ## streaming.c ##
     @@
    - #include "object-store.h"
    + #include "object-store-ll.h"
      #include "replace-object.h"
      #include "packfile.h"
     -#include "wrapper.h"
    @@ t/helper/test-fsmonitor-client.c
     
      ## t/helper/test-read-cache.c ##
     @@
    - #include "cache.h"
    - #include "config.h"
    + #include "read-cache-ll.h"
    + #include "repository.h"
      #include "setup.h"
     -#include "wrapper.h"
      
    @@ transport-helper.c
     
      ## transport.c ##
     @@
    - #include "object-store.h"
    + #include "object-store-ll.h"
      #include "color.h"
      #include "bundle-uri.h"
     -#include "wrapper.h"
    @@ worktree.c
     
      ## wrapper.c ##
     @@
    - #include "config.h"
    - #include "gettext.h"
    + #include "repository.h"
    + #include "strbuf.h"
      #include "trace2.h"
     -#include "wrapper.h"
      
6:  9604b66c72 ! 7:  067b28ec09 common: move alloc macros to common.h
    @@ Commit message
     
      ## add-patch.c ##
     @@
    - #include "cache.h"
    + #include "git-compat-util.h"
      #include "add-interactive.h"
      #include "advice.h"
     -#include "alloc.h"
    @@ alloc.h: void *alloc_object_node(struct repository *r);
      ## apply.c ##
     @@
      
    - #include "cache.h"
    + #include "git-compat-util.h"
      #include "abspath.h"
     -#include "alloc.h"
    + #include "base85.h"
      #include "config.h"
    - #include "object-store.h"
    - #include "blob.h"
    + #include "object-store-ll.h"
     
      ## archive-tar.c ##
     @@
    @@ attr.c
     @@
       */
      
    - #include "cache.h"
    + #include "git-compat-util.h"
     -#include "alloc.h"
      #include "config.h"
      #include "environment.h"
    @@ builtin/cat-file.c
     @@
       */
      #define USE_THE_INDEX_VARIABLE
    - #include "cache.h"
    + #include "builtin.h"
     -#include "alloc.h"
      #include "config.h"
      #include "convert.h"
    - #include "builtin.h"
    + #include "diff.h"
     
      ## builtin/checkout--worker.c ##
     @@
    @@ builtin/grep.c
     @@
       * Copyright (c) 2006 Junio C Hamano
       */
    - #include "cache.h"
    + #include "builtin.h"
     -#include "alloc.h"
      #include "gettext.h"
      #include "hex.h"
    @@ builtin/log.c
     
      ## builtin/merge.c ##
     @@
    - #include "cache.h"
    + #include "builtin.h"
      #include "abspath.h"
      #include "advice.h"
     -#include "alloc.h"
    @@ builtin/repack.c
      ## builtin/rev-parse.c ##
     @@
      #define USE_THE_INDEX_VARIABLE
    - #include "cache.h"
    + #include "builtin.h"
      #include "abspath.h"
     -#include "alloc.h"
      #include "config.h"
    @@ bulk-checkin.c
     
      ## cache-tree.c ##
     @@
    - #include "cache.h"
    + #include "git-compat-util.h"
     -#include "alloc.h"
      #include "environment.h"
      #include "hex.h"
    @@ common.h: static inline int cast_size_t_to_int(size_t a)
     
      ## config.c ##
     @@
    - #include "cache.h"
    + #include "git-compat-util.h"
      #include "abspath.h"
      #include "advice.h"
     -#include "alloc.h"
    @@ config.c
     
      ## daemon.c ##
     @@
    - #include "cache.h"
    + #include "git-compat-util.h"
      #include "abspath.h"
     -#include "alloc.h"
      #include "config.h"
      #include "environment.h"
    - #include "pkt-line.h"
    + #include "path.h"
     
      ## delta-islands.c ##
     @@
    @@ delta-islands.c
      ## diff.c ##
     @@
       */
    - #include "cache.h"
    + #include "git-compat-util.h"
      #include "abspath.h"
     -#include "alloc.h"
    + #include "base85.h"
      #include "config.h"
      #include "convert.h"
    - #include "environment.h"
     
      ## diffcore-rename.c ##
     @@
    @@ diffcore-rename.c
     -#include "alloc.h"
      #include "diff.h"
      #include "diffcore.h"
    - #include "object-store.h"
    + #include "object-store-ll.h"
     
      ## dir-iterator.c ##
     @@
    @@ fetch-pack.c
     -#include "alloc.h"
      #include "repository.h"
      #include "config.h"
    - #include "environment.h"
    + #include "date.h"
     
      ## fmt-merge-msg.c ##
     @@
    @@ fsck.c
     @@
      #include "git-compat-util.h"
     -#include "alloc.h"
    + #include "date.h"
    + #include "dir.h"
      #include "hex.h"
    - #include "object-store.h"
    - #include "repository.h"
     
      ## help.c ##
     @@
    @@ list-objects-filter.c
     
      ## midx.c ##
     @@
    - #include "cache.h"
    + #include "git-compat-util.h"
      #include "abspath.h"
     -#include "alloc.h"
      #include "config.h"
    @@ midx.c
      ## object-file.c ##
     @@
       */
    - #include "cache.h"
    + #include "git-compat-util.h"
      #include "abspath.h"
     -#include "alloc.h"
      #include "config.h"
    @@ pack-objects.c
     
      ## packfile.c ##
     @@
    - #include "cache.h"
    + #include "git-compat-util.h"
     -#include "alloc.h"
      #include "environment.h"
      #include "gettext.h"
    @@ packfile.c
     
      ## parallel-checkout.c ##
     @@
    - #include "cache.h"
    + #include "git-compat-util.h"
     -#include "alloc.h"
      #include "config.h"
      #include "entry.h"
    @@ read-cache.c
     @@
       * Copyright (C) Linus Torvalds, 2005
       */
    - #include "cache.h"
    + #include "git-compat-util.h"
     -#include "alloc.h"
    + #include "bulk-checkin.h"
      #include "config.h"
    - #include "diff.h"
    - #include "diffcore.h"
    + #include "date.h"
     
      ## ref-filter.c ##
     @@
    - #include "cache.h"
    + #include "git-compat-util.h"
     -#include "alloc.h"
      #include "environment.h"
      #include "gettext.h"
    - #include "hex.h"
    + #include "gpg-interface.h"
     
      ## reflog-walk.c ##
     @@
    @@ refspec.c
      #include "git-compat-util.h"
     -#include "alloc.h"
      #include "gettext.h"
    + #include "hash.h"
      #include "hex.h"
    - #include "strvec.h"
     
      ## remote-curl.c ##
     @@
    @@ remote.c
     
      ## rerere.c ##
     @@
    - #include "cache.h"
    + #include "git-compat-util.h"
      #include "abspath.h"
     -#include "alloc.h"
      #include "config.h"
    + #include "copy.h"
      #include "gettext.h"
    - #include "hex.h"
     
      ## revision.c ##
     @@
    - #include "cache.h"
    + #include "git-compat-util.h"
     -#include "alloc.h"
      #include "config.h"
      #include "environment.h"
    @@ revision.c
     
      ## sequencer.c ##
     @@
    - #include "cache.h"
    + #include "git-compat-util.h"
      #include "abspath.h"
      #include "advice.h"
     -#include "alloc.h"
      #include "config.h"
    + #include "copy.h"
      #include "environment.h"
    - #include "gettext.h"
     
      ## server-info.c ##
     @@
    - #include "cache.h"
    + #include "git-compat-util.h"
     -#include "alloc.h"
      #include "dir.h"
      #include "environment.h"
    @@ server-info.c
     
      ## shallow.c ##
     @@
    - #include "cache.h"
    + #include "git-compat-util.h"
     -#include "alloc.h"
      #include "hex.h"
      #include "repository.h"
    @@ sigchain.c
     
      ## sparse-index.c ##
     @@
    - #include "cache.h"
    + #include "git-compat-util.h"
     -#include "alloc.h"
      #include "environment.h"
      #include "gettext.h"
    - #include "repository.h"
    + #include "name-hash.h"
     
      ## split-index.c ##
     @@
    - #include "cache.h"
    + #include "git-compat-util.h"
     -#include "alloc.h"
      #include "gettext.h"
    + #include "hash.h"
      #include "mem-pool.h"
    - #include "split-index.h"
     
      ## strbuf.c ##
     @@
      #include "git-compat-util.h"
    - #include "abspath.h"
     -#include "alloc.h"
    - #include "environment.h"
      #include "gettext.h"
      #include "hex.h"
    + #include "path.h"
     
      ## string-list.c ##
     @@
    @@ submodule-config.c
     
      ## submodule.c ##
     @@
    - #include "cache.h"
    + #include "git-compat-util.h"
      #include "abspath.h"
     -#include "alloc.h"
      #include "repository.h"
    @@ transport.c
     
      ## tree-walk.c ##
     @@
    - #include "cache.h"
    + #include "git-compat-util.h"
      #include "tree-walk.h"
     -#include "alloc.h"
      #include "dir.h"
    @@ worktree.c
     -#include "alloc.h"
      #include "environment.h"
      #include "gettext.h"
    - #include "repository.h"
    + #include "path.h"
-- 
2.40.1.698.g37aff9b760-goog

