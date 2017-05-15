Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2D92F201A4
	for <e@80x24.org>; Mon, 15 May 2017 04:02:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756885AbdEOEC2 (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 May 2017 00:02:28 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:35219 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751536AbdEOEC1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 May 2017 00:02:27 -0400
Received: by mail-pg0-f66.google.com with SMTP id i63so15289895pgd.2
        for <git@vger.kernel.org>; Sun, 14 May 2017 21:02:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=ADiHmej6HMWozsWt6vkgGTb/+fm5kn4P0PK+ise0B8g=;
        b=KrvmXGacJHE6mzKwlO1WCvQGK5pujUUshFOVoX1A7vKLipKKD9cLTogoV56K/wP4YN
         KYyHu3p51qCN5b0SeqKjTh0LS+1eLzVsk1MeDg3HlK1ugBdcFYsjMwkDRFb9YwwO4UEY
         lY6Rsv++GM8LwffnDHZLMcJdvZEVqq7jR1h7ZIB75FW9RDyBFzNkwkpNADSRQLpm9qro
         b6YW2SX040kTjP0F12iTn39vyZPsCBcbo8wi5RsdtfrcZXw7RmOom24QM31PQl/WxerR
         6mQ0PM6JitTTwgJYNcc9PvXEITMEweYXZ1kkHb27uMh6RMZzcAWGS5bjCwtYUirjucuF
         13pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=ADiHmej6HMWozsWt6vkgGTb/+fm5kn4P0PK+ise0B8g=;
        b=SoGEy+7vJUCmWVxn/hl9LyIU2Hua0Zf28oc9WTWy1EK1idmMD3QvvlKiJ4lhfUrsAJ
         NA6fdA27Ij39al8Ysb0/hE7I1HQYe0nGlqpdDJM9FZHBL93xqb7K9Li6ONmTm5tv+yXs
         1f9oA0dx4IbVIGoiuUsPPIK3xTnP8YE5tXw+3VdTmgSWvMQn47BsgaTcHJLZCqq7YZ19
         lrh+OVnPQhDLrTlm6op5EkrpDbg/Vdpe3YN+P9jUiui0mSq6HtLJXotKRE7whwQJYbEK
         wAEaJ2l9toOm+e+gJCGpe3YrO2RWhqhtDm2OQP+wWNpRb0ej1P7tDkuNqcRMBj9MCLrx
         zBrQ==
X-Gm-Message-State: AODbwcDLjpGvVEWx2x2WG2Yv7nOrOZLo+0KYJgH24yku4YEXN81kK9U1
        zgPwF6LZzHLVrw==
X-Received: by 10.98.62.86 with SMTP id l83mr4149579pfa.114.1494820947083;
        Sun, 14 May 2017 21:02:27 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:b170:f9ed:5f25:7ab5])
        by smtp.gmail.com with ESMTPSA id m8sm16103199pga.34.2017.05.14.21.02.26
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sun, 14 May 2017 21:02:26 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Ben Peart <peartben@gmail.com>, git@vger.kernel.org,
        benpeart@microsoft.com, christian.couder@gmail.com,
        larsxschneider@gmail.com
Subject: Re: [PATCH v7 04/10] convert: move packet_write_line() into pkt-line as packet_writel()
References: <20170505152802.6724-1-benpeart@microsoft.com>
        <20170505152802.6724-5-benpeart@microsoft.com>
        <20170513090457.s6gmqjdyrj4osmck@sigill.intra.peff.net>
Date:   Mon, 15 May 2017 13:02:25 +0900
In-Reply-To: <20170513090457.s6gmqjdyrj4osmck@sigill.intra.peff.net> (Jeff
        King's message of "Sat, 13 May 2017 05:04:58 -0400")
Message-ID: <xmqqbmquwywe.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> This isn't a new problem, but I noticed that this function should
> probably get annotated to describe its interface.
>
> Junio, can you pick up the patch below on top of Ben's series (or I'd be
> fine if it were squashed into this patch)?

Surely.  Thanks for a careful review.

>
> -- >8 --
> Subject: [PATCH] pkt-line: annotate packet_writel with LAST_ARG_MUST_BE_NULL
>
> packet_writel() takes a variable-sized list and reads to
> the first NULL. Let's let the compiler know so that it can
> help us catch mistakes in the callers.
>
> This should have been annotated similarly when it was a
> static function, but it's doubly important now that the
> function is available to the whole code-base.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  pkt-line.h | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/pkt-line.h b/pkt-line.h
> index b2965869a..450183b64 100644
> --- a/pkt-line.h
> +++ b/pkt-line.h
> @@ -25,6 +25,7 @@ void packet_buf_flush(struct strbuf *buf);
>  void packet_buf_write(struct strbuf *buf, const char *fmt, ...) __attribute__((format (printf, 2, 3)));
>  int packet_flush_gently(int fd);
>  int packet_write_fmt_gently(int fd, const char *fmt, ...) __attribute__((format (printf, 2, 3)));
> +LAST_ARG_MUST_BE_NULL
>  int packet_writel(int fd, const char *line, ...);
>  int write_packetized_from_fd(int fd_in, int fd_out);
>  int write_packetized_from_buf(const char *src_in, size_t len, int fd_out);
