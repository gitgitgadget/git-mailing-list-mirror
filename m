Return-Path: <SRS0=8LOk=DA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B34AC4363D
	for <git@archiver.kernel.org>; Wed, 23 Sep 2020 23:47:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D0A0820C56
	for <git@archiver.kernel.org>; Wed, 23 Sep 2020 23:47:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Y2pZvNPu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726515AbgIWXrh (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Sep 2020 19:47:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726265AbgIWXrh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Sep 2020 19:47:37 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 816B1C0613CE
        for <git@vger.kernel.org>; Wed, 23 Sep 2020 16:47:37 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id r4so931080pgl.20
        for <git@vger.kernel.org>; Wed, 23 Sep 2020 16:47:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=6rwvNUwoysQGZOGi6M4zCgD9QfzPZ0E+o9PlxzKpqHg=;
        b=Y2pZvNPugT3cinrfPe/YhQU44+7s2Y+ttDoWK+QVdIO3OMArRt5w2AuSWtnC4XcJYY
         4vYEP71W1r0eL/XLk4en3//DsagTNca8g7gYOLpj52MrKVYf2ldGte6aLzeDlOg35FN6
         FhweS1vkgAp/BSZWAMP3w9sKaNcV9H4DMCRWWeSnDQjFXbYayUipH987hImSnq8R74O9
         ojuDRY3qsD+XeezWJWieOxLfOaIOY5sk2fQa5MYGz8KmDQmu//ME69wx86RyxIBlPhnM
         qo5afcoWG9PlE9+ZNqERPv0AtajeDAPrKjR04mWuUYkmqMM9qwRnlnJd1Gd/NMPwQ+Rc
         nf6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=6rwvNUwoysQGZOGi6M4zCgD9QfzPZ0E+o9PlxzKpqHg=;
        b=fOdD/lMQQmTFkZx1Bmz1DQ/xyLcsYU0zcP/l7jB6K/bJw0h1R64YlO9bHPHgce0Hiv
         H4xS9bjG7W7AJICrYR/AOqAi1sO3wgNZE0n9Bk3mZl+JfdVWXQ0W0WeMW0zlZWKfVyK5
         nwcVAptWamndwU3sHXAwV/B3Qs+9PqP5Y4O1h+cvaDss//moJc0FhtBDcFSymbJlla2b
         uYeqJ8PVTb1kkiWHCjTrLcfE6VJNREGZq0GSjAcaS+jAWzdXFyOjVS3Qn9vs3FGNJQ/s
         zscMIqVlGHc1iFLR8dDdI/b1VhdbESA4C2JfoPkS5QowInoW49lGhde8QvJvYwZ9Je/c
         fCZQ==
X-Gm-Message-State: AOAM531ER+n0MR+vj4n2khKwz7e1F9uTRR5nW2FGP7owL+FuSVs0E0/y
        3hjUxOUFCGfM6FFvQeCarc8as+zML7V2CLx8zTzj
X-Google-Smtp-Source: ABdhPJz+Y2+rjUeG/1RXb5IK+9/SzY7i2p5Aqi0DeQwh94w8XozVfyE+nbmjf6fXhHt94RQ+8rkxg16rdtPngv8jLd+B
Sender: "jonathantanmy via sendgmr" <jonathantanmy@twelve4.c.googlers.com>
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:18d])
 (user=jonathantanmy job=sendgmr) by 2002:aa7:9491:0:b029:142:2501:396b with
 SMTP id z17-20020aa794910000b02901422501396bmr2014604pfk.48.1600904856866;
 Wed, 23 Sep 2020 16:47:36 -0700 (PDT)
Date:   Wed, 23 Sep 2020 16:47:34 -0700
In-Reply-To: <20200909004939.1942347-9-emilyshaffer@google.com>
Message-Id: <20200923234734.1294057-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <20200909004939.1942347-9-emilyshaffer@google.com>
X-Mailer: git-send-email 2.28.0.681.g6f77f65b4e-goog
Subject: Re: [PATCH v4 8/9] commit: use config-based hooks
From:   Jonathan Tan <jonathantanmy@google.com>
To:     emilyshaffer@google.com
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> -	if (!no_verify && find_hook("pre-commit")) {
> +	if (!no_verify && hook_exists("pre-commit")) {

A reviewer would probably need to look at all instances of "pre-commit"
(and likewise for the other hooks) but if the plan is to convert all
hooks, then the reviewer wouldn't need to do this since we could just
delete the "find_hook" function.

Overall comments about the design and scope of the patch set:

 - I think that the abilities of the current patch set regarding
   overriding order of globally-set hook commands is sufficient. We
   should also have some way of disabling globally-set hooks, perhaps
   by implementing the "skip" variable mentioned in patch 1 or by
   allowing the redefinition of hookcmd sections (e.g. by redefining a
   command to "/usr/bin/true"). To me, these provide substantial
   user-facing value, and would be sufficient for a first version - and
   other things like parallelization can come later.

 - As for the UI that should be exposed through the "git hook" command,
   I think that "git hook list" and "git hook run" are sufficient.
   Editing the config files are not too difficult, and "git hook add"
   etc. can be added later.

 - As for whether (1) it is OK for none of the hooks to be converted (and
   instead rely on the user to edit their hook scripts to call "git hook
   run ???"), or if (2) we should require some hooks to be
   converted, or if (3) we should require all hooks to be converted: I'd
   rather have (2) or (3) so that we don't have dead code. I prefer (3),
   especially since a reviewer wouldn't have to worry about leftover
   usages of old functions like find_hook() (as I mentioned at the start
   of this email), but I'm not fully opposed to (2) either.
