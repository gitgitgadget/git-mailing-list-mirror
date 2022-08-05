Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8EBEC00140
	for <git@archiver.kernel.org>; Fri,  5 Aug 2022 16:13:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240976AbiHEQND (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Aug 2022 12:13:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238240AbiHEQND (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Aug 2022 12:13:03 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD6AC74CE7
        for <git@vger.kernel.org>; Fri,  5 Aug 2022 09:13:01 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id 123so4495095ybv.7
        for <git@vger.kernel.org>; Fri, 05 Aug 2022 09:13:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=xW/jYQuLkWG4io+Pif1BHBbFDFSHi5D9eqi2elgOEZE=;
        b=DmczMRthtp33Pkh6kigzgo7X2vKsUKifejAbL0i8BbVi32SdMRudU2kN1ZYzxBNy0e
         Rh5qZ6bUsPDJ7cn8IET+qXaJ15NhZjJ73jHUpiIdKwJjQtU/uBpx0jDlPQ6B8uHFa5IP
         2dUE7cCrPrlUF3K/qCn9+y2Unh6nCzG/we5HRcD/M73sHNlkCsLa+Gq0jEZRoC2ZhoKp
         MiNpeORzc5L2slfBHmAtH1S4rgHR4dNN6zZMbmqdxh6Z//CoPTi7w09ik3oCcrKCeDOE
         m5A8KogEyBlScRqoea+xyo3BzCoiN06NS5+VC+OzzgccHzvKfElXvd1rO4+Fd4aj0lqE
         X9Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=xW/jYQuLkWG4io+Pif1BHBbFDFSHi5D9eqi2elgOEZE=;
        b=d1/TtQwAQXKUAa9Gfeg1bF9DEimCFXnNq9lknqIlpyR5TtKnRmizxHCTq97wSMDUC9
         kvcuyoei2XOpZmI1XsxAdBs87E60DtXup2Tn3VkOIqNTGIQ0MR2QiHGJb7pAqeKv9xgQ
         cWld2zd3YjNpbmLbU8Dh/EViv//bfHsHclHjy70jIzy/NG4fa4oNkWU6cS73Zah4Zxc6
         VOcRwAmWMVoz7GytKS9ekuZd9lhuOcDTu3ewLKE3PHY8UXjIn7brynonoJBr8oQvnKHC
         C5d3afRV/Y1Zm2y0r0X8sWcyCfxenN5eHvUlRKqwMIZ/hqIqI9CAu0sMCTfuls8VX8UT
         +XIQ==
X-Gm-Message-State: ACgBeo2XG8FiAHYzLx//IiPiKonymKM2ac6o8BO/5tPz/3NBESB8F9QU
        84mm2desLLAY4x2Vhd8d9Ff0gS1xVd34niEahQeBxg==
X-Google-Smtp-Source: AA6agR4W5lj6/MC982jiRiOYb3S9HuScwFAyWdtqI92pX7/g7J2HLBttkHvyaWJQkndtF3339ALTjNkpzfvkoTLNQX8=
X-Received: by 2002:a25:75d7:0:b0:66f:cdfc:a986 with SMTP id
 q206-20020a2575d7000000b0066fcdfca986mr5474479ybc.268.1659715980706; Fri, 05
 Aug 2022 09:13:00 -0700 (PDT)
MIME-Version: 1.0
References: <30015309-00f1-9b44-023c-001ee3f242e4@0upti.me>
 <YuzML2lVGDBIK1uF@danh.dev> <220805.86pmhfru8a.gmgdl@evledraar.gmail.com> <220805.86les3rt7u.gmgdl@evledraar.gmail.com>
In-Reply-To: <220805.86les3rt7u.gmgdl@evledraar.gmail.com>
From:   Emily Shaffer <emilyshaffer@google.com>
Date:   Fri, 5 Aug 2022 09:12:49 -0700
Message-ID: <CAJoAoZmQdXhSU+y2HdDFpanS=8W5HEmiShKfBDdEMbC60aXPoQ@mail.gmail.com>
Subject: Re: [bug] Segfault in git commit when a hook has a broken shebang
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>,
        Ilya K <me@0upti.me>, Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 5, 2022 at 1:27 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avar=
ab@gmail.com> wrote:
> -- >8 --
> Subject: [PATCH] hook API: don't segfault on strbuf_addf() to NULL "out"
> MIME-Version: 1.0
> Content-Type: text/plain; charset=3DUTF-8
> Content-Transfer-Encoding: 8bit
>
> Fix a logic error in a082345372e (hook API: fix v2.36.0 regression:
> hooks should be connected to a TTY, 2022-06-07). When it started using
> the "ungroup" API added in fd3aaf53f71 (run-command: add an "ungroup"
> option to run_process_parallel(), 2022-06-07) it should have made the
> same sort of change that fd3aaf53f71 itself made in
> "t/helper/test-run-command.c".
>
> The correct way to emit this "Couldn't start" output with "ungroup"
> would be:
>
>         fprintf(stderr, _("Couldn't start hook '%s'\n"), hook_path);
>
> But we should instead remove the emitting of this output. As the added
> test shows we already emit output when we can't run the child. The
> "cannot run" output here is emitted by run-command.c's
> child_err_spew().

Nice, thanks. And child_err_spew() gives argv[0] in most cases, so
it's the same context as we'd get from this line anyway.

>
> So the addition of the "Couldn't start hook" output here in
> 96e7225b310 (hook: add 'run' subcommand, 2021-12-22) was always
> redundant. For the pre-commit hook we'll now emit exactly the same
> output as we did before f443246b9f2 (commit: convert
> {pre-commit,prepare-commit-msg} hook to hook.h, 2021-12-22) (and
> likewise for others).
>
> We could at this point add this to the pick_next_hook() callbacks in
> hook.c:
>
>         assert(!out);
>         assert(!*pp_task_cb);
>
> And this to notify_start_failure() and notify_hook_finished() (in the
> latter case the parameter is called "pp_task_cp"):
>
>         assert(!out);
>         assert(!pp_task_cb);
>
> But let's leave any such instrumentation for some eventual cleanup of
> the "ungroup" API.
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
Reviewed-by: Emily Shaffer <emilyshaffer@google.com>
> ---
>  hook.c          |  7 -------
>  t/t1800-hook.sh | 15 +++++++++++++++
>  2 files changed, 15 insertions(+), 7 deletions(-)
>
> diff --git a/hook.c b/hook.c
> index d113ee7faae..a493939a4fc 100644
> --- a/hook.c
> +++ b/hook.c
> @@ -62,9 +62,6 @@ static int pick_next_hook(struct child_process *cp,
>         strvec_push(&cp->args, hook_path);
>         strvec_pushv(&cp->args, hook_cb->options->args.v);
>
> -       /* Provide context for errors if necessary */
> -       *pp_task_cb =3D (char *)hook_path;
> -
>         /*
>          * This pick_next_hook() will be called again, we're only
>          * running one hook, so indicate that no more work will be
> @@ -80,13 +77,9 @@ static int notify_start_failure(struct strbuf *out,
>                                 void *pp_task_cp)
>  {
>         struct hook_cb_data *hook_cb =3D pp_cb;
> -       const char *hook_path =3D pp_task_cp;
>
>         hook_cb->rc |=3D 1;
>
> -       strbuf_addf(out, _("Couldn't start hook '%s'\n"),
> -                   hook_path);
> -
>         return 1;
>  }
>
> diff --git a/t/t1800-hook.sh b/t/t1800-hook.sh
> index 210f4298872..75f72ffbf27 100755
> --- a/t/t1800-hook.sh
> +++ b/t/t1800-hook.sh
> @@ -151,4 +151,19 @@ test_expect_success TTY 'git commit: stdout and stde=
rr are connected to a TTY' '
>         test_hook_tty commit -m"B.new"
>  '
>
> +test_expect_success 'git hook run a hook with a bad shebang' '
> +       test_when_finished "rm -rf bad-hooks" &&
> +       mkdir bad-hooks &&
> +       write_script bad-hooks/test-hook "/bad/path/no/spaces" </dev/null=
 &&
> +       cat >expect <<-\EOF &&
> +       fatal: cannot run bad-hooks/test-hook: ...
> +       EOF
> +       test_expect_code 1 git \
> +               -c core.hooksPath=3Dbad-hooks \
> +               hook run test-hook >out 2>actual.raw &&
> +       test_must_be_empty out &&
> +       sed -e "s/test-hook: .*/test-hook: .../" <actual.raw >actual &&
> +       test_cmp expect actual
> +'
> +
>  test_done
> --
