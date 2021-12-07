Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DBCFC433F5
	for <git@archiver.kernel.org>; Tue,  7 Dec 2021 15:30:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237545AbhLGPe0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Dec 2021 10:34:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231377AbhLGPeZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Dec 2021 10:34:25 -0500
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13CB4C061574
        for <git@vger.kernel.org>; Tue,  7 Dec 2021 07:30:55 -0800 (PST)
Received: by mail-qt1-x830.google.com with SMTP id 8so14597547qtx.5
        for <git@vger.kernel.org>; Tue, 07 Dec 2021 07:30:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=ilSJRhB4zqQBp07Zq5KhpNGyltPHV721xkuaJp3teGw=;
        b=XY+fviiICT8+zCF2zEAAx7sJn+D88HhXbink8NGDEW/VK+8sYI+/ef0Rhjv/W3kawW
         YYbunpdKQ5ZcjY8rUPLP+TPUvPKT917djFeiHAlCVqGJK3spxa8zGiQ4Ceec8CGJ4lI0
         Gz36W0qwibp3vnWYgNIqtQuoQ15/EtbdDmX+xhvABDEU3U6qnjnm385XFwQPxfJIyBGr
         nx5wHws+eU3qx3Cv1XTKKxLO7g8A2EM8jG2VJ/nRqaIDyjitbGwtT/7EYpXZjNlsAoL7
         2u2hKFsVG4ogx1EhTcz1ByKRUnLRXIgXUTwe0hZo3JG0v2QV8asD7Y+fpIdIJvjgPTiX
         Mk5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ilSJRhB4zqQBp07Zq5KhpNGyltPHV721xkuaJp3teGw=;
        b=4nYC0eakrPuGah7HzGF1qS2uMIHL1kMp4QlSxkBlhjyz023SqPjceHqxoNuePgPUio
         BbZezdv+7e1Z2H+6cVJkc4yGQCQypeHagErLj4xnQYFDRpJp7JzknWFAMvg5bHPF27D8
         RBWLAyYC/48nHrUvsma2ZNUZ1RV6VP1zTJAxc+Hr8LV0lykTrVzY2sbJJta5ORNLnQ8i
         JY3YzKzbhVl9m7x8LSROdANUWLQ2gni5jOgbEWDpRqWDXx/Civ/r8G5wB4gzd1PTGFMy
         kkA4ABJ2tffduvog7xBr74FbsuAzCZDPbJEuD91byMJO9SqfuWefCWXn+Z+rU7quLZWp
         3EHg==
X-Gm-Message-State: AOAM533dx/hSaV7rlLzETIerEzg3klmWW3zDRhN++kRBzy+0D8xjdMEd
        fdMCEE8ZicbFPUg/LFTm2og=
X-Google-Smtp-Source: ABdhPJzNUhj0CIXdBt4ey2YivdnOlJbEwtlqrPG6EsAY55lI2L42aloJFr3n836gOlFc0PZuhrp31A==
X-Received: by 2002:a05:622a:5:: with SMTP id x5mr48892657qtw.110.1638891053852;
        Tue, 07 Dec 2021 07:30:53 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:1d54:16a5:5c65:4b5? ([2600:1700:e72:80a0:1d54:16a5:5c65:4b5])
        by smtp.gmail.com with ESMTPSA id u10sm23811qtx.3.2021.12.07.07.30.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Dec 2021 07:30:53 -0800 (PST)
Message-ID: <865b99dd-0b18-9a07-49c1-3959a777c685@gmail.com>
Date:   Tue, 7 Dec 2021 10:30:52 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH 11/17] builtin/pack-objects.c: --cruft with expiration
Content-Language: en-US
To:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Cc:     gitster@pobox.com, larsxschneider@gmail.com, peff@peff.net,
        tytso@mit.edu
References: <cover.1638224692.git.me@ttaylorr.com>
 <37fda94785f1e689c7a7c32e69c6ff16fee7da4f.1638224692.git.me@ttaylorr.com>
From:   Derrick Stolee <stolee@gmail.com>
In-Reply-To: <37fda94785f1e689c7a7c32e69c6ff16fee7da4f.1638224692.git.me@ttaylorr.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/29/2021 5:25 PM, Taylor Blau wrote:

> +static void enumerate_and_traverse_cruft_objects(struct string_list *fresh_packs)
> +{
...
> +	/*
> +	 * Re-mark only the fresh packs as kept so that objects in
> +	 * unknown packs do not halt the reachability traversal early.
> +	 */
> +	for (p = get_all_packs(the_repository); p; p = p->next)
> +		p->pack_keep_in_core = 0;
> +	mark_pack_kept_in_core(fresh_packs, 1);

Are we ever going to recover this pack_keep_in_core state? Should we
be saving it somewhere so we can return without mutating this state
permanently?

> +	if (prepare_revision_walk(&revs))
> +		die(_("revision walk setup failed"));
> +	if (progress)
> +		progress_state = start_progress(_("Traversing cruft objects"), 0);
> +	nr_seen = 0;
> +	traverse_commit_list(&revs, show_cruft_commit, show_cruft_object, NULL);
> +
> +	stop_progress(&progress_state);
> +}
> +
>  static void read_cruft_objects(void)
>  {
>  	struct strbuf buf = STRBUF_INIT;
> @@ -3515,7 +3597,7 @@ static void read_cruft_objects(void)
>  	mark_pack_kept_in_core(&discard_packs, 0);
>  
>  	if (cruft_expiration)
> -		die("--cruft-expiration not yet implemented");
> +		enumerate_and_traverse_cruft_objects(&fresh_packs);
>  	else
>  		enumerate_cruft_objects();

>  basic_cruft_pack_tests never
> +basic_cruft_pack_tests 2.weeks.ago

I'm surprised these tests didn't require any changes to adapt to the
new expiration date. But I suppose none of the mtimes were older than
two weeks ago?

I continue to miss something in these tests, because I don't see how
things are becoming unreachable.

Thanks,
-Stolee
