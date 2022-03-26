Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 796D7C433FE
	for <git@archiver.kernel.org>; Sat, 26 Mar 2022 17:14:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232880AbiCZRQP (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 26 Mar 2022 13:16:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231603AbiCZRQM (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 26 Mar 2022 13:16:12 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 220413524D
        for <git@vger.kernel.org>; Sat, 26 Mar 2022 10:14:32 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id w21so10107885wra.2
        for <git@vger.kernel.org>; Sat, 26 Mar 2022 10:14:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hbbkl5RgBjE0ijHnCLiFjo3HhP4Uf3iJvKGUO1cJUQg=;
        b=kU7E9/xzYdcw65pRImlNG8IIVa7KOmRqXpnBlVhFuuhbwxbkfy3qlfudb4zFuuxEFL
         kwodzU5Az9mqyG1WJS8xs1uvhtD8GSDpStlKYHe6xXOKC0JUkaes2C5CeZB6fa6mryCF
         UwY6tZUAspglUU5U7FDDO9oyGuNTDi5SpOl0bWnHFb+syF8CWxI12rSB+1ST18895IsF
         5ybekzTxSDcCQG8o1Sk60X32OpX7tnoUj6lesURjfu8HQU+WjNcZO7Mu2b7BEfIUFtLf
         EKR9/2z2bb7tzOtwFtmzrfC5rczzOPmerJ2Saa2MOHvzWGVQQeiwA0jq5I7Hdyoz77sx
         /Mgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hbbkl5RgBjE0ijHnCLiFjo3HhP4Uf3iJvKGUO1cJUQg=;
        b=KB9c49GlXBujMvEzWXgR9kCbeRU4iYW9H0QFHvpNUxg6fEK3B2LscLq3jF80gFuNOG
         ADwKRNV4f0mAC/jhWZbPa2+XAbcpfw7RDvsKIQf3ElC7bMVxqg6egwZgsJ3XruOKARLW
         a/TbdjnS9P679Yc7SmjM+YrQ3D+WRbbXnH/aRaO6gRhZ7+o5XkbOrwRRwCDwYH0qi9HF
         t2XNzX2bT6sdzAsKIZUulHV2KDZlyyyhs+bqam0hl6z5cFauXHcRcpVHODpWol2bWj4L
         n9g1oZAmPTheRrJNyfw49QZK/zehLQJoEvvW0Yx95V2fbNdzTtBSk3P30SCK7pcomx2N
         tK3g==
X-Gm-Message-State: AOAM533iyfi/w+6ejJVtPnENqfs6oGaowA0Hqb5OSTeo+O1BElLdRPrX
        HD0SjD4YACXr7jIxUZB0PJXla9sCvjkQ+A==
X-Google-Smtp-Source: ABdhPJxlDQZz3bRs+aRRQEKc9HwZ20Pre2MODymdDa79AY63eX+Ddrh7dIEHysPyDFdOfGym5gUVmA==
X-Received: by 2002:adf:d1ee:0:b0:204:1f72:2d78 with SMTP id g14-20020adfd1ee000000b002041f722d78mr14158193wrd.471.1648314870177;
        Sat, 26 Mar 2022 10:14:30 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l19-20020a05600c4f1300b0038cb924c3d7sm7805913wmq.45.2022.03.26.10.14.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Mar 2022 10:14:29 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 0/7] various: remove dead code, drop i18n not used in-tree
Date:   Sat, 26 Mar 2022 18:14:12 +0100
Message-Id: <cover-v3-0.7-00000000000-20220326T171200Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1535.gf8d72b9da1e
In-Reply-To: <cover-v2-0.5-00000000000-20211119T202455Z-avarab@gmail.com>
References: <cover-v2-0.5-00000000000-20211119T202455Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

An altered version of
https://lore.kernel.org/git/cover-v2-0.5-00000000000-20211119T202455Z-avarab@gmail.com
sent a while ago, I ejected the json-writer.[ch] change, which had
objections (on the v1, but it seems E-Mails were crossed).

A the range-diff shows there's a couple of new trivial patches at the
start.

I then added a patch to the end to remove some i18n-markings that
aren't used anywhere in-tree, let's not waste time translating things
for hypothetical out-of-tree users as we migrate the last bits of
functionality away from shellscripts.

Ævar Arnfjörð Bjarmason (7):
  run-command.h: remove always unused "clean_on_exit_handler_cbdata"
  configure.ac: remove USE_PIC comment
  xdiff/xmacros.h: remove unused XDL_PTRFREE
  pack-bitmap-write: remove unused bitmap_reset() function
  object-store.h: remove unused has_sha1_file*()
  alloc.[ch]: remove alloc_report() function
  git-sh-setup: don't mark trees not used in-tree for i18n

 alloc.c                                       | 21 -------------------
 alloc.h                                       |  1 -
 configure.ac                                  |  3 ---
 .../coccinelle/the_repository.pending.cocci   | 15 -------------
 ewah/bitmap.c                                 |  5 -----
 ewah/ewok.h                                   |  1 -
 git-sh-setup.sh                               | 20 +++++++++++-------
 object-store.h                                |  4 ----
 run-command.h                                 |  1 -
 xdiff/xmacros.h                               |  1 -
 10 files changed, 13 insertions(+), 59 deletions(-)

Range-diff against v2:
-:  ----------- > 1:  bac78566135 run-command.h: remove always unused "clean_on_exit_handler_cbdata"
-:  ----------- > 2:  93dc689e1aa configure.ac: remove USE_PIC comment
1:  1e7e6d8d482 = 3:  05adde5b9e4 xdiff/xmacros.h: remove unused XDL_PTRFREE
2:  c9026af8953 = 4:  6bd89f3cf42 pack-bitmap-write: remove unused bitmap_reset() function
3:  6d0ca249001 = 5:  cf7969f8f67 object-store.h: remove unused has_sha1_file*()
4:  672bdffde83 ! 6:  b60a4c24a28 alloc.[ch]: remove alloc_report() function
    @@ Commit message
         appears to have been used for demonstration purposes in that commit
         message.
     
    +    These might be handy to manually use in a debugger, but keeping them
    +    and the "count" member of "alloc_state" just for that doesn't seem
    +    worth it.
    +
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## alloc.c ##
    +@@ alloc.c: union any_object {
    + };
    + 
    + struct alloc_state {
    +-	int count; /* total number of nodes allocated */
    + 	int nr;    /* number of nodes left in current allocation */
    + 	void *p;   /* first free node in current allocation */
    + 
    +@@ alloc.c: static inline void *alloc_node(struct alloc_state *s, size_t node_size)
    + 		s->slabs[s->slab_nr++] = s->p;
    + 	}
    + 	s->nr--;
    +-	s->count++;
    + 	ret = s->p;
    + 	s->p = (char *)s->p + node_size;
    + 	memset(ret, 0, node_size);
     @@ alloc.c: void *alloc_commit_node(struct repository *r)
      	init_commit_node(c);
      	return c;
5:  818f1a46d66 < -:  ----------- json-writer.[ch]: remove unused formatting functions
-:  ----------- > 7:  7a82b1fd005 git-sh-setup: don't mark trees not used in-tree for i18n
-- 
2.35.1.1535.gf8d72b9da1e

