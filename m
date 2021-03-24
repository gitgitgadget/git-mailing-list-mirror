Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8487C433DB
	for <git@archiver.kernel.org>; Wed, 24 Mar 2021 08:37:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 70BF3619EC
	for <git@archiver.kernel.org>; Wed, 24 Mar 2021 08:37:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233955AbhCXIhH (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Mar 2021 04:37:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230368AbhCXIgl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Mar 2021 04:36:41 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94B01C061763
        for <git@vger.kernel.org>; Wed, 24 Mar 2021 01:36:40 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id e14so7532744plj.2
        for <git@vger.kernel.org>; Wed, 24 Mar 2021 01:36:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MVyMcvodElQQtV7OgArOMG06NODmxLebAF+eZUzmXsE=;
        b=aLWOsN/3bMpU3Bmp34jexS+R8xOD7So12I875/oxj/lp4846zMT4NXBXrmaotZjKwQ
         cacw61sj5gz1dytpDqh6x9nhwhjHDq0vO8omnWoRIJwW8ipq1Sr5FXuaZqGMWTcI1y5d
         PCr5v71z84Zm2gKb33OiXU9RFQGMAc2Wo53mdXOtArgueVywxzkc4qV5FXW18DVszXs8
         IsIKIR3FBCYvlhhD54zgXYjjTybPlkEV2gNvJ2r8W77xSj/EN3c/K1LUXle/gOqkxKp/
         08y2fyABbERGJeAZrjJclYHZG70k7gyesrkuIOll8WsfBDsx3/B6c5H0Sn+9lQg0FxPK
         2Ojw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MVyMcvodElQQtV7OgArOMG06NODmxLebAF+eZUzmXsE=;
        b=rzXIwTNK87dT/FeVddoot4lPzITKzm0YULHhSUsKnuCLu0yGnflHETItv/t2yGiGm9
         M3COuVdAET3RqHbeLsNL55//0AJbkSzeplh8+YjmUq60J4uxLSi4o3pwfD9pkPUMFgKM
         sVlCWCUDrupg6yffiTSpi2CNUIF61ubkIy8WP4z+F8jn7x1i0jMBwDkbvQw+1L4m7et6
         QCgWEWv0OPu0T0iAFKSve/5q5JLAZN7kwC3+h69jlngvCSkmRimMXOnlMF4IkPBONNk1
         AGmrbdbZLfMUR96GUG8NU7KWd8zsZtN84DN7AMNAyjCEK+qraCTNgWGP9GaGcHJDkIWG
         5LOA==
X-Gm-Message-State: AOAM530Tf5PItfzfZ5EcwHJEG68xAZm7Msw+fnbzAcdeV/cbSLjdL4h7
        ftbNh8rkkMzw+3OwtDwNhrO2pa5rQmY=
X-Google-Smtp-Source: ABdhPJwi028lA9rrnMZ/+9RkMHyR9RNvaA0doO/8Glmv0VxFUnemRg9MeNNzjWf461YwKnDj8qUPww==
X-Received: by 2002:a17:90a:d681:: with SMTP id x1mr2049364pju.82.1616574999727;
        Wed, 24 Mar 2021 01:36:39 -0700 (PDT)
Received: from archbookpro.localdomain ([172.92.165.181])
        by smtp.gmail.com with ESMTPSA id a15sm1609361pju.34.2021.03.24.01.36.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Mar 2021 01:36:38 -0700 (PDT)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 0/3] git-completion.bash: improvements to _git_stash()
Date:   Wed, 24 Mar 2021 01:36:26 -0700
Message-Id: <cover.1616574955.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620
In-Reply-To: <cover.1615855962.git.liu.denton@gmail.com>
References: <cover.1615855962.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series modernises the _git_stash() completion handler by letting it
take advantage of __gitcomp_builtin(). Also, it fixes a bug with how
completions are offered when arguments are provided to the main git
command.

Changes since v1:

* Fix the hardcoded $cword comparisons in a more generic way

Denton Liu (3):
  git-completion.bash: pass $__git_subcommand_idx from __git_main()
  git-completion.bash: extract from else in _git_stash()
  git-completion.bash: use __gitcomp_builtin() in _git_stash()

 contrib/completion/git-completion.bash | 122 ++++++++++++-------------
 1 file changed, 60 insertions(+), 62 deletions(-)

Range-diff against v1:
-:  ---------- > 1:  e4aa3e8cd7 git-completion.bash: pass $__git_subcommand_idx from __git_main()
1:  a2d9bc4a66 ! 2:  430d5acf97 git-completion.bash: extract from else in _git_stash()
    @@ contrib/completion/git-completion.bash: _git_stash ()
     -		branch,--*)
     -			;;
     -		branch,*)
    --			if [ $cword -eq 3 ]; then
    +-			if [ $cword -eq $((__git_subcommand_idx+2)) ]; then
     -				__git_complete_refs
     -			else
     -				__gitcomp_nl "$(__git stash list \
    @@ contrib/completion/git-completion.bash: _git_stash ()
     +	branch,--*)
     +		;;
     +	branch,*)
    -+		if [ $cword -eq 3 ]; then
    ++		if [ $cword -eq $((__git_subcommand_idx+2)) ]; then
     +			__git_complete_refs
     +		else
      			__gitcomp_nl "$(__git stash list \
2:  be727d0171 < -:  ---------- git-completion.bash: fix `git <args>... stash branch` bug
3:  d6deaecc1f ! 3:  680f3a3146 git-completion.bash: use __gitcomp_builtin() in _git_stash()
    @@ Commit message
         subcommand is given, it automatically defaults to `git stash push`. This
         means that we can simplify the logic for when no subcommands have been
         given yet. We only have to offer subcommand completions when we're
    -    completing the word after "stash". Unfortunately, this does not work
    -    100% correctly. For example, in the case of something like `git -C stash
    -    stash<TAB>`, this will incorrectly identify the first "stash" as the
    -    command. This seems to be an edge-case that we can ignore, though, as
    -    other functions, such as _git_worktree(), suffer from the same problem.
    +    completing a non-option after "stash".
     
         One area that this patch could improve upon is that the `git stash list`
         command accepts log-options. It would be nice if the completion for this
    @@ contrib/completion/git-completion.bash: _git_sparse_checkout ()
     -	local save_opts='--all --keep-index --no-keep-index --quiet --patch --include-untracked'
      	local subcommands='push list show apply clear drop pop create branch'
      	local subcommand="$(__git_find_on_cmdline "$subcommands save")"
    - 	local stash_idx="$(__git_find_on_cmdline --show-idx stash)"
    - 	stash_idx="${stash_idx% *}"
    - 
     -	if [ -z "$subcommand" -a -n "$(__git_find_on_cmdline "-p")" ]; then
     -		subcommand="push"
     -	fi
    ++
      	if [ -z "$subcommand" ]; then
     -		case "$cur" in
     -		--*)
     -			__gitcomp "$save_opts"
    -+		case "$((cword - stash_idx)),$cur" in
    ++		case "$((cword - __git_subcommand_idx)),$cur" in
     +		*,--*)
     +			__gitcomp_builtin stash_push
      			;;
    @@ contrib/completion/git-completion.bash: _git_stash ()
     +		__gitcomp_builtin stash_branch
      		;;
      	branch,*)
    - 		if [ $((cword - stash_idx)) -eq 2 ]; then
    + 		if [ $cword -eq $((__git_subcommand_idx+2)) ]; then
-- 
2.31.0.rc2.261.g7f71774620

