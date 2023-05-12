Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15E0AC77B7F
	for <git@archiver.kernel.org>; Fri, 12 May 2023 17:14:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232659AbjELROf (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 May 2023 13:14:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbjELROd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 May 2023 13:14:33 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E3335B8B
        for <git@vger.kernel.org>; Fri, 12 May 2023 10:14:32 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-ba712bb7b28so4948565276.1
        for <git@vger.kernel.org>; Fri, 12 May 2023 10:14:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683911672; x=1686503672;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=z1paguTHx4dhhzKhgeIAf8vxGpnzIWXhpmU9dTZ8dPE=;
        b=dnZIINtQ9P/ZfpJ7EhxFHJMV8Aap6KT9otsc8x8nnpFhlveC6cb80XNxi55K1ooQ7w
         fOUG4A0AzNghg1AKqMxiNOvYXjd1gf4phWM54k6mdNLCKmqVkjAglEJMIOXdKSH2GAmR
         aYcvHSl8zthoSj0LZj8Jj6/dRk7UxuCgob0SPzcP9oKYSbX4hxZi1BvtT/DKJ981Vxpr
         uIUGy9F6o8/+xeFEew2uizOo8EUCjMjrzQFHO9k3wPHKYr7I7JJwr2Eix3Alh3cVzhWg
         5MIc23SkZxlcJEpBL+v2QgmzR2GOlMzEAWhEM/Ty3jW/rcVQJkgWLc+J9RBk5DyDCR6o
         rNNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683911672; x=1686503672;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z1paguTHx4dhhzKhgeIAf8vxGpnzIWXhpmU9dTZ8dPE=;
        b=JMRVqehk8ukbccU7ThRhe+Y1qmGcdwXBrv1F+7JWXckcWio17QFCz/5PZWw/qKgggq
         iWqAzxq5cC/z08p6PSam0dbOUzSQTLvSIRj/h6Zyld52b4SX4BwIqKtNd/u+ZV+NmJjj
         nYclTGguWioZZeHCsrns1LegFbU7nK5AT+ZsaW8UMZpWjdVyF4sTg14NF+IoIbpfdduN
         cOby3RyjLU7/sSFb724Q2Bqhgnr2Wi1q1G8L+/05jrtRegxgX0TIcrFU+WW2pDiJG18Y
         yWhvgU00YFxhG9yzO3qglxGxpzMQKLOg4FShAm3M66+OlkzLa7L1k4LxPImFrEqqz8Z/
         nE2w==
X-Gm-Message-State: AC+VfDwBE7njJCXbiBszItRKHL15x3KXF4ICgEiPPAHW/lyW0poKR7qB
        Amn9gUDWDq+hU69zRw5BkTfNnKNhMefToJd9AEtqAqX/OezxdO8UshsrUzJGgNNEtg6y5lhMGA0
        qC9+eVTVOsTr1Zrmkx8It4DuCw+S0BKZs5ARTi2Wq0IXaexDXaQdovSvMmi6qP6PqWA==
X-Google-Smtp-Source: ACHHUZ7F1q6f7Q8bwIJr2kyFuAT5WnnAxYfps6UEaYGaeZWBzoqqDrtMO3jwvTxsuFWOEyQ7kAN6lpAj3NG0s/I=
X-Received: from barleywine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3bd4])
 (user=calvinwan job=sendgmr) by 2002:a25:1283:0:b0:b9a:672d:23c9 with SMTP id
 125-20020a251283000000b00b9a672d23c9mr15437029ybs.0.1683911671801; Fri, 12
 May 2023 10:14:31 -0700 (PDT)
Date:   Fri, 12 May 2023 17:14:29 +0000
In-Reply-To: <20230511194446.1492907-1-calvinwan@google.com>
Mime-Version: 1.0
References: <20230511194446.1492907-1-calvinwan@google.com>
X-Mailer: git-send-email 2.40.1.606.ga4b1b128d6-goog
Message-ID: <20230512171429.2202982-1-calvinwan@google.com>
Subject: [PATCH v6 0/7] strbuf cleanups
From:   Calvin Wan <calvinwan@google.com>
To:     git@vger.kernel.org
Cc:     Calvin Wan <calvinwan@google.com>, phillip.wood123@gmail.com,
        sunshine@sunshineco.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Reroll with last couple of nits fixed. Thanks again to everyone for
