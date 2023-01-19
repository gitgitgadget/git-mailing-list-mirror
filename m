Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B533C00A5A
	for <git@archiver.kernel.org>; Thu, 19 Jan 2023 06:26:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229741AbjASG0s (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Jan 2023 01:26:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjASG0n (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Jan 2023 01:26:43 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FEB6654DB
        for <git@vger.kernel.org>; Wed, 18 Jan 2023 22:26:42 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id d9so1396633pll.9
        for <git@vger.kernel.org>; Wed, 18 Jan 2023 22:26:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8ddRLQid/ePaK0F1V5BU9x5O3Fi2ZggK+Xua9H/+1Xw=;
        b=UON2HtZVKrQw7/7xJeg7Gg21ORPXPdO5+bT67Kj9f1jzVh7irCuODf8YWKVEk3LgVg
         agZ6fNpwr0DbLe0V0xASwPzpxQmsS3DV9+9lSIdOlCaTEKsxYYquIAISAsWoDEvT2ote
         30HAcMH002VaNST9YblpZM6F6e3rR9kTYdSLJMPp8Th81dvUpqnM2tzwhorghF3DRGxr
         Cm5FIBHp2jSxaeHU6phzITooAtNoRrFflUI5aQA/W7H+MQ26yvl/KazNQ+vo9pRS1lxi
         aFwD//Pw0MNA3Gtoq48EkN6h1iIu8OGHdeVKhEZ2YcyGSaxR6wM2AYTeuX+DELIHJ0NQ
         C5DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8ddRLQid/ePaK0F1V5BU9x5O3Fi2ZggK+Xua9H/+1Xw=;
        b=pYv75BQaQMiwCDKBBC8C4kfmmropcOz23ccj0CTQZ9kDogotykCAPS7h0EjX8qAr5o
         AA70ajFx7jlh0GbEEgK2kEgUEP9H/1gMUoQGeRJz/23vSuT7xEiMIjKfaCJJyT/wEz+t
         uIBCbNFRUZgRzwEHI3H3cPtezjOoP4+0FUWeSYRyg6G3JU2FyfHFxT/vpzGVaxu85OCR
         udZVr+2guYsS9taNpeI6u8zWWbLHVQC8+bVEH0AqKPwagPW1elcYJTvTJNFupsKqi3bi
         6xYmlX/UQxezAnqpfzXOnkyKc5szZz/sicuJHCmEqOd/vw4omEBlPwOOAcYU5v0Ontun
         grZA==
X-Gm-Message-State: AFqh2koHeGCj/w/8mdO2v+lVokF5Y8Q8qxV1jnn7K+KojJ5cJobQbLqk
        83r3k2NeoJuX64pm3lHgaEBH8Vzu99s=
X-Google-Smtp-Source: AMrXdXvKKfSvVSJDIzCeErGR/myJyA2wGcKwkkz7hYI+S0vctSutZGMwEzSc52dgi+k2vvBWNn9LBQ==
X-Received: by 2002:a17:90a:dc82:b0:229:f0c7:487d with SMTP id j2-20020a17090adc8200b00229f0c7487dmr119260pjv.2.1674109601569;
        Wed, 18 Jan 2023 22:26:41 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id pc3-20020a17090b3b8300b001fde655225fsm4607554pjb.2.2023.01.18.22.26.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 22:26:41 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] hash-object: fix descriptor leak with --literally
References: <Y8ijpJqtkDTi792i@coredump.intra.peff.net>
Date:   Wed, 18 Jan 2023 22:26:40 -0800
In-Reply-To: <Y8ijpJqtkDTi792i@coredump.intra.peff.net> (Jeff King's message
        of "Wed, 18 Jan 2023 20:57:56 -0500")
Message-ID: <xmqqtu0n2g67.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> In hash_object(), we open a descriptor for each file to hash (whether we
> got the filename from the command line or --stdin-paths), but never
> close it. For the traditional code path which feeds the result to
> index_fd(), this is OK; it closes the descriptor for us.
>
> But 5ba9a93b39 (hash-object: add --literally option, 2014-09-11) a
> second code path which does not close the descriptor.

A sentence without verb?  "5ba9 (hash-...) added a second code path,
which does not close the descriptor." or something?

> After this patch, it completes successfully. I didn't bother with a
> test, as it's a pain to deal with descriptor limits portably, and the
> fix is so trivial.

True.  Will queue.  Thanks.

> I do think the world would be less confusing if index_fd() didn't close
> the descriptor we pass it, and then hash_file() could just do:
>
>   fd = open();
>   hash_fd(fd);
>   close(fd);
>
> which is much more readable. But it has many other callers. So even if
> we wanted to untangle all that, I think it makes sense to do this
> obvious fix in the meantime.

Indeed, thanks.

>  builtin/hash-object.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/builtin/hash-object.c b/builtin/hash-object.c
> index b506381502..44db83f07f 100644
> --- a/builtin/hash-object.c
> +++ b/builtin/hash-object.c
> @@ -27,6 +27,7 @@ static int hash_literally(struct object_id *oid, int fd, const char *type, unsig
>  	else
>  		ret = write_object_file_literally(buf.buf, buf.len, type, oid,
>  						 flags);
> +	close(fd);
>  	strbuf_release(&buf);
>  	return ret;
>  }
