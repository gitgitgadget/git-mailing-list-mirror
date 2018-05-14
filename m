Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 334A51F406
	for <e@80x24.org>; Mon, 14 May 2018 05:10:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751664AbeENFKU (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 May 2018 01:10:20 -0400
Received: from mail-wm0-f53.google.com ([74.125.82.53]:55498 "EHLO
        mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751498AbeENFKT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 May 2018 01:10:19 -0400
Received: by mail-wm0-f53.google.com with SMTP id a8-v6so11090355wmg.5
        for <git@vger.kernel.org>; Sun, 13 May 2018 22:10:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=iGM8qIgnj7/lkm7Zweyd7VtpDPfddD3dMQoMVoMvRpk=;
        b=bLSNQZ3FqBl06KDdTqg2B57QCz3iTonpgZSZJ5QAgdunFmGcfmCeIt1OgSYcEhOdl4
         wAmnOUbTNkaVm8WnJDV3dklN2HZzAevvpbeYNUun+ZvneHmgBiZJbQIGJRP5gBmrWihk
         4dgCko1hMxHry1Rl7okeM7GeQsnOgyT2lYOrB9qu668PV5KxzL+aAbYFFb0MT+f1UOqb
         A7zUtXRZDNeddOeBdkBtXKB8npqw841735r3IfJQo7Z/2GfKmWb16og6UkFbFwlGICUw
         0RPKveT0hHW4faOSDW6qAwRlHdKkxzobtqedjyXwITd1GdOfxsxya9nPh34EKFye4NSr
         OQpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=iGM8qIgnj7/lkm7Zweyd7VtpDPfddD3dMQoMVoMvRpk=;
        b=N4xfIubyvTI3GBrJYeYbkbSSheZy0/b6rWSRHhZxyZYLENzKKQKXZQPbXrXUZbcAdv
         VJWPmSsxwc+n3kQ9rfffEcK6mao0P2zjPh3uI6JzAwKbjjumfyrEmo53sxAWeA//QzXi
         dUQrX+yWGyNU2wH+peaXAylzyH4HqCrvQVawwE3KPfybOsz5YnO5HOtyXPqdOHyvAtei
         B5H376xsxQO2rBbUZ4I4/AwPkxK8z7RrPUe3yp/5OK06JYMELsmaUbQOMSx/OUO1FbD5
         cgtRsW3gO9jOPdsHVhIZhXWAiXC4jvzUdyvEguPzDyNP3NfoKamEZ7aTSdOsCuIUQ5uD
         WSxw==
X-Gm-Message-State: ALKqPwfVL5GCawQ/ETLhiveqRCfG3br8Kix1ncBIDUsV8NnOb884qouI
        eKJ7ERQxCumtrw9TwfVUkoqA7x8F
X-Google-Smtp-Source: AB8JxZoOgHJK6lYg5l0Vswu2GadHHPsh5KnkwzSyD9q4RJgLFAB80/LmHOnc9Rq9t9/HYfebNuz2sg==
X-Received: by 2002:a1c:b54c:: with SMTP id e73-v6mr3745503wmf.121.1526274617919;
        Sun, 13 May 2018 22:10:17 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id s5-v6sm11274449wra.48.2018.05.13.22.10.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 13 May 2018 22:10:16 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 08/14] revision.c: use commit-slab for show_source
References: <20180512080028.29611-1-pclouds@gmail.com>
        <20180513055208.17952-1-pclouds@gmail.com>
        <20180513055208.17952-9-pclouds@gmail.com>
Date:   Mon, 14 May 2018 14:10:15 +0900
In-Reply-To: <20180513055208.17952-9-pclouds@gmail.com> (=?utf-8?B?Ik5n?=
 =?utf-8?B?dXnhu4VuIFRow6FpIE5n4buNYw==?=
        Duy"'s message of "Sun, 13 May 2018 07:52:02 +0200")
Message-ID: <xmqqfu2uddqg.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nguyễn Thái Ngọc Duy  <pclouds@gmail.com> writes:

> -	refname = commit->util;
> +	refname = *revision_sources_peek(&revision_sources, commit);

At first glance, I thought that the reason why this uses _peek() is
because the "sources" is expected to only sparsely be populated,
perhaps because get_tags_and_duplicates() annotates only the tips
mentioned on the command line via rev_cmdline mechanism and this
code does not want to auto-vivify the slot, only to read NULL from
it.

But the code that follows this point liberally uses refname without
checking if it is NULL, so I am not quite sure what is going on. In
any case, wouldn't *slab_peek() an anti-pattern?  You use _peek()
because you expect that a slot is not yet allocated for a commit,
you desire not to vivify all the slots for all the commits, and
instead you are prepared to see a NULL returned from the call.  But
I do not think that is what is happening here, so shouldn't it be
using _at() instead of _peek()?

>  	if (anonymize) {
>  		refname = anonymize_refname(refname);

>  		anonymize_ident_line(&committer, &committer_end);
> @@ -862,10 +864,11 @@ static void get_tags_and_duplicates(struct rev_cmdline_info *info)
>  		 * This ref will not be updated through a commit, lets make
>  		 * sure it gets properly updated eventually.
>  		 */
> -		if (commit->util || commit->object.flags & SHOWN)
> +		if (*revision_sources_at(&revision_sources, commit) ||
> +		    commit->object.flags & SHOWN)

Here it uses *slab_at() which makes more sense.

