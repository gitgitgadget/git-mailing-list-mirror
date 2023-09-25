Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8DF4CE7AB1
	for <git@archiver.kernel.org>; Mon, 25 Sep 2023 17:51:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230304AbjIYRvH (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Sep 2023 13:51:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229777AbjIYRvF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Sep 2023 13:51:05 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7F91101
        for <git@vger.kernel.org>; Mon, 25 Sep 2023 10:50:59 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1c60cec8041so18485445ad.3
        for <git@vger.kernel.org>; Mon, 25 Sep 2023 10:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695664259; x=1696269059; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SSp3DEU+kTW2cMCLA3quaqqo4I92+FKCOHCGaeMFdRc=;
        b=cTkqL7iPfOUz6+/5JYF3AJ0tBl7gnthNa/wpOYXtutwR63r/RzlzXufedM6D/+kuoJ
         rOMEHSXQ/kAov+JioP44amfNnnY9Gyn1S8+RULym+JxIy09oA8r8aGCvmFZkFdZmTDWK
         Wy9hQvuLXLYhv0BHqIokOcwwxjI6aNT87N3orvds/khQZa29vR+M4zp6YcVSP8JxjzLY
         nsVe9kCZ471pmneUmaU6qmnS3CqY34L++UBt7D6LChzkhjASjB797W0rCa/gPh0V2Giq
         GcUHYt75tnHYpdhDc9lBpy8FupNcSZkLAbS5LLPPS03dh7WMZrkCYcBkFhsikb7KjqcL
         R2LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695664259; x=1696269059;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SSp3DEU+kTW2cMCLA3quaqqo4I92+FKCOHCGaeMFdRc=;
        b=jWmnBFd3QFTsv3Gks535uixKfFhG1EscGOJWedfS+xqS7uVnyfMZzswFLEcQKU26Yd
         D7mZ8v/wdyH5xXH+dYqM56HEoJigR1pArsBKcwl+CegPSRBwYVSOKhI+dH2pHT5NGn32
         tDZdpPqkcbh3y66O24EGPSTg3HdDCQZxNtVSAxdAy8slA3XGX4IRIp/QJmtF13Lz7/Zv
         Zw5m44iPZvodJYP9pncjK07hBjyKUBJhgwZ0V8/O47dohg6SmtwsXIs/Wkdlirrr4/yS
         g/fxrynWgFPcVLuj3+HryA6gwAjZ8Y9YmJKCZm6OeZ45cXf3J94INHPGMHlxIzVYVKjc
         jJVg==
X-Gm-Message-State: AOJu0Yw1iMjcI8P5VdcXjbIWGFKSAjSgFJsmXJHfgWolOvtZbvIjFWTQ
        GS0T9gzcvYIJye9NZDs7wEs0lNYRdSA=
X-Google-Smtp-Source: AGHT+IG9w/i59Brpt0QQC3W93H7TNPMz6wPZEysrQVv168d1gbhwW4d9Kg0uKF0x/QwQ3zH95588EA==
X-Received: by 2002:a17:90b:3ec3:b0:274:8ed5:6b4d with SMTP id rm3-20020a17090b3ec300b002748ed56b4dmr4946387pjb.11.1695664258611;
        Mon, 25 Sep 2023 10:50:58 -0700 (PDT)
Received: from fivlite-virtual-machine.localdomain ([49.37.157.220])
        by smtp.gmail.com with ESMTPSA id gw7-20020a17090b0a4700b00273f65fa424sm8417874pjb.8.2023.09.25.10.50.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Sep 2023 10:50:58 -0700 (PDT)
From:   Kousik Sanagavarapu <five231003@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Kousik Sanagavarapu <five231003@gmail.com>
Subject: [PATCH v2 0/3] Add mailmap support to ref-filter
Date:   Mon, 25 Sep 2023 23:13:07 +0530
Message-ID: <20230925175050.3498-1-five231003@gmail.com>
X-Mailer: git-send-email 2.42.0.273.ge948a9aaf4
In-Reply-To: <20230920191654.6133-1-five231003@gmail.com>
References: <20230920191654.6133-1-five231003@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks Junio for review on the previous round.

PATCH 1/3 - Cleanup test_atom to be less error-prone

PATCH 2/3 - Fix hidden breakage

PATCH 3/3 - Unchanged

Kousik Sanagavarapu (3):
  t/t6300: cleanup test_atom
  t/t6300: introduce test_bad_atom
  ref-filter: add mailmap support

 Documentation/git-for-each-ref.txt |   6 +-
 ref-filter.c                       | 152 ++++++++++++++++++++++-------
 t/t6300-for-each-ref.sh            | 123 +++++++++++++++++++++--
 3 files changed, 239 insertions(+), 42 deletions(-)

Range-diff against v1:

-:  ---------- > 1:  b28e858e35 t/t6300: cleanup test_atom
1:  0a90b67889 ! 2:  ee90d017d5 t/t6300: introduce test_bad_atom()
    @@ Metadata
     Author: Kousik Sanagavarapu <five231003@gmail.com>

      ## Commit message ##
    -    t/t6300: introduce test_bad_atom()
    +    t/t6300: introduce test_bad_atom

    -    Introduce a new function "test_bad_atom()", which is similar to
    +    Introduce a new function "test_bad_atom", which is similar to
         "test_atom()" but should be used to check whether the correct error
         message is shown on stderr.

    -    Like "test_atom()", the new function takes three arguments. The three
    +    Like "test_atom", the new function takes three arguments. The three
         arguments specify the ref, the format and the expected error message
         respectively, with an optional fourth argument for tweaking
         "test_expect_*" (which is by default "success").
    @@ t/t6300-for-each-ref.sh: test_expect_success 'arguments to %(objectname:short=)
        test_must_fail git for-each-ref --format="%(objectname:short=foo)"
      '

    -+test_bad_atom() {
    ++test_bad_atom () {
     +  case "$1" in
     +  head) ref=refs/heads/main ;;
     +   tag) ref=refs/tags/testtag ;;
     +   sym) ref=refs/heads/sym ;;
     +     *) ref=$1 ;;
     +  esac
    -+  printf '%s\n' "$3">expect
    -+  test_expect_${4:-success} $PREREQ "err basic atom: $1 $2" "
    -+          test_must_fail git for-each-ref --format='%($2)' $ref 2>actual &&
    -+          test_cmp expect actual
    -+  "
    ++  format=$2
    ++  test_do=test_expect_${4:-success}
    ++
    ++  printf '%s\n' "$3" >expect
    ++  $test_do $PREREQ "err basic atom: $ref $format" '
    ++          test_must_fail git for-each-ref \
    ++                  --format="%($format)" "$ref" 2>error &&
    ++          test_cmp expect error
    ++  '
     +}
     +
     +test_bad_atom head 'authoremail:foo' \
     +  'fatal: unrecognized %(authoremail) argument: foo'
     +
     +test_bad_atom tag 'taggeremail:localpart trim' \
    -+  'fatal: unrecognized %(taggeremail) argument:  trim'
    ++  'fatal: unrecognized %(taggeremail) argument: localpart trim'
     +
      test_date () {
        f=$1 &&
2:  63fc69f4dc ! 3:  fdc14fe80b ref-filter: add mailmap support
    @@ t/t6300-for-each-ref.sh: test_atom tag '*objectname' $(git rev-parse refs/tags/t
      test_atom tag taggerdate 'Tue Jul 4 01:18:45 2006 +0200'
      test_atom tag creator 'C O Mitter <committer@example.com> 1151968725 +0200'
      test_atom tag creatordate 'Tue Jul 4 01:18:45 2006 +0200'
    -@@ t/t6300-for-each-ref.sh: test_bad_atom() {
    +@@ t/t6300-for-each-ref.sh: test_bad_atom () {
      test_bad_atom head 'authoremail:foo' \
        'fatal: unrecognized %(authoremail) argument: foo'

    @@ t/t6300-for-each-ref.sh: test_bad_atom() {
     +  'fatal: unrecognized %(taggeremail) argument: ;localpart trim'
     +
      test_bad_atom tag 'taggeremail:localpart trim' \
    -   'fatal: unrecognized %(taggeremail) argument:  trim'
    -
    +-  'fatal: unrecognized %(taggeremail) argument: localpart trim'
    ++  'fatal: unrecognized %(taggeremail) argument:  trim'
    ++
     +test_bad_atom tag 'taggeremail:mailmap,mailmap,trim,qux,localpart,trim' \
     +  'fatal: unrecognized %(taggeremail) argument: qux,localpart,trim'
    -+
    +
      test_date () {
        f=$1 &&
    -   committer_date=$2 &&

-- 
2.42.0.273.ge948a9aaf4

