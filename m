Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B098FC433EF
	for <git@archiver.kernel.org>; Mon, 13 Sep 2021 04:09:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8716760FE6
	for <git@archiver.kernel.org>; Mon, 13 Sep 2021 04:09:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232777AbhIMELN (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Sep 2021 00:11:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230397AbhIMELM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Sep 2021 00:11:12 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87799C061574
        for <git@vger.kernel.org>; Sun, 12 Sep 2021 21:09:57 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id jg16so17978252ejc.1
        for <git@vger.kernel.org>; Sun, 12 Sep 2021 21:09:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=1yYdHkdFVaPPZta7pYX25D5ophG6iAJGOnmmSjYn/g4=;
        b=NFM/DwQ0CynUaABqLPYw1tcNSCaoYJAYFPaDTFrnJee8H/RkdK49laerk7QRWmX3pS
         UzzFNbyPdts3or8SmnnhWbH5fY9hyEvYo1SiWlojkLMgaJvwhOPLsaHk5LYmFApbarVQ
         yq6VMVYgxP+BWnY/Pqvx6SHxiPbm7AyBMuTEBRZ7FKvNT4tiAAaVfNiv81DpeDVjXpI9
         hu8faAmo5SizXOJgqVbhK+5I7/h2ChI2QsqzOUkM3AFI9CusK3dhaC7wWmedf0ekagRU
         W5KBLRIqtr+NyMFgW+8u6aWz6pS13Uh6cjj3waAayt/rQWZAUp90Jibad2LfUoERpFaY
         YkcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=1yYdHkdFVaPPZta7pYX25D5ophG6iAJGOnmmSjYn/g4=;
        b=lZMYSKxlF1e2ZTz5TqTr1/7PSRWsFs2gkssAsE1FK5ZXqJ+c0C4HnOxfH+99/8EGv1
         CJbBP2ZxsJs3m4T+U7tW+VYUV/6vtJgQ9Wz+9D/N/yHx2RiHakeZCWqGdmafArhbcKP9
         MZoibni6hcxCx0Dy82tZ6R31Gef/GxXHGJDUyRamuR9YYYUrZK87FkcoEVZxDjDu/8+1
         CDkT0YwLtExe1FnntfffBrt/PEZea+kdriABsPeE1wBo5ArzUa0UGpJI23+qOB9dQ6Jt
         0Od+ILKMCfOl4IP8j8QDIQOVdxgNmP8WUOjm1bt2zhIn7tBdMCKLjvD1U81v0TanTn5k
         yxpQ==
X-Gm-Message-State: AOAM530iFRNaFQzo9YXUD/ijiGy04GYnxR8SDHFmkQAIa9L7OmyQ6sh5
        iFTI2bVZwZLZu3s7IHedVvpMXiI6zZ/npw==
X-Google-Smtp-Source: ABdhPJzRydfy0qjP8HC7SEBG6y7cZR7d3D81Re8Oc7RIuCezkXrJMG3cmXaRRK4twQLtNQnM8Xf8/A==
X-Received: by 2002:a17:906:6dc1:: with SMTP id j1mr10549679ejt.324.1631506196027;
        Sun, 12 Sep 2021 21:09:56 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id k22sm2750860eje.89.2021.09.12.21.09.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Sep 2021 21:09:55 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: Oddidies in the .mailmap parser & future syntax extensions
Date:   Mon, 13 Sep 2021 06:02:09 +0200
References: <20210910130236.40101-1-me@fangyi.io>
 <YTt4RymWg+TOEmUf@tilde.club> <877dfocps2.fsf@evledraar.gmail.com>
 <xmqq1r5wti5a.fsf@gitster.g> <87h7esb3ig.fsf@evledraar.gmail.com>
 <xmqqk0jorxmx.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <xmqqk0jorxmx.fsf@gitster.g>
Message-ID: <87zgsh3ylo.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Sep 10 2021, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>> Who wants to use mailmap, *and* map one e-mail address to another, *and*
>> has an entry explicitly mapping the name, but *would* mind having git be
>> auto-smart and follow the chain of that explicit name mapping if there's
>> an entry after that with an an e-mail -> that-earlier-email mapping?
>
> Would it make a difference if I point out that at least for our
> project, we want to keep the .mailmap lines be sorted?

I just used git.git as a handy example. If the project wants to not use
some new shorthand syntax to make for easy sorting it can just not use
it. I don't think that should be an argument against the existence of
such a syntax for those who'd like it.

> I suspect that a "list must be mechanically sorted" requirement may
> make it awkward to also have an "if name is missing, use the last
> matching explicit name".  Also, it makes removing one entry among many
> for the same person less straight-forward (if you are removing the one
> that happens to be listed first, you need to move the name to the next
> entry in order to avoid losing it).

That's a good point, that E-Mail was written rather off-hand, and I see
from find_last_name_for_address_in_mailmap() that I probably had that
ordering in mind.

But given that point I think a shorthand like that would be equally or
more useful if we don't care about the order, the "more" being because
you'd be able to sort it in any way you like and still get the same
results.

I.e. when mapping:

    <gitster@pobox.com> <junio@hera.kernel.org>
    <gitster@pobox.com> <junio@kernel.org>

We'll have fully parsed the file, and having also seen:

    Junio C Hamano <gitster@pobox.com> <gitster@pobox.com>

We can follow the chain and see that since <gitster@pobox.com> has
explicit wanted name mapping, that we should use that for say
<junio@kernel.org>, because it wants to map to <gitster@pobox.com>, so
it should also get the name mapping.

Except if we had more than one name mapping, but that could/should also
be detected regardless of order.
