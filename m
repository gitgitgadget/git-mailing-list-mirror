Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3642C48BCF
	for <git@archiver.kernel.org>; Wed,  9 Jun 2021 17:16:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB42E610F8
	for <git@archiver.kernel.org>; Wed,  9 Jun 2021 17:16:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231290AbhFIRSe (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Jun 2021 13:18:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230152AbhFIRSe (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Jun 2021 13:18:34 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE0F0C061574
        for <git@vger.kernel.org>; Wed,  9 Jun 2021 10:16:39 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id k125-20020a3788830000b02903a65618d46cso17598038qkd.3
        for <git@vger.kernel.org>; Wed, 09 Jun 2021 10:16:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=yzghyUzocZ9gxPoeoZJt4Fp0+RdjRM1I0JOmZxxd/VQ=;
        b=Y6GU4Rmlz+KCseVQ+gtH2/CawHy0jT4EfulDY1j+V9gFxXj5Aw2mrp7bBGVEVHpHgS
         mxXbPWbtwazushhEkes0JytQmxzxqx9z2IzDAVmfs36ZuwJtf8/7MqafADCS9vahdMbT
         A2UCNg7ceQsIYAc+u0A87p/0uO8Dza4XRIE4R3ges1opcZyYp/NeRG2LEppv4exUU/vh
         T0AArPkWLjXwbJgkcQjLrzvKFUusm2ELb88KGvf3ndSzYyCXKuRsoWArakIF0XDC4ndP
         MU/rpJQZ8pTJjQMhlSDhx1D34VlvEOAaiVlXcO4JJbKG3jTUjNZ0r/OW8e8Q+ySsWonQ
         exig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=yzghyUzocZ9gxPoeoZJt4Fp0+RdjRM1I0JOmZxxd/VQ=;
        b=S6kYmK5TB+MR3733Ibpp3pBIfAUhmgyjGAcXe7CA4rOEyBeva9+BrcoeQd4H8tcPdH
         JxpfQZDW9sniZJdFOa76CXAwaCm9ZNsKqLB3QwWpn/rBjHY73fSetnfm1j4ebBmq+hyB
         Xp1Cv++NH039bhRj5aZWcUbodFNJwFkiQ8QozrSRCSCLBpnTFymK7g1YV/Rpa0BuyhDD
         Bgqb8BOrw8J9+xLqhtl8InXqYOYACyt7PdFCqZyqebzLFfHTC5Qio7TTDkwyxg1ONh6i
         xrFHT0WYtxnMMow/aBBK8AwASN/SGanSU9bQw1zhuvpF3WJR5bi70xSVeSd85sYDYhys
         BwXg==
X-Gm-Message-State: AOAM532H8UB+aVQFgksQO7JgBYWHAPLvYgWCDqpP0H/6StqgWa5G8dtZ
        jds0H429XC0Muacv9e5xFy+S5S2ZYTWwfyFGc5Go
X-Google-Smtp-Source: ABdhPJyczJYg9GTh+tZOxw2yHCjirOhWCFN3KCioUrR7JeUIVNz/hl3KCPIKbbjkzU3lxaod2PzXU0IpEcI8o6rUmEmx
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a05:6214:7f1:: with SMTP id
 bp17mr1054080qvb.29.1623258998865; Wed, 09 Jun 2021 10:16:38 -0700 (PDT)
Date:   Wed,  9 Jun 2021 10:16:35 -0700
In-Reply-To: <xmqqeedbidvy.fsf@gitster.g>
Message-Id: <20210609171635.2395049-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <xmqqeedbidvy.fsf@gitster.g>
X-Mailer: git-send-email 2.32.0.rc1.229.g3e70b5a671-goog
Subject: Re: [PATCH v2 1/4] promisor-remote: read partialClone config here
From:   Jonathan Tan <jonathantanmy@google.com>
To:     gitster@pobox.com
Cc:     jonathantanmy@google.com, git@vger.kernel.org, me@ttaylorr.com,
        newren@gmail.com, emilyshaffer@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Jonathan Tan <jonathantanmy@google.com> writes:
> 
> > I'm reluctant to add more fields to struct repository_format.
> 
> I am only suggesting to add one new member to either struct
> repository or struct repo_settings, so that it becomes crystal clear
> that struct repository_format is about each single repository, not
> the global the_repository.  Other things that partial repository
> support needs to keep *and* do not directly come from extensions
> would not belong to repository_format and should not be added there,
> but what we read from extensions.* for each repository belongs to
> each instance of in-core repository structure and should be
> discoverable starting from "struct repository", no?

Ah, I see. I'll try this.
