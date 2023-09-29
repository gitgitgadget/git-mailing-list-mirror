Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12D86E71D58
	for <git@archiver.kernel.org>; Fri, 29 Sep 2023 21:21:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233179AbjI2VVB (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Sep 2023 17:21:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbjI2VVA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Sep 2023 17:21:00 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 010F51AA
        for <git@vger.kernel.org>; Fri, 29 Sep 2023 14:20:58 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-597f461adc5so282408107b3.1
        for <git@vger.kernel.org>; Fri, 29 Sep 2023 14:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696022457; x=1696627257; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=CHQ5a7WjZB4GGWEcJ6xb9ItA26Xf7YO5WyzCrjz0ohA=;
        b=S/9+bQkvZSUVnzvVs5TNkAiI15gcyESaUtB5/uOoCjOd2cPRGb9fNetVTrmH0sE9uJ
         H98oIvbOoNl3VNi0c2Ue3+WoTkRQ04Yhnf/5LiQ4w6QJ2U543nTbQfMdahNCLGCJjfkJ
         wcfCCqk3TLG3cllnkPKHVxzIO0byhmYDU+e25XFK+hU+lnwV69D9KARH456wdCMLlJJw
         oSrCBl8Il/KyE+diw+1F+Q5X7ePDKH0TYwEX+q9tqHZMCULt99t2Rv2Q+Br7SeicF4gj
         IodqKuYmzotpM2+vxH9inxaK5vH5ju7qRu6DCFYkqSlF22NyE1lUioxxgh51chqBeVR6
         Hdgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696022457; x=1696627257;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CHQ5a7WjZB4GGWEcJ6xb9ItA26Xf7YO5WyzCrjz0ohA=;
        b=kf8PsoGeN3YJmhD31kr77VxuJF80nP52D/DWhWGWEq0U6R8KwnTp4u0OEO5RexTsaC
         ++XgSH0JcxI7vqBpDnbG1IlBA+z/qqyLyHDYBPU5OOVgIC40aU1IG1OeGwqAYELW4UR4
         xuN+9UW6Xs24t2N20AUFwd9cjU977dquiBgtGUpYQpJ55/i7aGzFrMvMXvS4xKsaPaGl
         OyAvzAQzYgrfbHzDtzUx93jgtie+OOe4Sh9egVK4oTfgtUXFb/Nube9cuPHbwF1au/DL
         X90TyozJVL1Ma24qWTCeCameGG8vyhm2hIpxTrLJwlS+xY6r5ixXPfBIRsWOJk99r+SM
         GFNA==
X-Gm-Message-State: AOJu0Yw1+TK1ZMawT9+MMnaMoG1yA3e+Co3eJv+MNMAgPi5gxG0xOI36
        mkPDjXkGKBQnB9mYJQWqCAos9/oigySm9m5KJE8e3sxt0/M09q0rF3Q4aCqs/oZhjRDL6eSGnBb
        8lv8uL2J7eAstz6ZRudk6hSKqmQh6XmGAmiWwOu4+BVGOaSzT9YG71KbdGhODn24b8xDpZRNDBA
        Bl
X-Google-Smtp-Source: AGHT+IGg6uUjeO2B96Ku4GbtWcFabFz1u192Mv9VQ9GAXgY9cChGZ9FTMjMoSFB4srStEx7b7oyFC8WMEFFC4pBhlSnV
X-Received: from jonathantanmy0.svl.corp.google.com ([2620:15c:2d3:204:b708:8deb:d032:67cf])
 (user=jonathantanmy job=sendgmr) by 2002:a81:b148:0:b0:59b:d9b8:9ae3 with
 SMTP id p69-20020a81b148000000b0059bd9b89ae3mr100418ywh.10.1696022457028;
 Fri, 29 Sep 2023 14:20:57 -0700 (PDT)
Date:   Fri, 29 Sep 2023 14:20:47 -0700
In-Reply-To: <20230627195251.1973421-1-calvinwan@google.com>
Mime-Version: 1.0
References: <20230627195251.1973421-1-calvinwan@google.com>
X-Mailer: git-send-email 2.42.0.582.g8ccd20d70d-goog
Message-ID: <cover.1696021277.git.jonathantanmy@google.com>
Subject: [PATCH v4 0/4] Preliminary patches before git-std-lib
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Calvin Wan <calvinwan@google.com>, phillip.wood123@gmail.com,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Calvin will be away for a few weeks and I'll be handling the git-std-lib
effort in the meantime. My goals will be:

- Get the preliminary patches in Calvin's patch set (patches 1-4) merged
first.

- Updating patches 5-6 based on reviewer feedback (including my
feedback). I have several aims including reducing or eliminating the
need for the GIT_STD_LIB preprocessor variable, and making stubs a test-
only concern (I think Phillip has some similar ideas [1] but I haven't
looked at their repo on GitHub yet).

[1] https://lore.kernel.org/git/98f3edcf-7f37-45ff-abd2-c0038d4e0589@gmail.com/

This patch set is in service of the first goal. Because the libification
patches are no longer included in this patch set, I have rewritten the
commit messages to justify the patches in terms of code organization.
There are no changes in the code itself. Also, I have retained Calvin's
name as the author.

Putting on my reviewer hat, if I was reviewing hex.h and config.h from
scratch, I would have not thought twice about requesting the changes
in these patches. But since we are not creating them from scratch but
modifying existing files, a question does arise about whether it's
worth the additional noise that someone looking through history needs
to handle. In this case, I think it's worth it - I think the future code
delver would appreciate being able to see the evolution of hex, hash
algo, config, and parse functions as their own files rather than, when
looking at one of them, having to filter out unrelated changes.

Besides that, as Calvin has described in his other emails, these patches
are prerequisites to being able to independently compile and use a
certain subset of the .c files. With patches that solely refactor, there
is sometimes a worry that the benefits are nebulous and that we would
be moving code around for nothing, but I don't think that that applies
here: there is still more work to be done on patches 5 and 6, but what
we have in patches 5 and 6 now shows that the benefits are concrete and
within reach.

Calvin Wan (4):
  hex-ll: separate out non-hash-algo functions
  wrapper: reduce scope of remove_or_warn()
  config: correct bad boolean env value error message
  parse: separate out parsing functions from config.h

 Makefile                   |   2 +
 attr.c                     |   2 +-
 color.c                    |   2 +-
 config.c                   | 173 +----------------------------------
 config.h                   |  14 +--
 entry.c                    |   5 +
 entry.h                    |   6 ++
 hex-ll.c                   |  49 ++++++++++
 hex-ll.h                   |  27 ++++++
 hex.c                      |  47 ----------
 hex.h                      |  24 +----
 mailinfo.c                 |   2 +-
 pack-objects.c             |   2 +-
 pack-revindex.c            |   2 +-
 parse-options.c            |   3 +-
 parse.c                    | 182 +++++++++++++++++++++++++++++++++++++
 parse.h                    |  20 ++++
 pathspec.c                 |   2 +-
 preload-index.c            |   2 +-
 progress.c                 |   2 +-
 prompt.c                   |   2 +-
 rebase.c                   |   2 +-
 strbuf.c                   |   2 +-
 t/helper/test-env-helper.c |   2 +-
 unpack-trees.c             |   2 +-
 url.c                      |   2 +-
 urlmatch.c                 |   2 +-
 wrapper.c                  |   8 +-
 wrapper.h                  |   5 -
 write-or-die.c             |   2 +-
 30 files changed, 313 insertions(+), 284 deletions(-)
 create mode 100644 hex-ll.c
 create mode 100644 hex-ll.h
 create mode 100644 parse.c
 create mode 100644 parse.h

Range-diff against v3:
1:  fcce01bc19 ! 1:  02ecc00e9c hex-ll: split out functionality from hex
    @@ Metadata
     Author: Calvin Wan <calvinwan@google.com>
     
      ## Commit message ##
    -    hex-ll: split out functionality from hex
    +    hex-ll: separate out non-hash-algo functions
     
    -    Separate out hex functionality that doesn't require a hash algo into
    -    hex-ll.[ch]. Since the hash algo is currently a global that sits in
    -    repository, this separation removes that dependency for files that only
    -    need basic hex manipulation functions.
    +    In order to further reduce all-in-one headers, separate out functions in
    +    hex.h that do not operate on object hashes into its own file, hex-ll.h,
    +    and update the include directives in the .c files that need only such
    +    functions accordingly.
     
         Signed-off-by: Calvin Wan <calvinwan@google.com>
    -    Signed-off-by: Junio C Hamano <gitster@pobox.com>
    +    Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
     
      ## Makefile ##
     @@ Makefile: LIB_OBJS += hash-lookup.o
2:  95a369d02b ! 2:  c9e7cd7857 wrapper: remove dependency to Git-specific internal file
    @@ Metadata
     Author: Calvin Wan <calvinwan@google.com>
     
      ## Commit message ##
    -    wrapper: remove dependency to Git-specific internal file
    +    wrapper: reduce scope of remove_or_warn()
     
    -    In order for wrapper.c to be built independently as part of a smaller
    -    library, it cannot have dependencies to other Git specific
    -    internals. remove_or_warn() creates an unnecessary dependency to
    -    object.h in wrapper.c. Therefore move the function to entry.[ch] which
    -    performs changes on the worktree based on the Git-specific file modes in
    -    the index.
    +    remove_or_warn() is only used by entry.c and apply.c, but it is
    +    currently declared and defined in wrapper.{h,c}, so it has a scope much
    +    greater than it needs. This needlessly large scope also causes wrapper.c
    +    to need to include object.h, when this file is largely unconcerned with
    +    Git objects.
    +
    +    Move remove_or_warn() to entry.{h,c}. The file apply.c still has access
    +    to it, since it already includes entry.h for another reason.
     
         Signed-off-by: Calvin Wan <calvinwan@google.com>
    -    Signed-off-by: Junio C Hamano <gitster@pobox.com>
    +    Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
     
      ## entry.c ##
     @@ entry.c: void unlink_entry(const struct cache_entry *ce, const char *super_prefix)
3:  5348528865 = 3:  e4c20a81f9 config: correct bad boolean env value error message
4:  b5a8945c5c ! 4:  5d9f0b3de0 parse: create new library for parsing strings and env values
    @@ Metadata
     Author: Calvin Wan <calvinwan@google.com>
     
      ## Commit message ##
    -    parse: create new library for parsing strings and env values
    +    parse: separate out parsing functions from config.h
     
    -    While string and environment value parsing is mainly consumed by
    -    config.c, there are other files that only need parsing functionality and
    -    not config functionality. By separating out string and environment value
    -    parsing from config, those files can instead be dependent on parse,
    -    which has a much smaller dependency chain than config. This ultimately
    -    allows us to inclue parse.[ch] in an independent library since it
    -    doesn't have dependencies to Git-specific internals unlike in
    -    config.[ch].
    +    The files config.{h,c} contain functions that have to do with parsing,
    +    but not config.
     
    -    Move general string and env parsing functions from config.[ch] to
    -    parse.[ch].
    +    In order to further reduce all-in-one headers, separate out functions in
    +    config.c that do not operate on config into its own file, parse.h,
    +    and update the include directives in the .c files that need only such
    +    functions accordingly.
     
         Signed-off-by: Calvin Wan <calvinwan@google.com>
    -    Signed-off-by: Junio C Hamano <gitster@pobox.com>
    +    Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
     
      ## Makefile ##
     @@ Makefile: LIB_OBJS += pack-write.o
-- 
2.42.0.582.g8ccd20d70d-goog

