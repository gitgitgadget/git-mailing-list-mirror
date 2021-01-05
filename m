Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65D76C433E0
	for <git@archiver.kernel.org>; Tue,  5 Jan 2021 19:44:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1DA3922D6F
	for <git@archiver.kernel.org>; Tue,  5 Jan 2021 19:44:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730876AbhAEToI (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 Jan 2021 14:44:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728071AbhAEToI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Jan 2021 14:44:08 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DC74C061574
        for <git@vger.kernel.org>; Tue,  5 Jan 2021 11:43:27 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id 3so618131wmg.4
        for <git@vger.kernel.org>; Tue, 05 Jan 2021 11:43:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6IdprFif0VKC7wjNf/2n2J8Z4wj6HcvNfyIHt9kDNgg=;
        b=IgNS4Yos1o/+pXq5ySKBESDS+5M7283L0HfhexgTV7zcNEm5CenvNbGvyR1okkD1+W
         zzh/Fb3aPvKswfKDJ15ys8hq36jKWi4+popblAi+uAN9mhENpv5Zd1HqbChcqbld4Z+U
         PV2uFwZao6dKhahodBxuosC4IoI86RSPGx8gqr2P7JuoEd4OR89kO8jYF8tVCJ4ACvwZ
         UVv3BoUpgCnNUZL/pI1uxmSFrMYMih1j5Vai6A+K4OAuyrBYTj5rVHS9WxjFqRseK8K0
         q0iHPSUyVgSqa/i3+KoVPTzH7QSyfVV1KRheg+5YFMyRPyiyvDpJ5KjnN4lSHIISfhnA
         JSMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6IdprFif0VKC7wjNf/2n2J8Z4wj6HcvNfyIHt9kDNgg=;
        b=nKK7ugFRChWqtOavIrDjPPD+pk53qrSP3Jd+WlBledDoVAi3u/nfqWNYBJOYPLbO3r
         GhAHXqH/GWFefKDciO9Y2PyJi0+2J2uCvaApZ5uiCb0PMRfqLgNA6eMOc/SoD8GVWjsc
         dRxDJL7QIh+53jm0sCbuOqEoxg1sMA5xaR2XCEGxq+Zo8HrP2rFfrdupjwikzIDRtYTo
         Oor3AYWRMfDwm7I56TANGqtHA8cN5x6j6hpQiuhRNo2TrTBjQZOGl0ZP6lPqTZ5uhxes
         tjf7i7F1m5yc8nwckCaLqfLGa4Kcom5og/uzbDAkLro4/6u8P98fyS+wDSaVLcTVG1p8
         Nmtg==
X-Gm-Message-State: AOAM533IJFP1PayixNGuzrzz3QtXvxYCjFn+o5mSlhw33JsJrQ5vskje
        cQ7lZ9HBzG6kT1i6iLYi5bdA/OAC8CnsEA==
X-Google-Smtp-Source: ABdhPJz/1EoBlpla0/wzhsdYKq2BHYkPx51wTD18csRtK90uwkluZzAP99jPoBAWm5dSNwz6HSoarA==
X-Received: by 2002:a1c:5402:: with SMTP id i2mr677964wmb.12.1609875805640;
        Tue, 05 Jan 2021 11:43:25 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id s6sm151113wro.79.2021.01.05.11.43.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jan 2021 11:43:24 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 00/23] make "mktag" use fsck_tag() & more
Date:   Tue,  5 Jan 2021 20:42:29 +0100
Message-Id: <20210105194252.627-1-avarab@gmail.com>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8
In-Reply-To: <20201223013606.7972-1-avarab@gmail.com>
References: <20201223013606.7972-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A late re-roll due to the holidays. Thanks all for the feedback on v4,
this should address all of it.

Brief comments on each patch below, and then the range-diff.

Ævar Arnfjörð Bjarmason (23):
  mktag doc: say <hash> not <sha1>
  mktag doc: grammar fix, when exists -> when it exists

