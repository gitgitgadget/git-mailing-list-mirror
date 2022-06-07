Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA3A9C43334
	for <git@archiver.kernel.org>; Tue,  7 Jun 2022 15:51:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236624AbiFGPvJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Jun 2022 11:51:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236463AbiFGPvH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Jun 2022 11:51:07 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 939ADEAD31
        for <git@vger.kernel.org>; Tue,  7 Jun 2022 08:51:05 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id o37-20020a05600c512500b0039c4ba4c64dso3977405wms.2
        for <git@vger.kernel.org>; Tue, 07 Jun 2022 08:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=USqDEWhNVn5nmtzUekSUhlj/+e5mLDhCbawMQssGTKg=;
        b=o3GtZGYkdvlP3nznlBULoK6tsd3/Y3z008+fbB5YoZ31Z+yCxoJ66qPwHewmlOJQ+f
         D1Njsb8mtBHgeFZAuR/7Kt7cc1dD7MOF0KC/T9dS1Y0UeFVxys78wLBEeE3v9xUgWQVi
         LEF0wUpE6gbDBCYGMSoxaHurghwPMkPe1VIYkwofT3LKtxWXPu+3aNFMk/a2jW6850Mk
         wzK6/wjdWZV0oA8GDbXatePvh5wZIiB6V9qCqERcQItCB30s2id56bFKm5EDt216eo6y
         Jh4hDSTupElqfuVFygd+S7c3W5UiZfCyN+luYtUXfR9ypRYqPR0yf0FnjIcOgtlPIeHJ
         4iVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=USqDEWhNVn5nmtzUekSUhlj/+e5mLDhCbawMQssGTKg=;
        b=AIwtnrNSolVReCCEBEBd7zugBxK/O/fQiNFGqTkmllWUklCrFdB/9+4WiTev/U4Nxy
         444/f5l5+lfrb4pBSSlB+1LIUAllf5TLgfIYBTEt8QZvwPB76iJl3ZreEPrsU9V2RJfi
         YLSxv8p/u1tR0/J4kT9JIFiBYxzqBN742dQiLOHLSzR1U6uqc7MmRZyTkl3Q4u2IBsFe
         gnhXebvX8SYujXsDS9EjJ94acNbbVhSbOHY8diI3FHJvP3AdwFeUAQ465r6TZVh6Decr
         lk64XhCfQl0J0T6Koiaau1t6w4zO5OfY/0mvbmvsdA/vZYU/vNBc7g6kFxIJq/FtDGZA
         dKCg==
X-Gm-Message-State: AOAM532fSmFv+8bXxEZ7Dg5kjbCSw7SWtY+8YrsBd1ssRYllI0WeD0Yw
        wety6iCyZhyWcHDOMBNHQJaIVZERm0OAtg==
X-Google-Smtp-Source: ABdhPJw2EXdGns9VhrMhHZq7wRY9+nDkPDzN3FQX+9rh3ij8nSY+T729fQlsnt3y6Cmvo371/cd55A==
X-Received: by 2002:a05:600c:190d:b0:394:8241:6454 with SMTP id j13-20020a05600c190d00b0039482416454mr30216571wmq.198.1654617063564;
        Tue, 07 Jun 2022 08:51:03 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id s6-20020adfbc06000000b0020fe4c5e94csm18790056wrg.19.2022.06.07.08.51.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jun 2022 08:51:03 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Phillip Wood <phillip.wood@talktalk.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 0/3] remote API: fix -fanalyzer-spotted freeing issue
Date:   Tue,  7 Jun 2022 17:50:02 +0200
Message-Id: <cover-0.3-00000000000-20220607T154520Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.1.1178.g0c3594a0ba5
In-Reply-To: <RFC-cover-00.15-00000000000-20220603T183608Z-avarab@gmail.com>
References: <RFC-cover-00.15-00000000000-20220603T183608Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series is spun off from the recent RFC -fanalyzer series[1] and
fixes a clear bug in remote_state_clear().

While doing so remove the underlying source of the landmines in the
API and use free() rather than FREE_AND_NULL() for structs that aren't
being re-used.

Then have the API free() the structure itself, rather than have
*_new() allocate it, but the caller being responsible for calling both
remote_state_clear() and free().

1. https://lore.kernel.org/git/RFC-cover-00.15-00000000000-20220603T183608Z-avarab@gmail.com/

