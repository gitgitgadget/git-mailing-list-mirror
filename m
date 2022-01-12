Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 332BBC433F5
	for <git@archiver.kernel.org>; Wed, 12 Jan 2022 12:40:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353218AbiALMkK (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Jan 2022 07:40:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353199AbiALMkH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Jan 2022 07:40:07 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCFBFC06173F
        for <git@vger.kernel.org>; Wed, 12 Jan 2022 04:40:06 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id l25so3921007wrb.13
        for <git@vger.kernel.org>; Wed, 12 Jan 2022 04:40:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ctQ2y7vfA2FoLvbOErAaffPQHM2wLp8UicnwcAkX7P0=;
        b=cCmSkGf+3UjPu8b9twtR885cnW6aILHQLheRhhaMc8aqpaW4HPW8Cj7W9KlPcnS9c/
         qx3J1xruu6Wzb6mXeacH/b90GjJSaU+E2vLPYoWHVYdlkaued3F5Y0kClniw3unkCD0d
         GtDQO2ayKaUo7dWpnlQbwPWxkgNISVEix7LQj45l5gTFgjBZBe2zK7JTkWNmJ4Zu3oAK
         DhnWF+pMIElJdXiKd//XFu7+1ewPLEGrSDOCb+PLiHW8Niui2Pm7t6wwBjDSdSPmHB1h
         gPt/nk6NPJOEyT4RiAdZV+DJXJ6KMeMFhINvL/rOcdEjgSYNglg2hLv4giUCWitQ1XpB
         za6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ctQ2y7vfA2FoLvbOErAaffPQHM2wLp8UicnwcAkX7P0=;
        b=ew0tQlvlM8HjS0JT5lRosct/ggDpDK5wr7nCn+0cILPIImdgDV2fZ3nmpz4sp1Liv8
         kEiHW/OEbahloT8jUGxOXleupfpJtsMtvrjXtVv1H2T1Sq3mQ3ucnN4IE1s/GQH+aCWR
         r6UsOQpHQrPlAeaM+HQApSDlXJ3qmLrT93ivy5M3w4dVs3xDc7PS8/H//GntfNJPbNBH
         OFyJ0/3DBymNkJdkEGw+97Avk9W8gd7OMPBnMiH+0FaI6cZ0p8P+XemnIuyD4sWkvfNK
         b8Y55Rnfx3SCfZT95X2pNFmIVeG8mHFMor6mo8a60x6v6u2XJWpnjLgXiAdMN/nUVK1c
         1wXA==
X-Gm-Message-State: AOAM533DMfN77ci5ezIfQGqcKGztKTMKSWDujO62VmcyxF6+vOX+2Q0n
        Xp33O92Vg7N5NFFTnX0HL0tszYEVQqVaNQ==
X-Google-Smtp-Source: ABdhPJzIotyJz658dMYZo83cyyYfL8+h3Gs5mHY9NjaPR059HSrkL2d0YABkidBYAQ1F4Si9nePt4g==
X-Received: by 2002:adf:df0a:: with SMTP id y10mr8054494wrl.360.1641991204781;
        Wed, 12 Jan 2022 04:40:04 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id j13sm5174242wmq.11.2022.01.12.04.40.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jan 2022 04:40:04 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Josh Steadmon <steadmon@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v7 0/6] object-name: make ambiguous object output translatable + show tag date
Date:   Wed, 12 Jan 2022 13:39:19 +0100
Message-Id: <cover-v7-0.6-00000000000-20220111T130811Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.0.rc0.848.gb9d3879eb1d
In-Reply-To: <cover-v6-0.6-00000000000-20211228T143223Z-avarab@gmail.com>
References: <cover-v6-0.6-00000000000-20211228T143223Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This topic improves the output we emit on ambiguous objects as noted
in 4/6, and makes it translatable, see 3/6. See [1] for v6.

This v7 addresses all the feedback on v7 from Junio. Note also that
there's an unrelated v8[2] in reply to the v6 from another topic,
because I mixed up the In-Reply-To for the two while submitting a
re-roll of it, sorry about that.

1. https://lore.kernel.org/git/cover-v6-0.6-00000000000-20211228T143223Z-avarab@gmail.com/
2. https://lore.kernel.org/git/cover-v8-0.7-00000000000-20211228T150728Z-avarab@gmail.com/

Ævar Arnfjörð Bjarmason (6):
  object-name tests: add tests for ambiguous object blind spots
  object-name: explicitly handle OBJ_BAD in show_ambiguous_object()
  object-name: make ambiguous object output translatable
  object-name: show date for ambiguous tag objects
  object-name: iterate ambiguous objects before showing header
  object-name: re-use "struct strbuf" in show_ambiguous_object()

 object-name.c                       | 113 +++++++++++++++++++++++++---
 t/t1512-rev-parse-disambiguation.sh |  78 +++++++++++++++++++
 2 files changed, 179 insertions(+), 12 deletions(-)

