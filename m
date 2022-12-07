Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9007AC63708
	for <git@archiver.kernel.org>; Wed,  7 Dec 2022 00:35:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbiLGAfV (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Dec 2022 19:35:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbiLGAfD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Dec 2022 19:35:03 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25E101B9C9
        for <git@vger.kernel.org>; Tue,  6 Dec 2022 16:35:03 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id v13-20020a17090a6b0d00b00219c3be9830so8472246pjj.4
        for <git@vger.kernel.org>; Tue, 06 Dec 2022 16:35:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iiTCWgQ85ItxpoMV/K8vlXIgP+oGv/xvUZz9ONIGNoY=;
        b=P8PfEGm8zUVYWZl9c3EQmLJYNC8+bSosW4qj60VnPbiomJp3s/x6m5bMlDwSgi3xVk
         2eJWvtR+MqijBt3/DCQK+3vO9hMO21HdOuPwyYaup3E2jERtsyStxPCZlHMzlt1CV4Hv
         eBdlzzyex08hIIWhUKtUOzQoc9JRwryxIJ+R5c6RPbIUv0CFMEMn3fagjbgAspbENLQF
         3iLm8cr/ds9N+EXb3C3lWoeu27SOofhLrq4irt/9Pn/ClIzhcmTuEjVH/J3pVLWGa5NC
         iCrIdG2CB0OFj++xeExyNt6Y8NsVRbBfU9urXhh6wz6jOkAuV8tKNQ56Al9KmDkxnEVI
         /8jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=iiTCWgQ85ItxpoMV/K8vlXIgP+oGv/xvUZz9ONIGNoY=;
        b=T8v0uqcPqRle42DIEa+QCMRZajVmnWzq7YaaChl0P8fg+yQJDV+SQ/kZMaRL633uRQ
         O7gUyS4Qdt6pYubl5UcC9SZiv4WdHs3Rgqc3ukSUYENG+nJXtzmpsq93XgDfGNtIrdSx
         QY7qqsS2JqM/HG96IThSBp9KhQtyfcjsT8oID4lfsxd+Ve+jsBdb5jP5Zan2wb3KHsPv
         YPqBSxI7R/McKRgbOhezh7U7aBCKkhPWOR01x+Vb52g9UrIPxEICbjBU4oWGigCv3zXp
         WV7g6JVkIhvO/uNSWKQTGZfeZJcRTBxg+y3b7WiRO/kSJiUEXjjFfYaBBhmVHUEZZLQu
         u/VQ==
X-Gm-Message-State: ANoB5pnYegL7SQGftl9P05UrUXcs9qSPR3MAnhLKHTYQJIRrJm+UTluJ
        xSpuEivcWzbSo3gt30r+Q+Q=
X-Google-Smtp-Source: AA0mqf72l5Plbut0x80SZsXMmYlTzbYzTrjuj7763e7x8O3ufk1NH06ZD/qlGXoQ3SwSzFnQu1exUg==
X-Received: by 2002:a17:90a:3d4c:b0:219:3db6:f194 with SMTP id o12-20020a17090a3d4c00b002193db6f194mr46659005pjf.27.1670373302445;
        Tue, 06 Dec 2022 16:35:02 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id y7-20020a170902d64700b00186c54188b4sm13121013plh.240.2022.12.06.16.35.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Dec 2022 16:35:01 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, Oscar Dominguez <dominguez.celada@gmail.com>
Subject: Re: [PATCH] ci: use actions/{upload,download}-artifact@v3
References: <pull.1354.git.git.1665388136.gitgitgadget@gmail.com>
        <pull.1354.v2.git.git.1670234474721.gitgitgadget@gmail.com>
        <xmqq1qpd9bys.fsf@gitster.g>
        <2s9ppo74-r654-231r-7ss7-o08464s2so6p@tzk.qr>
        <xmqqmt8085i6.fsf@gitster.g>
Date:   Wed, 07 Dec 2022 09:35:01 +0900
In-Reply-To: <xmqqmt8085i6.fsf@gitster.g> (Junio C. Hamano's message of "Wed,
        07 Dec 2022 08:41:21 +0900")
Message-ID: <xmqqa640830q.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>> This is probably incorrect, but you wouldn't know until something failed
>> in the `linux32` job.
>
> Yeah, that was what I was afraid to see.
>
>> I already have a correct fix in
>> https://github.com/git-for-windows/git/pull/4112/commits/b59c1e33fa62029f8d5dca801a8afb480514140c
>> and was only waiting for the patch at the root of this here mail thread to
>> advance further so I could contribute that fix, along with other
>> replacements for deprecated operations.
>
> Wonderful.
>
>> Maybe we can move these changes forward in a more orderly manner, with
>> Oscar's patch advancing to `next` once it is done, and the other patches
>> following after that?
>
> That was what I was planning to do anyway.  Thanks.

Eh, I should have made my intention clear.  I'll drop this one (as I
posted it primarily to fish out those who are interested in and more
capable than I am at clearing the deprecation warnings from the CI),
will mark Oscar's for 'next' (if I haven't done so already), wait for
your updates and queue them on a topic forked from Oscar's (or on
the same Oscar's topic), and cook them for the first or the second
batch of the next cycle.

Thanks.
