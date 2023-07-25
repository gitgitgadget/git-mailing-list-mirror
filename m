Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7DC9EB64DD
	for <git@archiver.kernel.org>; Tue, 25 Jul 2023 22:51:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231909AbjGYWvd (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Jul 2023 18:51:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230415AbjGYWvO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jul 2023 18:51:14 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1882D5254
        for <git@vger.kernel.org>; Tue, 25 Jul 2023 15:48:26 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id 3f1490d57ef6-d1c988afebfso298372276.2
        for <git@vger.kernel.org>; Tue, 25 Jul 2023 15:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1690325240; x=1690930040;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yQYDQIyQayP9MCegryYTVOT6r+1bgu5jjwttYMrrvlo=;
        b=Mz++nQbg+Gvp+Ir8X1ecYbo+kXwCL4U+GRyvk4z3isYRVLu53c63U6P88AxrzDHY4R
         J+gyxYK8gYgZiPBdHcwu2aK+Sf47+nuzSQiUoauOyGiUvO+1SNNLHH3UxYqrs/fn+/p5
         LbulHMGK0acAJajVs2A+OjcdQ2/XCegWfaYabhtd0IfG18I67J8jkzTyu/UbrImnbKd+
         YyCdXLG4ORYEScPrmjl1uC9ZJ0sV0aGJ96cH069Ivg1DUoq/ad2zPZt48xbvDMhDnM1y
         SkKA07ZcWBKXyvDJ20R2pV2TlRF3/2Wj2TJ7s+vPykzlIUNbMUFQZZ3nATs+jojC/zz7
         9r1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690325240; x=1690930040;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yQYDQIyQayP9MCegryYTVOT6r+1bgu5jjwttYMrrvlo=;
        b=Joy/XSJ2U7NUXDCKut3LZQHM9LZHwgZsmjsNU1ceS+SRJ8xprx9/dXNi7jCp39ZJ0n
         mGzSjlRFGf7f+aVVdEXOh0nx0hAWefX/wQg0v5zkrXioL2c6B3YprTxV+aHnz5C0KlSq
         AKnujbDmgXns5QJotEEMAuoC3ZHdmAauxn7tmr4fLC0/EpzpwolLZ41QOVNxmqftiZDU
         dN3UrCDo2mn+q2sUyz5qDHnalgm/ZQZydeen/Cy5CfFH6j5ZDHmZZZ+kJ+t9gHaZYI89
         ODqvNndt0/suy9kYBgDx1/a3E8WjYoxUFdw/Lu11va6ngXNBgWXpFhegEth6BHpDEkre
         OJEA==
X-Gm-Message-State: ABy/qLa7T6EGrF0gmv18kus1lIJjYbtuM/oVtCtTWX7i6AVHGZ/JgW2P
        ffiSQKkgoBWJei2s/XGIkSUoEg==
X-Google-Smtp-Source: APBJJlFG29CtIzSPpTGPbuQWF7i8mqaq5R0XqYRTPp1Ow1pow393eEItsRHvAaqQOsNa6Of3LN3KSQ==
X-Received: by 2002:a0d:d755:0:b0:583:3fc1:54c5 with SMTP id z82-20020a0dd755000000b005833fc154c5mr496062ywd.45.1690325240360;
        Tue, 25 Jul 2023 15:47:20 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id k184-20020a0dfac1000000b005838c619a08sm3543087ywf.111.2023.07.25.15.47.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 15:47:20 -0700 (PDT)
Date:   Tue, 25 Jul 2023 18:47:19 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        John Cai <johncai86@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v3 4/8] repack: refactor finding pack prefix
Message-ID: <ZMBQ97ucRg9gO4gW@nand.local>
References: <20230705060812.2865188-1-christian.couder@gmail.com>
 <20230724085909.3831831-1-christian.couder@gmail.com>
 <20230724085909.3831831-5-christian.couder@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230724085909.3831831-5-christian.couder@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 24, 2023 at 10:59:05AM +0200, Christian Couder wrote:
> diff --git a/builtin/repack.c b/builtin/repack.c
> index 96af2d1caf..21e3b89f27 100644
> --- a/builtin/repack.c
> +++ b/builtin/repack.c
> @@ -783,6 +783,17 @@ static int write_cruft_pack(const struct pack_objects_args *args,
>  	return finish_pack_objects_cmd(&cmd, names, local);
>  }
>
> +static const char *find_pack_prefix(void)
> +{
> +	const char *pack_prefix;
> +	if (!skip_prefix(packtmp, packdir, &pack_prefix))

I wonder if this might be a good opportunity to pass "packtmp" and
"packdir" as arguments to the function. I know that these are globals,
but it at least nudges us in the right direction away from adding more
global variables.

Thanks,
Taylor
