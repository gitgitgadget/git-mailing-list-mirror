Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85600C433EF
	for <git@archiver.kernel.org>; Thu, 27 Jan 2022 05:26:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236151AbiA0F05 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Jan 2022 00:26:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232519AbiA0F04 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Jan 2022 00:26:56 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B0BEC06161C
        for <git@vger.kernel.org>; Wed, 26 Jan 2022 21:26:56 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id v13so2573406wrv.10
        for <git@vger.kernel.org>; Wed, 26 Jan 2022 21:26:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=utDHoK5SzY9vl3zIUbkmlkkHUkxPaAXThxbEHIaRi9I=;
        b=XYu2NL/7Ntr4F4l0LaY2QEkkGifnjifux2AJwP73lPR2jLYbTvdHBvKZ3EcDFeSMbX
         rPtpahQ5WPmXweeXjGiV1KjKAhBbKxBeOBo4YvGk4hR3Hs9R4MYyeNfpGgr3SYzgyuSX
         ev4SvJoXDMcD0mXZfiwZdj2mikq6oPB4ROZoqW/iA9ys4dXfNwwl4wdmjRs08d3lY4eK
         PPd47avohPzo2qLq741zQA9PZeuEUIzbgUsFyUil/mtVGfR4qKKyx7pIjPm8d08jIaIe
         4+LiM662p16ISdQ7l7/0ROxFwCFBjjuOShkKgZnpqUVGyrLRXHm/agJ9JH5fLs3K/Eoc
         jXng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=utDHoK5SzY9vl3zIUbkmlkkHUkxPaAXThxbEHIaRi9I=;
        b=EmvLszEg7BFpE3RZMgIFfdcu03qVVaz2aPqMisBv3vG9GyMWAh1wcTqgccgnCifrEQ
         brD+iUYtKDe78BV9nH7XT2QMm0K34Z0hqbX1/7Z7ojACDBED3OnxnKEwi7M+r2dg3z8z
         me/9IrQ3TCU9zQOUZlrSjrDHgwPTS+4AU2LKKqNo5zZu6Jf38atBpQenmePmMwaYCdUi
         1IhPNoxiIbG4Y2qISa+4Ra+C/ocXkKELYj0b+i1WFh5u4MtGC1pYrqvf35TWIy4VyH3+
         6V29wBiPoKYV4jGQ3b3eX1u2VmGZUMdlV9UEjapTcYMIc2gvuRKQkIw4zN6YSr8k0Vhv
         yIHQ==
X-Gm-Message-State: AOAM533+fwWUjLevCGGHQacc8A3NMdFBfKUpwDsFuhHRpIahm8PyzTdK
        CSoiWnvd8pF/X/6xRDOasX7wuEx9Nbm0Vg==
X-Google-Smtp-Source: ABdhPJz2imp8ZxZYdhYHNrxn1HmQEPTKqBr5hU4WH++Z5LBkGNen7lCvtORe/GQXj2I9beJYI28p1A==
X-Received: by 2002:a05:6000:168f:: with SMTP id y15mr1565611wrd.365.1643261214157;
        Wed, 26 Jan 2022 21:26:54 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id z5sm6017661wmp.10.2022.01.26.21.26.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jan 2022 21:26:53 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Josh Steadmon <steadmon@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v8 0/7] object-name: make ambiguous object output translatable + show tag date
Date:   Thu, 27 Jan 2022 06:26:42 +0100
Message-Id: <cover-v8-0.7-00000000000-20220127T052116Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.0.890.gd7e422415d9
In-Reply-To: <cover-v7-0.6-00000000000-20220111T130811Z-avarab@gmail.com>
References: <cover-v7-0.6-00000000000-20220111T130811Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This topic improves the output we emit on ambiguous objects as noted
in 5/7, and makes it translatable, see 4/7. See [1] for v7.

This v8 addresses feedback from Junio. There's a small test change +
commit message change in 1/7, and a rather small change in adding an
explicit message in 5/7 for tags that we cannot parse.