reviewing this series!

Calvin Wan (7):
  strbuf: clarify API boundary
  abspath: move related functions to abspath
  credential-store: move related functions to credential-store file
  object-name: move related functions to object-name
  path: move related function to path
  strbuf: clarify dependency
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
 strbuf.c                   | 112 ++++---------------------------------
 strbuf.h                   |  57 ++++++-------------
 tempfile.c                 |   1 +
 wt-status.c                |   6 +-
 26 files changed, 227 insertions(+), 192 deletions(-)

Range-diff against v5:
1:  287e787c9c ! 1:  5ae531a1e2 strbuf: clarify API boundary
    @@ strbuf.h
     +/*
     + * NOTE FOR STRBUF DEVELOPERS
     + *
    -+ * The objects that this API interacts with should be limited to other
    -+ * primitives, however, there are older functions in here that interact
    -+ * with non-primitive objects which should eventually be moved out or
    -+ * refactored.
    ++ * strbuf is a low-level primitive; as such it should interact only
    ++ * with other low-level primitives. Do not introduce new functions
    ++ * which interact with higher-level APIs.
     + */
     +
      struct string_list;
2:  5bd27cad7a = 2:  3bb2b9c01a abspath: move related functions to abspath
3:  08e3e40de6 = 3:  ff91ca2fda credential-store: move related functions to credential-store file
4:  1a21d4fdd1 = 4:  10e61eb570 object-name: move related functions to object-name
5:  03b20f3384 = 5:  c3d5db4e11 path: move related function to path
6:  b55f4a39e1 = 6:  113d156195 strbuf: clarify dependency
7:  6ea36d7730 ! 7:  01c923160d strbuf: remove global variable
    @@ Commit message
         functions. Therefore, add an additional parameter for functions that use
         comment_line_char and refactor callers to pass it in instead.
         strbuf_stripspace() removes the skip_comments boolean and checks if
    -    comment_line_char is a non-NULL character to determine whether to skip
    +    comment_line_char is a non-NUL character to determine whether to skip
         comments or not.
     
      ## add-patch.c ##
    @@ strbuf.c: static size_t cleanup(char *line, size_t len)
       *
     - * Enable skip_comments to skip every line starting with comment
     - * character.
    -+ * Pass a non-NULL comment_line_char to skip every line starting
    -+ * with it
    ++ * Pass a non-NUL comment_line_char to skip every line starting
    ++ * with it.
       */
     -void strbuf_stripspace(struct strbuf *sb, int skip_comments)
     +void strbuf_stripspace(struct strbuf *sb, char comment_line_char)
    @@ strbuf.c: void strbuf_stripspace(struct strbuf *sb, int skip_comments)
      		len = eol ? eol - (sb->buf + i) + 1 : sb->len - i;
      
     -		if (skip_comments && len && sb->buf[i] == comment_line_char) {
    -+		if (comment_line_char != '\0' && len &&
    ++		if (comment_line_char && len &&
     +		    sb->buf[i] == comment_line_char) {
      			newlen = 0;
      			continue;
    @@ strbuf.h: int strbuf_getcwd(struct strbuf *sb);
      /**
     - * Strip whitespace from a buffer. The second parameter controls if
     - * comments are considered contents to be removed or not.
    -+ * Strip whitespace from a buffer. The second parameter is the comment
    -+ * character that determines whether a line is a comment or not. If the
    -+ * second parameter is a non-NULL character, comments are considered
    -+ * contents to be removed.
    ++ * Strip whitespace from a buffer. If comment_line_char is non-NUL,
    ++ * then lines beginning with that character are considered comments,
    ++ * thus removed.
       */
     -void strbuf_stripspace(struct strbuf *buf, int skip_comments);
     +void strbuf_stripspace(struct strbuf *buf, char comment_line_char);
-- 
2.40.1.606.ga4b1b128d6-goog

