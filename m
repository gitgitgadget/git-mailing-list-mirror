Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D09511F859
	for <e@80x24.org>; Wed, 24 Aug 2016 07:16:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754069AbcHXHQk (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Aug 2016 03:16:40 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:35421 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754065AbcHXHQj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Aug 2016 03:16:39 -0400
Received: by mail-it0-f68.google.com with SMTP id f6so1249683ith.2
        for <git@vger.kernel.org>; Wed, 24 Aug 2016 00:16:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=gQ/C7ALB2dWdXSNSHCoAbcLOhKi91/djwZwGRUt0+kA=;
        b=dQOcaGlzg/gG43qcW25dfoA0V+17pLHGqvDhEqyk/jWlsSlazJHXR91Q6FZKrXqKGk
         1UBxKIbyCK3TcjyT4xsj5QgyeVpBRYoL3w81zdy3QSN3oNDIE6n99z0+pxI2HelkO83h
         sfsEd6w8/FNE5+C9KyAQmBFM4xtV9GeAXVOIoHu3pcf7lgBCzxKRJgAwhaKQl72VknSE
         ZvAGVTwWgWGZ0RI8x5G/eU35NFTEHa4r0Azg2T1fldya+icClwsXHfhYmDNi+lTx+kL4
         unZyqSuF3Ix7bBzUCO7bHU4dt7C/LAhU4aCLieY0vZvDdZd28cMGgUXKo5Awe0+bTn+f
         J13g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=gQ/C7ALB2dWdXSNSHCoAbcLOhKi91/djwZwGRUt0+kA=;
        b=DuAygVA+gh6WyqnlKdDatEKKPC17XIcwTW1SMeOMkqcmu5vK+kBEIQBYelgqA21qN2
         88uhGyYYFQ+0Dolj0KeVluupAgsQoyV/0X+K0CxobtBB5S05YNLf10FLeanogRtCHMqB
         WTRd5dD4WMbteIik2omXsUuj6SRcZ2mTq3eDRLp5O/4l7yQCkFFWMfaflQDObwNJ6hP3
         k/NQhokqSD7O5e/Jl1S8X889TUHXF/RIZkcsh77tqL9aY0YKMb94469TsErSNA1rbyN5
         Prlc46VV2/ujFRl05PDInxEBc+p7XFXZhyzmwvpKN5V6aj9G78Ri2PkZ/UCf1AnH233w
         r2hA==
X-Gm-Message-State: AEkoous19DHZ/y8ZB12DjA182AzB3zRwCabuo6NAR1SI/16fXGZv6dupCTKpsooWtKwqEG3ZjCYxknY4nxBwKA==
X-Received: by 10.36.196.133 with SMTP id v127mr31529904itf.84.1472022999073;
 Wed, 24 Aug 2016 00:16:39 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.79.130.1 with HTTP; Wed, 24 Aug 2016 00:16:38 -0700 (PDT)
In-Reply-To: <e00df1449af0d8c55000a93c734d8a241b1cb5f0.1471968378.git.johannes.schindelin@gmx.de>
References: <cover.1471968378.git.johannes.schindelin@gmx.de> <e00df1449af0d8c55000a93c734d8a241b1cb5f0.1471968378.git.johannes.schindelin@gmx.de>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 24 Aug 2016 03:16:38 -0400
X-Google-Sender-Auth: q2rNun-mX-3yTroqvmyIH_13O90
Message-ID: <CAPig+cTCotTDT83x9=q5ORR1ZWR9oewvXiun9sjvEbTV8OuChA@mail.gmail.com>
Subject: Re: [PATCH 02/15] sequencer: lib'ify do_recursive_merge()
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 23, 2016 at 12:06 PM, Johannes Schindelin
<johannes.schindelin@gmx.de> wrote:
> To be truly useful, the sequencer should never die() but always return
> an error.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
> diff --git a/sequencer.c b/sequencer.c
> @@ -303,7 +303,8 @@ static int do_recursive_merge(struct commit *base, struct commit *next,
>         if (active_cache_changed &&
>             write_locked_index(&the_index, &index_lock, COMMIT_LOCK))
>                 /* TRANSLATORS: %s will be "revert" or "cherry-pick" */
> -               die(_("%s: Unable to write new index file"), action_name(opts));
> +               return error(_("%s: Unable to write new index file"),
> +                       action_name(opts));

Does this need to rollback the lockfile before returning?

A cursory scan of read-cache.c:do_write_locked_index() seems to
indicate that lockfile disposition is not handled automatically in
case of error (unless I'm misreading).

>         rollback_lock_file(&index_lock);
>
>         if (opts->signoff)