The range-diff looks rather scary though because if we're going to add
such output it made sense to add it in a new 3/7, before we made the
output translatable, and then to carry that change forward.

1. https://lore.kernel.org/git/cover-v7-0.6-00000000000-20220111T130811Z-avarab@gmail.com/

Ævar Arnfjörð Bjarmason (7):
  object-name tests: add tests for ambiguous object blind spots
  object-name: explicitly handle OBJ_BAD in show_ambiguous_object()
  object-name: explicitly handle bad tags in show_ambiguous_object()
  object-name: make ambiguous object output translatable
  object-name: show date for ambiguous tag objects
  object-name: iterate ambiguous objects before showing header
  object-name: re-use "struct strbuf" in show_ambiguous_object()

 object-name.c                       | 121 +++++++++++++++++++++++++---
 t/t1512-rev-parse-disambiguation.sh |  81 +++++++++++++++++++
 2 files changed, 190 insertions(+), 12 deletions(-)

Range-diff against v7:
1:  28c01b7f8a5 ! 1:  756c94bda7a object-name tests: add tests for ambiguous object blind spots
    @@ Commit message
         and because a subsequent commit will tweak it. Showing a diff of how
         the output changes is helpful to explain those subsequent commits.
     
    +    The "sed" invocation in test_cmp_failed_rev_parse() doesn't need a
    +    "/g" because under both SHA-1 and SHA-256 we'll wildcard match any
    +    trailing part of the OID after our known starting prefix. We'd like to
    +    convert all of that to just "..." for the "test_cmp" which follows.
    +
         1. https://lore.kernel.org/git/YZwbphPpfGk78w2f@coredump.intra.peff.net/
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
    @@ t/t1512-rev-parse-disambiguation.sh: export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
      . ./test-lib.sh
      
     +test_cmp_failed_rev_parse () {
    ++	dir=$1
    ++	rev=$2
    ++
     +	cat >expect &&
    -+	test_must_fail git -C "$1" rev-parse "$2" 2>actual.raw &&
    -+	sed "s/\($2\)[0-9a-f]*/\1.../" <actual.raw >actual &&
    ++	test_must_fail git -C "$dir" rev-parse "$rev" 2>actual.raw &&
    ++	sed "s/\($rev\)[0-9a-f]*/\1.../" <actual.raw >actual &&
     +	test_cmp expect actual
     +}
     +
