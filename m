Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9012FC3DA79
	for <git@archiver.kernel.org>; Fri, 30 Dec 2022 01:52:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234339AbiL3Bw1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Dec 2022 20:52:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbiL3BwY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Dec 2022 20:52:24 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAD59164B7
        for <git@vger.kernel.org>; Thu, 29 Dec 2022 17:52:22 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id g25-20020a7bc4d9000000b003d97c8d4941so8918843wmk.4
        for <git@vger.kernel.org>; Thu, 29 Dec 2022 17:52:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jpPohnICRcatsV64UM+JJQf5OOr79RrrN9Ym4hkrjY0=;
        b=DMP4pWgoYOWpG294S1rQLe4gkW71VYy2Il0wqEcdbYkdEayfH2bePj/Iw5T/4O61BM
         TAOSC/uWg9jLH94Kn6jDk9+Y2t9H1riNWbHSY9bHZ1O6s8cJy1LsIHKs6mQ+pah2nwtV
         eFrLtHnkfYdjD5GVpqbF6RZSKB4g+srnnUsKx1zMsYAODIBIZgl/QCPxLm9+raj0NCgO
         Q7ac/ODl163n4RVscv+OBLzK4GbvUsraACP1UVHrIeYOR9iGd/b4W5JNLqj2y8Th8lae
         BUjgRwiC49bLTxBa131Mqd0aX3kX/+NyRsXp6TyAM95eXBKVE4lZ4+Fa7NphHLPoVmTz
         mV8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jpPohnICRcatsV64UM+JJQf5OOr79RrrN9Ym4hkrjY0=;
        b=FHpRl7i3tc27DJ24K0000+oc/Q1mj+Vtlji5atENesAe2QUE6GwaE7CmmPCzIYQMQi
         Y0HFi8qPjroiH7xILd2wupV/T29R/Rgx/5aoj/Ft9dK5xWFkMj6e8XYgGwXVS7nfEGl2
         KJRVd6iakp+fSiXWLL/ekIHmUeYruLOFFLkIsKJdBJ4DcJdyum1K42IfLdzV0ZM1Dduq
         aUEPLXddn5zl6Sg68Jg8B6A3poOmTExaE/hLTX07rvK8fQQD9ExakQPibnOFVJOYAgvQ
         ugkzUqbaiCMa+giEANgH6FQ+cFMwjlZDEkardnOGaeix5X6l5n/ZevSkSPDAJrIpa6+5
         pVBw==
X-Gm-Message-State: AFqh2kolU0pNS3Nx8ufArOMqo53wahSfzQAI1yVMls6MBEV/ynKJWvNt
        5AQwpmq46fnsKW6nb5zVb9UpEZEXJX9avw==
X-Google-Smtp-Source: AMrXdXsNzXWJFlvVTMy1Q6YMF59MXpznvtsjX8K5wtLa4NUhE00avmRGjHPMTNcfj9MVQqSkNHwwdw==
X-Received: by 2002:a05:600c:5008:b0:3cf:6f4d:c25d with SMTP id n8-20020a05600c500800b003cf6f4dc25dmr21404664wmr.21.1672365140863;
        Thu, 29 Dec 2022 17:52:20 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id bh12-20020a05600c3d0c00b003cfa81e2eb4sm26649298wmb.38.2022.12.29.17.52.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Dec 2022 17:52:20 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>,
        Kousik Sanagavarapu <five231003@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 0/3] tag: don't misreport type of tagged objects in errors
Date:   Fri, 30 Dec 2022 02:52:13 +0100
Message-Id: <cover-v2-0.3-00000000000-20221230T011725Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.0.1153.g589e4efe9dc
In-Reply-To: <cover-0.4-00000000000-20221118T113442Z-avarab@gmail.com>
References: <cover-0.4-00000000000-20221118T113442Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series fixes a very long-standing issue where we'll get confused
when we parse a tag whose "type" lies about the type of the target
object.

The v1 was on top of jk/parse-object-type-mismatch, which has since
landed on "master". As I noted in [1] this covers remaining
misreporting cases which weren't addressed in that series.

