Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F0FBC433FE
	for <git@archiver.kernel.org>; Wed,  5 Oct 2022 07:34:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229884AbiJEHe0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Oct 2022 03:34:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbiJEHeZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Oct 2022 03:34:25 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C825174E0E
        for <git@vger.kernel.org>; Wed,  5 Oct 2022 00:34:22 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id y8so21801097edc.10
        for <git@vger.kernel.org>; Wed, 05 Oct 2022 00:34:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=X15J6luXzxzrgCwMYv2IjJq85A+nVVILNPE8Batyd2Q=;
        b=FJdIbXIt8GsLAKihfu4fp292dKIKGDKDxj0bmk1/fPO9g661U6Lf2zHhGI7D8uRi0x
         TAPt3XATnBJEalemL7ZpozgnJEcktY4++g/+jUwFJ+dWkKnavoqy4owwAWSOdWWGZq9y
         bJaVN19UsLBRFbqd6ITMU/I7bf5niAAGHJcwH7dTjEURYCUtEnZf9rp4+25j6S6YuUlZ
         hg5WqpMu1LGX8fw21L743dR341ph1ozlYFOvkT3TZi+7ibf1ZYWc8KxBUkSbE99XEyQf
         tNgzBNnjvOjh4fcd7gvM6rYva2RVRRiuj6mQNQ7/vcbHH4abLUR0EFNnZCegEir/GQoJ
         WGFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=X15J6luXzxzrgCwMYv2IjJq85A+nVVILNPE8Batyd2Q=;
        b=D9AkI8uZWbSh21ZZ3XyTv12mZBCfM/Zm3Ec5e1b0YDyUaEC+l2AozhoW/wsOZg9p9G
         xdkyQsMx1SOhHL/87MYLr5NpwANWcK0lBlxZrmHwYSHvxenwB+ZsYETRgfuK/wcnzYyv
         tneAJOc2qqxz6T0memAJbiB7cE0Uk2lrGJdMJDNV1Y9ty8o2FlkCxJJYehCQHi7UxJJr
         zlJKknvJKd13P6WurdnarQVJKCG+VxGFNg/koU6DjXSaRuySC3YnhH5oUe4e3q9M2Gnn
         cIagvjzjzT+Dv9Ly7fPkaMlrZFVlTSl7Tpvg4Pb15Vvo+an2RdAFFtbOsEqKiMkdZfEY
         Ckdw==
X-Gm-Message-State: ACrzQf0613LJGCPXtqo3uzQK89h4D7Len3TbuZlBjG+z6+USPDnkhzG6
        2bJ/E3X6pzXuFS8q03UdD20nHHH1gdCyyw==
X-Google-Smtp-Source: AMsMyM7/sn4xJx31r2IfK95r/n7V1WOVgn2IEhkBQjIZE7E3Iec3E04GNxCn4ubDTFD2UMSF26SGnQ==
X-Received: by 2002:a05:6402:50ca:b0:451:a711:1389 with SMTP id h10-20020a05640250ca00b00451a7111389mr26760801edb.239.1664955261147;
        Wed, 05 Oct 2022 00:34:21 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id b18-20020a17090630d200b0073dd8e5a39fsm8105541ejb.156.2022.10.05.00.34.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Oct 2022 00:34:20 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1ofyv4-002Op0-2n;
        Wed, 05 Oct 2022 09:34:18 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Subject: Re: PATCH] bisect--helper: plug strvec leak in bisect_start()
Date:   Wed, 05 Oct 2022 09:29:13 +0200
References: <5c6a4c30-d454-51b6-ec57-9af036b9c4e0@web.de>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <5c6a4c30-d454-51b6-ec57-9af036b9c4e0@web.de>
Message-ID: <221005.8635c2u3k5.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Oct 04 2022, Ren=C3=A9 Scharfe wrote:

