Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BE48C77B75
	for <git@archiver.kernel.org>; Fri, 12 May 2023 17:04:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237796AbjELRD7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 May 2023 13:03:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237789AbjELRD4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 May 2023 13:03:56 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E6731BFE
        for <git@vger.kernel.org>; Fri, 12 May 2023 10:03:52 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1aaea3909d1so95344545ad.2
        for <git@vger.kernel.org>; Fri, 12 May 2023 10:03:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683911032; x=1686503032;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=ALnxgDcw+heAXrxUxbpN25miNqyXmwnRNnYeoaMZSos=;
        b=VQd+BQud+2XDsBBUhRNFXmnY8xt885c8LG9QRMOysE7TZUjHqIk7DY9a5EaQZNAXH3
         jnyYI1yyBT0QGlYHiPwANiLf1uXXfcQyl91YPIaPR59BYxb4Pn5MBFSE/x3JAtsQN/30
         vHbbBb6mqQphlcMkDNcQZztXp7JtjWnydvTQ18malDuNNY4Vlx6dWR+hBCaCTUUUOMEz
         m4ndJICaLyHG29SIyaDTbbiuL4og74GvnrhI3E7oFC/WBf7UE4FEEKnVU8N7pu6J+pcR
         96WPBZeazKd+PysKIYN8IVJV75u5Acaja/blhXhb/RmOxYeRde8/RYERhwrWrwD5oEXW
         2OAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683911032; x=1686503032;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ALnxgDcw+heAXrxUxbpN25miNqyXmwnRNnYeoaMZSos=;
        b=DzfnyyVUaRsK8M6T/LFQ/xoPd0mD0Vsb7Wj9IPusY/Hmtua5uYEgSFxCiXDVvyZ6vW
         mM8GX3hV3S+0ZYIfjSLylI0s4UtH+hMcdO9aJ4TY+P05IMfhhwv4QLRpPbcsPkvi1tZo
         /JxFfZZqk4BiCLw13Qdjefr9QVc9kx4T2hSnxry7n3bXL+8tYcINgNvBjVtyx7cLrTy0
         YiVGhvz4FiY7OjNHHClGvKpoClk9040jAMdPOkMYQIZ9bsaN2517jxj//3sv0tS77qL/
         ub+tkaRQMuomuDmA6Wg0XVxYgi9iPpasHp5PlAuqm9f2mLTwrzPJx9XP7Vlo96VmVPmg
         IddQ==
X-Gm-Message-State: AC+VfDy7+oVUfgdcJdi8TVrvO89isxl3weFhfJjiIL0gtql+W5TJr3Cf
        HVJNmZ3iioxJQznTcogfiiQ=
X-Google-Smtp-Source: ACHHUZ42F7OP94AOZouGx1GTDEedTnutb2VoKFRguKM5+9mj5fDNLqD1DZGarZ4BfOPB0gp9a4s5vA==
X-Received: by 2002:a17:902:c453:b0:1a2:96d6:7d8 with SMTP id m19-20020a170902c45300b001a296d607d8mr22588374plm.28.1683911031783;
        Fri, 12 May 2023 10:03:51 -0700 (PDT)
Received: from localhost (187.137.203.35.bc.googleusercontent.com. [35.203.137.187])
        by smtp.gmail.com with ESMTPSA id i2-20020a170902c94200b001aae909cfbbsm8188422pla.119.2023.05.12.10.03.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 May 2023 10:03:51 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Matthieu Moy <Matthieu.Moy@univ-lyon1.fr>
Cc:     Sergey Organov <sorganov@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Can we clarify the purpose of `git diff -s`?
References: <645c5da0981c1_16961a29455@chronos.notmuch>
        <871qjn2i63.fsf@osv.gnss.ru>
        <5bb24e0208dd4a8ca5f6697d578f3ae0@SAMBXP02.univ-lyon1.fr>
        <4f713a29-1a34-2f71-ee54-c01020be903a@univ-lyon1.fr>
Date:   Fri, 12 May 2023 10:03:51 -0700
Message-ID: <xmqqo7mpqy6g.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Matthieu Moy <Matthieu.Moy@univ-lyon1.fr> writes:

> https://public-inbox.org/git/51E3DC47.70107@googlemail.com/
>
> Essentially, Stefan Beller was using 'git show --format="%ad"' and
> expecting it to show only the author date, and for merge commits it
> also showed the patch (--cc). I suggested -s and noticed that the
> option wasn't easily discoverable, hence the patch series to better
> document it and add --no-patch as a synonym.
>
> Probably I did not get all the subtleties of the different kinds of
> outputs. I guess I considered the output of diff to be the one
> specified by --format plus the patch (not considering --raw, --stat &
> friends), hence "get only the output specified by --format" and
> "disable the patch" were synonym to me.

Thanks for double checking.  It matches my recollection that we (you
the author and other reviewers as well) added "--no-patch" back then
to mean "no output from diff machinery, exactly the same as '-s' but
use a name that is more discoverable".

> Looking more closely, it's
> rather clear to me they are not, and that
>
>   git show --raw --patch --no-patch
>
> should be equivalent to
>
>   git show --raw

Yeah.  If this were 10 years ago and we were designing from scratch,
the "no output from diff machinery, more discoverable alias for
'-s'" would have been "--silent" or "--squelch" and we would made
any "--no-<format>" to defeat only "--<format>".

It is a different matter if we can safely change what "--no-patch"
means _now_.  Given that "--no-patch" was introduced for the
explicit purpose of giving "-s" a name that is easier to remember,
and given that in the 10 years since we did so, we may have acquired
at least a few more end users of Git than we used to have, hopefully
your change have helped them discover and learn to use "--no-patch"
to defeat any "--<format>" they gave earlier as initial options in
their script, which will be broken and need to be updated to use a
much less discoverable "-s".

Thanks.
