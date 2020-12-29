Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97C64C433DB
	for <git@archiver.kernel.org>; Tue, 29 Dec 2020 17:09:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4AEB921D94
	for <git@archiver.kernel.org>; Tue, 29 Dec 2020 17:09:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726158AbgL2RJV (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Dec 2020 12:09:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726111AbgL2RJV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Dec 2020 12:09:21 -0500
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBA99C061574
        for <git@vger.kernel.org>; Tue, 29 Dec 2020 09:08:40 -0800 (PST)
Received: by mail-ot1-x331.google.com with SMTP id j12so12339621ota.7
        for <git@vger.kernel.org>; Tue, 29 Dec 2020 09:08:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2GLFdJTp6NeA6G5chqRIuL2DQZxXVuiNlE13uI9leYY=;
        b=fUOF6VWTdayRj1ckkdAiKoH00wFe03lHEHuJPC/1KoHuNyXbcdmFZUyTNHOHiWhrLF
         B6+dDip0Ze6ZgykIL3cA3JF33K3RpkgSYXQw9jRux7gLhLgV5yIeMo6krQeiZJ15CWaZ
         OWHGU7mea1IRiRWWmP7sq8/tAqGXMOI56yMP44xanojeO4qSinKPvZolUVYNz4B229Zr
         RL6AkyFktyDaydTzvyg5NWtnWH8T1RzfUhWiuhego4s4f/IjY9ZYnUe00dKvQC7Zf+NE
         +QSLQIUr7XVUeJH98MniaFHYkqGdWlewMaVMcQr6kqQgwX0iEby27DJ9PmB0/dAVzQKu
         vdig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2GLFdJTp6NeA6G5chqRIuL2DQZxXVuiNlE13uI9leYY=;
        b=I6yDVobVK3KrbuGjLLzC4fLjL8/jz/M6OhTclmBt6mVc9f25OjBXpLdwVtkrB3A2Kv
         BbhO/HdQ8j31B3QUvOFP4TsRHUB76LXai3goZNuXDcT+QnB4ZmcfWcFORtz/piYbNU2U
         ZHabLe4+l5Ro0shKj6q/zL3cmBUg8a83ChdjVFYfFFE/G/TM4qlQTQcUZKiYyhQRS/8D
         PNDy3cJsTgJPdQvY1/PNgpV08fmUw/EAR08J9K/uEtiNGv8/BSU8IpaqHcguiMeNG4Aa
         E8APIXXOKlcrdNoXGyGznFdJ8r/Lyujcdyf9tduwy1L8uT8l87XI6gNoqIqMHzFr80f+
         rG3Q==
X-Gm-Message-State: AOAM530GKtZe0hQfjliQj+iruMBp3MkYVQTwPE8/pEIIynDT8LUJRPBW
        x12dDKEBG/Sui8uaAnU6IxzWr/jSE8MfTQ==
X-Google-Smtp-Source: ABdhPJxsNiJarhgGSYThq5AZnYIPsjYv6NQkCp9XzUlwJynyxLH8EsSu/zl5MBOXBMUKCRoebIKQXA==
X-Received: by 2002:a9d:745a:: with SMTP id p26mr37629133otk.206.1609261719898;
        Tue, 29 Dec 2020 09:08:39 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id j126sm9837538oib.13.2020.12.29.09.08.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Dec 2020 09:08:39 -0800 (PST)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 0/3] completion: make __git_complete public
Date:   Tue, 29 Dec 2020 11:08:34 -0600
Message-Id: <20201229170837.297857-1-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Back in 2012 I argued [1] for the introduction of a helper that would
allow users to specify aliases like:

  git_complete gf git_fetch

There was pushback because there was no clear guideline for public
functions (git_complete vs. _git_complete vs. _GIT_complete), and some
aliases didn't actually work.

Fast-forward to 2020, and there's still no guideline for public
functions, and those aliases still don't work (even though I sent the
fixes).

This has not prevented people from using this function that is clearly
needed to setup custom aliases [2], and in fact that's the recommended
way since there's no other.

But it is cumbersome that the user must type:

  __git_complete gf _git_fetch

Or worse:

  __git_complete gk __gitk_main

8 years is more than enough time to stop waiting for the perfect to
come; let's define a public function (with the same name) that is
actually user-friendly:

  __git_complete gf git_fetch
  __git_complete gk gitk

While also maintaining backwards compatibility.

[1] https://lore.kernel.org/git/1334524814-13581-1-git-send-email-felipe.contreras@gmail.com/
[2] https://stackoverflow.com/questions/342969/how-do-i-get-bash-completion-to-work-with-aliases

Felipe Contreras (3):
  completion: bash: add __git_have_func helper
  test: completion: add tests for __git_complete
  completion: add proper public __git_complete

 contrib/completion/git-completion.bash | 41 +++++++++++++++++++-------
 t/t9902-completion.sh                  | 20 +++++++++++++
 2 files changed, 51 insertions(+), 10 deletions(-)

