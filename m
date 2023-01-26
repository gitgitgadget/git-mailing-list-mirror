Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B920DC61DA2
	for <git@archiver.kernel.org>; Thu, 26 Jan 2023 17:06:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231918AbjAZRGd (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Jan 2023 12:06:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231963AbjAZRGb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Jan 2023 12:06:31 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 398963C24
        for <git@vger.kernel.org>; Thu, 26 Jan 2023 09:06:30 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id z3so1524403pfb.2
        for <git@vger.kernel.org>; Thu, 26 Jan 2023 09:06:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H+jiKVdFloZM9A+QHFVsqFhhHpLJJZxdTjpIWMng1qE=;
        b=K0zstNlPaBtE2d6Smn86OX0jZCGTAt+ToVKrQRZXzrBkoPn8nTie5yAFmgJ4VSJgIA
         4HgsalMIgnougsOjeVZRj8CHFYDGBRnvXu/5qGrDvmVYkInrEmmHtd1gU9cy+xoCiO5X
         +SAYCnDUelln7pv7d+lENlvPG2B/BJ+gYZP5okmDL6+zKHtO/9LHKGRJFYBGd6Tyb9Vy
         p6c+4yLimU8ZQNMkwkYlIkKWXxZwG4xc+Z5VIrnO+m9IC5V0107o6w8EQn+qPG+YBnQq
         /F88n2Vaej5gjgehQ9Wq+WltwWteXGUFwLqLtlZ5aUfXjnBug0CJJRawlXnfY6DhR6om
         cmmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H+jiKVdFloZM9A+QHFVsqFhhHpLJJZxdTjpIWMng1qE=;
        b=PEgINIwncaTGsJhcyAL3CwQv+nSpLox8IudOd4rosxowIfb13arJfRxyC/oegFB9Lf
         bE3wYinRFdqBRStFN3j+6tyl4V9xjDuYlkFnj/Dby7XTKNbOH/C1l2wL7WzCa/GK97yw
         nvAE+UsTW8z/khyHPHQ8fJe63OGy3gEU1WtUHuk/JIOG0uLK2wN6uduWRRl5dtaNVnsO
         9YlubG7YNeDo7/3+K+VL+EjZCE/KyI/aiAzzZaPu173B4xNR03XfMv1wjEJ2oq6YAw61
         f11zLJz7QS9oxU/NHjHtaGOpZXLU0pOduU16/BVL0G4NVEL/X/P6RIUa4nvw9QuoFUwA
         N7NA==
X-Gm-Message-State: AFqh2koeSWao1u4Ukufr1A2Y0cYi8Mm2R0o4Kf0NWqdaHuCRDgcJul6O
        lgGrJBIp/RfjswQpxd6YhgIPRuCEe2g=
X-Google-Smtp-Source: AMrXdXsFKGjPX/J0xAqGZnurzaz1qN0kFGtZZ3QypyLz8/H9iBKsOCc58wFa/mwWjVJT3jaoQV8tHA==
X-Received: by 2002:a05:6a00:420a:b0:588:eac0:b05b with SMTP id cd10-20020a056a00420a00b00588eac0b05bmr37458285pfb.27.1674752789210;
        Thu, 26 Jan 2023 09:06:29 -0800 (PST)
Received: from localhost (137.22.168.34.bc.googleusercontent.com. [34.168.22.137])
        by smtp.gmail.com with ESMTPSA id 144-20020a621496000000b0058d9428e482sm1076009pfu.85.2023.01.26.09.06.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jan 2023 09:06:28 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH] bisect: fix "reset" when branch is checked out elsewhere
References: <1c36c334-9f10-3859-c92f-3d889e226769@gmail.com>
        <xmqqo7qqovp1.fsf@gitster.g>
        <0d04f8ed-6933-9354-1f64-24d827424c71@gmail.com>
Date:   Thu, 26 Jan 2023 09:06:28 -0800
In-Reply-To: <0d04f8ed-6933-9354-1f64-24d827424c71@gmail.com>
 (=?utf-8?Q?=22Rub=C3=A9n?= Justo"'s
        message of "Thu, 26 Jan 2023 03:18:23 +0100")
Message-ID: <xmqqzga5b4yz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rubén Justo <rjusto@gmail.com> writes:

> But, and this is what makes me think that "checking out will fail" is the wrong
> choice for "bisect", while bisecting, with the worktree in a detached HEAD
> state, the branch to which "bisect reset" will check out back (BISECT_START),
> is still considered checked out in the working tree:
>
> 	$ git checkout -b work
> 	$ git bisect start HEAD HEAD~3
> 	... bisect detaches the current worktree ...
> 	$ git worktree add work
> 	Preparing worktree (checkout out 'work')
> 	fatal: 'work' is already checked out at ...
>
> So, checking out back to the implicitly checked out branch sounds like it
> should not fail.

If that is what you are aiming at, I suspect that the posted patch
is doing it in a wrong way.  Instead, we should just declare that
the branch being bisected does not mean the branch cannot be checked
out elsewhere, so that

	$ git worktree add --detach ../another HEAD^0
	$ git checkout -b work
	$ git bisect start work work~3
        ... detaches ...
	$ git -C ../another checkout work

should just work, no?

I admit I haven't thought things through, but I tend to be
sympathetic to such a declaration.  After all, "bisect" is a
read-only operation as far as the branch you happened to be on when
you started a bisect session is concerned.  Jumping around and
materializing tree states recorded in various commits leading to the
tip of the branch and inspecting them would not change anything on
the branch itself.  And more importantly, the branch being checked
out in another worktree and modified there should not break the
bisection, EXCEPT that the final "git bisect reset" (without
arguments) would fail if the other worktree removed the branch.

So, how about removing the is_worktree_being_bisected() check from
find_shared_symref(), so that not just "worktree add" and "bisect
reset", but "checkout" and "switch" are allowed to make the branch
current even it is being bisected elsewhere?

That would affect the other topic, I suspect, as well.  It may be a
positive change.  Or are there cases I missed, where the branch
being bisected should not be touched from elsewhere, and we cannot
remove the check from find_shared_symref()?

Thanks.



