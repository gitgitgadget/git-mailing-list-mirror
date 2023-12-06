Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HPzFJJOn"
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFA1CD68
	for <git@vger.kernel.org>; Wed,  6 Dec 2023 13:11:03 -0800 (PST)
Received: by mail-oi1-x22c.google.com with SMTP id 5614622812f47-3b88c29a995so213686b6e.0
        for <git@vger.kernel.org>; Wed, 06 Dec 2023 13:11:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701897063; x=1702501863; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=srQvR3LZZn1FoQw75JgeSeC8QaxLz4r+0A6EBK+Xyqo=;
        b=HPzFJJOnQniG7WdOlExl55u9TPq0oo45taTO3PR1G2vTrD1SVft0FImaeIGynenU6C
         iwe7VriF4WrWnI0T0kXydqTv8w4sJrSu2tr8dpJZpDQhL9gqNnPXM0QixLcSgVTtS9dp
         BDsgqWqlkNi6qMSQNfphja4olvUHRcfCT8FAKOX4n6SI49orvQh0EV/EfK2CTjZUG/Ky
         7bWFyxcZAVkS5+JX4+YEB41tG6xRkEotPwBzjKVqAtKqjA+60VvlpxzdQYtMnLQivuQC
         8lh3148waXMEltDehJbvJUHfTuoCyXFxed4bWU7nGvtOKPD3sbcxkiJb/J8OuA5CmNMo
         eJsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701897063; x=1702501863;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=srQvR3LZZn1FoQw75JgeSeC8QaxLz4r+0A6EBK+Xyqo=;
        b=hg0P/s2020m7kgPUG3+6AalGvvSzTRW4IQ4naQrbzeq81JdvvWTKDIXkNSq8JeO5cL
         TqKQxSh8PwpcV3T1UrJiqp9fS94sBIM5hT0Lr+3hq5S9ouQFfVZ4Mc3aSE1DjmYaGUfa
         t0bwXnIPxkp/paYxMvY2kRUt2YtEmXmBmUYbffqb7tvRQXH7tRNf4ZaHytCrlCYgEe50
         UO0weUnEnFSTnafl641JPeHu3wP8xt2cdMTO7P36s3HIQgx4WOYThswFCQoeJJtJvvD0
         k9LL4UMgNggMlNK4PXZzp54VTn+Q3TdIWA5Gn/nG6iuwaFlB2RE+WrbmOKZIoejgBPF+
         4arg==
X-Gm-Message-State: AOJu0YxNH4mklD08SvtBjhpZu6NL7epZ4amtzg9SfckieuabCxKNPl4B
	+jVLCj3ZY+WztA8HnIwpWavlxZ822SykkVzlpL/DxvyYYVrRYQ==
X-Google-Smtp-Source: AGHT+IHub5zq7xiOXrwQDngJvR1EWywjhVYIhRSu8KFvYku6jVVN93t1xOKs1uvA3qraFYchn31iY31eMpyCtF24Fvo=
X-Received: by 2002:a05:6870:b152:b0:1fb:dea:4803 with SMTP id
 a18-20020a056870b15200b001fb0dea4803mr1468118oal.115.1701897063096; Wed, 06
 Dec 2023 13:11:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1701863960.git.ps@pks.im> <b69c57d27269c9b40c9e4394861dffd8a8b9860c.1701863960.git.ps@pks.im>
In-Reply-To: <b69c57d27269c9b40c9e4394861dffd8a8b9860c.1701863960.git.ps@pks.im>
From: Karthik Nayak <karthik.188@gmail.com>
Date: Wed, 6 Dec 2023 22:10:37 +0100
Message-ID: <CAOLa=ZSZztJUF9nmSzGdOW0oWBRUp2sw8QyuZO_q06cNymad3Q@mail.gmail.com>
Subject: Re: [PATCH 1/7] setup: extract function to create the refdb
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 6, 2023 at 1:40=E2=80=AFPM Patrick Steinhardt <ps@pks.im> wrote=
:
> +static void create_reference_database(const char *initial_branch, int qu=
iet)
> +{
> +       struct strbuf err =3D STRBUF_INIT;
> +       int reinit =3D is_reinit();
> +
> +       /*
> +        * We need to create a "refs" dir in any case so that older
> +        * versions of git can tell that this is a repository.
> +        */

How does this work though, even if an earlier version of git can tell
that this is a repository,
it still won't be able to read the reftable backend. In that sense,
what do we achieve here?

> +       safe_create_dir(git_path("refs"), 1);
> +       adjust_shared_perm(git_path("refs"));
> +

Not related to your commit per se, but we ignore the return value
here, shouldn't we die in this case?
