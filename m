Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 091F2C05027
	for <git@archiver.kernel.org>; Thu, 26 Jan 2023 17:13:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231839AbjAZRNK (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Jan 2023 12:13:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231629AbjAZRNI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Jan 2023 12:13:08 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF44939280
        for <git@vger.kernel.org>; Thu, 26 Jan 2023 09:13:07 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id f3so1489313pgc.2
        for <git@vger.kernel.org>; Thu, 26 Jan 2023 09:13:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=702D9PRk5zx4wuZwPHUqJD6Qi3WQw6pphieUx+Z8nqY=;
        b=ZMz/D90dSIzNAUZmVOMtc0OAW9mceXpT719RxiVr1ODRoSWegoh9eZgIetSh25paOg
         ZX4mr3gq5046RfBBhZrXi2eLUS2HvTicKC5/O+TRX3unskgoGDC2yNncO5DA8OARztgE
         33gtu25nThY1w7LZE2R96X/fGYPF5odjvfqc41Yx9wUwGjazGdx58zpP5sOKxN+I4m6n
         Yjp2ciO3OZi8Md4GRJ9+mZV0gqn+n0xRrim9eO8wBQYPed0d24CqoSRiVuz1BKqOmQdJ
         F4GfypOkcCUbIMSQa1EezhFS5b2h+erMclbVpJX9MVpOEqx8Th90Cql/vyr5hUMmrpzM
         fNUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=702D9PRk5zx4wuZwPHUqJD6Qi3WQw6pphieUx+Z8nqY=;
        b=V6F5Lyrq1u9h2NhVyxLco8eDLbwnesqKxKFSjjXkSLohaYUjL3IVE3dBnbjNd+5iO5
         rRIT+/dBmVuolccTwku65sueBbOyP6F9yeaKuthf6Bwbz9C1bp1OpJ0ct1lb1u6NUKxq
         wT09dd0VgJ6zTwUJ9pFRsZFjmEGlR18ICi5No+t4FxQPjiaivVenaQ3kQbu93HLbjIpY
         jFP7NlNQLRonOXzO5fP353aSmQJgcspR00Fyxr2q42YbGasN+j9vXOR8PpuMumyHNYGe
         7kMb2fIRMcalkVto7KxY9h5cCoZ1Nqxko6HPqYLngwtsFhLaK2ePvjcgEPf3eRll3NEv
         abkg==
X-Gm-Message-State: AFqh2kqJEhAdJ53OfN40Fy1PZgyGvS2qzOVMqCoiuUskX3oAcUhxVBaq
        KmWJkbqlavFyBQylh0ihpSPBAosI4es=
X-Google-Smtp-Source: AMrXdXvPoH/A7IoPY5rdOVV6KSoh0gkz6kpHpLVYTDW9/kSaLwlzrr2M+cfzHqXYrLEWNxJ2UuiE7w==
X-Received: by 2002:a05:6a00:1d8d:b0:580:cc63:dcdc with SMTP id z13-20020a056a001d8d00b00580cc63dcdcmr35521576pfw.7.1674753187285;
        Thu, 26 Jan 2023 09:13:07 -0800 (PST)
Received: from localhost (137.22.168.34.bc.googleusercontent.com. [34.168.22.137])
        by smtp.gmail.com with ESMTPSA id g1-20020aa79f01000000b005815017d348sm1082836pfr.179.2023.01.26.09.13.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jan 2023 09:13:06 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH] bisect: fix "reset" when branch is checked out elsewhere
References: <1c36c334-9f10-3859-c92f-3d889e226769@gmail.com>
        <xmqqo7qqovp1.fsf@gitster.g>
        <0d04f8ed-6933-9354-1f64-24d827424c71@gmail.com>
        <xmqqzga5b4yz.fsf@gitster.g>
Date:   Thu, 26 Jan 2023 09:13:06 -0800
In-Reply-To: <xmqqzga5b4yz.fsf@gitster.g> (Junio C. Hamano's message of "Thu,
        26 Jan 2023 09:06:28 -0800")
Message-ID: <xmqqr0vhb4nx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> the branch itself.  And more importantly, the branch being checked
> out in another worktree and modified there should not break the
> bisection, EXCEPT that the final "git bisect reset" (without
> arguments) would fail if the other worktree removed the branch.

And "bisect reset [<branch>]" (with or without arguments) should not
ignore other worktrees when it runs "checkout" internally.  You
might have done

    * checkout 'work' in worktree A
    * start bisection of it there
    * checkout 'work' in worktree B
    * finish bisection of 'work' in worktree A
    * "git bisect reset"

and the third step should allow you work on 'work' in the other
worktree, but then the last step should not allow 'work' to be
checked out in two places (it is OK for the user to use "git bisect
reset main" and then "git checkout --ignore-other work" to work it
around, of course, but the default should be safe).

Hmm?
