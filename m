Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3C07C4332F
	for <git@archiver.kernel.org>; Mon, 19 Dec 2022 01:07:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231204AbiLSBHv (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 18 Dec 2022 20:07:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231273AbiLSBHX (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 18 Dec 2022 20:07:23 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 706AFBE04
        for <git@vger.kernel.org>; Sun, 18 Dec 2022 17:07:11 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id o1-20020a17090a678100b00219cf69e5f0so11446241pjj.2
        for <git@vger.kernel.org>; Sun, 18 Dec 2022 17:07:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vxogOBVyabnWhmzdQd2hQs67lLCA2/f1W6daqw8MXYU=;
        b=PBEvGZ8eLi3INwB+UuY98wi0R1PfhsUf0DEceN9yJk8c7oDM5R4qqzLe/lkAjsMOlT
         bsSJMWl7NrtYabiYa+pMF7J6AUwuviKXeKrvBU3T4Px6+IG9aj7dwTWdY9wL84DRY6tF
         9492+4ZfjAMzTsnKYEL4wEFfikyn50j4wFw7cZmKZnRWmgHl3F2OhzhLpiY++XGdy9K8
         YRhUZTk1zcNL06+DsM4sZGnTEexVDef6PHRvqckQSD4vCPR14CcuPxEu8MEO2czNw7/K
         LQSEMqZUfMLcPcKO3P/WRlIAFjgf0DeoOXsIjUUCxIj2zRngHVIaV2xyaUGQVHIQ5AYe
         jl2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vxogOBVyabnWhmzdQd2hQs67lLCA2/f1W6daqw8MXYU=;
        b=L5DJGskumXyu40DeIU4mxjei+PyHoz9B8npCmqCnpnVHJ1MdW2Bub4TC8nIQbAMk4f
         er/fs0EmPGSUDN2GKoRLOP1kMKyKdJSxLm6X+7LHicOTNytUK9bGDMhWfmw63koz6c0B
         wjMkweYDF6y6IItbcU78zczItPEOIn5Xzh7Q9AetzdFQIF4mABwF/3JNV1p8qAft1Ddh
         Wu6N8HVkmw5vguqL3ZBR5Caf3Uq+FylN/0gB3PIr57KhSKZP8WWT7XsUGqzgAwF0RiSm
         an+yfUWtRFOl4m8Qf2mf84XJtcA+qzI3qxLS51nL9TUMG6Yln5x36Fny3CK4IU08A+VR
         AklQ==
X-Gm-Message-State: ANoB5pnP1KWA/aTjIC95qVqQdOOYWdkMfnSzu2k7dWdYwz7yitw0VaR4
        ReRmbdAUQc1aA0lfgLoyjyZiWzZzG5t31w==
X-Google-Smtp-Source: AA0mqf5cEA3mkDzAfkoD3d2l/CyAPJV/0ZNdg/2k7RrRV323NwD8d/v9rYdy09rjxcKV81Px0R/hYw==
X-Received: by 2002:a17:902:7242:b0:18f:a4e1:9908 with SMTP id c2-20020a170902724200b0018fa4e19908mr29762594pll.15.1671412030613;
        Sun, 18 Dec 2022 17:07:10 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id jh19-20020a170903329300b001869efb722csm5684241plb.215.2022.12.18.17.07.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Dec 2022 17:07:10 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Rose via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Seija Kijin <doremylover123@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH] git: remove unneeded casts
References: <pull.1396.git.git.1671032126602.gitgitgadget@gmail.com>
        <Y5o9NNVx7dFLhIMd@coredump.intra.peff.net>
        <xmqqh6xxv946.fsf@gitster.g>
        <Y53E7PNu05VTdvXG@coredump.intra.peff.net>
Date:   Mon, 19 Dec 2022 10:07:09 +0900
In-Reply-To: <Y53E7PNu05VTdvXG@coredump.intra.peff.net> (Jeff King's message
        of "Sat, 17 Dec 2022 08:32:28 -0500")
Message-ID: <xmqqo7s0urpe.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> ... So perhaps:
>
>   - this used to be "char **argv" because of main(), but either because
>     of becoming a builtin or cmd_main() it is now const
>
>   - this used to require casting from non-const to const to free()
>
>   - etc, with one-offs for cases that don't fit in any group
>
> The keeps a single patch's explanation from being too overwhelming, and
> avoids repeating yourself when the same logic applies to multiple cases.

Thanks, that would be the organization I would use, too, if I were
doing this change myself.

> That said, I am happy with any solution that explains why we are sure
> each case is OK to do. :)

Yup.
