Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CDD9920560
	for <e@80x24.org>; Thu, 26 Oct 2017 20:29:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932345AbdJZU3Y (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Oct 2017 16:29:24 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:51697 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932334AbdJZU3X (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Oct 2017 16:29:23 -0400
Received: by mail-qt0-f193.google.com with SMTP id h4so5949091qtk.8
        for <git@vger.kernel.org>; Thu, 26 Oct 2017 13:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=NbQ5uwX4AAZajeSmB6F8UhfE22oM621H/RlEW1ZlIkM=;
        b=jTV20Uj4tLq4iG9hnR9o5sU18togSjQqb1ZASfGhWGCSZPc+0CvcGEkxFFXGCj5O2a
         FoptaS+kk3ndK99QsruPeXf1CHqxmB7mCR794JJ9BKlOlH/ait9Df8KFGdDwAXdUPRTi
         1NjO3L8BpF4esc/wDXbWeT+DNDuAfSdNefzNIXw6PLkywQyhoShKjVthEB93O89tHBwt
         /T6JitO2BTaAceB5nazGNTLSWorKyKu5PgYWyGX5ENYVUSnJ7RW882of3ZbXLzYrq/sN
         61ijyqlLz1LiCIWrdZTYOY4AQfOaMSjUuPHUIIOCBsBCrPbKVVbpxJsGvnRmgkK8d55z
         xLvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NbQ5uwX4AAZajeSmB6F8UhfE22oM621H/RlEW1ZlIkM=;
        b=Mncs6KE51Sx2cWwN03ek6yuqz8SITzEZthlJhlta0fwmPUt860iDIcuv3iJexbWOt8
         7bYSvzVgqkU5x4FrUkQAoUk8h2QSB+5qAc9b7s1p1st0xsWcSQpCMEeeoo3gMiJFwT8G
         Brkqd9uv0Q4EMJgiIfqcLfhP9gypNczmX3odIx7SPVElhV1FVdaJxNryzW5meMnAEA8G
         ZWiIyo9O8uPlACGjVS7tYZvxR8jlzLV7nu4V0hMwLeD2G0dkgiVpNPnf9qGaD78Jf3fS
         fljlCcdHVw3VKs+HcseegpkIHROYikwrl7j6RM20VocdZeRVbnlha+/LIlDdgIp2nZiV
         b4Bw==
X-Gm-Message-State: AMCzsaXoZ024Pjdlx+2o/bxQB2DWmsZtwIm86V+P2ppm5jFR7XgKvnd1
        IBnm8H3HCo7o0wsCjypZepNiizq+
X-Google-Smtp-Source: ABhQp+QovqGJOeoO5DmWbHJijMwRrswMQFr6DjGJYT7/y4R4IYeGyA5gDRCFmAhnrUnVALD5BqBTsQ==
X-Received: by 10.200.37.89 with SMTP id 25mr38279402qtn.268.1509049762524;
        Thu, 26 Oct 2017 13:29:22 -0700 (PDT)
Received: from [192.168.1.13] ([65.222.173.206])
        by smtp.gmail.com with ESMTPSA id q8sm4137064qtb.93.2017.10.26.13.29.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Oct 2017 13:29:21 -0700 (PDT)
Subject: Re: [PATCH v2 4/4] fsmonitor: Delay updating state until after split
 index is merged
To:     Alex Vandiver <alexmv@dropbox.com>, git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <20171026013117.30034-1-alexmv@dropbox.com>
 <38fa281fb175c086a5b1f1d3747597a9924e9f46.1508981451.git.alexmv@dropbox.com>
From:   Ben Peart <peartben@gmail.com>
Message-ID: <0c2c567e-e978-dc59-9bf5-a41f31405139@gmail.com>
Date:   Thu, 26 Oct 2017 16:29:22 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <38fa281fb175c086a5b1f1d3747597a9924e9f46.1508981451.git.alexmv@dropbox.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 10/25/2017 9:31 PM, Alex Vandiver wrote:
> If the fsmonitor extension is used in conjunction with the split index
> extension, the set of entries in the index when it is first loaded is
> only a subset of the real index.  This leads to only the non-"base"
> index being marked as CE_FSMONITOR_VALID.
> 
> Delay the expansion of the ewah bitmap until after tweak_split_index
> has been called to merge in the base index as well.
> 
> The new fsmonitor_dirty is kept from being leaked by dint of being
> cleaned up in post_read_index_from, which is guaranteed to be called
> after do_read_index in read_index_from.
> 
> Signed-off-by: Alex Vandiver <alexmv@dropbox.com>
> ---
>   cache.h     |  1 +
>   fsmonitor.c | 39 ++++++++++++++++++++++++---------------
>   2 files changed, 25 insertions(+), 15 deletions(-)
> 
> diff --git a/cache.h b/cache.h
> index 25adcf681..0a4f43ec2 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -348,6 +348,7 @@ struct index_state {
>   	unsigned char sha1[20];
>   	struct untracked_cache *untracked;
>   	uint64_t fsmonitor_last_update;
> +	struct ewah_bitmap *fsmonitor_dirty;
>   };
>   
>   extern struct index_state the_index;
> diff --git a/fsmonitor.c b/fsmonitor.c
> index 0d26ff34f..fad9c6b13 100644
> --- a/fsmonitor.c
> +++ b/fsmonitor.c
> @@ -49,20 +49,7 @@ int read_fsmonitor_extension(struct index_state *istate, const void *data,
>   		ewah_free(fsmonitor_dirty);
>   		return error("failed to parse ewah bitmap reading fsmonitor index extension");
>   	}
> -
> -	if (git_config_get_fsmonitor()) {
> -		/* Mark all entries valid */
> -		for (i = 0; i < istate->cache_nr; i++)
> -			istate->cache[i]->ce_flags |= CE_FSMONITOR_VALID;
> -
> -		/* Mark all previously saved entries as dirty */
> -		ewah_each_bit(fsmonitor_dirty, fsmonitor_ewah_callback, istate);
> -
> -		/* Now mark the untracked cache for fsmonitor usage */
> -		if (istate->untracked)
> -			istate->untracked->use_fsmonitor = 1;
> -	}
> -	ewah_free(fsmonitor_dirty);
> +	istate->fsmonitor_dirty = fsmonitor_dirty;
>   
>   	trace_printf_key(&trace_fsmonitor, "read fsmonitor extension successful");
>   	return 0;
> @@ -239,7 +226,29 @@ void remove_fsmonitor(struct index_state *istate)
>   
>   void tweak_fsmonitor(struct index_state *istate)
>   {
> -	switch (git_config_get_fsmonitor()) {
> +	int i;
> +	int fsmonitor_enabled = git_config_get_fsmonitor();
> +

The logic looks good this time.  It is nice to know this will now be 
optimal when split index is also turned on.  Thank you.

> +	if (istate->fsmonitor_dirty) {
> +		if (fsmonitor_enabled) {
> +			/* Mark all entries valid */
> +			for (i = 0; i < istate->cache_nr; i++) {
> +				istate->cache[i]->ce_flags |= CE_FSMONITOR_VALID;
> +			}
> +
> +			/* Mark all previously saved entries as dirty */
> +			ewah_each_bit(istate->fsmonitor_dirty, fsmonitor_ewah_callback, istate);
> +
> +			/* Now mark the untracked cache for fsmonitor usage */
> +			if (istate->untracked)
> +				istate->untracked->use_fsmonitor = 1;
> +		}
> +
> +		ewah_free(istate->fsmonitor_dirty);
> +		istate->fsmonitor_dirty = NULL;
> +	}
> +
> +	switch (fsmonitor_enabled) {
>   	case -1: /* keep: do nothing */
>   		break;
>   	case 0: /* false */
> 
