Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4B7791F453
	for <e@80x24.org>; Thu, 24 Jan 2019 08:35:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727069AbfAXIf3 (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 Jan 2019 03:35:29 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:39075 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725939AbfAXIf3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Jan 2019 03:35:29 -0500
Received: by mail-io1-f67.google.com with SMTP id k7so4008011iob.6
        for <git@vger.kernel.org>; Thu, 24 Jan 2019 00:35:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YlJDCXW0pMgTgoqPrB/mw5Sk4Bt0OYddgs1Jxn3S3xI=;
        b=SOVEMxzNPoU+2klE9QNo65uoNWwQKGQkSbd/H3DDYd/I7qocXxn4LTOhilQmFIV+ZX
         cRlhxhdlCircKldIBk2GQrPrgayuzJjpYYcpzNHrls/V6cvMwbEcqPXiU2RIce/5iln2
         x1JgS37UuIGYmL+WdcAm1tfOwun1y2GSJ430Q93yLKBq4nz9y7bZSCLJOGZKWglasC/o
         ZCn8f7zRlq1TVlC9zuBIG8dg6tpf3kxSNem9apHcsAbCTiLEbpV0F5qGSLtXHReOrAOi
         YSkiUtUXSy42CzunrNlNVbqAQHuD3Ze+PC1HyAg0bMpTDsZtzP1OkVj7HPYObg7ph3xM
         6S0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YlJDCXW0pMgTgoqPrB/mw5Sk4Bt0OYddgs1Jxn3S3xI=;
        b=QLUd+p/BbwOxQ3D7FhYIBwgjmdf9kLMzp1b3fDfHLDbrv8kmy6QJ0j488w9JCsSnCl
         jNRMLGio/KoUoxwo8l2AJQWnWxUSpqHUw60EUPf3FjLOHqW/3o8+8DKVsb3f1daEPlg9
         KUeQQRNNL/yhm67Fla2bn03+O4s5NMqcRViJO2Xk9sgV97iI9veJUSU8CZoKunW7FvgJ
         C8RONulYXa4+Ml/whJnPGXLMIlyIaAMI579xqY4zk6iY5puvyBVIHmMgG1jd2KSAsSNg
         KLr5ZeARAKrlTiQXsjvK1lQoc9gVf8nODUX78gw+9CUQ1IQVywqVSdQVR+6zlnKpW28G
         I0gg==
X-Gm-Message-State: AHQUAubxPIBTbzkR3W+z4AW4E6U0ar4yi/CkeNPMGHtbykZFQtkM07Nm
        PRMqtV2qY+m7aOa7oMVXKLRwY3Y0icWWl6NmGVc=
X-Google-Smtp-Source: AHgI3Ibm1oKaTf4nCaVm+H9OLNDIO11fJIm7xoguE1SRnvCBZGttXkqql2jBeidlG6OQCgj0N+yB9Dl5cGqPzCGXiWk=
X-Received: by 2002:a5d:9456:: with SMTP id x22mr2739899ior.282.1548318928313;
 Thu, 24 Jan 2019 00:35:28 -0800 (PST)
MIME-Version: 1.0
References: <20190124010521.28452-1-phogg@novamoon.net>
In-Reply-To: <20190124010521.28452-1-phogg@novamoon.net>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Thu, 24 Jan 2019 15:35:02 +0700
Message-ID: <CACsJy8DUPtC9bz7nB+JgRCQJkp6oQNnGnX0koC_+X2+dSJsM0Q@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] pack-objects: move read mutex to packing_data struct
To:     Patrick Hogg <phogg@novamoon.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 24, 2019 at 8:06 AM Patrick Hogg <phogg@novamoon.net> wrote:
>
> ac77d0c37 ("pack-objects: shrink size field in struct object_entry",
> 2018-04-14) added an extra usage of read_lock/read_unlock in the newly
> introduced oe_get_size_slow for thread safety in parallel calls to
> try_delta(). Unfortunately oe_get_size_slow is also used in serial
> code, some of which is called before the first invocation of
> ll_find_deltas. As such the read mutex is not guaranteed to be
> initialized.
>
> Resolve this by moving the read mutex to packing_data and initializing
> it in prepare_packing_data which is initialized in cmd_pack_objects.

