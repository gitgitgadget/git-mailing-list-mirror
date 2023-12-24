Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F34AB111A
	for <git@vger.kernel.org>; Sun, 24 Dec 2023 07:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PqR/dzS0"
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-50e67e37661so2322251e87.0
        for <git@vger.kernel.org>; Sat, 23 Dec 2023 23:51:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703404290; x=1704009090; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=flVkesae/MhD3DTzRmMDiwgl+tSoE8yRNpLCjq0mYek=;
        b=PqR/dzS0tN4Sl6UE696h4TzTg5GPFyn9QzleE7jpvnZof3Pwzl7IqsFIcSY0bbiDAr
         xqWhwOHetR3EcF9HT+fGNRVS/CCH3YiMc4k14d+YD1AVZBKFq8h9PuRgckd1y662wVqQ
         4/HvVKeIpasXa3KURtBDCpvG07Gm98LxcQR1iJIh+4mb8VSEKv7HZLB7xtL+4TBu065t
         X+RFdS8OAABjjk1UofWT6QDL4XSHpA6ignXqSFL3ktcxXrPEJi4NcMNzke7GvDGlkCaK
         vhwvvSu8tAzipOyoj6qtmndnf4Z7+/xkgMXlHCQ3MObNX98t9r3hpTP0Y5GRLxb10lPX
         7dRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703404290; x=1704009090;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=flVkesae/MhD3DTzRmMDiwgl+tSoE8yRNpLCjq0mYek=;
        b=sOCzl2aCx9A0fpMeufvgTdOL4c96+RyzxhZ3eWvpu0vuGTZ06/GpJhIdAS2vg1NHtJ
         32KorpyW48aKCW/KtFW90EOE/LYvjVKHl+3JnbFg4gxquujG9sSqBnTE1X6uxkKoIm+g
         CnouR68DoupqXoA3LPnEP20e+KJ2jy/yNNNMTAhXTd7uNnX7qBMRmyQgcSNZilkDQlHm
         v9G7mhh/xsm0OzZHvu92FMv1wckqJMZAeJMGUJpfS/R5DBd3EI4CfD8tPDJUwDOimKgS
         Fvb98qfLnMPHKdJZCJBtu1TGHthY/eLqx0QcOj9MG1H9Bst9ycAQcVpRrM9t7obux7k8
         BMkg==
X-Gm-Message-State: AOJu0YymFRrroYMOpFRDpQMJIDyOwvtoh9+e2yOkyYzwRw1x5d+eM6iP
	D/oDn3gE9bxlTDuWmcJcdomtyjVyE+KOrgtzxM0tIlpo
X-Google-Smtp-Source: AGHT+IG/Zzfc/CTr/59yx/R6is6P6PdFX1OQDua8fJs+nu55eclEe0iNJ4Z1FYHu4yiW5FJscNXc+XCbukqri9RzF4A=
X-Received: by 2002:a05:6512:2399:b0:50e:6d0f:c1d4 with SMTP id
 c25-20020a056512239900b0050e6d0fc1d4mr1698630lfv.26.1703404289731; Sat, 23
 Dec 2023 23:51:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231221065925.3234048-1-gitster@pobox.com> <20231221065925.3234048-3-gitster@pobox.com>
In-Reply-To: <20231221065925.3234048-3-gitster@pobox.com>
From: Elijah Newren <newren@gmail.com>
Date: Sat, 23 Dec 2023 23:51:19 -0800
Message-ID: <CABPp-BF3Vqq8Y8+2pQyO7-StUVPR3as+Q_aL+o92ydoJY-8zEw@mail.gmail.com>
Subject: Re: [PATCH 2/3] sparse-checkout: use default patterns for 'set' only !stdin
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 20, 2023 at 10:59=E2=80=AFPM Junio C Hamano <gitster@pobox.com>=
 wrote:
>
> "git sparse-checkout set ---no-cone" uses default patterns when none
> is given from the command line, but it should do so ONLY when
> --stdin is not being used.  Right now, add_patterns_from_input()
> called when reading from the standard input is sloppy and does not
> check if there are extra command line parameters that the command
> will silently ignore, but that will change soon and not setting this
> unnecessary and unused default patterns start to matter when it gets
> fixed.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  * This came from f2e3a218 (sparse-checkout: enable `set` to
>    initialize sparse-checkout mode, 2021-12-14) by Elijah.
>
>  builtin/sparse-checkout.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
> index 8f55127202..04ae81fce8 100644
> --- a/builtin/sparse-checkout.c
> +++ b/builtin/sparse-checkout.c
> @@ -837,7 +837,7 @@ static int sparse_checkout_set(int argc, const char *=
*argv, const char *prefix)
>          * non-cone mode, if nothing is specified, manually select just t=
he
>          * top-level directory (much as 'init' would do).
>          */
> -       if (!core_sparse_checkout_cone && argc =3D=3D 0) {
> +       if (!core_sparse_checkout_cone && !set_opts.use_stdin && argc =3D=
=3D 0) {
>                 argv =3D default_patterns;
>                 argc =3D default_patterns_nr;
>         } else {
> --
> 2.43.0-174-g055bb6e996

Thanks for catching this; the fix looks good to me.
