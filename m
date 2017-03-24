Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CBC1F1FC19
	for <e@80x24.org>; Fri, 24 Mar 2017 16:42:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936489AbdCXQmk (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Mar 2017 12:42:40 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:33485 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936353AbdCXQmj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Mar 2017 12:42:39 -0400
Received: by mail-pg0-f67.google.com with SMTP id 79so1453889pgf.0
        for <git@vger.kernel.org>; Fri, 24 Mar 2017 09:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=d0LPqAU9eD38AIqhdW9znCDHOcGDZsxe3ltKy6dOLO0=;
        b=ZsLBlidMPGTaywmw1Ry3KOefnDkB7spfHZE0hZzGWtjul4CdEPFwZ2ttzcvzU9180A
         NAmq8j/niKsnkNtTr6gc6TIZgO3OeS9sFlW7XTbNq0ENgte6LSpFRqv9SVhXdmQqUxdL
         1m+2fsv0GDPvph2r49aZPdit12NTXQgnSus17sv1UN9dJLYvYGCAYOja4kTl6jQCA3xX
         s+xAt+Fk2ZEinjAku6iQxxNZBfRRl/zc/+K54arI0NA5OvX17EmGd170qR8BzPvEWFbF
         gupVSWwo8VW6As+IDdihEYMb/ofu2+JePM/IYbv9P4ndTCp3DcyOc7n57BH71jTomBfF
         HRkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=d0LPqAU9eD38AIqhdW9znCDHOcGDZsxe3ltKy6dOLO0=;
        b=KqMz5b2COcJVvyaqdWJB5S56qL8bkhINn/s+QuMlyVEfWkZIKbGWLrYDVXD++C/aeH
         FGzQL0OnoZKXWWywFGbDezP+wiVnIRswaOzTx8RtE+/BhynVi3Q0Q0QzIftkI/LZ3QYv
         uxmslnjuxmPuUBeswWTo8XyT5EXs6SHJE8x8s5cfA7D2p+3pPzeBNj0Qot1YAj5y84V9
         4ohFvoysOD5/xhpSpeIcrEFOAR5vuBd2xU59a5fj9C364KOiGwcG3qAdkUitprb05uYv
         F0nwucOnNtzUNaI9InTE+1qBEi245uYlx2jG6p9JLLlpfTENwIph2498NPK3aZlN15lU
         m1Jg==
X-Gm-Message-State: AFeK/H3ywSf/A7eexvNlOq7CvYWesnoVcOieWAQHVXFDaCtgyhohOgt5pRvQSIdcDd91Ow==
X-Received: by 10.99.231.83 with SMTP id j19mr10089967pgk.50.1490373343237;
        Fri, 24 Mar 2017 09:35:43 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:1000:5b10:8597:ae41:db75:6a97])
        by smtp.gmail.com with ESMTPSA id x15sm5712552pgc.16.2017.03.24.09.35.42
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 24 Mar 2017 09:35:42 -0700 (PDT)
Date:   Fri, 24 Mar 2017 09:35:40 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     git@jeffhostetler.com
Cc:     git@vger.kernel.org, gitster@pobox.com, peff@peff.net,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH] read-cache: call verify_hdr() in a background thread
Message-ID: <20170324163540.GB31294@aiede.mtv.corp.google.com>
References: <1490362071-46932-1-git-send-email-git@jeffhostetler.com>
 <1490362071-46932-2-git-send-email-git@jeffhostetler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1490362071-46932-2-git-send-email-git@jeffhostetler.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

git@jeffhostetler.com wrote:

> From: Jeff Hostetler <jeffhost@microsoft.com>
>
> Teash do_read_index() in read-cache.c to call verify_hdr()

s/Teash/Teach/

> in a background thread while the forground thread parses

s/forground/foreground/

> the index and builds the_index.
>
> This is a performance optimization to reduce the overall
> time required to get the index into memory.
>
> Testing on Windows (using the OpenSSL SHA1 routine) showed
> that parsing the index and computing the SHA1 take almost
> equal time, so this patch effectively reduces the startup
> time by 1/2.
>
> Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>

