Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12BEEC4361B
	for <git@archiver.kernel.org>; Wed,  9 Dec 2020 20:04:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF39C239D1
	for <git@archiver.kernel.org>; Wed,  9 Dec 2020 20:04:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388062AbgLIUCl (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Dec 2020 15:02:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388059AbgLIUCi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Dec 2020 15:02:38 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A47FDC0613D6
        for <git@vger.kernel.org>; Wed,  9 Dec 2020 12:01:57 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id t16so3092673wra.3
        for <git@vger.kernel.org>; Wed, 09 Dec 2020 12:01:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uE7FsEK8LQW4hc6fmlPi97z4iEf2s7imlK3zryMCgR4=;
        b=e8ScBfHw/U2wL47B9Cm37RfUeEQ8K75j3DECOalwPwC1REpdmWyzDusk4y2A1VaPxj
         5oChi3lDCJI/uwZzpOuBltLRlhoKcaFoViBNdAApBE0G1NB2p98DwXzs64v2Wy2naE6b
         Sq0XDyNQupCh9E5Q+srJiTIDG1apIb7bZPEZKofIxF+EWULppalRSl5N2peFI8SzFd5i
         TuBKrsYVnNWRy+tyeCD5mOUeGGOL4XLiSH5kGj0zo3C6at4LTvA5/defIJxUpyJ6dzby
         2gF7TEteHzBjzG5O+NETspHNnnTc4p6uCYNt2hD+H4yPnK4O5oq7TAekxer+0VSAPpH6
         2E9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uE7FsEK8LQW4hc6fmlPi97z4iEf2s7imlK3zryMCgR4=;
        b=fQo+941ByrEKEN1tMIj8bJEfRvxwjZ072uDw/1phPq4bQBahMjYYlO2TXjHefBY/jP
         RHlibCMbcdWlaXtasSv74de+ee7dpDmcYUkGa7IG9naHSJ4BpVZOWlUqXfYUOO3gHmg/
         feO5jQCbFyuAeE8f7HweKKTMn4AiuTNtynyakfSt1UYMLvC5wepTDLiac5q23Iem3qQY
         0isHcqojl3SgnWN4WHTjVTzrmzDaLoYSPQWNl+dn8NhhYa9QeSC+1sImDlKc5mym/Boy
         YJouMxHtnuNrHQnccl5RE9Fb6wqlxd/eHLGCY1wMhFv1mu+kSNqS1LZmgqL01PMgLn0t
         hQYg==
X-Gm-Message-State: AOAM531CHhKBM6bt7qLJi5M1Qd8meY/AZToKpwtk2/XhkZx0BLLMjTee
        aEq8731EKa/RTKuDtzxktzFp6imaLCQ5CQ==
X-Google-Smtp-Source: ABdhPJwhGhYQPjMHiHfpWiOG+bvoWPsq49icyWY/YH6dkJ9lnYpZnOOK/4gcVlv2tWsEWVB4ptWWrA==
X-Received: by 2002:a05:6000:1d1:: with SMTP id t17mr4601894wrx.164.1607544116261;
        Wed, 09 Dec 2020 12:01:56 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id 34sm5762128wrh.78.2020.12.09.12.01.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Dec 2020 12:01:54 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 00/10] make "mktag" use fsck_tag()
Date:   Wed,  9 Dec 2020 21:01:30 +0100
Message-Id: <20201209200140.29425-1-avarab@gmail.com>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8
In-Reply-To: <20201126222257.5629-1-avarab@gmail.com>
References: <20201126222257.5629-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This version should address all the comments Junio made on v2. Changes:

 * The whole "extra" fsck option is gone, I just didn't realize I
   could set the new check to "ignore", and then manually promote it.

 * Ejected "mktag: reword write_object_file() error". It was the same
   phrasing as "git tag" uses, let's just keep it.

 * Clarifications in docs/commit messages

 * There's 2 extra patches at the end now which take the first steps
   into making "git mktag" more of a normal builtin. It reads fsck.*
   config variables, so you can turn off that "no extra headers" check
   through the normal fsck.<msg-id>=ignore config.

   It should also be moved to getopts, and we could make it support
   --no-strict to have the same idea of error/warning as fsck itself,
   but that's #leftoverbits, along with moving it to i18n.

   It would be nice to have patches 1-8 merged down if they're deemed
   ready, and if 9-10 aren't deemed wanted just discard them. I think
   it makes sense though...

