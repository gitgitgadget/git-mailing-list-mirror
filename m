Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A538C07E96
	for <git@archiver.kernel.org>; Sun, 11 Jul 2021 12:47:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F59D611AB
	for <git@archiver.kernel.org>; Sun, 11 Jul 2021 12:47:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232679AbhGKMuH (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 11 Jul 2021 08:50:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbhGKMuH (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Jul 2021 08:50:07 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A995C0613DD
        for <git@vger.kernel.org>; Sun, 11 Jul 2021 05:47:19 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id o5so27634081ejy.7
        for <git@vger.kernel.org>; Sun, 11 Jul 2021 05:47:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=7lybCj2Bsq+Iu6Qi7NsO2xP+fCI/WBbtg3G+u2dk400=;
        b=rwJrlXKzr60gmTAmb1HpaxfSi2p32t/UFbwO6WgIT8xG6xt+CuLur+WUjKRmaYLsuJ
         Xql0cnOhIejT/hzWvpM0EFmd3Nxzk8azuSymhsXLgmE+YU2/rZaSakk4KkM0J7sUvibn
         7tdSIKo34fRI85SNMbODXh4ewwosET11zqdt8ttrWafzALaga+xNINlqetbF1g/yOGer
         Nsx6TzJuj4Kl1BdXuerYxFwWoLD76zly6fKNmUvloMLEofsPZYSqyMQW4Qj8ZK2Cfr5B
         9MZrFb5x1HV4+hdAMb80nM4u84U5D/J8ROGb6VnZVFEg44B4q0V4A1f2kUr7jmfOk9IA
         1sKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=7lybCj2Bsq+Iu6Qi7NsO2xP+fCI/WBbtg3G+u2dk400=;
        b=cXcNNdMhNyN1H7XW983S+tzEQ8O5xeWya9NHeQP+da1gKJ6rHBun49qW5FoKtqNWhu
         sp4igwWft+8wyNZhbRAPxx+/Bs+iUVC7CaxNRWf1kBjJVbynDy3G2JJSxQpGzyIqyM7o
         X9lKqP6FMEFf3NsXPs53aQWh+ltlcB+d1RzyZlfMXUWGZyEVrUnnr2GIJM2FOSf/PBHR
         FX6CgrJ6qWfLBz7MPx5t4D9qle0EU7/eT29LIcp7r5rpDb2H8A1iiwzjqNJ/FprEK3q/
         7B8Ojxvz2YfR4NeugNRQoKCPMHC/Cq9zAMX0wGtWZ4gJE+zd1xQqUgH4kNspxXx3cgwX
         Wj7g==
X-Gm-Message-State: AOAM5337cNm1xnbZLnW0ROKndyQZ4aH5wpHRSqjhym1CrCKn1vcF9cme
        qqBxBChr77NAUkHIyeqrG0iB2SVUTkvJPg==
X-Google-Smtp-Source: ABdhPJxzCrsovRxu3thKMiiA0Qi/feOegHucIbslo3QrI68wI/RoF7/rLzROBBp2KqOFeZjMprtRrg==
X-Received: by 2002:a17:907:24d1:: with SMTP id e17mr24591404ejn.427.1626007636822;
        Sun, 11 Jul 2021 05:47:16 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id qo6sm2674071ejb.122.2021.07.11.05.47.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jul 2021 05:47:16 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: [PATCH v5 5/6] refs: explicitly return failure_errno from
 parse_loose_ref_contents
Date:   Sun, 11 Jul 2021 14:41:36 +0200
References: <pull.1012.v4.git.git.1625597757.gitgitgadget@gmail.com>
 <pull.1012.v5.git.git.1625684869.gitgitgadget@gmail.com>
 <6918c214d1b41b16c47625f0935389440253ec4c.1625684869.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <6918c214d1b41b16c47625f0935389440253ec4c.1625684869.git.gitgitgadget@gmail.com>
Message-ID: <87czrp3tm4.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Jul 07 2021, Han-Wen Nienhuys via GitGitGadget wrote:

> Subject: refs: explicitly return failure_errno from parse_loose_ref_contents
> [...]
> The EINVAL error from parse_loose_ref_contents is used in files-backend
> to create a custom error message.

Except as my https://lore.kernel.org/git/87v95o5ku8.fsf@evledraar.gmail.com/ shows, and if you remove this:

> +	ret = parse_loose_ref_contents(buf, oid, referent, type, failure_errno);
> +	errno = *failure_errno;

We aren't explicitly returning things yet, instead we set it for some,
but others still fail if we don't support that one caller relying on
this "errno" and not "failure_errno" through the backdoor, why not
simply convert that remaining caller?
