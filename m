Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59F0DC433F5
	for <git@archiver.kernel.org>; Mon,  4 Oct 2021 14:27:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A9CF61354
	for <git@archiver.kernel.org>; Mon,  4 Oct 2021 14:27:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233789AbhJDO24 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 Oct 2021 10:28:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233705AbhJDO2z (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Oct 2021 10:28:55 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48139C061745
        for <git@vger.kernel.org>; Mon,  4 Oct 2021 07:27:06 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id p21so3889293wmq.1
        for <git@vger.kernel.org>; Mon, 04 Oct 2021 07:27:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0eQ8OGoZA51lQ//no172XmqvAHDIxKe5C8VpufenF3w=;
        b=ai3zBpukAFN+5dly4lHJeGfX2R5chSiEZFKYEUJH6ix9rpraPh1VklMjigwNyMHDP9
         3/IEX5OUa3CZA+hifYSX/s08Wc4fYUyUoc/+LebU605ObVfMqrCLPjyafemOu90xzKtb
         X3zFQObC1lez/2+uEowDtV8KWzNl+mkxT2g2aeMARcOrjeti4OnAEM5iiOVVWMGfFlYQ
         FZIXh+JbCCRwfWN2pecwgBNrm6zmgc54aL0QeKXfXvWausha3yKGVm6+iYGGZ9Np0JNn
         jnw7vaMMFFLEZxuahwcqMXVsZLBDuyWdXLzbVy1zTvntKpV2UdhoOOomjWUfLcVMqRSH
         GMMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0eQ8OGoZA51lQ//no172XmqvAHDIxKe5C8VpufenF3w=;
        b=hTwGg8Ut2BvS2gGVbQt+m6iIvPCl5beedMkAyZE2a2EWsESlrJIcHetuF4MQFEsvrj
         zbCPxDxyZRoHqC7mJEuTnG8jJC55IJVJbY6LOLh+fCSkfvXiY1a68fph0ooMHSOK0Oey
         xiHOfy3lCFP3FUwtr779NSrGPnLGcTcx8Bismrn009i5qSNSmM/rF0fX2Cc+Kfr5UZ/+
         1OSZHLvaj2PmtSGnPWCYY03F71OYEYQbNlHHR6leBe1eNreOuI5U+4djiQ8O6HPz8Rct
         crseXU+8P6BXygh2sibLBMxcqDXGco6a3u+MX0sYP0gUjklYXPzdu8e/ABoYMMoZw99R
         iHRA==
X-Gm-Message-State: AOAM532G4e05Y23heEtJ7PZJChFHj5cZfl06D3fny1/VKvzue2zJP/eD
        LmZlZhk6KLr0wmVA4/ff3I7f9b7e7hS8Cg==
X-Google-Smtp-Source: ABdhPJzEVnzBUkbATHU2GWFyddRBCO99ZkfghEXsIJnJZZSUedSc9Me7iMiAtx/V3RB3gbEJY8hl4g==
X-Received: by 2002:a05:600c:3543:: with SMTP id i3mr18630488wmq.64.1633357624121;
        Mon, 04 Oct 2021 07:27:04 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id f9sm17368315wmf.3.2021.10.04.07.27.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Oct 2021 07:27:03 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 0/2] i18n: improve translatability of ambiguous object output
Date:   Mon,  4 Oct 2021 16:27:00 +0200
Message-Id: <cover-v2-0.2-00000000000-20211004T142523Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1409.ge73c1ecc5b4
In-Reply-To: <cover-0.2-00000000000-20211004T013611Z-avarab@gmail.com>
References: <cover-0.2-00000000000-20211004T013611Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A mostly-rewritten version in response to the discussion concluding at
http://lore.kernel.org/git/YVrudGOcUxblsfPY@coredump.intra.peff.net;
thanks a lot for the thorough review Jeff!

Ævar Arnfjörð Bjarmason (2):
  object.[ch]: mark object type names for translation
  object-name: make ambiguous object output translatable

 object-name.c | 72 ++++++++++++++++++++++++++++++++++++++++++++++-----
 object.c      | 27 ++++++++++++++++---
 object.h      |  1 +
 3 files changed, 90 insertions(+), 10 deletions(-)