Currently we'll parse tags and note what the "type" claims to be. Say
a pointer to a "blob" object that claims to be a "commit" in the
envelope.

Then when we we'd try to parse that supposed "commit' for real we'd
emit a message like:

	error: object <oid> is a blob, not a commit

Which is reversed, i.e. we'd remember the first "blob" we saw, and
then get confused about seeing a "commit" when we did the actual
parsing.

This is now fixed in almost all cases by having the one caller of
parse_tag() which actually knows the type tell it "yes, I'm sure this
is a commit".

We'll then be able to see that we have a non-parsed object as
scaffolding, but that it's really a commit, and emit the correct:

	error: object <oid> is a commit not a blob

Which goes along with other errors where the tag object itself yells
about being unhappy with the object reference.

I submitted a version of these patches back in early 2021[2], this is
significantly slimmed down since then.

At the time Jeff King noted[3] that this approach inherently can't cover
all possible scenarios. I.e. sometimes our parsing of the envelope
isn't followed up by the "real" parse.

Even in those cases we can "get it right as 3/3 here demonstrates.

But there are going to be cases left where we get it wrong, but
they're all cases where we get it wrong now. It's probably not worth
fixing the long tail of those issues, but now we'll emit a sensible
error on the common case of "log" etc.

Changes since v1:

* The v1 of this included a fix for the t.tag memory leak, which has
  now been ejected. I'm fixing that in another series[4]

  As a result we need to mark the new tests with !SANITIZE_LEAK, once
  some version of [4] lands we can un-mark these, so we'll test them
  under SANITIZE=leak.

* In the previous 1st patch I marked a "setup" test as
  "test_expect_failure", which will pass at that point, let's make it
  "test_expect_success" from the outset.

CI & branch at [5]. The "win build" CI failure is unrelated, it also
happens when I re-push master, root cause unknown, but unrelated to
this topic.

1. https://lore.kernel.org/git/221118.86cz9lgjxu.gmgdl@evledraar.gmail.com/
2. https://lore.kernel.org/git/cover-00.11-00000000000-20210328T021238Z-avarab@gmail.com/
3. https://lore.kernel.org/git/YGTGgFI19fS7Uv6I@coredump.intra.peff.net/
4. https://lore.kernel.org/git/cover-00.20-00000000000-20221228T175512Z-avarab@gmail.com/
5. https://github.com/avar/git/tree/avar/correct-object-as-type-minimal-2


Ævar Arnfjörð Bjarmason (3):
  object tests: add test for unexpected objects in tags
  tag: don't misreport type of tagged objects in errors
  tag: don't emit potentially incorrect "object is a X, not a Y"

 blob.c                                 |  11 +-
 blob.h                                 |   3 +
 commit.c                               |  11 +-
 commit.h                               |   2 +
 object.c                               |  20 +++-
 object.h                               |   2 +
 t/t6102-rev-list-unexpected-objects.sh | 146 +++++++++++++++++++++++++
 tag.c                                  |  22 +++-
 tag.h                                  |   2 +
 tree.c                                 |  11 +-
 tree.h                                 |   2 +
 11 files changed, 218 insertions(+), 14 deletions(-)

