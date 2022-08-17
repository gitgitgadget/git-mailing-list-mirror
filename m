Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1FB4C25B0E
	for <git@archiver.kernel.org>; Wed, 17 Aug 2022 02:21:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238054AbiHQCVc (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Aug 2022 22:21:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237509AbiHQCVa (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Aug 2022 22:21:30 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFD2099274
        for <git@vger.kernel.org>; Tue, 16 Aug 2022 19:21:29 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id n7so3423264wrv.4
        for <git@vger.kernel.org>; Tue, 16 Aug 2022 19:21:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc;
        bh=dHSlIVBTDYhL5oxKJzaStrPXk4+oXA7P065SngjTm1g=;
        b=oYrpog2LAZ2sSQ3vkxsg8Q/rC13Mu1wOw3DzPyCKs3zLfbyf0S2boxo5tpbDX5MPTe
         CYrIYDjNQTB8jbJAiPgT97DJYn4XRQUNmrx8rcURzp3kXrELGkpeW+A0NVMXw74gNVak
         R8SKEC9mYE+jY8DXpetzXkx7RK2mEmw9kp1nPXIryK1yM73pxUpq16aqbQ8OMluqh1bD
         Z9ZDPxL2+S6AQTs8n11ZxNKjSA3o18TqRgXkSVz7qTT2DSSUx2EiToWt3fJo3guu+Qi+
         qiLKcEs1MrtEfeSpqhuYF8ph/nORR9B5A/baVGsT0dzwr1vzu0Osa+0YnuPHBdf+gfFR
         U2sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=dHSlIVBTDYhL5oxKJzaStrPXk4+oXA7P065SngjTm1g=;
        b=OxWzdj3R+ydDa77v3Ly0F/2/VAnV2bJ0MYxytKuwHsh6gE0YsiM89NpWYFGsxKecFb
         8rq17vtsfYM9A5xDajHnECk7bLkzX4mOtWuTea7KoTE9mam1krdmg0SOe3ctLFL+7hVu
         DBYt6c8Bp2FZPzUNPXLUjHJ3C43laTXYOD/3cOCVYYfbS3y13e60Qr0WYlUCjThGglzo
         VClFUtBatwedsIac6HthtpQ4vPYz3rDSYAMDK8BL7YAndMHc2qyt8a8P6Cp8hEgH1VAY
         LzxJ/6D5z6w0RMRBIXu2KLB6DLYfkij+LbQAvbP73DZZGymcA6VyS09E+xhHR6Flgpg7
         g3Ug==
X-Gm-Message-State: ACgBeo3Gnn903VEqKUk+jTCS36GCw2tchZt/6AnRZV3MiXOvBmTi06hY
        NY6jtaDfr/yVadEsleN4ahbSiqo7MskqPw==
X-Google-Smtp-Source: AA6agR7dX3Y9vncdJq31bkw+xp30B0bbpp0DAeO0/YVHWHxI0qMlz/5SVc4pS0v9akFRcoe9RgTkug==
X-Received: by 2002:a05:6000:185:b0:21e:d661:9ac5 with SMTP id p5-20020a056000018500b0021ed6619ac5mr12999387wrx.649.1660702888062;
        Tue, 16 Aug 2022 19:21:28 -0700 (PDT)
Received: from gmgdl ([213.220.121.135])
        by smtp.gmail.com with ESMTPSA id m16-20020a05600c4f5000b003a603f96db7sm626743wmq.36.2022.08.16.19.21.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Aug 2022 19:21:27 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1oO8gQ-00084N-0V;
        Wed, 17 Aug 2022 04:21:26 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Alban Gruin <alban.gruin@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v8 08/14] merge-resolve: rewrite in C
Date:   Wed, 17 Aug 2022 04:16:09 +0200
References: <20210317204939.17890-1-alban.gruin@gmail.com>
 <20220809185429.20098-1-alban.gruin@gmail.com>
 <20220809185429.20098-9-alban.gruin@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <20220809185429.20098-9-alban.gruin@gmail.com>
Message-ID: <220817.86h72ba9uh.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Aug 09 2022, Alban Gruin wrote:

I think the rest of this series has been careful to keep output as-is
(in some cases arguably to a fault, e.g. carrying forward two
"gettextln" invocations as two puts(), which we should almost definitely
fold into one string).

But here:

> -    gettextln "Error: Your local changes to the following files would be overwritten by merge"
> [...]
> +		error(_("Your local changes to the following files "
> +			"would be overwritten by merge:\n  %s"),
> +		      sb.buf);

We introduce a subtle behavior change, we used to say "Error:", but now
it's "error:". Also since a1fd2cf8cd6 (i18n: mark message helpers prefix
for translation, 2022-06-21) the interaction with how "error: " is
translated is different, but let's leave that aside.

Now, I think the change probably makes sense & isn't risky, but perhaps
note it in a commit message, or even precede it with a commit to
s/Error/error/g in the *.sh code before the migration?

Also, if we *are* changing it while we're at it let's also s/Your/your/,
no? I see some other uses in other pre-existing merge*.c files, so maybe
the unusual casing is magical.
