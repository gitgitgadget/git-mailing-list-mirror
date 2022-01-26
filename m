Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A569C433F5
	for <git@archiver.kernel.org>; Wed, 26 Jan 2022 21:59:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232435AbiAZV7g (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Jan 2022 16:59:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231508AbiAZV7e (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Jan 2022 16:59:34 -0500
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 611FFC06161C
        for <git@vger.kernel.org>; Wed, 26 Jan 2022 13:59:34 -0800 (PST)
Received: by mail-io1-xd29.google.com with SMTP id c188so1311513iof.6
        for <git@vger.kernel.org>; Wed, 26 Jan 2022 13:59:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=OBGpI4Mh2f9H8LD8pVKkF0z2KHeqltJwbNtO61gEHBA=;
        b=jltYyzRpVbx3PMt++QbXZ2Fbfby2Y/EjA/ksN1xSCg/LToxvAlXpz9T/zCx7E6fJZ9
         flrQ4m/ddGyKumkiIuzOkhk3AGjQI1D7lqrTlaRuCkWkDiD8StSkmPYdLXfAn5OKmVEO
         2GmNsOvLWEbU8AKPAcCQOjClN+g2g0JyCfTbhponCfC1GDkVjk/Qpy62Bk4bAOKKiaIB
         RVJjXKtdztc6V75Fifvi4loSMQ38g04qbGPJ+OJwVJTux45ay5GUHCMlnblNt3q9nc7k
         x3ZK11/njv6COk4SGvOuL5BaQ/mdNcq+gVmKZgpU+pR0hDsJgxA1I2Lzt14nRphJRob9
         N7SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=OBGpI4Mh2f9H8LD8pVKkF0z2KHeqltJwbNtO61gEHBA=;
        b=k3fIlVjGnBF4h3kIsLeuPsz4Ulw6+X7IJKERwe7fRtKnO5KUY4RIOZGwoM4XYk3h68
         ADQkge9Q6N5d81FIo7JKh0fTyXUFcTN5kHi5QCRF1qrOEwjF9QJ+jrXeFTJmwzdqw91L
         WRUqAtRbAFAIcHEXGX+16HPvb9ti5gkkSrR+mG9/Mpf/67zxBmOA2fEWmrp9nDwp18ex
         xbrSxnO+DQQ/lJT7Ka5EGtHNUAOC3HoPWGnlEIXt84T6HC6uk6S+pnyB8Wo2wh4S73S6
         VTY0qiWAPYj1CQTaPgxDOhovv7OzKxqNYkL3HeAfy4X89SLiyL9dz3qUyQPlREjxi29t
         Gctg==
X-Gm-Message-State: AOAM533l/d6n4bNxgO100lWpRVMLddwb2gJQO/DFmY1QvGihEWNRc3cA
        619dgYVQtWZp17oWAUiDYUGsmg==
X-Google-Smtp-Source: ABdhPJzCQVFDSOHh4QjYA0E+jJSo9lqdUIloiPRPfhB3oRH1XDryEczC34VM6jwmF5ShohO7v8c7ag==
X-Received: by 2002:a02:ce99:: with SMTP id y25mr398364jaq.294.1643234373703;
        Wed, 26 Jan 2022 13:59:33 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id g14sm10871658ilj.41.2022.01.26.13.59.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jan 2022 13:59:33 -0800 (PST)
Date:   Wed, 26 Jan 2022 16:59:32 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] http API: fix dangling pointer issue noted by GCC 12.0
Message-ID: <YfHERK0RUwVjM963@nand.local>
References: <patch-1.1-1cec367e805-20220126T212921Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-1.1-1cec367e805-20220126T212921Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 26, 2022 at 10:30:40PM +0100, Ævar Arnfjörð Bjarmason wrote:
> But we can instead amend the code added in baa7b67d091 (HTTP slot
> reuse fixes, 2006-03-10) to get rid of "int *finished" entirely. I
> instrumented the code to add this after every use of slot->finished or
> slot->in_use:
>
>     if (slot->finished && slot->in_use == *slot->finished) BUG("in-use = %d and finished = %d disconnect", slot->in_use, *slot->finished);
>     if (!slot->finished && !slot->in_use) BUG("have !in-use and no finished pointer");
>
> Which never fires, but we would get occurrences of:
>
>     if (!slot->finished && slot->in_use) BUG("have in-use and no finished pointer");
>
> I.e. we can simply drop the field and rely on "slot->in_use" in cases
> where we used "finished" before. The two fields were mirror images of
> each other, and the tri-state nature of "finished" wasn't something we
> relied upon.

This sort of thing always makes me a little nervous, regardless of how
carefully it's done. I'm not sure I quite follow the above reasoning,
but let's take a look at the code...

> diff --git a/http-walker.c b/http-walker.c
> index 910fae539b8..5cc369dea85 100644
> --- a/http-walker.c
> +++ b/http-walker.c
> @@ -225,13 +225,9 @@ static void process_alternates_response(void *callback_data)
>  					 alt_req->url->buf);
>  			active_requests++;
>  			slot->in_use = 1;
> -			if (slot->finished != NULL)
> -				(*slot->finished) = 0;

Makes sense; here we set slot->in_use to 1, and would have set
slot->finished to 0.

>  			if (!start_active_slot(slot)) {
>  				cdata->got_alternates = -1;
>  				slot->in_use = 0;
> -				if (slot->finished != NULL)
> -					(*slot->finished) = 1;

Vice-versa here, OK.

> diff --git a/http.c b/http.c
> index 229da4d1488..4507c9ac9c7 100644
> --- a/http.c
> +++ b/http.c
> @@ -197,9 +197,6 @@ static void finish_active_slot(struct active_request_slot *slot)
>  	closedown_active_slot(slot);
>  	curl_easy_getinfo(slot->curl, CURLINFO_HTTP_CODE, &slot->http_code);
>
> -	if (slot->finished != NULL)
> -		(*slot->finished) = 1;
> -

But this one I don't quite follow. Or, at least, I don't readily see
that slot->in_use is necessarily going to be 0 here, or (if it isn't)
that we somehow don't care.

Could you walk me through your reasoning on why this particular hunk is
OK?

> @@ -1327,10 +1323,8 @@ void run_active_slot(struct active_request_slot *slot)
>  	fd_set excfds;
>  	int max_fd;
>  	struct timeval select_timeout;
> -	int finished = 0;
>
> -	slot->finished = &finished;
> -	while (!finished) {
> +	while (slot->in_use) {
>  		step_active_slots();
>
>  		if (slot->in_use) {

This part of the diff looks OK to me; you're just swapping the use of
'!finished' with 'slot->in_use', which makes sense *assuming* that they
are truly mirror images of each other.

The rest of the diff looks good to me, but I do think we should nail
down an answer to the question that I posed earlier in this message
first.

Thanks,
Taylor