Range-diff against v1:
1:  2be8477cd78 < -:  ----------- object-file.c: free the "t.tag" in check_tag()
2:  1b5544ec868 ! 1:  0abf873f1e3 object tests: add test for unexpected objects in tags
    @@ Commit message
         report, and asserting that those are correct (currently, it's far from
         correct).
     
    +    As these tests happen to run into a memory leak skip them under
    +    SANITIZE=leak, as the test file was previously marked leak-free in
    +    [3]. There is a concurrent fix for the leak in question[4].
    +
         1. https://lore.kernel.org/git/YGTGgFI19fS7Uv6I@coredump.intra.peff.net/
    +    2. https://lore.kernel.org/git/patch-18.20-aa4df0e1b5c-20221228T175512Z-avarab@gmail.com/
    +    3. dd9cede9136 (leak tests: mark some rev-list tests as passing with
    +       SANITIZE=leak, 2021-10-31)
    +    4. https://lore.kernel.org/git/patch-18.20-aa4df0e1b5c-20221228T175512Z-avarab@gmail.com/
     
         Helped-by: Jeff King <peff@peff.net>
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
    @@ t/t6102-rev-list-unexpected-objects.sh: test_expect_success 'traverse unexpected
      	test_i18ngrep "not a blob" output
      '
      
    -+test_expect_success 'setup unexpected non-tag tag' '
    ++test_expect_success !SANITIZE_LEAK 'setup unexpected non-tag tag' '
     +	test_when_finished "git tag -d tag-commit tag-tag" &&
     +
     +	git tag -a -m"my tagged commit" tag-commit $commit &&
    @@ t/t6102-rev-list-unexpected-objects.sh: test_expect_success 'traverse unexpected
     +	git update-ref refs/tags/commit_tag_blob $commit_tag_blob
     +'
     +
    -+test_expect_failure 'traverse unexpected incorrectly typed tag (to commit & tag)' '
    ++test_expect_failure !SANITIZE_LEAK 'traverse unexpected incorrectly typed tag (to commit & tag)' '
     +	test_must_fail git rev-list --objects $tag_tag_commit 2>err &&
     +	cat >expect <<-EOF &&
     +	error: object $commit is a commit, not a tag
    @@ t/t6102-rev-list-unexpected-objects.sh: test_expect_success 'traverse unexpected
     +	test_cmp expect err
     +'
     +
    -+test_expect_failure 'traverse unexpected incorrectly typed tag (to tree)' '
    ++test_expect_failure !SANITIZE_LEAK 'traverse unexpected incorrectly typed tag (to tree)' '
     +	test_must_fail git rev-list --objects $tag_tag_tree 2>err &&
     +	cat >expect <<-EOF &&
     +	error: object $tree is a tree, not a tag
    @@ t/t6102-rev-list-unexpected-objects.sh: test_expect_success 'traverse unexpected
     +	test_cmp expect err
     +'
     +
    -+test_expect_failure 'traverse unexpected incorrectly typed tag (to blob)' '
    ++test_expect_failure !SANITIZE_LEAK 'traverse unexpected incorrectly typed tag (to blob)' '
     +	test_must_fail git rev-list --objects $tag_tag_blob 2>err &&
     +	cat >expect <<-EOF &&
     +	error: object $blob is a blob, not a tag
    @@ t/t6102-rev-list-unexpected-objects.sh: test_expect_success 'traverse unexpected
     +	test_cmp expect err
     +'
     +
    -+test_expect_failure 'traverse unexpected non-tag tag (tree seen to blob)' '
    ++test_expect_failure !SANITIZE_LEAK 'traverse unexpected non-tag tag (tree seen to blob)' '
     +	test_must_fail git rev-list --objects $tree $commit_tag_blob 2>err &&
     +	cat >expect <<-EOF &&
     +	error: object $blob is a blob, not a commit
    @@ t/t6102-rev-list-unexpected-objects.sh: test_expect_success 'traverse unexpected
     +'
     +
     +
    -+test_expect_failure 'traverse unexpected objects with for-each-ref' '
    ++test_expect_failure !SANITIZE_LEAK 'traverse unexpected objects with for-each-ref' '
     +	cat >expect <<-EOF &&
     +	error: bad tag pointer to $tree in $tag_tag_tree
     +	fatal: parse_object_buffer failed on $tag_tag_tree for refs/tags/tag_tag_tree
    @@ t/t6102-rev-list-unexpected-objects.sh: test_expect_success 'traverse unexpected
     +'
     +
     +>fsck-object-isa
    -+test_expect_failure 'setup: unexpected objects with fsck' '
    ++test_expect_success 'setup: unexpected objects with fsck' '
     +	test_must_fail git fsck 2>err &&
     +	sed -n -e "/^error: object .* is a .*, not a .*$/ {
     +		s/^error: object \([0-9a-f]*\) is a \([a-z]*\), not a [a-z]*$/\\1 \\2/;
    @@ t/t6102-rev-list-unexpected-objects.sh: test_expect_success 'traverse unexpected
     +	'
     +done <fsck-object-isa
     +
    -+test_expect_success 'traverse unexpected non-tag tag (blob seen to blob)' '
    ++test_expect_success !SANITIZE_LEAK 'traverse unexpected non-tag tag (blob seen to blob)' '
     +	test_must_fail git rev-list --objects $blob $commit_tag_blob 2>err &&
     +	cat >expected <<-EOF &&
     +	error: object $blob is a blob, not a commit
