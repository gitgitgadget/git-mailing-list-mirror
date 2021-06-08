Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34D91C4743D
	for <git@archiver.kernel.org>; Tue,  8 Jun 2021 09:58:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E11961185
	for <git@archiver.kernel.org>; Tue,  8 Jun 2021 09:58:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230488AbhFHKAI (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Jun 2021 06:00:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229937AbhFHKAH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Jun 2021 06:00:07 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3020BC061574
        for <git@vger.kernel.org>; Tue,  8 Jun 2021 02:58:01 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id l10-20020a17090a150ab0290162974722f2so1931873pja.2
        for <git@vger.kernel.org>; Tue, 08 Jun 2021 02:58:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=09wiPUQi0rCkCjcxQ7udhxcESN89SNJ3pCLK6WDiSkY=;
        b=b1EwSzG8uBmd42RWaJcmd+xsL5NWS8PeBn7mI9cM/H1RvmzWZGYS7Zx/mjRKcaOEBq
         r9q/71RbhPK0HCOQiUsLAA9THEtfBtWc3LNKgkWcsRBOMpZ9EiHFfwvIQJb9UY/VMFbN
         2P9aIH0Vjc0hJ4oeg8KlxDQZ5wXXox5Bgxf5GwUsXDtxXRuiewkmuj8mfYtt0Ng92p6/
         L/1/5OuXeXdOQgVJ8MICalSX9PsIScp2NZaetJXR14VbOqE782yUL0/lqP9qF0U0VfUr
         bmfOzeiwFiM/QdjVn/q/7a+8wxC7Ah3C9bATV1pHmtHXhVTyP0y+vi/SoT1PKl6Ao2uw
         Gfag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=09wiPUQi0rCkCjcxQ7udhxcESN89SNJ3pCLK6WDiSkY=;
        b=gjtlkUJUfXdBZO3bxhCxuFUfgAnve8loBVqQg7oB2rK9+x6c5zTz7jEC4OtPJnKLEd
         4HBWvDutWblQ5Ae1PvjGJN9j0uyJ4/mPo7nb1WPzmmyR2wIdBTjQS4I89UbfKbVPrZOC
         22v+Q1AjS1IcaQ3LrE7BmGWRtVec3PtidbbdZA6c19ViSa2CnWyQfnq+UstHE0ja4LI5
         PALpAk04ooEAf0clCMI6CxvPSxmPX7NAMdSi7j9Ed8MwiX1G3KlkL7O1VAuHHoBO3MS1
         qATx0RwXCO10yTW01UwJV+NfsQUnCu7lLKgxL2S6Gf18xmhfgM98xZXXuo1i4XS2LmIo
         bpdw==
X-Gm-Message-State: AOAM532Hn21B5hWumgonQyw5lJuHwYMCtH68eLi4+WlVVla7gSmT1tZ0
        fY/GZr/AfiV7szaEPwC4/Axsld8kCeZm1RfOVYw=
X-Google-Smtp-Source: ABdhPJwWpISt7pTRsYCoRgnIiJ6zzRvsrxqBDkTGotfgXW0f+Mjz+dzvGac5htyycXn9dyw4Y0r7zw==
X-Received: by 2002:a17:90a:e60d:: with SMTP id j13mr24402851pjy.112.1623146280430;
        Tue, 08 Jun 2021 02:58:00 -0700 (PDT)
Received: from atharva-on-air.Dlink ([119.82.107.60])
        by smtp.gmail.com with ESMTPSA id p20sm10323979pff.204.2021.06.08.02.57.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Jun 2021 02:57:59 -0700 (PDT)
From:   Atharva Raykar <raykar.ath@gmail.com>
To:     git@vger.kernel.org
Cc:     Atharva Raykar <raykar.ath@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Shourya Shukla <periperidip@gmail.com>
Subject: [GSoC] [PATCH v2 0/2] submodule--helper: introduce subcommands for sh to C conversion
Date:   Tue,  8 Jun 2021 15:26:53 +0530
Message-Id: <20210608095655.47324-1-raykar.ath@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210605113913.29005-1-raykar.ath@gmail.com>
References: <20210605113913.29005-1-raykar.ath@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I have elaborated the commit message more, to explain why a warning is emitted
for an empty value in 'submodule.active'. The warning has been worded more
accurately than before.

An unnecessary extra check for 'submodule.active' has been avoided.

I have included a range diff, in case that is useful.

My fork containing these changes can be found at:
https://github.com/tfidfwastaken/git/commits/submodule-add-in-c

Emily and Jonathan: To be on the safe side, I have CC'd you so you know where I
keep my changes, and we can avoid potential conflicts, as I believe you are
working on this area as well. Just so you know, every week, I update the link to
all my ongoing work at:
https://atharvaraykar.me/gitnotes/#my-public-gitgit-branches

Atharva Raykar (2):
  submodule--helper: introduce add-clone subcommand
  submodule--helper: introduce add-config subcommand

 builtin/submodule--helper.c | 315 ++++++++++++++++++++++++++++++++++++
 git-submodule.sh            |  66 +-------
 2 files changed, 317 insertions(+), 64 deletions(-)

Range-diff against v1:
1:  398bfa713d = 1:  4374ebb6b1 submodule--helper: introduce add-clone subcommand
2:  f9954cfcf7 ! 2:  406022d0f7 submodule--helper: introduce add-config subcommand
    @@ Commit message
     
         This is meant to be a faithful conversion from shell to C, with only one
         minor change: A warning is emitted if no value is specified in
    -    'submodule.active', ie, the config looks like: "[submodule] active\n".
    +    'submodule.active', ie, the config looks like: "[submodule] active\n",
    +    because it is an invalid configuration. It would be helpful to let the
    +    user know that the pathspec is unset, and the value of
    +    'submodule.<name>.active' might be set to 'true' so that they can
    +    rectify their configuration and prevent future surprises (especially
    +    given that the latter variable has a higher priority than the former).
     
         The structure of the conditional to check if we need to set the 'active'
         toggle looks different from the shell version -- but behaves the same.
    @@ builtin/submodule--helper.c: static int add_clone(int argc, const char **argv, c
     +	char *key, *submod_pathspec = NULL;
     +	struct child_process add_submod = CHILD_PROCESS_INIT;
     +	struct child_process add_gitmodules = CHILD_PROCESS_INIT;
    -+	int pathspec_key_exists;
    ++	int pathspec_key_exists, activate = 0;
     +
     +	key = xstrfmt("submodule.%s.url", add_data->sm_name);
     +	git_config_set_gently(key, add_data->realrepo);
    @@ builtin/submodule--helper.c: static int add_clone(int argc, const char **argv, c
     +	 */
     +	pathspec_key_exists = !git_config_get_string("submodule.active",
     +						     &submod_pathspec);
    -+	if (pathspec_key_exists && !submod_pathspec)
    -+		warning(_("The submodule.active configuration exists, but "
    -+			  "no pathspec was specified. Setting the value of "
    -+			  "submodule.%s.active to 'true'."), add_data->sm_name);
    ++	if (pathspec_key_exists && !submod_pathspec) {
    ++		warning(_("The submodule.active configuration exists, but the "
    ++			  "pathspec was unset. If the submodule is not already "
    ++			  "active, the value of submodule.%s.active will be "
    ++			  "be set to 'true'."), add_data->sm_name);
    ++		activate = 1;
    ++	}
     +
     +	/*
    -+	 * If submodule.active does not exist, we will activate this
    -+	 * module unconditionally.
    ++	 * If submodule.active does not exist, or if the pathspec was unset,
    ++	 * we will activate this module unconditionally.
     +	 *
     +	 * Otherwise, we ask is_submodule_active(), which iterates
     +	 * through all the values of 'submodule.active' to determine
     +	 * if this module is already active.
     +	 */
    -+	if (!pathspec_key_exists ||
    ++	if (!pathspec_key_exists || activate ||
     +	    !is_submodule_active(the_repository, add_data->sm_path)) {
     +		key = xstrfmt("submodule.%s.active", add_data->sm_name);
     +		git_config_set_gently(key, "true");
-- 
2.31.1

