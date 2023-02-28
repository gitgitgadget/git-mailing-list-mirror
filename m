Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0BDEC64EC7
	for <git@archiver.kernel.org>; Tue, 28 Feb 2023 14:11:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229789AbjB1OLP (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Feb 2023 09:11:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbjB1OLN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Feb 2023 09:11:13 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D09D52FCFA
        for <git@vger.kernel.org>; Tue, 28 Feb 2023 06:11:11 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id v11so7031371plz.8
        for <git@vger.kernel.org>; Tue, 28 Feb 2023 06:11:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677593471;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pj+uQrHHSx5V9g2T/Fa8xXLrQAQXLLQDbnKBM2Jjak0=;
        b=o4dSCXguqUswDuDDOXtKlMkbi1K7MpO0vNUzYLk5NhSfJJvpMJDiw2ONBylHafkjcs
         PuPxi+tzG5elA4/eOzsO94Eq9WAPXxePhzhs1qy94V7iDXAvdFEJTmW4pZfKVHvqgga+
         f31NN7KofpaDa+q8SuFSSB2o65FRvEPPtu/+k+02P3NJWw9utPqb+CX2eVohY76Y9tQx
         CumqlFCyofOBkEkhsWS8LQOwZyGB5XA1LzX6GN9CaRE3UMROWKkWTAq1bcpQGOqxuxKg
         oHERZQBUoSNsuOCEDw2SwlwdWMbD3omtLFjgeaG742zP+VM1sZ1xvAwxfDGlq3SayucU
         OYeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677593471;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pj+uQrHHSx5V9g2T/Fa8xXLrQAQXLLQDbnKBM2Jjak0=;
        b=x6t2prYuW6HEBD6Edr7fOEpyw6RgP+RBmFw6lE4a85+63MFW5wJ8w5HAGbeoaBNbMW
         peTp3giUSqmVniqxoIIGPieHkTPgxjzkjeuJWXBF3V4GwfQGl20OuqLvb5DA1oeP5Y+B
         H6cB88P0Ue7yEddis2SY+2b6/Nm+6nDkO2BCchpa2N+fMPnwyINJPwyUMs7PKsXDzhQC
         imuffm5eSOJBbt5j6EKNrQ3wi+74loEqUm+2KM2TaZjl5ZvDTNFFSgOpCVgqrXhDDeU8
         pHDm+OGjDQEhNPy5zXgruZgocvHj18sWy3nF8X+yq3+MsN0X9tkd+4cB6tPsjYLLg51a
         l6gg==
X-Gm-Message-State: AO0yUKWRmpme/BTkIxQKsx/5zUvwgBEBzBLNa2ZYyvFae5gON0YUTPjW
        awNMOgqCViVqobvmoRUB/vcApj6ON1XGZnsB
X-Google-Smtp-Source: AK7set/l7JyYYC8i+ShxG8Qt7glc9G2ahs2Z03BA2y7r4SBt1kxtFH4tzp+XrFOoZurYS/cReDDCuA==
X-Received: by 2002:a17:90b:1bc8:b0:233:d854:2701 with SMTP id oa8-20020a17090b1bc800b00233d8542701mr3615795pjb.41.1677593470980;
        Tue, 28 Feb 2023 06:11:10 -0800 (PST)
Received: from localhost.localdomain ([47.246.101.61])
        by smtp.gmail.com with ESMTPSA id u6-20020a17090a1d4600b0023739b75710sm6198263pju.10.2023.02.28.06.11.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Feb 2023 06:11:10 -0800 (PST)
From:   Teng Long <dyroneteng@gmail.com>
X-Google-Original-From: Teng Long <tenglong.tl@alibaba-inc.com>
To:     gitster@pobox.com
Cc:     avarab@gmail.com, dyroneteng@gmail.com, git@vger.kernel.org,
        sunshine@sunshineco.com, tenglong.tl@alibaba-inc.com
Subject: Re: [PATCH v6 3/3] notes.c: introduce '--separator=<paragraph-break>' option
Date:   Tue, 28 Feb 2023 22:11:03 +0800
Message-Id: <20230228141103.47275-1-tenglong.tl@alibaba-inc.com>
X-Mailer: git-send-email 2.39.2.459.gd58159df.dirty
In-Reply-To: <xmqqcz608cpk.fsf@gitster.g>
References: <xmqqcz608cpk.fsf@gitster.g>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com>:

> > So this commit
> > introduces a new '--separator' option for 'git-notes-add' and
> > 'git-notes-append', for example when execute:
>
>     Introduce a new '--separator' option for 'git notes add' and
>     'git notes append'.

Thanks, I will avoid this like 'git-subcommand' expression in the future.

> > We will check the option value and if the value doesn't contail
> > a trailing '\n', will add it automatically,
>
> contail?

"contain", sorry.

> 	A newline is added to the value given to --separator if it
> 	does not end with one already.

Will apply.

> > so execute
> >       $ git notes add -m foo -m bar --separator="-"
> > and
> >       $ export LF="
> >       "
> >       $ git notes add -m foo -m bar --separator="-$LF"
> >
> > have the same behavour.
>
> 	Running A and B produces the same result.

Will s/Running A and B produces the same result/have the same behavour

>  - The default delimiter?  Delimiter for what?  I am puzzled.
>
> at the third step, gets puzzled.  The command takes the existing
> note's contents, adds a delimiter and then appends the new material
> given by the user, but because that is not clear after reading the
> first two lines, the sudden appearance of "delimiter" would confuse
> readers.
>
> > +	option to insert other delimiters. More specifically, if the
> > +	note and the message are not empty, the delimiter will be
> > +	inserted between them. If you specify multiple `-m` and `-F`
>
> Again, the order of presentation is somewhat backwards and that is
> why we need to say "More specifically" here.
>
> > +	options, the delimiter will be inserted between the messages
> > +	too.
>
> 	Append new message(s) given by `-m` or `-F` options to an
> 	existing note, or add them as a new note if one does not
> 	exist, for the object (defaults to HEAD).  When appending to
> 	an existing note, a blank line is added before each new
> 	message as an inter-paragraph separator.  The separator can
> 	be customized with the `--separator` option.

Will apply.

> Here is where you need to say about promoting incomplete line
> separator more than the proposed log message.
>
> 	Specify a string used as a custom inter-paragraph separator
> 	(a newline is added at the end as needed).  Defaults to a
> 	blank line.

Will apply.

> > +static void insert_separator(struct strbuf *message, size_t pos)
> > +{
> > +	if (!separator)
> > +		strbuf_insertstr(message, pos, "\n");
> > +	else if (separator[strlen(separator) - 1] == '\n')
> > +		strbuf_insertstr(message, pos, separator);
> > +	else
> > +		strbuf_insertf(message, pos, "%s%s", separator, "\n");
> > +}
>
> It looks like you are very fond of "insert", but aren't we always
> appending with the latest control flow?  In other words, is it worth
> carrying 'pos' around?

Actually I can't find a more suitable verb. I think it worth, but I'm
not sure whether there is a better way, that is, when we add separator which
use to contact messages like multiple '-m' and '-F', the 'pos' is at the end.
When we add separator which use to contact the prev_notes and the new notes
, the 'pos' is at the head.

> > +static void parse_messages(struct string_list *messages, struct note_data *d)
> > +{
> > +	size_t i;
> > +	for (i = 0; i < messages->nr; i++) {
> > +		if (d->buf.len)
> > +			insert_separator(&d->buf, d->buf.len);
> > +		strbuf_insertstr(&d->buf, d->buf.len,
> > +				 messages->items[i].string);
> > +		strbuf_stripspace(&d->buf, 0);
>
> This is not a new problem, but if we get three 100-byte messages, we
>
>  - add the first 100-byte message to d->buf and then run
>    stripspace() over that 100-byte.
>
>  - add separator and then the second 100-byte message to d->buf, and
>    then run stripspace() over that 200-plus-byte.
>
>  - add separator and then the third 100-byte message to d->buf, and
>    then run stripspace() over that 300-plus-byte.
>
> Shouldn't we be doing better?

After I read the comments of 'strbuf_stripspace', it does :

1. remove empty lines from beginning and end.
2. turn multiple empty lines between paragraphs into just one empty line.
3. if the input has only empty lines and spaces, no output will be produced.
4. if the last line doesn't have a newline at the end, one is added.
5. skip every commentted line if skip_comments is enabled.

I think above the five functions in 'strbuf_stripspace', we may just care about
the fourth, the others just like the logic when we edit the commit message when
doing 'git commit' or 'git merge', etc. My opinion is a "commit note" and a
"commit message" maybe not be the same, and sometimes the user might want a
blank line or something at the beginning of the notes. But after I read the
tests I think they are just the same. So, let me just fix this by stripspace
the message individually, thanks.

> Do we understand what d->given flag represents?  My understanding is
> that it becomes true only when any of the -m/-F/-c/-C options are given
> to tell the command what message to use, so that we can automatically
> open the editor to ask for the message when nothing is given.
> 
> So, I suspect that
> 
> 	d->given = !!messages->nr;
> 
> at the beginning of the function, or
> 
> 	d->given = !!d->buf.len;
> 
> may be equivalent[*], instead of setting it once every iteration?
> 
> 	Side note: The latter is slightly more strict, as giving a
> 	run of empty strings with the default separator would result
> 	in an empty d->buf and d->given will become false.

I agree, we should choose the latter and move "d->given = !!d->buf.len;"
behind the place where we concat the messages.


> Now d->given is set in parse_reuse_arg() and parse_reedit_arg(),
> because -c/-C is another source of a paragraph.  Shouldn't the
> paragraph taken by these options go in the message list to be
> concatenated together with other messages, or are -c/-C incompatible
> with -m/-F and we are OK with two separate and distinct behaviour?

Yes, my bad. -c/-C should be considered as well and dealing them with the same
messages-contacting logic, I will fix these two place in next patch.

> I wonder why separator is not a parameter into the helper function?

In my opinion, your proposal is probably similar to the current approach, but
your solution may be a bit more readable. I will consider changing it in the
next patch.

> other remaining "strbuf_addch(&d->buf, '\n')" in parse_reuse_arg().
> I am inclined to say that that codepath should behave the same way,
> but I didn't think it as deeply as you did, so...?

You really have a good eye, I didn't noticed them. There are two place remained,
the first one is "parse_reuse_arg", second one is "prepare_note_data" it's made
for separate the note and the commented lines (note template), I think they
should both be replaced/impacted by "--separator".

Thanks.
