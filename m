Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19599C05027
	for <git@archiver.kernel.org>; Fri, 20 Jan 2023 16:16:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbjATQQM (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Jan 2023 11:16:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbjATQQK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Jan 2023 11:16:10 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3966CB51F
        for <git@vger.kernel.org>; Fri, 20 Jan 2023 08:16:00 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id 5so433729plo.3
        for <git@vger.kernel.org>; Fri, 20 Jan 2023 08:16:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8ed4kRSDnpjS8oX37YJhjlmbFwdsBt4mzVefiwrOwLg=;
        b=jj6mOrpLR+gWg0T8QZhDMKUBXdubD+1K5rjeh5pGsG8wovjWs8eQpjsnI7iMbK4FYO
         DgB0dmAzgb2laKK43GAzBobIIsQ/2LMiqAOAQkqItEaCw+Kg199W9GHBiTPJFhmAq2Jr
         qdgG9Nrm3IiDOnq7JVw+qG6DRNo5OFFBM1kA918xy33o3bXi4XX+JAcwzbX4+cTiCpwl
         fdlANwzoNTpb5x1JhW7HHx9HVlSkCnfwothDEp3C9ZCjPra3lVcygN4RIC4EoDmG5VNk
         Wutq9CJdvu1SixUlG5DPg/FUiU4JHtmNLBr3guaE1ZdV47+bU2K8/Ad5hZhX2ix+DSBb
         9q2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8ed4kRSDnpjS8oX37YJhjlmbFwdsBt4mzVefiwrOwLg=;
        b=s72tyiSyFLy1OEtcKRvU5C1m6c9lLIYewyyHJksCqH4pc/CsSOK1vxRHuqbul6QYJf
         L0+Pv1nz48g1F7QYFuPmBU3JNdMHL7XPN9WONqHlBKARzBXIxbriyEDVhed5sn4y6teZ
         Bm7JVVxBf+tyTjiiyi9ho69TeRJU1eXJRnJH7Lh3vuV4tzikg8/jLGEkjU4l38nXmOO/
         iEzu4rN+83UeUBMQNwrMiB2v8/Dj4IRL9Uh6SZul+HUNnuni6S7Xp+eSskFH2e6+AScV
         bFKTublU7t28SbAEPBG+I65jlUiApajDR4gfBz7UQmpNTqszmsqWbFvZGVi9jJbzTGTJ
         YHXw==
X-Gm-Message-State: AFqh2koWO1zpaELZYzy8PobkxY6yReXUcAxddL7BgDJraQRhROQtFULB
        1z4fui8wQffn3HGO5XXCsAapqvJrWp0=
X-Google-Smtp-Source: AMrXdXsM7qo7zHNQZCSz3R7OTcmrBLZpp+o5zgoj/GpjIXcIoxXGsOmOrHOCgkaVb8ZDOAneyLvirg==
X-Received: by 2002:a17:90a:f483:b0:229:74a2:a692 with SMTP id bx3-20020a17090af48300b0022974a2a692mr16069824pjb.28.1674231360286;
        Fri, 20 Jan 2023 08:16:00 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id a9-20020a17090a688900b00219463262desm1681692pjd.39.2023.01.20.08.15.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jan 2023 08:15:59 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v2 1/2] rebase: remove completely useless -C option
References: <pull.1466.git.1674106587550.gitgitgadget@gmail.com>
        <pull.1466.v2.git.1674190573.gitgitgadget@gmail.com>
        <a0f8f5fac1c3f79cd46b943e95636728677dffef.1674190573.git.gitgitgadget@gmail.com>
        <xmqq5yd1za0t.fsf@gitster.g>
        <CABPp-BFakaEqnpW4Xn1rzcOC6oVmcEz+OxBV4dKA_TJZ-xbTvg@mail.gmail.com>
Date:   Fri, 20 Jan 2023 08:15:59 -0800
In-Reply-To: <CABPp-BFakaEqnpW4Xn1rzcOC6oVmcEz+OxBV4dKA_TJZ-xbTvg@mail.gmail.com>
        (Elijah Newren's message of "Fri, 20 Jan 2023 07:31:15 -0800")
Message-ID: <xmqqh6wlxjuo.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> On Fri, Jan 20, 2023 at 4:05 AM Junio C Hamano <gitster@pobox.com> wrote:
>> ...
>> That is, even when a patch does not cleanly apply with full context
>> in the incoming diff, by requiring *smaller* number of lines to
>> match, the diff *could* be forced to apply with reduced precision?
>
> Oh!  Reducing the number of lines of context to pay attention to never
> even occurred to me for whatever reason.  I'll drop the patch.

Yup.  "completely useless" on the title is less than half correct,
but still correct for a minor use case where -C is used to use
*more* context lines than the default.

We could update "rebase --apply" codepath to increase the context
lines generated by format-patch.  That would make the "completely
useless" totally incorrect ;-)
