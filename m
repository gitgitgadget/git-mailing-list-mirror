Return-Path: <SRS0=oq1W=ZN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C63A6C432C3
	for <git@archiver.kernel.org>; Thu, 21 Nov 2019 08:18:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9506A20898
	for <git@archiver.kernel.org>; Thu, 21 Nov 2019 08:18:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iaR7VUjE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726736AbfKUIR7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Nov 2019 03:17:59 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:39648 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726568AbfKUIR6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Nov 2019 03:17:58 -0500
Received: by mail-wm1-f68.google.com with SMTP id t26so2603050wmi.4
        for <git@vger.kernel.org>; Thu, 21 Nov 2019 00:17:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=thZdePNkKuBwC4ogcH0RYkZI06UpHf9w68X8ZDtWetg=;
        b=iaR7VUjEXmADBp4RvcdNyIrWU84XopcP9XEE8LrvnX+B50pbkmBmv9z5tyF69TUIbT
         7MSlXQtTBPv+4ajQN1JQ2MwVbd5IuKiodMODQXTKBY69dm2gdEltLWob1U9mI6XDQux7
         SnPcCYZOcYde9MaCBehifhMAhO1klFxBX0RWKVCa5jxa3NkENLkG7MNFLuVUD53Ac+f5
         wUPCm9+8X8NnojhMhTUMEZDz2WOLRZw9dVW7enab5AWVs7cD7YldO/j1fzM7wIXACITO
         icuutrC0Uli2/SAOsoL6xF9EvbVDRFgKGto3BF1jR69g1xR7sYvrt8PCQXYmYF91PYu3
         dGbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=thZdePNkKuBwC4ogcH0RYkZI06UpHf9w68X8ZDtWetg=;
        b=N/JV/NsC0a+vBUcfTMXquOiWg2U6Nzt2OR3AO7nmICv6HiLkLihG0TpTS6jxVh2dw8
         lpOYXxjgNlDdkR3YvpP02Rpv87Tz6YomCAAUkVISrbktkvkJMCLUmHONlkwtpfvp1heU
         FIQCs6JB6r95WtQfjrFvdVwtZY+wAMQPK0D/Jp6enyv2fkxd2ospLQJphmyXwuZ0uBgF
         OAvdmnUvBs5FA/PloVu3hXB0SKc9NbKcjJhGJws5Jtvpua1LaynZZ88+5Stri/fXcTdl
         nYlr36T814zBAqorb1Ryd2YDTX6xtEZiLVlIDIJ57UQHqYOBjaFYvEQHo1C14RxaB3N3
         XG+A==
X-Gm-Message-State: APjAAAWV3YUgylU5j02zL2LpeorolWO98j+jWEzVXmpgSB/toCUVIR3e
        Uomzdrf5UGx4t6/YYLH+5G4=
X-Google-Smtp-Source: APXvYqxg6yX9nEeih0H4F6lMlXCUlG2VUlnwv/BZT0YZRzkxLOli7lCCDEw3Czh1Upg6RC2E8BNJ1Q==
X-Received: by 2002:a1c:9c82:: with SMTP id f124mr8776515wme.25.1574324276137;
        Thu, 21 Nov 2019 00:17:56 -0800 (PST)
Received: from [192.168.0.104] (atoulouse-658-1-110-106.w86-199.abo.wanadoo.fr. [86.199.33.106])
        by smtp.gmail.com with ESMTPSA id 19sm2631023wrc.47.2019.11.21.00.17.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Nov 2019 00:17:55 -0800 (PST)
Subject: Re: [PATCH v5 0/6] rebase -i: support more options
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de,
        Rohit Ashiwal <rohit.ashiwal265@gmail.com>,
        martin.agren@gmail.com, newren@gmail.com,
        phillip.wood123@gmail.com, t.gummerer@gmail.com
References: <20190806173638.17510-1-rohit.ashiwal265@gmail.com>
 <20191101140003.13960-1-rohit.ashiwal265@gmail.com>
 <xmqqimnd92nv.fsf@gitster-ct.c.googlers.com>
From:   Alban Gruin <alban.gruin@gmail.com>
Openpgp: preference=signencrypt
Message-ID: <36162d31-0463-5e21-fbf6-53667fffc000@gmail.com>
Date:   Thu, 21 Nov 2019 09:17:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <xmqqimnd92nv.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr-FR
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

Le 21/11/2019 à 07:14, Junio C Hamano a écrit :
> As I hate to leave a mostly done topic hanging around forever, I am
> tempted to queue these fixups on top (instead of squash them in) to
> tie the loose ends after a few weeks' inactivity.
> 
> Thanks.
> 
> -- >8 --
> Subject: rebase -i: finishes touches to --reset-author-date
> 
> Clarify the way the `--reset-author-date` option is described,
> and mark its usage string translatable.
> 
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  Documentation/git-rebase.txt | 6 ++++--
>  builtin/rebase.c             | 6 +++---
>  2 files changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
> index c8d54d221d..03809da835 100644
> --- a/Documentation/git-rebase.txt
> +++ b/Documentation/git-rebase.txt
> @@ -392,8 +392,10 @@ See also INCOMPATIBLE OPTIONS below.
>  
>  --ignore-date::
>  --reset-author-date::
> -	Instead of using the given author date, reset it to the
> -	current time. This implies --force-rebase.
> +	By default, the author date of the original commit is used
> +	as the author date for the resulting commit.  This option
> +	tells Git to use the current timestamp instead and implies
> +	`--force-rebase`.
>  +
>  See also INCOMPATIBLE OPTIONS below.
>  
> diff --git a/builtin/rebase.c b/builtin/rebase.c
> index 44768082b8..d5c09f159c 100644
> --- a/builtin/rebase.c
> +++ b/builtin/rebase.c
> @@ -1437,9 +1437,9 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
>  			 &options.committer_date_is_author_date,
>  			 N_("make committer date match author date")),
>  		OPT_BOOL(0, "reset-author-date", &options.ignore_date,
> -			 "ignore author date and use current date"),
> -		OPT_BOOL(0, "ignore-date", &options.ignore_date,
> -			 "ignore author date and use current date"),
> +			 N_("ignore author date and use current date")),
> +		OPT_HIDDEN_BOOL(0, "ignore-date", &options.ignore_date,
> +				N_("synonym of --reset-autohr-date")),

There is a typo here.

>  		OPT_PASSTHRU_ARGV('C', NULL, &options.git_am_opts, N_("n"),
>  				  N_("passed to 'git apply'"), 0),
>  		OPT_BOOL(0, "ignore-whitespace", &options.ignore_whitespace,
> 
> 

Cheers,
Alban

