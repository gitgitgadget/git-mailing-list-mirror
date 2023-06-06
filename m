Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 321A8C77B7A
	for <git@archiver.kernel.org>; Tue,  6 Jun 2023 19:48:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239586AbjFFTsS (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Jun 2023 15:48:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237090AbjFFTrr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Jun 2023 15:47:47 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5D5510D7
        for <git@vger.kernel.org>; Tue,  6 Jun 2023 12:47:25 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id 41be03b00d2f7-53f06f7cc74so3516832a12.1
        for <git@vger.kernel.org>; Tue, 06 Jun 2023 12:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686080845; x=1688672845;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Rsz6kwdtXm0PEBQNUYRlHVfk9GpsM8DMd9G4WcGajwo=;
        b=hYivzzC4fa6PTtO5ywnoGKLBewguBUAJRQTMU5vR5Qy+X6Ul1K2oUaq+OAA2WYKuhb
         UjoR6PNuOCmFwK3nvSAt1zLEsAcYY0ue/Sqe6leR1EfeiKBhLbmWjX5s6+n0T55UnreD
         ou/Kq19AQtN4oFyLx8Yqkp6L2KxnvvqSqPiikXI0Rc8MHmGR1Y9NpS+E3zBuJ+leyomR
         XvPk940MbcKDEKs5ciPhX0rlH+aAIiEFiFDcn/PlSbT1IxF1EjIhJ7QDd+gMxrpQlhL7
         wmiAf7BG3fMfXlPMvdWUUl47FkPklX4FQp3lTqrBDiU0hPwZIjZTyX62LUHcnvICOWa6
         d/Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686080845; x=1688672845;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Rsz6kwdtXm0PEBQNUYRlHVfk9GpsM8DMd9G4WcGajwo=;
        b=iO3MxYPumaj/hGfhDvsRvQ7/tqKOdXizt4+xVnvQc5avA13whCtnbJo28nhsrLyJ3L
         wW9p2Mk9YPGXatsW/mn/RPB0HEjFGr0ZEHx65yaZrrYnF1v7VrnwLnk+Gl4riZ00jcDz
         VnFZ7DG5R+33Tk6gx2h+pmoSTa0KOOSlkOu/XbUzA1c1Baq/eO1WmZGWMkw27Ioy0fwh
         3DPf3W0XxnnV03zi4bvP7oAPGKV9Sp9PbgZhiyGN44bQLav0Gfopu2iM25miQB6094Om
         vrBIBv/JBAjj873PnssIRO8QMfOBIJvMiAWNgyunQQOuudKaspno7wMC4M8m+Vxy2n0Y
         Vjvw==
X-Gm-Message-State: AC+VfDxQr70cpgvrNZ62FXwvV08gkYLZ5AT0K9wNQsJ48LXDCqbVAoN/
        4gGiOg+mBHMeVZ+DhdZ0pn6t6gRwhGaPtxiMykdScOHQ9qQiyb2WXHFIoPV5jJ3LqLv1MFXpvge
        Wg6OyQPiIxnnayDlO2whF7Yc03z/tTjJYSyXNi0gz1VU2A5xPy203zLWyurKPa2ejGQ==
X-Google-Smtp-Source: ACHHUZ60k3UoSEDNHNj5Edpef0yYOy6lmufPHY9I83I+K/Uf6FPLpXmBhqlg2nOguMJkH+lLmr8KkmGVXMYlDsE=
X-Received: from barleywine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3bd4])
 (user=calvinwan job=sendgmr) by 2002:a63:c106:0:b0:543:fd61:5d38 with SMTP id
 w6-20020a63c106000000b00543fd615d38mr480031pgf.2.1686080845289; Tue, 06 Jun
 2023 12:47:25 -0700 (PDT)
Date:   Tue,  6 Jun 2023 19:47:20 +0000
In-Reply-To: <20230512171429.2202982-1-calvinwan@google.com>
Mime-Version: 1.0
References: <20230512171429.2202982-1-calvinwan@google.com>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Message-ID: <20230606194720.2053551-1-calvinwan@google.com>
Subject: [PATCH v7 0/7] strbuf cleanups
From:   Calvin Wan <calvinwan@google.com>
To:     git@vger.kernel.org
Cc:     Calvin Wan <calvinwan@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I rebased this series onto 2.41 and noticed I was getting a compilation
error for a missing dependency to repository in dir.h. With all of the
other cleanups happening, I assume some dependency chain that used to
exist doesn't anymore. This reroll moves "strbuf: clarify dependency" to
the second patch so any dependency chain broken by the other cleanup
patches can be caught. And that is why patch 4 adds a forward
declaration back. I also caught an additional unnecessary dependency
that could be removed in patch 5. This series should now be able to be
rebased onto 2.41 without any issue.

