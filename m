Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D724EB64DA
	for <git@archiver.kernel.org>; Tue, 13 Jun 2023 19:45:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230045AbjFMTpb (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Jun 2023 15:45:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239278AbjFMTp3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Jun 2023 15:45:29 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BDDA199B
        for <git@vger.kernel.org>; Tue, 13 Jun 2023 12:45:28 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1b3c0c476d1so25076255ad.1
        for <git@vger.kernel.org>; Tue, 13 Jun 2023 12:45:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686685527; x=1689277527;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PnjqkC5rvfos8XHGP9ilLmahnmhKOworr9uFqCpvPS0=;
        b=G7xAk6Xd9ldnHdxrYZFUSG03e72jjK9Z2dqbvrVIwry7Z88IiIajzniN4QRr8QqzEF
         yCVnGDLXEMTY3Ozm1wZbQJu52QHiuwkWbC0kJMbvcJWSLr7Xz6eo2+cczhEl06HsFUIE
         kZVvk44DEaY+cQsDHa2xxl01MNSS6K4BP4tJMaNgcsTCImd+th8Zb5zWjjVR0uaqFj9N
         jtYPcRETskxjM6f0n4UzxSAQKDlqx9flqMAouOR7WrxOXmB9NggXwp+Po5Zywmww3NGJ
         H+AHdG57Cw5NkR1VoSDfps8VuZBK5xkgm4Fj28er27kNIcfX/HO2fzx7yr5O3a1luTuL
         vk/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686685527; x=1689277527;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PnjqkC5rvfos8XHGP9ilLmahnmhKOworr9uFqCpvPS0=;
        b=bZ+rmQAHIKPCu3jYQfuL1fFlFoG+6Plc8M4TEINhOW2ehozc3GyikCZu0hq+evx3L7
         jGvNe2AQVqJ5T0iGvQ8aEVBpxPZF5CN/8QVYOJp03AgV3I+NRMK61n00T2rGBpooPYOB
         XCQ1Z7M+mhpGlB5M0FodfGT5rb3ocKMBGDN+wR60uKDK/0a7F0eiCenb5Eo1/TYSfaYk
         yAdtg+KMNCgsZC5z7M16u9QRSbyiDtP2xLniAmITatF5eWsO9FeY3Xm0rvFrkbEid5AM
         nhVP3/Rv0q+MEphf/g5h0Vde/S/I9st63ENesttKh7ORm1yFuR7FD/Jk06O/8WgQ4lQK
         j1ig==
X-Gm-Message-State: AC+VfDzpI1XFq5+mG5YMybiLHD4/SEOGdFWFIW13D/8HC0VoJ+9PBBbI
        9nAmrJyfPk+0aDIKOJyxwKQ=
X-Google-Smtp-Source: ACHHUZ6hCjywwAlMe0h8ekpf7OuFfFkpko5Brj0EDz1CBbi6+e/DI8HhkUJJ9ZLaVXfBfKR9eY6r7g==
X-Received: by 2002:a17:903:4d5:b0:1b1:b0ec:462d with SMTP id jm21-20020a17090304d500b001b1b0ec462dmr10538555plb.39.1686685527451;
        Tue, 13 Jun 2023 12:45:27 -0700 (PDT)
Received: from localhost (128.65.83.34.bc.googleusercontent.com. [34.83.65.128])
        by smtp.gmail.com with ESMTPSA id i9-20020a17090332c900b0019e60c645b1sm2125235plr.305.2023.06.13.12.45.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jun 2023 12:45:26 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Glen Choo <chooglen@google.com>
Cc:     Victoria Dye <vdye@github.com>, git@vger.kernel.org,
        Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        derrickstolee@github.com
Subject: Re: [PATCH] setup: copy repository_format using helper
References: <kl6lr0qgfmzo.fsf@chooglen-macbookpro.roam.corp.google.com>
        <20230612230453.70864-1-chooglen@google.com>
        <9fb6d7b1-00b6-93ee-efec-9dd0ab91a66d@github.com>
        <kl6llegnfccw.fsf@chooglen-macbookpro.roam.corp.google.com>
Date:   Tue, 13 Jun 2023 12:45:26 -0700
In-Reply-To: <kl6llegnfccw.fsf@chooglen-macbookpro.roam.corp.google.com> (Glen
        Choo's message of "Tue, 13 Jun 2023 11:25:51 -0700")
Message-ID: <xmqqpm5z404p.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Glen Choo <chooglen@google.com> writes:

> Victoria Dye <vdye@github.com> writes:
>
>> So, shouldn't it be safe to shallow-copy-and-NULL? But as I noted earlier
>> [1], if you do that it'll make the name 'check_repository_format()' a bit
>> misleading (since it's actually modifying its arg in place). So, if you
>> update to always shallow copy, 'check_repository_format()' should be renamed
>> to reflect its side effects.
>
> My understanding of check_repository_format() is that it serves double
> duty of doing a) setup of the_repository and b) populating an "out"
> parameter with the appropriate values. IMO a) is the side effect that
> could warrant the rename, and b) is the expected, "read-only" use case.
>
> From that perspective, doing a shallow copy here isn't really
> introducing a weird side-effect (because the arg to an "out" parameter
> should be zero-ed out to begin with), but it's returning a 'wrong'
> value. You're right that it's safe because the NULL-ed value isn't read
> back right now, but it's not any good if this function gains more
> callers.

Thanks for having this discussion.  The above makes perfect sense to
me.

> The helper function might not be a good idea yet, but I'm convinced that
> removing the setup from discover_git_directory() is a good idea. I think
> this series would be in a better state if we get rid of the wrong
> pattern instead of extending it.
> ...
>> I think you may be missing changes to 'discover_git_directory()'? Like I
>> mentioned above, though, if you don't think 'discover_git_directory()' needs
>> to set up 'the_repository', then those assignments should just be removed
>> (not replaced with 'setup_repository_from_format()').
>
> Ah sorry, yes they were meant to be removed. I somehow missed those as I
> was preparing the patch.

It looks like you two are in agreement at the end.  It does feel
that the change to make discover purely about discovering extends
the scope a bit too much, but it would be a good direction to go in
the longer term.

Thanks.