> The strvec "argv" is used to build a command for run_command_v_opt(),
> but never freed.  Use the "args" strvec of struct child_process and
> run_command() instead, which releases the allocated memory both on
> success and on error.  We just also need to set the "git_cmd" bit
> directly.
>
> Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
> ---
>  builtin/bisect--helper.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
> index 501245fac9..9fe0c08479 100644
> --- a/builtin/bisect--helper.c
> +++ b/builtin/bisect--helper.c
> @@ -765,11 +765,12 @@ static enum bisect_error bisect_start(struct bisect=
_terms *terms, const char **a
>  		strbuf_read_file(&start_head, git_path_bisect_start(), 0);
>  		strbuf_trim(&start_head);
>  		if (!no_checkout) {
> -			struct strvec argv =3D STRVEC_INIT;
> +			struct child_process cmd =3D CHILD_PROCESS_INIT;
>
> -			strvec_pushl(&argv, "checkout", start_head.buf,
> +			cmd.git_cmd =3D 1;
> +			strvec_pushl(&cmd.args, "checkout", start_head.buf,
>  				     "--", NULL);
> -			if (run_command_v_opt(argv.v, RUN_GIT_CMD)) {
> +			if (run_command(&cmd)) {
>  				res =3D error(_("checking out '%s' failed."
>  						 " Try 'git bisect start "
>  						 "<valid-branch>'."),

Okey, so we leak the strvec, and instead of adding a strvec_clear()
you're just switching the lower-level API, which we'd need in some cases
with this API, and would often be cleaner.

But I don't get it in this case, why not just:
=09
	diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
	index 4e97817fba5..f9645a9d0df 100644
	--- a/builtin/bisect--helper.c
	+++ b/builtin/bisect--helper.c
	@@ -763,11 +763,9 @@ static enum bisect_error bisect_start(struct bisect_t=
erms *terms, const char **a
	 		strbuf_read_file(&start_head, git_path_bisect_start(), 0);
	 		strbuf_trim(&start_head);
	 		if (!no_checkout) {
	-			struct strvec argv =3D STRVEC_INIT;
	+			const char *argv[] =3D { "checkout", start_head.buf, "--", NULL };
=09=20
	-			strvec_pushl(&argv, "checkout", start_head.buf,
	-				     "--", NULL);
	-			if (run_command_v_opt(argv.v, RUN_GIT_CMD)) {
	+			if (run_command_v_opt(argv, RUN_GIT_CMD)) {
	 				res =3D error(_("checking out '%s' failed."
	 						 " Try 'git bisect start "
	 						 "<valid-branch>'."),

The common pattern for run_command_v_opt() callers that don't need a
dynamic list is exactly that, e.g.:
=09
	builtin/difftool.c=3Dstatic int print_tool_help(void)
	builtin/difftool.c-{
	builtin/difftool.c-     const char *argv[] =3D { "mergetool", "--tool-help=
=3Ddiff", NULL };
	builtin/difftool.c:     return run_command_v_opt(argv, RUN_GIT_CMD);
	builtin/difftool.c-}
=09
And:
=09
	fsmonitor-ipc.c=3Dstatic int spawn_daemon(void)
	fsmonitor-ipc.c-{
	fsmonitor-ipc.c-        const char *args[] =3D { "fsmonitor--daemon", "sta=
rt", NULL };
	fsmonitor-ipc.c-
	fsmonitor-ipc.c:        return run_command_v_opt_tr2(args, RUN_COMMAND_NO_=
STDIN | RUN_GIT_CMD,
	fsmonitor-ipc.c-                                    "fsmonitor");
	fsmonitor-ipc.c-}

Here we have the "start_head" which we'll need to strbuf_release(), but
we're not returning directly, and the function is doing that already.

Your version is slightly more memory efficient, i.e. we'll end up having
to push this to a "struct child_process"'s argv anyway, but this is less
code & we don't need to carefully eyeball run_command_v_opt_cd_env_tr2()
to see that it's correct (which I did, your version does the right thing
too).