Range-diff against v6:
1:  27f267ad555 ! 1:  28c01b7f8a5 object-name tests: add tests for ambiguous object blind spots
    @@ t/t1512-rev-parse-disambiguation.sh: export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
      . ./test-lib.sh
      
     +test_cmp_failed_rev_parse () {
    -+	dir=$1
    -+	rev=$2
    -+	shift
    -+
    -+	test_must_fail git -C "$dir" rev-parse "$rev" 2>actual.raw &&
    -+	sed "s/\($rev\)[0-9a-f]*/\1.../g" <actual.raw >actual &&
    ++	cat >expect &&
    ++	test_must_fail git -C "$1" rev-parse "$2" 2>actual.raw &&
    ++	sed "s/\($2\)[0-9a-f]*/\1.../" <actual.raw >actual &&
     +	test_cmp expect actual
     +}
     +
    @@ t/t1512-rev-parse-disambiguation.sh: export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     +	) &&
     +
     +	test_must_fail git -C blob.prefix rev-parse dead &&
    -+	cat >expect <<-\EOF &&
    ++	test_cmp_failed_rev_parse blob.prefix beef <<-\EOF
     +	error: short object ID beef... is ambiguous
     +	hint: The candidates are:
     +	hint:   beef... blob
    @@ t/t1512-rev-parse-disambiguation.sh: export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     +	Use '\''--'\'' to separate paths from revisions, like this:
     +	'\''git <command> [<revision>...] -- [<file>...]'\''
     +	EOF
    -+	test_cmp_failed_rev_parse blob.prefix beef
     +'
     +
    -+test_expect_success 'ambiguous loose blob parsed as OBJ_BAD' '
    ++test_expect_success 'ambiguous loose bad object parsed as OBJ_BAD' '
     +	git init --bare blob.bad &&
     +	(
     +		cd blob.bad &&
    @@ t/t1512-rev-parse-disambiguation.sh: export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     +		echo xyzhjpyvwl | git hash-object -t bad -w --stdin --literally
     +	) &&
     +
    -+	cat >expect <<-\EOF &&
    ++	test_cmp_failed_rev_parse blob.bad bad0 <<-\EOF
     +	error: short object ID bad0... is ambiguous
     +	hint: The candidates are:
     +	fatal: invalid object type
     +	EOF
    -+	test_cmp_failed_rev_parse blob.bad bad0
     +'
     +
     +test_expect_success POSIXPERM 'ambigous zlib corrupt loose blob' '
    @@ t/t1512-rev-parse-disambiguation.sh: export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     +		echo broken >$oidf
     +	) &&
     +
    -+	cat >expect <<-\EOF &&
    ++	test_cmp_failed_rev_parse blob.corrupt cafe <<-\EOF
     +	error: short object ID cafe... is ambiguous
     +	hint: The candidates are:
     +	error: inflate: data stream error (incorrect header check)
    @@ t/t1512-rev-parse-disambiguation.sh: export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     +	Use '\''--'\'' to separate paths from revisions, like this:
     +	'\''git <command> [<revision>...] -- [<file>...]'\''
     +	EOF
    -+	test_cmp_failed_rev_parse blob.corrupt cafe
     +'
     +
      if ! test_have_prereq SHA1
