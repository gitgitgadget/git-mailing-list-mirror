Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 350ADC433F5
	for <git@archiver.kernel.org>; Wed,  9 Mar 2022 20:34:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234873AbiCIUfi (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Mar 2022 15:35:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232389AbiCIUfi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Mar 2022 15:35:38 -0500
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76FA9260E
        for <git@vger.kernel.org>; Wed,  9 Mar 2022 12:34:38 -0800 (PST)
Received: by mail-io1-xd35.google.com with SMTP id d62so4111486iog.13
        for <git@vger.kernel.org>; Wed, 09 Mar 2022 12:34:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=p3XWegXB+ZqYR4MyHVAKnoCO30nqojqRg4cKBFHMp30=;
        b=gGWj52F3d0RYUM/20y+9H2yhPt/wyyDIjSBRVEM4dt1wfsoyVCReDmHTagImcHTd47
         hsLL/0c9P15PGZL62j6plF2BE8fDlIsw/ZaHqhKo1IpVZXrYN17KprvFeyqzkAQ6KZRJ
         L4L6HhVULUjVHJcnDLbWbeBHm50wJp08CaMCSe/8oqoZVmhqM+Jii50Qbbv7P/ioUu0I
         8vbzjODpqb/Dg7BWmhVY4Ts5k31LTSkfYfFKbNO8ljym8smirSja7/hgWHhCo10OdqOi
         cE2Is14olyoeDM2NkKHfB8Ymre9QlfSOdh5o7NarjRYlCMriNSgpn2OShJUwoYn/KjmK
         JhaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=p3XWegXB+ZqYR4MyHVAKnoCO30nqojqRg4cKBFHMp30=;
        b=qaOs2CJq71EPbcCfEuwPYMk3g/yXrI9NekO9SrQWnZnRh5NiKX+F2I8PYsrrmIHFp8
         zbbI3cCm8e2OWKIwvBMTYR15cgnipOdHiUZ9GktbyYsNRuck2zePBTJhnd4S17bSgoA0
         lJ1cZTNGUbBe2eMweI5p1FZUtUeFZuVDEWzkrxNkc8fS+EBYy3nUkcdPENCvRUc7BZrh
         LSua9RiJzzUTbauOAb1c1T4jKBqYD5reRerW1FzY70uRyDrk4BNhyu4nkKefH0bhC00J
         WGy8JOZzNjF0r1fNmvWTEWyVGNXkU2XRIPPRI8xvU0D2cEnunGcg+GlaIDdyMcZU2eBD
         ka5A==
X-Gm-Message-State: AOAM530hVyljmDTlPbHf0hD2gHaSIWIoMn5/FXfGo01N0eJIyN3tnsvM
        9Avt7DK7FSC7X09Hupr3VsbBlw==
X-Google-Smtp-Source: ABdhPJyoEgQlOtU6yK6bgJaai77HG/EdRyB3FaOoCRHG1knGSj27EFvjLP49mk7YSOFGBL8n+IC+Gw==
X-Received: by 2002:a05:6602:124a:b0:641:2c16:32de with SMTP id o10-20020a056602124a00b006412c1632demr1075154iou.149.1646858077793;
        Wed, 09 Mar 2022 12:34:37 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id e15-20020a92194f000000b002c25e778042sm1558535ilm.73.2022.03.09.12.34.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Mar 2022 12:34:37 -0800 (PST)
Date:   Wed, 9 Mar 2022 15:34:36 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH 03/24] format-patch: don't leak "extra_headers" or
 "ref_message_ids"
Message-ID: <YikPXN5xobn+Y/Jn@nand.local>
References: <cover-00.24-00000000000-20220309T123321Z-avarab@gmail.com>
 <patch-03.24-ab1afe6c0c8-20220309T123321Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-03.24-ab1afe6c0c8-20220309T123321Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 09, 2022 at 02:16:33PM +0100, Ævar Arnfjörð Bjarmason wrote:
> @@ -1946,7 +1947,8 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
>  		strbuf_addch(&buf, '\n');
>  	}
>
> -	rev.extra_headers = strbuf_detach(&buf, NULL);
> +	extra_headers = strbuf_detach(&buf, NULL);
> +	rev.extra_headers = extra_headers;

Small nit, these two assignments could be combined on the same line
without wrapping. But obviously not a big deal.

> @@ -2173,8 +2175,10 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
>  		prepare_bases(&bases, base, list, nr);
>  	}
>
> -	if (in_reply_to || thread || cover_letter)
> -		rev.ref_message_ids = xcalloc(1, sizeof(struct string_list));
> +	if (in_reply_to || thread || cover_letter) {
> +		rev.ref_message_ids = xmalloc(sizeof(*rev.ref_message_ids));
> +		string_list_init_nodup(rev.ref_message_ids);
> +	}

OK, and this is the "while we're at it..." part of your commit message.
I did find this a little confusing to read at first, so wouldn't have
minded to see this and the rest of the change split across two patches,
but I think this is fine, too.

> @@ -2281,6 +2285,11 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
>  	strbuf_release(&rdiff1);
>  	strbuf_release(&rdiff2);
>  	strbuf_release(&rdiff_title);
> +	free(extra_headers);
> +	if (rev.ref_message_ids) {
> +		string_list_clear(rev.ref_message_ids, 0);

I was surprised to learn that string_list_clear() is not a noop when its
first argument is NULL.

Looking around, it probably wouldn't help that much. E.g., running
something like:

    git grep -B1 'string_list_clear(' | grep if -A1

doesn't turn up many results like the above. So maybe some good
#leftoverbits there, although maybe not.

> +		free(rev.ref_message_ids);

This could go in or out of the if-statement.

Thanks,
Taylor
