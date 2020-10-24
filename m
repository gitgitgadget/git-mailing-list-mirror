Return-Path: <SRS0=1Io1=D7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02E0EC2D0A3
	for <git@archiver.kernel.org>; Sat, 24 Oct 2020 23:44:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AAB5422246
	for <git@archiver.kernel.org>; Sat, 24 Oct 2020 23:44:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q4ZnKggE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1762942AbgJXXlX (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 24 Oct 2020 19:41:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731864AbgJXXlX (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Oct 2020 19:41:23 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C66FFC0613CE
        for <git@vger.kernel.org>; Sat, 24 Oct 2020 16:41:22 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id 23so5755578ljv.7
        for <git@vger.kernel.org>; Sat, 24 Oct 2020 16:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=t5i16+lViWtP83m7jDDORGdJ+VYHxGtT4GeovMfwmoU=;
        b=q4ZnKggEGVApy7XWz6/9FcUJ5u/F80P5aOllB2zNZ0ndlGZ9GDW++yoTLDcA+9KohK
         n7dMt+Dj4fHTK2o5/kcflyzSz6v35FI4ML39Ct6COay3dAK31qUbAhvSbubZ0iQzSNIx
         cA7ar0B3Vn1JTRiFlxgKSWbEzqrJGJTI9hvC9I2vr6OEohU2z5HVhYG9u4OX03cL6Ztb
         OqS3h4sl0sishrrQuojYPfXHnHAi3CkNPMAj0n2udPU/BiGlmO8PCz1MRfbCC1cf4sox
         TxSCX/12UyzamG+jaG533joxmUy8DcND+oY5wpbH8xaJHxR2roAR/tRMaSWfM1PsJ7nE
         w6lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=t5i16+lViWtP83m7jDDORGdJ+VYHxGtT4GeovMfwmoU=;
        b=mo3s+mH7eaEiYwkCWVhtwZil8DhRGS9xphijgFw6Ksb++V0L3IQvGZOonIH4HxkOwf
         1ITevE1+6Z9x0feb41C9g3/5vfW4QFNO0dzTIe7n443TfnXrZmyJ0wy7bYFK2PDcBaQ8
         zmMuFa/5FtLXpleUwPAfVVdelAoLUmZsATISsuSHPTr9LKUcims73IrSzI6Lwvyemmmk
         /JqeGBg0HoNT405J7rWCdwJXs9XdblwM3Ttz5VEM8ALCnWcfC7dmBDx9kkXUgr8Rjh1N
         YjiAazxmemapgc4MDn7SEPbZWBkkmtvYNx4mRVSE77RtEA06FpQxhyFBRqJj4lXmwJqL
         Mdgg==
X-Gm-Message-State: AOAM531B+jidl6je1Bz/5J6DTUUXusejQUb5F0JwfYJ0AsPcoRzHnKRr
        wRKJDvP0fbSLDcSZEIHeopo=
X-Google-Smtp-Source: ABdhPJzYBiZn9WdtSM086Z0EpKAKD9TxymvgyspNVrytPd02z5t0TOPrj0fWbblJOuuYOeJfseYTTQ==
X-Received: by 2002:a2e:2ac6:: with SMTP id q189mr3031131ljq.269.1603582881155;
        Sat, 24 Oct 2020 16:41:21 -0700 (PDT)
Received: from LAPTOP-ACER-ASPIRE-F5 (host-89-229-7-83.dynamic.mm.pl. [89.229.7.83])
        by smtp.gmail.com with ESMTPSA id t10sm640341ljk.53.2020.10.24.16.41.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2020 16:41:20 -0700 (PDT)
From:   Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>
To:     "Abhishek Kumar via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Abhishek Kumar <abhishekkumar8222@gmail.com>
Subject: Re: [PATCH v4 02/10] revision: parse parent in indegree_walk_step()
References: <pull.676.v3.git.1597509583.gitgitgadget@gmail.com>
        <pull.676.v4.git.1602079785.gitgitgadget@gmail.com>
        <4470d916428a28bb8277dfc4c3da84e08110e88e.1602079786.git.gitgitgadget@gmail.com>
Date:   Sun, 25 Oct 2020 01:41:19 +0200
In-Reply-To: <4470d916428a28bb8277dfc4c3da84e08110e88e.1602079786.git.gitgitgadget@gmail.com>
        (Abhishek Kumar via GitGitGadget's message of "Wed, 07 Oct 2020 14:09:37
        +0000")
Message-ID: <85o8kr42g0.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (windows-nt)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Abhishek Kumar via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Abhishek Kumar <abhishekkumar8222@gmail.com>
>
> In indegree_walk_step(), we add unvisited parents to the indegree queue.
> However, parents are not guaranteed to be parsed. As the indegree queue
> sorts by generation number, let's parse parents before inserting them to
> ensure the correct priority order.

All right, we need to ensure the parent commit is parsed to know its
generation number, to insert in into priority queue in a correct order.

>
> Signed-off-by: Abhishek Kumar <abhishekkumar8222@gmail.com>

Looks good.

> ---
>  revision.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/revision.c b/revision.c
> index aa62212040..c97abcdde1 100644
> --- a/revision.c
> +++ b/revision.c
> @@ -3381,6 +3381,9 @@ static void indegree_walk_step(struct rev_info *rev=
s)
>  		struct commit *parent =3D p->item;
>  		int *pi =3D indegree_slab_at(&info->indegree, parent);
>=20=20
> +		if (repo_parse_commit_gently(revs->repo, parent, 1) < 0)
> +			return;
> +
>  		if (*pi)
>  			(*pi)++;
>  		else

Best,
--=20
Jakub Nar=C4=99bski
