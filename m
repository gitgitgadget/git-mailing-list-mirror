Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8D4591FC3E
	for <e@80x24.org>; Thu, 27 Apr 2017 06:07:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932844AbdD0GHn (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Apr 2017 02:07:43 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:36090 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932835AbdD0GHl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Apr 2017 02:07:41 -0400
Received: by mail-pf0-f196.google.com with SMTP id v14so6476277pfd.3
        for <git@vger.kernel.org>; Wed, 26 Apr 2017 23:07:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=fMKUtChjfkNdET1fn3gxOIN8shqJMNbYhMNLhJe1Z5A=;
        b=eRsOZHtnnKPlI/nY4NvYP24wLaGavHqL/u+BT0zv0l5QrhhdJ6spFaTyWV59jzV0dE
         Fkm3gxGRBJSqBZ9LETQAuHTazwjRdt1/hSBmzgiCiS5RcDx6mFg4BMm4AOs1rrXko9F9
         YLX6309Q1+Gz8GWPExcQOvJuqICig2dnUtxuR5xaSMsj7Yz8xrC1ByiMRxbYN3FE57Ry
         ViVsAJR+WhzS4yQc7V5Jbpi9/D22rFrXOoRz3cUScSrt8GZFP/BrKbMqVDRAJK9m6YNb
         RyJDOrGdp5Jlwov8FYEdu3UZOfCYZ0mwwrKDdoWK1lfpBhN930ibM01IiDetHqGPPBG2
         MhbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=fMKUtChjfkNdET1fn3gxOIN8shqJMNbYhMNLhJe1Z5A=;
        b=cfEXT8329tF3/mU/7N2ojTbBq+CiPvH/qUauZ3UoRfL/ukxYrY9I/k/+bmeaOMjOBD
         7Stz7lPG73ADClHegd94Wdqr5tCWbeS8c1jRNcKLvyX6FBHIDU2JTk/Hz04qF1aZzlpQ
         7qchpM2xpE7+JeAqMlYFdm8OID0MVFHG24m5jsuJ2R4MOg4/ZDKVnDTkQnUAGd64/Sdn
         ACJWKdmVnWNIjzs4a/ZpDzyUOUnYcjFACGR7XG3lZt3xqfMdmUtdA7dUeAa0Hz5phLB0
         V4w1eYMBip5ObPWO67DMqcyJzbwwfFiQgRYCkm68fVOIyfUaRTjdRBDPMdA0UEmmcPjy
         aI0g==
X-Gm-Message-State: AN3rC/7g/CE/CWMn4a3lFkFMLVQQUUyviQn862Hd3yftIz8bvlYOboBf
        kDzyyfE7JA+w8A==
X-Received: by 10.99.145.200 with SMTP id l191mr3846814pge.123.1493273261226;
        Wed, 26 Apr 2017 23:07:41 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:d550:ca2:cfe6:6d97])
        by smtp.gmail.com with ESMTPSA id a21sm2118220pfc.60.2017.04.26.23.07.40
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 26 Apr 2017 23:07:40 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 10/26] Check for EOF while parsing mails
References: <cover.1493237937.git.johannes.schindelin@gmx.de>
        <1fb841cee32996ee9194c2bd33b9dfe74cc37726.1493237937.git.johannes.schindelin@gmx.de>
Date:   Wed, 26 Apr 2017 23:07:39 -0700
In-Reply-To: <1fb841cee32996ee9194c2bd33b9dfe74cc37726.1493237937.git.johannes.schindelin@gmx.de>
        (Johannes Schindelin's message of "Wed, 26 Apr 2017 22:20:16 +0200
        (CEST)")
Message-ID: <xmqqshkumlhw.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> Reported via Coverity.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  builtin/mailsplit.c | 2 +-
>  mailinfo.c          | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

Good find.  I'd retitle with a prefix

	mailinfo & mailsplit: check for EOF while parsing

so that it is clear that this patch is about lower level machinery
(as oppose to something like "git am").

Thanks.

>
> diff --git a/builtin/mailsplit.c b/builtin/mailsplit.c
> index 30681681c13..c0d88f97512 100644
> --- a/builtin/mailsplit.c
> +++ b/builtin/mailsplit.c
> @@ -232,7 +232,7 @@ static int split_mbox(const char *file, const char *dir, int allow_bare,
>  
>  	do {
>  		peek = fgetc(f);
> -	} while (isspace(peek));
> +	} while (peek >= 0 && isspace(peek));
>  	ungetc(peek, f);
>  
>  	if (strbuf_getwholeline(&buf, f, '\n')) {
> diff --git a/mailinfo.c b/mailinfo.c
> index 68037758f2f..60dcad7b714 100644
> --- a/mailinfo.c
> +++ b/mailinfo.c
> @@ -1099,7 +1099,7 @@ int mailinfo(struct mailinfo *mi, const char *msg, const char *patch)
>  
>  	do {
>  		peek = fgetc(mi->input);
> -	} while (isspace(peek));
> +	} while (peek >= 0 && isspace(peek));
>  	ungetc(peek, mi->input);
>  
>  	/* process the email header */
