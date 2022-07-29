Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C47C9C00144
	for <git@archiver.kernel.org>; Fri, 29 Jul 2022 22:09:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239214AbiG2WJk (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Jul 2022 18:09:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230089AbiG2WJj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Jul 2022 18:09:39 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A99078BABC
        for <git@vger.kernel.org>; Fri, 29 Jul 2022 15:09:38 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id nu8-20020a17090b1b0800b001f3244a8489so2591699pjb.4
        for <git@vger.kernel.org>; Fri, 29 Jul 2022 15:09:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:from:to:cc;
        bh=tbankgoyRFKUU+WiVF6UeELM41v3HNrbVoYEYWiwYk0=;
        b=WclPjjbGDCWH2Y1gmgMgJu0kZS9zCPoy7NyXCP5YWSQsFV9jEdWNAOZcWkqldniQEO
         SwCS9qgM2Gx8GtAJLgHYEx7pJ+0bdYUYbzEOa3ySf68NQnG8mV9NrekIustK1R7e0mEx
         r08Lb3aThbSGjNE9eAQIFDRYDtAvwJqpQR1QLcaPQNM7AiqSJQy/Tnh4nYV+dhDt+ldK
         EPKxH83R/0V8vTJkFwar3FZ3AFtOQTXTyQorVmwO7TfNTD8JzyihAZq2P6yxRUeOMVhV
         5vmHA3nsbBv5p1tult7w7tPQm8PGPSC/N6wK9zQaST+AgV9moG+cJe5vkBYxoyeb7ljg
         gYuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:x-gm-message-state:from:to
         :cc;
        bh=tbankgoyRFKUU+WiVF6UeELM41v3HNrbVoYEYWiwYk0=;
        b=C31quys9u/wU6soYXe5qZqsFYcgfE5mfs6XNPZo16h1kUaPuz+O/jgR9HqlvrDk6Eb
         Lk4KlkGfHo6LyeLXGsbazQNBNgeQipqwDM+d9Gmbg2UQzriXTi+l65QJoHKkowUpsWtB
         vxHldZgCgwU3JIP9/XgNpOI97HIa05IrMUQrcvlyj6Xn30osucljxjHSgr+xWWsVvTn9
         COae3xOATfqMNUhKPJNPEJEC5x13PC+XLFJvX+T1NiHKRkEbNLa+WtLGDvDD9ja8YJD6
         MK0qKfJLnKbiI5+rmAy6h/G57E4f31zJ4gYJQm4ZBmNLCIyCR8JirH8gZcBnOByyaihY
         Qv9A==
X-Gm-Message-State: ACgBeo2pOMOcxZMrHhb4n8Tbyt0dJyVLaCefcEFM92ACUS+Us0i4rYxU
        6RLZpwA2kZ7xEeCFUssG03mwx0ipNUfzNQ==
X-Google-Smtp-Source: AA6agR6OW7/ARyETYL32giGz2QvtrbSyKD+qGzZdcg5fJ84HjvpRKOM5uHEZ/snjKzVpAbCfrPgRSOW9WaV8yg==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:90b:3506:b0:1f0:81a:6477 with SMTP id
 ls6-20020a17090b350600b001f0081a6477mr7029822pjb.46.1659132578245; Fri, 29
 Jul 2022 15:09:38 -0700 (PDT)
Date:   Fri, 29 Jul 2022 15:09:36 -0700
In-Reply-To: <patch-14.20-b364f3200d8-20220728T161116Z-avarab@gmail.com>
Message-Id: <kl6lmtcrr2ov.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <cover-00.20-00000000000-20220728T161116Z-avarab@gmail.com> <patch-14.20-b364f3200d8-20220728T161116Z-avarab@gmail.com>
Subject: Re: [PATCH 14/20] submodule--helper: pass a "const struct
 module_clone_data" to clone_submodule()
From:   Glen Choo <chooglen@google.com>
To:     "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>,
        "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> Add "const" to the "struct module_clone_data" that we pass to
> clone_submodule(), which makes the ownership clear, and stops us from
> clobbering the "clone_data->path".
>
> We still need to add to the "reference" member, which is a "struct
> string_list". Let's do this by having clone_submodule() create its
> own, and copy the contents over, allowing us to pass it as a
> separate parameter.

I can't help but think that this would be easier to review as part of
the leaks series since:

- Outside of leaks, I don't think we really care about ownership (though
  please please correct me if I'm off base).

- The ownership of "reference" is still quite messy (downstream code
  might append to it, but its members are sometimes free()-able and
  sometimes not), so it's hard to visualize what we're getting out of
  this change without seeing the corresponding leak fix.

and...

> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> index 6cedcc5b239..e235acce985 100644
> --- a/builtin/submodule--helper.c
> +++ b/builtin/submodule--helper.c
> @@ -1569,18 +1567,20 @@ static char *clone_submodule_sm_gitdir(const char=
 *name)
>  	return sm_gitdir;
>  }
> =20
> -static int clone_submodule(struct module_clone_data *clone_data)
> +static int clone_submodule(const struct module_clone_data *clone_data,
> +			   struct string_list *reference)
>  {
>  	char *p;
>  	char *sm_gitdir =3D clone_submodule_sm_gitdir(clone_data->name);
>  	char *sm_alternate =3D NULL, *error_strategy =3D NULL;
>  	struct child_process cp =3D CHILD_PROCESS_INIT;
> +	const char *clone_data_path;
> =20
>  	if (!is_absolute_path(clone_data->path))
> -		clone_data->path =3D xstrfmt("%s/%s", get_git_work_tree(),
> -					   clone_data->path);
> +		clone_data_path =3D xstrfmt("%s/%s", get_git_work_tree(),
> +					  clone_data->path);

- (this is pretty minor) It feels weird to see that we're intentionally
  leaking clone_data_path at its inception. We aren't introducing any
  new leaks, but moving this to the leaks series makes it clearer that
  we eventually do the right thing.
