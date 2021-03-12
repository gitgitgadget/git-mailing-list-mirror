Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FDF3C433DB
	for <git@archiver.kernel.org>; Fri, 12 Mar 2021 11:14:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5FB9064F09
	for <git@archiver.kernel.org>; Fri, 12 Mar 2021 11:14:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233332AbhCLLNf (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Mar 2021 06:13:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233698AbhCLLNE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Mar 2021 06:13:04 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AF74C061574
        for <git@vger.kernel.org>; Fri, 12 Mar 2021 03:13:04 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id i61so7379981edd.7
        for <git@vger.kernel.org>; Fri, 12 Mar 2021 03:13:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=R3l7IOdGNtTIu0SlodhCZ0KtGEsJl4FnVct1+m2wq1o=;
        b=FwwAC27yIki3YcA9hRMj6Zpo8oGV99o1jT4tNwcLiArX4EM3S+Kq8moOBclDm2/L3t
         9EH7dXG0UssYJ2vkPUjCxk0et2/JsWpE0lVp716i0JMjRgB1h2hmSKNaU7O6npPG8SNI
         B3jrLbnqwgwad0QI72/g4eWS0GtBKZIe4gdcUTg5f702SMiqKvpw8CqiEBOf8AvrWBef
         MF9FxyMDfxw3eIjUOaQcdJn6zaBUs5qwlsldcwhvkxQjFOKVODRuF3zp+UpnPX7wWLut
         utmsoeofXqWb7s16CsD/br4D7DLzZejcrvigtfatSpNrgvaezzBnXLi8sTkGzBaq0l0s
         qc+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=R3l7IOdGNtTIu0SlodhCZ0KtGEsJl4FnVct1+m2wq1o=;
        b=Fud2JteqUf6r2iE9fcEfJvju5tq++KtMKvlkio2IWNsu4dpyzyBHA7567cTRUSW7nI
         BT4sEacUgG102E8EXtflyBPOQmUT5pXlYLxZiVxRjlwNROA0M1TJwiu5ZoDK7hGIi2LO
         dAX996GvtIVEKj8M+iwNNLTL4BYuZ4k5m23upw9ZnLCT8htbQC9ibd8Rtx0uh9CTA8ME
         bZz4iPUc0BgaJbTPkky8PKEXyeB82iHgpHi4qDXN0E/smLkvi2PqpvZZeJE6NlkKKUuM
         Vwzs3DXbqFpt+LA/RjmuHhNv/ZphiZnfttCW9fyh9x5DVnRAuE8hRzfS9EJlfh/EJMoe
         D8GA==
X-Gm-Message-State: AOAM531xN8AzeTdl7Yw0TLSr2iqDZVGEXRl+Rwl32gLNlDuQrdBYhWxA
        J4nh7ozjW+D++PeOpS7LRkKaCPoMEmhKlw==
X-Google-Smtp-Source: ABdhPJyMdHL2RqXTLMO10PucOo2E37ydwAbO5PRz0eDPU8943n5tnvd8rnttyP4Lqqi0KUiJK3AnJw==
X-Received: by 2002:a05:6402:2070:: with SMTP id bd16mr13449486edb.133.1615547581924;
        Fri, 12 Mar 2021 03:13:01 -0800 (PST)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id v15sm2738524edw.28.2021.03.12.03.13.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Mar 2021 03:13:01 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>,
        James Ramsay <james@jramsay.com.au>,
        Jonathan Nieder <jrnieder@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Josh Steadmon <steadmon@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH v8 00/37] config-based hooks
References: <20210311021037.3001235-1-emilyshaffer@google.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <20210311021037.3001235-1-emilyshaffer@google.com>
Date:   Fri, 12 Mar 2021 12:13:00 +0100
Message-ID: <87mtv8fww3.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Mar 11 2021, Emily Shaffer wrote:

> Since v7:
> - Addressed Jonathan Tan's review of part I
> - Addressed Junio's review of part I and II
> - Combined parts I and II
>

