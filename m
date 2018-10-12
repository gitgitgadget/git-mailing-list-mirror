Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 87B461F97E
	for <e@80x24.org>; Fri, 12 Oct 2018 12:23:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728539AbeJLTz4 (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 Oct 2018 15:55:56 -0400
Received: from mail-wm1-f49.google.com ([209.85.128.49]:51088 "EHLO
        mail-wm1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728213AbeJLTz4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Oct 2018 15:55:56 -0400
Received: by mail-wm1-f49.google.com with SMTP id i8-v6so12052242wmg.0
        for <git@vger.kernel.org>; Fri, 12 Oct 2018 05:23:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YTGZs6w+DHJMw03/DYsqT9bD+aQ/ggeK9IPbtVr4VuA=;
        b=oUNGdkBgYCNrVVQ154XndbgjXQP0aYwGwwRbaZu+cMXAc4hEK71DrnvFNOxTDRfwBa
         StTRG6ObEPa33mnjYI9qm81HIiWhmPyGXN/+VoaIb3cBaUTTIDQKO52umP9i+vX8UTvt
         Tuxa9rPSf2LI+5JR02f1NAzWaUmSZoW9Z97WOt+ePi7ugbD0fM2H/gY30En3Rs96trTM
         UNk+tvzX//eFp8SPsRRzhmW/QZsnBFw02qk7+1x4DEJpg5m3WqGL0Fiu4rSuCDkHNUbz
         u3rodgg+PvTXRYBgevFpUV5VbkkZ+GwxMLmYveT3WSpwLrs/6ZP3tTZZOrMa2E9ZB7Zg
         9pCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YTGZs6w+DHJMw03/DYsqT9bD+aQ/ggeK9IPbtVr4VuA=;
        b=sneOtKZY8pNOvEynyQ1CSDZG01RRnD+VLv2PYTnBU7SfSlBx95x9pL4w/wy/A63aBa
         +uA1LMSF7VLMnc/xiBBSHWl3b1z2oT8JHj7a9Q86uGpI11sMOBik8feR7ocidw/POt9E
         6JkhfXHLQSsj5gZK7NWISjyBmFjZFRiier9k2GgskJqPglgZ4XBVTv9ddSB2UfN6lVuP
         mVrWm1UUnnWptY/OSxk7bpi825pTaRoyExitAIDaY2LipU4ieNJpfOmPsrAuQrnNRY7+
         Be55vqQegpAmVC9McOXIkhV9xt9tsVSYD+cu7xa2nyB+8O+s+8Z45HB87zCFJhIf2WEF
         +rOw==
X-Gm-Message-State: ABuFfogc0nIre1kAbL+LcZJ6fvQVidxJiqXYJBlD/K4OqYphjxA2z+ku
        wPFLgmcghpY7s6xuABKXB7U=
X-Google-Smtp-Source: ACcGV622PqOaNm1KP1ybttSM8x+gSe1wyCUXzr8UDA4HMdUO7z2rbzYJtRE+wa3L1j35KQsJANLQjw==
X-Received: by 2002:a1c:7c16:: with SMTP id x22-v6mr4848049wmc.16.1539347020142;
        Fri, 12 Oct 2018 05:23:40 -0700 (PDT)
Received: from andromeda.localnet (wifi-eduroam-trans.univ-tlse3.fr. [195.220.58.237])
        by smtp.gmail.com with ESMTPSA id u5-v6sm1213420wru.16.2018.10.12.05.23.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 12 Oct 2018 05:23:39 -0700 (PDT)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     phillip.wood@dunelm.org.uk
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 04/15] sequencer: refactor sequencer_add_exec_commands() to work on a todo_list
Date:   Fri, 12 Oct 2018 14:23:32 +0200
Message-ID: <1861868.piMsbFIpbn@andromeda>
In-Reply-To: <10482114-7954-2d1d-1612-f2b559d4ca8f@talktalk.net>
References: <20181007195418.25752-1-alban.gruin@gmail.com> <6c55857a-ce3c-f9fc-18c6-d7cef2976931@gmail.com> <10482114-7954-2d1d-1612-f2b559d4ca8f@talktalk.net>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Le 12/10/2018 =E0 11:54, Phillip Wood a =E9crit :
> On 11/10/2018 17:57, Alban Gruin wrote:
> > Hi Phillip,
> >=20
> > thanks for taking the time to review my patches.
> >=20
> > Le 11/10/2018 =E0 13:25, Phillip Wood a =E9crit :
> >> On 07/10/2018 20:54, Alban Gruin wrote:
> >>> @@ -4419,15 +4406,38 @@ int sequencer_add_exec_commands(const char
> >>> *commands)
> >>>       }
> >>>         /* insert or append final <commands> */
> >>> -    if (insert >=3D 0 && insert < todo_list.nr)
> >>> -        strbuf_insert(buf, todo_list.items[insert].offset_in_buf +
> >>> +    if (insert >=3D 0 && insert < todo_list->nr)
> >>> +        strbuf_insert(buf, todo_list->items[insert].offset_in_buf +
> >>>                     offset, commands, commands_len);
> >>>       else if (insert >=3D 0 || !offset)
> >>>           strbuf_add(buf, commands, commands_len);
> >>>   -    i =3D write_message(buf->buf, buf->len, todo_file, 0);
> >>> +    if (todo_list_parse_insn_buffer(buf->buf, todo_list))
> >>> +        BUG("unusable todo list");}
> >>=20
> >> It is a shame to have to re-parse the todo list, I wonder how difficult
> >> it would be to adjust the todo_list item array as the exec commands are
> >> inserted. The same applies to the next couple of patches
> >=20
> > Good question.
> >=20
> > This function inserts an `exec' command after every `pick' command.
> > These commands are stored in a dynamically allocated list, grew with
> > ALLOW_GROW().
> >=20
> > If we want to keep the current structure, we would have to grow the size
> > of the list by 1 and move several element to the end every time we want
> > to add an `exec' command.  It would not be very effective.  Perhaps I
> > should use a linked list here, instead.  It may also work well with
> > rearrange_squash() and skip_unnecessary_picks().
> >=20
> > Maybe we could even get rid of the strbuf at some point.
>=20
> Another way would be to use the strbuf as a string pool rather than a
> copy of the text of the file. There could be a write_todo_list()
> function that takes a todo list and some flags, iterates over the items
> in the todo list and writes the file. The flags would specify whether to
> append the todo help and whether to abbreviate the object ids (so there
> is no need for a separate call to transform_todos()). Then
> add_exec_commands() could allocate a new array of todo items which it
> builds up as it works through the original list and replaces the
> original list with the new one at the end. The text of the exec items
> can be added to the end of the strbuf (we only need one copy of the exec
> text with this scheme). rearrange_squash() can use a temporary array to
> build a new list as well or just memmove() things but that might be
> slower if there is a lot of rearrangement to do. skip_unecessary_picks()
> could just set the current item to the one we want to start with.
>=20

This sounds good, and it looks like the solution dscho proposed on IRC a fe=
w=20
hours ago[0].  I will try to do this.

[0] http://colabti.org/irclogger/irclogger_log/git-devel?date=3D2018-10-12#=
l46

Cheers,
Alban




