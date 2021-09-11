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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86D82C433EF
	for <git@archiver.kernel.org>; Sat, 11 Sep 2021 11:21:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5692E611F2
	for <git@archiver.kernel.org>; Sat, 11 Sep 2021 11:21:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233746AbhIKLTK (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 11 Sep 2021 07:19:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230249AbhIKLTH (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Sep 2021 07:19:07 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D3A5C061574
        for <git@vger.kernel.org>; Sat, 11 Sep 2021 04:17:55 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id u16so6505469wrn.5
        for <git@vger.kernel.org>; Sat, 11 Sep 2021 04:17:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XACBjvF0uYX2PFfavlC935U9PQzs7uJYDsUx062BHVg=;
        b=klBOmaemWZYnlaHn7hKIx+HWGsh6UukdpRpeHRWAWdjHLoqwijAR0yW3cMf7E2J7cI
         0pFt3sxFsceXi1Y55uBDXIUQ/hk/5KtsGIPjPEbc5XGAYttNG5dG9trBTyCzcIPTy6VC
         C2/YzTvYw8yIhKb6iRmyjUJ+1Ykc82C3bp77bLCh1+UWJaBffPUCJ/dGBcFud778r4l5
         r0E7TPUQ33cQguPpMxb527AMOQK5aHHszv4r+U4Nq4f+c5T7Zv6cLQOxmZXgcnXEOUIY
         gVtGUMU1iTsynEfYv6hvWEGGCvHw4rePJIXteNi/cAS9uT06XCHt9esSb82USiGJnQio
         0LIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XACBjvF0uYX2PFfavlC935U9PQzs7uJYDsUx062BHVg=;
        b=ee91Gz1jVW35954P6V5ehpLd90F9XwwqJWfkQyQnjlH2QM/Z/Njs+C23klKGF3lIJu
         nL29XxAaqwXBwJT4cgSdAhTU2+rGvc1y8K9KghfODe4Rat8xqftgbEgqrVQIeKfYNars
         yHkquTba+vyKfmYOKM4Tia5G7F2+ytT8m+ZJ8b+gvnyUAyzON5S1AssGM4Dw9TO2injz
         jE5C/x7tRRv6blQbQrgI2dBrB2LmbBR3/Ag6C09YryOT5hriuQZu2tU2jIC4fjbx0xCZ
         DYDbtHL5DqC691sH22t3NhXQxf5uC7DNqJilhg8zjiLrHcd93g0kZKXxxjCi3ZMF0/vB
         8+LQ==
X-Gm-Message-State: AOAM532/N5tzHUHik/vl5SqOTPEak50FWZ3JRVJSxPnSDz31S29+Inwf
        Ds06hV1+lvSDF1h3T393oYSPOVZD1k7/UQ==
X-Google-Smtp-Source: ABdhPJw3MUP3OTST49PtEYkpdZUqHLQDx075f2hMLzf0ahbxBpAKDzk0tZrtsnfVl9GfHqBQimMa8w==
X-Received: by 2002:adf:fb49:: with SMTP id c9mr2713818wrs.44.1631359073529;
        Sat, 11 Sep 2021 04:17:53 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id p5sm1549731wrd.25.2021.09.11.04.17.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Sep 2021 04:17:52 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Eric Wong <e@80x24.org>, Prathamesh Chavan <pc44800@gmail.com>,
        Peter Baumann <peter.baumann@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Andrei Rybak <rybak.a.v@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 0/4] remove dead & internal-only shell code
Date:   Sat, 11 Sep 2021 13:17:47 +0200
Message-Id: <cover-v3-0.4-00000000000-20210911T111435Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.984.gea2c3555113
In-Reply-To: <cover-v2-0.7-00000000000-20210906T070201Z-avarab@gmail.com>
References: <cover-v2-0.7-00000000000-20210906T070201Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Per the discussion on v1 and v2 I've reduced the size of this series
to only those changes that should be uncontroversial to remove, even
by the harshest standards of maintaining compatibility with
out-of-tree users of undocumented functions in git's shell libraries.

Now we remove is_zero_oid() from git-submodule.sh, but not the
sane_egrep() from git-sh-setup.sh, git_pager() also stays, so does
peel_committish() and clear_local_git_env().

I think we can keep 2/4 ad remove the "pull with rebase" message,
since as noted there the worst case is that someone will lose only
that part of their translation.

And finally, the 3/4 and 4/4 are the same cleanups of internal-only or
test-only OID-matching variables as before.

Ævar Arnfjörð Bjarmason (4):
  git-submodule: remove unused is_zero_oid() function
  git-sh-setup: remove unused "pull with rebase" message
  git-bisect: remove unused SHA-1 $x40 shell variable
  test-lib: remove unused $_x40 and $_z40 variables

 git-bisect.sh    | 2 --
 git-sh-setup.sh  | 6 ------
 git-submodule.sh | 5 -----
 t/test-lib.sh    | 6 ++----
 4 files changed, 2 insertions(+), 17 deletions(-)

Range-diff against v2:
1:  8eb1dfbff5d < -:  ----------- git-sh-setup: remove unused git_pager() function
2:  e7f3115797c ! 1:  62b3a5881c9 git-sh-setup: remove unused sane_egrep() function
    @@ Metadata
     Author: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## Commit message ##
    -    git-sh-setup: remove unused sane_egrep() function
    +    git-submodule: remove unused is_zero_oid() function
     
         The is_zero_oid() function in git-submodule.sh has not been used since
         e83e3333b57 (submodule: port submodule subcommand 'summary' from shell
    -    to C, 2020-08-13), so we can remove it, and the sane_egrep() function,
    -    dead is_zero_oid() was the only function which still referenced it.
    +    to C, 2020-08-13), so we can remove it.
     
    -    Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
    +    This was the last user of the sane_egrep() function in
    +    git-sh-setup.sh. I'm not removing it in case some out-of-tree user
    +    relied on it. Per the discussion that can be found upthread of [1].
     
    - ## git-sh-setup.sh ##
    -@@ git-sh-setup.sh: sane_grep () {
    - 	GREP_OPTIONS= LC_ALL=C grep @@SANE_TEXT_GREP@@ "$@"
    - }
    - 
    --sane_egrep () {
    --	GREP_OPTIONS= LC_ALL=C egrep @@SANE_TEXT_GREP@@ "$@"
    --}
    --
    - is_bare_repository () {
    - 	git rev-parse --is-bare-repository
    - }
    +    1. https://lore.kernel.org/git/87tuiwjfvi.fsf@evledraar.gmail.com/
    +
    +    Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## git-submodule.sh ##
     @@ git-submodule.sh: isnumber()