Ævar Arnfjörð Bjarmason (3):
  remote.c: remove braces from one-statement "for"-loops
  remote.c: don't dereference NULL in freeing loop
  remote API: don't buggily FREE_AND_NULL(), free() instead

 remote.c     | 23 ++++++++++-------------
 remote.h     | 10 +++++++++-
 repository.c |  2 +-
 3 files changed, 20 insertions(+), 15 deletions(-)

Range-diff:
 1:  b3a678d934a !  1:  1879ed2826e remote.c: don't dereference NULL in freeing loop
    @@ Metadata
     Author: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## Commit message ##
    -    remote.c: don't dereference NULL in freeing loop
    +    remote.c: remove braces from one-statement "for"-loops
     
    -    Fix a bug in fd3cb0501e1 (remote: move static variables into
    -    per-repository struct, 2021-11-17) where we'd free(remote->pushurl[i])
    -    after having NULL'd out remote->pushurl. itself.
    -
    -    While we're at it let's get rid of the redundant braces per the
    -    CodingGuidelines, which also serves to show in the diff context that
    -    we were doing a FREE_AND_NULL(remote->pushurl) afterwards too, let's
    -    keep that one.
    +    Remove braces that don't follow the CodingGuidelines from code added
    +    in fd3cb0501e1 (remote: move static variables into per-repository
    +    struct, 2021-11-17). A subsequent commit will edit code adjacent to
    +    this.
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
    @@ remote.c: static void remote_clear(struct remote *remote)
     +	for (i = 0; i < remote->url_nr; i++)
      		free((char *)remote->url[i]);
     -	}
    --	FREE_AND_NULL(remote->pushurl);
    --
    + 	FREE_AND_NULL(remote->pushurl);
    + 
     -	for (i = 0; i < remote->pushurl_nr; i++) {
     +	for (i = 0; i < remote->pushurl_nr; i++)
      		free((char *)remote->pushurl[i]);
    @@ remote.c: static void remote_clear(struct remote *remote)
      	FREE_AND_NULL(remote->pushurl);
      	free((char *)remote->receivepack);
      	free((char *)remote->uploadpack);
    +@@ remote.c: void remote_state_clear(struct remote_state *remote_state)
    + {
    + 	int i;
    + 
    +-	for (i = 0; i < remote_state->remotes_nr; i++) {
    ++	for (i = 0; i < remote_state->remotes_nr; i++)
    + 		remote_clear(remote_state->remotes[i]);
    +-	}
    + 	FREE_AND_NULL(remote_state->remotes);
    + 	remote_state->remotes_alloc = 0;
    + 	remote_state->remotes_nr = 0;
 2:  4a055969ea5 <  -:  ----------- pull.c: don't feed NULL to strcmp() on get_rebase_fork_point() path
 3:  0b570d112fc <  -:  ----------- reftable: don't memset() a NULL from failed malloc()
 4:  3a287c19d7e <  -:  ----------- diff-lib.c: don't dereference NULL in oneway_diff()
 5:  46e0c307941 <  -:  ----------- refs/packed-backend.c: add a BUG() if iter is NULL
 6:  2d04035d7aa <  -:  ----------- ref-filter.c: BUG() out on show_ref() with NULL refname
 7:  cf1a5f3ed0f <  -:  ----------- strbuf.c: placate -fanalyzer in strbuf_grow()
 8:  2c4b7832144 <  -:  ----------- strbuf.c: use st_add3(), not unsigned_add_overflows()
 9:  de0f7722608 <  -:  ----------- add-patch: assert parse_diff() expectations with BUG()
10:  b50558d3b24 <  -:  ----------- reftable: don't have reader_get_block() confuse -fanalyzer
11:  66518467e1d <  -:  ----------- blame.c: clarify the state of "final_commit" for -fanalyzer
12:  9f0f515ed3a <  -:  ----------- pack.h: wrap write_*file*() functions
13:  63eeb66185a <  -:  ----------- pack-write API: pass down "verify" not arbitrary flags
14:  9cf550688d4 <  -:  ----------- config.mak.dev: add a DEVOPTS=analyzer mode to use GCC's -fanalyzer
15:  16bd2270b4c <  -:  ----------- config.mak.dev: add and use ASSERT_FOR_FANALYZER() macro
 -:  ----------- >  2:  0e258c230f6 remote.c: don't dereference NULL in freeing loop
 -:  ----------- >  3:  062fb3f454e remote API: don't buggily FREE_AND_NULL(), free() instead
-- 
2.36.1.1178.g0c3594a0ba5

