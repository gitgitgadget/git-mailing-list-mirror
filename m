Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7B4E51F404
	for <e@80x24.org>; Fri,  7 Sep 2018 21:10:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727145AbeIHBwy (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Sep 2018 21:52:54 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:53544 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726443AbeIHBwy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Sep 2018 21:52:54 -0400
Received: by mail-wm0-f68.google.com with SMTP id b19-v6so15945013wme.3
        for <git@vger.kernel.org>; Fri, 07 Sep 2018 14:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=vP5wrVumiQaCGpSribfaAbx7GQiDswhJtUlp77PmHiw=;
        b=stP9cyaDxyyOUNX22gQC+hinD2So1ZXLOYpDm7ISjoRq+54hdqtuFxlMVItEI7L5fo
         IeXhtAsDr/FPh8o+cwsg8Rw6Wg6gcqDZVcovTgEM3XoYtbTi0qbBcXZgTX5sFHn/YBKt
         1yW8Oanx6U9Vp2UQWI7ezXG0Aq2An4DtBFClqAXWN1rE2CmzGUtyyFcQ0RF1qTjVyerF
         ul0nxnkAwZxD4zkpehSLf/bGKUNdW9I2NQZzlQlFmfrWkXjlaNiylmozM/4HLXy185D0
         cid4AzBwEQAZbMvyichZ18SL5fDt4nqAEkEdrT5sMdw/EvQTJoJj70h3IrF5/nSq6VS+
         tcqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=vP5wrVumiQaCGpSribfaAbx7GQiDswhJtUlp77PmHiw=;
        b=RDg9ysOlVrEcXfnu0IpwS5ggQyD3VhOgSgMM8+uPhpzxNpwav1py/9/OVcTFNoI3M4
         8q/e1iWGuMIXgM5wTGq07aJPaaRwIySHyMK2jXjWMoLFJf9s6/EMttDA91ima1LwI2/T
         4SV1j0/yeF4n0BzG1obP/GELeoDfT1xXMoY8uVkP66Xkj0uPbX9+PVp7SvXZccBMFk0x
         htGxbiVX8XakiDXC2B9WWyb5dmKBB8S796MW9PwE79QU8FPk0eLOGay4cy4d80UxPNsU
         J7Z/iyvFLvi4LRPWcLRMBvNA+JfK3XYFx3V7RR2fTzFRfcEx90bwU8CE3+hvfLRFWiie
         7OAg==
X-Gm-Message-State: APzg51CO1ZosJOamriO0K4fJF6ZEE0dOsEuit4O/zDDYl/+eIq3klVK3
        HiplUXgQKq90b35yzak5d4k=
X-Google-Smtp-Source: ANB0VdY2KBu8e3YAmHAaVbMirM7RVM/CnsxlX8vgMxbrRMBcvcBxw+Z614cjNBsClo2au+AdD9aMsQ==
X-Received: by 2002:a1c:7711:: with SMTP id t17-v6mr6463268wmi.35.1536354607355;
        Fri, 07 Sep 2018 14:10:07 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id z3-v6sm5998656wmf.12.2018.09.07.14.10.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 07 Sep 2018 14:10:06 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ben Peart <benpeart@microsoft.com>
Cc:     "git\@vger.kernel.org" <git@vger.kernel.org>,
        "pclouds\@gmail.com" <pclouds@gmail.com>,
        Ben Peart <Ben.Peart@microsoft.com>
Subject: Re: [PATCH v3 3/4] read-cache: load cache extensions on a worker thread
References: <20180823154053.20212-1-benpeart@microsoft.com>
        <20180906210227.54368-1-benpeart@microsoft.com>
        <20180906210227.54368-4-benpeart@microsoft.com>
Date:   Fri, 07 Sep 2018 14:10:05 -0700
In-Reply-To: <20180906210227.54368-4-benpeart@microsoft.com> (Ben Peart's
        message of "Thu, 6 Sep 2018 21:03:58 +0000")
Message-ID: <xmqqbm99vwsy.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ben Peart <benpeart@microsoft.com> writes:

> +struct load_index_extensions
> +{
> +#ifndef NO_PTHREADS
> +	pthread_t pthread;
> +#endif
> +	struct index_state *istate;
> +	void *mmap;
> +	size_t mmap_size;
> +	unsigned long src_offset;

If the file format only allows uint32_t on any platform, perhaps
this is better specified as uint32_t?  Or if this is offset into
a mmap'ed region of memory, size_t may be more appropriate.

Same comment applies to "extension_offset" we see below (which in
turn means the returned type of read_eoie_extension() function may
want to match).

> + };

Space before '}'??

> +
> +static void *load_index_extensions(void *_data)
> +{
> +	struct load_index_extensions *p = _data;

Perhaps we are being superstitious, but I think our code try to
avoid leading underscore when able, i.e.

	load_index_extensions(void *data_)
	{
		struct load_index_extensions *p = data;

> +	unsigned long src_offset = p->src_offset;
> +
> +	while (src_offset <= p->mmap_size - the_hash_algo->rawsz - 8) {
> +		/* After an array of active_nr index entries,
> +		 * there can be arbitrary number of extended
> +		 * sections, each of which is prefixed with
> +		 * extension name (4-byte) and section length
> +		 * in 4-byte network byte order.
> +		 */
> +		uint32_t extsize;
> +		memcpy(&extsize, (char *)p->mmap + src_offset + 4, 4);
> +		extsize = ntohl(extsize);

The same "ntohl(), not get_be32()?" question as the one for the
previous step applies here, too.  I think the answer is "the
original was written that way" and that is acceptable, but once this
series lands, we may want to review the whole file and see if it is
worth making them consistent with a separate clean-up patch.

I think mmap() and munmap() are the only places that wants p->mmap
and mmap parameters passed around in various callchains to be of
type "void *"---I wonder if it is simpler to use "const char *"
throughout and only cast it to "void *" when necessary (I suspect
that there is nowhere we need to cast to or from "void *" explicitly
if we did so---assignment and argument passing would give us an
appropriate cast for free)?

> +		if (read_index_extension(p->istate,
> +			(const char *)p->mmap + src_offset,
> +			(char *)p->mmap + src_offset + 8,
> +			extsize) < 0) {
> +			munmap(p->mmap, p->mmap_size);
> +			die("index file corrupt");
> +		}
> +	...
> @@ -1907,6 +1951,11 @@ ...
> ...
> +	p.mmap = mmap;
> +	p.mmap_size = mmap_size;
> +
> +#ifndef NO_PTHREADS
> +	nr_threads = git_config_get_index_threads();
> +	if (!nr_threads)
> +		nr_threads = online_cpus();
> +
> +	if (nr_threads >= 2) {
> +		extension_offset = read_eoie_extension(mmap, mmap_size);
> +		if (extension_offset) {
> +			/* create a thread to load the index extensions */
> +			p.src_offset = extension_offset;
> +			if (pthread_create(&p.pthread, NULL, load_index_extensions, &p))
> +				die(_("unable to create load_index_extensions_thread"));
> +		}
> +	}
> +#endif

Makes sense.
