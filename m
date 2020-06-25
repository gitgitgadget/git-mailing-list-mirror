Return-Path: <SRS0=4a08=AG=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C057C433E1
	for <git@archiver.kernel.org>; Thu, 25 Jun 2020 07:25:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 504F6206C3
	for <git@archiver.kernel.org>; Thu, 25 Jun 2020 07:25:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="IOQ1EXyY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390178AbgFYHZR (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 Jun 2020 03:25:17 -0400
Received: from mout.web.de ([217.72.192.78]:37283 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390110AbgFYHZR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Jun 2020 03:25:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1593069912;
        bh=wxxqPEazqrid1fbuVzBDC2wytYKAbUGTlrEapSr8xd0=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=IOQ1EXyYB8g+V6cWOCzn4Y9apAA3Btt8al0vN40S3FjFh4lrrYMdB75MXJyEFx7ZK
         qepZnSVvBJdnIH5u4XBXyeBsCh5bbkyIRG5+zvtFsQbFyY2GbT7xtrLb4joGBnLMFk
         tCecC2UUOxXcf7UIc995dHVvvaE3W404Zli2sAQY=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([79.203.26.151]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MA4fI-1jiLz82LvO-00BZUt; Thu, 25
 Jun 2020 09:25:12 +0200
Subject: Re: [PATCH v2 07/11] commit-graph: check chunk sizes after writing
To:     =?UTF-8?Q?SZEDER_G=c3=a1bor_via_GitGitGadget?= 
        <gitgitgadget@gmail.com>, git@vger.kernel.org
Cc:     me@ttaylorr.com, szeder.dev@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.659.git.1592252093.gitgitgadget@gmail.com>
 <pull.659.v2.git.1592934430.gitgitgadget@gmail.com>
 <3eb10933dc8517ab01eff17a179e484068d29724.1592934430.git.gitgitgadget@gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <de5453ed-6db9-ebd5-28f9-8db4f9ed8447@web.de>
Date:   Thu, 25 Jun 2020 09:25:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <3eb10933dc8517ab01eff17a179e484068d29724.1592934430.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:X5QIcecQjhlRKxmFndcz/efTNZS5E69VLzlpj/w9tYzYMrTzZyS
 4ICLuwKOUeVbCI1NPXnAA7eOwSf9GKTg4YwEuFeFUdM2Sva9YIVFDguFlu1OsTjAl6jjx3A
 KSoPaq0HFYycBhzuTh5YA33CltSz5aIYj5cZTuGxcrLulDu2py9cr+izxtvaAMPC2zw89L3
 3OpYcsGmZwXeZyf1yjEdA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:L45W0RSGtT0=:5BhJX6cVrvH4i1uN+eEeLF
 1kYXkiGeRj26fJJusZwREBaE2nn48vu+n32kUzufavR/NiPfW/g7N4zLJwTMc5B+UkbtT1GYl
 hsPBBwI8DSP+fhKvQeZS6+PbprAmbAbc6c67ekWycx+VwK6TVA7pfmbanU5Thc0OPAiQQXswN
 pKPtc4MMHLUJL2q3vq9V1hPmoif/v1DdGBtXwmr2Z5/Lwz7siW23bsVtSwNmo+uCa1nVZ80Na
 tcTtr8bdBwb6H591x8XtREpwSbhqx92928FZdS+K0sWFEo59m8jNm5nRqJi8AF2MqYZEsFXUu
 wsp7QeYPsl3dp5rEw5H0k56y48CLCVfGePol8chDoPSal3LhnqNnVWZTAtX33ClVYn20/qjDp
 jubDPn5/fn3SrSTxLVM2RPD3nym5YF9W3oFpJAPLADvWIWH5PFWmzBGAjcaDl7Xnld8pTdL50
 zLDJd0Krd3Vw6EIacv4fT+K0hUhh0beBTdXjAULH4lsEuakuNtbQ1mUiTXrmtcD0QP7cM7F5O
 p6V55Fg75xah52OXy9U0uUUjL5FnycyWYsiHttgXRSO31uqxwrqlU9waJVoN94XZV+27SNfLX
 PG0V3o2xZxMXaBFPptSgZ18pVZbE7P71Sn/Q46PmgJq//H4Xt6WQZkjwFCBTWGGfZ4uCIrFZr
 vZQrKjGljkfmsWVuT+W6+PFH5gre2PCkjXnHS0sUiTcUKwNWoRdjHOx0a+wgWdPRNePspXiij
 szRP/Hznw4gDgVbjTK5oCjZcCLZ2hTnA5/MAiulaoIGqqjq7ZdmebJ/vhuhhm4BIWnof5pqzf
 sKyZOOGidhYwCixIG8ZVvUncAFcj3ZbITc7GE575M5WyWPjsWEWi8KheC0nZTLh5v25zAjdDm
 ihPDqO42/kz7dYCDm4xsbtZCT21uAlJgaRN6uriXB5kQp3bHWSgbmjKADFLvyhnrGxh9785a7
 +x+Ms2QqJXOsodLiGF0qNr+j6cbnpErhny2DY9Hd4VaMmcpgAXeR8wEJMUKQJF3OSoxSSiMFr
 /yDUXHDQ02jL+3lXvFYrx/EN1o3Kl6c7T0WhwDN6II9Y+2z/C/kjdqJ0WYwB5lMCU/+37sdXM
 gAvYnXohv7Y7yczFXZRCw+ygM7ke4cN8TRfTo8tM/A9Oxc8LK+/HemjjV5/Elsslr+RbEnuOO
 SASqvaI1R0OknB5tERdHZ8EJ2ejqLWP/zbIzlzNGOt9wdt9RBAdyOdIWUpWXd7jKziPbY=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 23.06.20 um 19:47 schrieb SZEDER G=C3=A1bor via GitGitGadget:
> From: =3D?UTF-8?q?SZEDER=3D20G=3DC3=3DA1bor?=3D <szeder.dev@gmail.com>
>
> In my experience while experimenting with new commit-graph chunks,
> early versions of the corresponding new write_commit_graph_my_chunk()
> functions are, sadly but not surprisingly, often buggy, and write more
> or less data than they are supposed to, especially if the chunk size
> is not directly proportional to the number of commits.  This then
> causes all kinds of issues when reading such a bogus commit-graph
> file, raising the question of whether the writing or the reading part
> happens to be buggy this time.
>
> Let's catch such issues early, already when writing the commit-graph
> file, and check that each write_graph_chunk_*() function wrote the
> amount of data that it was expected to, and what has been encoded in
> the Chunk Lookup table.  Now that all commit-graph chunks are written
> in a loop we can do this check in a single place for all chunks, and
> any chunks added in the future will get checked as well.
>
> Signed-off-by: SZEDER G=C3=A1bor <szeder.dev@gmail.com>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  commit-graph.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/commit-graph.c b/commit-graph.c
> index 086fc2d070..1de6800d74 100644
> --- a/commit-graph.c
> +++ b/commit-graph.c
> @@ -1683,12 +1683,21 @@ static int write_commit_graph_file(struct write_=
commit_graph_context *ctx)
>  			num_chunks * ctx->commits.nr);
>  	}
>
> +	chunk_offset =3D f->total + f->offset;
>  	for (i =3D 0; i < num_chunks; i++) {
> +		uint64_t end_offset;
> +

Hmm, the added code looks complicated because it keeps state outside the
loop, but it could be replace by this:

		uint64_t start_offset =3D f->total + f->offset;

>  		if (chunks[i].write_fn(f, ctx)) {
>  			error(_("failed writing chunk with id %"PRIx32""),
>  			      chunks[i].id);
>  			return -1;
>  		}
> +
> +		end_offset =3D f->total + f->offset;
> +		if (end_offset - chunk_offset !=3D chunks[i].size)
> +			BUG("expected to write %"PRId64" bytes to chunk %"PRIx32", but wrote=
 %"PRId64" instead",
> +			    chunks[i].size, chunks[i].id, end_offset - chunk_offset);
> +		chunk_offset =3D end_offset;

... and that:

		if (f->total + f->offset !=3D start_offset + chunks[i].size)
			BUG(...);

>  	}
>
>  	stop_progress(&ctx->progress);
>