No changes.

  mktag doc: update to explain why to use this

Got rid of the cross-linking of mktag and hash-object manpages as
suggested by Junio.

  mktag tests: don't needlessly use a subshell

no changes.

  mktag tests: use "test_commit" helper

NEW: Another trivial mktag test cleanup, make it use test_commit
instead of 3 boilerplate lines in its test. Made a later change
smaller.

  mktag tests: remove needless SHA-1 hardcoding

no changes.

  mktag tests: don't redirect stderr to a file needlessly

Reworded the commit message, and fixed another copy/pasted mktag test
(in the git-replace test file) that used the same pattern.

  mktag tests: don't create "mytag" twice

The commit message notes that testing the tag at the end is pointless,
but now later we'll do something with it...

  mktag tests: run "fsck" after creating "mytag"

...i.e. run fsck to (potentially in the future) check the envelope
v.s. refname.

  mktag tests: stress test whitespace handling

Reworded commit message & test descriptions to make more sense, got
rid of the one $space test, which didn't really add anything.

  mktag tests: test "hash-object" compatibility

Gets rid of the "create tag refname" special case at the end of the
tests by now doing it for every successful tag creation.

  mktag tests: improve verify_object() test coverage

Commit message update, notes that we don't do "git replace" tests.

  mktag tests: test verify_object() with replaced objects

NEW: test mktag with git-replace'd objects.

  mktag: use default strbuf_read() hint
  mktag: remove redundant braces in one-line body "if"
  mktag: use puts(str) instead of printf("%s\n", str)

no changes.

  mktag: use fsck instead of custom verify_tag()

only carried-forward changes from rebasing on the changes above.

  fsck: make fsck_config() re-usable
  mktag: allow turning off fsck.extraHeaderEntry

no changes.

  mktag: allow omitting the header/body \n separator
  mktag: convert to parse-options

ditto carried-forward changes.

  mktag: mark strings for translation
  mktag: add a --no-strict option

Use the more normal OPT_BOOL pattern, and fix a stupid error in
GIT_TEST_GETTEXT_POISON=true testing that broke the CI.

 Documentation/git-mktag.txt |  39 +++++-
 builtin/fsck.c              |  20 +--
 builtin/mktag.c             | 235 +++++++++++++----------------------
 fsck.c                      |  59 ++++++++-
 fsck.h                      |  16 +++
 t/t1006-cat-file.sh         |   2 +-
 t/t3800-mktag.sh            | 236 ++++++++++++++++++++++++++++--------
 t/t6050-replace.sh          |   2 +-
 8 files changed, 375 insertions(+), 234 deletions(-)

