Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFB78C32771
	for <git@archiver.kernel.org>; Fri, 19 Aug 2022 18:14:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350589AbiHSSOW (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Aug 2022 14:14:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350203AbiHSSNw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Aug 2022 14:13:52 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F47CB4B6
        for <git@vger.kernel.org>; Fri, 19 Aug 2022 11:07:39 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id m17-20020a7bce11000000b003a5bedec07bso4504459wmc.0
        for <git@vger.kernel.org>; Fri, 19 Aug 2022 11:07:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc;
        bh=+z4S5fG+y+XK4DAhdo5sIepXK/pShT7TJ8RvUsd1k0s=;
        b=dElMvvrd3ttPmimQH6vQszVWMD851M4xOatOvSKXYkOeTGz2OQXKn8PNYswnPdheUj
         ThcPplLIwjKCPFRSWFGADhcQus0hKpsMWi6Keex69/6nAUz/7xNeoM3hDxyJeZ6Nt6Ho
         yctONgdrd79O9O/qDvRvfuFKoJO6m651dLIUd210AbaNuPMOUoXfFoVIj2mfgNXZyPhd
         tXrXlsqWD2s1DxDuUwVQvwyjo7uTfEDaaUuvH3Cn01YS33ctRmCeFDekpJiEY6FOpcmU
         OA/qq57gst5jXHMxbG3QL5wK2bWyVDJfC38xuzm6gaA5N6qtVgz/rpFTrTTEC3smgPHN
         pETQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc;
        bh=+z4S5fG+y+XK4DAhdo5sIepXK/pShT7TJ8RvUsd1k0s=;
        b=rOQ2pH75OHy8T1VjtiZAu6IGtyVXqqW6tESSvYKDHODgYCSL+KAxz1UuFVRAvh64gW
         V4RMWKPdXx48hMELc6E/OsObyfnOitIcQBNh2YmK4K07n4+c5kgR6CUq0oWKisbiqfSj
         sfTfW0CSLfSrlf48YMNgI4Q1fmE6ijuRoqzOzCD7fmiagqQS6Xrpivu89H0BafIOhqrp
         9hlYZ1AI9xHOvp6ESqgEumeJ5jaVFHD5eIBZ5nmzYhgFSDmlOga8SEjz+qj3uysUQnTZ
         xzbdyMaGN288qc/7m0Yyx5uqf9CBvOFPC3RCDTBgTTRm49aaQ4p6IXARCzUh5DFKAQ/J
         Bdyw==
X-Gm-Message-State: ACgBeo2PIRzHgh+59cTeGdIw+/KJRREpVV5wf0XWXWVphJW1kapJDQhB
        FkAc/b2qus23pcRuTP975mo=
X-Google-Smtp-Source: AA6agR5Nw2o+bRu/qUSWxXan2gsXB5h1RAyYGx4PCN3VEy7onvdIwcboIdX7w1E4CuHQDv70J98hfQ==
X-Received: by 2002:a05:600c:4e15:b0:3a6:152a:9143 with SMTP id b21-20020a05600c4e1500b003a6152a9143mr5447406wmq.20.1660932458169;
        Fri, 19 Aug 2022 11:07:38 -0700 (PDT)
Received: from gmgdl ([213.220.124.15])
        by smtp.gmail.com with ESMTPSA id z11-20020a5d4c8b000000b002252f57865asm4737235wrs.15.2022.08.19.11.07.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 11:07:37 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1oP6PA-000qDE-02;
        Fri, 19 Aug 2022 20:07:36 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 15/20] builtin/notes.c: let parse-options parse
 subcommands
Date:   Fri, 19 Aug 2022 20:01:55 +0200
References: <20220725123857.2773963-1-szeder.dev@gmail.com>
 <20220819160411.1791200-1-szeder.dev@gmail.com>
 <20220819160411.1791200-16-szeder.dev@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <20220819160411.1791200-16-szeder.dev@gmail.com>
Message-ID: <220819.86pmgw5cpk.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Aug 19 2022, SZEDER G=C3=A1bor wrote:

> -	int result;
>  	const char *override_notes_ref =3D NULL;
> +	parse_opt_subcommand_fn *fn =3D list;
>  	struct option options[] =3D {
>  		OPT_STRING(0, "ref", &override_notes_ref, N_("notes-ref"),
>  			   N_("use notes from <notes-ref>")),
> +		OPT_SUBCOMMAND("list", &fn, list),
> +		OPT_SUBCOMMAND("add", &fn, add),
> +		OPT_SUBCOMMAND("copy", &fn, copy),
> +		OPT_SUBCOMMAND("append", &fn, append_edit),
> +		OPT_SUBCOMMAND("edit", &fn, append_edit),
> +		OPT_SUBCOMMAND("show", &fn, show),
> +		OPT_SUBCOMMAND("merge", &fn, merge),
> +		OPT_SUBCOMMAND("remove", &fn, remove_cmd),
> +		OPT_SUBCOMMAND("prune", &fn, prune),
> +		OPT_SUBCOMMAND("get-ref", &fn, get_ref),
>  		OPT_END()
>  	};
>=20=20
>  	git_config(git_default_config, NULL);
>  	argc =3D parse_options(argc, argv, prefix, options, git_notes_usage,
> -			     PARSE_OPT_STOP_AT_NON_OPTION);
> +			     PARSE_OPT_SUBCOMMAND_OPTIONAL);
> +	if (fn =3D=3D list && argc && strcmp(argv[0], "list")) {
> +		error(_("unknown subcommand: %s"), argv[0]);
> +		usage_with_options(git_notes_usage, options);
> +	}

I wanted to ask why the API can't smartly handle this, but your "Found
an unknown option given to a command with" comment in an earlier patch
answered it.

I think something in this direction would be a bit more readble/obvious,
as it avoids hardcoding "list":
=09
	diff --git a/builtin/notes.c b/builtin/notes.c
	index 42cbae46598..43d59b1a98e 100644
	--- a/builtin/notes.c
	+++ b/builtin/notes.c
	@@ -995,7 +995,7 @@ static int get_ref(int argc, const char **argv, const =
char *prefix)
	 int cmd_notes(int argc, const char **argv, const char *prefix)
	 {
	 	const char *override_notes_ref =3D NULL;
	-	parse_opt_subcommand_fn *fn =3D list;
	+	parse_opt_subcommand_fn *fn =3D NULL;
	 	struct option options[] =3D {
	 		OPT_STRING(0, "ref", &override_notes_ref, N_("notes-ref"),
	 			   N_("use notes from <notes-ref>")),
	@@ -1015,10 +1015,11 @@ int cmd_notes(int argc, const char **argv, const c=
har *prefix)
	 	git_config(git_default_config, NULL);
	 	argc =3D parse_options(argc, argv, prefix, options, git_notes_usage,
	 			     PARSE_OPT_SUBCOMMAND_OPTIONAL);
	-	if (fn =3D=3D list && argc && strcmp(argv[0], "list")) {
	-		error(_("unknown subcommand: %s"), argv[0]);
	-		usage_with_options(git_notes_usage, options);
	-	}
	+	if (!fn && argc)
	+		usage_msg_optf(_("unknown subcommand: %s"),
	+			       git_notes_usage, options, argv[0]);
	+	else if (!fn)
	+		fn =3D list;
=09=20
	 	if (override_notes_ref) {
	 		struct strbuf sb =3D STRBUF_INIT;

I.e. we rely on the API setting it to non-NULL if it finds a subcommand,
otherwise we just set it to "list" after checking whether we have excess
arguments.

> [...]
> -	else if (!strcmp(argv[0], "get-ref"))
> -		result =3D get_ref(argc, argv, prefix);
> -	else {
> -		result =3D error(_("unknown subcommand: %s"), argv[0]);
> -		usage_with_options(git_notes_usage, options);
> -	}
> -
> -	return result ? 1 : 0;
> +	return !!fn(argc, argv, prefix);
>  }

In any case this is a lot nicer, ditto previous comment about maybe
skipping the refactoring of this end code, but I'm also fine with
keeping it.