Ævar Arnfjörð Bjarmason (10):
  mktag doc: say <hash> not <sha1>
  mktag: use default strbuf_read() hint
  mktag: remove redundant braces in one-line body "if"
  mktag tests: don't needlessly use a subshell
  mktag tests: remove needless SHA-1 hardcoding
  mktag tests: improve verify_object() test coverage
  mktag: use fsck instead of custom verify_tag()
  mktag doc: update to explain why to use this
  fsck: make fsck_config() re-usable
  mktag: allow turning off fsck.extraHeaderEntry

 Documentation/git-hash-object.txt |   4 +
 Documentation/git-mktag.txt       |  34 ++++-
 builtin/fsck.c                    |  20 +--
 builtin/mktag.c                   | 204 +++++++++---------------------
 fsck.c                            |  57 ++++++++-
 fsck.h                            |  16 +++
 t/t1006-cat-file.sh               |   2 +-
 t/t3800-mktag.sh                  | 132 ++++++++++++++-----
 8 files changed, 261 insertions(+), 208 deletions(-)

Range-diff:
 1:  f46abb37df9 =  1:  aee3f52a478 mktag doc: say <hash> not <sha1>
 2:  1b4d9a53302 =  2:  6e98557709a mktag: use default strbuf_read() hint
 3:  83f4af6013e <  -:  ----------- mktag: reword write_object_file() error
 4:  bca1484ed96 =  3:  8e5fe08f155 mktag: remove redundant braces in one-line body "if"
 5:  ac7c4097c90 =  4:  1f06b9c0cf9 mktag tests: don't needlessly use a subshell
 6:  5e076659e45 !  5:  5d1cb73ca35 mktag tests: remove needless SHA-1 hardcoding
    @@ t/t3800-mktag.sh: EOF
      
      ############################################################
     -#  3. object line SHA1 check
    -+#  3. object line SHA check
    ++#  3. object line hash check
      
      cat >tag.sig <<EOF
     -object zz9e9b33986b1c2670fff52c5067603117b3e895
 7:  a048c3e6401 !  6:  cf86f4ca37d mktag tests: improve verify_object() test coverage
    @@ t/t3800-mktag.sh: check_verify_failure '"type" line type-name length check' \
      
      ############################################################
     -#  9. verify object (SHA1/type) check
    -+#  9. verify object (SHA/type) check
    ++#  9. verify object (hash/type) check
      
      cat >tag.sig <<EOF
      object $(test_oid deadbeef)
    @@ t/t3800-mktag.sh: check_verify_failure '"type" line type-name length check' \
     +
     +EOF
     +
    -+check_verify_failure 'verify object (SHA/type) check -- correct type, nonexisting object' \
    ++check_verify_failure 'verify object (hash/type) check -- correct type, nonexisting object' \
     +	'^error: char7: could not verify object.*$'
     +
     +cat >tag.sig <<EOF
    @@ t/t3800-mktag.sh: check_verify_failure '"type" line type-name length check' \
      EOF
      
     -check_verify_failure 'verify object (SHA1/type) check' \
    -+check_verify_failure 'verify object (SHA/type) check -- made-up type, nonexisting object' \
    ++check_verify_failure 'verify object (hash/type) check -- made-up type, nonexisting object' \
     +	'^fatal: invalid object type'
     +
     +cat >tag.sig <<EOF
    @@ t/t3800-mktag.sh: check_verify_failure '"type" line type-name length check' \
     +
     +EOF
     +
    -+check_verify_failure 'verify object (SHA/type) check -- incorrect type, valid object' \
    ++check_verify_failure 'verify object (hash/type) check -- incorrect type, valid object' \
      	'^error: char7: could not verify object.*$'
      
     +cat >tag.sig <<EOF
    @@ t/t3800-mktag.sh: check_verify_failure '"type" line type-name length check' \
     +
     +EOF
     +
    -+check_verify_failure 'verify object (SHA/type) check -- incorrect type, valid object' \
    ++check_verify_failure 'verify object (hash/type) check -- incorrect type, valid object' \
     +	'^error: char7: could not verify object'
     +
      ############################################################
 8:  dab44d32359 <  -:  ----------- fsck: add new "extra" checks for "mktag"
 9:  8ff853caeea !  7:  5812ee53c97 mktag: use fsck instead of custom verify_tag()
    @@ Commit message
         back to the same commit[1]. Let's unify them so we're not maintaining
         two sets functions to verify that a tag is OK.
     
    -    Moving to fsck_tag() required teaching it to optionally use some
    -    validations that only the old mktag code could perform. That was done
    -    in an earlier commit, the "extraHeaderEntry" and
    -    "extraHeaderBodyNewline" tests being added here make use of that
    -    logic.
    +    The behavior of fsck_tag() and the old "mktag" code being removed here
    +    is different in few aspects.
     
    -    There was other "mktag" validation logic that I think makes sense to
    -    just remove. Namely:
    +    I think it makes sense to remove some of those checks, namely:
     
          A. fsck only cares that the timezone matches [-+][0-9]{4}. The mktag
             code disallowed values larger than 1400.
    @@ Commit message
          C. Like B, but "mktag" disallowed spaces in the <email> part, fsck
             allows it.
     
    -    We didn't only lose obscure validation logic, we also gained some:
    +    In some ways fsck_tag() is stricter than "mktag" was, namely:
     
          D. fsck disallows zero-padded dates, but mktag didn't care. So
             e.g. the timestamp "0000000000 +0000" produces an error now. A
             test in "t1006-cat-file.sh" relied on this, it's been changed to
             use "hash-object" (without fsck) instead.
     
    +    There was one check I deemed worth keeping by porting it over to
    +    fsck_tag():
    +
    +     E. "mktag" did not allow any custom headers, and by extension (as an
    +        empty commit is allowed) also forbade an extra stray trailing
    +        newline after the headers it knew about.
    +
    +        Add a new check in the "ignore" category to fsck and use it. This
    +        somewhat abuses the facility added in efaba7cc77f (fsck:
    +        optionally ignore specific fsck issues completely, 2015-06-22).
    +
    +        This is somewhat of hack, but probably the least invasive change
    +        we can make here. The fsck command will shuffle these categories
    +        around, e.g. under --strict the "info" becomes a "warn" and "warn"
    +        becomes "error". Existing users of fsck's (and others,
    +        e.g. index-pack) --strict option rely on this.
    +
    +        So we need to put something into a category that'll be ignored by
    +        all existing users of the API. Pretending that
    +        fsck.extraHeaderEntry=error ("ignore" by default) was set serves
    +        to do this for us.
    +
         1. ec4465adb38 (Add "tag" objects that can be used to sign other
            objects., 2005-04-25)
     
    @@ builtin/mktag.c
     +	switch (msg_type) {
     +	case FSCK_WARN:
     +	case FSCK_ERROR:
    -+	case FSCK_EXTRA:
     +		/*
     +		 * We treat both warnings and errors as errors, things
     +		 * like missing "tagger" lines are "only" warnings
    @@ builtin/mktag.c: int cmd_mktag(int argc, const char **argv, const char *prefix)
     -	   "object <sha1>\ntype\ntagger " */
     -	if (verify_tag(buf.buf, buf.len) < 0)
     -		die("invalid tag signature file");
    -+	fsck_options.extra = 1;
     +	fsck_options.error_func = mktag_fsck_error_func;
    ++	fsck_set_msg_type(&fsck_options, "extraheaderentry", "warn");
     +	if (fsck_tag_standalone(NULL, buf.buf, buf.len, &fsck_options,
     +				&tagged_oid, &tagged_type))
     +		die("tag on stdin did not pass our strict fsck check");
    @@ builtin/mktag.c: int cmd_mktag(int argc, const char **argv, const char *prefix)
     +		die("tag on stdin did not refer to a valid object");
      
      	if (write_object_file(buf.buf, buf.len, tag_type, &result) < 0)
    - 		die("unable to write annotated tag object");
    + 		die("unable to write tag file");
     
      ## fsck.c ##
    +@@ fsck.c: static struct oidset gitmodules_done = OIDSET_INIT;
    + 	/* infos (reported as warnings, but ignored by default) */ \
    + 	FUNC(GITMODULES_PARSE, INFO) \
    + 	FUNC(BAD_TAG_NAME, INFO) \
    +-	FUNC(MISSING_TAGGER_ENTRY, INFO)
    ++	FUNC(MISSING_TAGGER_ENTRY, INFO) \
    ++	/* ignored (elevated when requested) */ \
    ++	FUNC(EXTRA_HEADER_ENTRY, IGNORE)
    + 
    + #define MSG_ID(id, msg_type) FSCK_MSG_##id,
    + enum fsck_msg_id {
     @@ fsck.c: static int fsck_tag(const struct object_id *oid, const char *buffer,
      		    unsigned long size, struct fsck_options *options)
      {
    @@ fsck.c: static int fsck_tag(const struct object_id *oid, const char *buffer,
      		ret = report(options, oid, OBJ_TAG, FSCK_MSG_BAD_TYPE, "invalid 'type' value");
      	if (ret)
      		goto done;
    +@@ fsck.c: static int fsck_tag(const struct object_id *oid, const char *buffer,
    + 	else
    + 		ret = fsck_ident(&buffer, oid, OBJ_TAG, options);
    + 
    ++	if (!starts_with(buffer, "\n")) {
    ++		/*
    ++		 * The verify_headers() check will allow
    ++		 * e.g. "[...]tagger <tagger>\nsome
    ++		 * garbage\n\nmessage" to pass, thinking "some
    ++		 * garbage" could be a custom header. E.g. "mktag"
    ++		 * doesn't want any unknown headers.
    ++		 */
    ++		ret = report(options, oid, OBJ_TAG, FSCK_MSG_EXTRA_HEADER_ENTRY, "invalid format - extra header(s) after 'tagger'");
    ++		if (ret)
    ++			goto done;
    ++	}
    ++
    + done:
    + 	strbuf_release(&sb);
    + 	return ret;
     
      ## fsck.h ##
     @@ fsck.h: int fsck_walk(struct object *obj, void *data, struct fsck_options *options);
    @@ t/t3800-mktag.sh: tagger . <> 0 +0000
     +check_verify_failure '"object" line label check' '^error:.* missingObject:'
      
      ############################################################
    - #  3. object line SHA check
    + #  3. object line hash check
     @@ t/t3800-mktag.sh: tagger . <> 0 +0000
      
      EOF
    @@ t/t3800-mktag.sh: tag mytag
     +	'^error:.* badType:'
      
      ############################################################
    - #  9. verify object (SHA/type) check
    + #  9. verify object (hash/type) check
     @@ t/t3800-mktag.sh: tagger . <> 0 +0000
      EOF
      
    - check_verify_failure 'verify object (SHA/type) check -- correct type, nonexisting object' \
    + check_verify_failure 'verify object (hash/type) check -- correct type, nonexisting object' \
     -	'^error: char7: could not verify object.*$'
     +	'^fatal: could not read tagged object'
      
    @@ t/t3800-mktag.sh: tagger . <> 0 +0000
     @@ t/t3800-mktag.sh: tagger . <> 0 +0000
      EOF
      
    - check_verify_failure 'verify object (SHA/type) check -- made-up type, nonexisting object' \
    + check_verify_failure 'verify object (hash/type) check -- made-up type, nonexisting object' \
     -	'^fatal: invalid object type'
     +	'^error:.* badType:'
      
    @@ t/t3800-mktag.sh: tagger . <> 0 +0000
     @@ t/t3800-mktag.sh: tagger . <> 0 +0000
      EOF
      
    - check_verify_failure 'verify object (SHA/type) check -- incorrect type, valid object' \
    + check_verify_failure 'verify object (hash/type) check -- incorrect type, valid object' \
     -	'^error: char7: could not verify object.*$'
     +	'^error:.* badType:'
      
    @@ t/t3800-mktag.sh: tagger . <> 0 +0000
     @@ t/t3800-mktag.sh: tagger . <> 0 +0000
      EOF
      
    - check_verify_failure 'verify object (SHA/type) check -- incorrect type, valid object' \
    + check_verify_failure 'verify object (hash/type) check -- incorrect type, valid object' \
     -	'^error: char7: could not verify object'
     +	'^fatal: object.*tagged as.*tree.*but is.*commit'
      
    @@ t/t3800-mktag.sh: this line should not be here
     +tagger T A Gger <tagger@example.com> 1206478233 -0500
     +
     +
    -+this line should be one line up
    ++this line comes after an extra newline
     +EOF
     +
    -+check_verify_failure 'detect invalid header entry' \
    -+	'^error:.* extraHeaderBodyNewline:'
    ++test_expect_success \
    ++    'allow extra newlines at start of body' \
    ++    'git mktag <tag.sig >.git/refs/tags/mytag 2>message'
      
      ############################################################
      # 24. create valid tag
10:  e38feefd3f8 !  8:  fa04664f7f1 mktag doc: update to explain why to use this
    @@ Documentation/git-mktag.txt: SYNOPSIS
     +Reads a tag contents on standard input and creates a tag object. The
     +output is the new tag's <object> identifier.
     +
    -+This command accepts a subset of what linkgit:git-hash-object[1] would
    -+accept with `-t tag --stdin`. I.e. both of these work:
    ++This command is mostly equivalent to linkgit:git-hash-object[1]
    ++invoked with `-t tag -w --stdin`. I.e. both of these will create and
    ++write a tag found in `my-tag`:
     +
     +    git mktag <my-tag
    -+    git hash-object -t tag --stdin <my-tag
    ++    git hash-object -t tag -w --stdin <my-tag
     +
    -+The difference between the two is that mktag does the equivalent of a
    -+linkgit:git-fsck(1) check on its input, and furthermore disallows some
    -+thing linkgit:git-hash-object[1] would pass, e.g. extra headers in the
    -+object before the message.
    ++The difference is that mktag will die before writing the tag if the
    ++tag doesn't pass a linkgit:git-fsck[1] check.
    ++
    ++The "fsck" check done mktag is is stricter than what
    ++linkgit:git-fsck[1] would run by default in that all `fsck.<msg-id>`
    ++messages are promoted from warnings to errors (so e.g. a missing
    ++"tagger" line is an error). Extra headers in the object are also an
    ++error under mktag, but ignored by linkgit:git-fsck[1].
      
      Tag Format
      ----------
    @@ Documentation/git-mktag.txt: exists, is separated by a blank line from the heade
      message part may contain a signature that Git itself doesn't
      care about, but that can be verified with gpg.
      
    -+HISTORY
    -+-------
    -+
    -+In versions of Git before v2.30.0 the "mktag" command's validation
    -+logic was subtly different than that of linkgit:git-fsck[1]. It is now
    -+a strict superset of linkgit:git-fsck[1]'s validation logic.
    -+
     +SEE ALSO
     +--------
     +linkgit:git-hash-object[1],
 -:  ----------- >  9:  30eff9170fb fsck: make fsck_config() re-usable
 -:  ----------- > 10:  11139ec2b8d mktag: allow turning off fsck.extraHeaderEntry
-- 
2.29.2.222.g5d2a92d10f8