Range-diff:
 1:  a31c305cfc6 =  1:  74b035fb842 mktag doc: say <hash> not <sha1>
 2:  81cb4cba5c0 =  2:  202bd33533f mktag doc: grammar fix, when exists -> when it exists
 3:  b4bc6f894cb !  3:  d1f650b6c4c mktag doc: update to explain why to use this
    @@ Commit message
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
    - ## Documentation/git-hash-object.txt ##
    -@@ Documentation/git-hash-object.txt: OPTIONS
    - 	stress-testing Git itself or reproducing characteristics of corrupt or
    - 	bogus objects encountered in the wild.
    - 
    -+SEE ALSO
    -+--------
    -+linkgit:git-mktag[1]
    -+
    - GIT
    - ---
    - Part of the linkgit:git[1] suite
    -
      ## Documentation/git-mktag.txt ##
     @@ Documentation/git-mktag.txt: git-mktag(1)
      
    @@ Documentation/git-mktag.txt: SYNOPSIS
      
      Tag Format
      ----------
    -@@ Documentation/git-mktag.txt: exists, is separated by a blank line from the header.  The
    - message part may contain a signature that Git itself doesn't
    - care about, but that can be verified with gpg.
    - 
    -+SEE ALSO
    -+--------
    -+linkgit:git-hash-object[1],
    -+
    - GIT
    - ---
    - Part of the linkgit:git[1] suite
 4:  acb94e02895 =  4:  64432d22952 mktag tests: don't needlessly use a subshell
 -:  ----------- >  5:  57c7bdde80b mktag tests: use "test_commit" helper
 5:  4ae76ec5e3f =  6:  ba581a99c89 mktag tests: remove needless SHA-1 hardcoding
 7:  b81d31a917c !  7:  974d1b9c6ec mktag tests: don't pipe to stderr needlessly
    @@ Metadata
     Author: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## Commit message ##
    -    mktag tests: don't pipe to stderr needlessly
    +    mktag tests: don't redirect stderr to a file needlessly
     
    -    Remove the piping of stderr to "message" in the valid tag test. This
    -    pattern seems to have been copy/pasted from the failure case in
    -    446c6faec6 (New tests and en-passant modifications to mktag.,
    +    Remove the redirection of stderr to "message" in the valid tag
    +    test. This pattern seems to have been copy/pasted from the failure
    +    case in 446c6faec6 (New tests and en-passant modifications to mktag.,
         2006-07-29).
     
    -    Nothing is piped to "message" here, and in the event of the test
    -    failing it only serves to hide the error.
    +    While I'm at it do the same for the "replace" tests. The tag creation
    +    I'm changing here seems to have been copy/pasted from the "mktag"
    +    tests to those tests in cc400f50112 (mktag: call
    +    "check_sha1_signature" with the replacement sha1, 2009-01-23).
    +
    +    Nobody examines the contents of the resulting "message" file, so the
    +    net result is that error messages cannot be seen in "sh t3800-mktag.sh
    +    -v" output.
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
    @@ t/t3800-mktag.sh: EOF
      
      ############################################################
      # 25. check mytag
    +
    + ## t/t6050-replace.sh ##
    +@@ t/t6050-replace.sh: tagger T A Gger <> 0 +0000
    + EOF
    + 
    + test_expect_success 'tag replaced commit' '
    +-     git mktag <tag.sig >.git/refs/tags/mytag 2>message
    ++     git mktag <tag.sig >.git/refs/tags/mytag
    + '
    + 
    + test_expect_success '"git fsck" works' '
 8:  11f59718b4b !  8:  73d82dbca24 mktag tests: don't create "mytag" twice
    @@ Commit message
         it. Let's do this by moving the test to use "update-ref", instead of
         our own homebrew ad-hoc refstore update.
     
    +    We're not really testing for anything yet by creating the tag at the
    +    end here. A subsequent commit will change that.
    +
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## t/t3800-mktag.sh ##
 -:  ----------- >  9:  0aa8190f404 mktag tests: run "fsck" after creating "mytag"
 9:  dd6b012b0c6 ! 10:  078e73c4221 mktag tests: stress test whitespace handling
    @@ Metadata
      ## Commit message ##
         mktag tests: stress test whitespace handling
     
    -    Add tests for various whitespace edge cases around the header/body
    -    boundary, such as two newlines separating the header and body, a space
    -    at the end of the "tagger" line before the header etc.
    +    Add tests for a couple of whitespace edge cases around the header/body
    +    boundary.
     
    -    Add a test showing that we insist that an empty body must be preceded
    -    by an empty line. This test for a long-standing regression which goes
    -    against the command's documented behavior. It'll be addressed in a
    -    follow-up change.
    +    I consider the requirement for a blank line before the empty body a
    +    bug, it's a long-standing regression which goes against the command's
    +    documented behavior. This bug will be addressed in a follow-up change.
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
    @@ t/t3800-mktag.sh: EOF
     +
     +EOF
     +
    -+test_expect_success 'allow extra newlines at end of headers' '
    ++test_expect_success 'require a blank line before an empty body (1)' '
     +	git mktag <tag.sig
     +'
     +
    -+space=' '
    -+cat >tag.sig <<EOF
    -+object $head
    -+type commit
    -+tag mytag
    -+tagger T A Gger <tagger@example.com> 1206478233 -0500$space
    -+
    -+EOF
    -+
    -+check_verify_failure 'extra whitespace at end of headers' \
    -+	'^error: char.*: malformed tag timezone$'
    -+
     +cat >tag.sig <<EOF
     +object $head
     +type commit
    @@ t/t3800-mktag.sh: EOF
     +tagger T A Gger <tagger@example.com> 1206478233 -0500
     +EOF
     +
    -+check_verify_failure 'disallow no header / body newline separator' \
    ++check_verify_failure 'require a blank line before an empty body (2)' \
     +	'^error: char.*: trailing garbage in tag header$'
     +
      ############################################################
10:  56c6b562fd5 ! 11:  83d7ca86b8f mktag tests: test "hash-object" compatibility
    @@ Commit message
         This tests e.g. that "mktag" doesn't trim its input or otherwise munge
         it in a way that "hash-object" doesn't.
     
    +    Since we're doing an "fsck --strict" here at the end let's incorporate
    +    the creation of the "mytag" name into this test, removing the
    +    special-case at the end of the file.
    +
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## t/t3800-mktag.sh ##
    @@ t/t3800-mktag.sh: check_verify_failure () {
     +	test_expect_success "$1" '
     +		git hash-object -t tag -w --stdin <tag.sig >expected &&
     +		git fsck --strict &&
    ++
     +		git mktag <tag.sig >hash &&
    -+		git fsck --strict &&
    -+		test_cmp expected hash
    ++		test_cmp expected hash &&
    ++		test_when_finished "git update-ref -d refs/tags/mytag $(cat hash)" &&
    ++		git update-ref refs/tags/mytag $(cat hash) $(test_oid zero) &&
    ++		git fsck --strict	
     +	'
     +}
     +
    @@ t/t3800-mktag.sh: tagger T A Gger <tagger@example.com> 1206478233 -0500
      
      EOF
      
    --test_expect_success 'allow extra newlines at end of headers' '
    +-test_expect_success 'require a blank line before an empty body (1)' '
     -	git mktag <tag.sig
     -'
    -+test_expect_mktag_success 'allow extra newlines at end of headers'
    ++test_expect_mktag_success 'require a blank line before an empty body (1)'
      
    - space=' '
      cat >tag.sig <<EOF
    + object $head
     @@ t/t3800-mktag.sh: tagger T A Gger <tagger@example.com> 1206478233 -0500
      
      EOF
      
     -test_expect_success 'create valid tag' '
     -	git mktag <tag.sig >hash &&
    +-	git update-ref refs/tags/mytag $(cat hash) $(test_oid zero) &&
    +-	git fsck --strict
    +-'
     +test_expect_mktag_success 'create valid tag object'
    -+test_expect_success 'create valid tag name' '
    - 	git update-ref refs/tags/mytag $(cat hash) $(test_oid zero)
    - '
      
    + test_done
 6:  9effb4532bc ! 12:  6cbf9176c35 mktag tests: improve verify_object() test coverage
    @@ Commit message
         Let's split these tests up, so we're testing all combinations of a
         non-existing object and in invalid/wrong "type" lines.
     
    +    We need to provide GIT_TEST_GETTEXT_POISON=false here because the
    +    "invalid object type" error is emitted by
    +    parse_loose_header_extended(), which has that message already marked
    +    for translation. Another option would be to use test_i18ngrep, but I
    +    prefer always running the test, not skipping it under gettext poison
    +    testing.
    +
    +    I'm not testing this in combination with "git replace". That'll be
    +    done in a subsequent commit.
    +
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## t/t3800-mktag.sh ##
    +@@ t/t3800-mktag.sh: test_description='git mktag: tag object verify test'
    + check_verify_failure () {
    + 	expect="$2"
    + 	test_expect_success "$1" '
    +-		test_must_fail git mktag <tag.sig 2>message &&
    ++		test_must_fail env GIT_TEST_GETTEXT_POISON=false \
    ++			git mktag <tag.sig 2>message &&
    + 		grep "$expect" message
    + 	'
    + }
     @@ t/t3800-mktag.sh: check_verify_failure '"type" line type-name length check' \
      	'^error: char.*: type too long$'
      
    @@ t/t3800-mktag.sh: check_verify_failure '"type" line type-name length check' \
      EOF
      
     -check_verify_failure 'verify object (SHA1/type) check' \
    -+check_verify_failure 'verify object (hash/type) check -- made-up type, nonexisting object' \
    ++check_verify_failure 'verify object (hash/type) check -- made-up type, valid object' \
     +	'^fatal: invalid object type'
     +
     +cat >tag.sig <<EOF
    @@ t/t3800-mktag.sh: check_verify_failure '"type" line type-name length check' \
     +
     +EOF
     +
    -+check_verify_failure 'verify object (hash/type) check -- incorrect type, valid object' \
    ++check_verify_failure 'verify object (hash/type) check -- made-up type, nonexisting object' \
      	'^error: char7: could not verify object.*$'
      
     +cat >tag.sig <<EOF
    @@ t/t3800-mktag.sh: check_verify_failure '"type" line type-name length check' \
     +
     +EOF
     +
    -+check_verify_failure 'verify object (hash/type) check -- incorrect type, valid object' \
    ++check_verify_failure 'verify object (hash/type) check -- mismatched type, valid object' \
     +	'^error: char7: could not verify object'
     +
      ############################################################
 -:  ----------- > 13:  ca1567866b0 mktag tests: test verify_object() with replaced objects
11:  1e2e4ec2697 = 14:  ac31d8658f3 mktag: use default strbuf_read() hint
12:  be2ab3edab0 = 15:  e32292af8b4 mktag: remove redundant braces in one-line body "if"
13:  d8514df970c = 16:  405fd2c747d mktag: use puts(str) instead of printf("%s\n", str)
14:  346d73cc972 ! 17:  6edaa992a25 mktag: use fsck instead of custom verify_tag()
    @@ t/t3800-mktag.sh: tagger . <> 0 +0000
     @@ t/t3800-mktag.sh: tagger . <> 0 +0000
      EOF
      
    - check_verify_failure 'verify object (hash/type) check -- made-up type, nonexisting object' \
    + check_verify_failure 'verify object (hash/type) check -- made-up type, valid object' \
     -	'^fatal: invalid object type'
     +	'^error:.* badType:'
      
    @@ t/t3800-mktag.sh: tagger . <> 0 +0000
     @@ t/t3800-mktag.sh: tagger . <> 0 +0000
      EOF
      
    - check_verify_failure 'verify object (hash/type) check -- incorrect type, valid object' \
    + check_verify_failure 'verify object (hash/type) check -- made-up type, nonexisting object' \
     -	'^error: char7: could not verify object.*$'
     +	'^error:.* badType:'
      
    @@ t/t3800-mktag.sh: tagger . <> 0 +0000
     @@ t/t3800-mktag.sh: tagger . <> 0 +0000
      EOF
      
    - check_verify_failure 'verify object (hash/type) check -- incorrect type, valid object' \
    + check_verify_failure 'verify object (hash/type) check -- mismatched type, valid object' \
     -	'^error: char7: could not verify object'
     +	'^fatal: object.*tagged as.*tree.*but is.*commit'
      
    + ############################################################
    + #  9.5. verify object (hash/type) check -- replacement
    +@@ t/t3800-mktag.sh: tagger . <> 0 +0000
    + EOF
    + 
    + check_verify_failure 'verify object (hash/type) check -- mismatched type, valid object' \
    +-	'^error: char7: could not verify object'
    ++	'^fatal: object.*tagged as.*tree.*but is.*blob'
    + 
      ############################################################
      # 10. verify tag-name check
     @@ t/t3800-mktag.sh: tagger . <> 0 +0000
    @@ t/t3800-mktag.sh: this line should not be here
     -	'^error: char.*: trailing garbage in tag header$'
     +	'^error:.* extraHeaderEntry:'
      
    - cat >tag.sig <<EOF
    - object $head
    -@@ t/t3800-mktag.sh: tagger T A Gger <tagger@example.com> 1206478233 -0500$space
    - EOF
    - 
    - check_verify_failure 'extra whitespace at end of headers' \
    --	'^error: char.*: malformed tag timezone$'
    -+	'^error:.* badTimezone:'
    - 
      cat >tag.sig <<EOF
      object $head
     @@ t/t3800-mktag.sh: tagger T A Gger <tagger@example.com> 1206478233 -0500
      EOF
      
    - check_verify_failure 'disallow no header / body newline separator' \
    + check_verify_failure 'require a blank line before an empty body (2)' \
     -	'^error: char.*: trailing garbage in tag header$'
     +	'^error:.* extraHeaderEntry:'
      
15:  0e7994d8fc3 = 18:  4c3fbb7ed58 fsck: make fsck_config() re-usable
16:  5e8046022b6 = 19:  32fc2264ec1 mktag: allow turning off fsck.extraHeaderEntry
17:  32698e1d005 ! 20:  32922a42dda mktag: allow omitting the header/body \n separator
    @@ fsck.c: int fsck_tag_standalone(const struct object_id *oid, const char *buffer,
      		/*
     
      ## t/t3800-mktag.sh ##
    +@@ t/t3800-mktag.sh: tagger T A Gger <tagger@example.com> 1206478233 -0500
    + 
    + EOF
    + 
    +-test_expect_mktag_success 'require a blank line before an empty body (1)'
    ++test_expect_mktag_success 'allow a blank line before an empty body (1)'
    + 
    + cat >tag.sig <<EOF
    + object $head
     @@ t/t3800-mktag.sh: tag mytag
      tagger T A Gger <tagger@example.com> 1206478233 -0500
      EOF
      
    --check_verify_failure 'disallow no header / body newline separator' \
    +-check_verify_failure 'require a blank line before an empty body (2)' \
     -	'^error:.* extraHeaderEntry:'
    -+test_expect_success 'allow no header / body newline separator' '
    -+	git mktag <tag.sig
    -+'
    ++test_expect_mktag_success 'allow no blank line before an empty body (2)'
      
      ############################################################
      # 24. create valid tag
18:  b6a22f2f992 ! 21:  3c991dda02b mktag: convert to parse-options
    @@ builtin/mktag.c: static int verify_object_in_tag(struct object_id *tagged_oid, i
     
      ## t/t3800-mktag.sh ##
     @@ t/t3800-mktag.sh: test_expect_success 'setup' '
    - 	head=$(git rev-parse --verify HEAD)
    + 	blob=$(git rev-parse --verify HEAD:B.t)
      '
      
     +test_expect_success 'basic usage' '
19:  7fc0b81df7d ! 22:  16db5858a08 mktag: mark strings for translation
    @@ builtin/mktag.c: int cmd_mktag(int argc, const char **argv, const char *prefix)
      
      	strbuf_release(&buf);
      	puts(oid_to_hex(&result));
    -
    - ## t/t3800-mktag.sh ##
    -@@ t/t3800-mktag.sh: test_description='git mktag: tag object verify test'
    - check_verify_failure () {
    - 	expect="$2"
    - 	test_expect_success "$1" '
    --		test_must_fail git mktag <tag.sig 2>message &&
    -+		test_must_fail env GIT_TEST_GETTEXT_POISON=false \
    -+			git mktag <tag.sig 2>message &&
    - 		grep "$expect" message
    - 	'
    - }
20:  6fa443d528c ! 23:  94d6aca6962 mktag: add a --no-strict option
    @@ Documentation/git-mktag.txt: SYNOPSIS
     +OPTIONS
     +-------
     +
    -+--no-strict::
    ++--strict::
     +	By default mktag turns on the equivalent of
    -+	linkgit:git-fsck[1] `--strict` mode. This disables it.
    ++	linkgit:git-fsck[1] `--strict` mode. Use `--no-strict` to
    ++	disable it.
     +
      DESCRIPTION
      -----------
    @@ builtin/mktag.c: static char const * const builtin_mktag_usage[] = {
      	N_("git mktag"),
      	NULL
      };
    -+static int option_no_strict;
    ++static int option_strict = 1;
      
      static struct fsck_options fsck_options = FSCK_OPTIONS_STRICT;
      
    @@ builtin/mktag.c: static int mktag_fsck_error_func(struct fsck_options *o,
      {
      	switch (msg_type) {
      	case FSCK_WARN:
    -+		if (option_no_strict) {
    ++		if (!option_strict) {
     +			fprintf_ln(stderr, _("warning: tag input does not pass fsck: %s"), message);
     +			return 0;
     +
    @@ builtin/mktag.c: static int verify_object_in_tag(struct object_id *tagged_oid, i
      int cmd_mktag(int argc, const char **argv, const char *prefix)
      {
      	static struct option builtin_mktag_options[] = {
    -+		OPT_NO_BOOL(0, "no-strict", &option_no_strict,
    -+			    N_("don't do strict fsck checks")),
    ++		OPT_BOOL(0, "strict", &option_strict,
    ++			 N_("enable more strict checking")),
      		OPT_END(),
      	};
      	struct strbuf buf = STRBUF_INIT;
     
    - ## parse-options.h ##
    -@@ parse-options.h: struct option {
    - #define OPT_COUNTUP(s, l, v, h)     OPT_COUNTUP_F(s, l, v, h, 0)
    - #define OPT_SET_INT(s, l, v, h, i)  OPT_SET_INT_F(s, l, v, h, i, 0)
    - #define OPT_BOOL(s, l, v, h)        OPT_BOOL_F(s, l, v, h, 0)
    -+#define OPT_NO_BOOL(s, l, v, h)     OPT_BOOL_F(s, l, v, h, PARSE_OPT_NONEG)
    - #define OPT_HIDDEN_BOOL(s, l, v, h) { OPTION_SET_INT, (s), (l), (v), NULL, \
    - 				      (h), PARSE_OPT_NOARG | PARSE_OPT_HIDDEN, NULL, 1}
    - #define OPT_CMDMODE(s, l, v, h, i)  { OPTION_SET_INT, (s), (l), (v), NULL, \
    -
      ## t/t3800-mktag.sh ##
     @@ t/t3800-mktag.sh: test_description='git mktag: tag object verify test'
      # given in the expect.pat file.
    @@ t/t3800-mktag.sh: test_description='git mktag: tag object verify test'
     +		grep '$2' message &&
     +		if test '$3' != '--no-strict'
     +		then
    -+			test_must_fail git mktag --no-strict <tag.sig 2>message.no-strict &&
    ++			test_must_fail env GIT_TEST_GETTEXT_POISON=false \
    ++				git mktag --no-strict <tag.sig 2>message.no-strict &&
     +			grep '$2' message.no-strict
     +		fi
     +	"
      }
      
      test_expect_mktag_success() {
    -@@ t/t3800-mktag.sh: test_expect_success 'basic usage' '
    - 	EOF
    - 	git mktag <tag.sig &&
    - 	git mktag --end-of-options <tag.sig &&
    --	test_expect_code 129 git mktag --unknown-option
    -+	test_expect_code 129 git mktag --unknown-option &&
    -+	test_expect_code 129 git mktag --strict
    - '
    - 
    - ############################################################
     @@ t/t3800-mktag.sh: too short for a tag
      EOF
      
-- 
2.29.2.222.g5d2a92d10f8

