Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC916C125
	for <git@vger.kernel.org>; Sun,  6 Oct 2024 18:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728238597; cv=none; b=pPbAbEbevgSPvmlXaedgUVm0G8+zl+1uZVoN6PHMvsaCdWGPQ44JgRnIUdYWeJG1c6uj2vJCXv/rz063c7eEJY3W51Uz/264WTEjSc1t2kFCaBgD5d4mi11gjuRLdASDjfBZAg0nsQykPoNdFwof2Bg7xlq9HlOPQSeiZrAunM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728238597; c=relaxed/simple;
	bh=SgAfO6BWUC8N6P3+EeT/DFgAGWzLUmLHaEDZwBPO8W4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C5JQFD15L1QKtR7eElcMqfa+w/w/09GZWPF7s1ieEgRymz5mt5ClAYVEeARu1YLqqwJ6HRkcMIiXtVmcJHVb60j1RafO6F3JB1I5Y9yqhjpvINpgaHW1t6X/6xwrz0Fqs7XlBQ4k3k0K6GQuSMGz9gUsNq+tH/7RIMtf4HnJzxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6cb21f041c8so3882726d6.3
        for <git@vger.kernel.org>; Sun, 06 Oct 2024 11:16:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728238593; x=1728843393;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LwwOumIKaEDUMhRdJC2uL9aZnumRYF1b/7sKuPonGds=;
        b=Pv0gISJy7OaT3UDbvxEOjDODgrI0UteDTDDy5rF+ShMMWZRJ4Pj5UAE+fO2OlYEKLD
         ViWrn7vaWlMmOwwZlXfGe+Lt4zR2xrSPHJVVOjxKiyx5hhvqQxXG2eUqWMfVjEYpDvQK
         P7tYNVcScJuJqxbSankOhgGJ9pUn8VoDJ4L/tuMXQ9bb3srek/ZV2zhP/AAtppcWxPO2
         60RbKLrqGBp+rGDp2foaomyIrQkUIxTzX6q+USLWv2gzmg/VYjhdyHqeIQcDZsWa0uCa
         CJ/8Bvo/GWOUYm6IaeAB2W9F8ofKFexE5Rl/ZIaRn4VH42u675X5mbbhMFP6d9ehw1Xz
         Gvug==
X-Gm-Message-State: AOJu0Yyhgkqr4/cj/mBS/fEp4paqkNqCsTGy8DgyBU3AInn6lIsPXEcG
	Wna8uBG25XKCoZWSCRfIEiM4m5k5fZkN4vO9Y5DRbIqEa6hWIL/76uO8dJprcrSXSKLaOVP7IPi
	R1vGkp8njzSa2IaKLYkOtmPHRfWM=
X-Google-Smtp-Source: AGHT+IEW43fhSrEVZsve9q6WP20rlwwppyrQ0bzUr50BjMFWuHiHYMU2hm1trzd8fJ9aLK/amwjj3yFQLWprdbLU4hs=
X-Received: by 2002:a05:6214:1c48:b0:6cb:6140:f490 with SMTP id
 6a1803df08f44-6cb9a45437cmr65911186d6.8.1728238593519; Sun, 06 Oct 2024
 11:16:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241006060017.171788-1-cdwhite3@pm.me> <20241006060017.171788-2-cdwhite3@pm.me>
In-Reply-To: <20241006060017.171788-2-cdwhite3@pm.me>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Sun, 6 Oct 2024 14:16:22 -0400
Message-ID: <CAPig+cSe0ykN=Mmb8Nwp112ROOCuhzzP0jofvL91PsVi8W4dHg@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] worktree: refactor infer_backlink() to use *strbuf
To: Caleb White <cdwhite3@pm.me>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 6, 2024 at 2:01=E2=80=AFAM Caleb White <cdwhite3@pm.me> wrote:
> This refactors the `infer_backlink` function to return an integer
> result and use a pre-allocated `strbuf` for the inferred backlink
> path, replacing the previous `char*` return type.
>
> This lays the groundwork for the next patch, which needs the
> resultant backlink as a `strbuf`. There was no need to go from
> `strbuf -> char* -> strbuf` again. This change also aligns the
> function's signature with other `strbuf`-based functions.

Regarding aligning the signature with other strbuf-based functions...

> Signed-off-by: Caleb White <cdwhite3@pm.me>
> ---
> diff --git a/worktree.c b/worktree.c
> @@ -642,10 +642,9 @@ static int is_main_worktree_path(const char *path)
> -static char *infer_backlink(const char *gitfile)
> +static int infer_backlink(struct strbuf *inferred, const char *gitfile)

... it's subjective, but I find that placing the strbuf as the first
argument makes the purpose of the function less clear. The direct
purpose of all (or the majority of) functions in strbuf.h is to
operate on strbufs, thus it makes sense for the strbuf to be the first
argument (just like `this` is the invisible first argument of instance
methods in C++ which operate on an instance of the class). However,
infer_backlink()'s purpose isn't to operate on a strbuf; the fact that
the original signature neither accepted nor returned a strbuf bears
that out. The really important input to this function is `gitfile`,
thus it makes sense for this argument to come first. The strbuf which
this patch makes it use is a mere implementation detail (a
micro-optimization) which doesn't otherwise change the function's
original purpose, thus it belongs in a less prominent position in the
argument list.

> @@ -658,17 +657,16 @@ static char *infer_backlink(const char *gitfile)
> -       strbuf_git_common_path(&inferred, the_repository, "worktrees/%s",=
 id);
> -       if (!is_directory(inferred.buf))
> +       strbuf_git_common_path(inferred, the_repository, "worktrees/%s", =
id);
> +       if (!is_directory(inferred->buf))
>                 goto error;
>         strbuf_release(&actual);
> -       return strbuf_detach(&inferred, NULL);
> +       return 0;

On success, we now return zero...

>  error:
>         strbuf_release(&actual);
> -       strbuf_release(&inferred);
> -       return NULL;
> +       return 1;

... and on failure we return 1. To avoid confusing readers who are
familiar with project idioms, it would probably be better to instead
follow the convention used in most of the rest of the project (and in
Unix system calls in general) of returning -1.

However...

> @@ -698,21 +697,23 @@ void repair_worktree_at_path(const char *path,
> -               if (!(backlink =3D infer_backlink(realdotgit.buf))) {
> +               if (infer_backlink(&backlink, realdotgit.buf)) {
>                         fn(1, realdotgit.buf, _("unable to locate reposit=
ory; .git file does not reference a repository"), cb_data);
>                         goto done;
>                 }

... this code now becomes more than a little confusing to read. It
says "if infer_backlink then signal error", which sounds rather
backward and leaves the reader scratching his or her head. ("Why
signal error if the function succeeded?"). Hence, infer_backlink()
should probably return 1 on success and 0 on failure, which will make
this code read more idiomatically:

    if (!infer_backlink(realdotgit.buf, &backlink)) {
        ...signal error...