3:  468af961dc4 ! 2:  96398731841 tag: don't misreport type of tagged objects in errors
    @@ blob.c
     +	return lookup_blob_type(r, oid, OBJ_NONE);
      }
      
    - int parse_blob_buffer(struct blob *item, void *buffer, unsigned long size)
    + void parse_blob_buffer(struct blob *item)
     
      ## blob.h ##
     @@ blob.h: struct blob {
    @@ blob.h: struct blob {
     +			      const struct object_id *oid,
     +			      enum object_type type);
      
    - int parse_blob_buffer(struct blob *item, void *buffer, unsigned long size);
    - 
    + /**
    +  * Blobs do not contain references to other objects and do not have
     
      ## commit.c ##
     @@ commit.c: struct commit *lookup_commit_object(struct repository *r,
    @@ object.c: struct object *parse_object_buffer(struct repository *r, const struct
     -		struct blob *blob = lookup_blob(r, oid);
     +		struct blob *blob = lookup_blob_type(r, oid, type);
      		if (blob) {
    - 			if (parse_blob_buffer(blob, buffer, size))
    - 				return NULL;
    + 			parse_blob_buffer(blob);
      			obj = &blob->object;
      		}
      	} else if (type == OBJ_TREE) {
    @@ object.h: struct object *lookup_object(struct repository *r, const struct object
       * Returns the object, having parsed it to find out what it is.
     
      ## t/t6102-rev-list-unexpected-objects.sh ##
    -@@ t/t6102-rev-list-unexpected-objects.sh: test_expect_success 'setup unexpected non-tag tag' '
    +@@ t/t6102-rev-list-unexpected-objects.sh: test_expect_success !SANITIZE_LEAK 'setup unexpected non-tag tag' '
      	git update-ref refs/tags/commit_tag_blob $commit_tag_blob
      '
      
    --test_expect_failure 'traverse unexpected incorrectly typed tag (to commit & tag)' '
    -+test_expect_success 'traverse unexpected incorrectly typed tag (to commit & tag)' '
    +-test_expect_failure !SANITIZE_LEAK 'traverse unexpected incorrectly typed tag (to commit & tag)' '
    ++test_expect_success !SANITIZE_LEAK 'traverse unexpected incorrectly typed tag (to commit & tag)' '
      	test_must_fail git rev-list --objects $tag_tag_commit 2>err &&
      	cat >expect <<-EOF &&
      	error: object $commit is a commit, not a tag
    -@@ t/t6102-rev-list-unexpected-objects.sh: test_expect_failure 'traverse unexpected incorrectly typed tag (to commit & tag)
    +@@ t/t6102-rev-list-unexpected-objects.sh: test_expect_failure !SANITIZE_LEAK 'traverse unexpected incorrectly typed tag (t
      	test_cmp expect err
      '
      
    --test_expect_failure 'traverse unexpected incorrectly typed tag (to tree)' '
    -+test_expect_success 'traverse unexpected incorrectly typed tag (to tree)' '
    +-test_expect_failure !SANITIZE_LEAK 'traverse unexpected incorrectly typed tag (to tree)' '
    ++test_expect_success !SANITIZE_LEAK 'traverse unexpected incorrectly typed tag (to tree)' '
      	test_must_fail git rev-list --objects $tag_tag_tree 2>err &&
      	cat >expect <<-EOF &&
      	error: object $tree is a tree, not a tag
    -@@ t/t6102-rev-list-unexpected-objects.sh: test_expect_failure 'traverse unexpected incorrectly typed tag (to tree)' '
    +@@ t/t6102-rev-list-unexpected-objects.sh: test_expect_failure !SANITIZE_LEAK 'traverse unexpected incorrectly typed tag (t
      	test_cmp expect err
      '
      
    --test_expect_failure 'traverse unexpected incorrectly typed tag (to blob)' '
    -+test_expect_success 'traverse unexpected incorrectly typed tag (to blob)' '
    +-test_expect_failure !SANITIZE_LEAK 'traverse unexpected incorrectly typed tag (to blob)' '
    ++test_expect_success !SANITIZE_LEAK 'traverse unexpected incorrectly typed tag (to blob)' '
      	test_must_fail git rev-list --objects $tag_tag_blob 2>err &&
      	cat >expect <<-EOF &&
      	error: object $blob is a blob, not a tag
    -@@ t/t6102-rev-list-unexpected-objects.sh: test_expect_failure 'traverse unexpected incorrectly typed tag (to blob)' '
    +@@ t/t6102-rev-list-unexpected-objects.sh: test_expect_failure !SANITIZE_LEAK 'traverse unexpected incorrectly typed tag (t
      	test_cmp expect err
      '
      
    --test_expect_failure 'traverse unexpected non-tag tag (tree seen to blob)' '
    -+test_expect_success 'traverse unexpected non-tag tag (tree seen to blob)' '
    +-test_expect_failure !SANITIZE_LEAK 'traverse unexpected non-tag tag (tree seen to blob)' '
    ++test_expect_success !SANITIZE_LEAK 'traverse unexpected non-tag tag (tree seen to blob)' '
      	test_must_fail git rev-list --objects $tree $commit_tag_blob 2>err &&
      	cat >expect <<-EOF &&
      	error: object $blob is a blob, not a commit
4:  1a9dcb9e05d ! 3:  2493988c41c tag: don't emit potentially incorrect "object is a X, not a Y"
    @@ Commit message
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## t/t6102-rev-list-unexpected-objects.sh ##
    -@@ t/t6102-rev-list-unexpected-objects.sh: test_expect_success 'traverse unexpected non-tag tag (tree seen to blob)' '
    +@@ t/t6102-rev-list-unexpected-objects.sh: test_expect_success !SANITIZE_LEAK 'traverse unexpected non-tag tag (tree seen t
      '
      
      
    --test_expect_failure 'traverse unexpected objects with for-each-ref' '
    -+test_expect_success 'traverse unexpected objects with for-each-ref' '
    +-test_expect_failure !SANITIZE_LEAK 'traverse unexpected objects with for-each-ref' '
    ++test_expect_success !SANITIZE_LEAK 'traverse unexpected objects with for-each-ref' '
      	cat >expect <<-EOF &&
      	error: bad tag pointer to $tree in $tag_tag_tree
      	fatal: parse_object_buffer failed on $tag_tag_tree for refs/tags/tag_tag_tree
    -@@ t/t6102-rev-list-unexpected-objects.sh: test_expect_failure 'traverse unexpected objects with for-each-ref' '
    - '
    - 
    - >fsck-object-isa
    --test_expect_failure 'setup: unexpected objects with fsck' '
    -+test_expect_success 'setup: unexpected objects with fsck' '
    - 	test_must_fail git fsck 2>err &&
    - 	sed -n -e "/^error: object .* is a .*, not a .*$/ {
    - 		s/^error: object \([0-9a-f]*\) is a \([a-z]*\), not a [a-z]*$/\\1 \\2/;
    -@@ t/t6102-rev-list-unexpected-objects.sh: test_expect_failure 'setup: unexpected objects with fsck' '
    +@@ t/t6102-rev-list-unexpected-objects.sh: test_expect_success 'setup: unexpected objects with fsck' '
      
      while read oid type
      do
-- 
2.39.0.1153.g589e4efe9dc

