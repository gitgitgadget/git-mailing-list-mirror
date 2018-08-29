Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AD9091F404
	for <e@80x24.org>; Wed, 29 Aug 2018 17:14:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728239AbeH2VMU (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 Aug 2018 17:12:20 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33660 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727704AbeH2VMU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Aug 2018 17:12:20 -0400
Received: by mail-wm0-f66.google.com with SMTP id i134-v6so5012628wmf.0
        for <git@vger.kernel.org>; Wed, 29 Aug 2018 10:14:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:message-id:user-agent
         :mime-version;
        bh=vSrsAFCGJ69YHynaG4FjvxqK6w5e59VnGRi6HrgmZYY=;
        b=pjjIoEcvorSvET0h4IZF0KdbJWKCzKEPoWQBYFXdnSQ8eLBOs5nxxDJVhteiJnE0uN
         PMeEfXDoZ6G3NK8a43Uc+irPiAoCDP4GGjiDlS+bFjq7/F+ehr3PTGErjU9NYXZLbzo0
         iMANwK99jd0ik/fln0Vep9SziHV63Oy1OSZ3euRSEvK8sGZ81bCn8WJsfu+BnJ65o18A
         qziIAWor2zee8SsedElu3EyRsma6UA+j6zuNy65DXfya/gGE/XF+WNPYwbPponyFurvh
         W7q9VLEAuukLWdf/HbvtPV551zWVkndRMCONftDvBgOTbNZWTavBTR9sXEzIrFBsiL2h
         hygw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :message-id:user-agent:mime-version;
        bh=vSrsAFCGJ69YHynaG4FjvxqK6w5e59VnGRi6HrgmZYY=;
        b=sL5IHOqvFsqok8NkDo2o0VFe+AWGB4mQKejCDvzdkvOZhepgEQ+M17nR5vdQQoN3hE
         W3i6vU2hnMUtGY6LtS2X1QL3t/GFamQrPVKJ0ImUqGF8Ly+zRJLHc+wqzblE8/+CRIN1
         e9EbdVSCPaQg+F/fbPYEmPyRurrttkH4cl0SvY4Rty1+HO1oykdoeTYfDFwS2vxm8WS8
         KNCI0F3cMXQuaq9I62Oxt6wT73Spwkcvtf/UP/RA+r4/mhygj6VcG1i5kzPfDOLnsKRn
         H7adkUUVkTNb7ul9k1L823tYIw4+/ZLhcsul7Ua1+b0zJaIn2KQ+C1UmBjU/uDrbjhuq
         g1Zg==
X-Gm-Message-State: APzg51Cu5N6rxiG4U7BvYjknkEAsCPyG9xQ/usa7S579ZDaL3x0tuj5c
        vHNnrBIitIcgzO2QYHzKb/w=
X-Google-Smtp-Source: ANB0Vdb6gObSyEn4D7rrnHly8HwRkVeRIuSDdzbtgRBlHMMBvkxys6IexxHhbz39R2821HFMKQ1r0g==
X-Received: by 2002:a1c:e141:: with SMTP id y62-v6mr5002016wmg.138.1535562865292;
        Wed, 29 Aug 2018 10:14:25 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id x24-v6sm8629472wrd.13.2018.08.29.10.14.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 29 Aug 2018 10:14:24 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ben Peart <Ben.Peart@microsoft.com>
Cc:     "git\@vger.kernel.org" <git@vger.kernel.org>,
        "pclouds\@gmail.com" <pclouds@gmail.com>
Subject: Re: [PATCH v2 1/3] read-cache: speed up index load through parallelization
References: <20180823154053.20212-1-benpeart@microsoft.com>
        <20180829152500.46640-1-benpeart@microsoft.com>
        <20180829152500.46640-2-benpeart@microsoft.com>
Date:   Wed, 29 Aug 2018 10:14:24 -0700
Message-ID: <xmqq5zztccy7.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ben Peart <Ben.Peart@microsoft.com> writes:

> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index 1c42364988..79f8296d9c 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -2391,6 +2391,12 @@ imap::
>  	The configuration variables in the 'imap' section are described
>  	in linkgit:git-imap-send[1].
>  
> +index.threads::
> +	Specifies the number of threads to spawn when loading the index.
> +	This is meant to reduce index load time on multiprocessor machines.
> +	Specifying 0 or 'true' will cause Git to auto-detect the number of
> +	CPU's and set the number of threads accordingly. Defaults to 'true'.

"0 or 'true' means 'auto'" made me go "Huh?"

The "Huh?"  I initially felt comes from the fact that usually 0 and
false are interchangeable, but for this particular application,
"disabling" the threading means setting the count to one (not zero),
leaving us zero as a usable "special value" to signal 'auto'.

So the end result does make sense, especially with this bit ...

> diff --git a/config.c b/config.c
> index 9a0b10d4bc..3bda124550 100644
> --- a/config.c
> +++ b/config.c
> @@ -2289,6 +2289,20 @@ int git_config_get_fsmonitor(void)
> ...
> +	if (!git_config_get_bool_or_int("index.threads", &is_bool, &val)) {
> +		if (is_bool)
> +			return val ? 0 : 1;
> +		else
> +			return val;

... which says "'0' and 'true' are the same and yields 0, '1' and
'false' yields 1, and '2' and above will give the int".  

Adding something like

	You can disable multi-threaded code by setting this variable
	to 'false' (or 1).

may reduce the risk of a similar "Huh?" reaction by other readers.

> +struct load_cache_entries_thread_data
> +{
> +	pthread_t pthread;
> +	struct index_state *istate;
> +	struct mem_pool *ce_mem_pool;
> +	int offset, nr;
> +	void *mmap;
> +	unsigned long start_offset;
> +	struct strbuf previous_name_buf;
> +	struct strbuf *previous_name;
> +	unsigned long consumed;	/* return # of bytes in index file processed */
> +};

We saw that Duy's "let's not use strbuf to remember the previous
name but instead use the previous ce" approach gave us a nice
performance boost; I wonder if we can build on that idea here?

One possible approach might be to create one ce per "block" in the
pre-scanning thread and use that ce as the "previous one" in the
per-thread data before spawning a worker.

> +static unsigned long load_cache_entries(struct index_state *istate,
> +			void *mmap, size_t mmap_size, unsigned long src_offset)
> +{
> +	struct strbuf previous_name_buf = STRBUF_INIT, *previous_name;
> +	struct load_cache_entries_thread_data *data;
> +	int nr_threads, cpus, ce_per_thread;
> +	unsigned long consumed;
> +	int i, thread;
> +
> +	nr_threads = git_config_get_index_threads();
> +	if (!nr_threads) {
> +		cpus = online_cpus();
> +		nr_threads = istate->cache_nr / THREAD_COST;

Here, nr_threads could become 0 with a small index, but any value
below 2 makes us call load_all_cache_entries() by the main thread
(and the value of nr_thread is not used anyore), it is fine.  Of
course, forced test will set it to 2 so there is no problem, either.

OK.

> +	/* a little sanity checking */
> +	if (istate->name_hash_initialized)
> +		die("the name hash isn't thread safe");

If it is a programming error to call into this codepath without
initializing the name_hash, which I think is the case, this is
better done with BUG("").

The remainder of the patch looked good.  Thanks.
