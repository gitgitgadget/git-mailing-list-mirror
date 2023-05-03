Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F01D9C77B7F
	for <git@archiver.kernel.org>; Wed,  3 May 2023 18:49:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229763AbjECStV (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 May 2023 14:49:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbjECStD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 May 2023 14:49:03 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8A705BBA
        for <git@vger.kernel.org>; Wed,  3 May 2023 11:48:55 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-b8f6bef3d4aso11114044276.0
        for <git@vger.kernel.org>; Wed, 03 May 2023 11:48:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683139735; x=1685731735;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=2FRuIpOGUMsA1ewzlWZVI/OCWZ1dW52ZqQu0cBkXFAg=;
        b=seTobT+8dcxAMg39qF0ZJEoQMYucpVYzzmm8pfemTlq6Cw+Sa+3x5IgQynQsaZO9vJ
         SGS3iuthWqSlbXWKAHeN70dI9UGLMDpivGGEQqQfxjAJx/tG8IQGZ9cIJINyonJ16NGu
         mU3wgI40D5BfE0Vq+zH05Y+CSHiXoZuGBXB4GrlLmikM/h7UmtGgnG1zrduAwiN2fm/m
         S/t8pRbL6ac/FkRgDk1m8aHc57g8u/+nYN33ZQhUbUbA+kuTFMMiiyXv+dCzmElvblM0
         vxLvtuE6mlOXrVT7iJKJOwvAUrh+Wi0DaQtvChHJQXVFscsihBgOO6Boi3QSj+CPH9Gh
         pulA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683139735; x=1685731735;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2FRuIpOGUMsA1ewzlWZVI/OCWZ1dW52ZqQu0cBkXFAg=;
        b=TKQNjSFAMCA5k+IZ5td427dHWrIlUepZw+d/mk9OA5lz0cBGyYfhPR45QhFe+gnKfK
         W+3u3knXsPWqipe69iasRT0CTFFFsU7+3qM9JLyTKmzBxJ0UjsOm9NquK3RBkJq4mQH8
         JTDi/Uj0jlPVGnD4AfWKLIrXmwCE9PokwD2aKx6cnE5Hty4QqRXFsEEVst9tb4y2zBmQ
         BkqIxV9iLDszQcbVtwqg0YTbDtOV0Fb/gCAOu3Py+owpjutF1S511WoURGAsEyr0f3NI
         OnchLYhnDQXPc0V97+S+25XWT5JHGzIQwB7Be8FPYLrxvn9eXStOCOFLbo4ZOk7OB3eQ
         dl3g==
X-Gm-Message-State: AC+VfDwVboipVPOJBpZ+UFJmJLylHxZWvbl7IJKU+4eGr4K0ZRYi+1UU
        LKo8sD3ZfZMHfkD01j6RANUJTqYNRET4FbV1mQJzdWUpAeQJnAs4y0oUYSeB+u5IeeeDTQAAAHR
        nIUexloLl6gieYs8BVD9rAcKkNqE7LmAQAxNFrzGD+2fGwoqD32SZmePas1LwHQDCUw==
X-Google-Smtp-Source: ACHHUZ5wCh8h+ymv/jd1+MOzCH41B2+9TZnjcUZ8bO3MU8m0YbkPEI284uRfsN9AlqlDzOOn8aANwuKlSgCxWPU=
X-Received: from barleywine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3bd4])
 (user=calvinwan job=sendgmr) by 2002:a25:e701:0:b0:b9e:71a7:3bc9 with SMTP id
 e1-20020a25e701000000b00b9e71a73bc9mr4035681ybh.10.1683139734984; Wed, 03 May
 2023 11:48:54 -0700 (PDT)
Date:   Wed,  3 May 2023 18:48:49 +0000
In-Reply-To: <20230502211454.1673000-1-calvinwan@google.com>
Mime-Version: 1.0
References: <20230502211454.1673000-1-calvinwan@google.com>
X-Mailer: git-send-email 2.40.1.521.gf1e218fcd8-goog
Message-ID: <20230503184849.1809304-1-calvinwan@google.com>
Subject: [PATCH v2 0/7] strbuf cleanups
From:   Calvin Wan <calvinwan@google.com>
To:     git@vger.kernel.org
Cc:     Calvin Wan <calvinwan@google.com>, newren@gmail.com, peff@peff.net
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Strbuf is a widely used basic structure that should only interact with
other primitives in strbuf.[ch]. Over time certain functions inside of
strbuf.[ch] have been added to interact with higher level objects and
functions. This series cleans up some of those higher level interactions
by moving the offending functions to the files they interact with and
adding documentation to strbuf.h. With the goal of eventually being able
to stand up strbuf as a libary, this series also removes the use of
environment variables from strbuf.

