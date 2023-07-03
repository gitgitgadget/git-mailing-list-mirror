Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1844EB64DC
	for <git@archiver.kernel.org>; Mon,  3 Jul 2023 16:27:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231281AbjGCQ1C (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Jul 2023 12:27:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230303AbjGCQ1B (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Jul 2023 12:27:01 -0400
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com [IPv6:2001:4860:4864:20::30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A64590
        for <git@vger.kernel.org>; Mon,  3 Jul 2023 09:27:00 -0700 (PDT)
Received: by mail-oa1-x30.google.com with SMTP id 586e51a60fabf-1b09276ed49so4364190fac.1
        for <git@vger.kernel.org>; Mon, 03 Jul 2023 09:27:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688401619; x=1690993619;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lrLs7REPFu6c15CQ4xY0LuOOik8deaTt8AMEge+Wzns=;
        b=OODxqTi3b6aLDxWJCtv6tHxUbQt5dX5b17fzYInT6BHyN1GcEPEQJzocFW+BWDZi6z
         urDsJzDX//r4wlz9RRNeCv0fG4v2w4aa9kqxxfLi6lubA9vBUIJuevzP2DIi0RpZhBty
         1nJaEqzwE3n00BMgvDOc0AXr8BmStKKcpOcXSZPQwyFLMYUc0ptY8SI8ekJaKVQkl/GZ
         Es+HLQtnpn7S7gzlzLoLrGhopIATSSSxSfLmkjnAzx/LCNo3z5dtH9/WMBuiU/tjFuEv
         u+0lByg/tYPGjJz000S6PudFhZXyogxSWN89J6HjF6XxDXYKeR5mMA173QjXl4SY5m/X
         1+/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688401619; x=1690993619;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lrLs7REPFu6c15CQ4xY0LuOOik8deaTt8AMEge+Wzns=;
        b=IuIi/WP9/+o55idoRXd3DZNBOKru3BAHQ4rZKn3fPMGKymyckJkwwUpQGwlwrsKOP5
         xHZ/NjmnwIuA8iX+kq5F7OkuQ4hq6TQUzu8S2x8G2epPvnePh1iP2+EjkXh7jOLVVhjo
         VZEh6TV4sjp/ZPDP6iU1n2dPCu98xVryzUlmD7FDx29M16+WAb10TjEs4IddIloh4IuN
         Ia4z2PagzqiVL/bMGQYW816MJ1j6XW9+rF9ZAyeG1iHDgceTI6dIkPV+rTV5S4vksGia
         3uvVtsHMWffiZa1M6IwVUZESwqgqAQ0p7ZuCSyI6uCjyUhPIMHh5crKvpQPkgvkmR8+0
         RRrQ==
X-Gm-Message-State: AC+VfDyz1DA6a//qviCObbhDQD+kVUdZ1f/erp8ZNJRw7xcSzWX0v9HA
        ejeGaHQmTmywTWJoBjiYMW9uk9K8Wsoor+iRkas=
X-Google-Smtp-Source: ACHHUZ7NCtK9KGeqafU+E1fGpJawjonjsxCcmp8ZdVeK9otj2TSa1QcrIwJ6IuKS4MFqxvKGGheozwvIweFcW2hTyEU=
X-Received: by 2002:a05:6870:42ce:b0:1aa:1c3f:808 with SMTP id
 z14-20020a05687042ce00b001aa1c3f0808mr11877977oah.55.1688401619547; Mon, 03
 Jul 2023 09:26:59 -0700 (PDT)
MIME-Version: 1.0
References: <20230702200818.1038494-1-alexhenrie24@gmail.com> <c3c36f93-3fc5-7f7d-1c24-e6925729cc96@gmail.com>
In-Reply-To: <c3c36f93-3fc5-7f7d-1c24-e6925729cc96@gmail.com>
From:   Alex Henrie <alexhenrie24@gmail.com>
Date:   Mon, 3 Jul 2023 10:26:23 -0600
Message-ID: <CAMMLpeTDqABQij5=h5aaJT4auCoKzhX7LEX02bxRFn=YtCPZfw@mail.gmail.com>
Subject: Re: [PATCH 0/2] advise about force-pushing as an alternative to reconciliation
To:     phillip.wood@dunelm.org.uk
Cc:     git@vger.kernel.org, git@matthieu-moy.fr, christiwald@gmail.com,
        john@keeping.me.uk, philipoakley@iee.email, gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 3, 2023 at 9:33=E2=80=AFAM Phillip Wood <phillip.wood123@gmail.=
com> wrote:

> On 02/07/2023 21:08, Alex Henrie wrote:
> > Many times now, I have seen novices do the following:
> >
> > 1. Start work on their own personal topic branch
> > 2. Push the branch to origin
> > 3. Rebase the branch onto origin/master
> > 4. Try to push again, but Git says they need to pull
> > 5. Pull and make a mess trying to reconcile the older topic branch with
> >     the rebased topic branch
> >
> > Help avoid this mistake by giving advice that mentions force-pushing,
> > rather than assuming that the user always wants to do reconciliation.
>
> I don't think we want to be advising users to force push. For the case
> you mention above I think it would be much safer to advise them to use
>
>         git push --force-if-includes
>
> In the absence of background fetches even
>
>         git push --force-with-lease
>
> is still safer than
>
>         git push --force

Hi Phillip, thanks for the feedback. --force-with-lease would be fine.
I'll make that change in v2.

Regarding your other suggestion, --force-if-includes doesn't do
anything unless --force-with-lease is also specified, and I think
recommending that users always type --force-with-lease
--force-if-includes is a bit much to ask of them. It also could lead
to confusion if the user has decided to delete the local branch and
start over, and is now trying to push the new local branch over the
old one on the remote.

-Alex