2:  c78243dc701 = 2:  b7027dfc843 object-name: explicitly handle OBJ_BAD in show_ambiguous_object()
3:  daebc95542c ! 3:  65801f2c890 object-name: make ambiguous object output translatable
    @@ object-name.c: static int show_ambiguous_object(const struct object_id *oid, voi
     +		 *    "deadbeef tag Some Tag Message"
     +		 *
     +		 * The second argument is the "tag" string from
    -+		 * object.c, it should (hopefully) already be
    -+		 * translated.
    ++		 * object.c.
     +		 */
     +		strbuf_addf(&desc, _("%s tag %s"), hash, tag_tag);
     +	} else if (type == OBJ_TREE) {
    @@ object-name.c: static int show_ambiguous_object(const struct object_id *oid, voi
     -	       desc.buf);
     +	/*
     +	 * TRANSLATORS: This is line item of ambiguous object output
    -+	 * from describe_ambiguous_object() above.
    ++	 * from describe_ambiguous_object() above. For RTL languages
    ++	 * you'll probably want to swap the "%s" and leading " " space
    ++	 * around.
     +	 */
     +	advise(_("  %s"), desc.buf);
      
4:  b5aa6e266f6 ! 4:  2e5511c9fa5 object-name: show date for ambiguous tag objects
    @@ Commit message
     
             hint:   b7e68c41d92 tag v2.32.0
     
    +    As with OBJ_COMMIT we punt on the cases where the date in the object
    +    is nonsensical, and other cases where parse_tag() might fail. For
    +    those we'll use our default date of "0" and tag message of
    +    "". E.g. for some of the corrupt tags created by t3800-mktag.sh we'd
    +    emit a line like:
    +
    +        hint:   8d62cb0b06 tag 1970-01-01 -
    +
    +    We could detect that and emit a "%s [bad tag object]" message (to go
    +    with the existing generic "%s [bad object]"), but I don't think it's
    +    worth the effort. Users are unlikely to ever run into cases where
    +    they've got a broken object that's also ambiguous, and in case they do
    +    output that's a bit nonsensical beats wasting translator time on this
    +    obscure edge case.
    +
    +    We should instead change parse_tag_buffer() to be more eager to emit
    +    an error() instead of silently aborting with "return -1;". In the case
    +    of "t3800-mktag.sh" it takes the "size < the_hash_algo->hexsz + 24"
    +    branch.
    +
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## object-name.c ##
    @@ object-name.c: static int show_ambiguous_object(const struct object_id *oid, voi
     +		 *    "deadbeef tag 2021-01-01 - Some Tag Message"
      		 *
      		 * The second argument is the "tag" string from
    - 		 * object.c, it should (hopefully) already be
    - 		 * translated.
    + 		 * object.c.
      		 */
     -		strbuf_addf(&desc, _("%s tag %s"), hash, tag_tag);
     +		strbuf_addf(&desc, _("%s tag %s - %s"), hash,
5:  644b076b2a6 ! 5:  2c03cdd3c1e object-name: iterate ambiguous objects before showing header
    @@ object-name.c: static int init_object_disambiguation(struct repository *r,
      	int type;
      	const char *hash;
     @@ object-name.c: static int show_ambiguous_object(const struct object_id *oid, void *data)
    - 	 * TRANSLATORS: This is line item of ambiguous object output
    - 	 * from describe_ambiguous_object() above.
    + 	 * you'll probably want to swap the "%s" and leading " " space
    + 	 * around.
      	 */
     -	advise(_("  %s"), desc.buf);
     +	strbuf_addf(advice, _("  %s\n"), desc.buf);
    @@ object-name.c: static enum get_oid_result get_short_oid(struct repository *r,
      	return status;
     
      ## t/t1512-rev-parse-disambiguation.sh ##
    -@@ t/t1512-rev-parse-disambiguation.sh: test_expect_success 'ambiguous loose blob parsed as OBJ_BAD' '
    +@@ t/t1512-rev-parse-disambiguation.sh: test_expect_success 'ambiguous loose bad object parsed as OBJ_BAD' '
      
    - 	cat >expect <<-\EOF &&
    + 	test_cmp_failed_rev_parse blob.bad bad0 <<-\EOF
      	error: short object ID bad0... is ambiguous
     -	hint: The candidates are:
      	fatal: invalid object type
      	EOF
    - 	test_cmp_failed_rev_parse blob.bad bad0
    + '
     @@ t/t1512-rev-parse-disambiguation.sh: test_expect_success POSIXPERM 'ambigous zlib corrupt loose blob' '
      
    - 	cat >expect <<-\EOF &&
    + 	test_cmp_failed_rev_parse blob.corrupt cafe <<-\EOF
      	error: short object ID cafe... is ambiguous
     -	hint: The candidates are:
      	error: inflate: data stream error (incorrect header check)
6:  6a31cfcfc29 ! 6:  bf226f67099 object-name: re-use "struct strbuf" in show_ambiguous_object()
    @@ object-name.c: static int show_ambiguous_object(const struct object_id *oid, voi
      		strbuf_release(&date);
      		strbuf_release(&msg);
     @@ object-name.c: static int show_ambiguous_object(const struct object_id *oid, void *data)
    - 		 * object.c, it should (hopefully) already be
    - 		 * translated.
    + 		 * The second argument is the "tag" string from
    + 		 * object.c.
      		 */
     -		strbuf_addf(&desc, _("%s tag %s - %s"), hash,
     +		strbuf_addf(sb, _("%s tag %s - %s"), hash,
    @@ object-name.c: static int show_ambiguous_object(const struct object_id *oid, voi
      
      
     @@ object-name.c: static int show_ambiguous_object(const struct object_id *oid, void *data)
    - 	 * TRANSLATORS: This is line item of ambiguous object output
    - 	 * from describe_ambiguous_object() above.
    + 	 * you'll probably want to swap the "%s" and leading " " space
    + 	 * around.
      	 */
     -	strbuf_addf(advice, _("  %s\n"), desc.buf);
     +	strbuf_addf(advice, _("  %s\n"), sb->buf);
-- 
2.34.1.1373.g062f5534af2

