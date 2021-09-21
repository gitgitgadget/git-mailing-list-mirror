Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93866C433FE
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 16:33:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 803E26023D
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 16:33:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229457AbhIUQfC (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Sep 2021 12:35:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbhIUQe7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Sep 2021 12:34:59 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE557C06175F
        for <git@vger.kernel.org>; Tue, 21 Sep 2021 09:33:30 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id v14-20020a05620a0f0e00b0043355ed67d1so48097337qkl.7
        for <git@vger.kernel.org>; Tue, 21 Sep 2021 09:33:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=igcYNWUtK4qT1OQZ6VCcKNzxLpPccsCAoVt0tnZ1zhg=;
        b=Gyxs/4wuj2jRmjLO9stlP63a0Pwlmt0TaCGlPSGKwJzMf2EUuvCd7vkRC1nu5jJ0Ma
         FI6Fx8I76fO8Kl1V0oATwcnYJO8MMwvUzlcNM81W7+wMwTOWrzrnX/INWTi1LJGvbyz5
         1WK+cqNM08yRN37FCAXQNyl+yHGD0O04FfmpOL8gltTICUEeBKwQ+eUlEBX9R9we4Gqd
         gWd+caZl5ZtP2nO7kyQkcJGWUISGf1NMnKZIz0eyMtFERZMKQiWSckHsZrDktjNiWJKl
         oYB67sdy5nEkbT0QoneQobnH/yQmLBa9GGRPcEPw9gWHbbN76NfSsDMHzBSzAQFrG2Dh
         QUGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=igcYNWUtK4qT1OQZ6VCcKNzxLpPccsCAoVt0tnZ1zhg=;
        b=a+1gfbyRtOt/bRoEgYp29msBtD7VucckFpovMyua83JwrYHHrGKI9S7KaZsGPjOwRP
         Jjh/9MW78618nJrwENMLOwIBSJVBDXG7U1QP8T3PeJMlnV9QXS81TGB71ea8S9iF64V0
         Xcl8/yOI8hMH0Lkjt58czoo6QZMMbdQLgAa+6i+pH6Rz+S6T+gQW6MWmH2KxqjW8bjjD
         GsYiAChsv2mWDnVNsSqKYQhGnTi+AUFQ/HGooMxqPM3O7bgDmxYNQDseXbVxPpca23tt
         9alYkPOwWAPSz3aoQ3Jv49eOV0lyoM/aSsPzLSJ8kdXEX13hzGzuF+frFQsAAojcT8dk
         VfLw==
X-Gm-Message-State: AOAM533pvHr2VmNlDVU3w5Z5T4FaVdb0A5FXJmOTf9Xpa892A4E7/xue
        fWHGK9PdAVedjBY19fdu45Bev4P6A+lSHmwWcuZE
X-Google-Smtp-Source: ABdhPJzYVTvbeKFh86PD7cr7cYMWHBk3FWSjybqZ41/D/lcdyImA1FAqVT+leEOjZtfhCZg2E5vfQ3UkOZWu9zKVTUSd
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a05:6214:2e4:: with SMTP id
 h4mr32294285qvu.3.1632242010105; Tue, 21 Sep 2021 09:33:30 -0700 (PDT)
Date:   Tue, 21 Sep 2021 09:33:22 -0700
In-Reply-To: <xmqqczp39bth.fsf@gitster.g>
Message-Id: <20210921163322.1640109-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <xmqqczp39bth.fsf@gitster.g>
X-Mailer: git-send-email 2.33.0.464.g1972c5931b-goog
Subject: Re: [PATCH v2 2/8] submodule--helper: get remote names from any repository
From:   Jonathan Tan <jonathantanmy@google.com>
To:     gitster@pobox.com
Cc:     raykar.ath@gmail.com, jonathantanmy@google.com, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Atharva Raykar <raykar.ath@gmail.com> writes:
> 
> > +static char *get_default_remote_submodule(const char *module_path)
> > +{
> > +	const char *refname;
> > +	const struct submodule *sub;
> > +	struct repository subrepo;
> > +
> > +	refname = refs_resolve_ref_unsafe(get_submodule_ref_store(module_path),
> > +					  "HEAD", 0, NULL, NULL);
> > +	sub = submodule_from_path(the_repository, null_oid(), module_path);
> > +	repo_submodule_init(&subrepo, the_repository, sub);
> > +	return repo_get_default_remote(&subrepo, refname);
> > +}
> 
> This call (and I think there is another call in this file) to
> repo_submodule_init() is affected by what Jonathan's 8eb8dcf9
> (repository: support unabsorbed in repo_submodule_init, 2021-09-09)
> wants to do, namely to lose "struct submodule sub" as a parameter
> and instead take the path to the module and the treeish name as
> parameters to repo_submodule_init().
> 
> I _think_ I resolved the conflict correctly, but please double check
> the result when it is pushed out later today, both of you.
> 
> Thanks.

Thanks for calling this out. There are indeed 2 such calls in 33cfc43433
("Merge branch 'ar/submodule-update' into seen", 2021-09-20) and both
look correct.
