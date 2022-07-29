Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05C4BC19F2B
	for <git@archiver.kernel.org>; Fri, 29 Jul 2022 08:31:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235127AbiG2IbR (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Jul 2022 04:31:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235032AbiG2IbP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Jul 2022 04:31:15 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CF133AE48
        for <git@vger.kernel.org>; Fri, 29 Jul 2022 01:31:14 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id v17so5097822wrr.10
        for <git@vger.kernel.org>; Fri, 29 Jul 2022 01:31:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=hDkJ9Hy5+FQvLv7qH1k6Lf8OKqz+mqy0UzCzfiVBF1s=;
        b=TZjfPGS5/D5HeJPCFW5QdBjt0nAZrH2v2pPvVsDxFQCtFpXyvSrLL+lYapYRKE7S69
         nGOWjIPWfvdrYI1EuGeBkjS2+sydSRiWRjZN6nYlzZjrQCXi1VJdn2EBzO05Tp12M1Jj
         lKvSnyPAu3/NAxT+xYGJEQJC6RfZvn5gGkQWniNVk2lexm4bCzz56BB2mUjGmx9KxrAX
         5iNHC2bryFmnq9wa4XePbDyAuo1gqW2gtXdFty1l8TOCsZXnKL4ctpnTqCzleorCdvQw
         EATVXx/sqmDcGgVowe4lSfVMfl+1q6R87V08kc7L6wL7nTYt3BfaRpbOKUb4CO5mgYdG
         7Pow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=hDkJ9Hy5+FQvLv7qH1k6Lf8OKqz+mqy0UzCzfiVBF1s=;
        b=5lZfTl3cJFQJbVAOgda4osAbnpgEP3U3nZKhKvctkCY1ia9W3YHHYUDEbORjHqCT8h
         NtCFudUXxXhUfLkctt5rYnx2fUVThI5IKlKgOHKhXlmVD39mqndD1wo9DHLvUja199b4
         J+hjMw4weoVChYSqYa+4HZpQB5CoGVubSIG8MELpbAqGGk5ac2MBrEk/D/SNFdGCgJ6c
         ztaaXjzB6cv2IuA0lY6p0QJ8XDiZUi+cIq+kchJ0Z3bSz2mp+AIAy9TEcGyV1KNRRw+R
         7iEinKqqYYbhPcgcQqLDvRpLQH3gub+pyUrum5CkX4Y26HE9YpEYfd8JaKIslq8J5MVY
         oWqw==
X-Gm-Message-State: ACgBeo1VPeyzcd+dTEj5MsBUU5Bh1ensogk4qvFWd0p6ZNPPGexDE2pR
        df6kFnlRJ/c9pJm8iLXj8YG35JxX3dz7dA==
X-Google-Smtp-Source: AA6agR6h4UvgaPsv6ui7ZFb07U92pGtUbEYxT+EUb+7Op8A6QJ9luY6wdfz73uWoqC3dlubIQuyEtQ==
X-Received: by 2002:a05:6000:1284:b0:21e:6526:bef5 with SMTP id f4-20020a056000128400b0021e6526bef5mr1582513wrx.488.1659083472253;
        Fri, 29 Jul 2022 01:31:12 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id f13-20020adfe90d000000b0021f0c0c62d1sm2325467wrm.13.2022.07.29.01.31.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Jul 2022 01:31:11 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 0/6] revisions API: fix more memory leaks
Date:   Fri, 29 Jul 2022 10:31:02 +0200
Message-Id: <cover-v2-0.6-00000000000-20220729T082919Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.1.1196.g8af3636bc64
In-Reply-To: <cover-0.6-00000000000-20220713T130511Z-avarab@gmail.com>
References: <cover-0.6-00000000000-20220713T130511Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A late re-roll of this set of revisions API and API user memory leak
fixes. I think the much simpler code here in 4/6 should address the
points Jeff King brought up in the v1 review.

Other than that I renamed the variable in 3/6 s/cp/pending/g, per
Jeff's suggestion (FWIW "cp" = "copy").

1. https://lore.kernel.org/git/cover-0.6-00000000000-20220713T130511Z-avarab@gmail.com/

Ævar Arnfjörð Bjarmason (6):
  bisect.c: add missing "goto" for release_revisions()
  test-fast-rebase helper: use release_revisions() (again)
  log: make the intent of cmd_show()'s "rev.pending" juggling clearer
  log: fix common "rev.pending" memory leak in "git show"
  bisect.c: partially fix bisect_rev_setup() memory leak
  revisions API: don't leak memory on argv elements that need free()-ing

 bisect.c                                      | 28 +++++++++++--------
 builtin/log.c                                 | 21 +++++++-------
 builtin/submodule--helper.c                   |  5 +++-
 remote.c                                      |  5 +++-
 revision.c                                    |  2 ++
 revision.h                                    |  3 +-
 t/helper/test-fast-rebase.c                   |  2 --
 t/t0203-gettext-setlocale-sanity.sh           |  1 +
 t/t1020-subdirectory.sh                       |  1 +
 t/t2020-checkout-detach.sh                    |  1 +
 t/t3307-notes-man.sh                          |  1 +
 t/t3920-crlf-messages.sh                      |  2 ++
 t/t4069-remerge-diff.sh                       |  1 +
 t/t7007-show.sh                               |  1 +
 ...3-pre-commit-and-pre-merge-commit-hooks.sh |  1 +
 t/t9122-git-svn-author.sh                     |  1 -
 t/t9162-git-svn-dcommit-interactive.sh        |  1 -
 17 files changed, 49 insertions(+), 28 deletions(-)