Nice.  Do you have example commands I can run to reproduce
that benchmark?  (Even better if you can phrase that as a
patch against t/perf/.)

[...]
> --- a/read-cache.c
> +++ b/read-cache.c
> @@ -1564,6 +1564,83 @@ static void post_read_index_from(struct index_state *istate)
>  	tweak_untracked_cache(istate);
>  }
>  
> +#ifdef NO_PTHREADS
> +
> +struct verify_hdr_thread_data {
> +	struct cache_header *hdr;
> +	size_t size;

'size' appears to always be cast to an unsigned long when it's
used.  Why not use unsigned long consistently?

> +};
> +
> +/*
> + * Non-threaded version does all the work immediately.
> + * Returns < 0 on error or bad signature.
> + */
> +static int verify_hdr_start(struct verify_hdr_thread_data *d)
> +{
> +	return verify_hdr(d->hdr, (unsigned long)d->size);
> +}
> +
> +static int verify_hdr_finish(struct verify_hdr_thread_data *d)
> +{
> +	return 0;
> +}
> +
> +#else
> +
> +#include <pthread.h>

Please put this at the top of the file with other #includes.  One
simple way to do that is to #include "thread-utils.h" at the top of
the file unconditionally.

> +
> +/*
> + * Require index file to be larger than this threshold before
> + * we bother using a background thread to verify the SHA.
> + */
> +#define VERIFY_HDR_THRESHOLD    (1024)

nits: (1) no need for parens for a numerical macro like this
(2) comment can be made briefer and more explicit:

/*
 * Index size threshold in bytes before it's worth bothering to
 * use a background thread to verify the index file.
 */

How was this value chosen?

> +
> +struct verify_hdr_thread_data {
> +	pthread_t thread_id;
> +	struct cache_header *hdr;
> +	size_t size;
> +	int result;
> +};

All structs are data.  Other parts of git seem to name this kind of
callback cookie *_cb_data, so perhaps verify_hdr_cb_data?

On the other hand this seems to also be used by the caller as a handle
to the async verify_hdr process. Maybe verify_hdr_state?

This seems to be doing something similar to the existing 'struct
async' interface.  Could it use that instead, or does it incur too
much overhead?  An advantage would be avoiding having to handle the
NO_PTHREADS ifdef-ery.

> +
> +/*
> + * Thread proc to run verify_hdr() computation in a background thread.
> + */
> +static void *verify_hdr_thread_proc(void *_data)

Please don't name identifiers with a leading underscore --- those are
reserved names.

> +{
> +	struct verify_hdr_thread_data *d = _data;
> +	d->result = verify_hdr(d->hdr, (unsigned long)d->size);
> +	return NULL;
> +}
> +
> +/*
> + * Threaded version starts background thread and returns zero
> + * to indicate that we don't know the hash is bad yet.  If the
> + * index is too small, we just do the work imediately.
> + */
> +static int verify_hdr_start(struct verify_hdr_thread_data *d)

This comment restates what the code says.  Is there background or
something about the intent behind the code that could be said instead
to help the reader?  Otherwise I'd suggest removing the comment.

[...]
> @@ -1574,6 +1651,7 @@ int do_read_index(struct index_state *istate, const char *path, int must_exist)
>  	void *mmap;
>  	size_t mmap_size;
>  	struct strbuf previous_name_buf = STRBUF_INIT, *previous_name;
> +	struct verify_hdr_thread_data data;
>  
>  	if (istate->initialized)
>  		return istate->cache_nr;
> @@ -1600,7 +1678,10 @@ int do_read_index(struct index_state *istate, const char *path, int must_exist)
>  	close(fd);
>  
>  	hdr = mmap;
> -	if (verify_hdr(hdr, mmap_size) < 0)
> +
> +	data.hdr = hdr;
> +	data.size = mmap_size;
> +	if (verify_hdr_start(&data) < 0)
>  		goto unmap;

What happens if there is an error before the code reaches the end of
the function?  I think there needs to be a verify_hdr_finish call in
the 'unmap:' cleanup section.

The rest looks reasonable.

Thanks and hope that helps,
Jonathan
