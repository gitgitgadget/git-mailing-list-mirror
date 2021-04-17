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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F079C433B4
	for <git@archiver.kernel.org>; Sat, 17 Apr 2021 12:58:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EBD3561186
	for <git@archiver.kernel.org>; Sat, 17 Apr 2021 12:58:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236485AbhDQM7F (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 17 Apr 2021 08:59:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232844AbhDQM7E (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Apr 2021 08:59:04 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58840C061574
        for <git@vger.kernel.org>; Sat, 17 Apr 2021 05:58:38 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id a4so29271025wrr.2
        for <git@vger.kernel.org>; Sat, 17 Apr 2021 05:58:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DFGjdpTIlES42d/J1QakP9/AftjLayt4ICkgCxL2R/8=;
        b=kpmhpEU7lxW+OCATCbvvfr+HhvpHg4AhJVj2mtpVTNKmpgeDXLXBbZpzp9c0pXaAzM
         WMyI0cZ6pz3cdOCwx4r7057hO7ex7FK5QFBc8ZGZl4mi045658m9UgYPq2yZHkhFkSpe
         2UQ1D0PKDYvIxgRs/RX4YQbWVUG/mOKJ9ughCO0tTRxdyxI822IOGgJI7YC88aImHloV
         70VVX3ZAOy9O2aksV8IQkDXh9mCOJy8pMb68P91KRiEFi2NP2ZGb+tFh03ovD9HXMHrH
         mRH/JI4Yk63r20PSRWjivLEZ3FN/8z90yTGTIW7dbUCqrDPxLBCK/eMfKVAYniJPx1eF
         8J4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DFGjdpTIlES42d/J1QakP9/AftjLayt4ICkgCxL2R/8=;
        b=VMFdbmGAc9cgUg21q9JO+FRJGv1W8Febgl0JDOIy1aL5PcZs8N+Wmt2qvRpxSsVu87
         skGZaSJhU/sd9y9fQZq97PJtCoXMX2nEDL/cHJ1+CsnrUiHhmjRCOOhyT6rIulA+bBYt
         g8qVWCZPAhasQuNDYVNJJy0ig9zedf93w6vhyb9PoLdz+qeLISJCiCKKGK0qG3efCH9I
         lgD9OLqc4CBxS15/ftHrV470puk5QsVy/SQr7kIPZAAapjJCnMWnURO+ybL9lBKHzcQm
         mtNIoPgpwUO+g7EWK0sDeSpUJ6d3dIbSKe/IAphSLwDwoA5NSALW9waAnMOQYtzzswC/
         ZMfA==
X-Gm-Message-State: AOAM533GYVr5yGL5KeosBg4scPOn9AiEHHU5zYRISzZ0yLzx4StLONFC
        CZWRg69M4GhfWLgZoklNXDggSzApxcyMyA==
X-Google-Smtp-Source: ABdhPJwRsBRMwsEEA1Hvs/lONyTMJlviTlf8r0Z7Td1B3EaObZhlNzJyaYAQLevDOPlkUzPL5/chkQ==
X-Received: by 2002:a05:6000:128f:: with SMTP id f15mr4291625wrx.19.1618664316804;
        Sat, 17 Apr 2021 05:58:36 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id i12sm12452909wmd.3.2021.04.17.05.58.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Apr 2021 05:58:36 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Matthieu Moy <git@matthieu-moy.fr>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Andreas Schwab <schwab@linux-m68k.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 0/3] test-lib-functions.sh: trickery to make -x less verbose
Date:   Sat, 17 Apr 2021 14:58:24 +0200
Message-Id: <cover-0.3-00000000000-20210417T125539Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.723.g7084a9d5a2d
In-Reply-To: <cover-00.12-00000000000-20210417T124424Z-avarab@gmail.com>
References: <cover-00.12-00000000000-20210417T124424Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series makes the "-x" output less verbose for our various helper
functions, mainly using the trickery of feeding "$@" to "test" to rely
on it to die when given too many arguments.

It was split off from v2 of my larger test-lib.sh series as noted in
its CL:
https://lore.kernel.org/git/cover-00.12-00000000000-20210417T124424Z-avarab@gmail.com/

The range-diff below is to v1 of the relevant part of that series,
showing what's changed just for these commits.

Ævar Arnfjörð Bjarmason (3):
  test-lib-functions: normalize test_path_is_missing() debugging
  Revert and amend "test-lib-functions: assert correct parameter count"
  test-lib-functions: remove last two parameter count assertions

 t/test-lib-functions.sh | 64 +++++++++++++++--------------------------
 1 file changed, 23 insertions(+), 41 deletions(-)

Range-diff:
1:  0813aa8e34e = 1:  c22e3f7764f test-lib-functions: normalize test_path_is_missing() debugging
2:  b6e9d971b40 < -:  ----------- test-lib-functions: use "return 1" instead of "false"
3:  0cd511206c4 ! 2:  6f9e09a2017 Revert and amend "test-lib-functions: assert correct parameter count"
    @@ Commit message
         assert correct parameter count, 2021-02-12) in order to improve the -x
         output.
     
    -    When I added these BUG assertions in e7884b353b7 I missed that this
    -    made the -x output much more verbose.
    +    The goal here is to get rid of the verbosity of having e.g. a "test 2
    +    -ne 2" line for every "test_cmp". We use "$@" as an argument to "test"
    +    to intentionally feed the "test" operator too many arguments if the
    +    functions are called with too many arguments, thus piggy-backing on it
    +    to check the number of arguments we get.
     
    -    E.g. for each test_cmp invocation we'd now emit:
    +    Before this for each test_cmp invocation we'd emit:
     
             + test_cmp expect actual
             + test 2 -ne 2
             + eval diff -u "$@"
             + diff -u expect actual
     
    -    That "test 2 -ne 2" line is new in e7884b353b7. As noted in
    +    That "test 2 -ne 2" line is new in my e7884b353b7. As noted in
         45a2686441b (test-lib-functions: remove bug-inducing "diagnostics"
         helper param, 2021-02-12) we had buggy invocations of some of these
         functions with too many parameters.
     
    -    Let's instead use "$@" instead of "$1" to achieve the same ends with
    -    no extra -x output verbosity. The "test" operator will die with an
    -    error if given more than one argument in these contexts, so using "$@"
    -    achieves the same goal.
    +    Now we'll get just:
     
    -    The same goes for "cmp" and "diff -u" (which we typically use for
    -    test_cmp).
    +        + test_cmp expect actual
    +        + eval diff -u "$@"
    +        + diff -u expect actual
    +
    +    This does not to the "right" thing in cases like:
    +
    +        test_path_is_file x -a y
    +
    +    Which will now turn into:
    +
    +        test -f x -a y
    +
    +    I consider that to be OK given the trade-off that any extra checking
    +    would produce more verbose trace output. As shown in 45a2686441b we
    +    had issues with these functions being invoked with multiple
    +    parameters (e.g. a glob) by accident, we don't need to be paranoid in
    +    guarding against hostile misuse from our own test suite.
    +
    +    While I'm at it change a few functions that relied on a "false" being
    +    the last statement in the function to use an explicit "return 1" like
    +    the other functions in this file.
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
    @@ t/test-lib-functions.sh: test_external_without_stderr () {
     +	if ! test -f "$@"
      	then
     -		echo "File $1 doesn't exist"
    -+		echo "File $@ doesn't exist"
    - 		return 1
    +-		false
    ++		echo "File $* doesn't exist"
    ++		return 1
      	fi
      }
      
    @@ t/test-lib-functions.sh: test_external_without_stderr () {
     +	if ! test -d "$@"
      	then
     -		echo "Directory $1 doesn't exist"
    -+		echo "Directory $@ doesn't exist"
    - 		return 1
    +-		false
    ++		echo "Directory $* doesn't exist"
    ++		return 1
      	fi
      }
      
    @@ t/test-lib-functions.sh: test_external_without_stderr () {
     +	if ! test -e "$@"
      	then
     -		echo "Path $1 doesn't exist"
    -+		echo "Path $@ doesn't exist"
    - 		return 1
    +-		false
    ++		echo "Path $* doesn't exist"
    ++		return 1
      	fi
      }
      
    @@ t/test-lib-functions.sh: test_external_without_stderr () {
     +	if test -n "$(ls -a1 "$@" | egrep -v '^\.\.?$')"
      	then
     -		echo "Directory '$1' is not empty, it contains:"
    -+		echo "Directory '$@' is not empty, it contains:"
    ++		echo "Directory '$*' is not empty, it contains:"
      		ls -la "$1"
      		return 1
      	fi
    @@ t/test-lib-functions.sh: test_dir_is_empty () {
     +	if ! test -s "$@"
      	then
     -		echo "'$1' is not a non-empty file."
    -+		echo "'$@' is not a non-empty file."
    - 		return 1
    +-		false
    ++		echo "'$*' is not a non-empty file."
    ++		return 1
      	fi
      }
      
    @@ t/test-lib-functions.sh: test_dir_is_empty () {
     -	if test -e "$1"
     +	if test -e "$@"
      	then
    - 		echo "Path $1 exists!"
    +-		echo "Path $1 exists!"
    ++		echo "Path $* exists!"
      		false
    + 	fi
    + }
     @@ t/test-lib-functions.sh: test_expect_code () {
      # - not all diff versions understand "-u"
      
    @@ t/test-lib-functions.sh: verbose () {
      	then
     -		echo "'$1' is not empty, it contains:"
     -		cat "$1"
    -+		echo "'$@' is not empty, it contains:"
    ++		echo "'$*' is not empty, it contains:"
     +		cat "$@"
      		return 1
      	fi
4:  b4a018a63f3 ! 3:  b7b11a60bcd test-lib-functions: remove last two parameter count assertions
    @@ Metadata
      ## Commit message ##
         test-lib-functions: remove last two parameter count assertions
     
    -    Remove a couple of parameter count assertions where we'll now silently
    -    do the wrong thing if given too many parameters, unlike the "$@" cases
    -    in the preceding commit where "test" etc. handle the check for usi.
    +    Remove a couple of parameter count assertions where, unlike the
    +    preceding commit's migration to 'test -$x "$@"', we'll now silently do
    +    the "wrong" thing if given too many parameters. The benefit is less
    +    verbose trace output, as noted in the preceding commit.
     
         In the case of "test_file_size", the "test-tool" we're invoking is
         happy to accept N parameters (it'll print out all N sizes). Let's just
    -    use "$@" in that case anyway, there's only a few callers, and
    +    use "$@" in that case anyway. There's only a few callers, and
         eventually those should probably be moved to use the test-tool
         directly.
     
-- 
2.31.1.722.g788886f50a2

