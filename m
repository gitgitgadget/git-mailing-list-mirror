Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BAC5C4338F
	for <git@archiver.kernel.org>; Fri,  6 Aug 2021 06:29:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B4B561164
	for <git@archiver.kernel.org>; Fri,  6 Aug 2021 06:29:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243330AbhHFGaE (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Aug 2021 02:30:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbhHFGaE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Aug 2021 02:30:04 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0433C061798
        for <git@vger.kernel.org>; Thu,  5 Aug 2021 23:29:47 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id mz5-20020a17090b3785b0290176ecf64922so20902668pjb.3
        for <git@vger.kernel.org>; Thu, 05 Aug 2021 23:29:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=references:user-agent:from:to:cc:subject:in-reply-to:message-id
         :date:mime-version:content-transfer-encoding;
        bh=xITfJHWsZ7eEVr1h5VDkb+BmAvNFDr4dy/MX96i2IkI=;
        b=E6pLxHpKMUTR4uAB9s6FFJy/OYvjea2aHosZj6gl30vbyrFdAieHqGHgBKBxWG2tbv
         E6TvYVrqX5xcCWlljaDkczVlK1hvzabIJMuKtwV+14O66nmJkvDzPiR6qyOYmgBuhG9p
         Eh53GVhu0VP004dZuYO/hmvPgMx9Qncpx7mYQC4xmUJn7zcg1NHxeV9Ry2Xfqa4C6u2S
         Vb2xM1uNVZ4KYeQa5P6ZU9DR8t/GwPjBnDP3CpmrV8sXwMSYb+PPVDFqvSFV8c+D2HtM
         dBSW1yiFmGIzXzDgE93Ow5SznhobocT8naWz6NPTD7nKKgOZ0qbwRm88fPjymX63hcSx
         SN1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:message-id:date:mime-version:content-transfer-encoding;
        bh=xITfJHWsZ7eEVr1h5VDkb+BmAvNFDr4dy/MX96i2IkI=;
        b=VdJ/8nSIYwQaUzxraFJFs0LRtyh3GwsXu3RuPjYhLaK9i1OHT5hWjuBbkwY0wptGno
         5nbDfKK2OF6gUe6NMjktY31B6SHAcdtqRslG/WaqMtoULUSTrg24gwsDA6dRW97G+baJ
         2/0x25s854zxlV9bw/IARQw/oo2N8xts37U7vGowZ303ygb39f3Efb1LAA+kpPciAR66
         LBLsNBPsgGNfKvRNhNkWkWMIn6+fi3NghqZlj/p1wsspy0FHs98FtN/mdjWD8SUPVpD2
         N6JEQvLG6Ze124eDYoygVTyS1WIT3WgVmg5QoA2Qr9RcG0eRZdi/1+KinXdTzyn89pG3
         fIOw==
X-Gm-Message-State: AOAM53333/0C0r5EQ/MpxIyn678ul1n4TSVey45I5bGbL/kgxPX0QLAx
        E7Zmg9UCI3By2rg+U1XMYzM=
X-Google-Smtp-Source: ABdhPJzsmIV4o4pC+A4F/qlLzvIA/7yk4vRT4Pa+3bC8sV171znomyFk9UJfymx1whfVhFxzdTyWZg==
X-Received: by 2002:a62:794e:0:b029:3c5:a678:efff with SMTP id u75-20020a62794e0000b02903c5a678efffmr9259113pfc.11.1628231387381;
        Thu, 05 Aug 2021 23:29:47 -0700 (PDT)
Received: from atharva-on-air ([119.82.121.47])
        by smtp.gmail.com with ESMTPSA id 186sm9145526pfg.11.2021.08.05.23.29.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Aug 2021 23:29:47 -0700 (PDT)
References: <20210710074801.19917-5-raykar.ath@gmail.com>
 <20210805192803.679948-1-kaartic.sivaraam@gmail.com>
User-agent: mu4e 1.4.15; emacs 27.2
From:   Atharva Raykar <raykar.ath@gmail.com>
To:     Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        Christian Couder <christian.couder@gmail.com>,
        Shourya Shukla <periperidip@gmail.com>
Subject: Re: [PATCH] submodule--helper: fix incorrect newlines in an error
 message
In-reply-to: <20210805192803.679948-1-kaartic.sivaraam@gmail.com>
Message-ID: <m28s1fuluy.fsf@gmail.com>
Date:   Fri, 06 Aug 2021 11:59:41 +0530
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Kaartic Sivaraam <kaartic.sivaraam@gmail.com> writes:

> A refactoring[1] done as part of the recent conversion of
> 'git submodule add' to builtin, changed the error message
> shown when a Git directory already exists locally for a submodule
> name. Before the refactoring, the error used to appear like so:
>
> [...]
>
> As one could observe the remote information is printed along with the
> first line rather than on its own line. Also, there's an additional
> newline following output.
>
> Make the error message consistent with the error message that used to be
> printed before the refactoring.

Thanks for catching this and sending a patch!

> [1]: https://lore.kernel.org/git/20210710074801.19917-5-raykar.ath@gmail.=
com/#t
>
> Signed-off-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
> ---
>
> Even with this patch, the error message is still not fully consistent wit=
h the one that
> used to be printed before the refactoring. Here's the diff:
>
> 3c3
> < If you want to reuse this local git directory instead of cloning again =
from
> ---
>> fatal: If you want to reuse this local git directory instead of cloning =
again from
> 6c6
> < or you are unsure what this means choose another name with the '--name'=
 option.
> ---
>> or if you are unsure what this means, choose another name with the '--na=
me' option.
>
>
> The first part shows that it is additionally prefixed with 'fatal: '. Whi=
le the 'fatal :' prefix
> made sense in other cases, I wonder if it's helpful in this case as the m=
essage being
> printed is an informative one. Should we avoid using 'die' to print this =
message?

I had initially implemented that message as an fprintf() with return for
the same reason, but Junio suggested we die() instead to keep the
conversion more faithful to the original [1].

Although now that I think of it, it feels like a tradeoff between
faithfulness to the original code and faithfulness to the original
behaviour. I also think this change is fairly inconsequential and easily
reversible so I am fine with it being done either way.

[1] https://lore.kernel.org/git/xmqqk0n03k84.fsf@gitster.g/

> The second part of the diff shows that there's some small grammatcial twe=
aks in the last
> line. While I appreciate the intention, I'm not very sure if this change =
is a strict
> improvement. I wonder about this as the original sounded good enough to m=
e and thus it
> feels like the change in message is triggering unnecesssary translation w=
ork. Should
> we avoid the change? Or does it actually seem like an improvement to the =
message?

I don't think that extra 'if' was intended. I think it's better to avoid
the change I inadvertently introduced.

> builtin/submodule--helper.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> index 3cbde305f3..560be07091 100644
> --- a/builtin/submodule--helper.c
> +++ b/builtin/submodule--helper.c
> @@ -2824,7 +2824,7 @@ static int add_submodule(const struct add_data *add=
_data)
>  		if (is_directory(submod_gitdir_path)) {
>  			if (!add_data->force) {
>  				fprintf(stderr, _("A git directory for '%s' is found "
> -						  "locally with remote(s):"),
> +						  "locally with remote(s):\n"),
>  					add_data->sm_name);
>  				show_fetch_remotes(stderr, add_data->sm_name,
>  						   submod_gitdir_path);
> @@ -2835,7 +2835,7 @@ static int add_submodule(const struct add_data *add=
_data)
>  				      "use the '--force' option. If the local git "
>  				      "directory is not the correct repo\n"
>  				      "or if you are unsure what this means, choose "
> -				      "another name with the '--name' option.\n"),
> +				      "another name with the '--name' option."),
>  				    add_data->realrepo);
>  			} else {
>  				printf(_("Reactivating local git directory for "


---
Atharva Raykar
=E0=B2=85=E0=B2=A5=E0=B2=B0=E0=B3=8D=E0=B2=B5 =E0=B2=B0=E0=B2=BE=E0=B2=AF=
=E0=B3=8D=E0=B2=95=E0=B2=B0=E0=B3=8D
=E0=A4=85=E0=A4=A5=E0=A4=B0=E0=A5=8D=E0=A4=B5 =E0=A4=B0=E0=A4=BE=E0=A4=AF=
=E0=A4=95=E0=A4=B0