Range-diff:
-:  ---------- > 1:  0993732142 completion: bash: add __git_have_func helper
1:  ea77b1a140 ! 2:  7918c34d0e test: completion: add tests for __git_complete
    @@ Metadata
      ## Commit message ##
         test: completion: add tests for __git_complete
     
    +    Even though the function was marked as not public, it's already used in
    +    the wild.
    +
    +    We should at least test basic functionality.
    +
         Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
     
      ## t/t9902-completion.sh ##
    @@ t/t9902-completion.sh: test_expect_success 'sourcing the completion script clear
      '
      
     +test_expect_success '__git_complete' '
    ++	unset -f __git_wrap__git_main &&
     +	__git_complete foo __git_main &&
    -+	test "$(type -t __git_wrap__git_main)" == function &&
    ++	__git_have_func __git_wrap__git_main &&
     +	__git_complete gf _git_fetch &&
    -+	test "$(type -t __git_wrap_git_fetch)" == function
    ++	__git_have_func __git_wrap_git_fetch
     +'
     +
      test_done
2:  aec19e61ee ! 3:  8a6cc52063 completion: add proper public __git_complete
    @@ Metadata
      ## Commit message ##
         completion: add proper public __git_complete
     
    -    Back in 2012 I argued [1] for the introduction of a helper that would
    -    allow users to specify aliases like:
    +    When __git_complete was introduced, it was meant to be temporarily, while
    +    a proper guideline for public shell functions was established
    +    (tentatively _GIT_complete), but since that never happened, people
    +    in the wild started to use __git_complete, even though it was marked as
    +    not public.
     
    -      git_complete gf git_fetch
    +    Eight years is more than enough wait, let's mark this function as
    +    public, and make it a bit more user-friendly.
     
    -    Back then there was pushback because there was no clear guideline for
    -    public functions (git_complete vs _git_complete vs _GIT_complete), and
    -    some aliases didn't actually work.
    -
    -    Fast-forward to 2020 and there's still no guideline for public
    -    functions, and those aliases still don't work (even though I sent the
    -    fixes).
    -
    -    This has not prevented people from using this function that is clearly
    -    needed to setup custom aliases [2], and in fact it's the recommended
    -    way. But it is cumbersome that the user must type:
    -
    -      __git_complete gf _git_fetch
    -
    -    Or worse:
    +    So that instead of doing:
     
           __git_complete gk __gitk_main
     
    -    8 years is more than enough time to stop waiting for the perfect to
    -    come; let's define a public function (with the same name) that is
    -    actually user-friendly:
    +    The user can do:
     
    -      __git_complete gf git_fetch
           __git_complete gk gitk
     
    -    While also maintaining backwards compatibility.
    +    And instead of:
     
    -    The logic is:
    +      __git_complete gf _git_fetch
    +
    +    Do:
     
    -     1. If $2 exists, use it directly
    -     2. If not, check if __$2_main exists
    -     3. If not, check if _$2 exists
    -     4. If not, fail
    +      __git_complete gf git_fetch
     
    -    [1] https://lore.kernel.org/git/1334524814-13581-1-git-send-email-felipe.contreras@gmail.com/
    -    [2] https://stackoverflow.com/questions/342969/how-do-i-get-bash-completion-to-work-with-aliases
    +    Backwards compatibility is maintained.
     
         Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
     
    @@ contrib/completion/git-completion.bash: __git_complete ()
     +{
     +	local func
     +
    -+	if [[ "$(type -t $2)" == function ]]; then
    ++	if __git_have_func $2; then
     +		func=$2
    -+	elif [[ "$(type -t __$2_main)" == function ]]; then
    ++	elif __git_have_func __$2_main; then
     +		func=__$2_main
    -+	elif [[ "$(type -t _$2)" == function ]]; then
    ++	elif __git_have_func _$2; then
     +		func=_$2
     +	else
     +		echo "ERROR: could not find function '$2'" 1>&2
    @@ contrib/completion/git-completion.bash: __git_complete ()
     
      ## t/t9902-completion.sh ##
     @@ t/t9902-completion.sh: test_expect_success 'sourcing the completion script clears cached --options' '
    - '
      
      test_expect_success '__git_complete' '
    -+	unset -f __git_wrap__git_main &&
    + 	unset -f __git_wrap__git_main &&
     +
      	__git_complete foo __git_main &&
    - 	test "$(type -t __git_wrap__git_main)" == function &&
    + 	__git_have_func __git_wrap__git_main &&
     +	unset -f __git_wrap__git_main &&
     +
      	__git_complete gf _git_fetch &&
    --	test "$(type -t __git_wrap_git_fetch)" == function
    -+	test "$(type -t __git_wrap_git_fetch)" == function &&
    +-	__git_have_func __git_wrap_git_fetch
    ++	__git_have_func __git_wrap_git_fetch &&
     +
     +	__git_complete foo git &&
    -+	test "$(type -t __git_wrap__git_main)" == function &&
    ++	__git_have_func __git_wrap__git_main &&
     +	unset -f __git_wrap__git_main &&
     +
     +	__git_complete gd git_diff &&
    -+	test "$(type -t __git_wrap_git_diff)" == function &&
    ++	__git_have_func __git_wrap_git_diff &&
     +
     +	test_must_fail __git_complete ga missing
      '
-- 
2.30.0

