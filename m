Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE9B2C432BE
	for <git@archiver.kernel.org>; Fri, 27 Aug 2021 11:20:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B220D60FDA
	for <git@archiver.kernel.org>; Fri, 27 Aug 2021 11:20:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245008AbhH0LVD (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 Aug 2021 07:21:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233082AbhH0LU6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Aug 2021 07:20:58 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9757CC061757
        for <git@vger.kernel.org>; Fri, 27 Aug 2021 04:20:09 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id q14so9873323wrp.3
        for <git@vger.kernel.org>; Fri, 27 Aug 2021 04:20:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=ajOgDLbuUkQd6Ej0nZjuOyfJvr2ngwC70rIA9xxe7Rg=;
        b=AxvCHwF0lTsS3GlDjzlfupcLuFKcbD41mGJT3bFnAYYZF5Ym1ImBzpOxyIfqvW6G2t
         XporYsAFUTHqcJY9wS/yomy9bBABlVoTycfOuQ6dIq72+giZ8vU4nSqEO/tyP4Y2Wy1T
         27u9od3lBn/xgXQ5nI9DN6NXc4zb1Vi0TYJef5GnuOhCQyjPwwTYYbt2tJEeAT+zS5PO
         KGhJRelizgj+YLFDFyasEJ+MX28o5zdcHK/A3tNdCfqnft6jnuIYPSJ/nwh9FYmGJqqt
         F6scTYdlgZZOtCYfXVvHd/jcSjDfrzBmBxeXj8gjJkf6TvSwOWW15m27vitaFq1iFDNc
         r6pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=ajOgDLbuUkQd6Ej0nZjuOyfJvr2ngwC70rIA9xxe7Rg=;
        b=aZdPpPegR/PPhoC8UvbNdW+Bvhanisi375ZYPohQugp3TdvnWEIgfu/8A4pVmzNIio
         thjESJdeIrWNOxtZzO6dP7GBf9ZVzRi8WEaZvRfEeBXf7tQLZ8wV2Dkn0o4i7lPki1Ms
         55p3zgQSYlIpHoV4ttFmIhyawuhKCiJhy3d2YmXP3Rje/LYLpXqyL3M4W0YFp4QBEX4r
         torqwWU+y7FKfKzpU5BqTbDh17puF20Mmg3TbHejWlzegb5eFXQYrgI8BsDGoxdlNkl2
         fDjPgMgPxfE0ynMprLcG05GJKeCIx7+UxfT35oPmU00Obtn54gaTJmTf9QlpWPzxk0BB
         5YQw==
X-Gm-Message-State: AOAM530aDOPnhZoFuREANhXy7cs6OCs8q4gAGrqEPyUOe0/Lmsd/AXWb
        HfpWEhf1KiSmBiOuv66xq+WebYnOsgejAA==
X-Google-Smtp-Source: ABdhPJx+2PteV7sEwXHZ1zxn0Mf5g2Z1KEQ3R3MyGHy8ouwx1t6/DgerUaRyK//dPneYECsoSZIJ9g==
X-Received: by 2002:adf:f884:: with SMTP id u4mr9393902wrp.411.1630063207911;
        Fri, 27 Aug 2021 04:20:07 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id h8sm10561422wmb.35.2021.08.27.04.20.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Aug 2021 04:20:07 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v3 1/6] hook: run a list of hooks instead
Date:   Fri, 27 Aug 2021 13:15:31 +0200
References: <20210819033450.3382652-1-emilyshaffer@google.com>
 <20210819033450.3382652-2-emilyshaffer@google.com>
 <87zgt6evkf.fsf@evledraar.gmail.com> <YSgEw1D3u+MIPx2t@google.com>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <YSgEw1D3u+MIPx2t@google.com>
Message-ID: <8735qvyw0p.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Aug 26 2021, Emily Shaffer wrote:

> On Tue, Aug 24, 2021 at 04:56:10PM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>>=20
>>=20
>> On Wed, Aug 18 2021, Emily Shaffer wrote:
>>=20
>> > @@ -25,7 +25,8 @@ static int run(int argc, const char **argv, const ch=
ar *prefix)
>> >  	struct run_hooks_opt opt =3D RUN_HOOKS_OPT_INIT;
>> >  	int ignore_missing =3D 0;
>> >  	const char *hook_name;
>> > -	const char *hook_path;
>> > +	struct list_head *hooks;
>> > +
>> >  	struct option run_options[] =3D {
>> >  		OPT_BOOL(0, "ignore-missing", &ignore_missing,
>> >  			 N_("exit quietly with a zero exit code if the requested hook cann=
ot be found")),
>>=20
>> In general in this patch series there's a bunch of little whitespace
>> changes like that along with other changes. I think it's probably best
>> if I just absorb that in the "base" topic instead of doing them
>> here. E.g. in this case we could also add a line between "struct option"
>> and the rest.
>>=20
>> I don't mind either way, but the whitespace churn makes for distracting
>> reading...
>
> Ah, hm. I don't know if in this specific case it's necessary for me to
> even have this whitespace change, since 'run_options' is still a struct
> declaration. I'll just drop this one, but in general whichever
> whitespace bits you like from this topic, feel free to absorb. Will make
> a note to scan through the diff when I rebase onto your next reroll
> checking for spurious whitespace changes.
>
>>=20
>> > @@ -58,15 +59,16 @@ static int run(int argc, const char **argv, const =
char *prefix)
>> >  	git_config(git_default_config, NULL);
>> >=20=20
>> >  	hook_name =3D argv[0];
>> > -	if (ignore_missing)
>> > -		return run_hooks_oneshot(hook_name, &opt);
>> > -	hook_path =3D find_hook(hook_name);
>> > -	if (!hook_path) {
>> > +	hooks =3D list_hooks(hook_name);
>> > +	if (list_empty(hooks)) {
>> > +		/* ... act like run_hooks_oneshot() under --ignore-missing */
>> > +		if (ignore_missing)
>> > +			return 0;
>> >  		error("cannot find a hook named %s", hook_name);
>> >  		return 1;
>> >  	}
>> >=20=20
>> > -	ret =3D run_hooks(hook_name, hook_path, &opt);
>> > +	ret =3D run_hooks(hook_name, hooks, &opt);
>> >  	run_hooks_opt_clear(&opt);
>> >  	return ret;
>>=20
>> This memory management is a bit inconsistent. So here we list_hooks(),
>> pass it to run_hooks(), which clears it for us, OK...
>>=20
>> > -int run_hooks(const char *hook_name, const char *hook_path,
>> > -	      struct run_hooks_opt *options)
>> > +int run_hooks(const char *hook_name, struct list_head *hooks,
>> > +		    struct run_hooks_opt *options)
>> >  {
>> > -	struct strbuf abs_path =3D STRBUF_INIT;
>> > -	struct hook my_hook =3D {
>> > -		.hook_path =3D hook_path,
>> > -	};
>> >  	struct hook_cb_data cb_data =3D {
>> >  		.rc =3D 0,
>> >  		.hook_name =3D hook_name,
>> > @@ -197,11 +241,9 @@ int run_hooks(const char *hook_name, const char *=
hook_path,
>> >  	if (!options)
>> >  		BUG("a struct run_hooks_opt must be provided to run_hooks");
>> >=20=20
>> > -	if (options->absolute_path) {
>> > -		strbuf_add_absolute_path(&abs_path, hook_path);
>> > -		my_hook.hook_path =3D abs_path.buf;
>> > -	}
>> > -	cb_data.run_me =3D &my_hook;
>> > +
>> > +	cb_data.head =3D hooks;
>> > +	cb_data.run_me =3D list_first_entry(hooks, struct hook, list);
>> >=20=20
>> >  	run_processes_parallel_tr2(jobs,
>> >  				   pick_next_hook,
>> > @@ -213,18 +255,15 @@ int run_hooks(const char *hook_name, const char =
*hook_path,
>> >  				   "hook",
>> >  				   hook_name);
>> >=20=20
>> > -
>> > -	if (options->absolute_path)
>> > -		strbuf_release(&abs_path);
>> > -	free(my_hook.feed_pipe_cb_data);
>> > +	clear_hook_list(hooks);
>> >=20=20
>> >  	return cb_data.rc;
>> >  }
>>=20
>> Which we can see here will call clear_hook_list(), so far so good, but t=
hen...
>>=20
>> >  int run_hooks_oneshot(const char *hook_name, struct run_hooks_opt *op=
tions)
>> >  {
>> > -	const char *hook_path;
>> > -	int ret;
>> > +	struct list_head *hooks;
>> > +	int ret =3D 0;
>> >  	struct run_hooks_opt hook_opt_scratch =3D RUN_HOOKS_OPT_INIT;
>> >=20=20
>> >  	if (!options)
>> > @@ -233,14 +272,19 @@ int run_hooks_oneshot(const char *hook_name, str=
uct run_hooks_opt *options)
>> >  	if (options->path_to_stdin && options->feed_pipe)
>> >  		BUG("choose only one method to populate stdin");
>> >=20=20
>> > -	hook_path =3D find_hook(hook_name);
>> > -	if (!hook_path) {
>> > -		ret =3D 0;
>> > +	hooks =3D list_hooks(hook_name);
>> > +
>> > +	/*
>> > +	 * If you need to act on a missing hook, use run_found_hooks()
>> > +	 * instead
>> > +	 */
>> > +	if (list_empty(hooks))
>> >  		goto cleanup;
>> > -	}
>> >=20=20
>> > -	ret =3D run_hooks(hook_name, hook_path, options);
>> > +	ret =3D run_hooks(hook_name, hooks, options);
>> > +
>> >  cleanup:
>> >  	run_hooks_opt_clear(options);
>> > +	clear_hook_list(hooks);
>>=20
>> ...the oneshot command also does clear_hook_list(), after calling
>> run_hooks() which cleared it already.  That looks like a mistake,
>> i.e. we should always trust run_hooks() to clear it, no?
>
> Ah, good catch. I will update the comment on run_hooks() and fix
> _oneshot() :)
>
>  - Emily

I found a further memory issue with this, on "seen" running e.g. t0001
when compiled with SANITIZE=3Dleak is broken by this series.

It's because in clear_hook_list() you clear the list of hooks, but
forget to clear the malloc'd container, so a missing free() fixes it. As
in the POC patch at the end of this mail.

But e.g. "git hook list <name>" is still broken, easy enough to fix,
just also needs fixing of the list_hooks_gently() callsites to e.g. this:
=20=20=20=20
    diff --git a/builtin/hook.c b/builtin/hook.c
    index 50233366a8..2cd1831075 100644
    --- a/builtin/hook.c
    +++ b/builtin/hook.c
    @@ -48,8 +48,10 @@ static int list(int argc, const char **argv, const c=
har *prefix)
=20=20=20=20=20
     	head =3D list_hooks_gently(hookname);
=20=20=20=20=20
    -	if (list_empty(head))
    +	if (list_empty(head)) {
    +		clear_hook_list(head);
     		return 1;
    +	}
=20=20=20=20=20
     	list_for_each(pos, head) {
     		struct hook *item =3D list_entry(pos, struct hook, list);

Although going to that length to make the SANITIZE=3Dleak run clean is
arguably overdoing it...

diff --git a/hook.c b/hook.c
index 23af86b9ea..e6e1e4173a 100644
--- a/hook.c
+++ b/hook.c
@@ -67,6 +67,7 @@ void clear_hook_list(struct list_head *head)
 	struct list_head *pos, *tmp;
 	list_for_each_safe(pos, tmp, head)
 		remove_hook(pos);
+	free(head);
 }
=20
 static int known_hook(const char *name)
@@ -142,7 +143,16 @@ const char *find_hook_gently(const char *name)
=20
 int hook_exists(const char *name)
 {
-	return !list_empty(list_hooks(name));
+	struct list_head *hooks;
+	int exists;
+
+	hooks =3D list_hooks(name);
+
+	exists =3D !list_empty(hooks);
+
+	clear_hook_list(hooks);
+
+	return exists;
 }
=20
 struct hook_config_cb
