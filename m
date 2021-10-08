Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25367C433F5
	for <git@archiver.kernel.org>; Fri,  8 Oct 2021 19:34:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F386760FF2
	for <git@archiver.kernel.org>; Fri,  8 Oct 2021 19:34:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231480AbhJHTgv (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Oct 2021 15:36:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231316AbhJHTgv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Oct 2021 15:36:51 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 445ADC061570
        for <git@vger.kernel.org>; Fri,  8 Oct 2021 12:34:55 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id v17so32803242wrv.9
        for <git@vger.kernel.org>; Fri, 08 Oct 2021 12:34:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=j2xw+L+Wgn6yNVt0KBhb22YvbBVytVuLHY/XkGLCgYk=;
        b=az0MGf9wQt7vb2JDa7QL2SVKlpbeBuUvLQLC+jVBe48C5RpHgs/6tCirQcT3sZX4D5
         sFZkBHvt3akQkY1ghUc95R1OxuDVq3/67zEpvF6pRsdIDyCCwMAp33Op055UFNKE8Ghd
         HfMG56USsQ+/QfnHjaO5mpFAYVuuNVsgirYxRd7IE7AWT/rUuHBLa/Md6C+O8+BaXHzZ
         qCKesQuxITYZ23LzAHEV50To8DFu4EqRUc+AqsVnWdOv7IObHSpUCU73JbYbFpJU0cvM
         YRjvRB1Iibeh5UIPgCMcVl1MI7N0s7Zoh2LcolY0CPiyPSdZz8FlBGwG7GutE09XL894
         8SxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=j2xw+L+Wgn6yNVt0KBhb22YvbBVytVuLHY/XkGLCgYk=;
        b=MRwXVxBpEsHAni6ZT63qdBt218MEDaeCECNr5uNOUD+WXRlFjij0DcnBpfN/RUUJ5n
         2iJXhiYJxGNc2avAFDgExx8UcjxcfdS634RRs3vcMzxdeL4E4RaMw2s4wc9IjRvfH80O
         EBFZ2Zseqw5KBa181Jjo1hV8ilxLBy0wEwkymKNPk3zLmVgG3I2BL8e5jp0+lEgSiSCz
         l76B0knRg5YBV32kGlU32wXG/bSeb0kV4obA6W1YmJe7z/ko724Q8cUT51iVqePMW13w
         +ClLlCULm9kH5inQGHVDQBBRJSRzMSNu72ubKFZw9bUyPWJhYZ7dNukV+2mvzB3NLkaZ
         k5Hg==
X-Gm-Message-State: AOAM533rnZlaTGwq6agNyR4pSCIaXxnq9hk2MvqZLIP1WG8aG2JlgnyH
        4Fxaw9wOWbsowAG8LBjwpn8un8LcnQ/rHA==
X-Google-Smtp-Source: ABdhPJwFbk3scr4mJ69FK/99L7sXZYju18ENGXD4bpn5iPstcoKJHEDZR8mB+fYIewXHdrCL9Fnl7g==
X-Received: by 2002:a7b:c351:: with SMTP id l17mr5531630wmj.120.1633721693598;
        Fri, 08 Oct 2021 12:34:53 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c204sm13056157wme.11.2021.10.08.12.34.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Oct 2021 12:34:53 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 0/3] i18n: improve translatability of ambiguous object output
Date:   Fri,  8 Oct 2021 21:34:45 +0200
Message-Id: <cover-v3-0.3-00000000000-20211008T193041Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1492.g76eb1af92bc
In-Reply-To: <cover-v2-0.2-00000000000-20211004T142523Z-avarab@gmail.com>
References: <cover-v2-0.2-00000000000-20211004T142523Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since v2 the "commit", "tag" etc. types in object.c are no longer
marked for translation.

There's a new 1/3 where we lead with an assert() and commit message
showing that the existing "unknown type" code is gone, which makes
what comes after simpler.

In 2/3 we no longer have to deal with special-cases related to corrupt
or otherwise bad objects, which makes for less work for translators.

In 3/3 I added the tag date to ambiguous tag objects, which is now
consistent with how commit objects are shown.

