Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9E2BC433EF
	for <git@archiver.kernel.org>; Fri, 29 Oct 2021 05:51:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 89F2560F4B
	for <git@archiver.kernel.org>; Fri, 29 Oct 2021 05:51:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231829AbhJ2Fvh (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Oct 2021 01:51:37 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:58175 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231774AbhJ2FvY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Oct 2021 01:51:24 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 255041589CF;
        Fri, 29 Oct 2021 01:48:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=bkimdX1jMHqa
        MER3UsXz38GRHcM/C/mG6sXmelGQhoc=; b=DjbjcFDkKcH8hZcQKgY6pvOFNruo
        s2zye62HmBD9yUYS7Y6xSVHhLJ9dKbj3zH0wdVuwOWNqghWKjRQ4IAaltGPjTwvc
        L0mufzPvrCl5YPyMxL2c+e967DOhuMca1JJDvzEu47sd1iFUjOSI9hRufLrrg2f3
        9mdK31VIV85i3xY=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 114DF1589CD;
        Fri, 29 Oct 2021 01:48:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id B5C5E1589CB;
        Fri, 29 Oct 2021 01:48:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Emily Shaffer <emilyshaffer@google.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Re: [PATCH v3 03/13] rebase: convert pre-rebase to use hook.h
References: <cover-v2-00.13-00000000000-20211015T093918Z-avarab@gmail.com>
        <cover-v3-00.13-00000000000-20211019T231647Z-avarab@gmail.com>
        <patch-v3-03.13-cbbfd77a4f6-20211019T231647Z-avarab@gmail.com>
Date:   Thu, 28 Oct 2021 22:48:51 -0700
In-Reply-To: <patch-v3-03.13-cbbfd77a4f6-20211019T231647Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Wed, 20 Oct
 2021 01:20:41
        +0200")
Message-ID: <xmqqk0hwmldo.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: E5B486C4-387B-11EC-AC2A-98D80D944F46-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> From: Emily Shaffer <emilyshaffer@google.com>
>
> Move the pre-rebase hook away from run-command.h to and over to the
> new hook.h library.
>
> Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
> ---
>  builtin/rebase.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/builtin/rebase.c b/builtin/rebase.c
> index 34b4744e5f3..758b5dfabe2 100644
> --- a/builtin/rebase.c
> +++ b/builtin/rebase.c
> @@ -28,6 +28,7 @@
>  #include "sequencer.h"
>  #include "rebase-interactive.h"
>  #include "reset.h"
> +#include "hook.h"
> =20
>  #define DEFAULT_REFLOG_ACTION "rebase"
> =20
> @@ -1017,6 +1018,7 @@ int cmd_rebase(int argc, const char **argv, const=
 char *prefix)
>  	int reschedule_failed_exec =3D -1;
>  	int allow_preemptive_ff =3D 1;
>  	int preserve_merges_selected =3D 0;
> +	struct run_hooks_opt hook_opt =3D RUN_HOOKS_OPT_INIT;
>  	struct option builtin_rebase_options[] =3D {
>  		OPT_STRING(0, "onto", &options.onto_name,
>  			   N_("revision"),
> @@ -1711,9 +1713,11 @@ int cmd_rebase(int argc, const char **argv, cons=
t char *prefix)
>  	}
> =20
>  	/* If a hook exists, give it a chance to interrupt*/
> +	strvec_push(&hook_opt.args, options.upstream_arg);
> +	if (argc)
> +		strvec_push(&hook_opt.args, argv[0]);
>  	if (!ok_to_skip_pre_rebase &&
> -	    run_hook_le(NULL, "pre-rebase", options.upstream_arg,
> -			argc ? argv[0] : NULL, NULL))
> +	    run_hooks_oneshot("pre-rebase", &hook_opt))
>  		die(_("The pre-rebase hook refused to rebase."));
> =20
>  	if (options.flags & REBASE_DIFFSTAT) {


OK, so the convention is

 * if there is no extra args the hook takes, you only give hook_name
   and NULL;

 * if there is even one arg the hook takes, you have to prepare the
   opt struct and strvec_push() the arg yourself.

That would work, and it might be merely the matter of taste, but it
would have been nicer if the calling sequence to run_hooks_oneshot()
were more like run_hook_le().

But patches were already written, so let's keep reading.