Obviously correct.

Reviewed-by: Duy Nguyen <pclouds@gmail.com>

>
> Signed-off-by: Patrick Hogg <phogg@novamoon.net>
> ---
>  builtin/pack-objects.c |  7 ++-----
>  pack-objects.c         |  1 +
>  pack-objects.h         | 10 ++++++++++
>  3 files changed, 13 insertions(+), 5 deletions(-)
>
> diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
> index 411aefd68..506061b4c 100644
> --- a/builtin/pack-objects.c
> +++ b/builtin/pack-objects.c
> @@ -1954,9 +1954,8 @@ static int delta_cacheable(unsigned long src_size, unsigned long trg_size,
>  }
>
>  /* Protect access to object database */
> -static pthread_mutex_t read_mutex;
> -#define read_lock()            pthread_mutex_lock(&read_mutex)
> -#define read_unlock()          pthread_mutex_unlock(&read_mutex)
> +#define read_lock()            packing_data_read_lock(&to_pack)
> +#define read_unlock()          packing_data_read_unlock(&to_pack)
>
>  /* Protect delta_cache_size */
>  static pthread_mutex_t cache_mutex;
> @@ -2381,7 +2380,6 @@ static pthread_cond_t progress_cond;
>   */
>  static void init_threaded_search(void)
>  {
> -       init_recursive_mutex(&read_mutex);
>         pthread_mutex_init(&cache_mutex, NULL);
>         pthread_mutex_init(&progress_mutex, NULL);
>         pthread_cond_init(&progress_cond, NULL);
> @@ -2392,7 +2390,6 @@ static void cleanup_threaded_search(void)
>  {
>         set_try_to_free_routine(old_try_to_free_routine);
>         pthread_cond_destroy(&progress_cond);
> -       pthread_mutex_destroy(&read_mutex);
>         pthread_mutex_destroy(&cache_mutex);
>         pthread_mutex_destroy(&progress_mutex);
>  }
> diff --git a/pack-objects.c b/pack-objects.c
> index b6cdbb016..3554c43ac 100644
> --- a/pack-objects.c
> +++ b/pack-objects.c
> @@ -150,6 +150,7 @@ void prepare_packing_data(struct packing_data *pdata)
>                                                    1UL << OE_DELTA_SIZE_BITS);
>  #ifndef NO_PTHREADS
>         pthread_mutex_init(&pdata->lock, NULL);
> +       init_recursive_mutex(&pdata->read_lock);
>  #endif
>  }
>
> diff --git a/pack-objects.h b/pack-objects.h
> index dc869f26c..0a038e3bc 100644
> --- a/pack-objects.h
> +++ b/pack-objects.h
> @@ -146,6 +146,7 @@ struct packing_data {
>         struct packed_git **in_pack;
>
>         pthread_mutex_t lock;
> +       pthread_mutex_t read_lock;
>
>         /*
>          * This list contains entries for bases which we know the other side
> @@ -174,6 +175,15 @@ static inline void packing_data_unlock(struct packing_data *pdata)
>         pthread_mutex_unlock(&pdata->lock);
>  }
>
> +static inline void packing_data_read_lock(struct packing_data *pdata)
> +{
> +       pthread_mutex_lock(&pdata->read_lock);
> +}
> +static inline void packing_data_read_unlock(struct packing_data *pdata)
> +{
> +       pthread_mutex_unlock(&pdata->read_lock);
> +}
> +
>  struct object_entry *packlist_alloc(struct packing_data *pdata,
>                                     const unsigned char *sha1,
>                                     uint32_t index_pos);
> --
> 2.20.1.windows.1
>


-- 
Duy
