Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 902A2201A9
	for <e@80x24.org>; Sat, 18 Feb 2017 05:35:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750836AbdBRFfi (ORCPT <rfc822;e@80x24.org>);
        Sat, 18 Feb 2017 00:35:38 -0500
Received: from mail-pf0-f194.google.com ([209.85.192.194]:36079 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750759AbdBRFfh (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Feb 2017 00:35:37 -0500
Received: by mail-pf0-f194.google.com with SMTP id c193so766650pfb.3
        for <git@vger.kernel.org>; Fri, 17 Feb 2017 21:35:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=ui57wmmOv89Zy31EW3fyqkGwxxx/Ql3pt4LPjYs6nCQ=;
        b=SZdDI9BlbLelDgmGXll5zU2VsbnXM2s3iWMJh2FYPRzYvbZfiCcG1s5H20w5+BdYvR
         uMKd7wtZJgN8dAWj3ArHTfE3zlBUTMVaxXlAo+UtFmfg0HRn8avocWslTOBo6h5VMbK4
         bIzbGR4YgQHM29D/49m4HzSBk4EuTHuAq3RB1/woSk1kbBToDsf6J/VgGZpY/nqBX663
         ywOsjpJWq4Z1kMTmUCQxK6WDLDz3LAmudgVOlNZPuna0GIi/QAPnSifCSEQxUwNyvPhu
         VbQ3k5G5Wxw/5Lr8/AS+BoWAS0V8VGY0F6dfoo2aG/TmnmJphIKuK5ZaWOSEZYfD0rDr
         2Umw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=ui57wmmOv89Zy31EW3fyqkGwxxx/Ql3pt4LPjYs6nCQ=;
        b=NNONF6GtAFPjAihfaPRMGwEQSkLJfo0rr1qDldG8GDOBLUXg7aUhAPu/eBFC3dmhx5
         d1WGiDVuo4orftjEN35iIeOrAbqUfX9h7FWiXQ9rtqtaOYrGGWrwKd4f4I/xRLaEAJsR
         cg0Zq20o4ddCXhY5FSZN9wzAwlAlDeTVMooV9YvFJhltDTiT0QmJsKpRgANjYxpOh8WX
         0SzGoInTmVe3NyXfmcvePWHOFrSfeMXCRp2jVN2EVRut54Okl50pbdFBND4VwUQyIoYN
         POrJa0D+tBRE9c2Z7tdQLIl3xRSlvd+meHjatxChsNrWC/Rk2/pFo/Lz2RBIjR9Nog1Y
         QiUw==
X-Gm-Message-State: AMke39kKnhaXDONT2hgnUMfnjSGiSD6SscHNxC2lvA8V0JGVrogfuq+edJezH1yYQVBRUg==
X-Received: by 10.99.147.81 with SMTP id w17mr14573177pgm.111.1487396137222;
        Fri, 17 Feb 2017 21:35:37 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:3130:38b1:b121:8f0d])
        by smtp.gmail.com with ESMTPSA id s24sm22764536pgo.25.2017.02.17.21.35.36
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 17 Feb 2017 21:35:36 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org, Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH 2/5] hashmap: allow memihash computation to be continued
References: <cover.1487071883.git.johannes.schindelin@gmx.de>
        <bd4893f86c4484fc36480848bf2d0905d961e022.1487071883.git.johannes.schindelin@gmx.de>
Date:   Fri, 17 Feb 2017 21:35:35 -0800
In-Reply-To: <bd4893f86c4484fc36480848bf2d0905d961e022.1487071883.git.johannes.schindelin@gmx.de>
        (Johannes Schindelin's message of "Tue, 14 Feb 2017 12:32:07 +0100
        (CET)")
Message-ID: <xmqq7f4onjrs.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> diff --git a/hashmap.c b/hashmap.c
> index b10b642229c..061b7d61da6 100644
> --- a/hashmap.c
> +++ b/hashmap.c
> @@ -50,6 +50,20 @@ unsigned int memihash(const void *buf, size_t len)
>  	return hash;
>  }
>  
> +/* Incoporate another chunk of data into a memihash computation. */
> +unsigned int memihash_continue(unsigned int hash,
> +			       const void *buf, size_t len)
> +{
> +	const unsigned char *p = buf;
> +	while (len--) {
> +		unsigned int c = *p++;
> +		if (c >= 'a' && c <= 'z')
> +			c -= 'a' - 'A';
> +		hash = (hash * FNV32_PRIME) ^ c;
> +	}
> +	return hash;
> +}

This makes me wonder if we want to reduce the duplication (primarily
to avoid risking the loop body to go out of sync) by doing:

	unsigned int memihash(const void *buf, size_t len)
	{
		return memihash_continue(buf, len, FNV32_BASE);
	}                

If an extra call level really matters, its "inline" equivalent in
the header would probably be good.
