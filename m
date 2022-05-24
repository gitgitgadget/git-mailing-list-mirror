Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ADBBC433EF
	for <git@archiver.kernel.org>; Tue, 24 May 2022 19:27:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240548AbiEXT1s (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 May 2022 15:27:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235930AbiEXT1q (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 May 2022 15:27:46 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 536F56D191
        for <git@vger.kernel.org>; Tue, 24 May 2022 12:27:45 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id s3so24305906edr.9
        for <git@vger.kernel.org>; Tue, 24 May 2022 12:27:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=SpxOqRBhwzG54CM+3mxRTv28QiU5MzcMqkhnreNIKDA=;
        b=bb+WXU/WgC/WOnKV6125rB9QCkCoEvfUX+a5Gaa/IBffwaXS0rcZI5370WoEns9jph
         0OrKXmzSRFyDvgl6eeKG+IiyxQCl94CFKSLtvwTJuFvHQDHI/4QjNTvScFX2qgOjJxUY
         BDLAN0yCvxVhiE8dtmMSu7cCs0HgLmPJILDF63SQ45BBNm3ixkchg2tP6tpQsi5QDWql
         TUX1ufKdUHajhJcaSb40KeCxA3SpyvnDILiO6k+nayyYR2Fi47N5ApGuMI50/wwhUfJh
         qRb5dFHVFkRrCK02BjhJIiRDHztI+VblWkV06ZgS1V31pjiXxYd7jajKD6nPfqQpEfyY
         Cscg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=SpxOqRBhwzG54CM+3mxRTv28QiU5MzcMqkhnreNIKDA=;
        b=P/dYEwvZivxFw23CogNYSUkFgWSzpTofd/4/tQlMkjvy2PSdygmr0sb2YrGmWNImJi
         lOCrThhTZCrz61SW/FJaa8FkMl+d8/Qs6CyHZFn54Qj+H4qJa1+w5WvTnyzafXagYpKl
         uFSqUoLfSS5z/s6khSyU9zAbOuXkaV9Y7FmZ1CniorChQf4ilOQKtkFXOCwYvXqkgk9m
         0FTzT4pOVA76L+hYHWOnv+0GZ8Es99qn3Rs/sjpKjrpzzpNI/dabHuYOAHm9Zp1SdUs1
         vstCvMIJb21LFC0UomSlSPdIMmxufhlDaMyt5KGwYkqiWaJZAOWNJywWdpBl7bCyK/pO
         QiKA==
X-Gm-Message-State: AOAM531baqx4+SqKp5/eKlR239ztZpleujOFlghFhAkS3DGxw3ezBCNZ
        758KMj+iHNP6Br+qcWZrcZ/bjFBYiJA=
X-Google-Smtp-Source: ABdhPJxSVpla+BXpwwuZaw431P0MSfZWZfe3iamJr9TRk4PHujnIaN5XbPX9Y7p0Mi/9PBOCyHqUmw==
X-Received: by 2002:a05:6402:509:b0:42a:b6c9:eac with SMTP id m9-20020a056402050900b0042ab6c90eacmr29923418edv.225.1653420463797;
        Tue, 24 May 2022 12:27:43 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id gc4-20020a170906c8c400b006f3ef214e0esm3205628ejb.116.2022.05.24.12.27.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 May 2022 12:27:43 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1ntaBy-003WXu-LE;
        Tue, 24 May 2022 21:27:42 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Carl Smedstad <carl.smedstad@protonmail.com>, git@vger.kernel.org
Subject: Re: [PATCH] check-ignore: --non-matching without --verbose
Date:   Tue, 24 May 2022 21:26:30 +0200
References: <pull.1236.git.1653310466062.gitgitgadget@gmail.com>
 <xmqqilpwru9z.fsf@gitster.g>
 <hl3lllnkPVswb8IZoaMCS62N42epy97_8rLH8qrvSGCbKoovP5_qjtq4nrot5-h-q_7KOu-JpPX4nC0f74BXm6uWdtxosa6z5niHqAJKRUw=@protonmail.com>
 <xmqqwneahh8t.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <xmqqwneahh8t.fsf@gitster.g>
Message-ID: <220524.868rqqwx1t.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, May 24 2022, Junio C Hamano wrote:

> Carl Smedstad <carl.smedstad@protonmail.com> writes:
>
>>> Not commenting on the patch itself, but ...
>>>
>>> > find . |
>>> > git check-ignore --verbose --non-matching |
>>> > grep $'^::\t' |
>>> > sed -e 's/.*\t//'
>>>
>>> ... feeding grep output to sed caught my eyes. Isn't that equivalent to
>>>
>>> git ... |
>>> sed -n '/^::\t/s/.*\t//p'
>>
>> That is indeed equivalent. TIL about regular-expression addresses in
>> sed, thanks!
>
> I however suspect that these "\t"'s should be spelled out as an
> actual TAB in the final production version for portability.

Make that a "for sure", it's a commonly unsupported feature of some
sed's, it's actually more common that not that it isn't supported. See
$HT in t4213-log-tabexpand.sh.
