Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 17AF11F453
	for <e@80x24.org>; Sat, 29 Sep 2018 19:08:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727995AbeI3BgR (ORCPT <rfc822;e@80x24.org>);
        Sat, 29 Sep 2018 21:36:17 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53253 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727823AbeI3BgR (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 Sep 2018 21:36:17 -0400
Received: by mail-wm1-f66.google.com with SMTP id b19-v6so5098917wme.3
        for <git@vger.kernel.org>; Sat, 29 Sep 2018 12:06:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=OD7NFYLXZgv7/wnc05arNR7SB0VeX9OZNBpl/An0rUg=;
        b=C2EAHg2dTnvQJ8pr/LaJqFPDPZcUKTbjOJEiZUsspKIeW9uwpO28U0cV0O9R11nNqC
         20xCsXVuP7w/Sq/IGb0IFiUhVbY4apO2JZqhoRhUcBdXMS6N5NfplyZGzMjRuLfZcGg0
         dHOXLQKm8O24MrOi2qOtoazPKBxkt/zJWUPdDJJh2lXchvmiHzdTo2bHnI+ZarrrQ6Uq
         QAOT3sge+sYqAwFvHgpJXEMNQMs6x8XbCiwXCnU5kK9nWXF6fLEy8BAV12cumsLTRCIZ
         WRkZ7bdGJuavpfQISRgyQur9Wp8WS+/lMYaFIVjAkRDjk6DAtc1YVl8n4vCb291Di+9w
         /jiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=OD7NFYLXZgv7/wnc05arNR7SB0VeX9OZNBpl/An0rUg=;
        b=NaVtiXYJtKHe9fJ8TjF90rnW8vZzc+V9uFP07A+i3wxmeNsfaYWJ7dlIewhm+zmwKq
         e2u7b4Beox2gVGx2sr0yt/ZBKhH6eylsv0fxXuqx8pZeXSjBE327E1lLihcL4Ft2pQEW
         EOFzFAdq43FbSOV8JXStrFYh9NZ+ymfybkEJXYRJzqEBeAi0c14OdMnxOX10b0lokpcr
         LKVkbIHIuVwWogBzOANGMDVpFH9zW3eu+ELGzCQdOR+9nPUnTMXGpcSxiU+SJvgK568c
         kxI64yLCKdhOHsFn55Ym8V5ruFp9DS3x/stHOrH0IdutoxGa8EyYdCEbNOGfnAeJljW2
         yBFg==
X-Gm-Message-State: ABuFfojbCg5Ud3ABa+Q/GC9IrVPEJdvVuYPoWZKdJ9eO8B8yRmUaBnMc
        vbTwElrt018YhE5GWR/vBr0=
X-Google-Smtp-Source: ACcGV62tj9Il8HJ/A1qEuMBb5HH+kbCDyTgSXtViGqweMcJrYNg6M0YQJLYQxcAeZg9JzALpRYX/Ug==
X-Received: by 2002:a1c:32c4:: with SMTP id y187-v6mr4780077wmy.31.1538248000994;
        Sat, 29 Sep 2018 12:06:40 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id f187-v6sm5780120wmg.17.2018.09.29.12.06.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 29 Sep 2018 12:06:39 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Kyle Hubert <khubert@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH] Improvement to only call Git Credential Helper once
References: <20180928163716.29947-1-khubert@gmail.com>
        <20180929081705.GI2174@sigill.intra.peff.net>
Date:   Sat, 29 Sep 2018 12:06:38 -0700
In-Reply-To: <20180929081705.GI2174@sigill.intra.peff.net> (Jeff King's
        message of "Sat, 29 Sep 2018 04:17:05 -0400")
Message-ID: <xmqqk1n486o1.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Wow, what's old is new again. Here's more or less the same patch from
> 2012:
>
>   https://public-inbox.org/git/20120407033417.GA13914@sigill.intra.peff.net/
>
> Unfortunately, some people seem to rely on this multi-helper behavior. I
> recommend reading the whole thread, as there are some interesting bits
> in it (that I had always meant to return to, but somehow 6 years went
> by).

After reading that thread again, my version of summary is that

 - storing the credential obtained from a helper back to the same
   helper may be pointless at best and may incur end-user
   interaction (e.g. asking for symmetric encryption key before the
   data hits the disk), but it can be used as a "we used what you
   gave us successfully" ping-back signal.  We may not have designed
   approve() to do "store" back to the same helper by default and
   instead to do so only when asked by the helper, if we knew
   better.  But an unconditional change of behaviour will break
   existing users and helpers.

 - storing the credential obtained from a helper to a different
   helper may have security implications, and we may not have
   designed approve() to do "store" by default to all helpers if we
   knew better.  But an unconditional change of behaviour will break
   existing users and helpers.

Assuming that the above summary is accurate, I think the former is
easier to solve.  In the ideal end game state, we would also have
"accepted" in the protocol and call the helper that gave us the
accepted credential material with an earlier "get" (if the helper is
updated to understand "accepted").  The "accepted" may not even need
to receive the credential material as the payload.

The latter is trickier, as there are design considerations.

 - We may want to allow the helper that gives the credential back
   from the outside world upon "get" request to say "you can 'store'
   this to other helpers of this kind but not of that kind".  If we
   want to do so, we'd need to extend what is returned from the
   helper upon "get" (e.g. "get2" will give more than what "get"
   does back).

 - We may want to allow the helper that receives the credential
   material from others to behave differently depending on where it
   came from, and what other helpers done to it (e.g. even a new
   credential the end user just typed may not want to go to all
   helpers; an on-disk helper may feel "I'd take it if the only
   other helpers that responded to 'store' are the transient
   'in-core' kind, but otherwise I'd ignore").  I am not offhand
   sure what kind of flexibility and protocol extension is
   necessary.

 - We may want to be able to override the preference the helper
   makes in the above two.  The user may want to say "Only use this
   on-disk helper as a read-only source and never call 'store' on it
   to add new entries (or update an existing one)."

