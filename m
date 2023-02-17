Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A860C636D6
	for <git@archiver.kernel.org>; Fri, 17 Feb 2023 22:58:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229906AbjBQW6W (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Feb 2023 17:58:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229916AbjBQW6O (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Feb 2023 17:58:14 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A59DC6A073
        for <git@vger.kernel.org>; Fri, 17 Feb 2023 14:57:31 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id e14so836033plg.8
        for <git@vger.kernel.org>; Fri, 17 Feb 2023 14:57:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kBDlAtaHDtUgGLFNvd+wLdT+TIwEOi51hFXaGysnQhc=;
        b=XgvgXTtR683K/XArTTNnlJQYm5xsHXPJCOsnrBintaNkZ/t/MjnV/X2VX91OmRHNyG
         nKLPMXEasmbbsJDe97hehlvjyJnM55XFyjSXdK349ZjDZ8Nd/l/tC0kihSqod4tcwuG2
         uGKERE7KSnDWMC5bqn1cxlVJe7oS8Mu1B3hLOpO9MKTAVDv5ZdjbSgeYKc3JG2blRwI3
         /OX77n7dJiiEDe/afZXGT90xuOI+EmMPZPv0cGhrGr/YlYqX4bOGM3aIN5x6C2QE69Fy
         QiqqZq3W6ikk/Zra0H80FDmcHYyLFfSUF0Iizl9b/V9nEosX4qHbqhNYaKtOdxTi2hdt
         d9ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kBDlAtaHDtUgGLFNvd+wLdT+TIwEOi51hFXaGysnQhc=;
        b=rGizlBrUqXGPGJwZXddHRvRUBqekDR8sdaE8/E3imM3F4VcW0rF+AlQ/DqLZqpGdBQ
         ExBGrk56ok7QNmhWQfBOsb5fZWyc7xxMFblbduWG0rlTZl1TgtiW7WT4A3OO/0zsMOwN
         ankEmGEGEdva57/HIkcfC6UHjq8tYv6FxSOqraX/m/pOJmT1cGpOfCfpsFTtogXWs7Q3
         gikdBO3yxYCxEyHN+JxW67Gf/adQ/pfNELU1HeCfQMp/Blj0sowi/r0GA9xgDYlSiRHn
         IJvHr/ImvqlUcfFdPFj1J5EFWS+xAHIC+M3CSlKoD4oK2fmc/mqOUF5Bt2x4IzCoGXqq
         HtZg==
X-Gm-Message-State: AO0yUKU8psUSObFa7/ewlylxa+Z3/xlJZkFEhxz9cGXlP+DqoLSdJtqS
        TXjhkRV2nkIYrlxPeGvVktE=
X-Google-Smtp-Source: AK7set+ZDIVEJzSbFQqxMTQvg3KvnuU4+qNK78s7cC6z1IIjidrbWNNKZKwK1VT4Xu3U6/h1Q0X9xA==
X-Received: by 2002:a17:90b:1810:b0:236:73e8:f4c with SMTP id lw16-20020a17090b181000b0023673e80f4cmr3462121pjb.2.1676674650927;
        Fri, 17 Feb 2023 14:57:30 -0800 (PST)
Received: from localhost (252.157.168.34.bc.googleusercontent.com. [34.168.157.252])
        by smtp.gmail.com with ESMTPSA id i20-20020a17090aee9400b002339491ead6sm1336381pjz.5.2023.02.17.14.57.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Feb 2023 14:57:30 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Emily Shaffer <nasamuffin@google.com>
Cc:     Git List <git@vger.kernel.org>, Jonathan Nieder <jrn@google.com>,
        Jose Lopes <jabolopes@google.com>,
        Aleksandr Mikhailov <avmikhailov@google.com>
Subject: Re: Proposal/Discussion: Turning parts of Git into libraries
References: <CAJoAoZ=Cig_kLocxKGax31sU7Xe4==BGzC__Bg2_pr7krNq6MA@mail.gmail.com>
Date:   Fri, 17 Feb 2023 14:57:30 -0800
In-Reply-To: <CAJoAoZ=Cig_kLocxKGax31sU7Xe4==BGzC__Bg2_pr7krNq6MA@mail.gmail.com>
        (Emily Shaffer's message of "Fri, 17 Feb 2023 13:12:23 -0800")
Message-ID: <xmqq3573lx2d.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emily Shaffer <nasamuffin@google.com> writes:

> Basically, if this effort turns out not to be fruitful as a whole, I'd
> like for us to still have left a positive impact on the codebase.
> ...
> So what's next? Naturally, I'm looking forward to a spirited
> discussion about this topic - I'd like to know which concerns haven't
> been addressed and figure out whether we can find a way around them,
> and generally build awareness of this effort with the community.

On of the gravest concerns is that the devil is in the details.

For example, "die() is inconvenient to callers, let's propagate
errors up the callchain" is an easy thing to say, but it would take
much more than "let's propagate errors up" to libify something like
check_connected() to do the same thing without spawning a separate
process that is expected to exit with failure.

It is not clear if we can start small, work on a subset of the
things and still reap the benefit of libification.  Is there an
existing example that we have successfully modularlized the API into
one subsystem?  Offhand, I suspect that the refs API with its two
implementations may be reasonably close, but is the inteface into
that subsystem the granularity of the library interface you guys
have in mind?

