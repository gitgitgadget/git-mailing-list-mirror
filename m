Return-Path: <SRS0=3Zv9=35=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 944C5C35250
	for <git@archiver.kernel.org>; Sun,  9 Feb 2020 12:40:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 591012080C
	for <git@archiver.kernel.org>; Sun,  9 Feb 2020 12:40:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="by79SfW+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727654AbgBIMjv (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 9 Feb 2020 07:39:51 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:43168 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727473AbgBIMjv (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Feb 2020 07:39:51 -0500
Received: by mail-lj1-f195.google.com with SMTP id a13so4010779ljm.10
        for <git@vger.kernel.org>; Sun, 09 Feb 2020 04:39:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=j5HLCYLaxDu1r7jXBTeUC2KiiGBZUNv5V/2NPOwrdy4=;
        b=by79SfW+KIjIoeobArl94hqhdDm2xAwSVg6s2Liinf0lTWJ7Bvu/TK22gGkxODK5sd
         UYPHWed8FOMCkDPyJ8ExVGwgz8IFuIcf5ofNRnXzL2qXXtaJDBz6VuSZL5CrgtLODmZs
         P3+5Dta77WWYyuCpa9Gfd6jzo5w8653HXvbH0Ljj4CHgvautVJpU9B9/FNcWj25wbhl8
         HRZVVNictemKjIJuOWxie7iJdoeeBrSHJeCmLGkCaRYpW+FUA61HXDpyDvMxD8dmhxMi
         OB4UBkGRQ7aZWu2yz2dhArL3LLAeWsn+AEnCkTCJ0poK85y0ym49BHOd9HzZMrWNKbvV
         CLpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=j5HLCYLaxDu1r7jXBTeUC2KiiGBZUNv5V/2NPOwrdy4=;
        b=iswiHAtUdcdfujYz3tEVYU2uiBHldQtdHhbtRRRVUqrdsoFPlk2EmCzmgM5iUy6HuJ
         cAkeLxWEVofftatZao4k67Wy/eNjU6CUj3M3dkzpzJjik96Z0LDqQ+YVhUVUc8WPxrMw
         Qkqz9ZlWOgSuBQI7anEMJkFJXNFM62Tkhlk6PWb70TU+raRqApOdsLM+n+73ooXu5VdJ
         GDcPk/IE149x1T7iW7lxgVsAdWaXg3zVRs5kLx+ocLJlYsshlW/S+rLChEAsmY/3U0GL
         C7ST8fuR7GGgZhcWX9Qjwy11YCAowoXOa9+8Y5gtLFeXvVkCKRkfXBQg3gMdcMelfCWb
         4Raw==
X-Gm-Message-State: APjAAAWl9gMchivwRDY40pKvr9BRo57CvNx8zdp3zi5a7HdjJlwgK6DB
        WgWkoePmSaMg2WY71Wm/beo=
X-Google-Smtp-Source: APXvYqxw/peP+82O7/i3Ldw7soaWG7mv56hZadH+eCuuZ4gYDwY1vRze4L6RDWmTb2tSk94kuDUowA==
X-Received: by 2002:a2e:2e11:: with SMTP id u17mr5027145lju.117.1581251987468;
        Sun, 09 Feb 2020 04:39:47 -0800 (PST)
Received: from Laptop-Acer-Aspire-F15 (host-89-229-7-83.dynamic.mm.pl. [89.229.7.83])
        by smtp.gmail.com with ESMTPSA id u16sm4560063ljo.22.2020.02.09.04.39.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 09 Feb 2020 04:39:46 -0800 (PST)
From:   Jakub Narebski <jnareb@gmail.com>
To:     "Garima Singh via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, stolee@gmail.com, szeder.dev@gmail.com,
        jonathantanmy@google.com, jeffhost@microsoft.com, me@ttaylorr.com,
        peff@peff.net, garimasigit@gmail.com, christian.couder@gmail.com,
        emilyshaffer@gmail.com, gitster@pobox.com,
        Garima Singh <garima.singh@microsoft.com>
Subject: Re: [PATCH v2 01/11] commit-graph: use MAX_NUM_CHUNKS
References: <pull.497.git.1576879520.gitgitgadget@gmail.com>
        <pull.497.v2.git.1580943390.gitgitgadget@gmail.com>
        <bf6b93878af5be81148614087aee6b4435ef0396.1580943390.git.gitgitgadget@gmail.com>
Date:   Sun, 09 Feb 2020 13:39:41 +0100
In-Reply-To: <bf6b93878af5be81148614087aee6b4435ef0396.1580943390.git.gitgitgadget@gmail.com>
        (Garima Singh via GitGitGadget's message of "Wed, 05 Feb 2020 22:56:20
        +0000")
Message-ID: <8636bkvss2.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (windows-nt)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Garima Singh via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Garima Singh <garima.singh@microsoft.com>
> Subject: Re: [PATCH v2 01/11] commit-graph: use MAX_NUM_CHUNKS
>
> This is a minor cleanup to make it easier to change the
> number of chunks being written to the commit-graph in the future.

Looks good to me...

...with the very minor possible nitpick that the subject probably should
be

  [PATCH v2 01/11] commit-graph: define and use MAX_NUM_CHUNKS

But this is just a bikeshedding.  Feel free to disregard this.

Best,
--=20
Jakub Nar=C4=99bski

> Signed-off-by: Garima Singh <garima.singh@microsoft.com>
> ---
>  commit-graph.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/commit-graph.c b/commit-graph.c
> index b205e65ed1..3c4d411326 100644
> --- a/commit-graph.c
> +++ b/commit-graph.c
> @@ -23,6 +23,7 @@
>  #define GRAPH_CHUNKID_DATA 0x43444154 /* "CDAT" */
>  #define GRAPH_CHUNKID_EXTRAEDGES 0x45444745 /* "EDGE" */
>  #define GRAPH_CHUNKID_BASE 0x42415345 /* "BASE" */
> +#define MAX_NUM_CHUNKS 5
>=20=20
>  #define GRAPH_DATA_WIDTH (the_hash_algo->rawsz + 16)
>=20=20
> @@ -1356,8 +1357,8 @@ static int write_commit_graph_file(struct write_com=
mit_graph_context *ctx)
>  	int fd;
>  	struct hashfile *f;
>  	struct lock_file lk =3D LOCK_INIT;
> -	uint32_t chunk_ids[6];
> -	uint64_t chunk_offsets[6];
> +	uint32_t chunk_ids[MAX_NUM_CHUNKS + 1];
> +	uint64_t chunk_offsets[MAX_NUM_CHUNKS + 1];
>  	const unsigned hashsz =3D the_hash_algo->rawsz;
>  	struct strbuf progress_title =3D STRBUF_INIT;
>  	int num_chunks =3D 3;
