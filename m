Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEE4F17D4
	for <git@vger.kernel.org>; Sun, 24 Dec 2023 07:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HGRqM6C8"
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2ccadec4b79so14891541fa.1
        for <git@vger.kernel.org>; Sat, 23 Dec 2023 23:53:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703404395; x=1704009195; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ap/+K8oQupFrI9BitapI9clC1+Nqgvgxl1i0dbbL7hw=;
        b=HGRqM6C8d9/nOM/RqOfWzsbUf3ThUFvnfk55Z1l2LOFZzQ/GfUUh8lLz+cIyyM7Htw
         VoDUl+YCShqKLARWdi5u6GdVk1aomW966SYJh+KHXi5ee5z8nu4ye61G9bcNEEALy+Wq
         myOLLJfsRsrTsj06gL8Q/w4GySzE2dpZy7OTxv63ZquSLy+ra76DVYASDOUTzS6yrpqy
         7Ac2dTkT5rbjD3KJ4+6LJ7NFwZ+a0nNo71Eu0Br4QUp06EcXfhOsDWP/uy8ZUHh9I8sU
         pDbAH7KxFcwU6/a1HYGPvRlpJmiPo/1s5NcAxq5chRSpbvwh2NiUCfbHgp/7qH4bzRcC
         oClg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703404395; x=1704009195;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ap/+K8oQupFrI9BitapI9clC1+Nqgvgxl1i0dbbL7hw=;
        b=KjTD1hOznL3kUBqtZeyYiUsLOxdbfN0kASGuAfUSi8BfSX9H0MXaKYF3La8EwAL3RX
         vlFgnt54Dl2Z1XWMevuChDmRgYJZNGmXwuIerIh10IS8238lr+/b3SelbmGX8Ig8ICpX
         KgFYZDKKwzKrE107Jey1TOA2ZohDRtUXymTaJvrKph5QvSC0LKg50huv6/ysrZeGNnVL
         jxxiwYnAsTKYwDc+NyWjZrUt7lenj6c3iXzi8EQJqZRmYgVcyJsBGM2gI38f7/tZ6Wv7
         jUk/Hbtxv/ajO2HuDT9O0K9AG3nRoF/uYNBxwBK8dWCAcQRy4iq0/zdYB8uaduMJ+M6h
         3aOg==
X-Gm-Message-State: AOJu0YwMDJb23fGGImzdC05lHTguVqRaaK0HxiZqdRavbhlpfLjtjI3Y
	cUNniZp1JBRYGisc3G+o+8iIWn1dz3LLNDtVYqs=
X-Google-Smtp-Source: AGHT+IHq3wlTod2qXHVwISvmUFUB13Ivmcwy3s4iXKHAmy/tr888niyuUmEpKcC0JAfFLQrSsNUbSz/hQLXLu61HCYA=
X-Received: by 2002:a2e:1518:0:b0:2cc:3f83:e3f9 with SMTP id
 s24-20020a2e1518000000b002cc3f83e3f9mr1345328ljd.46.1703404395366; Sat, 23
 Dec 2023 23:53:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231221065925.3234048-1-gitster@pobox.com> <20231221065925.3234048-2-gitster@pobox.com>
In-Reply-To: <20231221065925.3234048-2-gitster@pobox.com>
From: Elijah Newren <newren@gmail.com>
Date: Sat, 23 Dec 2023 23:53:04 -0800
Message-ID: <CABPp-BGk-B4iVa7ZubNVoWRtJgg4guK31ctdO16osUnn7bRhHQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] sparse-checkout: take care of "--end-of-options" in set/add/check-rules
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>, Josh Steadmon <steadmon@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 20, 2023 at 11:00=E2=80=AFPM Junio C Hamano <gitster@pobox.com>=
 wrote:
>
> 93851746 (parse-options: decouple "--end-of-options" and "--",
> 2023-12-06) updated the world order to make callers of parse-options
> that set PARSE_OPT_KEEP_UNKNOWN_OPT responsible for deciding what to
> do with "--end-of-options" they may see after parse_options() returns.
>
> This unfortunately broke "sparse-checkout set/add", and from this
> invocation,
>
>   "git sparse-checkout [add|set] --[no-]cone --end-of-options pattern..."
>
> we now see "--end-of-options" listed in .git/info/sparse-checkout as if
> it is one of the path patterns.
>
> A breakage that results from the same cause exists in the check-rules
> subcommand, but check-rules has a few other problems that need to be
> corrected before it can fully work with --end-of-options safely,
> which will be addressed later.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  builtin/sparse-checkout.c          | 3 +++
>  parse-options.c                    | 8 ++++++++
>  parse-options.h                    | 2 ++
>  t/t1090-sparse-checkout-scope.sh   | 8 ++++++++
>  t/t1091-sparse-checkout-builtin.sh | 2 +-
>  5 files changed, 22 insertions(+), 1 deletion(-)
>
> diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
> index 5c8ffb1f75..8f55127202 100644
> --- a/builtin/sparse-checkout.c
> +++ b/builtin/sparse-checkout.c
> @@ -779,6 +779,7 @@ static int sparse_checkout_add(int argc, const char *=
*argv, const char *prefix)
>                              builtin_sparse_checkout_add_options,
>                              builtin_sparse_checkout_add_usage,
>                              PARSE_OPT_KEEP_UNKNOWN_OPT);
> +       parse_opt_skip_end_of_options(&argc, &argv);
>
>         sanitize_paths(argc, argv, prefix, add_opts.skip_checks);
>
> @@ -826,6 +827,7 @@ static int sparse_checkout_set(int argc, const char *=
*argv, const char *prefix)
>                              builtin_sparse_checkout_set_options,
>                              builtin_sparse_checkout_set_usage,
>                              PARSE_OPT_KEEP_UNKNOWN_OPT);
> +       parse_opt_skip_end_of_options(&argc, &argv);
>
>         if (update_modes(&set_opts.cone_mode, &set_opts.sparse_index))
>                 return 1;
> @@ -998,6 +1000,7 @@ static int sparse_checkout_check_rules(int argc, con=
st char **argv, const char *
>                              builtin_sparse_checkout_check_rules_options,
>                              builtin_sparse_checkout_check_rules_usage,
>                              PARSE_OPT_KEEP_UNKNOWN_OPT);
> +       parse_opt_skip_end_of_options(&argc, &argv);
>
>         if (check_rules_opts.rules_file && check_rules_opts.cone_mode < 0=
)
>                 check_rules_opts.cone_mode =3D 1;
> diff --git a/parse-options.c b/parse-options.c
> index d50962062e..fe265bbf68 100644
> --- a/parse-options.c
> +++ b/parse-options.c
> @@ -1321,3 +1321,11 @@ void die_for_incompatible_opt4(int opt1, const cha=
r *opt1_name,
>                 break;
>         }
>  }
> +
> +void parse_opt_skip_end_of_options(int *argc, const char ***argv)
> +{
> +       if (*argc && !strcmp(**argv, "--end-of-options")) {
> +               (*argc)--;
> +               (*argv)++;
> +       }
> +}
> diff --git a/parse-options.h b/parse-options.h
> index bd62e20268..0d3354d4a8 100644
> --- a/parse-options.h
> +++ b/parse-options.h
> @@ -498,6 +498,8 @@ int parse_opt_passthru_argv(const struct option *, co=
nst char *, int);
>  /* value is enum branch_track* */
>  int parse_opt_tracking_mode(const struct option *, const char *, int);
>
> +void parse_opt_skip_end_of_options(int *argc, const char ***argv);
> +
>  #define OPT__VERBOSE(var, h)  OPT_COUNTUP('v', "verbose", (var), (h))
>  #define OPT__QUIET(var, h)    OPT_COUNTUP('q', "quiet",   (var), (h))
>  #define OPT__VERBOSITY(var) { \
> diff --git a/t/t1090-sparse-checkout-scope.sh b/t/t1090-sparse-checkout-s=
cope.sh
> index 3a14218b24..5b96716235 100755
> --- a/t/t1090-sparse-checkout-scope.sh
> +++ b/t/t1090-sparse-checkout-scope.sh
> @@ -57,6 +57,14 @@ test_expect_success 'return to full checkout of main' =
'
>  test_expect_success 'skip-worktree on files outside sparse patterns' '
>         git sparse-checkout disable &&
>         git sparse-checkout set --no-cone "a*" &&
> +       cat .git/info/sparse-checkout >wo-eoo &&
> +
> +       git sparse-checkout disable &&
> +       git sparse-checkout set --no-cone --end-of-options "a*" &&
> +       cat .git/info/sparse-checkout >w-eoo &&
> +
> +       test_cmp wo-eoo w-eoo &&
> +
>         git checkout-index --all --ignore-skip-worktree-bits &&
>
>         git ls-files -t >output &&
> diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout=
-builtin.sh
> index f67611da28..e33a6ed1b4 100755
> --- a/t/t1091-sparse-checkout-builtin.sh
> +++ b/t/t1091-sparse-checkout-builtin.sh
> @@ -334,7 +334,7 @@ test_expect_success 'cone mode: set with nested folde=
rs' '
>
>  test_expect_success 'cone mode: add independent path' '
>         git -C repo sparse-checkout set deep/deeper1 &&
> -       git -C repo sparse-checkout add folder1 &&
> +       git -C repo sparse-checkout add --end-of-options folder1 &&
>         cat >expect <<-\EOF &&
>         /*
>         !/*/
> --
> 2.43.0-174-g055bb6e996

I've got a counter-proposal for this patch at
https://lore.kernel.org/git/pull.1625.git.git.1703379611749.gitgitgadget@gm=
ail.com/,
based on further thread discussion over at
https://lore.kernel.org/git/CABPp-BF9XZeESHdxdcZ91Vsn5tKqQ6_3tC11e7t9vTFp=
=3Duufbg@mail.gmail.com/.
