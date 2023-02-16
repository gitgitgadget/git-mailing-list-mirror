Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E77F3C636CC
	for <git@archiver.kernel.org>; Thu, 16 Feb 2023 18:39:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229789AbjBPSjW (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Feb 2023 13:39:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230161AbjBPSjO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Feb 2023 13:39:14 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6419C52889
        for <git@vger.kernel.org>; Thu, 16 Feb 2023 10:39:06 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id s8so1835777pgg.11
        for <git@vger.kernel.org>; Thu, 16 Feb 2023 10:39:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=574kIjZKMz1pK6xcMsfdwdG2jBqHZ+CSFja51o/bE18=;
        b=U8up4ZpHLg4WbW8FuzE5ONFFD/qDHsTbigG26SINvKA/Yf8tTJv0i3jKq+FA1IyLmL
         P4QVeSNpJSSoh9/HBmzdB6jkZHuNpQwsI35yyxiqP0HuY6NjudhSCFGE/wzPdt3JVeZI
         bdZlw1a5LKTyNkPILEWCek/vdlH0OWhYXDRO1wjLkzb2QaonlrEvv6KeU6S3MScCHM0w
         3v2ZRvyxR1E8wqR2xB6dUIDrQg0wVjv//G1eOkeWy+CX3FxZTfkUfPwOm7zxWQjMzwDn
         P4RrZ6+HPpJuELVr7IFLeaT9BoSo/qrwIZG6bYhPrrtUh5j3ssISq4sA3ocmMuJlUGWe
         WXmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=574kIjZKMz1pK6xcMsfdwdG2jBqHZ+CSFja51o/bE18=;
        b=m3RfPzLZVEYjsMMHVUkAcS5XrS/8Ed1m6g/siYYErIl4B1ZnGLNwqB/7vKoJiqmcUJ
         EeRONdskaiOTaJzB0UB/T/knafcbTUdDZYuEElTkOKp87LsIF4WalSPfNd2WORT7eigr
         pOIwjuUMbj+JAY4TIz8vLq5ydQ3a7yYDXBUdl+XoWtvbqJ0zT4V6xtEAkr5qKFPwj5/5
         BCQFO9zTVYdzo+XoxJpABmzuj4dyp/zfMcriNtLFsnkYQe39a08oHBqIDsjIRuMoUl6C
         A0xrsmThwxoUtWDLx2TzZW242EFLV1IiNeToq3grVIBjPQJ1b7TABRxS6Vfnb35Ti9E1
         ugJQ==
X-Gm-Message-State: AO0yUKV7lx97pp9htw6xz3gVXVrupU/pnzhikePOEsElTyHq2bA1Zrax
        XHe3St+SmE9ZDHglH7an+AdD6KAuw/k=
X-Google-Smtp-Source: AK7set96iJEtgZK+OjxBskJ/dm8rKwVXKMkIM5D8Q9tcihgCaQr0ZV8Nj9KS+q5koEZurj9/E6pmXA==
X-Received: by 2002:a62:1c47:0:b0:5a8:bc09:6430 with SMTP id c68-20020a621c47000000b005a8bc096430mr6299260pfc.23.1676572745720;
        Thu, 16 Feb 2023 10:39:05 -0800 (PST)
Received: from localhost (252.157.168.34.bc.googleusercontent.com. [34.168.157.252])
        by smtp.gmail.com with ESMTPSA id q16-20020a62ae10000000b005939de7104asm1596894pff.215.2023.02.16.10.39.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Feb 2023 10:39:05 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Teng Long <dyroneteng@gmail.com>
Cc:     avarab@gmail.com, git@vger.kernel.org, sunshine@sunshineco.com,
        tenglong.tl@alibaba-inc.com
Subject: Re: [PATCH v5 1/3] notes.c: cleanup 'strbuf_grow' call in
 'append_edit'
References: <cover.1676551077.git.dyroneteng@gmail.com>
        <9a4506692239db52c2632346c079d9ac82946c8d.1676551077.git.dyroneteng@gmail.com>
Date:   Thu, 16 Feb 2023 10:39:05 -0800
In-Reply-To: <9a4506692239db52c2632346c079d9ac82946c8d.1676551077.git.dyroneteng@gmail.com>
        (Teng Long's message of "Thu, 16 Feb 2023 21:05:03 +0800")
Message-ID: <xmqqk00hpi9i.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Teng Long <dyroneteng@gmail.com> writes:

> Let's cleanup the unnecessary 'strbuf_grow' call in 'append_edit'. This
> "strbuf_grow(&d.buf, size + 1);" is prepared for insert a blank line if
> needed, but actually when inserting, "strbuf_insertstr(&d.buf, 0,
> "\n");" will do the "grow" for us.

Correct.  I think the code ends up trying to exactly size the strbuf
as multiple "-m message" options are encountered on the command
line, which is probably pointless (see below).

> Best guess may be that the author originally inserted "\n" manually by
> direct manipulation of the strbuf rather than employing a strbuf
> function, but then switched to strbuf_insert() before submitting the
> series and forgot to remove the now-unnecessary strbuf_grow().

Please do not speculate when you do not have to.  "git blame" is
your friend.

348f199b (builtin-notes: Refactor handling of -F option to allow
combining -m and -F, 2010-02-13) added these to mimic the code
introduced by 2347fae5 (builtin-notes: Add "append" subcommand for
appending to note objects, 2010-02-13) that reads in previous note
before the message.  And the resulting code with explicit sizing is
carried to this day.

In the context of reading an existing note in, exact sizing may have
made sense, but because the resulting note needs cleansing with
stripspace() when appending with this option, such an exact sizing
does not buy us all that much in practice.

It may help avoiding overallocation due to ALLOC_GROW() slop, but
nobody can feed so many long messages for it to matter from the
command line.

> Signed-off-by: Teng Long <dyroneteng@gmail.com>
> Helped-by: Eric Sunshine <sunshine@sunshineco.com>
> ---
>  builtin/notes.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/builtin/notes.c b/builtin/notes.c
> index 80d9dfd2..23cb6f0d 100644
> --- a/builtin/notes.c
> +++ b/builtin/notes.c
> @@ -215,7 +215,6 @@ static int parse_msg_arg(const struct option *opt, const char *arg, int unset)
>  
>  	BUG_ON_OPT_NEG(unset);
>  
> -	strbuf_grow(&d->buf, strlen(arg) + 2);
>  	if (d->buf.len)
>  		strbuf_addch(&d->buf, '\n');
>  	strbuf_addstr(&d->buf, arg);
> @@ -618,7 +617,6 @@ static int append_edit(int argc, const char **argv, const char *prefix)
>  		enum object_type type;
>  		char *prev_buf = read_object_file(note, &type, &size);
>  
> -		strbuf_grow(&d.buf, size + 1);
>  		if (d.buf.len && prev_buf && size)
>  			strbuf_insertstr(&d.buf, 0, "\n");
>  		if (prev_buf && size)