Ævar Arnfjörð Bjarmason (3):
  object-name: remove unreachable "unknown type" handling
  object-name: make ambiguous object output translatable
  object-name: show date for ambiguous tag objects

 object-name.c | 68 +++++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 61 insertions(+), 7 deletions(-)

Range-diff against v2:
1:  55bde16aa23 < -:  ----------- object.[ch]: mark object type names for translation
-:  ----------- > 1:  fb29e10ee35 object-name: remove unreachable "unknown type" handling
2:  c0e873543f5 ! 2:  587a5717e47 object-name: make ambiguous object output translatable
    @@ Commit message
         object-name: make ambiguous object output translatable
     
         Change the output of show_ambiguous_object() added in [1] and last
    -    tweaked in [2] to be more friendly to translators. By being able to
    -    customize the sprintf formats we're even ready for RTL languages.
    -
    -    The "unknown type" message here is unreachable, and has been since
    -    [1], i.e. that code has never worked. If we craft an object of a bogus
    -    type with a conflicting prefix we'll just die:
    -
    -        $ git rev-parse 8315
    -        error: short object ID 8315 is ambiguous
    -        hint: The candidates are:
    -        fatal: invalid object type
    -
    -    But let's continue to pretend that this works, we can eventually use
    -    the API improvements in my ab/fsck-unexpected-type (once it lands) to
    -    inspect these objects and emit the actual type here, or at least not
    -    die as we emit "unknown type".
    +    tweaked in [2] and the preceding commit to be more friendly to
    +    translators. By being able to customize the "<SP><SP>%s\n" format
    +    we're even ready for RTL languages, who'd presumably like to change
    +    that to "%s<SP><SP>\n".
     
         1. 1ffa26c461 (get_short_sha1: list ambiguous objects on error,
            2016-09-26)
    @@ Commit message
     
      ## object-name.c ##
     @@ object-name.c: static int show_ambiguous_object(const struct object_id *oid, void *data)
    - {
      	const struct disambiguate_state *ds = data;
      	struct strbuf desc = STRBUF_INIT;
    -+	struct strbuf ci_ad = STRBUF_INIT;
    -+	struct strbuf ci_s = STRBUF_INIT;
      	int type;
    -+	const char *tag_desc = NULL;
    -+	const char *abbrev;
    ++	const char *hash;
      
      	if (ds->fn && !ds->fn(ds->repo, oid, ds->cb_data))
      		return 0;
     @@ object-name.c: static int show_ambiguous_object(const struct object_id *oid, void *data)
    + 	type = oid_object_info(ds->repo, oid, NULL);
    + 	assert(type == OBJ_TREE || type == OBJ_COMMIT ||
    + 	       type == OBJ_BLOB || type == OBJ_TAG);
    ++	hash = repo_find_unique_abbrev(ds->repo, oid, DEFAULT_ABBREV);
    ++
    + 	if (type == OBJ_COMMIT) {
    ++		struct strbuf ad = STRBUF_INIT;
    ++		struct strbuf s = STRBUF_INIT;
    + 		struct commit *commit = lookup_commit(ds->repo, oid);
    ++
      		if (commit) {
      			struct pretty_print_context pp = {0};
      			pp.date_mode.type = DATE_SHORT;
     -			format_commit_message(commit, " %ad - %s", &desc, &pp);
    -+			format_commit_message(commit, "%ad", &ci_ad, &pp);
    -+			format_commit_message(commit, "%s", &ci_s, &pp);
    ++			format_commit_message(commit, "%ad", &ad, &pp);
    ++			format_commit_message(commit, "%s", &s, &pp);
      		}
    - 	} else if (type == OBJ_TAG) {
    - 		struct tag *tag = lookup_tag(ds->repo, oid);
    - 		if (!parse_tag(tag) && tag->tag)
    --			strbuf_addf(&desc, " %s", tag->tag);
    -+			tag_desc = tag->tag;
    - 	}
    - 
    --	advise("  %s %s%s",
    --	       repo_find_unique_abbrev(ds->repo, oid, DEFAULT_ABBREV),
    --	       type_name(type) ? type_name(type) : "unknown type",
    --	       desc.buf);
    -+	abbrev = repo_find_unique_abbrev(ds->repo, oid, DEFAULT_ABBREV);
    -+	if (type == OBJ_COMMIT) {
    ++
     +		/*
     +		 * TRANSLATORS: This is a line of ambiguous commit
     +		 * object output. E.g.:
     +		 *
     +		 *    "deadbeef commit 2021-01-01 - Some Commit Message"
    -+		 *
    -+		 * The second argument is the "commit" string from
    -+		 * object.c, it should (hopefully) already be
    -+		 * translated.
     +		 */
    -+		strbuf_addf(&desc, _("%s %s %s - %s"), abbrev, ci_ad.buf,
    -+			    _(type_name(type)), ci_s.buf);
    -+	} else if (tag_desc) {
    ++		strbuf_addf(&desc, _("%s commit %s - %s"), hash, ad.buf, s.buf);
    ++
    ++		strbuf_release(&ad);
    ++		strbuf_release(&s);
    + 	} else if (type == OBJ_TAG) {
    + 		struct tag *tag = lookup_tag(ds->repo, oid);
    ++		const char *tag_tag = "";
    ++
    + 		if (!parse_tag(tag) && tag->tag)
    +-			strbuf_addf(&desc, " %s", tag->tag);
    ++			tag_tag = tag->tag;
    ++
     +		/*
     +		 * TRANSLATORS: This is a line of
     +		 * ambiguous tag object output. E.g.:
    @@ object-name.c: static int show_ambiguous_object(const struct object_id *oid, voi
     +		 * object.c, it should (hopefully) already be
     +		 * translated.
     +		 */
    -+		strbuf_addf(&desc, _("%s %s %s"), abbrev, _(type_name(type)),
    -+			    tag_desc);
    -+	} else {
    -+		const char *tname = type_name(type) ? _(type_name(type)) :
    -+			_(unknown_type);
    ++		strbuf_addf(&desc, _("%s tag %s"), hash, tag_tag);
    ++	} else if (type == OBJ_TREE) {
     +		/*
     +		 * TRANSLATORS: This is a line of ambiguous <type>
    -+		 * object output. Where <type> is one of the object
    -+		 * types of "tree", "blob", "tag" ("commit" is handled
    -+		 * above).
    -+		 *
    -+		 *    "deadbeef tree"
    -+		 *    "deadbeef blob"
    -+		 *    "deadbeef tag"
    -+		 *    "deadbeef unknown type"
    -+		 *
    -+		 * Note that annotated tags use a separate format
    -+		 * outlined above.
    -+		 *
    -+		 * The second argument is the "tree", "blob" or "tag"
    -+		 * string from object.c, or the "unknown type" string
    -+		 * in the case of an unknown type. All of them should
    -+		 * (hopefully) already be translated.
    ++		 * object output. E.g. "deadbeef tree".
     +		 */
    -+		strbuf_addf(&desc, _("%s %s"), abbrev, tname);
    -+	}
    -+
    ++		strbuf_addf(&desc, _("%s tree"), hash);
    ++	} else if (type == OBJ_BLOB) {
    ++		/*
    ++		 * TRANSLATORS: This is a line of ambiguous <type>
    ++		 * object output. E.g. "deadbeef blob".
    ++		 */
    ++		strbuf_addf(&desc, _("%s blob"), hash);
    ++	} else {
    ++		BUG("unreachable");
    + 	}
    + 
    +-	advise("  %s %s%s",
    +-	       repo_find_unique_abbrev(ds->repo, oid, DEFAULT_ABBREV),
    +-	       type_name(type), desc.buf);
     +	/*
     +	 * TRANSLATORS: This is line item of ambiguous object output,
     +	 * translated above.
     +	 */
    -+	advise(_("  %s\n"), desc.buf);
    ++	advise(_("  %s"), desc.buf);
      
      	strbuf_release(&desc);
    -+	strbuf_release(&ci_ad);
    -+	strbuf_release(&ci_s);
      	return 0;
    - }
    - 
-:  ----------- > 3:  8bde4e174b7 object-name: show date for ambiguous tag objects
-- 
2.33.0.1492.g76eb1af92bc