Comments on the overall design / goals (I don't just have strbuf nits):

I think I mentioned this in earlier rounds, but I'm still very skeptical
of the need for a "git hook" command for anything except the "run" case
(which is very useful).

So I tried patching it with this on top:
=09
	diff --git a/Documentation/config/hook.txt b/Documentation/config/hook.txt
	index 4f66bb35cf8..eb48da1dcf0 100644
	--- a/Documentation/config/hook.txt
	+++ b/Documentation/config/hook.txt
	@@ -1,20 +1,17 @@
	-hook.<command>.command::
	-	A command to execute during the <command> hook event. This can be an
	-	executable on your device, a oneliner for your shell, or the name of a
	-	hookcmd. See linkgit:git-hook[1].
	-
	-hookcmd.<name>.command::
	-	A command to execute during a hook for which <name> has been specified
	-	as a command. This can be an executable on your device or a oneliner for
	-	your shell. See linkgit:git-hook[1].
	-
	-hookcmd.<name>.skip::
	-	Specify this boolean to remove a command from earlier in the execution
	-	order. Useful if you want to make a single repo an exception to hook
	-	configured at the system or global scope. If there is no hookcmd
	-	specified for the command you want to skip, you can use the value of
	-	`hook.<command>.command` as <name> as a shortcut. The "skip" setting
	-	must be specified after the "hook.<command>.command" to have an effect.
	+hook.<name>.event::
	+hook.<name>.command::
	+	A command to execute during a given hook event for which
	+	<name> has been specified This can be an executable on your
	+	device or a oneliner for your shell. See linkgit:git-hook[1].
	++
	+As a convention setting this to the string `true` will clobber and
	+omit a command from earlier in the execution order. Similarly to the
	+"cat" special-case for `pager.<cmd>` we won't execute the hook at all
	+in that case.
	++
	+To have a single hook handle multiple types of events (such as
	+`pre-receive` and `post-receive`) specify `hook.<name>.event` multiple
	+times.
=09=20
	 hook.runHookDir::
	 	Controls how hooks contained in your hookdir are executed. Can be any of

I didn't finish that WIP patch, but I have yet to see any reason for why
it wouldn't work.

In experimenting with it further I tried just adding a "git config
--show-hook" as a convenience alias for "git config --show-origin
--show-scope --get-regexp '^hook\.<name>\.'", something like:
=09
	diff --git a/builtin/config.c b/builtin/config.c
	index 963d65fd3fc..f62356b923a 100644
	--- a/builtin/config.c
	+++ b/builtin/config.c
	@@ -33,6 +33,7 @@ static int end_nul;
	 static int respect_includes_opt =3D -1;
	 static struct config_options config_options;
	 static int show_origin;
	+static int show_hook;
	 static int show_scope;
=09=20
	 #define ACTION_GET (1<<0)
	@@ -159,6 +160,7 @@ static struct option builtin_config_options[] =3D {
	 	OPT_BOOL('z', "null", &end_nul, N_("terminate values with NUL byte")),
	 	OPT_BOOL(0, "name-only", &omit_values, N_("show variable names only")),
	 	OPT_BOOL(0, "includes", &respect_includes_opt, N_("respect include direc=
tives on lookup")),
	+	OPT_BOOL(0, "show-hook", &show_hook, N_("show configuration for a given =
hook (convenience alias for --show-origin --show-scope --get-regexp '^hook\=
\.<name>\\.')")),
	 	OPT_BOOL(0, "show-origin", &show_origin, N_("show origin of config (file=
, standard input, blob, command line)")),
	 	OPT_BOOL(0, "show-scope", &show_scope, N_("show scope of config (worktre=
e, local, global, system, command)")),
	 	OPT_STRING(0, "default", &default_value, N_("value"), N_("with --get, us=
e default value when missing entry")),
	@@ -631,6 +633,7 @@ int cmd_config(int argc, const char **argv, const char=
 *prefix)
	 {
	 	int nongit =3D !startup_info->have_repository;
	 	char *value;
	+	struct strbuf show_hook_arg =3D STRBUF_INIT;
=09=20
	 	given_config_source.file =3D xstrdup_or_null(getenv(CONFIG_ENVIRONMENT));
=09=20
	@@ -645,6 +648,14 @@ int cmd_config(int argc, const char **argv, const cha=
r *prefix)
	 		usage_builtin_config();
	 	}
=09=20
	+	if (show_hook) {
	+		strbuf_addf(&show_hook_arg, "^hook\\.%s\\.", argv[0]);
	+		actions =3D ACTION_GET_REGEXP;
	+		show_scope =3D 1;
	+		argv[0] =3D show_hook_arg.buf;
	+	}
	+=09=09
	+
	 	if (nongit) {
	 		if (use_local_config)
	 			die(_("--local can only be used inside a git repository"));
	@@ -915,5 +926,8 @@ int cmd_config(int argc, const char **argv, const char=
 *prefix)
	 		return get_colorbool(argv[0], argc =3D=3D 2);
	 	}
=09=20
	+	/* TODO: Memory leak on non-zero return, do we care? */
	+	strbuf_release(&show_hook_arg);
	+
	 	return 0;
	 }

So the reason that na=C3=AFve approach doesn't work is that the current
design has both a hook.<command>.command, *or* a
hookcmd.<command>.<cfg>. So it can't be just a single --get-regexp, you
need to statefully parse it, as indeed your implementation does.

But this seems like a bad idea to me for at least these reasons I've
thought of so far:

 1. If we just change the design a bit we can make this a much simpler
    git-config wrapper, or point to that directly.

 2. You're sticking full paths in the git config key, which is
    case-insensitive, and a feature of this format is being able to
    configure/override previously configured hooks.

    So the behavior of this feature depends on git's interaction with
    the case-sensitivity of filesystems, and not just one fs, any fs
    we're walking in our various config sources, and where the hook
    itself lives.

    As recent CVEs have shown that's a big can of worms, particularly
    for something whose goal is to address the security aspect of
    running hooks from other config.

    Arguably the case-sensitivity issue is just confusing since we
    canonicalize it anyway. But once you add in FS path canonicalization
    it becomes a real big can of worms. See the .gitmodules fsck code.

    Even if it wasn't for that it's relatively nastier to edit/maintain
    full paths and the appropriate escaping in the double-quoted key in
    the config file v.s. having it as an optionally quoted value.

 3. We're left with this "*.command =3D cmd", and "*.skip =3D true"
    special-case syntax. I can't see any reason for why it's needed over
    simply having "*.command =3D true" clobber earlier hooks as noted in
    the proposed docs above.

    And that doesn't require any magic to support, just like our
    existing "core.pager=3Dcat" case.

    I mean, I suppose it's magical in that we might otherwise error on
    non-consumed stdin (do we?), anyway, documenting it as a synonym for
    "cat >/dev/null" would get around that :)

 4. It makes the common case of having the same hooks for N commands
    needlessly verbose, if you can just support "type" (or whatever we
    should call it) you can add that N times...

 5. At the end of this series we're left with the start of the docs
    saying:

      You can list and run configured hooks with this command. Later,
      you will be able to add and modify hooks with this command.

    But those patches have yet to land, and looking at the design
    document I'm skeptical of that being a good addition v.s. just
    adding the same thing to "git config".

    As just one exmaple; surely "git config edit <name>" would need to
    run around and find config files to edit, then open them in a loop
    for you, no?

    Which we'd eventually want for "git config" in general with an
    --edit-regexp option or whatever, which brings us (well, at least
    me) back to "then let's just add it to git-config?".

 6. The whole 'git hook' config special-casing doesn't help other
    commands or the security issue that seemed to have prompted (at
    least some of) its existence

    In the design doc we mention the "core.pager =3D rm -rf /" case for a
    .git/config.

    This series doesn't implement, but the design docs note a future
    want for solving that issue for the hooks.

    To me that's another case where we should just have general config
    syntax, not something hook-specific, e.g. if I could do this in my
    ~/.gitconfig:

       ;; We consider 'config.ignore' in reverse order, so e.g setting
       ;; it in. ~/.gitconfig will ignore any such keys for repo-level
       ;; config
       [config "ignore"]
       key =3D core.pager
       keyRegexp =3D "^hook\."

    We'd address both any hook security concerns, as well as core.pager
    etc. We could then just have e.g. some syntax sugar of:

       [include]
       path =3D built-in://gimme-safe-config

    Which would just be a thin layer of magit to include
    <path-to-git-prefix>/config-templates/gimme-safe-config or whatever.

    We'd thus address the issue for all config types without
    hook-specific magic.

Anyway. I'm very willing to be convinced otherwise. I just think that
for a first-draft implementation leaving aside 'hook.<command>.command'
and the whole 'list' thing makes sense.

We can consider the core code changes relatively separately from any
future aspirations, particularly with a 40-some patch series, and the
end-state of *this series* IMO not really justifying, that part of the
implementation, and thus requiring reviewers to look ahead beyond the
40-some patches.
