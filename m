Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D72B91F42D
	for <e@80x24.org>; Fri,  1 Jun 2018 02:30:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751091AbeFACav (ORCPT <rfc822;e@80x24.org>);
        Thu, 31 May 2018 22:30:51 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:53532 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750726AbeFACav (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 May 2018 22:30:51 -0400
Received: by mail-wm0-f65.google.com with SMTP id a67-v6so98601wmf.3
        for <git@vger.kernel.org>; Thu, 31 May 2018 19:30:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=7yOqpdjamcascbBNQyJSjtaf+sKUgOEFB2HXSgCHPZo=;
        b=kZ7Zp1bpKOwdgmlmTk7yGkRrx8kWXbCb5HIZQBbB4FS0xNoLYltw0f+L5loHvWAv45
         DHaKw4KSDqu4+ocwxIjfRNeODIiO/PfDcxuoQ0CXYKl4urBugUuCx26ebi2DyQOvIIBb
         kAdj5DgOnsqpPWz3cfi/lyMGTlhczWLWq3kMVFUo1m09lU77eHIVlYVUBiM5MgIk+hah
         IcdhSnMATlrRk6kfNRgDpW6GUhdpSVAoX8QK74Aj1T1J34XVqJH/b5p0Y1EUtrgwrjBg
         G1tK8rulX/kPeW8gGHRYEaJNkSJad4DQJhRl9axzhFRiya8pmXbMZsWNr+iW2CVKrUXs
         sAeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=7yOqpdjamcascbBNQyJSjtaf+sKUgOEFB2HXSgCHPZo=;
        b=RUArd6bCkxV8+wOQGlNTtX7syFMJVxE2H+LRe6hPMgxKVNwz9lJoNvW8BSaGoAaT7/
         4DoPEMm5sY/+RH3Zlgi3nz+xEpfrbcoYVF8RKGB5sxEKlA4Y7VSb+l6OOHLHX5kwgb0P
         yma7viZ+iNctJloWGjB8MbwKqRaHhdEY6TIX0TRcbvim1T6R8ZfdXRpdlGyp0rs5qviT
         hDmmCOlMAfXpc8PeHBLHQDExW8hPIQpQzNvEyb5AWvbHfAPynkBCJrecWbxw1shtdFt0
         UovI7xh6r87WfbN42o5EK8jh7HFZHLomP4+9hFhZGXy1HAlLXU/OlH8XJMjYfxEooxRN
         PQMw==
X-Gm-Message-State: APt69E0a75/x1s5uyjv5LPvk2wv58+tBejRBL3PXnTbV9VwCaNrO3ugh
        Ml4jT1KosTOB0eoF6ud+oZk=
X-Google-Smtp-Source: ADUXVKLgXQZhI3YGIPQmMS9QfQ0a4qu8+OCVXMrEwMOkEKFnLXODJ4xCzegLQXq44kyoBQw4KtOdDA==
X-Received: by 2002:a1c:ea9b:: with SMTP id g27-v6mr1206089wmi.21.1527820249733;
        Thu, 31 May 2018 19:30:49 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id r3-v6sm18261032wrj.78.2018.05.31.19.30.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 31 May 2018 19:30:48 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <dstolee@microsoft.com>
Cc:     "git\@vger.kernel.org" <git@vger.kernel.org>,
        "sbeller\@google.com" <sbeller@google.com>,
        "jnareb\@gmail.com" <jnareb@gmail.com>,
        "stolee\@gmail.com" <stolee@gmail.com>
Subject: Re: [RFC PATCH 4/6] commit-graph: avoid writing when repo is shallow
References: <20180531174024.124488-1-dstolee@microsoft.com>
        <20180531174024.124488-5-dstolee@microsoft.com>
Date:   Fri, 01 Jun 2018 11:30:47 +0900
In-Reply-To: <20180531174024.124488-5-dstolee@microsoft.com> (Derrick Stolee's
        message of "Thu, 31 May 2018 17:41:14 +0000")
Message-ID: <xmqqd0xb9r1k.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <dstolee@microsoft.com> writes:

> Shallow clones do not interact well with the commit-graph feature for
> several reasons. Instead of doing the hard thing to fix those
> interactions, instead prevent reading or writing a commit-graph file for
> shallow repositories.

The latter instead would want to vanish, I would guess.

>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  commit-graph.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/commit-graph.c b/commit-graph.c
> index 95af4ed519..80e377b90f 100644
> --- a/commit-graph.c
> +++ b/commit-graph.c
> @@ -208,6 +208,9 @@ static void prepare_commit_graph(void)
>  		return;
>  	prepare_commit_graph_run_once = 1;
>  
> +	if (is_repository_shallow())
> +		return;
> +
>  	obj_dir = get_object_directory();
>  	prepare_commit_graph_one(obj_dir);
>  	prepare_alt_odb();
> @@ -711,6 +714,15 @@ void write_commit_graph(const char *obj_dir,
>  	int num_extra_edges;
>  	struct commit_list *parent;
>  
> +	/*
> +	 * Shallow clones are not supproted, as they create bad
> +	 * generation skips as they are un-shallowed.
> +	 */
> +	if (is_repository_shallow()) {
> +		warning("writing a commit-graph in a shallow repository is not supported");
> +		return;
> +	}
> +
>  	oids.nr = 0;
>  	oids.alloc = approximate_object_count() / 4;
