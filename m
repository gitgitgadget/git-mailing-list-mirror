Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82B48C636D4
	for <git@archiver.kernel.org>; Thu, 16 Feb 2023 02:57:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229539AbjBPC5U (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Feb 2023 21:57:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbjBPC5P (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Feb 2023 21:57:15 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F21EC46158
        for <git@vger.kernel.org>; Wed, 15 Feb 2023 18:57:08 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id e17so659369plg.12
        for <git@vger.kernel.org>; Wed, 15 Feb 2023 18:57:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8ugdu9hx4Ebtwjj150WqmD7JciqpnC5IUxslR8DipJc=;
        b=nP7pwnVl2kUXQixGpPFKx6ZV4oZiWXCtuPntsfnwY9HVW0oqYtdQ/wYVrG1ua1hOBQ
         K6p8OSLrKmg3Ban1rLmBws6pL/bkSsEFc43Wu9fVpwT2241fVM6mqu8nKJUM8pO6WVxJ
         8h4+HyP4SiiUMqUcJL3FkUDzc1/58SqOlk4nR79gafIew7WLn5BwGQokX0XC+rtJKOLI
         j1IE1RDZQ8jlLFw0bjP4WhGRlr4ENTrNK4rjkJtT+2jfJug6AQ3GfXpzPRQCbboHmPsU
         wjVPK0lCJnT0XUL7Op26fLo2JNKOSZO/KcdxYweiuechXMf65TNPoJp/G8Y58roNu/bu
         QoDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8ugdu9hx4Ebtwjj150WqmD7JciqpnC5IUxslR8DipJc=;
        b=DkhW8sHUr7wpAOw2mIhFlnPTsXN+1xNHHS22sNK5gHaolygyQ5YRIxbISBbYZDPFk0
         fDIZ14tbdgYZfpGjt1sFEuJVKu1MqMvzpxr0XD0FE9zGOweDAYOQgYIg8M7c9mqblpUB
         eX60Faq5rzcrcG074xbKlHqbmu5Lw0HgF9DqHTCpozlP++dxTCk5beoJ/3NyXQvXC8Om
         4qiCdeshlHgybunNj+Efl92ookNnUanWbiiATQlnWLGk14uNEa485ZpVrWi058YZJlHY
         69hbGXrSDJXNyoV7hqvX04vejsPWlG8DOmVbt4HzhGhmfIoGWR0/GyTpy2ri9glTYW76
         FiEg==
X-Gm-Message-State: AO0yUKVO+kQwR5Q12Pg1E0JLesklN8NjXMJ9WQd6Ue7zmjeMI5kSFZKn
        W8wo/m05etASyizMymLqDVM=
X-Google-Smtp-Source: AK7set+hV8qzSmRJy5DGKJHQzcXfzjZR/GF/Znsvx+9qg4pWaUNKba7XTAWa3AF2Tb80H5j6U507HA==
X-Received: by 2002:a17:902:c405:b0:19a:723b:433e with SMTP id k5-20020a170902c40500b0019a723b433emr5555263plk.42.1676516228403;
        Wed, 15 Feb 2023 18:57:08 -0800 (PST)
Received: from localhost (252.157.168.34.bc.googleusercontent.com. [34.168.157.252])
        by smtp.gmail.com with ESMTPSA id q7-20020a170902a3c700b0019896d29197sm71825plb.46.2023.02.15.18.57.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Feb 2023 18:57:08 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     John Cai <johncai86@gmail.com>,
        John Cai via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v2 1/2] diff: consolidate diff algorithm option parsing
References: <pull.1452.git.git.1675568781.gitgitgadget@gmail.com>
        <pull.1452.v2.git.git.1676410819.gitgitgadget@gmail.com>
        <0c5e1fc6c2651e39bcefa27ee0976c9519671969.1676410819.git.gitgitgadget@gmail.com>
        <xmqqk00j3b6r.fsf@gitster.g>
        <AAC53EE0-91F5-4A74-AB26-5F3F8B680CDE@gmail.com>
        <xmqqmt5ev6ln.fsf@gitster.g>
        <Y+2RgdCDrDC1N9Y1@coredump.intra.peff.net>
Date:   Wed, 15 Feb 2023 18:57:07 -0800
In-Reply-To: <Y+2RgdCDrDC1N9Y1@coredump.intra.peff.net> (Jeff King's message
        of "Wed, 15 Feb 2023 21:14:25 -0500")
Message-ID: <xmqqk00itj0c.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I'd have expected it with individual callbacks like:
>
>   int handle_patience(...)
>   {
> 	do_patience_specific_stuff();
> 	do_shared_stuff(PATIENCE_DIFF);
>   }
>
>   int handle_histogram(...)
>   {
> 	do_shared_stuff(HISTOGRAM_DIFF);
>   }
>
> and so on. That's a bit more verbose, but the call stack reflects the
> flow we expect.

Exactly.

Thanks for spelling it out.
