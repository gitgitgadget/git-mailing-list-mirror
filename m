Return-Path: <SRS0=YePV=76=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B881C433E0
	for <git@archiver.kernel.org>; Wed, 17 Jun 2020 21:18:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 13D4A2184D
	for <git@archiver.kernel.org>; Wed, 17 Jun 2020 21:18:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UBZYnTGG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726909AbgFQVSD (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Jun 2020 17:18:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726758AbgFQVSB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Jun 2020 17:18:01 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1089C06174E
        for <git@vger.kernel.org>; Wed, 17 Jun 2020 14:18:00 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id z9so4642335ljh.13
        for <git@vger.kernel.org>; Wed, 17 Jun 2020 14:18:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=WAfDjNu+O4FIXikSwZGA+2zXyxIRTf22zZwxQpB8P5M=;
        b=UBZYnTGGUYhB7OZTb0GmQu4V/qT0Y2aDOsD2IVc2K+/azSQxrOik35PK8O9t7FtyQD
         xB6DqtWUKZA4QO24iMjRsI64kB52+MpKMa/Gzbe++j9WI+o7+mJBvo89LhXQZKcgO8hi
         iOtul7hnBdo842uJ9lZP2JWVrTm8WcIh9u1ngX3IoDoM296blK3+x8LcF6Pw4Gp+aUvk
         7wJqRN7OWW9gpMFJ1Ci+jtUs/VSMfyGpwH8GzgtZq+ttYLH1I3uskGCuj0BGoR0KI+z7
         m04BpZPENUC73B7MxFFaBZ9zEIfNj5eki80oPgthvFP1Bj/MChwLpAX6NIMxlaNfrxtR
         PgVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=WAfDjNu+O4FIXikSwZGA+2zXyxIRTf22zZwxQpB8P5M=;
        b=Kkf/K8tBAwVtOTgtz3Fz13AZf9/QIPN6e0QGf1u0Yau7fba4XqOn4q9LcaBQkeOAb+
         k/H2n2r1TmVgD4Iy6x7LNtdHgEd0upIGeJKoEjL5gctWi22De9v2NXTaN3g9F0bcCfyg
         88k+zOZJeYJZnVd/oOrkiIB+sG5XZ+ZmEwo3LS0kHiS37k73wf3lOJ48bQ/b4zICJXFh
         hBO9Z084oyWBzKe+QXSy8VCCFoZ7VUyw6mS7FrN72NCmg07qMtAYqvechUZqLJ9DqeGN
         z9Dl+HWo1xevv4a+ERWz/kAQD3OzH1e1wFubpOyrLJpwQmiQwdhM2j1+2bVAPo/xzhkR
         WaYQ==
X-Gm-Message-State: AOAM530H9UTly9ICAIXXrLQPQS9b7QrlY3Eq7D39NfRiBrQ7Aww57SeY
        OAzwxx0i/P1tlLnS12kpb1f2fSNT
X-Google-Smtp-Source: ABdhPJyLiLf9yK+1v3x1a3U8L0Wn7M644n9OAc1UNyYtl4jGJQXHe5uWkHpyt2ZvtEahgrSpBpXhBQ==
X-Received: by 2002:a2e:8e8d:: with SMTP id z13mr535486ljk.461.1592428679209;
        Wed, 17 Jun 2020 14:17:59 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id y3sm185492ljk.39.2020.06.17.14.17.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2020 14:17:58 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     "Curtin, Eric" <Eric.Curtin@dell.com>
Cc:     Stefan Moch <stefanmoch@mail.de>,
        Philip Oakley <philipoakley@iee.email>,
        Christian Couder <christian.couder@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        "Geary, Niall" <Niall.Geary@dell.com>,
        "rowlands, scott" <Scott.Rowlands@dell.com>,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: Collaborative conflict resolution feature request
References: <BY5PR19MB3400EB9AD87DFE612AFD5CC390810@BY5PR19MB3400.namprd19.prod.outlook.com>
        <CAP8UFD3m9ANt6UOyOoMDy2haTJjhzL5ctFiki46ktgH3RLPqjA@mail.gmail.com>
        <BY5PR19MB3400AE170C9F5FF501D27B18909E0@BY5PR19MB3400.namprd19.prod.outlook.com>
        <432b9e0b-eedf-6d39-ebc0-0416f8574afc@iee.email>
        <87zh943bda.fsf@osv.gnss.ru>
        <39c45b18-194c-0ff1-4a6d-1db8dee788c7@iee.email>
        <fe2cd745-29a7-3341-d321-4199b184bc96@mail.de>
        <BY5PR19MB34004535CCF180CE5C63B731909A0@BY5PR19MB3400.namprd19.prod.outlook.com>
Date:   Thu, 18 Jun 2020 00:17:56 +0300
In-Reply-To: <BY5PR19MB34004535CCF180CE5C63B731909A0@BY5PR19MB3400.namprd19.prod.outlook.com>
        (Eric Curtin's message of "Wed, 17 Jun 2020 18:32:39 +0000")
Message-ID: <874kr92xyz.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Curtin, Eric" <Eric.Curtin@dell.com> writes:

> Hi Guys,
>
> Yes I think you all understand the conundrum well. Conflict resolution
> by definition is a collaborative effort, but git doesn't support it as a,
> collaborative effort, only one user can resolve it in git.

[As a side-note, I don't agree with "by definition" part of the
statement, nor with "only one user" part, so what is left?]

What I'd like to stress though is that there is a pitfall here: is it
feasible to try to support concurrent conflict resolution, or is it to
be sequential (even if in multiple turns)? I incline to the latter.

Concurrent conflict resolution would lead to conflicts in conflict
resolutions, that already sounds too complex to be useful for my taste,
and we already are in recursion that must be stopped somewhere, so it's
tempting to stop it one level up.

Admittedly, one can try to avoid conflicts in resolutions by splitting
content to independent parts (where Git is not easily applicable by
design, being the tool that manages entire content), but such a split
doesn't sound realistic, as if it were possible, it'd be easier to apply
it to avoid original conflicts in the first place. Then, a non-trivial
conflict resolution often needs changes elsewhere anyway, making strict
content split again problematic.

OTOH, anything sequential is intrinsically difficult for a distributed
system like Git, so it probably should better be implemented elsewhere.
This approach is simplified by the fact that fortunately Git doesn't
care how exactly you come-up with the resulting merge commit[*], so one
is free to use whatever external tool to achieve his goals.

-- Sergey

[*] Well, it actually does care in some corner cases, e.g., when it
drops or tries to re-create merges on rebase, and that will only be
eliminated once "evil merge" concept is finally buried, for better.
