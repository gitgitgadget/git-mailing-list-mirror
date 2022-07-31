Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41350C00140
	for <git@archiver.kernel.org>; Sun, 31 Jul 2022 15:24:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236872AbiGaPYX (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 31 Jul 2022 11:24:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233285AbiGaPYU (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 31 Jul 2022 11:24:20 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05BAFDEC6
        for <git@vger.kernel.org>; Sun, 31 Jul 2022 08:24:19 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id l24so6693999ion.13
        for <git@vger.kernel.org>; Sun, 31 Jul 2022 08:24:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=V7734tfuAxhywb1qD2TtD76cX2iIByu5sa6qYb2r4eE=;
        b=Wfvggc6+HaHaIAes9IaDU/dh8ImvzrDt9WwIvuP1EYqvdYPIY13kWfLu9h/5PjFW9a
         hDRxM6PhjCPaM5IYBTJwgxZGD/zBXUE+QGCRJmSCIrs/VdGdAodYkvkUFtFwUer/IXK8
         g/V7emlgdyXTW1x8BajAX4YXAPHlszZWMWngOeXDeYB1dzKmQiYjafcbZkYZK/vtsY/i
         bKclMuCtZuJ5DvGgnLZdEDRa4akYqc9Wu4b1vP2ueo+wSY4NkrbjjM8RNR3QSwwMEwxc
         qKHiaIRrp7oG52hb94ShqA2UykzGqQsTofF+mUCUaFAVKaskcC1i1qcSUJs2uYuYRZ06
         gZPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=V7734tfuAxhywb1qD2TtD76cX2iIByu5sa6qYb2r4eE=;
        b=w6ogji5LkfFPbLXyXkAlZxacI3ETPghBBAUcYxb1DTQI3pbQFC2onodQ57SnCfqtBk
         zdFf1dXHL5NlJRKt3NQ7bqBI1LxZlY0YYi8oDSBsDgp/dlaKBls08kamA+5HmadOIvLH
         qUUxjXs2tBwf9GcGcIWcNySP1O2k128ZMlFUKImC8GaDpGDtMXf6W6wYV/jwb9zv7zlZ
         GhDDrwxTaa28d1tZ+ZjXS453yeoB8RPUMghuZcUWCv1yH5DFnbRfb59QYdTKDihTvbzH
         29Ely6EIPCK7kXvSthH4mibwqM5kXeh2tvKYNQ0GVFZXJFlkE3Ai4QAakRhqL24kVA3N
         1PiQ==
X-Gm-Message-State: AJIora8EDPyIOMtq8o3mxy+shzserLvW9f/jH/bLfeS46WdQ86vJTOgT
        aU/0QcXWXGdz9pWiBemD1Ykk4pQaNUMQXJLdADU=
X-Google-Smtp-Source: AGRyM1uFL1aX1MABf1arv0gmyMvFV3UdjMJJRH/LhhLIdH6wY5ctLtLsEvQ70/xGHoXtChoYkeWFFR1pj/QKEEhKsqs=
X-Received: by 2002:a6b:6e1a:0:b0:67c:c3f1:f16c with SMTP id
 d26-20020a6b6e1a000000b0067cc3f1f16cmr4052528ioh.135.1659281058328; Sun, 31
 Jul 2022 08:24:18 -0700 (PDT)
MIME-Version: 1.0
References: <20220328191112.3092139-1-calvinwan@google.com>
 <20220502170904.2770649-1-calvinwan@google.com> <20220502170904.2770649-9-calvinwan@google.com>
In-Reply-To: <20220502170904.2770649-9-calvinwan@google.com>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Sun, 31 Jul 2022 23:24:07 +0800
Message-ID: <CAOLTT8RyDCokvJBaC1CCoT2+3AE1kOn7evjkTMK_V6KWoaH30g@mail.gmail.com>
Subject: Re: [PATCH v4 8/8] cat-file: add --batch-command remote-object-info command
To:     Calvin Wan <calvinwan@google.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Philip Oakley <philipoakley@iee.email>, johncai86@gmail.com,
        Taylor Blau <me@ttaylorr.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Calvin Wan <calvinwan@google.com> =E4=BA=8E2022=E5=B9=B45=E6=9C=883=E6=97=
=A5=E5=91=A8=E4=BA=8C 06:33=E5=86=99=E9=81=93=EF=BC=9A
>
> Since the `info` command in cat-file --batch-command prints object info
> for a given object, it is natural to add another command in cat-file
> --batch-command to print object info for a given object from a remote.
> Add `remote-object-info` to cat-file --batch-command.
>
> While `info` takes object ids one at a time, this creates overhead when
> making requests to a server so `remote-object-info` instead can take
> multiple object ids at once.
>
> cat-file --batch-command is generally implemented in the following
> manner:
>
>  - Receive and parse input from user
>  - Call respective function attached to command
>  - Set batch mode state, get object info, print object info
>
> In --buffer mode, this changes to:
>
>  - Receive and parse input from user
>  - Store respective function attached to command in a queue
>  - After flush, loop through commands in queue
>     - Call respective function attached to command
>     - Set batch mode state, get object info, print object info
>
> Notice how the getting and printing of object info is accomplished one
> at a time. As described above, this creates a problem for making
> requests to a server. Therefore, `remote-object-info` is implemented in
> the following manner:
>
>  - Receive and parse input from user
>  If command is `remote-object-info`:
>     - Get object info from remote
>     - Loop through object info
>         - Call respective function attached to `info`
>         - Set batch mode state, use passed in object info, print object
>           info
>  Else:
>     - Call respective function attached to command
>     - Parse input, get object info, print object info
>
> And finally for --buffer mode `remote-object-info`:
>  - Receive and parse input from user
>  - Store respective function attached to command in a queue
>  - After flush, loop through commands in queue:
>     If command is `remote-object-info`:
>         - Get object info from remote
>         - Loop through object info
>             - Call respective function attached to `info`
>             - Set batch mode state, use passed in object info, print
>               object info
>     Else:
>         - Call respective function attached to command
>         - Set batch mode state, get object info, print object info
>
> To summarize, `remote-object-info` gets object info from the remote and
> then generates multiples `info` commands with the object info passed in.
> It cannot be implemented similarly to `info` and `content` because of
> the overhead with remote commenication.
>
> ---
>  Documentation/git-cat-file.txt |  16 +-
>  builtin/cat-file.c             | 200 +++++++++++++++----
>  t/t1006-cat-file.sh            | 347 +++++++++++++++++++++++++++++++++
>  3 files changed, 522 insertions(+), 41 deletions(-)
>
> diff --git a/Documentation/git-cat-file.txt b/Documentation/git-cat-file.=
txt
> index 24a811f0ef..0d9e8e6214 100644
> --- a/Documentation/git-cat-file.txt
> +++ b/Documentation/git-cat-file.txt
> @@ -115,6 +115,10 @@ info <object>::
>         Print object info for object reference `<object>`. This correspon=
ds to the
>         output of `--batch-check`.
>
> +remote-object-info <remote> [<object>]::
> +       Print object info for object references `<object>` at specified <=
remote>.
> +       This command may only be combined with `--buffer`.
> +
>  flush::
>         Used with `--buffer` to execute all preceding commands that were =
issued
>         since the beginning or since the last flush was issued. When `--b=
uffer`
> @@ -245,7 +249,8 @@ newline. The available atoms are:
>         The full hex representation of the object name.
>
>  `objecttype`::
> -       The type of the object (the same as `cat-file -t` reports).
> +       The type of the object (the same as `cat-file -t` reports). See
> +       `CAVEATS` below.
>
>  `objectsize`::
>         The size, in bytes, of the object (the same as `cat-file -s`
> @@ -253,13 +258,14 @@ newline. The available atoms are:
>
>  `objectsize:disk`::
>         The size, in bytes, that the object takes up on disk. See the
> -       note about on-disk sizes in the `CAVEATS` section below.
> +       note about on-disk sizes in the `CAVEATS` section below. Not
> +       supported by `remote-object-info`.
>
>  `deltabase`::
>         If the object is stored as a delta on-disk, this expands to the
>         full hex representation of the delta base object name.
>         Otherwise, expands to the null OID (all zeroes). See `CAVEATS`
> -       below.
> +       below. Not supported by `remote-object-info`.
>
>  `rest`::
>         If this atom is used in the output string, input lines are split

Why not forbidden %(rest) here too?

> +static int get_remote_info(struct batch_options *opt, int argc, const ch=
ar **argv)
> +{
> +       int retval =3D 0;
> +       size_t i;
> +       struct remote *remote =3D NULL;
> +       struct object_id oid;
> +       struct string_list object_info_options =3D STRING_LIST_INIT_NODUP=
;
> +       static struct transport *gtransport;
> +       char *format =3D DEFAULT_FORMAT;
> +
> +       if (opt->format)
> +               format =3D xstrdup(opt->format);
> +
> +       remote =3D remote_get(argv[0]);
> +       if (!remote)
> +               die(_("must supply valid remote when using --object-info"=
));
> +       oid_array_clear(&object_info_oids);
> +       for (i =3D 1; i < argc; i++) {
> +               if (get_oid(argv[i], &oid))
> +                       die(_("malformed object id '%s'"), argv[i]);
> +               oid_array_append(&object_info_oids, &oid);
> +       }
> +
> +       gtransport =3D transport_get(remote, NULL);
> +       if (gtransport->smart_options) {
> +               size_t j;
> +               int include_size =3D 0, include_type =3D 0;
> +
> +               remote_object_info =3D xcalloc(object_info_oids.nr, sizeo=
f(struct object_info));
> +               gtransport->smart_options->object_info =3D 1;
> +               gtransport->smart_options->object_info_oids =3D &object_i=
nfo_oids;
> +               /**
> +                * 'size' is the only option currently supported.
> +                * Other options that are passed in the format will defau=
lt to a
> +                * standard fetch request rather than object-info.
> +                */
> +               if (strstr(format, "%(objectsize)")) {
> +                       string_list_append(&object_info_options, "size");
> +                       include_size =3D 1;
> +               }
> +               if (strstr(format, "%(objecttype)")) {
> +                       string_list_append(&object_info_options, "type");
> +                       include_type =3D 1;
> +               }
> +               if (strstr(format, "%(objectsize:disk)"))
> +                       die(_("objectsize:disk is currently not supported=
 with remote-object-info"));
> +               if (strstr(format, "%(deltabase)"))
> +                       die(_("deltabase is currently not supported with =
remote-object-info"));

%(rest) too?

> +               if (object_info_options.nr > 0) {
> +                       gtransport->smart_options->object_info_options =
=3D &object_info_options;
> +                       for (j =3D 0; j < object_info_oids.nr; j++) {
> +                               if (include_size)
> +                                       remote_object_info[j].sizep =3D x=
calloc(1, sizeof(long));
> +                               if (include_type)
> +                                       remote_object_info[j].typep =3D x=
calloc(1, sizeof(enum object_type));
> +                       }
> +                       gtransport->smart_options->object_info_data =3D &=
remote_object_info;
> +                       retval =3D transport_fetch_refs(gtransport, NULL)=
;
> +               }
> +       } else {
> +               retval =3D -1;
> +       }
> +       return retval;
> +}

Maybe such code style will be better?

        if (!gtransport->smart_options) {
               return -1;
        }
        ...
        return transport_fetch_refs(gtransport, NULL);

> +
>  struct object_cb_data {
>         struct batch_options *opt;
>         struct expand_data *expand;
> @@ -538,6 +611,7 @@ typedef void (*parse_cmd_fn_t)(struct batch_options *=
, const char *,
>  struct queued_cmd {
>         parse_cmd_fn_t fn;
>         char *line;
> +       const char *name;
>  };
>
>  static void parse_cmd_contents(struct batch_options *opt,
> @@ -565,9 +639,49 @@ static const struct parse_cmd {
>  } commands[] =3D {
>         { "contents", parse_cmd_contents, 1},
>         { "info", parse_cmd_info, 1},
> +       { "remote-object-info", parse_cmd_info, 1},
>         { "flush", NULL, 0},
>  };
>
> +static void parse_remote_info(struct batch_options *opt,
> +                          char *line,
> +                          struct strbuf *output,
> +                          struct expand_data *data,
> +                          const struct parse_cmd *p_cmd,
> +                          struct queued_cmd *q_cmd)
> +{
> +       int count;
> +       size_t i;
> +       const char **argv;
> +
> +       count =3D split_cmdline(line, &argv);
> +       if (get_remote_info(opt, count, argv))
> +               goto cleanup;
> +       opt->use_remote_info =3D 1;
> +       data->skip_object_info =3D 1;
> +       data->mark_query =3D 0;
> +       for (i =3D 0; i < object_info_oids.nr; i++) {
> +               if (remote_object_info[i].sizep)
> +                       data->size =3D *remote_object_info[i].sizep;
> +               if (remote_object_info[i].typep)
> +                       data->type =3D *remote_object_info[i].typep;
> +
> +               data->oid =3D object_info_oids.oid[i];
> +               if (p_cmd)
> +                       p_cmd->fn(opt, argv[i+1], output, data);
> +               else
> +                       q_cmd->fn(opt, argv[i+1], output, data);
> +       }
> +       opt->use_remote_info =3D 0;
> +       data->skip_object_info =3D 0;
> +       data->mark_query =3D 1;
> +
> +cleanup:
> +       for (i =3D 0; i < object_info_oids.nr; i++)
> +               free_object_info_contents(&remote_object_info[i]);
> +       free(remote_object_info);
> +}
> +
>  static void dispatch_calls(struct batch_options *opt,
>                 struct strbuf *output,
>                 struct expand_data *data,
> @@ -579,8 +693,12 @@ static void dispatch_calls(struct batch_options *opt=
,
>         if (!opt->buffer_output)
>                 die(_("flush is only for --buffer mode"));
>
> -       for (i =3D 0; i < nr; i++)
> -               cmd[i].fn(opt, cmd[i].line, output, data);
> +       for (i =3D 0; i < nr; i++) {
> +               if (!strcmp(cmd[i].name, "remote-object-info"))
> +                       parse_remote_info(opt, cmd[i].line, output, data,=
 NULL, &cmd[i]);
> +               else
> +                       cmd[i].fn(opt, cmd[i].line, output, data);
> +       }
>
>         fflush(stdout);
>  }
> @@ -640,11 +758,17 @@ static void batch_objects_command(struct batch_opti=
ons *opt,
>                         dispatch_calls(opt, output, data, queued_cmd, nr)=
;
>                         free_cmds(queued_cmd, &nr);
>                 } else if (!opt->buffer_output) {
> -                       cmd->fn(opt, p, output, data);
> +                       if (!strcmp(cmd->name, "remote-object-info")) {
> +                               char *line =3D xstrdup_or_null(p);
> +                               parse_remote_info(opt, line, output, data=
, cmd, NULL);

memory leak: "line".

> +                       } else {
> +                               cmd->fn(opt, p, output, data);
> +                       }
>                 } else {
>                         ALLOC_GROW(queued_cmd, nr + 1, alloc);
>                         call.fn =3D cmd->fn;
>                         call.line =3D xstrdup_or_null(p);
> +                       call.name =3D cmd->name;
>                         queued_cmd[nr++] =3D call;
>                 }
>         }
> +
> +test_expect_success 'remote-object-info fails on unspported filter optio=
n (objectsize:disk)' '
> +       (
> +               cd "$HTTPD_DOCUMENT_ROOT_PATH/http_parent" &&
> +
> +               test_must_fail git cat-file --batch-command=3D"%(objectsi=
ze:disk)" 2>err <<-EOF &&
> +               remote-object-info "$HTTPD_URL/smart/http_parent" $hello_=
sha1
> +               EOF
> +               test_i18ngrep "objectsize:disk is currently not supported=
 with remote-object-info" err
> +       )
> +'
> +
> +test_expect_success 'remote-object-info fails on unspported filter optio=
n (deltabase)' '
> +       (
> +               cd "$HTTPD_DOCUMENT_ROOT_PATH/http_parent" &&
> +
> +               test_must_fail git cat-file --batch-command=3D"%(deltabas=
e)" 2>err <<-EOF &&
> +               remote-object-info "$HTTPD_URL/smart/http_parent" $hello_=
sha1
> +               EOF
> +               test_i18ngrep "deltabase is currently not supported with =
remote-object-info" err
> +       )
> +'
> +

%(rest) too?

> +set_transport_variables "server"
> +
> +test_expect_success 'batch-command remote-object-info file://' '
> +       (
> +               cd server &&
> +
> +               echo "$hello_sha1 $hello_size" >expect &&
> +               echo "$tree_sha1 $tree_size" >>expect &&
> +               echo "$commit_sha1 $commit_size" >>expect &&
> +               echo "$tag_sha1 $tag_size" >>expect &&
> +               git cat-file --batch-command=3D"%(objectname) %(objectsiz=
e)" >actual <<-EOF &&
> +               remote-object-info "file://$(pwd)" $hello_sha1
> +               remote-object-info "file://$(pwd)" $tree_sha1
> +               remote-object-info "file://$(pwd)" $commit_sha1
> +               remote-object-info "file://$(pwd)" $tag_sha1
> +               EOF
> +               test_cmp expect actual
> +       )

Can we support <rev> instead of only <oid> here?

$ git cat-file --batch-check
HEAD
28583b8d8ca72730d7c9e0ea50861ad431a6dea4 commit 3038
master
ab336e8f1c8009c8b1aab8deb592148e69217085 commit 281
origin/master
23b219f8e3f2adfb0441e135f0a880e6124f766c commit 282
origin/master:git.c
e5d62fa5a92e95e1ede041ebf913d841744c31f8 blob 28398

So cat-file --batch-check can support it.

$git cat-file --batch-commands
remote-object-info "file://$(pwd)" master:git.c

I guess it cannot work now, right?
