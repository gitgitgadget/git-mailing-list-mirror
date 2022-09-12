Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E66E3ECAAD5
	for <git@archiver.kernel.org>; Mon, 12 Sep 2022 15:40:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230373AbiILPkf (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Sep 2022 11:40:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230380AbiILPk1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Sep 2022 11:40:27 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FA221A831
        for <git@vger.kernel.org>; Mon, 12 Sep 2022 08:40:19 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id e68so9014119pfe.1
        for <git@vger.kernel.org>; Mon, 12 Sep 2022 08:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date;
        bh=hKTOrOSG/HV8W0DZvEjmEPSGZbSz8ZALoCEDSBd5xhE=;
        b=kiGATOIg46KDmwc7/ebp1SSK+Z0qEedIeksrRto0neCjBhg1lW2/5+ZC8b24C/y0vc
         VxQbdppIdcqRafCTyBrmUWNy6y8nb9td73DD4qpM8ZnT8Q/3xfjOc0pjdzI1egApcZGQ
         oAxL59MBlTh8n8R/R5BvePWBDsBHOvTlWa0YXat4OCdekwmBdNKMXLXgP1RkHlMM4a+5
         Vv2j2Qh312D+x5WO4iUHE61NG7gDSaU1ibu3vGiDTI3+t06sbLHo63TH4Z45UPjdqbI0
         M5nyNIsjOF8TCFGC+rwtuiRAD+2plhICJ14Q8b8FX4TJL090IdPJfsQCdtQ3tr+6wm9Y
         p6HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date;
        bh=hKTOrOSG/HV8W0DZvEjmEPSGZbSz8ZALoCEDSBd5xhE=;
        b=ml6/CYv9C4ULG/FJhf1Xu19YobUzeVHSY8sAUZ6po0AVtn8IOKxiQ08NXPbcLgCCyu
         IA7RI5w9uHURAOI52tJ8DJTz3xnxZg7UqAnySX7tK6h7jvwes6Do18Wm5LxHWmUq+FAB
         2iX/z4aEOW74JQFIlEWOWqiBxK5MluFEnYwX9HUXwTNb+5MVMAUFLbdbohJpG2WpUZgB
         1LSjZ/w4wmuAZpxIoTI5+wbkuGAVbt+87UC8YGfhaGyUJ4SYyVUQ4i0NeTb/XnRkoKkN
         9wNZCcWmmXITZm7ug5OFpEbdMONhP0mwkCC5K3x2kx6AR4mTAnMsb0ZF2hGkkJgV+KOA
         UnnQ==
X-Gm-Message-State: ACgBeo2x6Vwhu6yviDkrIMiq1OF9rUXJ59jPH2Wgr2HoELjTKkgVfx0u
        hj+qWZfpNAdFPq55lDcut048Feg+kCU=
X-Google-Smtp-Source: AA6agR44juzBDBpijTsZ3zn2sK4cYee2C/VGBNJi2suI1G23NRdfnZkLlPjDqZRwymAalybuGjEtRA==
X-Received: by 2002:a63:4183:0:b0:41b:f6d3:8825 with SMTP id o125-20020a634183000000b0041bf6d38825mr24129771pga.193.1662997218097;
        Mon, 12 Sep 2022 08:40:18 -0700 (PDT)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id rw5-20020a17090b2c4500b002006f15ad4fsm5429380pjb.10.2022.09.12.08.40.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Sep 2022 08:40:17 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH 1/4] list-objects-filter: don't memset after releasing
 filter struct
References: <Yx1qwlpNbxGEiUgc@coredump.intra.peff.net>
        <Yx1q4crkHGNzwLhh@coredump.intra.peff.net>
Date:   Mon, 12 Sep 2022 08:40:16 -0700
In-Reply-To: <Yx1q4crkHGNzwLhh@coredump.intra.peff.net> (Jeff King's message
        of "Sun, 11 Sep 2022 00:58:09 -0400")
Message-ID: <xmqq5yhsha8v.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> If we see an error while parsing a "combine" filter, we call
> list_objects_filter_release() to free any allocated memory,
> and then use memset() to return the struct to a known state. But the
> release function already does that reinitializing. Doing it again is
> pointless.

Makes sense.

> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  list-objects-filter-options.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/list-objects-filter-options.c b/list-objects-filter-options.c
> index 6cc4eb8e1c..ea989db260 100644
> --- a/list-objects-filter-options.c
> +++ b/list-objects-filter-options.c
> @@ -187,10 +187,8 @@ static int parse_combine_filter(
>  
>  cleanup:
>  	strbuf_list_free(subspecs);
> -	if (result) {
> +	if (result)
>  		list_objects_filter_release(filter_options);
> -		memset(filter_options, 0, sizeof(*filter_options));
> -	}
>  	return result;
>  }
