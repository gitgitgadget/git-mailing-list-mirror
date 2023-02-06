Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2616C05027
	for <git@archiver.kernel.org>; Mon,  6 Feb 2023 22:08:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229700AbjBFWIL (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Feb 2023 17:08:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbjBFWIJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Feb 2023 17:08:09 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 060CA193CE
        for <git@vger.kernel.org>; Mon,  6 Feb 2023 14:08:09 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id g13so8901804ple.10
        for <git@vger.kernel.org>; Mon, 06 Feb 2023 14:08:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gJgZyvlhoTy+8a2qXoHhDWowrreVzuC1XubEGkwvrFg=;
        b=gwpiUs7tdH+5OvMbjhHYOSMhY10iB8D25JBQGudvxH48d0oOWE0q0ubXQWiNhGgueN
         jEHoB11f1bIfF8zrKNFNn9oPTnp2DjU0QhWNgR9X8NPdhm5Cks9WYfj3UvhHB0e7Q6u+
         dUSpgSgeFPseReDrGS0gbYUtxbKbkYtXxXqhG2hNrYlQ8txDKBLUGISXTH9T71XLybZS
         dB7vbJVsoWs5DX39iHdCKof9nPCWZBY8ABAKfs/Y7dxK3VTzPV97MWre9563eIV750kD
         On3335urd4twXJTetaiq6nPsUpj5PILl0tlhWWw+ftkwlLSTUZQ1Jhr6WHdiVKGWWgve
         sDaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gJgZyvlhoTy+8a2qXoHhDWowrreVzuC1XubEGkwvrFg=;
        b=Zo/BqUuK/33KxrPl1mmi7x7DcW0YYzE+RgYxv9mI0bmO7qksw5CzBEvyeMMwCz67EV
         hZPUQpdzcceo204aLHlcP5InG0SVVqLow3ktdHhsWkaDGuyIcRu5idmjHIQ5iNyIPLg6
         ST2H2+n7gragp+BSLGpMZwOXPpy3xa9FLURTVxCeg5HYmOVDkNqECGbwI9mi7foSo8nI
         WdtWH9ewyG1+vFk929diInctrp2fUd00vstDLl2bKGbNYProff2sLILTbdemyuK3D5QN
         RLd2LvajpRqO7OS2inYPqMvix6oraciHEJYvJkfwaV9bu7ajK1nJODDVHeTUWWLQG9sb
         BOKg==
X-Gm-Message-State: AO0yUKUcKqUq2wwsoU8ri0al8k1C7R4NQ4nPcZWY01C0tE6OVGgVsZAf
        Ex4GCVXwsWuTBqLZlZOp+wM=
X-Google-Smtp-Source: AK7set8nOot/V/kXLi20OzWAdrZN9c825+SDnLp+NDsZE8hDPKVoZdGyjBP6+X/HaVjFl2KruHj+CA==
X-Received: by 2002:a17:902:ea09:b0:199:1d6e:c4fc with SMTP id s9-20020a170902ea0900b001991d6ec4fcmr433268plg.65.1675721288388;
        Mon, 06 Feb 2023 14:08:08 -0800 (PST)
Received: from localhost (137.22.168.34.bc.googleusercontent.com. [34.168.22.137])
        by smtp.gmail.com with ESMTPSA id k23-20020a170902761700b00188ea79fae0sm7460471pll.48.2023.02.06.14.08.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 14:08:08 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Rick van Rein <rick@openfortress.nl>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Matthew John Cheetham <mjcheetham@github.com>
Subject: Re: Git over HTTP; have flexible SASL authentication
References: <20230127163434.GA784@openfortress.nl>
        <xmqq7cx7aov7.fsf@gitster.g> <20230204113408.GD21507@openfortress.nl>
Date:   Mon, 06 Feb 2023 14:08:07 -0800
In-Reply-To: <20230204113408.GD21507@openfortress.nl> (Rick van Rein's message
        of "Sat, 4 Feb 2023 11:34:08 +0000")
Message-ID: <xmqqk00u4fco.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rick van Rein <rick@openfortress.nl> writes:

> SASL assumes that the endpoints can hold state and progress through any
> challenge/response exchange, in multiple steps if needed.  This is not
> trivial with stateless HTTP, but we fixed it with a "s2s" argument which
> can hold the (datestamped, signed, encrypted) state on the server side.

That's nice to know, and its applications below do look useful, at
least to me.

> A few mechanisms that spring to mind as useful with Git over HTTP-SASL are
>
>  - Kerberos / GSS-API, desirable for companies using its single sign-on
>  _ FIDO, currently being added to SASL to benefit all protocols
>  - OPAQUE, a very modern crypto, developed in IETF now
>  - SXOVER-PLUS, our own work that calls back to a user's domain for login
> 	(so no server-stored credentials needed, only access control)
>
> I'm curious if this would indeed be considered an improvement to Git.
>
> Cheers,
>  -Rick
