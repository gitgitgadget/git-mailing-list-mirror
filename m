Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93546C77B75
	for <git@archiver.kernel.org>; Fri, 12 May 2023 16:58:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237696AbjELQ6A (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 May 2023 12:58:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229654AbjELQ57 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 May 2023 12:57:59 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB69B358A
        for <git@vger.kernel.org>; Fri, 12 May 2023 09:57:58 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-64359d9c531so7678825b3a.3
        for <git@vger.kernel.org>; Fri, 12 May 2023 09:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683910678; x=1686502678;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z6HeqRwBW8eRVnNjX8rkRnlsPL+MYEM26UIsqKgxxOk=;
        b=KpH/QakRGZaEfrYL3rcSchvTQ285Yj/WC57j6vfkQyemrJ0yW1o9M2T2UryX97RaPv
         QBiV9Uj1uHYOD4DBhpkndjZeLkfq2SBYHTauQavWvcGX6A10YC549SvSPgshGfoWKZGW
         eaVYy+ZC6J+77HsxXlf++LbLpCkXX33/4hIP82fLCeQnMKMA/xuN+nJkUjvvgA7NIily
         5/U74377ZsSs2E5nb980WAggSCXI/m+UfJTNiu+fOB6XdZw0neG6DvRopek6nfJVz9Te
         Cs1eE4ls5y3PGgdGb59oZPY+dkJQwqvyzA1j4bsou0aYGMW3G2qG8synM2WioWshc9ke
         YvNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683910678; x=1686502678;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=z6HeqRwBW8eRVnNjX8rkRnlsPL+MYEM26UIsqKgxxOk=;
        b=gUOCEfKGkI9gxbI6S8S5uncQYHEf+gUQ0T6kcUGpE8xeJs39ue62Um52umFta0C34O
         jHCMHdM3SKNbQLruYPQQjHdbTm8C0Jyk2gsMptUnHLkn5PcwpCjxe2Hjxy7Be/lwfp03
         4sYUWlbEjvl1v9OooETrop1brxFoL4kJxmOM1QOwl8fO99iIySpbP4AEjKK3pUoNdLNc
         Q+iPSU27Eg7EOufQpxXSPxcWm26Mk7dMABNY+QzHU6MfhKRGJNYm2ntrjzBMGIGe5wGL
         odwd61YwmitdUQuPsfj8Bk7oRyKdyxhtPmOEzGnPFKYjavfNM7evB6GH3wb3I6Qb1cGc
         aTmw==
X-Gm-Message-State: AC+VfDxpXigBg4q0xw2O5bDDWTNmxbtptI9fTtu3g7+NfbTxoPhxCUtB
        gpm+VzvC5cM5Pfxk99Eg5So=
X-Google-Smtp-Source: ACHHUZ5VlfjVN8wzTCWY/dLGDRtPUZdD7FvBr+rAEhqFIUmqaSOwk3cNHSkA9aip07SFZXzNpyzWBw==
X-Received: by 2002:a05:6a20:9192:b0:f4:ac2d:8ea0 with SMTP id v18-20020a056a20919200b000f4ac2d8ea0mr29356628pzd.32.1683910678112;
        Fri, 12 May 2023 09:57:58 -0700 (PDT)
Received: from localhost (187.137.203.35.bc.googleusercontent.com. [35.203.137.187])
        by smtp.gmail.com with ESMTPSA id e24-20020aa78258000000b0062dd8809d6esm7272089pfn.150.2023.05.12.09.57.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 May 2023 09:57:57 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Toon Claes <toon@iotcl.com>
Cc:     git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v5 1/1] cat-file: quote-format name in error when using -z
References: <xmqqilfhctrr.fsf@gitster.g>
        <20230510190116.795641-1-toon@iotcl.com>
        <20230510190116.795641-2-toon@iotcl.com> <xmqqpm782be6.fsf@gitster.g>
        <87h6sh6f81.fsf@iotcl.com>
Date:   Fri, 12 May 2023 09:57:56 -0700
In-Reply-To: <87h6sh6f81.fsf@iotcl.com> (Toon Claes's message of "Fri, 12 May
        2023 10:54:20 +0200")
Message-ID: <xmqqy1ltqygb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Toon Claes <toon@iotcl.com> writes:

> Ideally the output should be NUL-terminated if -z is used. This was also
> suggested[2] when the flag was introduced. Obviously we cannot change
> this now, because it would break behavior for *everyone* using -z, not
> only when funny names are used. So if we want to go this route, we
> should only do so with another flag (e.g. `--null-output`) or a config
> option.

Yes, `--null-output` came also to my mind.  As this new mode of
output is for consumption by programs, letting them read
NUL-terminated records is a viable, if cumbersome, possibility.

> But I was looking at the git-config(1) documentation:
>
>> core.quotePath::
>> 	Commands that output paths (e.g. 'ls-files', 'diff'), will
>> 	quote "unusual" characters in the pathname by enclosing the
>> 	pathname in double-quotes and escaping those characters with
>> 	backslashes in the same way C escapes control characters (e.g.
>> 	`\t` for TAB, `\n` for LF, `\\` for backslash) or bytes with
>> 	values larger than 0x80 (e.g. octal `\302\265` for "micro" in
>> 	UTF-8).  If this variable is set to false, bytes higher than
>> 	0x80 are not considered "unusual" any more. Double-quotes,
>> 	backslash and control characters are always escaped regardless
>> 	of the setting of this variable.  A simple space character is
>> 	not considered "unusual".  Many commands can output pathnames
>> 	completely verbatim using the `-z` option. The default value
>> 	is true.
>
> If you read this, the changes of this patch fully contradict this.

Hmph, I do not quite see where the contradiction is.  If you mean
"Many commands can output" part, I do not think it applies here.
First, your "cat-file" does not have to be a part of "many".  More
importantly, the mention of `-z` there is about the option accepted
by the diff family of commants, e.g. "git diff --name-only -z
HEAD^", that is an output record separator.  Your "-z" is about the
input record separator, and if you are not changing "-z" to suddenly
mean both input and output  separator to break existing scripts that
expect "-z" only applies to input, the above "completely verbatim"
does not apply to you.

> Also
> documentation on other commands (e.g. git-check-ignore(1)) using `-z`
> will mention the verbatim output.

Again, it is about the output.

Stepping back a bit, how big a problem is this in real life?  It
certainly is possible to create a pathname with funny byte values in
it, and in some environments,letters like single-quote that are
considered cumbersome to handle by those who are used to CLI
programs may be commonplace.  But a path with newline?  Or any
control character for that matter?  And this is not even the primary
output from the program but is an error message for consumption by
humans, no?

I am wondering if it is simpler to just declare that the paths
output in error messages have certain bytes, probably all control
characters other than HT, replaced with a dot, and tell the users
not to rely on the pathnames being intact if they contain funny
bytes in them.  That way, with the definition of "work" being "you
can read the path out of error messages that talk about it", paths
with bytes that c-quote mechanism butchers, like double quotes and
backslashes, that have worked before will not be broken, and paths
with LF or CRLF in them that have never worked would not work, but
at least does not break the input stream of whoever is reading the
error messages line by line.

I dunno.