Calvin Wan (7):
  strbuf: clarify API boundary
  abspath: move related functions to abspath
  credential-store: move related functions to credential-store file
  object-name: move related functions to object-name
  path: move related function to path
  strbuf: clarify dependency
  strbuf: remove environment variables

 abspath.c                  |  36 +++++++++++++
 abspath.h                  |  21 ++++++++
 add-patch.c                |  12 +++--
 builtin/am.c               |   2 +-
 builtin/branch.c           |   4 +-
 builtin/commit.c           |   2 +-
 builtin/credential-store.c |  19 +++++++
 builtin/merge.c            |  10 ++--
 builtin/notes.c            |  16 +++---
 builtin/rebase.c           |   2 +-
 builtin/stripspace.c       |   6 ++-
 builtin/tag.c              |   9 ++--
 fmt-merge-msg.c            |   9 ++--
 gpg-interface.c            |   5 +-
 hook.c                     |   1 +
 object-name.c              |  15 ++++++
 object-name.h              |   9 ++++
 path.c                     |  20 +++++++
 path.h                     |   5 ++
 pretty.c                   |   1 +
 rebase-interactive.c       |  15 +++---
 sequencer.c                |  24 +++++----
 strbuf.c                   | 106 +++----------------------------------
 strbuf.h                   |  53 +++++--------------
 tempfile.c                 |   1 +
 wt-status.c                |   6 +--
 26 files changed, 220 insertions(+), 189 deletions(-)

Range-diff against v1:
-:  ---------- > 1:  e0dd3f5295 strbuf: clarify API boundary
1:  283771c088 ! 2:  ec1ea6ae4f abspath: move related functions to abspath
    @@ Commit message
         abspath: move related functions to abspath
     
         Move abspath-related functions from strbuf.[ch] to abspath.[ch] since
    -    they do not belong in a low-level library.
    +    paths are not primitive objects and therefore strbuf should not interact
    +    with them.
     
      ## abspath.c ##
     @@ abspath.c: char *prefix_filename_except_for_dash(const char *pfx, const char *arg)
2:  58f78b8ae0 = 3:  2d74561b91 credential-store: move related functions to credential-store file
3:  88ab90c079 ! 4:  30b5e635cb object-name: move related functions to object-name
    @@ Commit message
         object-name: move related functions to object-name
     
         Move object-name-related functions from strbuf.[ch] to object-name.[ch]
    -    since they do not belong in a low-level library.
    +    since paths are not a primitive object that strbuf should directly
    +    interact with.
     
      ## object-name.c ##
     @@ object-name.c: static void find_abbrev_len_packed(struct min_abbrev_data *mad)
4:  30b7de5a81 ! 5:  6905618470 path: move related function to path
    @@ Metadata
      ## Commit message ##
         path: move related function to path
     
    -    Move path-related function from strbuf.[ch] to path.[ch] since it does
    -    not belong in a low-level library.
    +    Move path-related function from strbuf.[ch] to path.[ch] since path is
    +    not a primitive object and therefore strbuf should not directly interact
    +    with it.
     
      ## path.c ##
     @@ path.c: int normalize_path_copy(char *dst, const char *src)
5:  7b6d6353de ! 6:  caf3482bf7 strbuf: clarify dependency
    @@ Metadata
      ## Commit message ##
         strbuf: clarify dependency
     
    +    refs.h was once needed but is no longer so as of 6bab74e7fb8 ("strbuf:
    +    move strbuf_branchname to sha1_name.c", 2010-11-06). strbuf.h was
    +    included thru refs.h, so removing refs.h requires strbuf.h to be added
    +    back.
    +
      ## strbuf.c ##
     @@
      #include "environment.h"
6:  ffacd1cbe5 ! 7:  a7f23488f8 strbuf: remove enviroment variables
    @@ Metadata
     Author: Calvin Wan <calvinwan@google.com>
     
      ## Commit message ##
    -    strbuf: remove enviroment variables
    +    strbuf: remove environment variables
     
    -    As a lower level library, strbuf should not directly access environment
    -    variables within its functions. Therefore, add an additional variable to
    -    function signatures for functions that use an environment variable and
    -    refactor callers to pass in the environment variable.
    +    As a library that only interacts with other primitives, strbuf should
    +    not directly access environment variables within its
    +    functions. Therefore, add an additional variable to function signatures
    +    for functions that use an environment variable and refactor callers to
    +    pass in the environment variable.
     
      ## add-patch.c ##
     @@ add-patch.c: static int edit_hunk_manually(struct add_p_state *s, struct hunk *hunk)
    @@ strbuf.h: void strbuf_addf(struct strbuf *sb, const char *fmt, ...);
      __attribute__((format (printf,2,0)))
      void strbuf_vaddf(struct strbuf *sb, const char *fmt, va_list ap);
     @@ strbuf.h: int strbuf_normalize_path(struct strbuf *sb);
    + 
    + /**
       * Strip whitespace from a buffer. The second parameter controls if
    -  * comments are considered contents to be removed or not.
    +- * comments are considered contents to be removed or not.
    ++ * comments are considered contents to be removed or not. The third parameter
    ++ * is the comment character that determines whether a line is a comment or not.
       */
     -void strbuf_stripspace(struct strbuf *buf, int skip_comments);
     +void strbuf_stripspace(struct strbuf *buf, int skip_comments, char comment_line_char);
-- 
2.40.1.521.gf1e218fcd8-goog

