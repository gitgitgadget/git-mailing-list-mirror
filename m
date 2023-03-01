Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1208AC678D4
	for <git@archiver.kernel.org>; Wed,  1 Mar 2023 20:28:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbjCAU2t (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Mar 2023 15:28:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjCAU2s (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Mar 2023 15:28:48 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2BC415174
        for <git@vger.kernel.org>; Wed,  1 Mar 2023 12:28:47 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id i9so19307034lfc.6
        for <git@vger.kernel.org>; Wed, 01 Mar 2023 12:28:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VN6e9R7fsMetW29ClneRiqP7/3kfbeUWPrUFxN58yEU=;
        b=LTtrIRtObxope9kDoTJTiKSJujryaYkgHVFSIMn3kPxio0rgQCjxo9Z2WHz1eccNJi
         fj3z0zdhOzBE7jwYn+LEb1+9X2jgTQhhsGrSTvqha9DTZHxYFKbWG4dJ/6t3COi20aOK
         I0IgEujREODTzCZtoK1kKGOhpnbmWqMoeaKU/Dq8sd30BlMvgHvKHAhSl0Lo3hQm8fJ3
         T+Anka5cH+s9KrlTLDdjR8q0cLj+qe46sjesTTDHRJZZZPvK5ZsMZy7wPaikUz1DDQdw
         b7Ju5xRrq1IiCnQHuhhdVc9wb7acBp/2JHG3OZNF+mGBBIVuNirLs5sDNfF6T37hZhqF
         ktHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VN6e9R7fsMetW29ClneRiqP7/3kfbeUWPrUFxN58yEU=;
        b=o2PJDOwhfOItP6fFySiln9c/anl5K2P21PmgkHwYG5UzgiVfEBEl5AMA1RAVr0ubFl
         NPN2ljAvdXllKUcymN0lo4OoPdt8xTHzUiCSq7rAGwRSsN+qtdnoWY+NVF1yli9uzz6d
         UmpJpuLqudNcybjqPDCvuf1cYPOVgS+c04h45R+Zgjtvb3u0UOj9wtgeYwiMgi+X3VQZ
         y9waI6x9UKXq/xG8O863jZvK29WCwLTQEbTAouXZstuO6t3B9JOzC80G8nilhxbbydbo
         iVwI1CVDTrigtCIGDWKvOfboses+/qUf3351H/NgcMMkO5NQmuriLew4d4EqGlrlWf+h
         22pg==
X-Gm-Message-State: AO0yUKULdIaOcAu7VjvjQXu+dFyJ6LKQMJbeh71hcgHIGv9rZPKF9chr
        JKyLrHjYUuEClUHwRwv+OyxnNDGP4Xo=
X-Google-Smtp-Source: AK7set9zzVUyBBfKpXMDEVTbWZH7W9irqRnmp49S0tTAEsiqb4860nOmELdop6Bh+T42srbEjx4yuA==
X-Received: by 2002:ac2:5495:0:b0:4db:3ddf:2fc5 with SMTP id t21-20020ac25495000000b004db3ddf2fc5mr2027078lfk.26.1677702525744;
        Wed, 01 Mar 2023 12:28:45 -0800 (PST)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id u4-20020a056512040400b004b581ab4c77sm1843666lfk.78.2023.03.01.12.28.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Mar 2023 12:28:44 -0800 (PST)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: "git diff" surprising default output
References: <871qm849co.fsf@osv.gnss.ru> <xmqqzg8wmfa6.fsf@gitster.g>
Date:   Wed, 01 Mar 2023 23:28:43 +0300
In-Reply-To: <xmqqzg8wmfa6.fsf@gitster.g> (Junio C. Hamano's message of "Wed,
        01 Mar 2023 11:40:17 -0800")
Message-ID: <87sfeo2p38.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Sergey Organov <sorganov@gmail.com> writes:
>
>> I figured the offender is --indent-heuristic that is described in the
>> manual as:
>>
>>       Enable the heuristic that shifts diff hunk boundaries to make
>>       patches easier to read. This is the default.
>>
>> but apparently rather makes patches harder to read, at least at some
>> conditions. Turning it off helps to get the expected result:
>
> As a heuristic, it is not surprising that it has some corner cases
> where it does not shine.  I think the version that was eventually
> merged starts here
>
>   https://lore.kernel.org/git/cover.1473068229.git.mhagger@alum.mit.edu/
>
> and we should be able to find a few links to the original
> observation that motivated the change, e.g.
>
>   https://public-inbox.org/git/cover.1470259583.git.mhagger@alum.mit.edu/

Thanks a lot for the references!

From what I briefly read there it apparently follows that it'd shine at
regular C code, yet won't shine at preprocessor directives that are
usually out of regular alignment.

It'd be nice to improve this, but I'm not sure it's a simple thing to
fix, or even at all possible, though maybe it'd help to somehow favoring
chunks that start and end at the same alignment?

Or maybe it's just plain bug in the implementation?

Thanks,
-- Sergey Organov
