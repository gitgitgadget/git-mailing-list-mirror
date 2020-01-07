Return-Path: <SRS0=IlH6=24=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDAF1C33C8C
	for <git@archiver.kernel.org>; Tue,  7 Jan 2020 12:19:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACE69206F0
	for <git@archiver.kernel.org>; Tue,  7 Jan 2020 12:19:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gH3CwoGa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727658AbgAGMTN (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Jan 2020 07:19:13 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:37462 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727177AbgAGMTN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Jan 2020 07:19:13 -0500
Received: by mail-lj1-f195.google.com with SMTP id o13so43066448ljg.4
        for <git@vger.kernel.org>; Tue, 07 Jan 2020 04:19:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=J+H977QxQxcLCkMsB8naaZ7+lgdj21pVouIlSGiC0aQ=;
        b=gH3CwoGaredrRDWAW9L9lvUQKo4V5A39LXmvA7R/ehMpom+8eJZZfuS00dZd1Zc7t4
         QFDyeH3nCLmh62h2Yktnau0n6ptJ2LbT5xz1EtaFYk8CAEWEv9/90E1s3vGH88cnijAR
         2ejvF1DMXCnv45BX2XpINLsGIBai7soV7bdCoH4RbIwFc4e8aZYqEC76dAaAQ81/SV6+
         3l/adXhWNHH7vsKyPhMqzCwij0F/v0YaKxYZJ9Rb5rvcmh7AeACuJfk+Ey4bs0gpSNZq
         rAd0DDXgE4WGF2hI668ek7N46JEoXbZhdmf3VgJmXSxzcyjsmsepPzo1w6Ja8gBquiEu
         gqvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=J+H977QxQxcLCkMsB8naaZ7+lgdj21pVouIlSGiC0aQ=;
        b=OyR7ZiwMBtKk/zXX7WMIbwcTm1pz+qXgahbvqyTH6M90GzEt2vM+nd+0TJcofuy1lK
         5Jg9IOEpY215KuUlLUQFsd269/duSTrfAAe4tlNz/6qcR9rS3xYt6R7eMxqPh/9SQP/b
         oos97d24aZy01a/EkQ8O8C1cdYZRa7rhIx572/rzb9BzBWDSRHKqRaEsHKlPeOxTauPm
         ZfnWWC+L72Tf18qpC0mO6Xx09F+AwYYu6ZpQQNbZj/O/focr0k0/ss6jcy51n3kUEFkZ
         oxqaZswkhVGvo2co87BzllnIc3f63hjgq8cNO1w+T0wGzXn/BLXA67rItmUCN8bX2dT7
         +iqg==
X-Gm-Message-State: APjAAAWbzCKhIdb56b5aZ82s4Q2mKy6p2vPDUBHxDeAHnszAdvbEbNwc
        csu2GBOxKu+WzByrIOWr72c=
X-Google-Smtp-Source: APXvYqzBlJE/87ss8SsYpT5ZoE88VIJouL4OKARO15LU7yTNnIGE2Zvx7hr+7Opi9hLvpzt0JQNGLA==
X-Received: by 2002:a2e:916:: with SMTP id 22mr60399063ljj.60.1578399551779;
        Tue, 07 Jan 2020 04:19:11 -0800 (PST)
Received: from Laptop-Acer-Aspire-F15 ([158.75.2.130])
        by smtp.gmail.com with ESMTPSA id e21sm36047579lfc.63.2020.01.07.04.19.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 07 Jan 2020 04:19:11 -0800 (PST)
From:   Jakub Narebski <jnareb@gmail.com>
To:     "Garima Singh via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, stolee@gmail.com, szeder.dev@gmail.com,
        jonathantanmy@google.com, jeffhost@microsoft.com, me@ttaylorr.com,
        peff@peff.net, Junio C Hamano <gitster@pobox.com>,
        Garima Singh <garima.singh@microsoft.com>
Subject: Re: [PATCH 3/9] commit-graph: use MAX_NUM_CHUNKS
References: <pull.497.git.1576879520.gitgitgadget@gmail.com>
        <a15f87fdcbea1a37a20a05135832b42f36f682f1.1576879520.git.gitgitgadget@gmail.com>
Date:   Tue, 07 Jan 2020 13:19:06 +0100
In-Reply-To: <a15f87fdcbea1a37a20a05135832b42f36f682f1.1576879520.git.gitgitgadget@gmail.com>
        (Garima Singh via GitGitGadget's message of "Fri, 20 Dec 2019 22:05:14
        +0000")
Message-ID: <865zhnzcg5.fsf@gmail.com>
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
>
> This is a minor cleanup to make it easier to change the
> number of chunks being written to the commit-graph in the future.

Very minor nit: in the whole commit message it is not stated explicitly
what MAX_NUM_CHUNKS is for, though it is very easy to guess (from the
name itself).

>
> Signed-off-by: Garima Singh <garima.singh@microsoft.com>
> ---
>  commit-graph.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/commit-graph.c b/commit-graph.c
> index 61e60ff98a..8c4941eeaa 100644
> --- a/commit-graph.c
> +++ b/commit-graph.c
> @@ -24,6 +24,7 @@
>  #define GRAPH_CHUNKID_DATA 0x43444154 /* "CDAT" */
>  #define GRAPH_CHUNKID_EXTRAEDGES 0x45444745 /* "EDGE" */
>  #define GRAPH_CHUNKID_BASE 0x42415345 /* "BASE" */
> +#define MAX_NUM_CHUNKS 5

Minor nit: MAX_NUM_CHUNKS or MAX_CHUNKS?

>=20=20
>  #define GRAPH_DATA_WIDTH (the_hash_algo->rawsz + 16)
>=20=20
> @@ -1381,8 +1382,8 @@ static int write_commit_graph_file(struct write_com=
mit_graph_context *ctx)
>  	int fd;
>  	struct hashfile *f;
>  	struct lock_file lk =3D LOCK_INIT;
> -	uint32_t chunk_ids[6];
> -	uint64_t chunk_offsets[6];
> +	uint32_t chunk_ids[MAX_NUM_CHUNKS + 1];
> +	uint64_t chunk_offsets[MAX_NUM_CHUNKS + 1];

Looks good.  I guess we won't ever have more chunks than 5:
OIDF, OIDL, CDAT, EDGE, BASE (and they cannot repeat, and last two are
optional).

>  	const unsigned hashsz =3D the_hash_algo->rawsz;
>  	struct strbuf progress_title =3D STRBUF_INIT;
>  	int num_chunks =3D 3;

Good.

Looks good to me.
--=20
Jakub Nar=C4=99bski
