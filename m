Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02520C7EE20
	for <git@archiver.kernel.org>; Wed, 26 Apr 2023 16:46:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229490AbjDZQqR (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Apr 2023 12:46:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233355AbjDZQqP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Apr 2023 12:46:15 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30F437D84
        for <git@vger.kernel.org>; Wed, 26 Apr 2023 09:46:12 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-63b5c48ea09so6063844b3a.1
        for <git@vger.kernel.org>; Wed, 26 Apr 2023 09:46:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682527571; x=1685119571;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/9aeotcW3Hk4dAPqFGJ+kGsngLM5HU71nAeTPpSGeCk=;
        b=bQ8c9l2H5MXUGOOPnOUEOIw79YezcSzgQz1rlNAPqAm1iOvUVFYeZ0OyPp4sarVotz
         J4jX4QdsxEb3jUTyKn6sDpd72hOfzWqR0Mc5iq1sDW1zS+NK4CXLdCwbu9AX1GA020lJ
         5hCoYSdDC/yDc9kBZrRFu5e0X4K5sV3Ri/CYsX46UH0yz+Qv2f/3OZNiZuIjlLLAbWs4
         9YX2rB702I3SBPXORak7R+NvAZF3DzKQv9CX/JRgDmSSAJ12pqqWGQSNoyiSsx+Ykj5/
         v2pnpmGXDcZLW1LfOYd4nFq1l9zuJCj8nIqFLVjIDCSMTDh+QebcEK55ejvgR3IlnR/8
         U4LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682527571; x=1685119571;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/9aeotcW3Hk4dAPqFGJ+kGsngLM5HU71nAeTPpSGeCk=;
        b=H3kAHxaXl31BW9aieLNLREZAxcjbU9HIGEpnxUJjuoVUvxT8a1fYesIRMaT3BElo1U
         wnckd0ajF1H8UP7y68EZnD2QH28GNX2lmqBXihYMyvX27o8iFxE6TblEEMmzyKopV6Jf
         8skc6NrAC+bxIjGEW1+2ejn4vJOPMKQTCm7C7yRYUXb/zFJlk2J0VPLiFw4pM4mIJvRb
         QbGrJfVRUROwnHD9FtZlmACRbb8g1CjuvNK7IEqbgF63MvQUVpj+CiD7x6MT29tp+1us
         4ciJR768BpL6TXRgQDg4YCwVVRnJNMnt8CJtZ3+uRMHlJ04X+QOV6ZkCkP++0sj1v38p
         fL6Q==
X-Gm-Message-State: AAQBX9fyCl+LAi6ppnBx9fB6StfoNavG8poNx2tAlXicZ1F7+AErtwBt
        0398pxV8W2EI2C3s1PwEUko=
X-Google-Smtp-Source: AKy350Z9KxiVKd7rGPhAdUOBsWbtriurVG3T3pUgVNlzGgBOqCv3KjmSvtNu78KA8LK4s6UFvyFPiQ==
X-Received: by 2002:a05:6a00:1996:b0:5e0:a86:a76f with SMTP id d22-20020a056a00199600b005e00a86a76fmr31397454pfl.0.1682527571564;
        Wed, 26 Apr 2023 09:46:11 -0700 (PDT)
Received: from localhost (187.137.203.35.bc.googleusercontent.com. [35.203.137.187])
        by smtp.gmail.com with ESMTPSA id c14-20020a62f84e000000b00625037cf695sm11436321pfm.86.2023.04.26.09.46.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Apr 2023 09:46:11 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "Pooyan Khanjankhani via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Pooyan Khanjankhani <pooyankhan@gmail.com>,
        Pooyan Khanjankhani <p.khanjankhani@digikala.com>
Subject: Re: [PATCH] revisions.txt: correct a mistake in dotted range
 notations section
References: <pull.1485.git.git.1682495081131.gitgitgadget@gmail.com>
Date:   Wed, 26 Apr 2023 09:46:10 -0700
In-Reply-To: <pull.1485.git.git.1682495081131.gitgitgadget@gmail.com> (Pooyan
        Khanjankhani via GitGitGadget's message of "Wed, 26 Apr 2023 07:44:41
        +0000")
Message-ID: <xmqqo7natwvh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Pooyan Khanjankhani via GitGitGadget" <gitgitgadget@gmail.com>
writes:

>      $ git log A..B C..D
>
>  does *not* specify two revision ranges for most commands.  Instead
>  it will name a single connected set of commits, i.e. those that are
> -reachable from either B or D but are reachable from neither A or C.
> +reachable from either B or D but are not reachable from neither A or C.
>  In a linear history like this:
>  
>      ---A---B---o---o---C---D
>
> because A and B are reachable from C, the revision range specified
> by these two dotted ranges is a single commit D.

Isn't that an unwanted double negative?

The first hit I got about "neither double negation" on Google search
was:

https://www.grammar-monster.com/lessons/either_or_neither_nor_double_negative.htm

but the source of this might sound more authoritative:

https://dictionary.cambridge.org/grammar/british-grammar/neither-neither-nor-and-not-either_2