2:  b7027dfc843 = 2:  e60f100003a object-name: explicitly handle OBJ_BAD in show_ambiguous_object()
4:  2e5511c9fa5 ! 3:  eaede34fa4f object-name: show date for ambiguous tag objects
    @@ Metadata
     Author: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## Commit message ##
    -    object-name: show date for ambiguous tag objects
    +    object-name: explicitly handle bad tags in show_ambiguous_object()
     
    -    Make the ambiguous tag object output nicer in the case of tag objects
    -    such as ebf3c04b262 (Git 2.32, 2021-06-06) by including the date in
    -    the "tagger" header. I.e.:
    +    Follow-up the handling of OBJ_BAD in the preceding commit and
    +    explicitly handle those cases where parse_tag() fails, or we don't end
    +    up with a non-NULL pointer in in tag->tag.
     
    -        $ git rev-parse b7e68
    -        error: short object ID b7e68 is ambiguous
    -        hint: The candidates are:
    -        hint:   b7e68c41d92 tag 2021-06-06 - v2.32.0
    -        hint:   b7e68ae18e0 commit 2019-12-23 - bisect: use the standard 'if (!var)' way to check for 0
    -        hint:   b7e68f6b413 tree
    -        hint:   b7e68490b97 blob
    -        b7e68
    -        [...]
    +    If we run into such a tag we'd previously be silent about it. We
    +    really should also be handling these batter in parse_tag_buffer() by
    +    being more eager to emit an error(), instead of silently aborting with
    +    "return -1;".
     
    -    Before this we'd emit a "tag" line of:
    +    One example of such a tag is the one that's tested for in
    +    "t3800-mktag.sh", where the code takes the "size <
    +    the_hash_algo->hexsz + 24" branch.
     
    -        hint:   b7e68c41d92 tag v2.32.0
    +    But in lieu of earlier missing "error" output let's show the user
    +    something to indicate why we're not showing a tag message in these
    +    cases, now instead of showing:
     
    -    As with OBJ_COMMIT we punt on the cases where the date in the object
    -    is nonsensical, and other cases where parse_tag() might fail. For
    -    those we'll use our default date of "0" and tag message of
    -    "". E.g. for some of the corrupt tags created by t3800-mktag.sh we'd
    -    emit a line like:
    +        hint:   deadbeef tag
     
    -        hint:   8d62cb0b06 tag 1970-01-01 -
    +    We'll instead display:
     
    -    We could detect that and emit a "%s [bad tag object]" message (to go
    -    with the existing generic "%s [bad object]"), but I don't think it's
    -    worth the effort. Users are unlikely to ever run into cases where
    -    they've got a broken object that's also ambiguous, and in case they do
    -    output that's a bit nonsensical beats wasting translator time on this
    -    obscure edge case.
    -
    -    We should instead change parse_tag_buffer() to be more eager to emit
    -    an error() instead of silently aborting with "return -1;". In the case
    -    of "t3800-mktag.sh" it takes the "size < the_hash_algo->hexsz + 24"
    -    branch.
    +        hint:   deadbeef tag [tag could not be parsed]
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## object-name.c ##
     @@ object-name.c: static int show_ambiguous_object(const struct object_id *oid, void *data)
    - 	} else if (type == OBJ_TAG) {
      		struct tag *tag = lookup_tag(ds->repo, oid);
    - 		const char *tag_tag = "";
    -+		timestamp_t tag_date = 0;
    - 
    --		if (!parse_tag(tag) && tag->tag)
    -+		if (!parse_tag(tag) && tag->tag) {
    - 			tag_tag = tag->tag;
    -+			tag_date = tag->date;
    -+		}
    + 		if (!parse_tag(tag) && tag->tag)
    + 			strbuf_addf(&desc, " %s", tag->tag);
    ++		else
    ++			strbuf_addstr(&desc, " [tag could not be parsed]");
    + 	}
      
    - 		/*
    - 		 * TRANSLATORS: This is a line of
    - 		 * ambiguous tag object output. E.g.:
    - 		 *
    --		 *    "deadbeef tag Some Tag Message"
    -+		 *    "deadbeef tag 2021-01-01 - Some Tag Message"
    - 		 *
    - 		 * The second argument is the "tag" string from
    - 		 * object.c.
    - 		 */
    --		strbuf_addf(&desc, _("%s tag %s"), hash, tag_tag);
    -+		strbuf_addf(&desc, _("%s tag %s - %s"), hash,
    -+			    show_date(tag_date, 0, DATE_MODE(SHORT)),
    -+			    tag_tag);
    - 	} else if (type == OBJ_TREE) {
    - 		/*
    - 		 * TRANSLATORS: This is a line of ambiguous <type>
    + out:
3:  65801f2c890 ! 4:  6a26c917a94 object-name: make ambiguous object output translatable
    @@ Commit message
         for RTL languages, who'd presumably like to change that to
         "%s<SP><SP>\n".
     
    +    In the case of the existing "tag [tag could not be parsed]" output
    +    we'll now instead emit "[bad tag, could not parse it]". This is
    +    consistent with the "[bad object]" output. Rephrasing the message like
    +    this is possible because we're not unconditionally adding the
    +    type_name() at the beginning.
    +
         1. 1ffa26c461 (get_short_sha1: list ambiguous objects on error,
            2016-09-26)
         2. 5cc044e0257 (get_short_oid: sort ambiguous objects by type,
    @@ object-name.c: static int show_ambiguous_object(const struct object_id *oid, voi
     +		strbuf_release(&msg);
      	} else if (type == OBJ_TAG) {
      		struct tag *tag = lookup_tag(ds->repo, oid);
    -+		const char *tag_tag = "";
    -+
    - 		if (!parse_tag(tag) && tag->tag)
    +-		if (!parse_tag(tag) && tag->tag)
     -			strbuf_addf(&desc, " %s", tag->tag);
    -+			tag_tag = tag->tag;
    +-		else
    +-			strbuf_addstr(&desc, " [tag could not be parsed]");
     +
    -+		/*
    -+		 * TRANSLATORS: This is a line of
    -+		 * ambiguous tag object output. E.g.:
    -+		 *
    -+		 *    "deadbeef tag Some Tag Message"
    -+		 *
    -+		 * The second argument is the "tag" string from
    -+		 * object.c.
    -+		 */
    -+		strbuf_addf(&desc, _("%s tag %s"), hash, tag_tag);
    ++		if (!parse_tag(tag) && tag->tag) {
    ++			/*
    ++			 * TRANSLATORS: This is a line of ambiguous
    ++			 * tag object output. E.g.:
    ++			 *
    ++			 *    "deadbeef tag Some Tag Message"
    ++			 *
    ++			 * The second argument is the "tag" string
    ++			 * from object.c.
    ++			 */
    ++			strbuf_addf(&desc, _("%s tag %s"), hash, tag->tag);
    ++		} else {
    ++			/*
    ++			 * TRANSLATORS: This is a line of ambiguous
    ++			 * tag object output where we couldn't parse
    ++			 * the tag itself. E.g.:
    ++			 *
    ++			 *    "deadbeef tag [bad tag, could not parse it]"
    ++			 */
    ++			strbuf_addf(&desc, _("%s [bad tag, could not parse it]"),
    ++				    hash);
    ++		}
     +	} else if (type == OBJ_TREE) {
     +		/*
     +		 * TRANSLATORS: This is a line of ambiguous <type>
-:  ----------- > 5:  6237f07e3a9 object-name: show date for ambiguous tag objects
5:  2c03cdd3c1e = 6:  57336c67dd2 object-name: iterate ambiguous objects before showing header
6:  bf226f67099 ! 7:  1f0e1053918 object-name: re-use "struct strbuf" in show_ambiguous_object()
    @@ object-name.c: static int show_ambiguous_object(const struct object_id *oid, voi
      		strbuf_release(&date);
      		strbuf_release(&msg);
     @@ object-name.c: static int show_ambiguous_object(const struct object_id *oid, void *data)
    - 		 * The second argument is the "tag" string from
    - 		 * object.c.
    - 		 */
    --		strbuf_addf(&desc, _("%s tag %s - %s"), hash,
    -+		strbuf_addf(sb, _("%s tag %s - %s"), hash,
    - 			    show_date(tag_date, 0, DATE_MODE(SHORT)),
    - 			    tag_tag);
    + 			 * The third argument is the "tag" string
    + 			 * from object.c.
    + 			 */
    +-			strbuf_addf(&desc, _("%s tag %s - %s"), hash,
    ++			strbuf_addf(sb, _("%s tag %s - %s"), hash,
    + 				    show_date(tag->date, 0, DATE_MODE(SHORT)),
    + 				    tag->tag);
    + 		} else {
    +@@ object-name.c: static int show_ambiguous_object(const struct object_id *oid, void *data)
    + 			 *
    + 			 *    "deadbeef [bad tag, could not parse it]"
    + 			 */
    +-			strbuf_addf(&desc, _("%s [bad tag, could not parse it]"),
    ++			strbuf_addf(sb, _("%s [bad tag, could not parse it]"),
    + 				    hash);
    + 		}
      	} else if (type == OBJ_TREE) {
     @@ object-name.c: static int show_ambiguous_object(const struct object_id *oid, void *data)
      		 * TRANSLATORS: This is a line of ambiguous <type>
-- 
2.35.0.890.gd7e422415d9

