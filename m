Return-Path: <SRS0=lBg5=3Z=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 911B6C35254
	for <git@archiver.kernel.org>; Wed,  5 Feb 2020 14:35:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6422020702
	for <git@archiver.kernel.org>; Wed,  5 Feb 2020 14:35:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BfaYDzxv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726602AbgBEOfv (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Feb 2020 09:35:51 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:45119 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726502AbgBEOfv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Feb 2020 09:35:51 -0500
Received: by mail-qk1-f194.google.com with SMTP id x1so1970562qkl.12
        for <git@vger.kernel.org>; Wed, 05 Feb 2020 06:35:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ycYnJqJBo6986iAkbuSnnpiWZQD2VvlelN1k2b+8bzE=;
        b=BfaYDzxvlaByQozabIgVcaVkAUGtDbjNaa6b1qspt9eGxYVq288boKZ7yg0ShJjuoM
         5LGAA6eZpuDgXPr6UIObMLGjDgKn50hPUY4vNG0hlzhOCB7VAelctjejvwnOB1Dce7Td
         RuZlamq/h7iF+yLrxmzzjAgyBw7eEp5jkWryw3tG6NtSjXdhCAT8xrrmKnm+2thedmZy
         MR0VSI2f3hwyuGGp70v7nA3MY11npCCoGp7yfS58VfJ1jrEY/ujiXkWxMga7Yr9VhVan
         apmSVRDt0B60aCFcuuPAPr3eonnMcV7fnDEOH9mw6sCUThpnylPFnXM6A/e5vjgi0Z1K
         e9Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ycYnJqJBo6986iAkbuSnnpiWZQD2VvlelN1k2b+8bzE=;
        b=mLmpzu35xWJ5Juu8Bz3IDmgvxXLVYElJMSo4sYqwW58cz4P+v6AdJ/gtPjuHRs5NOm
         zBgM0Z8GDKKQd2ljr85WrZUlFQhY/hZy2wi/16wKScvR1dT7e0hlTkRapEpq0Q2SxZW5
         prAOi9TJ1VSYekwrOXw5P27qGl5q1XdHcefrqV1r2dsULDI48zMJZAC8Jw0mOHQEccDs
         jMOYcupA6iZHF2hYeHDUfzA0SXZvGkoWTp7pp9ih6E3xiE7+1KQe8PeD1R3mEo20GnL+
         QIrV2jrUERP5GPfunmGTUjPiXzmoc8H6N3pSSel9AuTdx89pWVJYW01BUZjvir6pw4Ei
         1hSA==
X-Gm-Message-State: APjAAAW1QTOfiU3Ad2yLA2iVT3+UFKX2D/BK9QptkUrwk7Ui3M8n5RkE
        xOeRwIfLUN6hweUvQRDyji4=
X-Google-Smtp-Source: APXvYqxNxhf+726RSy2+9NwlqQNFz11W6Loz7fKyrYK1wlM2DoUWOLe6MH4PKVH7Pc0ZwnkhNldb9g==
X-Received: by 2002:a37:308:: with SMTP id 8mr31919468qkd.98.1580913349036;
        Wed, 05 Feb 2020 06:35:49 -0800 (PST)
Received: from ?IPv6:2001:4898:6808:13e:c9b5:7cd5:1ee4:5066? ([2001:4898:a800:1010:7aeb:7cd5:1ee4:5066])
        by smtp.gmail.com with ESMTPSA id y26sm14363581qtc.94.2020.02.05.06.35.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Feb 2020 06:35:48 -0800 (PST)
Subject: Re: [PATCH 04/10] name-rev: don't leak path copy in name_ref()
To:     =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>,
        Git Mailing List <git@vger.kernel.org>
Cc:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
References: <084909f8-fefa-1fe0-b2ce-74eff47c4972@web.de>
 <32a0a2d6-3237-24e9-c647-6624cc2a1e89@web.de>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <1cced7f0-8112-1ed9-b25d-e559a17a3cc0@gmail.com>
Date:   Wed, 5 Feb 2020 09:35:47 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:73.0) Gecko/20100101
 Thunderbird/73.0
MIME-Version: 1.0
In-Reply-To: <32a0a2d6-3237-24e9-c647-6624cc2a1e89@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2/4/2020 4:17 PM, René Scharfe wrote:
> name_ref() duplicates the path string and passes it to name_rev(), which
> either puts it into a commit slab or ignores it if there is already a
> better name, leaking it.  Move the duplication to name_rev() and release
> the copy in the latter case.
> 
> Signed-off-by: René Scharfe <l.s.r@web.de>
> ---
>  builtin/name-rev.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/builtin/name-rev.c b/builtin/name-rev.c
> index 2e6820bd5b..3e22a0503e 100644
> --- a/builtin/name-rev.c
> +++ b/builtin/name-rev.c
> @@ -121,6 +121,8 @@ static void name_rev(struct commit *start_commit,
> 
>  	if (deref)
>  		tip_name = to_free = xstrfmt("%s^0", tip_name);
> +	else
> +		tip_name = to_free = xstrdup(tip_name);

We now unconditionally duplicate the input tip_name and free it
within the method. Good.

>  	if (!create_or_update_name(start_commit, tip_name, taggerdate, 0, 0,
>  				   from_tag)) {
> @@ -323,7 +325,7 @@ static int name_ref(const char *path, const struct object_id *oid, int flags, vo
>  		if (taggerdate == TIME_MAX)
>  			taggerdate = commit->date;
>  		path = name_ref_abbrev(path, can_abbreviate_output);
> -		name_rev(commit, xstrdup(path), taggerdate, from_tag, deref);
> +		name_rev(commit, path, taggerdate, from_tag, deref);

And we no longer duplicate 'path' here, as it is unconditionally duplicated
in name_ref().

Thanks,
-Stolee

