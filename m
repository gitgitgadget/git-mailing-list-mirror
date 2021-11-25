Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1273CC433F5
	for <git@archiver.kernel.org>; Thu, 25 Nov 2021 22:06:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244765AbhKYWJ0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 Nov 2021 17:09:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343939AbhKYWHZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Nov 2021 17:07:25 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBAD6C061574
        for <git@vger.kernel.org>; Thu, 25 Nov 2021 14:03:48 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id a18so14429101wrn.6
        for <git@vger.kernel.org>; Thu, 25 Nov 2021 14:03:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=O1KV67visnMLJTYOw3iW2kpfidVEHHbvYbIfWfVxq/s=;
        b=RIedw97MlTK/+/LZt8N5OXiVQjsT777XKclGXkJ9EpxKqRdVd6a/x7qqZcqM5fsZFg
         wmVOU9qWPn83wM1j6VF40LGhX6N/FJJcOzRBHRHaIDZ+LFxND2cLaepXyt9qRwxWRZu5
         wNS6Y0mV421baDgnXtqOJCjX6LzDHMUURtGoJ3Ylwy/Kk/hQR+c2lVgMZEGcSmXMgIn/
         lS9zDyDxwFYJ/hPO5/k2B2gKvlV5lGeoMkJxAnvMXbZQnepl4NgU+/hM340/ne++UqEL
         I1CR8G4ircDq4VqtfxZQeMx7J+uGr77ZOj/qlGL9n+UkDbBoputbtuRjVVYzPsCTvgAS
         9pcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=O1KV67visnMLJTYOw3iW2kpfidVEHHbvYbIfWfVxq/s=;
        b=4SV06OrQ762JU9EvwEahylaNYx9l7JgndPY5AeEc1dDuUKa6j1mS5uWJ0NBiSYLngx
         pXJhUHa/+YNVBI5LRZFXmUFMaqKBBEJ9vzCmeeEP0GQ644i0AMSP28ehxVQZADWkP9Ye
         tzNdgeuPIHbT5RpBR+SHE2pKEfam7Rm+1mpQQEbLk1gfyumgIcdzmLaSQZScz7MPTD+k
         vgAn+JqhgTeVQwRD1RxdjC0J3wfeFU3mSgGKmUdI8wklG9fF124J4Bh887t2L+85iQkZ
         3uBD8fV0LzK8ngVWq8g8Njshk5so7tyIOi1qbigE+QUIqtO18S24jZD2Wgmx2G25xWmb
         hI0Q==
X-Gm-Message-State: AOAM5313+pBrbor2JQ3+Rl8t0gK/OQkFTQAXc92iLtvmKVMqYPKDG7ps
        QQ/AF11Uhorz4wJ3FqnDVt86nHR+F2E=
X-Google-Smtp-Source: ABdhPJwD/1Yi4rIJLQnsdx2n8PXzHPFSNxrrTQ+hBar/6Gz3VLou20yxHViVIZRQlafpIcxGLbS58A==
X-Received: by 2002:a05:6000:2c4:: with SMTP id o4mr10377431wry.303.1637877826795;
        Thu, 25 Nov 2021 14:03:46 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n2sm8883726wmi.36.2021.11.25.14.03.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Nov 2021 14:03:46 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 0/6] object-name: make ambiguous object output translatable + show tag date
Date:   Thu, 25 Nov 2021 23:03:38 +0100
Message-Id: <cover-v5-0.6-00000000000-20211125T215529Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.1.838.g779e9098efb
In-Reply-To: <cover-v4-0.3-00000000000-20211122T175219Z-avarab@gmail.com>
References: <cover-v4-0.3-00000000000-20211122T175219Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This topic improves the output we emit on ambiguous objects as noted
in 4/6, and makes it translatable, see 3/6. See [1] for v4.

This addresses the feedback Jeff King had on v4. There weren't any
tests for cases where we'd return -1 when parsing objects, and I was
focused on different object types in earlier iterations, and missed
that case.

So this v5 leads with some exhaustive testing of the existing
functionality to address that and other blind spots,

I then resurrected the patch from an earlier iteration to buffer the
output for a single advice() call at the end. As the exhaustive tests
that we have now show if we call error() (which can and will happen
several times on invalid objects) while parsing our N objects, we'll
split up the header and body for the advice(), by buffering it up
we're guaranteed to print errors and the payload separately.

1. https://lore.kernel.org/git/cover-v4-0.3-00000000000-20211122T175219Z-avarab@gmail.com

