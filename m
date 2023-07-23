Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F110C001B0
	for <git@archiver.kernel.org>; Sun, 23 Jul 2023 16:28:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229625AbjGWQ2d (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 23 Jul 2023 12:28:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjGWQ2c (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 23 Jul 2023 12:28:32 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02D5A10CF
        for <git@vger.kernel.org>; Sun, 23 Jul 2023 09:27:56 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1b9e93a538dso18314615ad.3
        for <git@vger.kernel.org>; Sun, 23 Jul 2023 09:27:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690129656; x=1690734456;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ftZVNmj5b+8na47uT+6jfTKaV4jW5QcFA6V+KL08SIg=;
        b=pbD4TsOB7RpIdrhtPPK6dESA6/Fg/lSqUPvL0hDeyX/zsukYKKjwrh+sF1Olkax5Py
         ri8dUK6QF0e+DRpW9g1TTLS05k5332KPznjnEpSx16KZrlOBuonZj6HxTzHXYJJT1n9U
         VNa2rcYAhe/8lYpRd1YWlePhY1wWeVs5umUwERb+Fpp9lFA3A2mI7zCTjIgPOrYW14vU
         TxNauT7fQEm9mCTnmr92tLZIeP9StkbPq1DvHL7FKdzcMb2auq3e/rhbZQ09I/p39nJ6
         oSXuNsH6Ur+Ch3xqB2MyRzjKkNgPVzhisvG8skr6MVw/sZ3wODeRG7sZ6c6/+ZHVIljx
         4ywQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690129656; x=1690734456;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ftZVNmj5b+8na47uT+6jfTKaV4jW5QcFA6V+KL08SIg=;
        b=VuwLfQIbvqhAcMz+J4cGwLuXixHRU5Cb+2rPgL9uqKK106N3no5bM4RJCV/KkCkk43
         R4qg7TkxXu5Ka2Y+elpB94eSy/VIbuVnoWTNg0B6NMJmDDUg6GbiZ3MFmzC8YVXtLQ03
         poADNeox2YxhqkkBXzsoMc9/UW9+MiI0JPWo8jeEQ3+tGWBapiU7GXzUDNJYEsbRRi+d
         YOdNS1ZsoqTZu7dZHhl5aGcfmCTDCcHcVeC8VbO7bQtDldfNyOpxmFiUL7bcalncTTuJ
         QNqTzhUyniszfbZYxSu7gG6QfiBvdDKjNnRAlG0to3Jj5Td6UH+2+SbeDcSo47uOOe8r
         TVYA==
X-Gm-Message-State: ABy/qLbOzThFFg5k5fNMkBW2cK14jXrF0QPXmxjbJcV2odvHNw5/KhpN
        Ea/GlrSQtOh6UKZa4tt9Rd5yW1Vvfwbl5e1s
X-Google-Smtp-Source: APBJJlGGUGYJXNLbMkwmTfeIdGqIK3crVImEPQgT57BPEDAjD7xqejWTztMbALIEFeSWyMVw0cGMZg==
X-Received: by 2002:a17:902:f54b:b0:1bb:a367:a70 with SMTP id h11-20020a170902f54b00b001bba3670a70mr751474plf.17.1690129655623;
        Sun, 23 Jul 2023 09:27:35 -0700 (PDT)
Received: from fivlite-virtual-machine.localdomain ([49.37.157.197])
        by smtp.gmail.com with ESMTPSA id ju4-20020a170903428400b001b392bf9192sm7121847plb.145.2023.07.23.09.27.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jul 2023 09:27:35 -0700 (PDT)
From:   Kousik Sanagavarapu <five231003@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Josh Steadmon <steadmon@google.com>,
        Siddharth Singh <siddhartth@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>,
        Kousik Sanagavarapu <five231003@gmail.com>
Subject: [PATCH v4 0/2] Add new "describe" atom
Date:   Sun, 23 Jul 2023 21:49:57 +0530
Message-ID: <20230723162717.68123-1-five231003@gmail.com>
X-Mailer: git-send-email 2.41.0.396.g9ab76b0018
In-Reply-To: <20230719162424.70781-1-five231003@gmail.com>
References: <20230719162424.70781-1-five231003@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,
Thanks for the review on the previous version.

PATCH 1/2 - Added comments to explain what the helper functions do and
	    also fixed a nit where config.h should be included
	    here and not the subsequent commit.

PATCH 2/2 - Changed the formatting on Documentation to follow what was
	    in the file. Also, the statement
		
		"Descriptions can be insconsistent when tags are added
		or removed at the same time"

	    is not true in ref-filter's case as,

		$ time git for-each-ref --format="%(describe)" refs/		    
		real	0m19.936s
		user	0m11.488s
		sys	0m7.915s


		$ time git for-each-ref --format="%(describe) %(describe)" refs/	
		real	0m19.502s
		user	0m11.653s
		sys	0m7.623s

	    I also added a test to check that we err on bad describe
	    args.

Kousik Sanagavarapu (2):
  ref-filter: add multiple-option parsing functions
  ref-filter: add new "describe" atom

 Documentation/git-for-each-ref.txt |  23 +++
 ref-filter.c                       | 230 +++++++++++++++++++++++++++++
 t/t6300-for-each-ref.sh            | 138 +++++++++++++++++
 3 files changed, 391 insertions(+)

Range-diff against v3:

1:  08f3be1631 ! 1:  2914bd58ec ref-filter: add multiple-option parsing functions
    @@ Commit message
         are going to add a new %(describe) atom in a subsequent commit where we
         parse options like tags=<bool-value> or match=<pattern> given to it.
     
    +    Helped-by: Junio C Hamano <gitster@pobox.com>
         Mentored-by: Christian Couder <christian.couder@gmail.com>
         Mentored-by: Hariom Verma <hariom18599@gmail.com>
         Signed-off-by: Kousik Sanagavarapu <five231003@gmail.com>
     
      ## ref-filter.c ##
    +@@
    + #include "git-compat-util.h"
    + #include "environment.h"
    + #include "gettext.h"
    ++#include "config.h"
    + #include "gpg-interface.h"
    + #include "hex.h"
    + #include "parse-options.h"
     @@ ref-filter.c: static int err_bad_arg(struct strbuf *sb, const char *name, const char *arg)
        return -1;
      }
      
    ++/*
    ++ * Parse option of name "candidate" in the option string "to_parse" of
    ++ * the form
    ++ *
    ++ *        "candidate1[=val1],candidate2[=val2],candidate3[=val3],..."
    ++ *
    ++ * The remaining part of "to_parse" is stored in "end" (if we are
    ++ * parsing the last candidate, then this is NULL) and the value of
    ++ * the candidate is stored in "valuestart" and its length in "valuelen",
    ++ * that is the portion after "=". Since it is possible for a "candidate"
    ++ * to not have a value, in such cases, "valuestart" is set to point to
    ++ * NULL and "valuelen" to 0.
    ++ *
    ++ * The function returns 1 on success. It returns 0 if we don't find
    ++ * "candidate" in "to_parse" or we find "candidate" but it is followed
    ++ * by more chars (for example, "candidatefoo"), that is, we don't find
    ++ * an exact match.
    ++ *
    ++ * This function only does the above for one "candidate" at a time. So
    ++ * it has to be called each time trying to parse a "candidate" in the
    ++ * option string "to_parse".
    ++ */
     +static int match_atom_arg_value(const char *to_parse, const char *candidate,
     +                          const char **end, const char **valuestart,
     +                          size_t *valuelen)
     +{
     +  const char *atom;
     +
    -+  if (!(skip_prefix(to_parse, candidate, &atom)))
    ++  if (!skip_prefix(to_parse, candidate, &atom))
    ++          return 0; /* definitely not "candidate" */
    ++
    ++  if (*atom == '=') {
    ++          /* we just saw "candidate=" */
    ++          *valuestart = atom + 1;
    ++          atom = strchrnul(*valuestart, ',');
    ++          *valuelen = atom - *valuestart;
    ++  } else if (*atom != ',' && *atom != '\0') {
    ++          /* key begins with "candidate" but has more chars */
     +          return 0;
    -+  if (valuestart) {
    -+          if (*atom == '=') {
    -+                  *valuestart = atom + 1;
    -+                  *valuelen = strcspn(*valuestart, ",\0");
    -+                  atom = *valuestart + *valuelen;
    -+          } else {
    -+                  if (*atom != ',' && *atom != '\0')
    -+                          return 0;
    -+                  *valuestart = NULL;
    -+                  *valuelen = 0;
    -+          }
    -+  }
    -+  if (*atom == ',') {
    -+          *end = atom + 1;
    -+          return 1;
    -+  }
    -+  if (*atom == '\0') {
    -+          *end = atom;
    -+          return 1;
    ++  } else {
    ++          /* just "candidate" without "=val" */
    ++          *valuestart = NULL;
    ++          *valuelen = 0;
     +  }
    -+  return 0;
    ++
    ++  /* atom points at either the ',' or NUL after this key[=val] */
    ++  if (*atom == ',')
    ++          atom++;
    ++  else if (*atom)
    ++          BUG("Why is *atom not NULL yet?");
    ++
    ++  *end = atom;
    ++  return 1;
     +}
     +
    ++/*
    ++ * Parse boolean option of name "candidate" in the option list "to_parse"
    ++ * of the form
    ++ *
    ++ *        "candidate1[=bool1],candidate2[=bool2],candidate3[=bool3],..."
    ++ *
    ++ * The remaining part of "to_parse" is stored in "end" (if we are parsing
    ++ * the last candidate, then this is NULL) and the value (if given) is
    ++ * parsed and stored in "val", so "val" always points to either 0 or 1.
    ++ * If the value is not given, then "val" is set to point to 1.
    ++ *
    ++ * The boolean value is parsed using "git_parse_maybe_bool()", so the
    ++ * accepted values are
    ++ *
    ++ *        to set true  - "1", "yes", "true"
    ++ *        to set false - "0", "no", "false"
    ++ *
    ++ * This function returns 1 on success. It returns 0 when we don't find
    ++ * an exact match for "candidate" or when the boolean value given is
    ++ * not valid.
    ++ */
     +static int match_atom_bool_arg(const char *to_parse, const char *candidate,
     +                          const char **end, int *val)
     +{
2:  742a79113c ! 2:  77a2a56520 ref-filter: add new "describe" atom
    @@ Commit message
         The new atom "describe" and its friends are equivalent to the existing
         pretty formats with the same name.
     
    +    Helped-by: Junio C Hamano <gitster@pobox.com>
         Mentored-by: Christian Couder <christian.couder@gmail.com>
         Mentored-by: Hariom Verma <hariom18599@gmail.com>
         Signed-off-by: Kousik Sanagavarapu <five231003@gmail.com>
    @@ Documentation/git-for-each-ref.txt: ahead-behind:<committish>::
        commits ahead and behind, respectively, when comparing the output
        ref to the `<committish>` specified in the format.
      
    -+describe[:options]:: Human-readable name, like
    -+               link-git:git-describe[1]; empty string for
    -+               undescribable commits. The `describe` string may be
    -+               followed by a colon and zero or more comma-separated
    -+               options. Descriptions can be inconsistent when tags
    -+               are added or removed at the same time.
    ++describe[:options]::
    ++  A human-readable name, like linkgit:git-describe[1];
    ++  empty string for undescribable commits. The `describe` string may
    ++  be followed by a colon and one or more comma-separated options.
     ++
     +--
    -+tags=<bool-value>;; Instead of only considering annotated tags, consider
    -+              lightweight tags as well; see the corresponding option
    -+              in linkgit:git-describe[1] for details.
    -+abbrev=<number>;; Use at least <number> hexadecimal digits; see
    -+            the corresponding option in linkgit:git-describe[1]
    -+            for details.
    -+match=<pattern>;; Only consider tags matching the given `glob(7)` pattern,
    -+            excluding the "refs/tags/" prefix; see the corresponding
    -+            option in linkgit:git-describe[1] for details.
    -+exclude=<pattern>;; Do not consider tags matching the given `glob(7)`
    -+              pattern, excluding the "refs/tags/" prefix; see the
    -+              corresponding option in linkgit:git-describe[1] for
    -+              details.
    ++tags=<bool-value>;;
    ++  Instead of only considering annotated tags, consider
    ++  lightweight tags as well; see the corresponding option in
    ++  linkgit:git-describe[1] for details.
    ++abbrev=<number>;;
    ++  Use at least <number> hexadecimal digits; see the corresponding
    ++  option in linkgit:git-describe[1] for details.
    ++match=<pattern>;;
    ++  Only consider tags matching the given `glob(7)` pattern,
    ++  excluding the "refs/tags/" prefix; see the corresponding option
    ++  in linkgit:git-describe[1] for details.
    ++exclude=<pattern>;;
    ++  Do not consider tags matching the given `glob(7)` pattern,
    ++  excluding the "refs/tags/" prefix; see the corresponding option
    ++  in linkgit:git-describe[1] for details.
     +--
     +
      In addition to the above, for commit and tag objects, the header
    @@ Documentation/git-for-each-ref.txt: ahead-behind:<committish>::
     
      ## ref-filter.c ##
     @@
    - #include "git-compat-util.h"
    - #include "environment.h"
    - #include "gettext.h"
    -+#include "config.h"
      #include "gpg-interface.h"
      #include "hex.h"
      #include "parse-options.h"
    @@ ref-filter.c: static int contents_atom_parser(struct ref_format *format, struct
     +
     +  for (;;) {
     +          int found = 0;
    -+          const char *bad_arg = NULL;
    ++          const char *bad_arg = arg;
     +
     +          if (!arg || !*arg)
     +                  break;
     +
    -+          bad_arg = arg;
     +          found = describe_atom_option_parser(&args, &arg, err);
     +          if (found < 0)
     +                  return found;
    -+          if (!found) {
    -+                  if (bad_arg && *bad_arg)
    -+                          return err_bad_arg(err, "describe", bad_arg);
    -+                  break;
    -+          }
    ++          if (!found)
    ++                  return err_bad_arg(err, "describe", bad_arg);
     +  }
     +  atom->u.describe_args = strvec_detach(&args);
     +  return 0;
    @@ t/t6300-for-each-ref.sh: test_expect_success 'color.ui=always does not override
      '
      
     +test_expect_success 'setup for describe atom tests' '
    -+  git init describe-repo &&
    ++  git init -b master describe-repo &&
     +  (
     +          cd describe-repo &&
     +
    @@ t/t6300-for-each-ref.sh: test_expect_success 'color.ui=always does not override
     +          test_cmp expect actual
     +  )
     +'
    ++
    ++test_expect_success 'err on bad describe atom arg' '
    ++  (
    ++          cd describe-repo &&
    ++
    ++          # The bad arg is the only arg passed to describe atom
    ++          cat >expect <<-\EOF &&
    ++          fatal: unrecognized %(describe) argument: baz
    ++          EOF
    ++          ! git for-each-ref --format="%(describe:baz)" \
    ++                  refs/heads/master 2>actual &&
    ++          test_cmp expect actual &&
    ++
    ++          # The bad arg is in the middle of the option string
    ++          # passed to the describe atom
    ++          cat >expect <<-\EOF &&
    ++          fatal: unrecognized %(describe) argument: qux=1,abbrev=14
    ++          EOF
    ++          ! git for-each-ref \
    ++                  --format="%(describe:tags,qux=1,abbrev=14)" \
    ++                  ref/heads/master 2>actual &&
    ++          test_cmp expect actual
    ++  )
    ++'
     +
      cat >expected <<\EOF
      heads/main

-- 
2.41.0.396.g9ab76b0018