Calvin Wan (7):
  strbuf: clarify API boundary
  strbuf: clarify dependency
  abspath: move related functions to abspath
  credential-store: move related functions to credential-store file
  object-name: move related functions to object-name
  path: move related function to path
  strbuf: remove global variable

 abspath.c                  |  36 ++++++++++++
 abspath.h                  |  21 +++++++
 add-patch.c                |  12 ++--
 builtin/am.c               |   2 +-
 builtin/branch.c           |   4 +-
 builtin/commit.c           |   2 +-
 builtin/credential-store.c |  19 +++++++
 builtin/merge.c            |  10 ++--
 builtin/notes.c            |  16 +++---
 builtin/rebase.c           |   2 +-
 builtin/stripspace.c       |   6 +-
 builtin/tag.c              |   9 ++-
 dir.h                      |   2 +
 fmt-merge-msg.c            |   9 ++-
 gpg-interface.c            |   5 +-
 hook.c                     |   1 +
 object-name.c              |  15 +++++
 object-name.h              |   9 +++
 path.c                     |  20 +++++++
 path.h                     |   5 ++
 pretty.c                   |   1 +
 rebase-interactive.c       |  15 ++---
 sequencer.c                |  24 +++++---
 strbuf.c                   | 113 ++++---------------------------------
 strbuf.h                   |  57 ++++++-------------
 tempfile.c                 |   1 +
 wt-status.c                |   6 +-
 27 files changed, 229 insertions(+), 193 deletions(-)

Range-diff against v6:
1:  5ae531a1e2 = 1:  121788f263 strbuf: clarify API boundary
-:  ---------- > 2:  5e91404ecd strbuf: clarify dependency
2:  3bb2b9c01a = 3:  5c05f40181 abspath: move related functions to abspath
3:  ff91ca2fda = 4:  e1addc77e5 credential-store: move related functions to credential-store file
4:  10e61eb570 ! 5:  62e8c42f59 object-name: move related functions to object-name
    @@ Commit message
         so that strbuf is focused on string manipulation routines with minimal
         dependencies.
     
    +    dir.h relied on the forward declration of the repository struct in
    +    strbuf.h. Since that is removed in this patch, add the forward
    +    declaration to dir.h.
    +
    + ## dir.h ##
    +@@
    +  *
    +  */
    + 
    ++struct repository;
    ++
    + struct dir_entry {
    + 	unsigned int len;
    + 	char name[FLEX_ARRAY]; /* more */
    +
      ## object-name.c ##
     @@ object-name.c: static void find_abbrev_len_packed(struct min_abbrev_data *mad)
      		find_abbrev_len_for_pack(p, mad);
    @@ strbuf.c
      #include "gettext.h"
      #include "hex.h"
     -#include "object-name.h"
    - #include "refs.h"
    + #include "repository.h"
    + #include "strbuf.h"
      #include "string-list.h"
    - #include "utf8.h"
     @@ strbuf.c: void strbuf_addftime(struct strbuf *sb, const char *fmt, const struct tm *tm,
      	strbuf_setlen(sb, sb->len + len);
      }
5:  c3d5db4e11 ! 6:  0abba57acb path: move related function to path
    @@ Commit message
         Move path-related function from strbuf.[ch] to path.[ch] so that strbuf
         is focused on string manipulation routines with minimal dependencies.
     
    +    repository.h is no longer a necessary dependency after moving this
    +    function out.
    +
      ## path.c ##
     @@ path.c: int normalize_path_copy(char *dst, const char *src)
      	return normalize_path_copy_len(dst, src, NULL);
    @@ path.h: const char *remove_leading_path(const char *in, const char *prefix);
      int daemon_avoid_alias(const char *path);
     
      ## strbuf.c ##
    +@@
    + #include "environment.h"
    + #include "gettext.h"
    + #include "hex.h"
    +-#include "repository.h"
    + #include "strbuf.h"
    + #include "string-list.h"
    + #include "utf8.h"
     @@ strbuf.c: void strbuf_stripspace(struct strbuf *sb, int skip_comments)
      	strbuf_setlen(sb, j);
      }
6:  113d156195 < -:  ---------- strbuf: clarify dependency
7:  01c923160d = 7:  d33267a390 strbuf: remove global variable
-- 
2.41.0.162.gfafddb0af9-goog

