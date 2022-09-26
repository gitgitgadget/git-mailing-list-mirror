Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99704C32771
	for <git@archiver.kernel.org>; Mon, 26 Sep 2022 15:07:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235678AbiIZPHm (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Sep 2022 11:07:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235656AbiIZPGY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Sep 2022 11:06:24 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39B1BEA216
        for <git@vger.kernel.org>; Mon, 26 Sep 2022 06:38:28 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id rk17so959698ejb.1
        for <git@vger.kernel.org>; Mon, 26 Sep 2022 06:38:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date;
        bh=1AOL3N0bD1xpOp12urCyKtxA4txDCmH5B9Q7GPaByrQ=;
        b=kpDGs4ihGhoaltzGnUjLgqm9xqSnrt5MOTTiAPujU6u4DV5pg73LvtyXp9FKzxmy6m
         havBmrX+EYRVCAD+5GI2YVjXVELZfFISsFwFTm3j3d4ryBJhlnl+aJNL3JR1yhURsRGo
         20g3faZ9JoyJiKaM2ZST9cukpmlsy6B9k6n/zn3N035SC8uVuN3Af55dQwaqp/bxOmL5
         DZHWDXuBSSvK3KncBJsMN81oj+v2m9ChNjhq6XBLcFXZf+DbEcxJyUo2kGBmhC/y0MPL
         lX/KEAYOBXZYRtpRuuUMEQtU10NNkonki7GgGQafa4VxqmFX2JJqAqWfA0FvFxT2iDzH
         ip9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date;
        bh=1AOL3N0bD1xpOp12urCyKtxA4txDCmH5B9Q7GPaByrQ=;
        b=gxf4av/LLnOASJMu/zQhqZBmx1/LRgD0o4KvzG8+J5MkXMLukKi++L6lukMsLAzfWw
         IVpEQCqmssUG+xFE3FYzl1a62W6S21hyI2GSJeUQNQf5iKudzPCoR3mMQ22RbCVkFNg+
         xsKD70Y76AAIZqqS5I9HSqfoKrJ7jD5+3RbeeM+IDEWfRRVcj3iKiaBYks65wPf1eFx3
         zKzW1EBIKWSiBkvVSfaLgMLSTqtNRgdHBdX+ImxLIPjWDpGbmcbVejeSGvZw3T0z/TFK
         t39g9kEqMqpo9L68pyV6fNvYTQk9/ROYPJ7fv8gN/wAqBuE1nerYe5fQrJRw00a3zCzR
         q3sA==
X-Gm-Message-State: ACrzQf3yVKxS0MmwiQZu8/yZALXKyeic49YBdQ6VJNVqPFerd3F22A6t
        WFMWjRj2dlvJ5fbGIZ0RGTXQcmCfVgw=
X-Google-Smtp-Source: AMsMyM5FTRYS9aEqPrzqjw8BbSH2QrPENlR4QOLES0QB5NOOrnSp7iTMqCzxr9wUTn6vLByTe0m31g==
X-Received: by 2002:a17:907:760d:b0:77b:1d8d:7700 with SMTP id jx13-20020a170907760d00b0077b1d8d7700mr18223496ejc.195.1664199506602;
        Mon, 26 Sep 2022 06:38:26 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id r9-20020a17090609c900b0073a644ef803sm8373175eje.101.2022.09.26.06.38.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 06:38:26 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1ocoJV-0006Bq-0s;
        Mon, 26 Sep 2022 15:38:25 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        git@vger.kernel.org, Victoria Dye <vdye@github.com>,
        Junio C Hamano <junio@pobox.com>
Subject: Re: [PATCH] cmd-list.perl: fix identifying man sections
Date:   Mon, 26 Sep 2022 15:35:06 +0200
References: <20220923070334.1970213-1-martin.agren@gmail.com>
 <Yy4uDW9YjpleFUHW@coredump.intra.peff.net>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <Yy4uDW9YjpleFUHW@coredump.intra.peff.net>
Message-ID: <220926.86czbi1cj2.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Sep 23 2022, Jeff King wrote:

> On Fri, Sep 23, 2022 at 09:03:34AM +0200, Martin =C3=85gren wrote:
>
>> This makes our git(1) manpage look as follows:
>>=20
>>   Main porcelain commands
>>        git-add(git)
>>            Add file contents to the index.
>>=20
>>   [...]
>>=20
>>        gitk(git)
>>            The Git repository browser.
>>=20
>>        scalar(scalar)
>>            A tool for managing large Git repositories.
>
> Good catch. The patch looks good (I was going to suggest ?:, but I see
> =C3=86var beat me to it).
>
> I wondered if we might have caught this in a more automatic way. The
> output of:
>
>   cd Documentation
>   ./doc-diff cc75e556a9^ cc75e556a9

FWIW I asked before on-list[1] why the CI output of
https://github.com/gitster/git wasn't visible, I don't know if it's a
setting Junio can adjust, or something else.

I wanted to set something up to scrape the WC E-Mails, and see what the
CI status of those topics was individually.

And, if others found it useful eventually, perhaps send that as a
follow-up to the list. I.e. if CI for the topic passes, what (if any)
the output differences are. We could then just run a "doc-diff" in the
CI, and report (as part of some matrix) a checkmark next to those that
have doc changes.

Of course I could re-push all of the topics myself, but that would take
a long time to complete, and compete with any other use I have for CI
myself. So piggy-backing on gitster's would be much better, if they're
even there in the first place...

1. https://lore.kernel.org/git/220114.86fspqrxbw.gmgdl@evledraar.gmail.com/
