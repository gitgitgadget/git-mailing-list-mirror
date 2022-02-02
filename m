Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9DC9C433EF
	for <git@archiver.kernel.org>; Wed,  2 Feb 2022 03:42:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244074AbiBBDmp (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Feb 2022 22:42:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243201AbiBBDmo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Feb 2022 22:42:44 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39F95C061714
        for <git@vger.kernel.org>; Tue,  1 Feb 2022 19:42:44 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id k18so35815399wrg.11
        for <git@vger.kernel.org>; Tue, 01 Feb 2022 19:42:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=LKD+RsPzoSCMbUzhia5YRTHhLAPzK0rW5Ta5ZZeebnE=;
        b=IifsJ16YJF3nZGsiEWdKkw0VdCbTzyiJA9D3tdF2LkSyt5gxR19w2wZ+PDcvzQ0bBd
         +1cLzrGeXN7/8QWQ9viXE7lx4NV1YGJwHGJ37whju1IyAFmk7LWdXAZnBb2Ji2IKP+Qv
         09uoOeggHlFN9o2fGdGCLPDZAxsqIsWOXeQI0tvV/c0zq3tnBWi032+SzSqQNBDrhaR+
         dhuPmC/dUiCtbFzF/bUHQOGizKiSNC6k3DNG9FFLIoT9LoGb0EMr3yFQzOahiKFSsIsW
         D9DMjIzIGJT+OUmG5yCWHq2G+n7sIt/lt+Lin2k5LIk8nzBCqYe3Ez99FWwRnu6pnsiJ
         mbEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=LKD+RsPzoSCMbUzhia5YRTHhLAPzK0rW5Ta5ZZeebnE=;
        b=Uc5SbmXfImMGMGhJc+Q/oxBytLcY8wGBU0obUSDHyWmNNCoF7jz7kf9McwNKpPpnn+
         G21qclLan9tWOCK0GQVCTIMSt11JGIqrrmZuxX8HkPpNtavPxHZ4rbctG+Q/Iq1xjWV3
         zMG41pOC3/qKOpa4gEbQqtmKQIGJywpkcHmomrUwKIU3XfG2ULZcIj6tI5wS9unRIxIR
         ff4rHag+Wd0NHnSvLRAEIaHsmivQ9XlPmMgRPiB9wNM8WsnUTgjvokvOx5X7gVVyi99f
         gZiU0Kf4S5kbNFD9/yY9H2dI7ws1doiTtYI5/ysj9rMQU3ovPdjI92RLHaHCK74OBkhW
         +H6Q==
X-Gm-Message-State: AOAM5306S7hHtE6qJ5FBm975rApE+6hzCka2S8aN/Hyj13TKh+2sc+Ui
        Pg1rTRc3Pwm9WtQmenqo/etp2up3F4g=
X-Google-Smtp-Source: ABdhPJytATKRURxEdX7EXd938MNHOHN/nyjEbJBQfh85Wj/CaejLTA5JdFBgEplNOthWFxToYPozFw==
X-Received: by 2002:adf:f80a:: with SMTP id s10mr23084311wrp.440.1643773362573;
        Tue, 01 Feb 2022 19:42:42 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 1sm3450021wmo.37.2022.02.01.19.42.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Feb 2022 19:42:42 -0800 (PST)
Message-Id: <pull.1131.v4.git.1643773361.gitgitgadget@gmail.com>
In-Reply-To: <pull.1131.v3.git.1643734828.gitgitgadget@gmail.com>
References: <pull.1131.v3.git.1643734828.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 02 Feb 2022 03:42:37 +0000
Subject: [PATCH v4 0/3] repo-settings: fix checking for fetch.negotiationAlgorithm=default
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This regression is not new in v2.35; it first appeared in v2.34. So, not
urgent.

Changes since v3:

 * 'consecutive' is used as the traditional default. 'default' means either
   'consecutive' or 'skipping' depending on feature.experimental.

Changes since v2:

 * Also fix the fact that fetch.negotationAlgorithm=$BOGUS_VALUE no longer
   errors out (yet another regression, this one dating back to v2.24.0), and
   add a test to make sure we don't regress it again.
 * Add 'consecutive' as a synonym for 'default', and remove 'default' from
   the documentation to guide people towards using 'consecutive' when they
   want the classic behavior.

Changes since v1:

 * Put the common code in two testcases into a function, and then just
   invoked it from each

Elijah Newren (3):
  repo-settings: fix checking for fetch.negotiationAlgorithm=default
  repo-settings: fix error handling for unknown values
  repo-settings: rename the traditional default
    fetch.negotiationAlgorithm

 Documentation/config/fetch.txt | 25 +++++++++++++------------
 fetch-negotiator.c             |  2 +-
 repo-settings.c                |  9 ++++++++-
 repository.h                   |  2 +-
 t/t5500-fetch-pack.sh          | 24 +++++++++++++++++++++---
 5 files changed, 44 insertions(+), 18 deletions(-)


base-commit: 89bece5c8c96f0b962cfc89e63f82d603fd60bed
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1131%2Fnewren%2Ffix-fetch-negotiation-algorithm-equals-default-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1131/newren/fix-fetch-negotiation-algorithm-equals-default-v4
Pull-Request: https://github.com/gitgitgadget/git/pull/1131

Range-diff vs v3:

 1:  df0ec5ffe98 = 1:  df0ec5ffe98 repo-settings: fix checking for fetch.negotiationAlgorithm=default
 2:  23f692b81be = 2:  23f692b81be repo-settings: fix error handling for unknown values
 3:  7b28c527a90 ! 3:  7500a4d2e44 repo-settings: name the default fetch.negotiationAlgorithm 'consecutive'
     @@ Metadata
      Author: Elijah Newren <newren@gmail.com>
      
       ## Commit message ##
     -    repo-settings: name the default fetch.negotiationAlgorithm 'consecutive'
     +    repo-settings: rename the traditional default fetch.negotiationAlgorithm
      
     -    Give the default fetch.negotiationAlgorithm the name 'consecutive' and
     -    update the documentation accordingly.  Since there may be some users
     -    using the name 'default' for this behavior, retain that name for now.
     -    We do not want to use that name indefinitely, though, because if
     -    'skipping' becomes the default, then the "default" behavior will not be
     -    the default behavior, which would be confusing.
     +    Give the traditional default fetch.negotiationAlgorithm the name
     +    'consecutive'.  Also allow a choice of 'default' to have Git decide
     +    between the choices (currently, picking 'skipping' if
     +    feature.experimental is true and 'consecutive' otherwise).  Update the
     +    documentation accordingly.
      
          Signed-off-by: Elijah Newren <newren@gmail.com>
      
     @@ Documentation/config/fetch.txt: fetch.output::
      -	that never skips commits (unless the server has acknowledged it or one
      -	of its descendants). If `feature.experimental` is enabled, then this
      -	setting defaults to "skipping".
     +-	Unknown values will cause 'git fetch' to error out.
      +	Control how information about the commits in the local repository
      +	is sent when negotiating the contents of the packfile to be sent by
      +	the server.  Set to "consecutive" to use an algorithm that walks
     @@ Documentation/config/fetch.txt: fetch.output::
      +	faster, but may result in a larger-than-necessary packfile; or set
      +	to "noop" to not send any information at all, which will almost
      +	certainly result in a larger-than-necessary packfile, but will skip
     -+	the negotiation step.  The default is normally "consecutive", but
     -+	if `feature.experimental` is true, then the default is "skipping".
     - 	Unknown values will cause 'git fetch' to error out.
     ++	the negotiation step.  Set to "default" to override settings made
     ++	previously and use the default behaviour.  The default is normally
     ++	"consecutive", but if `feature.experimental` is true, then the
     ++	default is "skipping".  Unknown values will cause 'git fetch' to
     ++	error out.
       +
       See also the `--negotiate-only` and `--negotiation-tip` options to
     + linkgit:git-fetch[1].
      
       ## fetch-negotiator.c ##
      @@ fetch-negotiator.c: void fetch_negotiator_init(struct repository *r,
     @@ repo-settings.c: void prepare_repo_settings(struct repository *r)
       	/* Booleans config or default, cascades to other settings */
       	repo_cfg_bool(r, "feature.manyfiles", &manyfiles, 0);
      @@ repo-settings.c: void prepare_repo_settings(struct repository *r)
     + 	}
     + 
     + 	if (!repo_config_get_string(r, "fetch.negotiationalgorithm", &strval)) {
     ++		int fetch_default = r->settings.fetch_negotiation_algorithm;
     + 		if (!strcasecmp(strval, "skipping"))
       			r->settings.fetch_negotiation_algorithm = FETCH_NEGOTIATION_SKIPPING;
       		else if (!strcasecmp(strval, "noop"))
       			r->settings.fetch_negotiation_algorithm = FETCH_NEGOTIATION_NOOP;
     --		else if (!strcasecmp(strval, "default"))
     --			r->settings.fetch_negotiation_algorithm = FETCH_NEGOTIATION_DEFAULT;
     -+		else if (!strcasecmp(strval, "consecutive") ||
     -+			 !strcasecmp(strval, "default"))
     ++		else if (!strcasecmp(strval, "consecutive"))
      +			r->settings.fetch_negotiation_algorithm = FETCH_NEGOTIATION_CONSECUTIVE;
     + 		else if (!strcasecmp(strval, "default"))
     +-			r->settings.fetch_negotiation_algorithm = FETCH_NEGOTIATION_DEFAULT;
     ++			r->settings.fetch_negotiation_algorithm = fetch_default;
       		else
       			die("unknown fetch negotiation algorithm '%s'", strval);
       	}

-- 
gitgitgadget
