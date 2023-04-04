Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB821C6FD1D
	for <git@archiver.kernel.org>; Tue,  4 Apr 2023 18:20:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235633AbjDDSUb (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Apr 2023 14:20:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232011AbjDDSUa (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Apr 2023 14:20:30 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 758F930F8
        for <git@vger.kernel.org>; Tue,  4 Apr 2023 11:20:29 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id lr16-20020a17090b4b9000b0023f187954acso34856666pjb.2
        for <git@vger.kernel.org>; Tue, 04 Apr 2023 11:20:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680632429;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jLx+x3nAkdtCUIDcB01KkSE67G619VW7zSIh372uWKc=;
        b=WHMRCifVbICj39GM9Ht9pOayJzZpiM38LFg/n9KcuDkJowPf9iP+9WgK865gjMgqy7
         cyLesP4VJ63pMS792uwUkoJrgqFP3UsO892d/OR5ljy0ISMZXCm3IPcVOTPE24MNSFKr
         0/N+FKU/Z8a3Z1H8HVEQL/Kki6ZsE4ljS6Ji1LluXJLn1ha9BkpeGTdxkWQcIU4oROyH
         yMtPxJxfmTfokC3A7Z1FECjnMbAmBVzZfDlcqPxMuIUJcffNYOp411b6KPeDHxdccfyE
         UD16HS4lo3v2TC9I/tl6Ym63F6wiueLXFcybAwP9tv7KwGoEzJSQFS4wrSX85K5DKqaO
         SWuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680632429;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jLx+x3nAkdtCUIDcB01KkSE67G619VW7zSIh372uWKc=;
        b=cBcWiGajasMBUhWRaJtboI0ioiikcEFch674+z6DsZN71AND256erPDhJpL6KRIev0
         wgVTihT/pcl9gTPZL5OCsTmNix0X5gDNfE87BGIyzli64eQOksAW/j7ReVanlWGffYZ6
         VsW7B2TOgHV8WaQtjDbs7Dg4fVka4Cj5L5W8bN2nqiQtVHHz8xVpFG+yq3ta+Bt++LmL
         KTiSkU78q2zTBYdMPfa0KPJl35/U8GFUUQpGUkk8CXm7e3Rf1DtdO0z3FJ5yC4jGUaGP
         +y1savKn3J3wj3qitgD4dY5XDtzW6iHJiQ5cXVxHx94zxcrIiaX3seBalqnxIUhdPZ9f
         TQYA==
X-Gm-Message-State: AAQBX9dFEpTeRKdHve7a/yx0Rx+XQ6qA66AqKzaGq9qr1jTo4L/nXoM0
        JpIgDVFnvzWPsDb1yvaxwYk=
X-Google-Smtp-Source: AKy350acJxqNMAQg2rpFH3LDpj6Ml6NwO9fHuwclOa0Ob8UQRwASoYE0I+mTftOt8fHh81nTVQadIg==
X-Received: by 2002:a17:903:228e:b0:1a1:9787:507d with SMTP id b14-20020a170903228e00b001a19787507dmr20066plh.3.1680632428727;
        Tue, 04 Apr 2023 11:20:28 -0700 (PDT)
Received: from localhost (254.80.82.34.bc.googleusercontent.com. [34.82.80.254])
        by smtp.gmail.com with ESMTPSA id p3-20020a1709026b8300b0019a91895cdfsm8669275plk.50.2023.04.04.11.20.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 11:20:28 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Sergey Organov <sorganov@gmail.com>
Cc:     Chris Torek <chris.torek@gmail.com>,
        Hongyi Zhao <hongyi.zhao@gmail.com>,
        Phillip Susi <phill@thesusis.net>,
        Git List <git@vger.kernel.org>
Subject: Re: git revert with partial commit.
References: <CAGP6POLrtA_9kjCwUbVB8-F+dgQbhz==oy5SsXULfspNj_Umuw@mail.gmail.com>
        <87edp0ak45.fsf@vps.thesusis.net>
        <CAGP6POLVpjxO91s1dX98TLepXMrybSWq9y8qJ6b7w+e0SRJT1A@mail.gmail.com>
        <CAGP6POJr63o67k+7BeokM-pkPbXYrQy4kcWwMXTfoeuFaPaADQ@mail.gmail.com>
        <CAGP6POLx0+OhMJ9oqmK8R9Lq7tppC258NWHNFhqXMbO9smXd+w@mail.gmail.com>
        <CAPx1Gvcz6f3AQJYfq7Sih0bL6pAi5mHZj8rj=kd7kRDWKLZEzw@mail.gmail.com>
        <87lej7zhpt.fsf@osv.gnss.ru>
Date:   Tue, 04 Apr 2023 11:20:28 -0700
In-Reply-To: <87lej7zhpt.fsf@osv.gnss.ru> (Sergey Organov's message of "Tue,
        04 Apr 2023 20:21:18 +0300")
Message-ID: <xmqq4jpv1pcj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sergey Organov <sorganov@gmail.com> writes:

>> This kind of operation produces a new commit, so there's no such
>> thing as a partial revert or partial cherry-pick, at least in
>> terms of "things Git can do by itself".  But we, as humans writing
>> programs, wish to *achieve* such things.
>
> So, why Git can't help us achieving it by supporting paths limiting in
> (all) merge operations? There seems to be no absolute obstacles, just a
> luck of support.

I think there is no fundamental reason to forbid an optional
pathspec to "cherry-pick" and "revert", given that a commit that
results from either "git cherry-pick" or "git revert" is called a
"cherry-pick" or a "revert" merely by convention and there is no
tool-level support to treat them any specially at merge or rebase
time [*1*].  It would make it harder to design tool-level support
for full cherry-picks or reverts, but that is a problem for future
generation, not ours ;-)  Allowing pathspec to "merge" and recording
the result as a merge of two (or more) parents is an absolute no-no
but that is not what we are discussing.

But in practice, the part that takes the most brain work in a revert
or cherry-pick that is not an outright "the effect of that commit as
its entirety is now gone" is not the mechanical (partial)
reapplication, but coming up with a good split of the original (or
the reverse of the original) and a good explanation.  Especially
given that it would be just the matter of running these commands
with "--no-commit", selectively resetting the paths that the user
does not want to touch, before spending some quality time describing
what the user did in the resulting commit, it is very understandable
if teaching pathspec to these commands has been outside anybody's
priority list so far.

But I do not think Chris meant to say "you should not expect such a
feature"; what we heard was a reasonable explanation of how the
current world works, and I do not see a reason to react strongly to
such a statement as if you were unreasonably forbidden from doing
something sensible.


[Footnote]

*1* If there were, it would totally be a different story.  For
example, merging a branch that has a revert of a commit X to a
branch that has the original commit X _may_ want to avoid replaying
the revert from the side branch in the result depending on the
circumstances, but it will be even less clear what to do if such a
"special cased" revert were a partial one).
