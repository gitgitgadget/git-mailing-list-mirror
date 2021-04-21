Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1203C433ED
	for <git@archiver.kernel.org>; Wed, 21 Apr 2021 18:26:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 79FBE61448
	for <git@archiver.kernel.org>; Wed, 21 Apr 2021 18:26:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244431AbhDUS1Q (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Apr 2021 14:27:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242566AbhDUS1Q (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Apr 2021 14:27:16 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACE7EC06174A
        for <git@vger.kernel.org>; Wed, 21 Apr 2021 11:26:42 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id d3-20020a9d29030000b029027e8019067fso37870611otb.13
        for <git@vger.kernel.org>; Wed, 21 Apr 2021 11:26:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=HhKPe+POTiYrQh0NMo5C6vrDYBWnkcRqWEncvK6smas=;
        b=oQGEVqTJnyKz0lcljxfV7RlcAtwrLc59a05u8PprZXCPrv69sKstaCjR4h5vpVZEq9
         wajS1JdJRvFgbOzMhL/xeK0RWXFwXaHNlzsrCN2V6Ae8gloqokqeWH4CINp+asPRtCAM
         g9VikK0PJ/IUFbY40MIQGwbNnOsdxKmpKYoy1iTp8oxWhHNEGiwX2gAPAKAdJttxc4Vf
         3/RFXGXJLA8p+QO4a4o/OEvgaII0f2XYx/E9h7wVh9Gp4XIvoJE4ZeGrD4/ALvrxafIj
         22LVYn/WWjU1eiF5R5taowLpDl9/5J75IQAuOfrcCiJVTIeHmOsedL94D9BEfhSuRq1s
         kjAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=HhKPe+POTiYrQh0NMo5C6vrDYBWnkcRqWEncvK6smas=;
        b=ApLfJvpNITHMQN/acaRs5Q1elaRhgFjtk5llQgnZ61z687fHOpY3roJcykDULF/i3Q
         WwX5ZBMZ6Cagt+2fsXtLXRS4gPXBlYXZ0mpN52mRdiCSM2M6TNzaH5WkGxrHyOZ9nGjY
         LxZ1gNg0Qj86st7TxWmO48bHX9WAPEPDaaRdLkZWpqEwM5TlT4T95/RdFpvniR0RiNzi
         QWAv8XUMWnwn0PZsVx/UVnEdxefh0eJZhqHjLWhSm9PVQlMGpyXLjh5zZlXo66KHfPP5
         mjKTFn3ymILVEoe1qub3Zq/h9vQPyIvixe+aBUkDaVEekEI5TrswbI+l2YZEplly74I0
         Bigw==
X-Gm-Message-State: AOAM530z+1mrdQQgV6K09Hibc81kviBG1QnGwrSFstUzdjII49rBSLgC
        FypjcEDuen8Zqav/SpBdNlTSOB1g+KfKhOPruQw=
X-Google-Smtp-Source: ABdhPJxFilxRF/KFTLQ2/Cej6mgxBH6jOZGgfwtUm0RWvblQNUw+G9e0yZgzZl8mJP9evSnQx8OnDBc/b6w453UNqGM=
X-Received: by 2002:a05:6830:108d:: with SMTP id y13mr18603766oto.162.1619029602031;
 Wed, 21 Apr 2021 11:26:42 -0700 (PDT)
MIME-Version: 1.0
References: <20210420190552.822138-1-lukeshu@lukeshu.com> <8735vk3vyq.fsf@evledraar.gmail.com>
 <87k0ov38bv.wl-lukeshu@lukeshu.com>
In-Reply-To: <87k0ov38bv.wl-lukeshu@lukeshu.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 21 Apr 2021 11:26:31 -0700
Message-ID: <CABPp-BHHUB+AxAq4MeLyVtFO8wbDyyBOTMdxWtOWbknG7HumYQ@mail.gmail.com>
Subject: Re: [RFC PATCH] fast-export, fast-import: Let tags specify an
 internal name
To:     Luke Shumaker <lukeshu@lukeshu.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Luke Shumaker <lukeshu@datawire.io>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 21, 2021 at 9:36 AM Luke Shumaker <lukeshu@lukeshu.com> wrote:
>
> On Wed, 21 Apr 2021 02:03:57 -0600,
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> > On Tue, Apr 20 2021, Luke Shumaker wrote:
> >
> > > -static void handle_tag(const char *name, struct tag *tag)
> > > +static void handle_tag(const char *refname, struct tag *tag)
> > >  {
> > >     unsigned long size;
> > >     enum object_type type;
> > >     char *buf;
> > > -   const char *tagger, *tagger_end, *message;
> > > +   const char *refbasename;
> > > +   const char *tagname, *tagname_end, *tagger, *tagger_end, *message=
;
> >
> > Let's put the new "*tagname, *tagname_end" on its own line, the current
> > convention is to not conflate unrelated variable declarations on the
> > same line (as e.g. the existing "message" and "tagger" does.
>
> Ack.
>
> > >     size_t message_size =3D 0;
> > >     struct object *tagged;
> > >     int tagged_mark;
> > > @@ -800,6 +801,11 @@ static void handle_tag(const char *name, struct =
tag *tag)
> > >             message +=3D 2;
> > >             message_size =3D strlen(message);
> > >     }
> > > +   tagname =3D memmem(buf, message ? message - buf : size, "\ntag ",=
 5);
> > > +   if (!tagname)
> > > +           die("malformed tag %s", oid_to_hex(&tag->object.oid));
> > > +   tagname +=3D 5;
> > > +   tagname_end =3D strchrnul(tagname, '\n');
> >
> > So it's no longer possible to export a reporitory with a missing "tag"
> > entry in a tag? Maybe OK, but we have an escape hatch for it with fsck,
> > we don't need one here?
> >
> > In any case a test for it would be good to have.
>
> I hadn't realized that it was possible for a tag object to be missing
> the "tag" entry, I will fix that.
>
> I don't think it's worth adding an option to fast-import to make it
> possible to create such an object, but fast-export should be able to
> handle it (and emit it in the stream such that fast-import would
> create it with the "tag" entry").
>
> Yes, the whole patch needs tests.

fast-export already dies on missing author or missing committer in a
commit object, so there seems to be some precedence for just dying
instead of swallowing objects.  (Is a missing "tag" line in a tag more
common that missing "author"/"committer" in commit objects?)

If we do want to add an option to handle the missing entry, perhaps we
make an option similar to fast-export's --fake-missing-tagger?

> > > @@ -884,14 +890,19 @@ static void handle_tag(const char *name, struct=
 tag *tag)
> > >
> > >     if (tagged->type =3D=3D OBJ_TAG) {
> > >             printf("reset %s\nfrom %s\n\n",
> > > -                  name, oid_to_hex(&null_oid));
> > > +                  refname, oid_to_hex(&null_oid));
> > >     }
> > > -   skip_prefix(name, "refs/tags/", &name);
> > > -   printf("tag %s\n", name);
> > > +   refbasename =3D refname;
> > > +   skip_prefix(refbasename, "refs/tags/", &refbasename);
> > > +   printf("tag %s\n", refbasename);
> > >     if (mark_tags) {
> > >             mark_next_object(&tag->object);
> > >             printf("mark :%"PRIu32"\n", last_idnum);
> > >     }
> > > +   if ((size_t)(tagname_end - tagname) !=3D strlen(refbasename) ||
> >
> > Would be more readable IMO to have a temporary variable for that
> > "tagname_end - tagname", then just cast that and use it here.
> >
> > > +       strncmp(tagname, refbasename, (size_t)(tagname_end - tagname)=
))
> >
> > and here.
>
> Ack.
>
> > > @@ -2803,6 +2803,13 @@ static void parse_new_tag(const char *arg)
> > >     read_next_command();
> > >     parse_mark();
> > >
> > > +   /* name ... */
> > > +   if (skip_prefix(command_buf.buf, "name ", &v)) {
> > > +           name =3D strdupa(v);
> > > +           read_next_command();
> > > +   } else
> > > +           name =3D NULL;
> > > +
> >
> > Skip this whole (stylistically incorrect, should have {}) and just
> > initialize it to NULL when you declare the variable?
>
> In my defense, the guideline has always been to match the local style,
> and in fast-import.c this is done without {} 8 times and with {} 3
> times :)
>
> --
> Happy hacking,
> ~ Luke Shumaker
