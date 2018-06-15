Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BE6DA1F403
	for <e@80x24.org>; Fri, 15 Jun 2018 17:05:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756325AbeFORFr (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Jun 2018 13:05:47 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:39082 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756005AbeFORFq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Jun 2018 13:05:46 -0400
Received: by mail-wr0-f196.google.com with SMTP id w7-v6so10599328wrn.6
        for <git@vger.kernel.org>; Fri, 15 Jun 2018 10:05:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=2k8mMcVCaaGbYJ+ZiaTVWaKXHmrYzf5tHFsRuv4wdww=;
        b=K6jLe0Rsb7rcrnp7d6vHn0e6/0CQeS/50M44XmqExn+WJPZykIbVw2HGXytkljWUa+
         IJYdUqvnmOH3Vib98DdIZMqa8mCykWZWg8jLvgdxL4+F2xGgRoAT66PjwU7PoorTVBJx
         K/HOq0vfJuxBySq97jLf0xRUlOqURXBgfTfYx0ibUm1CdOiBmAE+M+qbGC9xS0yT4Kbq
         8q8mWxGqrFGToiAEISX5M5SpUbT8qc7IMBLNHh+HZEzO3iz74lo+Z9x7Sov0kyj37ykV
         C9gYboT0wRy6kXlpPEfHSbnVrlJOi/OmMsftA+JXEKRExDEpUUB7/VpUtJXr1b6pPWb3
         n98g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=2k8mMcVCaaGbYJ+ZiaTVWaKXHmrYzf5tHFsRuv4wdww=;
        b=SbnryLk1Y3aJG0u6AJm3DPkHbctLDuMb4wiPUf2GfSswVpW7opKIiUGYLlJsfGl45p
         B3fMNh1i1TwJ1e6qs46YgoyzHQxCjwzSBE5W4yJsbNPoicYa4UB33oahGfou/HEY9xXD
         HbEKV6NaRmZNzESb9i2lfzPJakBc7xw49IGZZm2WsPr6wEFoKSmaULFPu3wsPSvSC6mq
         dG0lS/uH+8zIYa77X8pZdwBnhs0N5Ss6+yNj//LWXcBZF80J4wf1RECVOPC6qvtZOaKp
         tpmUwiyud8un7BMl4m5+aENciLEASAd1fdL8EyyUpphP5aTqAzMFz6urBsTrcqTC7Y27
         lnhQ==
X-Gm-Message-State: APt69E1a9jaKwk7TFRsJKPdINwUW+TqCtaQeEZVnbBmddx5vhlqkhypn
        AOj+54Ox/t5uTsndd8bSMws=
X-Google-Smtp-Source: ADUXVKIMzXZYUXMsokbdpfVN5dBJaM3V+Rc/oO+MbSOQmHNyrmLylcnaN08sNGZxk780341OHIBUgA==
X-Received: by 2002:adf:c358:: with SMTP id e24-v6mr2289471wrg.257.1529082345158;
        Fri, 15 Jun 2018 10:05:45 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id m10-v6sm9867215wrq.56.2018.06.15.10.05.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 15 Jun 2018 10:05:43 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Luat Nguyen <root@l4w.io>, git@vger.kernel.org
Subject: Re: [PATCH 1/3] ewah_read_mmap: bounds-check mmap reads
References: <20180615032850.GA23241@sigill.intra.peff.net>
        <20180615033112.GA20390@sigill.intra.peff.net>
Date:   Fri, 15 Jun 2018 10:05:42 -0700
In-Reply-To: <20180615033112.GA20390@sigill.intra.peff.net> (Jeff King's
        message of "Thu, 14 Jun 2018 23:31:13 -0400")
Message-ID: <xmqqsh5o0yl5.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> diff --git a/ewah/ewah_io.c b/ewah/ewah_io.c
> index bed1994551..33c08c40f8 100644
> --- a/ewah/ewah_io.c
> +++ b/ewah/ewah_io.c
> @@ -122,16 +122,23 @@ int ewah_serialize_strbuf(struct ewah_bitmap *self, struct strbuf *sb)
>  	return ewah_serialize_to(self, write_strbuf, sb);
>  }
>  
> -int ewah_read_mmap(struct ewah_bitmap *self, const void *map, size_t len)
> +ssize_t ewah_read_mmap(struct ewah_bitmap *self, const void *map, size_t len)
>  {
>  	const uint8_t *ptr = map;
> +	size_t data_len;
>  	size_t i;
>  
> +	if (len < sizeof(uint32_t))
> +		return error("corrupt ewah bitmap: eof before bit size");
>  	self->bit_size = get_be32(ptr);
>  	ptr += sizeof(uint32_t);
> +	len -= sizeof(uint32_t);
>  
> +	if (len < sizeof(uint32_t))
> +		return error("corrupt ewah bitmap: eof before length");
>  	self->buffer_size = self->alloc_size = get_be32(ptr);
>  	ptr += sizeof(uint32_t);
> +	len -= sizeof(uint32_t);
>  
>  	REALLOC_ARRAY(self->buffer, self->alloc_size);
>  
> @@ -141,15 +148,25 @@ int ewah_read_mmap(struct ewah_bitmap *self, const void *map, size_t len)
>  	 * the endianness conversion in a separate pass to ensure
>  	 * we're loading 8-byte aligned words.
>  	 */
> -	memcpy(self->buffer, ptr, self->buffer_size * sizeof(eword_t));
> -	ptr += self->buffer_size * sizeof(eword_t);


> +	data_len = st_mult(self->buffer_size, sizeof(eword_t));

This is a faithful conversion from the original, but I somehow would
have appreciated if the latter were not sizeof(eword_t) but rather
sizeof(self->buffer_size[0]), especially as I wondered ...

> +	if (len < data_len)
> +		return error("corrupt ewah bitmap: eof in data "
> +			     "(%"PRIuMAX" bytes short)",
> +			     (uintmax_t)(data_len - len));
> +	memcpy(self->buffer, ptr, data_len);
> +	ptr += data_len;
> +	len -= data_len;
>  
>  	for (i = 0; i < self->buffer_size; ++i)
>  		self->buffer[i] = ntohll(self->buffer[i]);

... what individual datum one iteration of this loop is copying, and
then realized "buffer_size" is a misleading field name (anything that 
claims to be size and not measuring in bytes is misleading to me ;-).

> +	if (len < sizeof(uint32_t))
> +		return error("corrupt ewah bitmap: eof before rlw");
>  	self->rlw = self->buffer + get_be32(ptr);
> +	ptr += sizeof(uint32_t);
> +	len -= sizeof(uint32_t);
>  
> -	return (3 * 4) + (self->buffer_size * 8);
> +	return ptr - (const uint8_t *)map;

Much nicer; I needed to wonder what these 12 and 8 in the original are.

>  
>  int ewah_deserialize(struct ewah_bitmap *self, int fd);
> -int ewah_read_mmap(struct ewah_bitmap *self, const void *map, size_t len);
> +ssize_t ewah_read_mmap(struct ewah_bitmap *self, const void *map, size_t len);

I double checked all the callers and made sure that they are already
prepared to react sensibly to error returns, which is good.

>  
>  uint32_t ewah_checksum(struct ewah_bitmap *self);
>  
> diff --git a/t/t5310-pack-bitmaps.sh b/t/t5310-pack-bitmaps.sh
> index 423c0a475f..237ee6e5fc 100755
> --- a/t/t5310-pack-bitmaps.sh
> +++ b/t/t5310-pack-bitmaps.sh
> @@ -331,4 +331,17 @@ test_expect_success 'pack reuse respects --incremental' '
>  	git show-index <empty.idx >actual &&
>  	test_cmp expect actual
>  '
> +
> +test_expect_success 'truncated bitmap fails gracefully' '
> +	git repack -ad &&
> +	git rev-list --use-bitmap-index --count --all >expect &&
> +	bitmap=$(ls .git/objects/pack/*.bitmap) &&
> +	test_when_finished "rm -f $bitmap" &&
> +	head -c 512 <$bitmap >$bitmap.tmp &&
> +	mv $bitmap.tmp $bitmap &&
> +	git rev-list --use-bitmap-index --count --all >actual 2>stderr &&
> +	test_cmp expect actual &&
> +	test_i18ngrep corrupt stderr
> +'
> +
>  test_done