Ævar Arnfjörð Bjarmason (6):
  object-name tests: add tests for ambiguous object blind spots
  object-name: explicitly handle OBJ_BAD in show_ambiguous_object()
  object-name: make ambiguous object output translatable
  object-name: show date for ambiguous tag objects
  object-name: iterate ambiguous objects before showing header
  object-name: re-use "struct strbuf" in show_ambiguous_object()

 object-name.c                       | 111 +++++++++++++++++++++++++---
 t/t1512-rev-parse-disambiguation.sh |  83 +++++++++++++++++++++
 2 files changed, 182 insertions(+), 12 deletions(-)

Range-diff against v4:
-:  ----------- > 1:  767165d096d object-name tests: add tests for ambiguous object blind spots
1:  2e7090c09f9 ! 2:  ee86912f1c1 object-name: remove unreachable "unknown type" handling
    @@ Metadata
     Author: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## Commit message ##
    -    object-name: remove unreachable "unknown type" handling
    +    object-name: explicitly handle OBJ_BAD in show_ambiguous_object()
     
    -    Remove unreachable "unknown type" handling in the code that displays
    -    the ambiguous object list. See [1] for the current output, and [1] for
    -    the commit that added the "unknown type" handling.
    +    Amend the "unknown type" handling in the code that displays the
    +    ambiguous object list to assert() that we're either going to get the
    +    "real" object types we can pass to type_name(), or a -1 (OBJ_BAD)
    +    return value from oid_object_info().
     
    -    The reason this code wasn't reachable is because we're not passing in
    -    OBJECT_INFO_ALLOW_UNKNOWN_TYPE, so we'll die in sort_ambiguous()
    -    before we get to show_ambiguous_object():
    +    See [1] for the current output, and [1] for the commit that added the
    +    "unknown type" handling.
     
    -        $ git rev-parse 8315
    -        error: short object ID 8315 is ambiguous
    -        hint: The candidates are:
    -        fatal: invalid object type
    +    We are never going to get an "unknown type" in the sense of custom
    +    types crafted with "hash-object --literally", since we're not using
    +    the OBJECT_INFO_ALLOW_UNKNOWN_TYPE flag.
     
    -    We should do better here, but let's leave that for some future
    -    improvement. In a subsequent commit I'll improve the output we do
    -    show, and not having to handle the "unknown type" case simplifies that
    -    change.
    +    If we manage to otherwise unpack such an object without errors we'll
    +    die() in parse_loose_header_extended() called by sort_ambiguous()
    +    before we get to show_ambiguous_object(), as is asserted by the test
    +    added in the preceding commit.
     
    -    Even though we know that this isn't reachable let's back that up with
    -    an assert() both for self-documentation and sanity checking.
    +    So saying "unknown type" here was always misleading, we really meant
    +    to say that we had a failure parsing the object at all, if the problem
    +    is only that it's type is unknown we won't reach this code.
    +
    +    So let's emit a generic "[bad object]" instead. As our tests added in
    +    the preceding commit show, we'll have emitted various "error" output
    +    already in those cases.
    +
    +    We should do better in the truly "unknown type" cases, which we'd need
    +    to handle if we were passing down the OBJECT_INFO_ALLOW_UNKNOWN_TYPE
    +    flag. But let's leave that for some future improvement. In a
    +    subsequent commit I'll improve the output we do show, and not having
    +    to handle the "unknown type" (as in OBJECT_INFO_ALLOW_UNKNOWN_TYPE)
    +    simplifies that change.
     
         1. 5cc044e0257 (get_short_oid: sort ambiguous objects by type,
            then SHA-1, 2018-05-10)
    @@ object-name.c: static int show_ambiguous_object(const struct object_id *oid, voi
      		return 0;
      
      	type = oid_object_info(ds->repo, oid, NULL);
    ++
    ++	if (type < 0) {
    ++		strbuf_addstr(&desc, "[bad object]");
    ++		goto out;
    ++	}
    ++
     +	assert(type == OBJ_TREE || type == OBJ_COMMIT ||
     +	       type == OBJ_BLOB || type == OBJ_TAG);
    ++	strbuf_addstr(&desc, type_name(type));
    ++
      	if (type == OBJ_COMMIT) {
      		struct commit *commit = lookup_commit(ds->repo, oid);
      		if (commit) {
     @@ object-name.c: static int show_ambiguous_object(const struct object_id *oid, void *data)
    + 			strbuf_addf(&desc, " %s", tag->tag);
    + 	}
      
    - 	advise("  %s %s%s",
    +-	advise("  %s %s%s",
    ++out:
    ++	advise("  %s %s",
      	       repo_find_unique_abbrev(ds->repo, oid, DEFAULT_ABBREV),
     -	       type_name(type) ? type_name(type) : "unknown type",
    --	       desc.buf);
    -+	       type_name(type), desc.buf);
    + 	       desc.buf);
      
      	strbuf_release(&desc);
    - 	return 0;
    +
    + ## t/t1512-rev-parse-disambiguation.sh ##
    +@@ t/t1512-rev-parse-disambiguation.sh: test_expect_success POSIXPERM 'ambigous zlib corrupt loose blob' '
    + 	error: unable to unpack cafe... header
    + 	error: inflate: data stream error (incorrect header check)
    + 	error: unable to unpack cafe... header
    +-	hint:   cafe... unknown type
    ++	hint:   cafe... [bad object]
    + 	hint:   cafe... blob
    + 	fatal: ambiguous argument '\''cafe...'\'': unknown revision or path not in the working tree.
    + 	Use '\''--'\'' to separate paths from revisions, like this:
2:  00d84faeb1d ! 3:  b79964483e8 object-name: make ambiguous object output translatable
    @@ object-name.c: static int show_ambiguous_object(const struct object_id *oid, voi
      
      	if (ds->fn && !ds->fn(ds->repo, oid, ds->cb_data))
      		return 0;
    -@@ object-name.c: static int show_ambiguous_object(const struct object_id *oid, void *data)
    + 
    ++	hash = repo_find_unique_abbrev(ds->repo, oid, DEFAULT_ABBREV);
      	type = oid_object_info(ds->repo, oid, NULL);
    + 
    + 	if (type < 0) {
    +-		strbuf_addstr(&desc, "[bad object]");
    ++		/*
    ++		 * TRANSLATORS: This is a line of ambiguous object
    ++		 * output shown when we cannot look up or parse the
    ++		 * object in question. E.g. "deadbeef [bad object]".
    ++		 */
    ++		strbuf_addf(&desc, _("%s [bad object]"), hash);
    + 		goto out;
    + 	}
    + 
      	assert(type == OBJ_TREE || type == OBJ_COMMIT ||
      	       type == OBJ_BLOB || type == OBJ_TAG);
    -+	hash = repo_find_unique_abbrev(ds->repo, oid, DEFAULT_ABBREV);
    -+
    +-	strbuf_addstr(&desc, type_name(type));
    + 
      	if (type == OBJ_COMMIT) {
     +		struct strbuf ad = STRBUF_INIT;
     +		struct strbuf s = STRBUF_INIT;
    @@ object-name.c: static int show_ambiguous_object(const struct object_id *oid, voi
     +		 * object output. E.g. "deadbeef blob".
     +		 */
     +		strbuf_addf(&desc, _("%s blob"), hash);
    -+	} else {
    -+		BUG("unreachable");
      	}
      
    --	advise("  %s %s%s",
    ++
    + out:
    +-	advise("  %s %s",
     -	       repo_find_unique_abbrev(ds->repo, oid, DEFAULT_ABBREV),
    --	       type_name(type), desc.buf);
    +-	       desc.buf);
     +	/*
    -+	 * TRANSLATORS: This is line item of ambiguous object output,
    -+	 * translated above.
    ++	 * TRANSLATORS: This is line item of ambiguous object output
    ++	 * from describe_ambiguous_object() above.
     +	 */
     +	advise(_("  %s"), desc.buf);
      
3:  9d24bab635d ! 4:  36b6b440c37 object-name: show date for ambiguous tag objects
    @@ object-name.c: static int show_ambiguous_object(const struct object_id *oid, voi
      
      		/*
      		 * TRANSLATORS: This is a line of
    -@@ object-name.c: static int show_ambiguous_object(const struct object_id *oid, void *data)
    + 		 * ambiguous tag object output. E.g.:
    + 		 *
    +-		 *    "deadbeef tag Some Tag Message"
    ++		 *    "deadbeef tag 2021-01-01 - Some Tag Message"
    + 		 *
    + 		 * The second argument is the "tag" string from
      		 * object.c, it should (hopefully) already be
      		 * translated.
      		 */
-:  ----------- > 5:  8880c283559 object-name: iterate ambiguous objects before showing header
-:  ----------- > 6:  78bb0995f08 object-name: re-use "struct strbuf" in show_ambiguous_object()
-- 
2.34.1.838.g779e9098efb

