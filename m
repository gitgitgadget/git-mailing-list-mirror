Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63184C7EE2C
	for <git@archiver.kernel.org>; Mon,  8 May 2023 19:19:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233267AbjEHTS4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 May 2023 15:18:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233232AbjEHTSs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 May 2023 15:18:48 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D1A249E8
        for <git@vger.kernel.org>; Mon,  8 May 2023 12:18:47 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-644d9bf05b7so1521270b3a.3
        for <git@vger.kernel.org>; Mon, 08 May 2023 12:18:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683573527; x=1686165527;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=RcFfEEu1GhCQHDOj4GNQ1xoudw1OyV0nex82pA55aIo=;
        b=ApbnG4+h/QA5odtvvoa8g5Zwnknd/xyy8bsVHR5LGaXGpy2QvsVuhKXHO6ciaoKssH
         MLmMtaoHra83Sion0inazP8C/gjFUQ5bE+yqOuN58oBz+aF8orPKKDOJjvayv8edxXWt
         odWuw1icQ4NbRx/HD8tSqtU5TjgEXd9wmTk+X/oTDgE0TbwLudV4bHEbYeJhyDy43YKD
         2D3+qC7Xy3pc1GBZpQSVQgwghJ9QkPRqN+TrIpQa/FobVIJzc5MX4Rfdr3VA0V2OHXM2
         xu9u/OCZ3R1YRsU+IBBA2Op8FfacwZcs71KjYVyaiHPFbM5o8jtHXeds/ij94tyV7b28
         0HVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683573527; x=1686165527;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RcFfEEu1GhCQHDOj4GNQ1xoudw1OyV0nex82pA55aIo=;
        b=Mq+wexX24RMTf9OTobuS830z+k3UFBn8cFtrTthqG5CeY852ZwB40PtLvMDvXEhCxD
         H8aEhsCBpLTz2LFiphKPClouzL/U1Q7agbaCXsBryjcYFa6g+UdFVA3Sgw4vjf2V3NLy
         xGhUEYVKGUOBk+v6XJoX2akgHTKEtWzuoHP+86cPjbvKBUXqCKoGnqVXxesdXLQyaf3w
         NDiKDmtil29kcsfMMR8Ie4NgDuArpv8CHW+dkVxUhpF2Ld10AZG5RsZsSVKrJRv57SdJ
         qdBCG1j2MuSL72UxFyxRQozYJnDvG8R8MGpc8M1LxVUz/IKoRtXdLq/d6c2txU1AzRHW
         gJuQ==
X-Gm-Message-State: AC+VfDxIJILlL1lwSsI4+w6fkX97W1GUwRiEiwroKE+sC2teCrDMDkP5
        Swlgwt146gEBSjIJX1PqkU3h+IN0sAk=
X-Google-Smtp-Source: ACHHUZ70XDG97rY9lAoVeQtnaoNi41VdCaSaK0o1b1tASWOY4WcX5Ty9GShPU1ofuKUZx/xkaaaLMw==
X-Received: by 2002:a05:6a00:a81:b0:62d:8376:3712 with SMTP id b1-20020a056a000a8100b0062d83763712mr15922830pfl.28.1683573526660;
        Mon, 08 May 2023 12:18:46 -0700 (PDT)
Received: from localhost (187.137.203.35.bc.googleusercontent.com. [35.203.137.187])
        by smtp.gmail.com with ESMTPSA id a4-20020a62bd04000000b006413d1dc4adsm304380pff.110.2023.05.08.12.18.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 May 2023 12:18:46 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Tao Klerks <tao@klerks.biz>
Cc:     Felipe Contreras <felipe.contreras@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Tao Klerks via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] RFC: switch: allow same-commit switch during merge if
 conflicts resolved
References: <pull.1527.git.1683008869804.gitgitgadget@gmail.com>
        <CABPp-BH8A=CnO3_UWXDegb87VTNEX8s+=CefB90m1_vjBZ_+Fw@mail.gmail.com>
        <CAPMMpogiTVksUKgZ==n4d3xm4ZJqxm7ki2dOF8j8S5BaJvu1Ew@mail.gmail.com>
        <CABPp-BGmPKyNcDa-wUh-oisTvvux+X=6BvGxSNQC2O7uodpFrA@mail.gmail.com>
        <64581fc358ede_4e6129442@chronos.notmuch>
        <CAPMMpojTjFn7JCo8QsDcOJf6NoJYASbV1bL_JxDhUr7DS12DJg@mail.gmail.com>
        <64591fbddaf2d_7c6829457@chronos.notmuch>
        <CAPMMpoi74RFBptKkv23FSK-fQsnuan9EK5HodUBRLNtxLYdr_w@mail.gmail.com>
Date:   Mon, 08 May 2023 12:18:45 -0700
Message-ID: <xmqqzg6eocmi.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Tao Klerks <tao@klerks.biz> writes:

> The question, I understand, is whether there should be a "git -c
> core.suckycheckoutstatemanagement=true checkout" option *just in
> case*, so any affected automation users could set it, fix their
> affected automated processes, and then remove it, before we finally
> remove the "core.suckycheckoutstatemanagement" option in a subsequent
> release.

If a new behaviour is hidden behind a new option nobody has heard of
before, you would not risk breaking anybody who wrote their scripts
long time ago and have relied on them the way they currently work,
and the new option would not have to be removed at all.  I think the
"switch" was written exactly for such a transition so that folks who
wanted a different behaviour do not have to break existing users of
"checkout".

Do we still mark "switch" as experimental in bold red letters in the
documentation?  Then it is not too late to improve the end-user
experimence with the command without worrying about too much about
backward compatibility.