Range-diff against v1:
1:  7085f951a12 ! 1:  55bde16aa23 object-name tests: tighten up advise() output test
    @@ Metadata
     Author: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## Commit message ##
    -    object-name tests: tighten up advise() output test
    +    object.[ch]: mark object type names for translation
     
    -    Change tests added in 1ffa26c4614 (get_short_sha1: list ambiguous
    -    objects on error, 2016-09-26) to only care about the OIDs that are
    -    listed, which is what the test is trying to check for.
    +    Mark the "commit", "tree", "blob" and "tag" types for translation, and
    +    add an extern "unknown type" string for the OBJ_NONE case.
     
    -    This isn't needed by the subsequent commit, which won't change any of
    -    the output, but a mere tightening of the tests assertions to more
    -    closely match what we really want to test for here.
    +    It is usually bad practice to translate individual words like this,
    +    but for e.g. the list list output emitted by the "short object ID dead
    +    is ambiguous" advice it makes sense.
     
    -    Now if the advise() message itself were change the phrasing around the
    -    list of OIDs we won't have this test break. We're assuming that such
    -    output won't have a need to indent anything except the OIDs.
    +    A subsequent commit will make that output translatable, and use these
    +    translation markings to do so. Well, we won't use "commit", but let's
    +    mark it up anyway for consistency. It'll probably come in handy sooner
    +    than later to have it already be translated, and it's to much of a
    +    burden to place on translators if they're translating the other three
    +    object types anyway.
    +
    +    Aside: I think it would probably make sense to change the "NULL" entry
    +    for type_name() to be the "unknown type". I've ran into cases where
    +    type_name() was unconditionally interpolated in e.g. an sprintf()
    +    format, but let's leave that for #leftoverbits as that would be
    +    changing the behavior of the type_name() function.
    +
    +    All of these will be new in the git.pot file, except "blob" which will
    +    be shared with a "cat-file" command-line option, see
    +    7bcf3414535 (cat-file --textconv/--filters: allow specifying the path
    +    separately, 2016-09-09) for its introduction.
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
    - ## t/t1512-rev-parse-disambiguation.sh ##
    -@@ t/t1512-rev-parse-disambiguation.sh: test_expect_success 'ambiguity errors are not repeated (peel)' '
    + ## object.c ##
    +@@ object.c: struct object *get_indexed_object(unsigned int idx)
      
    - test_expect_success 'ambiguity hints' '
    - 	test_must_fail git rev-parse 000000000 2>stderr &&
    --	grep ^hint: stderr >hints &&
    --	# 16 candidates, plus one intro line
    --	test_line_count = 17 hints
    -+	grep "^hint:   " stderr >hints &&
    -+	# 16 candidates, minus surrounding prose
    -+	test_line_count = 16 hints
    - '
    + static const char *object_type_strings[] = {
    + 	NULL,		/* OBJ_NONE = 0 */
    +-	"commit",	/* OBJ_COMMIT = 1 */
    +-	"tree",		/* OBJ_TREE = 2 */
    +-	"blob",		/* OBJ_BLOB = 3 */
    +-	"tag",		/* OBJ_TAG = 4 */
    ++	/*
    ++	 * TRANSLATORS: "commit", "tree", "blob" and "tag" are the
    ++	 * name of Git's object types. These names are interpolated
    ++	 * stand-alone when doing so is unambiguous for translation
    ++	 * and doesn't require extra context. E.g. as part of an
    ++	 * already-translated string that needs to have a type name
    ++	 * quoted verbatim, or the short description of a command-line
    ++	 * option expecting a given type.
    ++	 */
    ++	N_("commit"),	/* OBJ_COMMIT = 1 */
    ++	N_("tree"),	/* OBJ_TREE = 2 */
    ++	N_("blob"),	/* OBJ_BLOB = 3 */
    ++	N_("tag"),	/* OBJ_TAG = 4 */
    + };
      
    - test_expect_success 'ambiguity hints respect type' '
    - 	test_must_fail git rev-parse 000000000^{commit} 2>stderr &&
    --	grep ^hint: stderr >hints &&
    --	# 5 commits, 1 tag (which is a committish), plus intro line
    --	test_line_count = 7 hints
    -+	grep "^hint:   " stderr >hints &&
    -+	# 5 commits, 1 tag (which is a committish), minus surrounding prose
    -+	test_line_count = 6 hints
    - '
    - 
    - test_expect_success 'failed type-selector still shows hint' '
    -@@ t/t1512-rev-parse-disambiguation.sh: test_expect_success 'failed type-selector still shows hint' '
    - 	echo 851 | git hash-object --stdin -w &&
    - 	echo 872 | git hash-object --stdin -w &&
    - 	test_must_fail git rev-parse ee3d^{commit} 2>stderr &&
    --	grep ^hint: stderr >hints &&
    --	test_line_count = 3 hints
    -+	grep "^hint:   " stderr >hints &&
    -+	test_line_count = 2 hints
    - '
    ++/*
    ++ * TRANSLATORS: This is the short type name of an object that's not
    ++ * one of Git's known object types, as opposed to "commit", "tree",
    ++ * "blob" and "tag" above.
    ++ *
    ++ * A user is unlikely to ever encounter these, but they can be
    ++ * manually created with "git hash-object --literally".
    ++ */
    ++const char *unknown_type = N_("unknown type");
    ++
    + const char *type_name(unsigned int type)
    + {
    + 	if (type >= ARRAY_SIZE(object_type_strings))
    +
    + ## object.h ##
    +@@ object.h: struct object {
    + 	struct object_id oid;
    + };
      
    - test_expect_success 'core.disambiguate config can prefer types' '
    ++extern const char *unknown_type;
    + const char *type_name(unsigned int type);
    + int type_from_string_gently(const char *str, ssize_t, int gentle);
    + #define type_from_string(str) type_from_string_gently(str, -1, 0)
2:  b6136380c28 ! 2:  c0e873543f5 object-name: make ambiguous object output translatable
    @@ Commit message
         tweaked in [2] to be more friendly to translators. By being able to
         customize the sprintf formats we're even ready for RTL languages.
     
    -    1. ef9b0370da6 (sha1-name.c: store and use repo in struct
    -       disambiguate_state, 2019-04-16)
    +    The "unknown type" message here is unreachable, and has been since
    +    [1], i.e. that code has never worked. If we craft an object of a bogus
    +    type with a conflicting prefix we'll just die:
    +
    +        $ git rev-parse 8315
    +        error: short object ID 8315 is ambiguous
    +        hint: The candidates are:
    +        fatal: invalid object type
    +
    +    But let's continue to pretend that this works, we can eventually use
    +    the API improvements in my ab/fsck-unexpected-type (once it lands) to
    +    inspect these objects and emit the actual type here, or at least not
    +    die as we emit "unknown type".
    +
    +    1. 1ffa26c461 (get_short_sha1: list ambiguous objects on error,
    +       2016-09-26)
         2. 5cc044e0257 (get_short_oid: sort ambiguous objects by type,
            then SHA-1, 2018-05-10)
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## object-name.c ##
    -@@ object-name.c: static int init_object_disambiguation(struct repository *r,
    - 	return 0;
    - }
    - 
    -+struct show_ambiguous_state {
    -+	const struct disambiguate_state *ds;
    -+	struct strbuf *advice;
    -+};
    -+
    - static int show_ambiguous_object(const struct object_id *oid, void *data)
    +@@ object-name.c: static int show_ambiguous_object(const struct object_id *oid, void *data)
      {
    --	const struct disambiguate_state *ds = data;
    -+	struct show_ambiguous_state *state = data;
    -+	const struct disambiguate_state *ds = state->ds;
    -+	struct strbuf *advice = state->advice;
    + 	const struct disambiguate_state *ds = data;
      	struct strbuf desc = STRBUF_INIT;
    ++	struct strbuf ci_ad = STRBUF_INIT;
    ++	struct strbuf ci_s = STRBUF_INIT;
      	int type;
    ++	const char *tag_desc = NULL;
    ++	const char *abbrev;
      
    + 	if (ds->fn && !ds->fn(ds->repo, oid, ds->cb_data))
    + 		return 0;
     @@ object-name.c: static int show_ambiguous_object(const struct object_id *oid, void *data)
      		if (commit) {
      			struct pretty_print_context pp = {0};
      			pp.date_mode.type = DATE_SHORT;
     -			format_commit_message(commit, " %ad - %s", &desc, &pp);
    -+			format_commit_message(commit, _(" %ad - %s"), &desc, &pp);
    ++			format_commit_message(commit, "%ad", &ci_ad, &pp);
    ++			format_commit_message(commit, "%s", &ci_s, &pp);
      		}
      	} else if (type == OBJ_TAG) {
      		struct tag *tag = lookup_tag(ds->repo, oid);
      		if (!parse_tag(tag) && tag->tag)
     -			strbuf_addf(&desc, " %s", tag->tag);
    -+			strbuf_addf(&desc, _(" %s"), tag->tag);
    ++			tag_desc = tag->tag;
      	}
      
     -	advise("  %s %s%s",
     -	       repo_find_unique_abbrev(ds->repo, oid, DEFAULT_ABBREV),
     -	       type_name(type) ? type_name(type) : "unknown type",
     -	       desc.buf);
    -+	strbuf_addf(advice,
    -+		    /*
    -+		     * TRANSLATORS: This is a line of ambiguous object
    -+		     * output. E.g.:
    -+		     *
    -+		     *    "deadbeef commit 2021-01-01 - Some Commit Message\n"
    -+		     *    "deadbeef tag Some Tag Message\n"
    -+		     *    "deadbeef tree\n"
    -+		     *
    -+		     * I.e. the first argument is a short OID, the
    -+		     * second is the type name of the object, and the
    -+		     * third a description of the object, if it's a
    -+		     * commit or tag. In that case the " %ad - %s" and
    -+		     * " %s" formats above will be used for the third
    -+		     * argument.
    -+		     */
    -+		    _("  %s %s%s\n"),
    -+		    repo_find_unique_abbrev(ds->repo, oid, DEFAULT_ABBREV),
    -+		    type_name(type) ? type_name(type) : "unknown type",
    -+		    desc.buf);
    - 
    - 	strbuf_release(&desc);
    - 	return 0;
    -@@ object-name.c: static enum get_oid_result get_short_oid(struct repository *r,
    - 	}
    - 
    - 	if (!quietly && (status == SHORT_NAME_AMBIGUOUS)) {
    -+		struct strbuf sb = STRBUF_INIT;
    - 		struct oid_array collect = OID_ARRAY_INIT;
    -+		struct show_ambiguous_state as = {
    -+			.ds = &ds,
    -+			.advice = &sb,
    -+		};
    - 
    - 		error(_("short object ID %s is ambiguous"), ds.hex_pfx);
    - 
    -@@ object-name.c: static enum get_oid_result get_short_oid(struct repository *r,
    - 		if (!ds.ambiguous)
    - 			ds.fn = NULL;
    - 
    --		advise(_("The candidates are:"));
    - 		repo_for_each_abbrev(r, ds.hex_pfx, collect_ambiguous, &collect);
    - 		sort_ambiguous_oid_array(r, &collect);
    - 
    --		if (oid_array_for_each(&collect, show_ambiguous_object, &ds))
    -+		if (oid_array_for_each(&collect, show_ambiguous_object, &as))
    - 			BUG("show_ambiguous_object shouldn't return non-zero");
    -+
    ++	abbrev = repo_find_unique_abbrev(ds->repo, oid, DEFAULT_ABBREV);
    ++	if (type == OBJ_COMMIT) {
     +		/*
    -+		 * TRANSLATORS: The argument is the list of ambiguous
    -+		 * objects composed in show_ambiguous_object(). See
    -+		 * its "TRANSLATORS" comment for details.
    ++		 * TRANSLATORS: This is a line of ambiguous commit
    ++		 * object output. E.g.:
    ++		 *
    ++		 *    "deadbeef commit 2021-01-01 - Some Commit Message"
    ++		 *
    ++		 * The second argument is the "commit" string from
    ++		 * object.c, it should (hopefully) already be
    ++		 * translated.
     +		 */
    -+		advise(_("The candidates are:\n\n%s"), sb.buf);
    ++		strbuf_addf(&desc, _("%s %s %s - %s"), abbrev, ci_ad.buf,
    ++			    _(type_name(type)), ci_s.buf);
    ++	} else if (tag_desc) {
    ++		/*
    ++		 * TRANSLATORS: This is a line of
    ++		 * ambiguous tag object output. E.g.:
    ++		 *
    ++		 *    "deadbeef tag Some Tag Message"
    ++		 *
    ++		 * The second argument is the "tag" string from
    ++		 * object.c, it should (hopefully) already be
    ++		 * translated.
    ++		 */
    ++		strbuf_addf(&desc, _("%s %s %s"), abbrev, _(type_name(type)),
    ++			    tag_desc);
    ++	} else {
    ++		const char *tname = type_name(type) ? _(type_name(type)) :
    ++			_(unknown_type);
    ++		/*
    ++		 * TRANSLATORS: This is a line of ambiguous <type>
    ++		 * object output. Where <type> is one of the object
    ++		 * types of "tree", "blob", "tag" ("commit" is handled
    ++		 * above).
    ++		 *
    ++		 *    "deadbeef tree"
    ++		 *    "deadbeef blob"
    ++		 *    "deadbeef tag"
    ++		 *    "deadbeef unknown type"
    ++		 *
    ++		 * Note that annotated tags use a separate format
    ++		 * outlined above.
    ++		 *
    ++		 * The second argument is the "tree", "blob" or "tag"
    ++		 * string from object.c, or the "unknown type" string
    ++		 * in the case of an unknown type. All of them should
    ++		 * (hopefully) already be translated.
    ++		 */
    ++		strbuf_addf(&desc, _("%s %s"), abbrev, tname);
    ++	}
     +
    - 		oid_array_clear(&collect);
    - 	}
    ++	/*
    ++	 * TRANSLATORS: This is line item of ambiguous object output,
    ++	 * translated above.
    ++	 */
    ++	advise(_("  %s\n"), desc.buf);
    + 
    + 	strbuf_release(&desc);
    ++	strbuf_release(&ci_ad);
    ++	strbuf_release(&ci_s);
    + 	return 0;
    + }
      
-- 
2.33.0.1409.ge73c1ecc5b4

