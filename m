Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8B4B71F404
	for <e@80x24.org>; Tue,  4 Sep 2018 18:58:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727986AbeIDXZD (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Sep 2018 19:25:03 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36236 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727695AbeIDXZD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Sep 2018 19:25:03 -0400
Received: by mail-wr1-f67.google.com with SMTP id m27-v6so5083159wrf.3
        for <git@vger.kernel.org>; Tue, 04 Sep 2018 11:58:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=tSgx3flKlJTESfQyLK5/GtG2/2wU0nL6CpUIADSOLnQ=;
        b=A5ADVfflZfttBP08ZBGGbgkbh8t073afmYldCXyQbnqQHevPNndaVD31w8LeRfzb+j
         6iVA1NEUmHuzbGNZGw+y0rWE9wRldyT2m3OpxlUz7A0IIzfm+s/YLQZfSqW+EU/BRnZV
         XqPufecto+h6SJ6TrVcDr1aRR50QW7Dt+y8rGjIDVkYn/WBzONSQ9G9p7B5J/pf9nCCL
         B7CcMlTH93HdHZhdrJNv/722ydIcvitBbSn4GwnqJZBZAuSyYsUagD1Mvj+0FlpyM+lb
         dn+oVrlXtbbWkg1VYcMEL2osEccZeLtxVjc5BlFpAggi5++NZSP8032ZYHIYU0QEAFBX
         hO9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=tSgx3flKlJTESfQyLK5/GtG2/2wU0nL6CpUIADSOLnQ=;
        b=YjctD3/kZHc3Quxey5f5SJkPIjLAKH+IQk89hLkW5M20CC0WYPrISrILKVwX3T0CIX
         xRq/EYXmwQokhOOMr/rRgGYrmqS8nrArTfYKV2DWVhy021ubqrVZnSN/WgMfX4wmb/mU
         688iwqvryG0gDMiVGFXda3ZGs+0f8jQQBWEVfe9kdBnnndsHUIVmIXafsuKaZ4YYgoyr
         im7bgu60dK74nmV01EYcSO3nAfT3Gb03USLarf1J9b7mdiouzfMpBySXnIpgLHF+FhSf
         b57HZv0UG3HHTMDeui7Hv9145RShlBnTWJGuEUYY/PHoyE8jQ9hFaJgkrhM9hnEiOrDC
         UWWA==
X-Gm-Message-State: APzg51BffgFu3X5i//gaXGVBZv1zpOvcnE7xzDb4nZn7D9zvCvKSaZGs
        ZbiJinmm2ps5X3bh/obcM+Q=
X-Google-Smtp-Source: ANB0VdaWbGebPR1vlm6x3dZS8nwnO5SIAI3GpgDHXwkH++rSOAC9wTcoNg9KJa3DcztenfWESqizvg==
X-Received: by 2002:a05:6000:1008:: with SMTP id a8mr4523362wrx.285.1536087516933;
        Tue, 04 Sep 2018 11:58:36 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id a203-v6sm7073051wmh.31.2018.09.04.11.58.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 04 Sep 2018 11:58:36 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     Ben.Peart@microsoft.com, git@vger.kernel.org, peartben@gmail.com
Subject: Re: [PATCH v2 1/1] read-cache.c: optimize reading index format v4
References: <20180825064458.28484-1-pclouds@gmail.com>
        <20180902131933.27484-1-pclouds@gmail.com>
        <20180902131933.27484-2-pclouds@gmail.com>
Date:   Tue, 04 Sep 2018 11:58:35 -0700
In-Reply-To: <20180902131933.27484-2-pclouds@gmail.com> (=?utf-8?B?Ik5n?=
 =?utf-8?B?dXnhu4VuIFRow6FpIE5n4buNYw==?=
        Duy"'s message of "Sun, 2 Sep 2018 15:19:33 +0200")
Message-ID: <xmqqk1o19jj8.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nguyễn Thái Ngọc Duy  <pclouds@gmail.com> writes:

> +static struct cache_entry *create_from_disk(struct index_state *istate,
>  					    struct ondisk_cache_entry *ondisk,
>  					    unsigned long *ent_size,
> -					    struct strbuf *previous_name)
> +					    const struct cache_entry *previous_ce)
>  {
>  	struct cache_entry *ce;
>  	size_t len;
>  	const char *name;
>  	unsigned int flags;
> +	size_t copy_len;

We should not have to, but let's initialize it to 0 here, because
...

> +	if (expand_name_field) {
> +...
> +		copy_len = previous_len - strip_len;
> +		name = (const char *)cp;
> +	}
> +
> +	if (len == CE_NAMEMASK) {
> +		len = strlen(name);
> +		if (expand_name_field)
> +			len += copy_len;
> ...
> +	}
> +	if (expand_name_field) {
> +		if (copy_len)
> +			memcpy(ce->name, previous_ce->name, copy_len);
> +		memcpy(ce->name + copy_len, name, len + 1 - copy_len);
> +		*ent_size = (name - ((char *)ondisk)) + len + 1 - copy_len;

I am seeing a compiler getting confused, thinking that copy_len
could be used before getting assigned.

Humans can see that reference to copy_len are made only inside "if
(expand_name_field)", so we shouldn't have to.

