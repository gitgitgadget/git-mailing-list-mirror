Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFAB6C433E0
	for <git@archiver.kernel.org>; Fri, 12 Mar 2021 12:27:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 87E3F64FF3
	for <git@archiver.kernel.org>; Fri, 12 Mar 2021 12:27:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231240AbhCLM1M (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Mar 2021 07:27:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbhCLM0l (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Mar 2021 07:26:41 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B295EC061574
        for <git@vger.kernel.org>; Fri, 12 Mar 2021 04:26:40 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id ci14so52867768ejc.7
        for <git@vger.kernel.org>; Fri, 12 Mar 2021 04:26:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=0O3MZTlncnnwkRAfikxf4HQ1cI1c5AABn+ZVj7OhT+s=;
        b=FuQxXiZzCpByurwcdSpPLBt/X/GA0JM+7bnkG7PBD0Ip4UY/0OCh3COG8nmGAl7FNV
         MSlxgpy999iAzzXARca7LghzR0ejFYAP+IW7kAw+zvNVcktBQ9wTkxfyeb3zwOnhvqQ3
         0krEQ2GtLAYuMV5j4oWQGtZbWcXcX3CXK/00JKalCfnfhDXFj99IqnYADNVokf9rs3YR
         0V9aATheORzWz1WIGqmsTOF3Ms6Letfl6Xu/D6ZRDlJlomPDfbIb1utmevUmvUGXwuGk
         lnN2QY42oiMJbEFmmXncPn4CHEUgup7iWK5QEjaosJ/QkyZovhVxHWQywyN9Yj1h+l7Z
         Wsrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=0O3MZTlncnnwkRAfikxf4HQ1cI1c5AABn+ZVj7OhT+s=;
        b=VkuJOROKr/e4BrI/anf8h5qMY9SD+oc+mKO+18PZ0mlb7fJEt+/b9R1Dp+9RHVcH4/
         URV+5G8fweW819oS/nqKLf7zufijpInQxd2j6yDw0z/YJg6irbuJ+2QPwfmymhHrnSg7
         F1pcFGOE6QZq4JG1W0b3CXMOcsZ/hZYLCz8ZTWRjcJgsWWUInTCKXfWkXyNtAesi5Why
         3t8CCeyqLcekJLPeJsK3dxNvHINKJeGj8haBEb/bR0wmDAKdtU1E+oLdkDkbT7vtI7iq
         q4Ict7AjeV6lXtp4NWfKPdBSRKhbeQNnSxqAMo2Y9mlgsrGaMm3HY/12OToQoHsy/Qjd
         Hluw==
X-Gm-Message-State: AOAM532flhcKzIxTOPUGidp4rx+0MRfckQBu38u3W7nuGGUbA3JuorWB
        tvv799JHbb8JB56kaL2VQlQ=
X-Google-Smtp-Source: ABdhPJzDxx8pqEhzdlXANOwG1AGfL0XucdqcIWM+IRhakvokZq+ZLi/F15JDGVzGyKbINsBNkwH/0w==
X-Received: by 2002:a17:906:b159:: with SMTP id bt25mr8208802ejb.364.1615551999328;
        Fri, 12 Mar 2021 04:26:39 -0800 (PST)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id bv9sm2721515ejb.21.2021.03.12.04.26.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Mar 2021 04:26:38 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/2] [WIP] sequencer.c: carry forward notes on HEAD
 across "rebase -x"
References: <xmqq8s6tcuxc.fsf@gitster.g>
 <20210312030107.1849942-1-gitster@pobox.com>
 <20210312030107.1849942-3-gitster@pobox.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <20210312030107.1849942-3-gitster@pobox.com>
Date:   Fri, 12 Mar 2021 13:26:38 +0100
Message-ID: <87k0qcfthd.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Mar 12 2021, Junio C Hamano wrote:

> +# NEEDSWORK: Fix c762aada1ab3a2c428c with s/@/HEAD/;
> +
>  test_expect_success 'rebase -x with empty command fails' '
>  	test_when_finished "git rebase --abort ||:" &&
>  	test_must_fail env git rebase -x "" @ 2>actual &&
> @@ -867,6 +869,22 @@ test_expect_success 'rebase -i can copy notes over a fixup' '
>  	test_cmp expect output
>  '

I eyeballed c762aada1ab (rebase -x: sanity check command, 2019-01-29)
for a bit and still don't quite know what this HEAD v.s. @ is about in
that context, seems this is a stray FIXME comment for an unrelated test.

Maybe it would be better to have test_expect_failure etc. here as
appropriate?

> +test_expect_success 'notes are copied even rebase -x changes HEAD' '
> +	git reset --hard n3 &&
> +	git rebase -x "git commit --amend --no-edit" n1^1 &&
> +	git log --format="%s <%N>" n1^1..n3 >expect &&
> +	git log --format="%s <%N>" n1^1..HEAD >actual &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_failure 'notes are copied even rebase -x changes HEAD' '
> +	git reset --hard n3 &&
> +	git rebase -x "git commit --amend -m tweak" n1^1 &&
> +	git log --format="tweak <%N>" n1^1..n3 >expect &&
> +	git log --format="%s <%N>" n1^1..HEAD >actual &&
> +	test_cmp expect actual
> +'
> +
>  test_expect_success 'rebase while detaching HEAD' '
>  	git symbolic-ref HEAD &&
>  	grandparent=$(git rev-parse HEAD~2) &&

