Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 286AE1F4B6
	for <e@80x24.org>; Sat, 22 Jun 2019 21:42:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726378AbfFVVmh (ORCPT <rfc822;e@80x24.org>);
        Sat, 22 Jun 2019 17:42:37 -0400
Received: from bsmtp7.bon.at ([213.33.87.19]:37220 "EHLO bsmtp7.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726286AbfFVVmh (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Jun 2019 17:42:37 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp7.bon.at (Postfix) with ESMTPSA id 45WTYP74fdz5tlB;
        Sat, 22 Jun 2019 23:42:33 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 72E72450;
        Sat, 22 Jun 2019 23:42:33 +0200 (CEST)
Subject: Re: [PATCH v3] l10n: localizable upload progress messages
To:     Dimitriy Ryazantcev <dimitriy.ryazantcev@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
References: <20190622093655.80092-2-dimitriy.ryazantcev@gmail.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <65cf1cfd-bb5f-dba0-17d6-7fee0ed1f51f@kdbg.org>
Date:   Sat, 22 Jun 2019 23:42:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190622093655.80092-2-dimitriy.ryazantcev@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 22.06.19 um 11:36 schrieb Dimitriy Ryazantcev:
> Signed-off-by: Dimitriy Ryazantcev <dimitriy.ryazantcev@gmail.com>
> ---
>  progress.c |  4 +++-
>  strbuf.c   | 16 ++++++++++++----
>  2 files changed, 15 insertions(+), 5 deletions(-)
> 
> diff --git a/progress.c b/progress.c
> index a2e8cf64a8..61d8cf5d04 100644
> --- a/progress.c
> +++ b/progress.c
> @@ -151,7 +151,9 @@ static void throughput_string(struct strbuf *buf, uint64_t total,
>  	strbuf_humanise_bytes(buf, total);
>  	strbuf_addstr(buf, " | ");
>  	strbuf_humanise_bytes(buf, rate * 1024);
> -	strbuf_addstr(buf, "/s");
> +	strbuf_addstr(buf, "/");
> +	/* TRANSLATORS: IEC 80000-13:2008, subclause 13-12.b: second */
> +	strbuf_addstr(buf, _("s"));
>  }
>  
>  void display_throughput(struct progress *progress, uint64_t total)
> diff --git a/strbuf.c b/strbuf.c
> index 0e18b259ce..0a3ebc3749 100644
> --- a/strbuf.c
> +++ b/strbuf.c
> @@ -814,20 +814,28 @@ void strbuf_addstr_urlencode(struct strbuf *sb, const char *s,
>  void strbuf_humanise_bytes(struct strbuf *buf, off_t bytes)
>  {
>  	if (bytes > 1 << 30) {
> -		strbuf_addf(buf, "%u.%2.2u GiB",
> +		strbuf_addf(buf, "%u.%2.2u ",
>  			    (unsigned)(bytes >> 30),
>  			    (unsigned)(bytes & ((1 << 30) - 1)) / 10737419);
> +		/* TRANSLATORS: ISO/IEC 80000-13:2008, clause 4: gibi */
> +		strbuf_addstr(buf, _("Gi"));
>  	} else if (bytes > 1 << 20) {
>  		unsigned x = bytes + 5243;  /* for rounding */
> -		strbuf_addf(buf, "%u.%2.2u MiB",
> +		strbuf_addf(buf, "%u.%2.2u ",
>  			    x >> 20, ((x & ((1 << 20) - 1)) * 100) >> 20);
> +		/* TRANSLATORS: ISO/IEC 80000-13:2008, clause 4: mebi */
> +		strbuf_addstr(buf, _("Mi"));
>  	} else if (bytes > 1 << 10) {
>  		unsigned x = bytes + 5;  /* for rounding */
> -		strbuf_addf(buf, "%u.%2.2u KiB",
> +		strbuf_addf(buf, "%u.%2.2u ",
>  			    x >> 10, ((x & ((1 << 10) - 1)) * 100) >> 10);
> +		/* TRANSLATORS: ISO/IEC 80000-13:2008, clause 4: kibi */
> +		strbuf_addstr(buf, _("Ki"));
>  	} else {
> -		strbuf_addf(buf, "%u bytes", (unsigned)bytes);
> +		strbuf_addf(buf, "%u ", (unsigned)bytes);
>  	}
> +	/* TRANSLATORS: ISO/IEC 80000-13:2008, subclause 13-9.c: byte */
> +	strbuf_addstr(buf, _("B"));
>  }
>  
>  void strbuf_add_absolute_path(struct strbuf *sb, const char *path)
> 

All of the prefixes are in ISO/IEC, i.e., standardized. Why do they have
to be translated?

Isn't the way of presentation of magnitudes with a unit also
standardized, and should not need to be translated?

-- Hannes
