Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6234DC4167B
	for <git@archiver.kernel.org>; Sun, 18 Dec 2022 01:32:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229885AbiLRBZz (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 17 Dec 2022 20:25:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbiLRBZw (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Dec 2022 20:25:52 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6352DE95
        for <git@vger.kernel.org>; Sat, 17 Dec 2022 17:25:51 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id q17-20020a17090aa01100b002194cba32e9so9725955pjp.1
        for <git@vger.kernel.org>; Sat, 17 Dec 2022 17:25:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Lkn4QblcDPOyXCHvgb1a3wxjatIC7X1gBcrkpyuPzuA=;
        b=FmrUjQFIO57ZB/q6bmGleFMef2jG4Pw+QUf+Y8guwr9a7Nup0V6Mm3MsvpbWUA4gRB
         jkEM9GHBexnrYrxy8KeJfGFwPAgRM7aQYn57oAc/6knuX/7uWH7WaFNuFB6JyPK9G5nc
         4tix8q8nfMCmWDWTnGiyNfU9eFXDvyqPid59f6qYqjARbAAAu2hIzVRbr8/bHgZVyZ8B
         sUY6AmLeoBnObw+zjFHJ59jcN2Lhq4sAAuuhRHZwDaWYMog8+m/u4eIJWUEWPHhaArjA
         Iclyo5OHJ+0HZoorQaeBZMXTDxIw599ITSZ1sdj6oXcNYn6N2M24wmjtcEONb3aKSI/G
         gtdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Lkn4QblcDPOyXCHvgb1a3wxjatIC7X1gBcrkpyuPzuA=;
        b=j3yTeFV5q8/4pcim+SrPca2KKOAg/wIz9w7KpQM7RU9fRk6Kyw6ysLcXblC05zF2Uo
         B147cEtFVfOXNxpJp2jYL52XDMvT/A/Wyo/ddttB7Q7mUoi58od6BL2A+0BsqDdmIbvp
         ivHA8nPcXRa1JiIpa5Q30SwfNNeZ/lOdRBM5iX4pGNZ10GXASiWt5C3YKUk6ao0xH9O4
         AcPSlqbkBOeVBO6UaBJFvlY9PTE3bGFb0mDYLnzB/si+UPKuOAliszKiYeKBgMTRMejL
         puLG77VBWtOq7uzlAoq/Sh3u5IzGxOCfPXDGtzzHCwY6Jq/u2VTTCH9g/8U9R8SYXoSP
         OCjQ==
X-Gm-Message-State: AFqh2kpI2frO9CHDAhDueQhXzTZwN8XDLSBxP1xY4HsHtfSxgwi9Fa9H
        nfKE/6lPNnHX2HbupAstE8k=
X-Google-Smtp-Source: AMrXdXu0M0n0AjgXGdyKXW5n1/oo7Y5ns5ZaE9DJvx2iFGIRuShDIK1xWCreVhJqUZkaajTij4YECA==
X-Received: by 2002:a17:903:22cc:b0:190:fbbd:277d with SMTP id y12-20020a17090322cc00b00190fbbd277dmr16092595plg.17.1671326750762;
        Sat, 17 Dec 2022 17:25:50 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id p1-20020a1709026b8100b0017fe9b038fdsm4168431plk.14.2022.12.17.17.25.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Dec 2022 17:25:50 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Sven Strickroth <email@cs-ware.de>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git <git@vger.kernel.org>,
        "Robin H. Johnson" <robbat2@gentoo.org>
Subject: Re: [PATCH] submodule: Accept -v for update command
References: <FR3P281MB21416B718C4C052A28C319B1E90F9@FR3P281MB2141.DEUP281.PROD.OUTLOOK.COM>
        <1ff185c5-4a9e-36e3-3141-8b149c1c7bb0@cs-ware.de>
        <cad05012-7bf9-5975-3add-253b11c7bcc8@cs-ware.de>
        <221130.868rjsi6bn.gmgdl@evledraar.gmail.com>
        <xmqqiliur6t9.fsf@gitster.g>
        <f805f2da-a7e1-9fde-cc0a-04a30f79c9af@cs-ware.de>
Date:   Sun, 18 Dec 2022 10:25:49 +0900
In-Reply-To: <f805f2da-a7e1-9fde-cc0a-04a30f79c9af@cs-ware.de> (Sven
        Strickroth's message of "Sat, 10 Dec 2022 14:06:37 +0100")
Message-ID: <xmqqedsxzen6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sven Strickroth <email@cs-ware.de> writes:

> Subject: Re: [PATCH] submodule: Accept -v for update command
>
> "git pull -v --recurse-submodules" propagates the "-v" to the
> submodule command which did not support "-v" yet.
>
> Commit a56771a668d introduced this regression.
>
> Signed-off-by: Sven Strickroth <email@cs-ware.de>
> ---

This unfortunately fell in the cracks.  Thanks for a few people who
reported the issue this patch tried to fix recently (it is curous
why this regression that is almost 5 years old suddenly started
biting people).

Applying the improvement suggestions given in the review messages to
the other patch to deal with this regression from the "pull" side,
let's explain the commit this way:

    Subject: [PATCH] submodule: accept -v for the update command

    Since a56771a6 (builtin/pull: respect verbosity settings in
    submodules, 2018-01-25), "git pull -v --recurse-submodules"
    propagates the "-v" to the submodule command, but because the
    latter command does not understand the option, it barfs.

    Teach "git submodule update" to accept the option to fix it.

    Signed-off-by: Sven Strickroth <email@cs-ware.de>
    
Thanks.

>  git-submodule.sh | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/git-submodule.sh b/git-submodule.sh
> index 9a50f2e912..7f9582d923 100755
> --- a/git-submodule.sh
> +++ b/git-submodule.sh
> @@ -244,6 +244,9 @@ cmd_update()
>  		-q|--quiet)
>  			quiet=1
>  			;;
> +		-v|--verbose)
> +			quiet=0
> +			;;
>  		--progress)
>  			progress=1
>  			;;
