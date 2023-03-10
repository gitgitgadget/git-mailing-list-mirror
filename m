Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02481C64EC4
	for <git@archiver.kernel.org>; Fri, 10 Mar 2023 17:06:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231868AbjCJRG1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Mar 2023 12:06:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231892AbjCJRF6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Mar 2023 12:05:58 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 584A912B965
        for <git@vger.kernel.org>; Fri, 10 Mar 2023 09:04:23 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id a2so6278063plm.4
        for <git@vger.kernel.org>; Fri, 10 Mar 2023 09:04:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678467863;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LVGxlL6nPuz1fU8ZvoMteTDnNieGct/H+mnnUJhOLk4=;
        b=hXTQPL/uIqzQApTzJN48mJJIM3GqG+vlMtkncA/MAUvpT6v1SnB3NMCa8O/Rk3LhgA
         L7I3YU4VyixvJnhgFJas/mp3xishZf//EyyS+Z+LP8beSfrBI4r9oVvuQTfe6D1oslOs
         WB790K9bvGh8KaNK2DViwX+oJ9iP2TpvWXa/WlOhO4GE3ZG+U0Pqv5FL+3AjiwAQvg2n
         ty2AIDIDmv045Lm1WCjy8cvsMMunj4OdKA3zDMlndBYUeAJ/HYFd+cAHc+skKCU9gTj5
         Kg7kFr1fYVn08f6JtGuQb5uQalWM1zwDti2hoSGideK2/R8hlbz/XVmrQ2kuAJQ3V7g9
         Vg0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678467863;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=LVGxlL6nPuz1fU8ZvoMteTDnNieGct/H+mnnUJhOLk4=;
        b=O3zv5xy7ZazqM93hALE/p9ZvDLXsxzB0x7vmy7F9nMORmP4FeQJvN1Hm0oKqgMgzvD
         6iS9G+9GtLDhADo3FzpA6bG3sFmpeo47LtCx4KJ0WnEII8VUbSkyaWSvp6AZFcPoQ/UP
         znsF9Yb1s5wOpqJCJN5wdTDhnW+ppP79/xl6V3H217+edeU+/XAclOd2l4My5FkIj4Bw
         Jy6pE1oU+ifvRQKVQ+e7lIuCtSyRQQjtj4XbECa6COy5kBvL0zNDq6tI1H/Vjgb1DmNX
         XnqDnMgsxq6QALXi96VCPTALrmVSgXHIFShjzSIyPxVtmmYdH2ck978dVjyX/hQ6SPq5
         MwYA==
X-Gm-Message-State: AO0yUKXPZCBiqCozoudEO9Kb0DCbLCbBWDr+HzJVmHXZ2nqHpiKo5HO3
        vNUfwNb7FXP3J6pZ811pdpE=
X-Google-Smtp-Source: AK7set+otJ8krB8LefEgaayz4LDoSMX/IArbgbvITOEhs7Q9C6YyKVeqX0s5J62mhYEEZyoyOKOi7w==
X-Received: by 2002:a05:6a20:3d05:b0:cc:5917:c4e3 with SMTP id y5-20020a056a203d0500b000cc5917c4e3mr31529473pzi.48.1678467862695;
        Fri, 10 Mar 2023 09:04:22 -0800 (PST)
Received: from localhost (83.92.168.34.bc.googleusercontent.com. [34.168.92.83])
        by smtp.gmail.com with ESMTPSA id g4-20020a62e304000000b005a8173829d5sm75281pfh.66.2023.03.10.09.04.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 09:04:22 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Alejandro Colomar <alx.manpages@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 3/5] diff: add --default-prefix option
References: <ZAl3bHB9zxjLITgf@coredump.intra.peff.net>
        <ZAl4MkWVV8fr+3fO@coredump.intra.peff.net>
        <xmqq5yb9q42e.fsf@gitster.g>
        <ZAr7+zW+pkOXoIfL@coredump.intra.peff.net>
Date:   Fri, 10 Mar 2023 09:04:21 -0800
In-Reply-To: <ZAr7+zW+pkOXoIfL@coredump.intra.peff.net> (Jeff King's message
        of "Fri, 10 Mar 2023 04:44:27 -0500")
Message-ID: <xmqqcz5g7d2i.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> While it is not _quite_ the same thing to say "use prefixes a/ and b/"
> versus "countermand any config and use the default", it is close enough
> that I am tempted to say this patch should be scrapped. I mostly just
> wanted to have a way to counter format.noprefix, if we are going to
> endorse it as a concept (whether by adding it, or saying "no, respecting
> diff.noprefix is not a bug").
>
> (If we do scrap it, I'd probably fold the extra tests into the previous
> commit, but using --src-prefix, etc).

I would very much like to keep this one; if we can find a shorter
name that would be even sweeter.

I am wondering if we can keep the current behaviour instead and send
a message: "if you do not want your everyday diff not to have
prefixes, fine, go set diff.noprefix, but if you do not like that
format-patch also gives a no-prefix patches with that configuration,
or at times you may want your 'git show' to show the standard
prefix, you can countermand your diff.noprefix configuration".

