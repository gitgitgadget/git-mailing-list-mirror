Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D992EB64D9
	for <git@archiver.kernel.org>; Mon, 19 Jun 2023 16:10:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbjFSQKb (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Jun 2023 12:10:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjFSQKa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Jun 2023 12:10:30 -0400
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4185F95
        for <git@vger.kernel.org>; Mon, 19 Jun 2023 09:10:29 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-570282233ceso30676987b3.1
        for <git@vger.kernel.org>; Mon, 19 Jun 2023 09:10:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1687191028; x=1689783028;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=UZfB+PahgDyIyiZN3pUNiPwr9pyHKvsLWFva2fpjpjg=;
        b=n2IBH+6Mv0nZ8hkKnWPnEfkJk324ukTkMuJuWm+qnpZcF9kHP4O1TlRYAXwpWKj5rO
         qXO6t9EeEQUp0L9ZTMej7StUNOwTampywXhv6W5qCyOyGxzMt2FLHc4ahTmabKDbj5JP
         nqhsqHfNEbfAWVochb3OPquAhqPzdzrsm2stqhGQ2pBTJ3/gqN7H6RxSZK00tmnX6D7p
         3iy/VDkEYvRmkLeE3Gi0llxd4nTmr8qUN/KD4SCH89xAbAiZMuMAg9QueWcup86VJ2tW
         /k+AA8gWbHZPU0L498doJ0A1Qjt7Wc4hCdIeAO3UaLDoQI8ip5J3VCJjhOS3Cq+5iuLz
         8VoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687191028; x=1689783028;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UZfB+PahgDyIyiZN3pUNiPwr9pyHKvsLWFva2fpjpjg=;
        b=FaS9PBR3kVTTXUdwI50GDs2S9sVZZ+Ycf8h4fN8qt19+dmSSwWGH0rAdCby1bcfQcB
         t6uHII6WH5JIl8T8cOwSfkjiMqODI+xLBLABUjvrOs7sSOTn+utbd0wqdJ+6US9nM6yg
         4zw947n6jzI+tQ6jveeFujCvX/dMVKF//seI16bQbBZnIx3+8thQrOezludLFoz8O6Dh
         nqdBTkX6WeQw2yRxF7VKrWhulc3fmZNzHRcBLURELuLHhps5GtVl79xEN7fD+YkMyF4c
         Rq+/DI2nxYJmsyuuJW5tuxgykCmPF8XyGhto517CLsGbKA578wwMFywU9lJnx+VFOcCt
         iloA==
X-Gm-Message-State: AC+VfDyJKujInSN2h6eaQZL4d6rDtR6bnEEIjYLWuBkhVh9VTuzLeswW
        PICAU3XeYxWRm30gk/NoT42AseGeuN6mNhOdy+yfj4Y1
X-Google-Smtp-Source: ACHHUZ707l7W84IwxHE2x+fyOnSc3K05o9dlEzHOLIE3ZfDFxakW7XnwXGDuE0lAYpVACYPqJRohMg==
X-Received: by 2002:a81:dd02:0:b0:56d:17cf:2d04 with SMTP id e2-20020a81dd02000000b0056d17cf2d04mr8024333ywn.41.1687191028416;
        Mon, 19 Jun 2023 09:10:28 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id m17-20020a0dca11000000b0056974f3f32bsm35508ywd.1.2023.06.19.09.10.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jun 2023 09:10:28 -0700 (PDT)
Date:   Mon, 19 Jun 2023 12:10:25 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: [PATCH 2/5] strbuf: factor out strbuf_expand_step()
Message-ID: <ZJB98Q6NHbK6D1uB@nand.local>
References: <767baa64-20a6-daf2-d34b-d81f72363749@web.de>
 <caf8e100-1308-cb4e-d61a-4e15ee3f47f7@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <caf8e100-1308-cb4e-d61a-4e15ee3f47f7@web.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jun 17, 2023 at 10:41:44PM +0200, René Scharfe wrote:
> diff --git a/strbuf.c b/strbuf.c
> index 08eec8f1d8..a90b597da1 100644
> --- a/strbuf.c
> +++ b/strbuf.c
> @@ -415,19 +415,24 @@ void strbuf_vaddf(struct strbuf *sb, const char *fmt, va_list ap)
>  	strbuf_setlen(sb, sb->len + len);
>  }
>
> +int strbuf_expand_step(struct strbuf *sb, const char **formatp)
> +{
> +	const char *format = *formatp;
> +	const char *percent = strchrnul(format, '%');

Can format be NULL here? Obviously formatp is never NULL since it is
`&s`, but we guarded the while loop in the pre-image with `while (*s)`
and I am not sure that **formatp is always non-NULL here.

Thanks,
Taylor
