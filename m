Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 610AAC433EF
	for <git@archiver.kernel.org>; Mon, 28 Feb 2022 16:26:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235945AbiB1Q0q (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Feb 2022 11:26:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231250AbiB1Q0o (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Feb 2022 11:26:44 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F7D985967
        for <git@vger.kernel.org>; Mon, 28 Feb 2022 08:26:05 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id i11so18341409eda.9
        for <git@vger.kernel.org>; Mon, 28 Feb 2022 08:26:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=21zuUmH0twjs9vMc3gEBXhI2imT9va73Gc8+G7DJZBU=;
        b=Dkk5PB0+Mt3STSRdBDMYxYQZHYb130bsNRYIOukH8fW3hhkIqHfH3JKDYaWYxpWMUz
         vHED5ToGPk0d9lK/4WwXc6A0z9Ibnn29pCvrMXg8tGgpduS48OEy4PN7GBfEkDiTnvRp
         KWdU40HIH8pQPjBebaryyGTQEW8u1q3VjIEolCLQB4K7PNzUxHgcKIiQNNw4DUaFHUel
         R1GhZ+/RpGEmW/3zRokAFKoLawYliNesZqgcXQFZo6q1EkwFeEUBuurvoqUjp4Ucxbc2
         mGH6YJK1QGPmmQmks3utoBGyQu/3CAbJx8VKuhaVBb7CHCCpi8d121b1DYwJNSLxo89j
         0H7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=21zuUmH0twjs9vMc3gEBXhI2imT9va73Gc8+G7DJZBU=;
        b=A8839KKkpiYBTCAwLOncGF8O3+9W1pgo5hRvCMpjCBV15/fRXjiVxzwecVD43lmaiI
         cMv6n7nkvdddDIl34xuPTnWBZXzkCQr0ZTNORtWxCp0juQHWHas5kDovkj54wXPbJhQB
         tGlNRgZw/TN61M2B8Rv6WTIu7LUvNrfZ9JRP0Gse9Gvz+7daAS42MA1ysOF8gyTpybXG
         7SfQ88PfWw4IjX0I4FmDWWQuFhnbNAXnpo5Ab1NfobQdfUhGyEQw7RDvUd/OEqHWiRj6
         95fftoQcAi8+FBNexlyUNDKvTBhJWqapRQD63raLdIYLmCCu8r/dwmycDnuDfDLUrPTH
         82Dw==
X-Gm-Message-State: AOAM532sDvVb4IqvTHKUpYJlbwtwKQTs5pXcmATXYa5/qZQjrkLGJcQS
        CCOLmXMcZg8CnFMBJIjTfTQ=
X-Google-Smtp-Source: ABdhPJz84MljClEX6CoCu9HwZa2gDaEdh8+RQ3SsiSUgjskJEmlM1KohdApiLxNt2RiIsTvbwyFfGA==
X-Received: by 2002:a05:6402:142b:b0:413:2b86:7af2 with SMTP id c11-20020a056402142b00b004132b867af2mr20689808edx.102.1646065563816;
        Mon, 28 Feb 2022 08:26:03 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id gc22-20020a1709072b1600b006ce29e0627asm4419378ejc.220.2022.02.28.08.26.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Feb 2022 08:26:03 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nOiqY-001Suy-ET;
        Mon, 28 Feb 2022 17:26:02 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Teng Long <dyroneteng@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?utf-8?B?xJBvw6Bu?= =?utf-8?B?IFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>, Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Jeff King <peff@peff.net>, tenglong.tl@alibaba-inc.com
Subject: Re: [PATCH v11 08/13] ls-tree: slightly refactor `show_tree()`
Date:   Mon, 28 Feb 2022 17:18:10 +0100
References: <cover.1644319434.git.dyroneteng@gmail.com>
 <41e8ed50476a5afd6009db1a69c7a39b04e038b0.1644319434.git.dyroneteng@gmail.com>
 <220219.86mtine6jb.gmgdl@evledraar.gmail.com>
 <CADMgQSRYKB1ybxZWxQQ3uVM71fmdbzHqcK-WUPNKm2HMxw2C2g@mail.gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <CADMgQSRYKB1ybxZWxQQ3uVM71fmdbzHqcK-WUPNKm2HMxw2C2g@mail.gmail.com>
Message-ID: <220228.864k4j3qlh.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Feb 28 2022, Teng Long wrote:

[Since this had HTML parts it didn't make it to the git ML, quoting it
here in full & replying on-list].

> On Sat, Feb 19, 2022 at 2:04 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <a=
varab@gmail.com> wrote:
>
>  > I think this and the 09/13 really don't make sense in combination.
>  >=20
>  > Now, I clearly prefer to put options for the command into its own litt=
le
>  > struct to pass around, I think it makes for easier reading than the
>  > globals you end up with.
>  >=20
>  > But tastes differ, and some built-ins use one, and some the other
>  > pattern.
>  >=20
>  > But this is really the worst of both worlds, let's just pick one or the
>  > other, not effectively some some ptions in that struct in 09/13, and
>  > some in globals here...
>
> I'm not 100 percent sure about it, but I agree with we can just pick one =
or
> the other.
>
> So, how about:=20
>      1. add "unsigned shown_fields"  in "struct show_tree_data"
>      2.  move global "show_fields" to "struct show_tree_data"
>      3. move "parse_show_fields()" to "show_tree()"
>
> diff --git a/builtin/ls-tree.c b/builtin/ls-tree.c
> index 293b8f9dfb..92add01ecc 100644
> --- a/builtin/ls-tree.c
> +++ b/builtin/ls-tree.c
> @@ -25,7 +25,6 @@ static int ls_options;
>  static struct pathspec pathspec;
>  static int chomp_prefix;
>  static const char *ls_tree_prefix;
> -static unsigned int shown_fields;
>  #define FIELD_PATH_NAME 1
>  #define FIELD_SIZE (1 << 1)
>  #define FIELD_OBJECT_NAME (1 << 2)
> @@ -40,6 +39,7 @@ struct show_tree_data {
>         const struct object_id *oid;
>         const char *pathname;
>         struct strbuf *base;
> +       unsigned int shown_fields;
>  };
>=20=20
>  static const  char * const ls_tree_usage[] =3D {
> @@ -55,19 +55,19 @@ enum {
>=20=20
>  static int cmdmode =3D MODE_UNSPECIFIED;
>=20=20
> -static int parse_shown_fields(void)
> +static int parse_shown_fields(unsigned int *shown_fields)
>  {
>         if (cmdmode =3D=3D MODE_NAME_ONLY) {
> -               shown_fields =3D FIELD_PATH_NAME;
> +               *shown_fields =3D FIELD_PATH_NAME;
>                 return 0;
>         }
>=20=20
>         if (!ls_options || (ls_options & LS_RECURSIVE)
>             || (ls_options & LS_SHOW_TREES)
>             || (ls_options & LS_TREE_ONLY))
> -               shown_fields =3D FIELD_DEFAULT;
> +               *shown_fields =3D FIELD_DEFAULT;
>         if (cmdmode =3D=3D MODE_LONG)
> -               shown_fields =3D FIELD_LONG_DEFAULT;
> +               *shown_fields =3D FIELD_LONG_DEFAULT;
>         return 1;
>  }
>=20=20
> @@ -105,7 +105,7 @@ static int show_default(struct show_tree_data *data)
>  {
>         size_t baselen =3D data->base->len;
>=20=20
> -       if (shown_fields & FIELD_SIZE) {
> +       if (data->shown_fields & FIELD_SIZE) {
>                 char size_text[24];
>                 if (data->type =3D=3D OBJ_BLOB) {
>                         unsigned long size;
> @@ -137,15 +137,19 @@ static int show_tree(const struct object_id *oid, s=
truct strbuf *base,
>  {
>         int recurse =3D 0;
>         size_t baselen;
> +       unsigned int shown_fields =3D 0;
>         enum object_type type =3D object_type(mode);
> -       struct show_tree_data data =3D {
> +               struct show_tree_data data =3D {
>                 .mode =3D mode,
>                 .type =3D type,
>                 .oid =3D oid,
>                 .pathname =3D pathname,
>                 .base =3D base,
> +               .shown_fields =3D shown_fields,
>         };
>=20=20
> +       parse_shown_fields(&shown_fields);
> +
>         if (type =3D=3D OBJ_TREE && show_recursive(base->buf, base->len, =
pathname))
>                 recurse =3D READ_TREE_RECURSIVE;
>         if (type =3D=3D OBJ_TREE && recurse && !(ls_options & LS_SHOW_TRE=
ES))
> @@ -219,8 +223,6 @@ int cmd_ls_tree(int argc, const char **argv, const ch=
ar *prefix)
>         if (get_oid(argv[0], &oid))
>                 die("Not a valid object name %s", argv[0]);
>=20=20
> -       parse_shown_fields();
> -
>         /*
>          * show_recursive() rolls its own matching code and is
>          * generally ignorant of 'struct pathspec'. The magic mask
>

Yes, this looks good, i.e. these are (I think, I didn't look in much
detail) now all store one place instead of two.

>  > >+#define FIELD_DEFAULT 29 /* 11101 size is not shown to output by def=
ault */
>
>  >Why do we need some FIELD_DEFAULT here as opposed to just having it by
>  >an enum field with a valu of 0?
>
>=20=20
> You mean to use "cmdmode" or set "FIELD_DEFAULT" to 0, if the former  I t=
hink is a
> similar situation to your last replied paragraph so I will reply to that.=
 Or if the=20
> latter, we want them as a bitmask not only a flag,  so  I think "0" here =
means no fields
> will be shown and "29" is the default bitmask value (also some context me=
tioned in
> https://public-inbox.org/git/xmqqmtlu7bb0.fsf@gitster.g/).

I meant (elaborated on below) that it seemed like this was conflating
"default mode" with "wants to emit size" in the state machine.

I.e. I didn't try rewriting it (or re-visited it now), but it seemed at
the time with some minor changes it could be eliminated, but maybe
not...

>  > let's name this enum type and use it, see e.g. builtin/help.c's "static
>  > enum help_action" for an example.
>
> Totally agree with that.=20
> I want to name it "mutx_option", I'm not sure whether we need a better on=
e.=20

Sure, I don't think the name matters much since it's now, so whatever
you think is OK.

I just wanted to point out that some existing code makes the same
pattern simpler by relying on the 0-init and having fields starting at
0.

>  > I still don't really get why we can't just use the one MODE_*
>  > here. E.g. doesn't MODE_LONG map to FIELD_LONG_DEFAULT, MODE_NAME_ONLY
>  > to FIELD_PATH_NAME etc?
>
>=20=20
> For current, the answer is YES I think.
>
>  > Is this all so we can do "shown_fields & FIELD_SIZE" in show_default()
>  > as opposed to e.g. checking "default format or long format?" ?
>
> Actually, in v3 patch I use "cmdmode" to determine the output fields and =
the next patches Junio
> suggest using bitmasks for the work (https://public-inbox.org/git/xmqqmtl=
u7bb0.fsf@gitster.g/).
>
> I didn't understand it at first,  and I thought it might make sense. The =
cmd_mode is used here to indicate that options are mutually exclusive, whic=
h may have the same effect in certain
> cases, such as some short-circuited options (-- name-only).
>
> However, cmd_mode is not a complete representation of what fields we want=
 to output, because some options may not be mutually exclusive but can also=
 be used to change the output (for
> example, we want to add -format or others). If there is a bitmask associa=
ted with the output field, we can quickly and explicitly know what to outpu=
t in the show_tree() phase, without
> thinking about the relationship to cmd_mode or doing a translation of mea=
ning=EF=BC=8C and at the same time  this will make it easier to adapt to ch=
ange I think.

*nod*

I'm not quite sure I get what you're aiming for, but I'll look at it
again in any future re-roll & see if I can submit a patch-on-top next
time if I have any comments (if at all worth it). Thanks!
