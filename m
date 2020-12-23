Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31089C433E6
	for <git@archiver.kernel.org>; Wed, 23 Dec 2020 01:38:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC15C2256F
	for <git@archiver.kernel.org>; Wed, 23 Dec 2020 01:38:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726904AbgLWBiZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Dec 2020 20:38:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726319AbgLWBiY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Dec 2020 20:38:24 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43F08C0613D6
        for <git@vger.kernel.org>; Tue, 22 Dec 2020 17:37:44 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id c5so16953831wrp.6
        for <git@vger.kernel.org>; Tue, 22 Dec 2020 17:37:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=byOB8UkRoSiBW+ldgYjC03xWAELzaKPgUp+btpP8ZlE=;
        b=bn4YIiz2bXU6Wxw9rq3vAFiz4hnXMIcULxgsz3H3f3ux3+i+ztoMBCBhmgow05tdGH
         ZFEKUQZKHh4bwfGCaVS6VqSLDif9KfoDzq+MgGOJXkQaC0s+B9/BOFZMVsMF5vhW2lXu
         tgdeypU3nndm9I5cJlU+cjUyTEMAuplHyqTkBwSM3HBuiWdc1rRl1X8deB9a1Eqp8dkW
         O+brf+Y/MBPq2+m2SE4ljo36ICL3E/Vm/LTOPgDfFnKjP6kbOfm3D1COF/BhYXfSkFOl
         kRGPrG1oNAZdDVtXLAieRbBEN1IvBL1TCMexCJvwPIAxGTaQzsi1kcPsKhFIQOCx1NGZ
         X3OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=byOB8UkRoSiBW+ldgYjC03xWAELzaKPgUp+btpP8ZlE=;
        b=OHIsvSPgkgU1VPjs+YSymZVOZ9byKFDXUWbzGHP9Y5d9kbIFY80s/CRGVY9xPpuer7
         4XM0Z+/RZzawSULXxbTH1ecxMyn8KAVL3ZSKQsnq+GEueQ0RbNJUzsUW7HkQU/2YIu/F
         lPyPTXPIBK6N0/D67WPnpdSH9jc641J1I7PoEIDQmHpi66TClVofxHQt68KGs3p/1jZM
         F71u/nuBmlQO1lsM3DlOEoxTrnhvLNno6k/DDZyr0aZK9ogep0cb4WczQLasDlryLXe4
         TrNyq66XodtBzkqJjVdAbidjjryzdFusnGhZ1wZ/IZgo3BhHRopD4dEuC59zx4nXcnrl
         1u8A==
X-Gm-Message-State: AOAM533Vloc3NM6ZcG6y44MoCjfeclWMCSkAhMT/UYIm25Df5pQpm/wk
        m9uy/P3YniOB9I02waHAxgdhUEXnwlFx8A==
X-Google-Smtp-Source: ABdhPJzItpEif1rdbl8GVuGKGEQxmUCJUgfUbpO+Iy8YXMbowyyfGyFRTR3xkMVYwHrk51WegaZRig==
X-Received: by 2002:a05:6000:1290:: with SMTP id f16mr27369641wrx.298.1608687462473;
        Tue, 22 Dec 2020 17:37:42 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id d191sm28492563wmd.24.2020.12.22.17.37.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Dec 2020 17:37:41 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 00/20] make "mktag" use fsck_tag() & more
Date:   Wed, 23 Dec 2020 02:35:45 +0100
Message-Id: <20201223013606.7972-1-avarab@gmail.com>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8
In-Reply-To: <20201209200140.29425-1-avarab@gmail.com>
References: <20201209200140.29425-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

So, when re-rolling this with Junio's small fixup this grew in scope a
bit, but should paradoxically be easier to deal with even though it's
2x the size now. Read on:

Ævar Arnfjörð Bjarmason (20):
  mktag doc: say <hash> not <sha1>
  mktag doc: grammar fix, when exists -> when it exists
  mktag doc: update to explain why to use this
  mktag tests: don't needlessly use a subshell
  mktag tests: remove needless SHA-1 hardcoding
  mktag tests: improve verify_object() test coverage
  mktag tests: don't pipe to stderr needlessly
  mktag tests: don't create "mytag" twice
  mktag tests: stress test whitespace handling
  mktag tests: test "hash-object" compatibility

I re-arranged this series so the doc/test patches for existing
behavior all come first now. There's some new patches there (see
range-diff), but all rather easy-to review fixes or tests for existing
behavior.

  mktag: use default strbuf_read() hint
  mktag: remove redundant braces in one-line body "if"
  mktag: use puts(str) instead of printf("%s\n", str)

Trivial coding style changes, the puts() patch is new.

  mktag: use fsck instead of custom verify_tag()

Still the real meat of the series, unchanged in any meaningful way,
except in (as seen in the range-diff) carrying forward doc/test
changes made earlier.

  fsck: make fsck_config() re-usable
  mktag: allow turning off fsck.extraHeaderEntry

ditto unchanged.

  mktag: allow omitting the header/body \n separator

