Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2FACC433E0
	for <git@archiver.kernel.org>; Thu, 11 Feb 2021 01:58:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F77D64DBD
	for <git@archiver.kernel.org>; Thu, 11 Feb 2021 01:58:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229598AbhBKB5j (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Feb 2021 20:57:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229715AbhBKByc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Feb 2021 20:54:32 -0500
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1427DC061793
        for <git@vger.kernel.org>; Wed, 10 Feb 2021 17:52:34 -0800 (PST)
Received: by mail-qk1-x72e.google.com with SMTP id h8so3855252qkk.6
        for <git@vger.kernel.org>; Wed, 10 Feb 2021 17:52:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=kJ5zKwAKl0WfU2RFhwGF90N5oMI+xcedpm4OCo3r3cU=;
        b=EMKcED5CZ7SwYjFV/kJLtPU1543O8R2GOYQO/YNnY78a1Frn+lDrJjifNbdAqp00P9
         GR/FEjVxV/AxuAos4DCpMTl8JCmZqAlPzP/e9zGWfokBAUXwD+5LZuyI15SgjKnd1LkS
         T76ABv/XYrlN/Xr7+G26XJlSuc6HR7wX6gZT6X0LkUEF3SDeSOZ+j404IG/lk/9ztSZm
         P3nN7woeWBDRGe6KLr1hqBAGc6lNmCPxoLwn0TaYa2w59blzrEGa5smwuBwNND8eJQFA
         RjSGhIGuXsWV7wNYxHAY8Qvr8gh2mxi6nHdstiURLqwNUlBvAOVvw26dESYiqGy8+a1h
         WHUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kJ5zKwAKl0WfU2RFhwGF90N5oMI+xcedpm4OCo3r3cU=;
        b=uD7xWjBYPejXZaWz3atxCSjoXZFdVtJGQsUCa6Qb33ab62Po7HympMzAyTFeKI8XBy
         9ykaR1liCBeanyJjmQAxnIhppS5hOgs//CS0Kkl5cTCONKaWx4rc74WP3/kDabI0n46Y
         KQhnQZKqHUO2+Uq338tI0keRRqJF0SPV6dq4hc2BQ53wWHhLQWtxsbTofaZL0QD4ZnCl
         yoKFtQaAdOakD4qBkbF05XTZEyyPhVT+UgfLn9hmWyrm5HejA2Kt6wFo2/94vjqhRGcr
         GLaDiEdUGR8D6sbMmciQ6uEHyyAyeVtwHkRqGRhn0xrHkV0vrXh4vY1nkU3Mei89sZ6N
         fOBA==
X-Gm-Message-State: AOAM5300+Xw+v5bt3IJbqGQU3ncRf3r3Xitfipkn/WrwhDRyRT7ED50C
        o9C5CcpecVty3d+keumUggGSCbmeVSkHFutU
X-Google-Smtp-Source: ABdhPJyCYUsbGp9/Kd2SfXnWygOLvEk99VhxzZs7ENvt5lm5mnoWuD/Qti3g6t2TGnlDk/Dr5pcO2g==
X-Received: by 2002:a05:620a:ec9:: with SMTP id x9mr6354273qkm.333.1613008353237;
        Wed, 10 Feb 2021 17:52:33 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:666f:3d4:2894:5ee9])
        by smtp.gmail.com with ESMTPSA id e15sm2496254qtq.43.2021.02.10.17.52.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Feb 2021 17:52:32 -0800 (PST)
Date:   Wed, 10 Feb 2021 20:52:27 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Jeff King <peff@peff.net>, Chris Torek <chris.torek@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 06/14] pkt-line: accept additional options in
 read_packetized_to_strbuf()
Message-ID: <YCSN260gqNV+DyTI@nand.local>
References: <pull.766.git.1610465492.gitgitgadget@gmail.com>
 <pull.766.v2.git.1612208747.gitgitgadget@gmail.com>
 <6a389a3533512acedfa1769c64296c1e19b16221.1612208747.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6a389a3533512acedfa1769c64296c1e19b16221.1612208747.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 01, 2021 at 07:45:39PM +0000, Johannes Schindelin via GitGitGadget wrote:
> diff --git a/pkt-line.c b/pkt-line.c
> index 528493bca21..f090fc56eef 100644
> --- a/pkt-line.c
> +++ b/pkt-line.c
> @@ -461,7 +461,7 @@ char *packet_read_line_buf(char **src, size_t *src_len, int *dst_len)
>  	return packet_read_line_generic(-1, src, src_len, dst_len);
>  }
>
> -ssize_t read_packetized_to_strbuf(int fd_in, struct strbuf *sb_out)
> +ssize_t read_packetized_to_strbuf(int fd_in, struct strbuf *sb_out, int options)
>  {
>  	int packet_len;
>
> @@ -477,7 +477,7 @@ ssize_t read_packetized_to_strbuf(int fd_in, struct strbuf *sb_out)
>  			 * that there is already room for the extra byte.
>  			 */
>  			sb_out->buf + sb_out->len, LARGE_PACKET_DATA_MAX+1,
> -			PACKET_READ_GENTLE_ON_EOF);
> +			options | PACKET_READ_GENTLE_ON_EOF);

This feels a little magical to me. Since read_packetized_to_strbuf only
has the one caller you mention, why not have the caller pass all of the
options (including PACKET_READ_GENTLE_ON_EOF)?

>  		if (packet_len <= 0)
>  			break;
>  		sb_out->len += packet_len;
> diff --git a/pkt-line.h b/pkt-line.h
> index 7f31c892165..150319a6f00 100644
> --- a/pkt-line.h
> +++ b/pkt-line.h
> @@ -145,8 +145,12 @@ char *packet_read_line_buf(char **src_buf, size_t *src_len, int *size);
>
>  /*
>   * Reads a stream of variable sized packets until a flush packet is detected.
> + *
> + * The options are augmented by PACKET_READ_GENTLE_ON_EOF and passed to
> + * packet_read.

Obviously this comment will need updating if you take my suggestion.

Thanks,
Taylor