3:  d92e880fcfa < -:  ----------- git-sh-setup: move peel_committish() function to git-subtree.sh
4:  46c018aa860 < -:  ----------- git-sh-setup: clear_local_git_env() function to git-submodule.sh
5:  45c1369e958 ! 2:  db7223741ec git-sh-setup: remove unused "pull with rebase" message
    @@ Commit message
         git-pull.sh script, which was removed in 49eb8d39c78 (Remove
         contrib/examples/*, 2018-03-25).
     
    +    Even if some out-of-tree user copy/pasted the old git-pull.sh code,
    +    and relied on passing it a "pull with rebase" argument, we'll fall
    +    back on the "*" case here, they just won't get the "pull with rebase"
    +    part of their message translated.
    +
    +    I don't think it's likely that anyone out-of-tree relied on that, but
    +    I'm being conservative here per the discussion that can be found
    +    upthread of [1].
    +
    +    1. https://lore.kernel.org/git/87tuiwjfvi.fsf@evledraar.gmail.com/
    +
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## git-sh-setup.sh ##
6:  bcae7884bb0 = 3:  cc2059f09f1 git-bisect: remove unused SHA-1 $x40 shell variable
7:  479e94f22f4 = 4:  206519c2d34 test-lib: remove unused $_x40 and $_z40 variables
-- 
2.33.0.984.gea2c3555113

