Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2973DC433FE
	for <git@archiver.kernel.org>; Mon, 15 Nov 2021 20:32:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 12E1C63240
	for <git@archiver.kernel.org>; Mon, 15 Nov 2021 20:32:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351506AbhKOUfF (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Nov 2021 15:35:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345289AbhKOT2A (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Nov 2021 14:28:00 -0500
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB37CC09E03F
        for <git@vger.kernel.org>; Mon, 15 Nov 2021 10:48:23 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id hg9-20020a17090b300900b001a6aa0b7d8cso348257pjb.2
        for <git@vger.kernel.org>; Mon, 15 Nov 2021 10:48:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=cpVOlm9T3Y0Xf45E+4Vqw4ZrBTrBncSqzQcgViBK2qo=;
        b=RBN2q5/8jqRvjPRE4lEa/K69LA7oh+j/oZKaIAGF4PKN0HPjZdD4ZW6kzC0Orzbjrk
         hrvS6O2GUujCuqMDzeTwQpB8Ophr1mZdIGK6pmN6qjze3UMh9bf5oQWvhTSwjOaCh3Jr
         9D4l1prBAzVP721JMW7MFALccf2ZhBU2PuFPF+J1ML7fGfJZVG7Pekt5phBjl5r6S5pz
         ud0M8tBRsdevcBb6REz68IDP0MtrjxZgcVH2dRr5HCyq6kSM/GI5aWKrYW8lu7g7h4p1
         ll6SLCC+cjP/qljpyVecWmpZt26ZQ91WXxXwwbrF3v7NFnDDQ7tVgSogMEeviYdhd+Yq
         1jpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=cpVOlm9T3Y0Xf45E+4Vqw4ZrBTrBncSqzQcgViBK2qo=;
        b=5Z7sIJblTJZD6umoPCv9LLfBkP+4lS2bzmfR3oMPodMQnATW12/vjAavo/HVPyGbwI
         /zBfXK26+m0AZaSYazGHrG8F4bx2wHhhI8t2haHtiLvMriS1J/GeGfhKI8+ho7vW4vIa
         g+2/tHO9nuZJ60UCPMnxOyoCQ8V7scTz7jTaSbVc1e429kHB/1lOgAVVLALQx/plRp2U
         /UH+ly4aU79skLNrbm5km6bdsltLNQ9jIq6jK5fEjbmE+iNFWy0ecH9JAdCN2lfhr1gx
         SkWEcZEj8bgyIToDyMFw+//Q8B5SHGWH6GLO/u0NhB9Nm8jIlkWUgJrn4fq/1Z6sCjE2
         DJYg==
X-Gm-Message-State: AOAM531u6WLbjH3p3cjQtrGp8l6JF4ug6s/UFvl5o/kvc8HZZnaiIuiw
        a9NVv0qHlJho3usAEeGKZkRzDaZ2pSLVncCJAtj3
X-Google-Smtp-Source: ABdhPJy4o2p1J9uR2kZcnIfK6J3239PJtyg6e/nioSNP0vIyqPrkqtGtXi2/k0TQMN3misPSJair/ba4zD0QAYkM2Dk0
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a65:408c:: with SMTP id
 t12mr722338pgp.262.1637002103272; Mon, 15 Nov 2021 10:48:23 -0800 (PST)
Date:   Mon, 15 Nov 2021 10:48:21 -0800
In-Reply-To: <20211028183101.41013-5-chooglen@google.com>
Message-Id: <20211115184821.1079331-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <20211028183101.41013-5-chooglen@google.com>
X-Mailer: git-send-email 2.34.0.rc1.387.gb447b232ab-goog
Subject: Re: [PATCH v4 4/6] remote: remove the_repository->remote_state from
 static methods
From:   Jonathan Tan <jonathantanmy@google.com>
To:     chooglen@google.com
Cc:     git@vger.kernel.org, gitster@pobox.com,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Replace all remaining references of the_repository->remote_state in
> static functions with a struct remote_state parameter.
> 
> To do so, move read_config() calls to non-static functions and create a
> family of static functions, "remotes_*", that behave like "repo_*", but
> accept struct remote_state instead of struct repository. In the case
> where a static function calls a non-static function, replace the
> non-static function with its "remotes_*" equivalent.

In patches 2-4, the same lines have been changed a few times, so much so
that I found it easier to review if I squashed 2-4 together. I'm not
sure what the opinions of other reviewers are, but I think it's better
if patches 2-4 were combined into one patch.

The only confusing part is the moving of read_config(), but that is
described in this commit message - it's moved to the outer (non-static)
functions so that the inner functions do not need to have a pointer to
the repo, only to remote_state.

So, patches 2-4 look good. I think they should be combined, but I'm OK
if they're left separate too.
