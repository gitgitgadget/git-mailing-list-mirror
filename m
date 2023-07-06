Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE134EB64DA
	for <git@archiver.kernel.org>; Thu,  6 Jul 2023 02:33:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232842AbjGFCdg (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Jul 2023 22:33:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbjGFCdf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Jul 2023 22:33:35 -0400
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50C951B6
        for <git@vger.kernel.org>; Wed,  5 Jul 2023 19:33:34 -0700 (PDT)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-1b0606bee45so308359fac.3
        for <git@vger.kernel.org>; Wed, 05 Jul 2023 19:33:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688610813; x=1691202813;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SINskWsr7213U9d04MGSjauO3tZkQXB6JYJI3kWBO38=;
        b=CgvwrF9oebxiaGHr5h2ADms7t3zh3BK21wADO5cukJt27HmDhIHe6oZb9TBf5bO6Os
         SOlMsuC7QzMcBstgejpQvehmccNnydZoCPMyMvfM0nFEKJwtV1NLT87TdYijcWtc1WJW
         7iB9HzVU/fYe0MSTr5t8CSOmbyNkG8G8ywQfuTevpQF+Wz0iLD3cpsmwdlOh5sbviaRn
         RD2vIgCQX8claWeIQbgyseLAEteO9bCm8irfj6UfW2M5M854fEaJq8K+RxgmxrNsY+JY
         ZiIGURRq6XOp/Zus33Me7FGJR08sAmwb67ZTij8N0ghdThijtF70kYKEOsri2zBwdhKr
         c/dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688610813; x=1691202813;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SINskWsr7213U9d04MGSjauO3tZkQXB6JYJI3kWBO38=;
        b=c2BdCCVBzN08qzVOEkQL+dYZU2I+uXPkRUwPnjov5zb+pB1vvGebQV25bwoh7yztwX
         7aIoiIaTqLqDmYNJWa8iOPRfFArfYyFtS3krejKDDE+5sGYxm7GcKgBUh7WglmS5IX+R
         zzmhXUymHLZR+7+Md537MC2tguU4ucLhIArbswS7/uCV88iWY0tq9haRNgheH5VaI5ZH
         v8WIc+5LvILzXZZBoY+8ZpwAp1JYrd4lLa3yayGheUCM8k6wWzzMaN7sYe7REAmZwm5v
         tu+TBFF8mQgbhLU2EomLimhJu3ExzVRSl0F0V/vjl3KbXHySaHrxbyZPe4XzBF+r0qqP
         6dXg==
X-Gm-Message-State: ABy/qLaCxV3x6kL3/gnlgCZHivKwdBbTUq3L33/AsabyfQ2Nj5Qd8cYY
        oA4mUCmjMVzoCcCnYHErDYipBK8PPDFTrXJt4Po=
X-Google-Smtp-Source: APBJJlGPjiUYZdYdWP53PfHTWYQmmAbvjT/PYkLeQqdBJFhk+stK4Oi/B/lM6VR4NmGWSFLPFF7c746UAyaQQNlbnZs=
X-Received: by 2002:a05:6870:ec86:b0:1aa:9eb6:974d with SMTP id
 eo6-20020a056870ec8600b001aa9eb6974dmr1244638oab.41.1688610813559; Wed, 05
 Jul 2023 19:33:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230702200818.1038494-1-alexhenrie24@gmail.com>
 <c3c36f93-3fc5-7f7d-1c24-e6925729cc96@gmail.com> <xmqqv8ez4ajb.fsf@gitster.g>
 <CAMMLpeS5QJrFFnN14n33_LiaN9MP5Ea=HV24ZFM30zPnmhoqZw@mail.gmail.com> <xmqq5y6z3oym.fsf@gitster.g>
In-Reply-To: <xmqq5y6z3oym.fsf@gitster.g>
From:   Alex Henrie <alexhenrie24@gmail.com>
Date:   Wed, 5 Jul 2023 20:32:56 -0600
Message-ID: <CAMMLpeRPcw8WbGJwbeS_E+qxKvCukNc3g-3BXeNP5BrRJJ5ifA@mail.gmail.com>
Subject: Re: [PATCH 0/2] advise about force-pushing as an alternative to reconciliation
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Phillip Wood <phillip.wood123@gmail.com>, git@vger.kernel.org,
        git@matthieu-moy.fr, christiwald@gmail.com, john@keeping.me.uk,
        philipoakley@iee.email
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 4, 2023 at 11:30=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:

> I think the description in the cover was prone to be misunderstood,
> but I think I got it now.  Where you are pushing from your topic
> branch is your "publishing" branch that only you would push into,
> and the primary way you update it is by rebasing your local copy of
> it on the updated 'master' branch to keep up with others' work
> integrated into the shared 'master'.

Right. It's a narrow case, but it's quite common. For example, GitHub
and GitLab keep permanent references to every version of a branch that
was pushed while a pull request was open for that branch. On those
platforms, force-pushing is analogous to emailing a new version of a
patchset.

> In such a workflow, the way to update your "publishing" branch will
> normally be to force push to overwrite.  And in this very narrow use
> case, where nobody else is pushing into your "publishing" branch,
> your remote-tracking branch would be always up-to-date with the
> remote repository and use of --force-with-lease that does not say
> which commit you expect there to be is safe.  In fact, you do not
> even have to use --force-with-lease in such a use case, because its
> additional safety (relative to --force) relies on the assumption
> that you would be the only one who is pushing into the remote
> repository to update that branch---and at that point, --force
> without lease is just as good.

OK, I'll switch back to --force in v3. Thanks for the feedback!

-Alex