I discovered a regression in mktag in git since 2008 where it refuses
to accept input without an empty newline separating the body & message
in cases where there's no message.

Now we again accept the same input as hash-object, and with the new
"hash-object" test integration earlier in the series we're confident
that mktag & hash-object do the same thing in all these cases.

  mktag: convert to parse-options
  mktag: mark strings for translation
  mktag: add a --no-strict option

The #leftoverbits I suggested in v3 of converting to parse-options &
doing i18n for mktag, and finally supporting --no-strict so you can
make it behave like "fsck" does in its default mode.

 Documentation/git-hash-object.txt |   4 +
 Documentation/git-mktag.txt       |  42 +++++-
 builtin/fsck.c                    |  20 +--
 builtin/mktag.c                   | 235 +++++++++++-------------------
 fsck.c                            |  59 +++++++-
 fsck.h                            |  16 ++
 parse-options.h                   |   1 +
 t/t1006-cat-file.sh               |   2 +-
 t/t3800-mktag.sh                  | 211 +++++++++++++++++++++------
 9 files changed, 361 insertions(+), 229 deletions(-)

Range-diff:
 1:  aee3f52a47 =  1:  a31c305cfc mktag doc: say <hash> not <sha1>
 -:  ---------- >  2:  81cb4cba5c mktag doc: grammar fix, when exists -> when it exists
 8:  fa04664f7f !  3:  b4bc6f894c mktag doc: update to explain why to use this
    @@ Commit message
         documentation wouldn't have much of an idea what the difference
         was.
     
    -    Let's make it clear that it's to do with slightly different fsck
    -    validation logic, and cross-link the "mktag" and "hash-object"
    -    documentation to aid discover-ability.
    +    Let's allude to our own validation logic, and cross-link the "mktag"
    +    and "hash-object" documentation to aid discover-ability. A follow-up
    +    change to migrate "mktag" to use "fsck" validation will make the part
    +    about validation logic clearer.
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
    @@ Documentation/git-mktag.txt: SYNOPSIS
     +    git hash-object -t tag -w --stdin <my-tag
     +
     +The difference is that mktag will die before writing the tag if the
    -+tag doesn't pass a linkgit:git-fsck[1] check.
    -+
    -+The "fsck" check done mktag is is stricter than what
    -+linkgit:git-fsck[1] would run by default in that all `fsck.<msg-id>`
    -+messages are promoted from warnings to errors (so e.g. a missing
    -+"tagger" line is an error). Extra headers in the object are also an
    -+error under mktag, but ignored by linkgit:git-fsck[1].
    ++tag doesn't pass a sanity check.
      
      Tag Format
      ----------
 4:  1f06b9c0cf =  4:  acb94e0289 mktag tests: don't needlessly use a subshell
 5:  5d1cb73ca3 =  5:  4ae76ec5e3 mktag tests: remove needless SHA-1 hardcoding
 6:  cf86f4ca37 =  6:  9effb4532b mktag tests: improve verify_object() test coverage
 -:  ---------- >  7:  b81d31a917 mktag tests: don't pipe to stderr needlessly
 -:  ---------- >  8:  11f59718b4 mktag tests: don't create "mytag" twice
 -:  ---------- >  9:  dd6b012b0c mktag tests: stress test whitespace handling
 -:  ---------- > 10:  56c6b562fd mktag tests: test "hash-object" compatibility
 2:  6e98557709 = 11:  1e2e4ec269 mktag: use default strbuf_read() hint
 3:  8e5fe08f15 = 12:  be2ab3edab mktag: remove redundant braces in one-line body "if"
 -:  ---------- > 13:  d8514df970 mktag: use puts(str) instead of printf("%s\n", str)
 7:  5812ee53c9 ! 14:  346d73cc97 mktag: use fsck instead of custom verify_tag()
    @@ Commit message
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
    + ## Documentation/git-mktag.txt ##
    +@@ Documentation/git-mktag.txt: write a tag found in `my-tag`:
    +     git hash-object -t tag -w --stdin <my-tag
    + 
    + The difference is that mktag will die before writing the tag if the
    +-tag doesn't pass a sanity check.
    ++tag doesn't pass a linkgit:git-fsck[1] check.
    ++
    ++The "fsck" check done mktag is stricter than what linkgit:git-fsck[1]
    ++would run by default in that all `fsck.<msg-id>` messages are promoted
    ++from warnings to errors (so e.g. a missing "tagger" line is an error).
    ++
    ++Extra headers in the object are also an error under mktag, but ignored
    ++by linkgit:git-fsck[1]
    + 
    + Tag Format
    + ----------
    +
      ## builtin/mktag.c ##
     @@
      #include "tag.h"
    @@ builtin/mktag.c
     +
     +	buffer = read_object_file(tagged_oid, &type, &size);
     +	if (!buffer)
    -+		die("could not read tagged object '%s'\n",
    ++		die("could not read tagged object '%s'",
     +		    oid_to_hex(tagged_oid));
     +	if (type != *tagged_type)
    -+		die("object '%s' tagged as '%s', but is a '%s' type\n",
    ++		die("object '%s' tagged as '%s', but is a '%s' type",
     +		    oid_to_hex(tagged_oid),
     +		    type_name(*tagged_type), type_name(type));
     +
    @@ t/t3800-mktag.sh: tagger  <> 0 +0000
      
     -check_verify_failure 'disallow missing tag author name' \
     -	'^error: char.*: missing tagger name$'
    -+test_expect_success 'allow missing tag author name' '
    -+	git mktag <tag.sig
    -+'
    ++test_expect_mktag_success 'allow missing tag author name'
      
      ############################################################
      # 14. disallow missing tag author name
    @@ t/t3800-mktag.sh: tagger T A Gger <
      
      ############################################################
      # 15. allow empty tag email
    -@@ t/t3800-mktag.sh: test_expect_success \
    -     'git mktag <tag.sig >.git/refs/tags/mytag 2>message'
    +@@ t/t3800-mktag.sh: EOF
    + test_expect_mktag_success 'allow empty tag email'
      
      ############################################################
     -# 16. disallow spaces in tag email
    @@ t/t3800-mktag.sh: tagger T A Gger <tag ger@example.com> 0 +0000
      
     -check_verify_failure 'disallow spaces in tag email' \
     -	'^error: char.*: malformed tagger field$'
    -+test_expect_success 'allow spaces in tag email like fsck' '
    -+	git mktag <tag.sig
    -+'
    ++test_expect_mktag_success 'allow spaces in tag email like fsck'
      
      ############################################################
      # 17. disallow missing tag timestamp
    @@ t/t3800-mktag.sh: tagger T A Gger <tagger@example.com> 1206478233 -1430
      
     -check_verify_failure 'detect invalid tag timezone3' \
     -	'^error: char.*: malformed tag timezone$'
    -+test_expect_success 'allow invalid tag timezone' '
    -+	git mktag <tag.sig
    -+'
    ++test_expect_mktag_success 'allow invalid tag timezone'
      
      ############################################################
      # 23. detect invalid header entry
    @@ t/t3800-mktag.sh: this line should not be here
      check_verify_failure 'detect invalid header entry' \
     -	'^error: char.*: trailing garbage in tag header$'
     +	'^error:.* extraHeaderEntry:'
    -+
    -+cat >tag.sig <<EOF
    -+object $head
    -+type commit
    -+tag mytag
    -+tagger T A Gger <tagger@example.com> 1206478233 -0500
    -+
    -+
    -+this line comes after an extra newline
    -+EOF
    -+
    -+test_expect_success \
    -+    'allow extra newlines at start of body' \
    -+    'git mktag <tag.sig >.git/refs/tags/mytag 2>message'
    + 
    + cat >tag.sig <<EOF
    + object $head
    +@@ t/t3800-mktag.sh: tagger T A Gger <tagger@example.com> 1206478233 -0500$space
    + EOF
    + 
    + check_verify_failure 'extra whitespace at end of headers' \
    +-	'^error: char.*: malformed tag timezone$'
    ++	'^error:.* badTimezone:'
    + 
    + cat >tag.sig <<EOF
    + object $head
    +@@ t/t3800-mktag.sh: tagger T A Gger <tagger@example.com> 1206478233 -0500
    + EOF
    + 
    + check_verify_failure 'disallow no header / body newline separator' \
    +-	'^error: char.*: trailing garbage in tag header$'
    ++	'^error:.* extraHeaderEntry:'
      
      ############################################################
      # 24. create valid tag
 9:  30eff9170f = 15:  0e7994d8fc fsck: make fsck_config() re-usable
10:  11139ec2b8 ! 16:  5e8046022b mktag: allow turning off fsck.extraHeaderEntry
    @@ Commit message
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## Documentation/git-mktag.txt ##
    -@@ Documentation/git-mktag.txt: tag doesn't pass a linkgit:git-fsck[1] check.
    - The "fsck" check done mktag is is stricter than what
    - linkgit:git-fsck[1] would run by default in that all `fsck.<msg-id>`
    - messages are promoted from warnings to errors (so e.g. a missing
    --"tagger" line is an error). Extra headers in the object are also an
    --error under mktag, but ignored by linkgit:git-fsck[1].
    -+"tagger" line is an error).
    -+
    -+Extra headers in the object are also an error under mktag, but ignored
    +@@ Documentation/git-mktag.txt: would run by default in that all `fsck.<msg-id>` messages are promoted
    + from warnings to errors (so e.g. a missing "tagger" line is an error).
    + 
    + Extra headers in the object are also an error under mktag, but ignored
    +-by linkgit:git-fsck[1]
     +by linkgit:git-fsck[1]. This extra check can be turned off by setting
     +the appropriate `fsck.<msg-id>` varible:
     +
 -:  ---------- > 17:  32698e1d00 mktag: allow omitting the header/body \n separator
 -:  ---------- > 18:  b6a22f2f99 mktag: convert to parse-options
 -:  ---------- > 19:  7fc0b81df7 mktag: mark strings for translation
 -:  ---------- > 20:  6fa443d528 mktag: add a --no-strict option
-- 
2.29.2.222.g5d2a92d10f8