Range-diff against v1:
1:  6624eb315a5 = 1:  12a4a20c59f bisect.c: add missing "goto" for release_revisions()
2:  0da0acba8b0 = 2:  bbd3a7e5ecc test-fast-rebase helper: use release_revisions() (again)
3:  f7cc2f6a381 ! 3:  1629299f883 log: make the intent of cmd_show()'s "rev.pending" juggling clearer
    @@ builtin/log.c: static void show_setup_revisions_tweak(struct rev_info *rev,
      	struct rev_info rev;
     -	struct object_array_entry *objects;
     +	struct object_array blank = OBJECT_ARRAY_INIT;
    -+	struct object_array cp = OBJECT_ARRAY_INIT;
    ++	struct object_array pending = OBJECT_ARRAY_INIT;
     +	unsigned int i;
      	struct setup_revision_opt opt;
      	struct pathspec match_all;
    @@ builtin/log.c: int cmd_show(int argc, const char **argv, const char *prefix)
      
     -	count = rev.pending.nr;
     -	objects = rev.pending.objects;
    -+	memcpy(&cp, &rev.pending, sizeof(rev.pending));
    ++	memcpy(&pending, &rev.pending, sizeof(rev.pending));
      	rev.diffopt.no_free = 1;
     -	for (i = 0; i < count && !ret; i++) {
     -		struct object *o = objects[i].item;
     -		const char *name = objects[i].name;
    -+	for (i = 0; i < cp.nr && !ret; i++) {
    -+		struct object *o = cp.objects[i].item;
    -+		const char *name = cp.objects[i].name;
    ++	for (i = 0; i < pending.nr && !ret; i++) {
    ++		struct object *o = pending.objects[i].item;
    ++		const char *name = pending.objects[i].name;
      		switch (o->type) {
      		case OBJ_BLOB:
      			ret = show_blob_object(&o->oid, &rev, name);
    @@ builtin/log.c: int cmd_show(int argc, const char **argv, const char *prefix)
      				ret = error(_("could not read object %s"),
      					    oid_to_hex(oid));
     -			objects[i].item = o;
    -+			cp.objects[i].item = o;
    ++			pending.objects[i].item = o;
      			i--;
      			break;
      		}
4:  2c5b41d2b24 ! 4:  54b632c1124 log: fix common "rev.pending" memory leak in "git show"
    @@ Commit message
         In the preceding commit this code was made to use a more extendable
         pattern, which we can now complete. Once we've clobbered our
         "rev.pending" and invoked "cmd_log_walk_no_free()" we need to
    -    "object_array_clear()" our newly created "rev.pending" to avoid
    -    leaking the memory related to the one member array we've created.
    +    "object_array_clear()" our old "rev.pending".
     
    -    But more importantly we need to set "rev.pending" back to the original
    -    we squirreled away in the "cp" variable, so that we'll make use of the
    +    So in addition to the now-populated &pending array, to avoid leaking
    +    the memory related to the one member array we've created. The
    +    &rev.pending was already being object_array_clear()'d by the
         release_revisions() added in f6bfea0ad01 (revisions API users: use
    -    release_revisions() in builtin/log.c, 2022-04-13). In f6bfea0ad01 this
    -    memory leak was noted as an outstanding TODO, but it's now been fixed.
    +    release_revisions() in builtin/log.c, 2022-04-13), now we'll also
    +    correctly free the previous data (f6bfea0ad01 noted this memory leak
    +    as an outstanding TODO).
    +
    +    This way of doing it is making assumptions about the internals of
    +    "struct rev_info", in particular that the "pending" member is
    +    stand-alone, and that no other state is referring to it. But we've
    +    been making those assumptions ever since 5d7eeee2ac6 (git-show: grok
    +    blobs, trees and tags, too, 2006-12-14).
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## builtin/log.c ##
     @@ builtin/log.c: int cmd_show(int argc, const char **argv, const char *prefix)
    - 			memcpy(&rev.pending, &blank, sizeof(rev.pending));
    + 		return cmd_log_deinit(cmd_log_walk(&rev), &rev);
    + 
    + 	memcpy(&pending, &rev.pending, sizeof(rev.pending));
    ++	memcpy(&rev.pending, &blank, sizeof(rev.pending));
    + 	rev.diffopt.no_free = 1;
    + 	for (i = 0; i < pending.nr && !ret; i++) {
    + 		struct object *o = pending.objects[i].item;
    +@@ builtin/log.c: int cmd_show(int argc, const char **argv, const char *prefix)
    + 			rev.shown_one = 1;
    + 			break;
    + 		case OBJ_COMMIT:
    +-			memcpy(&rev.pending, &blank, sizeof(rev.pending));
      			add_object_array(o, name, &rev.pending);
      			ret = cmd_log_walk_no_free(&rev);
    -+			object_array_clear(&rev.pending);
    -+			memcpy(&rev.pending, &cp, sizeof(rev.pending));
      			break;
    - 		default:
    +@@ builtin/log.c: int cmd_show(int argc, const char **argv, const char *prefix)
      			ret = error(_("unknown type: %d"), o->type);
    + 		}
    + 	}
    ++	object_array_clear(&pending);
    + 
    + 	rev.diffopt.no_free = 0;
    + 	diff_free(&rev.diffopt);
     
      ## t/t0203-gettext-setlocale-sanity.sh ##
     @@
5:  525e3427396 = 5:  2af2bce2d17 bisect.c: partially fix bisect_rev_setup() memory leak
6:  291e660a2bc = 6:  3c57e126554 revisions API: don't leak memory on argv elements that need free()-ing
-- 
2.37.1.1196.g8af3636bc64

